(*
This unit is part of TArtFormula package.
See formula.pas for notes, License and disclaimer agreement.

(c) Artem V. Parlyuk, e-mail:artsoft@nm.ru, http://artsoft.nm.ru
*)

// VB modification for BIG_ENDIAN sistems (storedbl, getdbl)
// VB for use with FPC, without Lazarus.


unit formulan;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}
{$I artformula.inc}

interface
uses SysUtils, classes;

type

 TFormulaError = (ER_Ok, ER_ILLEGAL, ER_UNKNOWN, ER_RIGHT, ER_LEFT, ER_SYNTAX, ER_VARS,
   ER_NOTENOUGH);

 FormulaException = class(Exception)
 end;
 TArtFormulaN = class;

 TFormulaStackN = class
 protected
  max,pos : integer;
  data : array of ansichar;
  Parent : TArtFormulaN;
 public
  constructor Create(i:integer=256);
  destructor Destroy; override;
  property Num : integer read pos;
  function Top : ansichar;
  procedure Push(c : ansichar);
  function Pop:ansichar;
  function PopEx : ansistring;
  function Item(i:integer) : ansichar;
 end;

 pformulafunctionN = function(pos : integer; var data : array of double) : double;

 StringArray = array of String;
 DoubleArray = array of double;
 PStringArray = ^StringArray;
 PDoubleArray = ^DoubleArray;

 FTableItem = record
      name : string;
      paramcount : integer;
      fun : pformulafunctionN;
 end;

 TConstItem = record
  name, value : string;
 end;

 TDiffStackItem = record
  val, diff : string;
  fv : boolean;
 end;

TArtFormulaN = class(TComponent)
  protected
   max,cpos : integer;
   cdata : array of double;
   D : array of TDiffStackItem;
   pos, numofvar : integer;
   ferror : TFormulaError;
   ftestused : boolean;
   fcompiled : ansistring;
   fcasesensitive : boolean;
   S : TFormulaStackN;
   input : ansistring;
   tmp, temp : ansistring;
   varnames : StringArray;
   data : double;
   usedvars : array of boolean;
   userfunc : array of FTableItem;
   ConstTable : array of TConstItem;
   formula_err : TFormulaError;

{$ifdef AF_MULTILANG}
   flocalstrings : TStrings;
{$endif}


   function Parser(flag:boolean=false) : integer;
   function Form: integer;
   function ErrString: string;
  public
   property Error : TFormulaError read ferror;
   property ErrPos : integer read pos;
   property Compiled : ansistring read fcompiled write fcompiled;

{$ifdef AF_MULTILANG}
   property LocalStrings : TStrings read flocalstrings write flocalstrings;

   function GetLocalString(name : string; defvalue : string) : string;
   procedure LoadLang(lngfile : string);
{$endif}

   constructor Create(AOwner: TComponent); override;
   destructor Destroy; override;

   procedure AddUserFunction(name : string; paramcount:integer; fun : pformulafunctionN);
   procedure AddUserConstant(name, value : string);

   function Test(instr : string; num : byte = 0; vars : PStringArray = nil) : boolean;
   function Compile(instr : string; num : byte = 0; vars : PStringArray = nil) : string; overload;
   function Compile(instr : string; vars : string) : ansistring; overload;
   function Compute(vals : PDoubleArray = nil) : double;
   function ComputeStr(instr : string; num : byte = 0; vars : PStringArray = nil; vals : pdoublearray = nil) : double; overload;
   function ComputeStr(instr : string; vars : string; vals : pdoublearray) : double; overload;
   function Diff(x : string):string;
   function DiffStr(instr : string; num : byte; vars : PStringArray; x : string):string; overload;
   function DiffStr(instr : string; vars : string; x : string):string; overload;
   procedure VarList(vars : string; var varz:StringArray);

  published
   property TestUsed : boolean read ftestused write ftestused;
   property CaseSensitive : boolean read fcasesensitive write fcasesensitive;
end;

procedure Register;

implementation

{$J+}

uses math, FormulaNf, inifiles {$IFDEF LCL}, LResources{$endif};

const
 F_EOS = -1;
 F_DATA = 254;
 F_VAR = 253;
 F_NE = #252;
 F_UMINUS = #251;
 F_GE = #250;
 F_LE = #249;
 F_USERF = #248;

 NUMFUN = 33;

const
 table : array [0..NUMFUN-1] of FTableItem =
(
 (name:''),
 (name:'SIN'; paramcount:1;fun:mysin),
 (name:'COS';paramcount:1;fun:mycos),
 (name:'TAN';paramcount:1;fun:mytan),
 (name:'LOG';paramcount:1;fun:mylog),
 (name:'LG';paramcount:1;fun:mylg),
 (name:'EXP';paramcount:1;fun:myexp),
 (name:'SQRT';paramcount:1;fun:mysqrt),
 (name:'INT';paramcount:1;fun:myint),
 (name:'FRAC';paramcount:1;fun:myfrac),
 (name:'ABS';paramcount:1;fun:myabs),
 (name:'ATAN';paramcount:1;fun:myatan),
 (name:'ASIN';paramcount:1;fun:myasin),
 (name:'ACOS';paramcount:1;fun:myacos),
 (name:'ASINH';paramcount:1;fun:myasinh),
 (name:'ACOSH';paramcount:1;fun:myacosh),
 (name:'ATANH';paramcount:1;fun:myatanh),
 (name:'COSH';paramcount:1;fun:mycosh),
 (name:'SINH';paramcount:1;fun:mysinh),
 (name:'TANH';paramcount:1;fun:mytanh),
 (name:'SIGN';paramcount:1;fun:mysign),
 (name:'RND';paramcount:0;fun:myrnd),
 (name:'MAX';paramcount:-1;fun:mymax),
 (name:'MIN';paramcount:-1;fun:mymin),
 (name:'AVG';paramcount:-1;fun:myavg),
 (name:'STDDEV';paramcount:-1;fun:mystddev),
 (name:'STDDEVP';paramcount:-1;fun:mystddevp),
 (name:'SUM';paramcount:-1;fun:mysum),
 (name:'SUMOFSQUARES';paramcount:-1;fun:mysumofsquares),
 (name:'COUNT';paramcount:-1;fun:mycount),
 (name:'VARIANCE';paramcount:-1;fun:myvar),
 (name:'VARIANCEP';paramcount:-1;fun:myvarp),
 (name:'IFF';paramcount:3;fun:myiff)
 );

function isznak(c : ansichar) : boolean;
begin
 result := {$IF Defined(AF_DELPHI2010)}CharInSet(c,{$ELSE}(c in{$IFEND} ['+','-','*','/','%','^','>','<','=','&','|',F_NE,F_LE,F_GE]);
end;

function isfun(c : ansichar) : boolean;
begin
 result := ((c > #0)and(ord(c) < NUMFUN));
end;


constructor TFormulaStackN.Create(i : integer = 256);
begin
 max := i;
 pos := 0;
 setlength(data,i);
end;

destructor TFormulaStackN.Destroy;
begin
 data := nil;
 inherited Destroy;
end;

function TFormulaStackN.Top : ansichar;
begin
 if pos > 0 then result := data[pos - 1]
 else result := #0;
end;

procedure TFormulaStackN.Push(c : ansichar);
begin
 if pos = max then
 begin
  inc(max, 256);
  setlength(data,max);
 end;
 data[pos] := c;
 inc(pos);
end;

function TFormulaStackN.Pop : ansichar;
begin
if pos > 0 then
begin
 dec(pos);
 result := data[pos];
end
else result := #0;
end;

function TFormulaStackN.PopEx : ansistring;
begin
if pos > 0 then
begin
 dec(pos);
 if data[pos] = F_USERF then
 begin
  result := F_USERF + data[pos-1] + chr(Parent.userfunc[ord(data[pos-1])].paramcount);
  dec(pos);
 end
 else
 if isfun(data[pos]) then
  result := data[pos] + chr(table[ord(data[pos])].paramcount)
 else result := data[pos];
end
else result := #0;
end;


function TFormulaStackN.Item(i:integer) : ansichar;
begin
 if (i >= 0) and (i < pos) then result := data[i]
 else result := #0;
end;

function prior(a,b : ansichar) : boolean;
var pa,pb:integer;
begin
 if isfun(a) then pa := 1
 else if a = '^' then pa := 2
 else if {$IF Defined(AF_DELPHI2010)}CharInSet(a,{$ELSE}(a in{$IFEND} ['!',F_UMINUS]) then pa := 3
 else if {$IF Defined(AF_DELPHI2010)}CharInSet(a,{$ELSE}(a in{$IFEND} ['*','/','%']) then pa := 4
 else if {$IF Defined(AF_DELPHI2010)}CharInSet(a,{$ELSE}(a in{$IFEND} ['+','-']) then pa := 5
 else if {$IF Defined(AF_DELPHI2010)}CharInSet(a,{$ELSE}(a in{$IFEND} ['|','&']) then pa := 6
 else if {$IF Defined(AF_DELPHI2010)}CharInSet(a,{$ELSE}(a in{$IFEND} ['<','>','=',F_NE,F_GE,F_LE]) then pa := 7
 else if {$IF Defined(AF_DELPHI2010)}CharInSet(a,{$ELSE}(a in{$IFEND} ['(',')']) then pa := 8
 else pa := 100;

 if isfun(b) then pb := 1
 else if b = '^' then pb := 2
 else if {$IF Defined(AF_DELPHI2010)}CharInSet(b,{$ELSE}(b in{$IFEND} ['!',F_UMINUS]) then pb := 3
 else if {$IF Defined(AF_DELPHI2010)}CharInSet(b,{$ELSE}(b in{$IFEND} ['*','/','%']) then pb := 4
 else if {$IF Defined(AF_DELPHI2010)}CharInSet(b,{$ELSE}(b in{$IFEND} ['+','-']) then pb := 5
 else if {$IF Defined(AF_DELPHI2010)}CharInSet(b,{$ELSE}(b in{$IFEND} ['|','&']) then pb := 6
 else if {$IF Defined(AF_DELPHI2010)}CharInSet(b,{$ELSE}(b in{$IFEND} ['<','>','=',F_NE,F_GE,F_LE]) then pb := 7
 else if {$IF Defined(AF_DELPHI2010)}CharInSet(b,{$ELSE}(b in{$IFEND} ['(',')']) then pb := 8
 else pb := 100;

 result := pa >= pb;

end;

destructor TArtFormulaN.Destroy;
begin
 S.Free;
 usedvars := nil;
 userfunc := nil;
 cdata := nil;
 {$ifdef AF_Multilang}
  flocalstrings.Free;
  flocalstrings := nil;
 {$endif}

 inherited Destroy;
end;

constructor TArtFormulaN.Create(AOwner: TComponent);
begin
 inherited Create(AOwner);
 pos := 1;
 ferror := ER_Ok;
 input :=#0;
 usedvars := nil;
 S := TFormulaStackN.Create();
 S.Parent := self;
 max := 128;
 cpos := 0;
 setlength(cdata,128);
 {$ifdef AF_Multilang}
  flocalstrings := TStringList.Create;
  flocalstrings.Delimiter := '=';
 {$endif}

 AddUserConstant('PI','3.1415926535897932385');
 AddUserConstant('FALSE','0');
 AddUserConstant('TRUE','1');
 AddUserConstant('LN','LOG');
end;


 const

 cFunctionAlreadyDefined          {$ifdef AF_MULTILANG}: string {$endif} = 'Function already defined';
 cTooManyUserFunctionsDefined     {$ifdef AF_MULTILANG}: string {$endif} = 'Too many user functions defined';
 cConstantAlreadyDefined          {$ifdef AF_MULTILANG}: string {$endif} = 'Constant already defined';
 cWrongVariablesList              {$ifdef AF_MULTILANG}: string {$endif} = 'Wrong variables list';
 cDivisionByZero                  {$ifdef AF_MULTILANG}: string {$endif} = 'Division by zero';
 cCantDifferentiate               {$ifdef AF_MULTILANG}: string {$endif} = 'Can''t differentiate';

{$ifndef AF_MULTILANG}
 cIllegalCharacter                = 'Illegal character';
 cUnknownIdentifier               = 'Unknown identifier';
 cExpected                        = 'expected';
 cSyntaxError                     = 'Syntax error';
 cVariableNotUsed                 = 'Variable not used';
 cNotEnoughParameters             = 'Not enough parameters';
{$endif}



{$ifdef AF_MULTILANG}
const err_strings : array [TFormulaError] of string =
('Ok', 'Illegal character', 'Unknown identifier', '")" expected', '"(" expected',
  'Syntax error', 'Variable not used','Not enough parameters');
{$else}
const err_strings : array [TFormulaError] of string =
('Ok', cIllegalcharacter, cUnknownidentifier, '")" '+ cexpected, '"(" '+cexpected,
  cSyntaxerror, cVariablenotused,cNotenoughparameters);
{$endif}


 {$ifdef AF_Multilang}

function TArtFormulaN.GetLocalString(name : string; defvalue : string) : string;
begin
  if flocalstrings.IndexOfName(name) = -1 then result := defvalue
  else
  begin
   result := flocalstrings.Values[name];
   if result = '' then  result := defvalue;
  end;

end;


procedure TArtFormulaN.LoadLang(lngfile : string);
var ini : Tinifile;
begin
  ini := TIniFile.Create(lngfile);
  ini.ReadSectionValues('ArtFormula',flocalstrings);


 cFunctionAlreadyDefined          := GetLocalString('cFunctionAlreadyDefined', 'Function already defined');
 cTooManyUserFunctionsDefined     := GetLocalString('cTooManyUserFunctionsDefined', 'Too many user functions defined');
 cConstantAlreadyDefined          := GetLocalString('cConstantAlreadyDefined', 'Constant already defined');
 cWrongVariablesList              := GetLocalString('cWrongVariablesList', 'Wrong variables list');
 cDivisionByZero                  := GetLocalString('cDivisionByZero', 'Division by zero');
 cCantDifferentiate               := GetLocalString('cCantDifferentiate', 'Can''t differentiate');

 err_strings[ER_ILLEGAL] := GetLocalString('cIllegalCharacter', 'Illegal character');
 err_strings[ER_UNKNOWN] := GetLocalString('cUnknownIdentifier', 'Unknown identifier');
 err_strings[ER_RIGHT] :=  '")" '+ GetLocalString('cExpected', 'expected');
 err_strings[ER_LEFT] :=   '"(" '+ GetLocalString('cExpected', 'expected');
 err_strings[ER_SYNTAX] :=  GetLocalString('cSyntaxError', 'Syntax error');
 err_strings[ER_VARS] :=    GetLocalString('cVariableNotUsed', 'Variable not used');
 err_strings[ER_NOTENOUGH] := GetLocalString('cNotEnoughParameters', 'Not enough parameters');

end;

 {$endif}



procedure TArtFormulaN.AddUserFunction(name : string; paramcount:integer; fun : pformulafunctionN);
var i:integer;
begin
 for i := 0 to high(table) do
  if uppercase(name) = table[i].name then
  raise FormulaException.Create(cFunctionAlreadyDefined);
 for i := 0 to high(userfunc) do
  if uppercase(name) = userfunc[i].name then
  raise FormulaException.Create(cFunctionAlreadyDefined);
 i := high(userfunc)+1;
 if i = 255 then raise FormulaException.Create(cTooManyUserFunctionsDefined);
 setlength(userfunc,i+1);
 userfunc[i].name := uppercase(name);
 userfunc[i].paramcount := paramcount;
 userfunc[i].fun := fun;
end;

procedure TArtFormulaN.AddUserConstant(name,value : string);
var i:integer;
begin
 for i := 0 to high(consttable) do
  if uppercase(name) = consttable[i].name then
  raise FormulaException.Create(cConstantAlreadyDefined);
 i := high(consttable)+1;
 setlength(consttable,i+1);
 consttable[i].name := uppercase(name);
 consttable[i].value := value;
end;

function TArtFormulaN.Parser(flag:boolean): integer;
var s : ansistring;
    i : integer;
    c : ansichar;
begin
 ferror := ER_Ok;
 c := input[pos];
 tmp := '';
 if {$IF Defined(AF_DELPHI2010)}CharInSet(c,{$ELSE}(c in{$IFEND} [' ',#9,#10,#13]) then
 begin
  repeat
   inc(pos);
   c := input[pos];
  until not {$IF Defined(AF_DELPHI2010)}CharInSet(c,{$ELSE}(c in{$IFEND} [' ',#9,#10,#13]);
 end;

 if c = '{' then
 begin
  inc(pos);
  c := input[pos];
  while (c <> '}') and (c <> #0) do
  begin
   inc(pos);
   c := input[pos];
  end;
  while (c = '}') or {$IF Defined(AF_DELPHI2010)}CharInSet(c,{$ELSE}(c in{$IFEND} [' ',#9,#10,#13]) do
  begin
   inc(pos);
   c := input[pos];
  end;
 end;

 if c = #0 then
 begin
  result := F_EOS;
  exit;
 end;

 if flag then
 begin
  result := ord(c);
  exit;
 end;

 if(((c >= 'A')and(c <= 'Z'))or((c >= 'a')and(c <= 'z'))or(c = '_')) then
 begin
  repeat
   if not fcasesensitive and (c >= 'a')and(c <= 'z') then
     c := ansichar(chr(ord(c) + ord('A') - ord('a')));
   tmp := tmp + c;
   inc(pos);
   c := input[pos];
  until not(((c >= 'A')and(c <= 'Z'))or((c >= 'a')and(c <= 'z'))or
        ((c <= '9')and(c >= '0'))or(c='_'));

  for i := 0 to high(ConstTable) do
  begin
   if uppercase(tmp) = consttable[i].name then
   begin
    input := copy(input,1,pos-1)+ consttable[i].value + copy(input,pos,length(input)-pos+1);
    result := Parser;
    exit;
   end;
  end;

  for i := 1 to NUMFUN - 1 do
   if uppercase(tmp) = table[i].name then
   begin
      result := i;
      exit;
   end;

  for i := 0 to high(userfunc) do
   if uppercase(tmp) = userfunc[i].name then
   begin
      result := ord(F_USERF);
      data := i;
      exit;
   end;

  for i := 0 to numofvar - 1 do
  begin
   if not fcasesensitive then s := uppercase(varnames[i])
   else s := varnames[i];
   if tmp = s then
    begin
      data := i;
      usedvars[i] := true;
      result := F_VAR;
      exit;
    end;
  end;
  ferror := ER_UNKNOWN;
  result := 0;
  exit;
 end;


 if((c>='0')and (c<='9')) then
 begin
  repeat
   tmp := tmp + c;
   inc(pos);
   c := input[pos];
  until not((c>='0')and(c<='9'));




  if c = '.' then
  begin
   tmp := tmp + c;
   inc(pos);
   c := input[pos];
   while((c>='0')and(c<='9')) do
   begin
    tmp := tmp + c;
    inc(pos);
    c := input[pos];
   end;
  end;

  if not {$IF Defined(AF_DELPHI2010)}CharInSet(c,{$ELSE}(c in{$IFEND} ['e', 'E']) then
  begin
   data := strtofloat(tmp);
   result := F_DATA;
   exit;
  end;

  tmp := tmp + c;
  inc(pos);
  c := input[pos];
  if((c = '+')or(c = '-')) then
  begin
   tmp := tmp + c;
   inc(pos);
   c := input[pos];
  end;

  while((c>='0')and(c<='9')) do
  begin
    tmp := tmp + c;
    inc(pos);
    c := input[pos];
  end;

   data := strtofloat(tmp);
   result := F_DATA;
   exit;

 end;

 if {$IF Defined(AF_DELPHI2010)}CharInSet(c,{$ELSE}(c in{$IFEND} ['%','+','-','(',')','*','/', '^', ',','!','=','&','|']) then
 begin
  inc(pos);
  result := ord(c);
  exit;
 end;

 if c = '>' then
 begin
  inc(pos);
  if input[pos] = '=' then
  begin
   inc(pos);
   result := ord(F_GE);
   exit;
  end;
  result := ord(c);
  exit;
 end;

  if c = '<' then
 begin
  inc(pos);
  if input[pos] = '=' then
  begin
   inc(pos);
   result := ord(F_LE);
   exit;
  end;
  if input[pos] = '>' then
  begin
   inc(pos);
   result := ord(F_NE);
   exit;
  end;
  result := ord(c);
  exit;
 end;


 ferror := ER_ILLEGAL;
 result := 0;
 exit;
end;

function TArtFormulaN.ErrString : string;
begin
 result := err_strings[ferror];
end;

function TArtFormulaN.Compile(instr : string; num : byte; vars : PStringArray) : string;
var c: char;
begin
 c := decimalseparator;
 decimalseparator := '.';
 fcompiled := '';
 if not Test(instr, num, vars) then
 begin
  result := '';
  decimalseparator := c;
  exit;
 end;
 fcompiled := temp;
 result := temp;
 decimalseparator := c;
end;

procedure TArtFormulaN.VarList(vars : string; var varz:StringArray);
var res : integer;
    cs : boolean;
begin
 if vars <> '' then
 begin
  input := vars+#0;
  pos := 1;
  numofvar := 0;
  temp := '';
  res := 0;
  cs := fcasesensitive;
  fcasesensitive := true;
  while res <> F_EOS do
  begin
   res := Parser;
   if (res <> 0) and (ferror <> ER_UNKNOWN) then
     raise FormulaException.Create(cWrongVariablesList);
   setlength(varz, high(varz)+2);
   varz[high(varz)] := tmp;
   res := Parser;
   if res = F_EOS then continue;
   if chr(res) <> ',' then
     raise FormulaException.Create(cWrongVariablesList);
  end;
  fcasesensitive := cs;
 end;
end;


function TArtFormulaN.Compile(instr : string; vars : string) : ansistring;
var c: char;
    varz:StringArray;
begin
 c := decimalseparator;
 decimalseparator := '.';
 fcompiled := '';

 VarList(vars, varz);

 if not Test(instr, high(varz)+1, @varz) then
 begin
  varz := nil;
  decimalseparator := c;
  raise FormulaException.Create(ErrString);
 end;
 varz := nil;
 fcompiled := temp;
 result := temp;
 decimalseparator := c;
end;

function TArtFormulaN.ComputeStr(instr : string; num : byte; vars : PStringArray; vals : pdoublearray) : double;
var tmp : ansistring;
begin
 tmp := Compile(instr, num, vars);
 if(tmp = '') then raise FormulaException.Create(ErrString);
 result := Compute(vals);
end;

function TArtFormulaN.ComputeStr(instr : string; vars : string; vals : pdoublearray) : double;
var tmp : ansistring;
begin
 tmp := Compile(instr, vars);
 if(tmp = '') then raise FormulaException.Create(ErrString);
 result := Compute(vals);
end;


function TArtFormulaN.Test(instr : string; num : byte; vars : PStringArray) : boolean;
var i:integer;
begin
  if num > 0 then
  begin
   setlength(usedvars,num);
   setlength(varnames,num);
   for i:=0 to num-1 do
   begin
    varnames[i] := vars^[i];
    usedvars[i] := false;
   end;
  end;
  input := instr+#0;
  pos := 1;
  numofvar := num;
  temp := '';
 if Form <> F_EOS then
 begin
  if ferror = ER_Ok then ferror := ER_SYNTAX;
  result := false;
  exit;
 end;

 while S.Top <> #0 do
 begin
  temp := temp + S.Popex;
 end;

 if ftestused then
 for i:=0 to num-1 do
  if usedvars[i] = false then
  begin
   ferror := ER_VARS;
   result := false;
   exit;
  end;

 if length(temp) = 0 then
  result := false
 else
  result := true;
end;


procedure storedbl (p: pointer; value: double); inline;
begin
  System.Move (value, p^, sizeof(double));
end;


function getdbl (p: pointer): double; inline;
var res: double;
begin
  res := 0;
  System.Move (p^, res, sizeof(double));
  result := res;
end;


function TArtFormulaN.Form:integer;
var p : integer;
    (*VB u : ^double;*)
    i,cnt:integer;
begin
  p := Parser;
  if p = F_EOS then
  begin
   result := 0;
   exit;
  end;

   if chr(p) = '+' then p := Parser;

   if chr(p) = '-' then
   begin
     S.Push(F_UMINUS);
     p := Form;
   end
   else
   if chr(p) = '!' then
   begin
     S.Push('!');
     p := Form;
   end
   else
   if(chr(p) = '(') then
   begin
     S.Push('(');
     p := Form();
     if p = 0 then
     begin
      result := 0;
      exit;
     end;
     if(chr(p) <> ')') then
     begin
      ferror := ER_RIGHT;
      result := 0;
      exit;
     end;

     while(S.Top()<>'(') do
     begin
      temp := temp + S.Popex;
     end;

     S.Pop;
     if isfun(S.Top) then
     begin
      temp := temp + S.Top;
      temp := temp + chr(table[ord(S.Pop)].paramcount)
     end;

     p := Parser;
    end
   else
   if isfun(ansichar(chr(p))) then
    begin
     S.Push(ansichar(chr(p)));
     cnt := table[p].paramcount;
     if(chr(Parser) <> '(') then
     begin
      ferror := ER_LEFT;
      result := 0;
      exit;
     end;
     S.Push('(');
     if cnt > 0 then
     for i := 1 to cnt do
     begin
      S.Push(',');
      p := Form;
      if p = 0 then
      begin
       result := 0;
       exit;
      end;

      while(S.Top <> ',') do
      begin
       temp := temp + S.Popex;
      end;
      if (chr(p) <> ',') and (i<cnt) then
      begin
       ferror := ER_NOTENOUGH;
       result := 0;
       exit;
      end;
      S.Pop;
     end
     else if cnt = -1 then
     begin
      p := Parser(true);
      cnt := 0;
      while chr(p) <> ')' do
      begin
       inc(cnt);
       S.Push(',');
       p := Form;
       if p = 0 then
       begin
        result := 0;
        exit;
       end;

       while(S.Top <> ',') do
       begin
        temp := temp + S.Popex;
       end;
       S.Pop;
      end;
      temp := temp + chr(F_DATA);
      temp := temp + stringofchar(#0,sizeof(double));
      (*VB u := @(temp[length(temp)-sizeof(double)+1]);*)
      (*VB u^ := cnt; *)
      storedbl (@(temp[length(temp)-sizeof(double)+1]), cnt);
     end
     else p := Parser;
     if chr(p) <> ')' then
     begin
      ferror := ER_RIGHT;
      result := 0;
      exit;
     end;
     while(S.Top <> '(') do
     begin
      temp := temp + S.Popex;
     end;
     S.Pop;
     temp := temp + S.PopEx;
     p := Parser;
    end

   else
   if chr(p) = F_USERF then
    begin
     S.Push(ansichar(char(trunc(data))));
     S.Push(ansichar(chr(p)));
     p := trunc(data);
     cnt := userfunc[p].paramcount;
     if(chr(Parser) <> '(') then
     begin
      ferror := ER_LEFT;
      result := 0;
      exit;
     end;
     S.Push('(');
     if cnt > 0 then
     for i := 1 to cnt do
     begin
      S.Push(',');
      p := Form;
      if p = 0 then
      begin
       result := 0;
       exit;
      end;

      while(S.Top <> ',') do
      begin
       temp := temp + S.Popex;
      end;
      if (chr(p) <> ',') and (i<cnt) then
      begin
       ferror := ER_NOTENOUGH;
       result := 0;
       exit;
      end;
      S.Pop;
     end
     else p := Parser;

     if chr(p) <> ')' then
     begin
      ferror := ER_RIGHT;
      result := 0;
      exit;
     end;
     while(S.Top <> '(') do
     begin
      temp := temp + S.Popex;
     end;
     S.Pop;
     temp := temp + S.PopEx;
     p := Parser;
    end

   else if p = F_VAR then
    begin
     temp := temp + chr(p);
     temp := temp + chr(trunc(data));
     p := Parser;
    end
   else if p = F_DATA then
    begin
     temp := temp + chr(p);
     temp := temp + stringofchar(#0,sizeof(double));
     (*VB u := @(temp[length(temp)-sizeof(double)+1]);*)
     (*VBu^ := data;*)
     storedbl (@(temp[length(temp)-sizeof(double)+1]), data);

     p := Parser;
    end
   else
   begin
    result := 0;
    exit;
   end;


     if p = F_EOS then
     begin
      result :=  F_EOS;
      exit;
     end;
     if not isznak(ansichar(chr(p))) then
     begin
       result := p;
       exit;
     end;

     while prior(ansichar(chr(p)),S.Top) do temp := temp + S.Popex;
     S.Push(ansichar(chr(p)));
     p := Form;
     if p = 0 then
     begin
       result := 0;
       exit;
     end
     else
     begin
      result := p;
      exit;
     end;
end;

function TArtFormulaN.Diff(x : string):string;
var i,l:integer;
    s1,s2:string;
    c : char;
function SimpleExpr(s:string; f:boolean = false):string;
const oper = '(+-*-^';
var i:integer;
begin
 if f then
  begin
   result := s;
   exit;
  end;

 for i:=1 to length(oper) do
  if System.pos(oper[i],s) > 0 then
  begin
   result := '('+s+')';
   exit;
  end;
 result := s;
end;

function Simplify(s1: string; oper:char; s2:string;
                  f1:boolean = false;f2:boolean = false):string;
var v1,v2:double;
    b1, b2:boolean;
begin
  v1 := 0;
  v2 := 0;
  try
    v1 := strtofloat(s1);
    b1 := true;
  except
    b1 := false;
  end;

  try
    v2 := strtofloat(s2);
    b2 := true;
  except
    b2 := false;
  end;

  if b1 and b2 then
  begin
   case oper of
   '+': result := floattostr(v1+v2);
   '-': result := floattostr(v1-v2);
   '*': result := floattostr(v1*v2);
   '/': result := floattostr(v1/v2);
   '^': result := floattostr(power(v1,v2));
   end;
   exit;
  end
  else
  if b1 then
   case oper of
   '+':
      if v1 = 0 then
      begin
       result := s2;
       exit;
      end;
   '-':
      if v1 = 0 then
      begin
       result := '(-'+SimpleExpr(s2,f2)+')';
       exit;
      end;
   '*':
      if v1 = 0 then
      begin
       result := '0';
       exit;
      end
      else
      if v1 = 1 then
      begin
       result := s2;
       exit;
      end;
   '/':
      if v1 = 0 then
      begin
       result := '0';
       exit;
      end;
   '^':
      if v1 = 0 then
      begin
       result := '0';
       exit;
      end
      else
      if v1 = 1 then
      begin
       result := '1';
       exit;
      end;
   end
  else
  if b2 then
   case oper of
   '+','-':
      if v2 = 0 then
      begin
       result := s1;
       exit;
      end;
   '*':
      if v2 = 0 then
      begin
       result := '0';
       exit;
      end
      else
      if v2 = 1 then
      begin
       result := s1;
       exit;
      end;
   '/':
      if v2 = 0 then
      begin
       raise FormulaException.Create(cDivisionByZero);
      end
      else
      if v2 = 1 then
      begin
       result := s1;
       exit;
      end;
   '^':
      if v2 = 0 then
      begin
       result := '1';
       exit;
      end
      else
      if v2 = 1 then
      begin
       result := s1;
       exit;
      end;
   end
  else
  if s1=s2 then
   case oper of
   '+':begin
        result := '2*'+Simpleexpr(s1,f1);
        exit;
       end;
   '-':
      begin
       result := '0';
       exit;
      end;
   '*':
      begin
       result := Simpleexpr(s1,f1)+'^2';
       exit;
      end;
   '/':
      begin
       result := '1';
       exit;
      end;
   end;

  if (oper <> '+') and (oper <> '-') then
   result := SimpleExpr(s1,f1) + oper + SimpleExpr(s2,f2)
  else
   result := s1 + oper + s2;
end;

begin
 i := 1;
 l := length(compiled);
 cpos := 0;
 c := decimalseparator;
 decimalseparator := '.';
 while(i<=l) do
 begin
   case compiled[i] of
      '+':
      begin
       dec(cpos);
       D[cpos-1].val := simplify(D[cpos-1].val, '+', D[cpos].val, D[cpos-1].fv, D[cpos].fv);
       D[cpos-1].diff := simplify(D[cpos-1].diff, '+', D[cpos].diff);
       D[cpos-1].fv := false;
      end;
      '-':
      begin
       dec(cpos);
       D[cpos-1].val := simplify(D[cpos-1].val, '-', D[cpos].val,D[cpos-1].fv,D[cpos].fv);
       D[cpos-1].diff := simplify(D[cpos-1].diff, '-', D[cpos].diff);
       D[cpos-1].fv := false;
      end;

      '*':
      begin
       dec(cpos);
       s1 := simplify(D[cpos-1].diff, '*', D[cpos].val,false,D[cpos].fv);
       s2 := simplify(D[cpos-1].val, '*', D[cpos].diff,D[cpos-1].fv);
       D[cpos-1].diff := simplify(s1,'+',s2);
       D[cpos-1].val := simplify(D[cpos-1].val, '*', D[cpos].val,D[cpos-1].fv,D[cpos].fv);
       D[cpos-1].fv := false;
      end;

      '/':
      begin
       dec(cpos);
       s1 := simplify(D[cpos-1].diff, '*', D[cpos].val,false,D[cpos].fv);
       s2 := simplify(D[cpos-1].val, '*', D[cpos].diff,D[cpos-1].fv);
       s1 := simplify(s1,'-',s2);
       s2 := simplify(D[cpos].val,'^','2',D[cpos].fv);
       D[cpos-1].diff := simplify(s1,'/',s2);
       D[cpos-1].val := simplify(D[cpos-1].val, '/', D[cpos].val,D[cpos-1].fv,D[cpos].fv);
       D[cpos-1].fv := false;
      end;

      '^':
      begin
       dec(cpos);

       if D[cpos].diff = '0' then
       begin
        s1 := simplify(D[cpos].val, '-', '1');
        s1 := simplify(D[cpos-1].val, '^', s1,D[cpos-1].fv);
        s1 := simplify(D[cpos].val,'*',s1,D[cpos].fv);
        D[cpos-1].diff := simplify(s1,'*',D[cpos-1].diff);
       end
       else
       begin
        s1 := simplify(D[cpos-1].diff, '*', D[cpos].val,D[cpos-1].fv,D[cpos].fv);
        s1 := simplify(s1, '/', D[cpos-1].val,false,D[cpos-1].fv);
        s2 := simplify(D[cpos].diff, '*', 'log('+D[cpos-1].val+')',false,true);
        s1 := simplify(s2,'+',s1);
        s2 := simplify(D[cpos-1].val, '^', D[cpos].val,D[cpos-1].fv,D[cpos].fv);
        D[cpos-1].diff := simplify(s2,'*',s1);
       end;

       D[cpos-1].val := simplify(D[cpos-1].val, '^', D[cpos].val,D[cpos-1].fv,D[cpos].fv);
       D[cpos-1].fv := false;
      end;

      F_UMINUS:
      begin
       D[cpos-1].val := '(-'+SimpleExpr(D[cpos-1].val,D[cpos-1].fv)+')';
       D[cpos-1].diff := '(-'+SimpleExpr(D[cpos-1].diff)+')';
       D[cpos-1].fv := false;
      end;


      #1 {SIN}:
      begin
       D[cpos-1].diff := simplify('cos('+D[cpos-1].val+')','*',D[cpos-1].diff,true);
       D[cpos-1].val := 'sin('+D[cpos-1].val+')';
       D[cpos-1].fv := true;
       inc(i);
      end;
      #2 {COS}:
      begin
       D[cpos-1].diff := simplify('(-sin('+D[cpos-1].val+'))','*',D[cpos-1].diff,true);
       D[cpos-1].val := 'cos('+D[cpos-1].val+')';
       D[cpos-1].fv := true;
       inc(i);
      end;
      #3 {TAN}:
      begin
       D[cpos-1].diff := simplify('(1+tan('+D[cpos-1].val+')^2)','*',D[cpos-1].diff,true);
       D[cpos-1].val := 'tan('+D[cpos-1].val+')';
       D[cpos-1].fv := true;
       inc(i);
      end;
      #4 {LOG}:
      begin
       D[cpos-1].diff := simplify(D[cpos-1].diff,'/',D[cpos-1].val);
       D[cpos-1].val := 'log('+D[cpos-1].val+')';
       D[cpos-1].fv := true;
       inc(i);
      end;
      #5 {LG}:
      begin
       D[cpos-1].diff := simplify(D[cpos-1].diff,'/',simpleExpr(D[cpos-1].val)+'*log(10)');
       D[cpos-1].val := 'lg('+D[cpos-1].val+')';
       D[cpos-1].fv := true;
       inc(i);
      end;
      #6 {EXP}:
      begin
       D[cpos-1].diff := simplify('exp('+D[cpos-1].val+')','*',D[cpos-1].diff,true);
       D[cpos-1].val := 'exp('+D[cpos-1].val+')';
       D[cpos-1].fv := true;
       inc(i);
      end;
      #7 {SQRT}:
      begin
       D[cpos-1].diff := simplify(D[cpos-1].diff,'/','2*sqrt('+D[cpos-1].val+')');
       D[cpos-1].val := 'sqrt('+D[cpos-1].val+')';
       D[cpos-1].fv := true;
       inc(i);
      end;
      #11 {ATAN}:
      begin
       D[cpos-1].diff := simplify(D[cpos-1].diff,'/','(1+'+SimpleExpr(D[cpos-1].val)+'^2)',false,true);
       D[cpos-1].val := 'atan('+D[cpos-1].val+')';
       D[cpos-1].fv := true;
       inc(i);
      end;
      #12 {ASIN}:
      begin
       D[cpos-1].diff := simplify(D[cpos-1].diff,'/','sqrt(1-'+SimpleExpr(D[cpos-1].val)+'^2)',false,true);
       D[cpos-1].val := 'asin('+D[cpos-1].val+')';
       D[cpos-1].fv := true;
       inc(i);
      end;
      #13 {ACOS}:
      begin
       D[cpos-1].diff := simplify('-'+D[cpos-1].diff,'/','sqrt(1-'+SimpleExpr(D[cpos-1].val)+'^2)',false,true);
       D[cpos-1].val := 'acos('+D[cpos-1].val+')';
       D[cpos-1].fv := true;
       inc(i);
      end;
      #14 {ASINH}:
      begin
       D[cpos-1].diff := simplify(D[cpos-1].diff,'/','sqrt(1+'+SimpleExpr(D[cpos-1].val)+'^2)',false,true);
       D[cpos-1].val := 'asinh('+D[cpos-1].val+')';
       D[cpos-1].fv := true;
       inc(i);
      end;
      #15 {ACOSH}:
      begin
       D[cpos-1].diff := simplify(D[cpos-1].diff,'/','sqrt('+SimpleExpr(D[cpos-1].val)+'^2-1)',false,true);
       D[cpos-1].val := 'acosh('+D[cpos-1].val+')';
       D[cpos-1].fv := true;
       inc(i);
      end;
      #16 {ATANH}:
      begin
       D[cpos-1].diff := simplify(D[cpos-1].diff,'/','(1-'+SimpleExpr(D[cpos-1].val)+'^2)',false,true);
       D[cpos-1].val := 'atanh('+D[cpos-1].val+')';
       D[cpos-1].fv := true;
       inc(i);
      end;
      #17 {COSH}:
      begin
       D[cpos-1].diff := simplify('sinh('+D[cpos-1].val+')','*',D[cpos-1].diff,true);
       D[cpos-1].val := 'cosh('+D[cpos-1].val+')';
       D[cpos-1].fv := true;
       inc(i);
      end;
      #18 {SINH}:
      begin
       D[cpos-1].diff := simplify('cosh('+D[cpos-1].val+')','*',D[cpos-1].diff,true);
       D[cpos-1].val := 'sinh('+D[cpos-1].val+')';
       D[cpos-1].fv := true;
       inc(i);
      end;
      #19 {TANH}:
      begin
       D[cpos-1].diff := simplify('(1-tanh('+D[cpos-1].val+')^2)','*',D[cpos-1].diff,true);
       D[cpos-1].val := 'tanh('+D[cpos-1].val+')';
       D[cpos-1].fv := true;
       inc(i);
      end;

     chr(F_VAR):
       begin
        inc(i);
        if cpos > high(D) then setlength(D,high(D)+33);
        D[cpos].val := varnames[ord(compiled[i])];
        if D[cpos].val = x then D[cpos].diff := '1'
        else D[cpos].diff := '0';
        D[cpos].fv := true;
        inc(cpos);
       end;
     chr(F_DATA):
       begin
        if cpos > high(D) then setlength(D,high(D)+33);
        (*VB D[cpos].val := floattostr((pdouble(@(compiled[i+1])))^); *)
        D[cpos].val := floattostr(getdbl(@(compiled[i+1])));
        D[cpos].diff := '0';
        D[cpos].fv := true;
        inc(cpos);
        inc(i,sizeof(double));
       end;
   else raise FormulaException.Create(cCantDifferentiate);
   end;
  inc(i);
 end;
 result := D[cpos-1].diff;
 decimalseparator := c;
end;

function TArtFormulaN.DiffStr(instr : string; num : byte; vars : PStringArray; x : string):string;
var tmp : string;
begin
 tmp := Compile(instr, num, vars);
 if(tmp = '') then raise FormulaException.Create(ErrString);
 result := Diff(x);
end;

function TArtFormulaN.DiffStr(instr : string; vars : string; x : string):string;
var tmp : string;
begin
 tmp := Compile(instr, vars);
 if(tmp = '') then raise FormulaException.Create(ErrString);
 result := Diff(x);
end;

function TArtFormulaN.Compute(vals : pDoubleArray) : double;
var i,idx,l,cnt:integer;
begin
 i := 1;
 l := length(compiled);
 cpos := 0;
 ferror := ER_Ok;

 while(i<=l) do
 begin
   case compiled[i] of
      '+':
      begin
       dec(cpos);
       cdata[cpos-1] := cdata[cpos] + cdata[cpos-1];
      end;
      '-':
      begin
       dec(cpos);
       cdata[cpos-1] := cdata[cpos-1] - cdata[cpos];
      end;
      '*':
      begin
       dec(cpos);
       cdata[cpos-1] := cdata[cpos-1] * cdata[cpos];
      end;
      '/':
      begin
       dec(cpos);
       cdata[cpos-1] := cdata[cpos-1] / cdata[cpos];
      end;
      '%':
      begin
       dec(cpos);
       cdata[cpos-1] := trunc(cdata[cpos-1]) mod trunc(cdata[cpos]);
      end;
      '^':
      begin
       dec(cpos);
       cdata[cpos-1] := power(cdata[cpos-1], cdata[cpos]);
      end;
      F_NE :
      begin
       dec(cpos);
       cdata[cpos-1] := ifthen(cdata[cpos-1]<>cdata[cpos],1,0);
      end;
      '=' :
      begin
       dec(cpos);
       cdata[cpos-1] := ifthen(cdata[cpos-1]=cdata[cpos],1,0);
      end;
      '<' :
      begin
       dec(cpos);
       cdata[cpos-1] := ifthen(cdata[cpos-1]<cdata[cpos],1,0);
      end;
      F_LE :
      begin
       dec(cpos);
       cdata[cpos-1] := ifthen(cdata[cpos-1]<=cdata[cpos],1,0);
      end;
      '>' :
      begin
       dec(cpos);
       cdata[cpos-1] := ifthen(cdata[cpos-1]>cdata[cpos],1,0);
      end;
      F_GE:
      begin
       dec(cpos);
       cdata[cpos-1] := ifthen(cdata[cpos-1]>=cdata[cpos],1,0);
      end;
      F_UMINUS:
      begin
       cdata[cpos-1] := -cdata[cpos-1];
      end;
      '!':
      begin
       cdata[cpos-1] := ifthen(cdata[cpos-1]=0,1,0);
      end;
      '&':
      begin
       dec(cpos);
       cdata[cpos-1] := ifthen((cdata[cpos-1]<>0) and (cdata[cpos]<>0),1,0);
      end;
      '|':
      begin
       dec(cpos);
       cdata[cpos-1] := ifthen((cdata[cpos-1]<>0) or (cdata[cpos]<>0),1,0);
      end;
      #1 .. chr(NUMFUN-1):
        begin
         idx := ord(compiled[i]);
         inc(i);
         cnt := ord(compiled[i]);
         if cnt = 255 then cnt := trunc(cdata[cpos-1]+1)
         else if cnt = 0 then
         begin
          if cpos = max then
          begin
           inc(max,128);
           setlength(cdata,max);
          end;
          cdata[cpos] := 0;
          inc(cpos);
          cnt := 1;
         end;
         cdata[cpos-cnt] := table[idx].fun(cpos-1, cdata);
         dec(cpos,cnt-1);
        end;
      F_USERF:
        begin
         inc(i);
         idx := ord(compiled[i]);
         inc(i);
         cnt := ord(compiled[i]);
         if cnt = 255 then cnt := trunc(cdata[cpos-1]+1)
         else if (cnt = 0) then
         begin
          if cpos = max then
          begin
           inc(max,128);
           setlength(cdata,max);
          end;
          cdata[cpos] := 0;
          inc(cpos);
          cnt := 1;
         end;
         cdata[cpos-cnt] := userfunc[idx].fun(cpos-1, cdata);
         dec(cpos,cnt-1);
        end;
     chr(F_VAR):
       begin
        inc(i);
        if cpos = max then
        begin
         inc(max,256);
         setlength(cdata,max);
        end;
        cdata[cpos] := vals^[ord(compiled[i])];
        inc(cpos);
       end;
     chr(F_DATA):
       begin
        if cpos = max then
        begin
         inc(max,256);
         setlength(cdata,max);
        end;
        (*VB cdata[cpos] := (pdouble(@(compiled[i+1])))^;  *)
        cdata[cpos] := getdbl(@(compiled[i+1]));
        inc(cpos);
        inc(i,sizeof(double));
       end;
     end;
  inc(i);
 end;
 result := cdata[cpos-1];
end;

procedure Register;
begin
  RegisterComponents('Art', [TArtFormulaN]);
end;


{$IFDEF LCL}
initialization

{$I tartformulan.lrs}
{$ENDIF}

end.
