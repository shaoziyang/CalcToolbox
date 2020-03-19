(*

ArtFormula v3.4

--------------------------------------------------------------------------------

ArtFormula package contains two nonvisual Delphi component for symbolic
expression parsing and evaluation. Provides runtime scripting engine for
automating your programs.

TArtFormula description 

Properties:

property Error : TFormulaError; - returns current error code. 

TFormulaError = (ER_Ok, ER_ILLEGAL, ER_UNKNOWN, ER_RIGHT, ER_LEFT, ER_SYNTAX,
ER_VARS, ER_NOTENOUGH);

property ErrPos : integer; - returns position of error. 

property ErrLine : integer; - returns the line with error.

property ErrStrPos : integer; - returns the position of error inside source
string.

property Stop : boolean; - set Stop to true during computation to stop. 

property Compiled : string; - bytecode of compiled source string.

property LocalStrings : TStrings; - if TArtFormula compiled with multilang
support, this property contains list of pairs "StringName=LocalString". You can
use Names and Values properties of LocalStings to obtain stringnames and
localstrings.

property ModuleName : sting; - contains name of last called module. Useful for
user defined modules and functions

property FunctionName : sting; - contains name of last called function. Useful
for user defined modules and functions

property ParamCount : integer; - contains parameters count of last called
function (-1 for variable argument list function)

property Global : TArtSubFormula; - Global scope of ArtFormula program (for
debugging issues mostly).

property SubRoutine : PArtSubFormula; - Pointer to current subroutine of
ArtFormula program (for debugging issues mostly).

Published properties:

property UnQuotedString : boolean; - if true, ArtFormula will consider unknown
identifiers as string literals.

property TestUsedVars : boolean; - if true, ArtFormula will test whether all
external variables, passed as vars parameter of Compile or Test procedure, are
used in source expression.

property CaseSensitive : boolean; - if true, ArtFormula will distinguish case
of characters in variables name. Note: functions names are always case
insensitive.

property Step : boolean; - if true, you can stop computation, by setting Stop
property to true. If false you can't stop computation until it ends.

property StoreLines : boolean; - if true, ArtFormula will store line number in 
compiled bytecode, so ErrLine will contain runtime error line number.

Note: Step, StoreLines and OnStep properties usefull for debugging issues 
(see demo).  
   
property CaseSensitiveString : boolean; - if true, ArtFormula will distinguish
case of string characters in comparison operations and in pos function.

property ExternGetVar : boolean; - if set, ArtFormula will use GetVarValue and
GetVarsCount events to evaluate unspecified external variables.

property VarNameLiterals : string; - defines set of literals, allowed for
variable names.

property NoLeadingZero : boolean; - if true, you can omit leadin zero before
point in floationg point numbers (both .5 and 0.5 correct), if false - only 
notation with leading zero accepted (only 0.5, .5 - causes error).

property ZeroEmptyString : boolean; - if true, ArtFormula will treat empty
string az 0 in arithmetic operations.

property AutoCreateVars : boolean; - if true, ArtFormula will creates new 
variable with the first assignment statement. But if unknown variable is 
in the expression, ArtFormula will rise an expression.


Methods:

procedure SetVar(name : string; value : PCalcItem); - sets value of variable,
given by name parameter.

function GetVar(name : string) : PCalcItem; - returns value of variable. 

function IncVar(name : string) : PCalcItem; - increments value of a variable. 

function DecVar(name : string) : PCalcItem; - decrements value of a variable. 

procedure AddVar(name : string; value : PCalcItem); - adds internal variable. 

procedure AddUserConstant(name, value : string); - adds new constant. 

function AddUserFunction(name : string; paramcount:integer; 
fun : pformulafunction; defval : PDefArray = nil; 
ismodule:boolean=false;replace:boolean=false):PTableItem;  - adds user function.

function AddModuleFunction(module: PTableItem; name : string;
paramcount:integer; fun : pformulafunction; ismodule:boolean=false;
replace:boolean=false):PTableItem; - adds module function.

function Test(instr : string; num : integer = 0; vars : PStringArray = nil) :
boolean; - tests syntax of source code represented by instr. External variable
names are passed as vars parameter, num specifies number of external variables.
Returns true if there are no errors.

function Compile(instr : string; num : integer = 0; vars : PStringArray = nil) :
string; - compiles source string and returns compiled bytecode. On error raises
exception.

function ComputeN(num : integer = 0; vals : PCalcArray = nil) : double; -
compute previously compiled program and returns result as numeric value. Values
of extern variables are passed in vals parameter, the number of values is passed
in num value.

function Compute(num : integer = 0; vals : PCalcArray = nil) : string; - compute
previously compiled program and returns result as string value.

function ComputeStrN(instr : string; num : integer = 0; vars : PStringArray = nil;
vals : PCalcArray = nil) : double; - compiles and computes source string.
Returns result as numeric value.

function ComputeStr(instr : string; num : integer = 0; vars : PStringArray = nil;
vals : PCalcArray = nil) : string; - compiles and computes source string.
Returns result as string value.

procedure StartGetVars(n : integer); - starts new parameters evaluation for
variable argument list function.

function GetNextVar(var x : TCalcItem) : boolean; - evaluates next variable
argument list function parameter. Returns false for last value.

function GetLocalString(name : string; defvalue : string) : string; -
if TArtFormula compiled with multilang support, this function returns string
value from current loaded language for string name and if string not set or
empty it returns defvalue.

procedure LoadLang(lngfile : string); - if TArtFormula compiled with multilang
support, this procedure load local strings from lngfile.

procedure SetLocalString(name : string; value : string); - if TArtFormula
compiled with multilang support, this procedure can be used to change error
strings in runtime.

Events:

property GetVarsCount : TArtFormulaGetVarsCountProc;
TArtFormulaGetVarsCountProc = procedure(Vname:string; var count:integer) of
object;
If you set ExternGetVars all unknown identifiers will treated as external
variables. To evaluate them you should implement GetVarsCount and GetVarValue
event handlers. GetVarsCount should return in count parameter number of values
associated with Vname variable.

property GetVarValue : TArtFormulaGetVarProc;
TArtFormulaGetVarProc = procedure(Vname:string; n : integer; var Val:string) of
object;
GetVarValue should return in Val parameter n-th value associated with Vname
variable. n will change from 0 to count-1 where count returned by GetVarsCount
event.

Note. Using GetVarsCount and GetVarValue you can implement for example range
calculation in spreadsheet application when one parameter passed in variant
argument list function associated with number of cells.

Note. For fixed argument list function ArtFormula will evaluate only first value
associated with variable.

property OnStep : TArtFormulaStepProc
TArtFormulaStepProc =  procedure(AF:TArtFormula) of object;
Write OnStep event handler to debug your ArtFormula program (see demo).


property OnLoadLang : TArtFormulaLoadLangProc;
TArtFormulaLoadLangProc =  procedure of object;
If TArtFormula compiled with multilang support, this event arises when new local
strings loaded from lang file. You can use this event to change local strings
for installed TArtFormula modules or user functions.

--------------------------------------------------------------------------------
Author
Artem V. Parlyuk, e-mail:artsoft@nm.ru, http://artsoft.nm.ru

--------------------------------------------------------------------------------
License and disclaimer agreement 
IMPORTANT - READ CAREFULLY

This license and disclaimer statement constitutes a legal agreement
("License Agreement") between you (either as an individual or a single
entity) and Artem Parlyuk (the "Author"), for this software product in
this particular case TArtFormula Delphi package ("Software"), including
any software, media, and accompanying on-line or printed documentation.

BY DOWNLOADING, INSTALLING, COPYING, OR OTHERWISE USING THE SOFTWARE,
YOU AGREE TO BE BOUND BY ALL OF THE TERMS AND CONDITIONS OF THIS LICENSE
AND DISCLAIMER AGREEMENT. If you do not agree with the terms and
conditions of this agreement, you must promptly cease all use of the
software and destroy all copies of this software and all of its component
parts in your possession or under your control.

This Software is owned by Author and is protected by copyright law
and international copyright treaty.

This Software is freeware. You are granted the permission to use
Software in your own applications for private or commercial purposes,
provided your software contains the copyright notice "TArtFormula
Delphi package Copyright (c) by Artem Parlyuk" and link to the Author
site (http://artsoft.nm.ru) and Author e-mail (mailto:artsoft@nm.ru) .

You can freely distribute copies of the main archive as long as no
alterations are made to the contents and no charge is raised except
a reasonable fee for distributing costs. You may not remove copyright
notices from copies of the Software. You may not claim this Software
as written by anyone but Author, Artem Parlyuk.

The author has taken all possible care to ensure the software is
error-free, however the author disavows any potential liability
arising from any use of the software. This software is provided
"as is" and without any warranties expressed or implied, including,
but not limited to, implied warranties of fitness for a particular
purpose, and non-infringement. You expressly acknowledge and agree
that use of the Software is at your sole risk.

In no event shall the author be liable for any damages whatsoever
(including, without limitation, damages for loss of business profits,
business interruption, loss of business information, or other pecuniary
loss) arising out of the use of or inability to use this software or
documentation, even if the author has been advised of the possibility
of such damages.

Any feedback given to the Author will be treated as non-confidential.
The Author may use any feedback free of charge without limitation.

*)


{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

{$I artformula.inc}

{.$DEFINE TestFuncNames}

unit formula;

interface
uses SysUtils, classes;


const

 DATA_INC_STEP=200;


type

 TFormulaError = (ER_Ok, ER_ILLEGAL, ER_UNKNOWN, ER_RIGHT, ER_LEFT, ER_SYNTAX, ER_VARS,
   ER_NOTENOUGH,ER_IDENT,ER_FORWARD);

 FormulaException = class(Exception)
 end;
 TArtFormula = class;

 TFormulaCalc = class;

 TFormulaDataType = (fdtnumber, fdtstring, fdtgetvar);

 TCalcItem = record
   data : double;
   str : string;
   typ : TFormulaDataType;
 end;

 TCalcArray = array of TCalcItem;
 PCalcItem = ^TCalcItem;
 PCalcArray = ^TCalcArray;
 TDefArray = array [0..255] of TCalcItem;
 PDefArray = ^TDefArray;

 pformulafunction = function(var Calc : TFormulaCalc):TCalcItem;

 PTableItem = ^FTableItem;


 FTableItem = record
      name : string;
      paramcount : integer;
      defvalues : PDefArray;
      fun : pformulafunction;
      module : boolean;
      funs : array of PTableItem;
 end;


 ATableItem = array of PTableItem;
 PATableItem = ^ATableItem;

 TFormulaStack = class
 protected
  max,pos : integer;
  data : array of char;
  Parent : TArtFormula;
 public
  constructor Create(i:integer=DATA_INC_STEP);
  destructor Destroy; override;
  property Num : integer read pos;
  function Top : char;
  procedure Push(c : char);
  function Pop:char;
  function PopEx : string;
 end;

 TFormulaCalc = class
 protected
  max,pos : integer;
  data : TCalcArray;
  fParent : TArtFormula;
 public
  property Parent : TArtFormula read fParent;
  constructor Create(i:integer=DATA_INC_STEP);
  destructor Destroy; override;
  property Num : integer read pos;

  procedure Clear;
  function TopN: double;
  function TopS: String;
  procedure PushN(n:double);
  procedure PushS(s:string);
  procedure Push(var x: TCalcItem);
  function PopN : double;
  function PopS : string;
  procedure Pop(n:integer);
  function ItemN(i:integer):double;
  function ItemS(i:integer):string;
  function Item(i:integer):PCalcItem;
  procedure Plus;
  procedure PlusS;
  procedure Minus;
  procedure Mult;
  procedure cDiv;
  procedure Division;
  procedure cMod;
  procedure Like;
  procedure Pow;
  procedure EQ;
  procedure NE;
  procedure LE;
  procedure LT;
  procedure GE;
  procedure GT;
  procedure cAND;
  procedure cOR;
  procedure cXOR;
  procedure cNOT;

  procedure bAND;
  procedure bOR;
  procedure bXOR;
  procedure bNOT;
  procedure bSHL;
  procedure bSHR;

  procedure Uminus;
  procedure DoFunction(var fun: FTableItem; cnt:integer; module : boolean = false; addcnt : integer = 0);
end;

 StringArray = array of String;
 PStringArray = ^StringArray;

 TConstItem = record
  name, value : string;
 end;

TArtFormulaGetVarProc =  procedure(Vname:string; n : integer; var Val:string; wantnumber:boolean=false) of object;
TArtFormulaGetVarsCountProc =  procedure(Vname:string; var count:integer; wantnumber:boolean=false) of object;
TArtFormulaLoadLangProc =  procedure of object;
TArtFormulaStepProc =  procedure(AF:TArtFormula) of object;


TArtSubFormula = record
  name : string;
  frwd : boolean;
  paramcount : integer;
  varnames : StringArray;
  values :  TCalcArray;
  defvalues : PDefArray;
  fcompiled : string;
end;

TArtSFArray = array of TArtSubFormula;
PArtSubFormula = ^TArtSubFormula;

TArtFormula = class(TComponent)
  protected
   offset, soffset, xoffset, xsoffset, xlines, pos, {numofvar,} spos, lines : integer;
   ferror : TFormulaError;
   fstop : boolean;
   fstep : boolean;
   flines : boolean;
   fexsyntax : boolean;
   fexgetvar : boolean;
   fautovar : boolean;
   fgetvar :  TArtFormulaGetVarProc;
   fgetvarscount : TArtFormulaGetVarsCountProc;
   fonstep : TArtFormulaStepProc;
   ftestused : boolean;
   fcasesensitive, fcasesensitivestring : boolean;
   funquotedstring, fnozero, fzero : boolean;
   fvarname : string;
   ffuncname, fmodulename : string;
   fparamcount : integer;
   S : TFormulaStack;
   C : TFormulaCalc;
   input : string;
   temp,tmp : string;
   tc : char;
   formula : TArtSubFormula;
   pformula :PArtSubFormula;
//   varnames : StringArray;
//   values : TCalcArray;
   data : double;

   ncnt, gvcnt, gvpos, npos : integer;
   vals : array of string;

   fsubformula : TArtSFArray;

   usedvars : array of boolean;
   userfunc : ATableItem;
   ConstTable : array of TConstItem;
   formula_err : TFormulaError;
//   fcompiled : string;
{$ifdef AF_MULTILANG}
   flocalstrings : TStrings;
   floadlang : TArtFormulaLoadLangProc;
{$endif}
   function Parser(flag:boolean=false; unq : boolean = false; getident : boolean = false) : char;
   function Form: char;
   function ErrString: string;
   function GetPos:integer;
   function GetSPos:integer;
   function GetLPos:integer;
   function TestIdent(name : string; testfrwd : boolean = false) : char;
   procedure IntCompute(compiled : string; num : integer; vals : PCalcArray);
   procedure AddLine;
  public
   constructor Create(AOwner: TComponent); override;
   destructor Destroy; override;

   function FindVar(name : string): integer;
   procedure SetVar(name : string; value : PCalcItem);
   function GetVar(name : string) : PCalcItem;
   function IncVar(name : string) : PCalcItem;
   function DecVar(name : string) : PCalcItem;
   procedure AddVar(name : string; value : PCalcItem);

   procedure StartGetVars(n : integer);
   function GetNextVar(var x : TCalcItem; wantnumber : boolean=false) : boolean;

   function AddUserFunction(name : string; paramcount:integer; fun : pformulafunction; defval : PDefArray = nil; ismodule:boolean=false;replace:boolean=false):PTableItem;
   function AddModuleFunction(module: PTableItem; name : string; paramcount:integer; fun : pformulafunction; ismodule:boolean=false;replace:boolean=false):PTableItem;
   procedure AddUserConstant(name, value : string; test : boolean = false);

   property Calc : TFormulaCalc read C;
   property Error : TFormulaError read ferror;
   property ErrPos : integer read GetSpos;
   property ErrLine : integer read GetLPos;
   property ErrStrPos : integer read GetPos;
   property Stop : boolean write fstop;
   property Compiled : string read formula.fcompiled write formula.fcompiled;

   property FunctionName : string read ffuncname;
   property ModuleName : string read fmodulename;
   property ParamCount : integer read fparamcount;

   property Global : TArtSubFormula read formula;
   property Subroutine : PArtSubFormula read pformula;


{$ifdef AF_MULTILANG}
   property LocalStrings : TStrings read flocalstrings write flocalstrings;

   function GetLocalString(name : string; defvalue : string) : string;
   procedure LoadLang(lngfile : string);
{$endif}

   function Test(instr : string; num : integer = 0; vars : PStringArray = nil) : boolean;
   function Compile(instr : string; num : integer = 0; vars : PStringArray = nil) : string;
   function ComputeN(num : integer = 0; vals : PCalcArray = nil) : double;
   function Compute(num : integer = 0; vals : PCalcArray = nil) : string;
   function ComputeStrN(instr : string; num : integer = 0; vars : PStringArray = nil; vals : PCalcArray = nil) : double;
   function ComputeStr(instr : string; num : integer = 0; vars : PStringArray = nil; vals : PCalcArray = nil) : string;

   procedure CompileProgram(instr : string);
   function RunSub(name : string;vals : PCalcArray = nil) : string; overload;
   function RunSub(idx:integer; vals : PCalcArray = nil) : string; overload;
{$ifdef AF_MULTILANG}
   procedure SetLocalString(name : string; value : string);
{$endif}
 published

   property UnQuotedString : boolean read funquotedstring write funquotedstring;
   property TestUsedVars : boolean read ftestused write ftestused default false;
   property CaseSensitive : boolean read fcasesensitive write fcasesensitive default false;
   property Step : boolean read fstep write fstep;
   property StoreLines : boolean read flines write flines;
   property CaseSensitiveString : boolean read fcasesensitivestring write fcasesensitivestring default true;
   property ExternGetVar : boolean read fexgetvar write fexgetvar;
   property VarNameLiterals : string read fvarname write fvarname;
   property GetVarValue : TArtFormulaGetVarProc read fgetvar write fgetvar;
   property GetVarsCount : TArtFormulaGetVarsCountProc read fgetvarscount write fgetvarscount;
   property NoLeadingZero : boolean read fnozero write fnozero;
   property ZeroEmptyString : boolean read fzero write fzero;
   property SubFormula : TArtSFArray read fsubformula;
   property OnStep : TArtFormulaStepProc read fonstep write fonstep;
   property AutoCreateVars : boolean read fautovar write fautovar;
{$ifdef AF_MULTILANG}
   property OnLoadLang : TArtFormulaLoadLangProc read floadlang write floadlang;
{$endif}
end;

function getN(var x : TCalcItem; AF : TArtFormula = nil) : double;
function getS(var x : TCalcItem; AF : TArtFormula = nil) : string;
procedure setN(var x : TCalcItem; n:double);
procedure setS(var x : TCalcItem; s:string);

procedure Register;

implementation

{$J+}

uses math, formulaf, AMask, forms, inifiles {$IFDEF LCL}, LResources{$endif};

const


 F_EOS = chr(255);
 F_DATA = chr(254);
 F_VAR = chr(253);
 F_NE = chr(252);
 F_UMINUS = chr(251);
 F_GE = chr(250);
 F_LE = chr(249);
 F_USERF = chr(248);
 F_XOR = chr(247);
 F_STR = chr(246);
 F_FUN = chr(245);
 F_IF = chr(244);
 F_WHILE = chr(243);
 F_GO = chr(242);
 F_POP = chr(241);
 F_LET = chr(240);
 F_UNTIL = chr(239);
 F_FOR = chr(238);
 F_INC = chr(237);
 F_DEC = chr(236);
 F_IDENT = chr(235);
 F_MFUN = chr(234);
 F_IDXF = chr(233);
 F_IDXF1 = chr(232);
 F_GETVAR = chr(231);
 F_SHL = chr(230);
 F_SHR = chr(229);
 F_BXOR = chr(228);
 F_BOR = chr(227);
 F_BAND = chr(226);
 F_BNOT = chr(225);
 F_RETURN = chr(224);
 F_LIKE = chr(223);
 F_GLOBAL = chr(222);
 F_CONST = chr(221);
 F_SUB = chr(220);
 F_LINE = chr(219);
 F_FORWARD = chr(218);

 IDX_SET = 0;
 IDX_VAL = 1;
 IDX_INC = 5;
 IDX_DEC = 6;

 NUMFUN = 76;

const
 dv_round : array[0..1] of TCalcItem = ((typ:fdtgetvar),(data:0;typ:fdtnumber));
 dv_iff : array[0..2] of TCalcItem = ((typ:fdtgetvar),(typ:fdtgetvar),(data:0;typ:fdtnumber));
 dv_formatdate : array[0..1] of TCalcItem = ((str:'c';typ:fdtstring),(typ:fdtgetvar));
 dv_stringofchar : array[0..1] of TCalcItem = ((str:' ';typ:fdtstring),(typ:fdtgetvar));
 dv_input : array[0..2] of TCalcItem = ((str:'Input value';typ:fdtstring),(str:'Value:';typ:fdtstring),(str:'';typ:fdtstring));
 dv_msg : array[0..2] of TCalcItem = ((typ:fdtgetvar),(str:'Message';typ:fdtstring),(data:0;typ:fdtnumber)); 

 table : array [0..NUMFUN-1] of FTableItem =
(
 (name:'SET';paramcount:2;fun:myset),
 (name:'VAL';paramcount:1;fun:myval),
 (name:'DEFINE';paramcount:2;fun:myvar),
 (name:'BLOCK';paramcount:-1;fun:myblock),
 (name:'DEFINES';paramcount:-1;fun:myvars),
 (name:'INC'; paramcount:1;fun:myinc),
 (name:'DEC'; paramcount:1;fun:mydec),
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
 (name:'RANDOMIZE';paramcount:0;fun:myrandomize),
 (name:'MAX';paramcount:-1;fun:mymax),
 (name:'MIN';paramcount:-1;fun:mymin),
 (name:'AVG';paramcount:-1;fun:myavg),
 (name:'STDDEV';paramcount:-1;fun:mystddev),
 (name:'STDDEVP';paramcount:-1;fun:mystddevp),
 (name:'SUM';paramcount:-1;fun:mysum),
 (name:'CONCAT';paramcount:-1;fun:myconcat),
 (name:'SUMOFSQUARES';paramcount:-1;fun:mysumofsquares),
 (name:'COUNT';paramcount:-1;fun:mycount),
 (name:'VARIANCE';paramcount:-1;fun:myvariance),
 (name:'VARIANCEP';paramcount:-1;fun:myvarp),
 (name:'IFF';paramcount:3;defvalues:@dv_iff;fun:myiff),
 (name:'CHR';paramcount:1;fun:mychr),
 (name:'LENGTH';paramcount:1;fun:mylength),
 (name:'TRIM';paramcount:1;fun:mytrim),
 (name:'TRIMLEFT';paramcount:1;fun:mytrimleft),
 (name:'TRIMRIGHT';paramcount:1;fun:mytrimright),
 (name:'UPPERCASE';paramcount:1;fun:myuppercase),
 (name:'LOWERCASE';paramcount:1;fun:mylowercase),
 (name:'MIDSTR';paramcount:3;fun:mymidstr),
 (name:'LEFTSTR';paramcount:2;fun:myleftstr),
 (name:'RIGHTSTR';paramcount:2;fun:myrightstr),
 (name:'POS';paramcount:2;fun:mypos),
 (name:'DATE';paramcount:1;fun:mydate),
 (name:'NOW';paramcount:0;fun:mynow),
 (name:'DAYOFWEEK';paramcount:1;fun:myweek),
 (name:'YEAR';paramcount:1;fun:myyear),
 (name:'MONTH';paramcount:1;fun:mymonth),
 (name:'DAY';paramcount:1;fun:myday),
 (name:'HOUR';paramcount:1;fun:myhour),
 (name:'MINUTE';paramcount:1;fun:myminute),
 (name:'SECOND';paramcount:1;fun:mysecond),
 (name:'MILLISECOND';paramcount:1;fun:mymillisecond),
 (name:'ISLEAPYEAR';paramcount:1;fun:myleapyear),
 (name:'ENCODEDATE';paramcount:3;fun:myencodedate),
 (name:'FORMAT';paramcount:2;fun:myformat),
 (name:'FORMATF';paramcount:2;fun:myformatf),
 (name:'FORMATDATE';paramcount:2;defvalues:@dv_formatdate;fun:myformatdate),
 (name:'ISNUMBER';paramcount:1;fun:myisnumber),
 (name:'CODE';paramcount:1;fun:mycode),
 (name:'STRINGOFCHAR';paramcount:2;defvalues:@dv_stringofchar;fun:mystring),
 (name:'INPUT';paramcount:3;defvalues:@dv_input;fun:myinput),
 (name:'MSG';paramcount:3;defvalues:@dv_msg;fun:mymsg),
 (name:'EXISTS';paramcount:1;fun:myexists),
 (name:'TRUNC';paramcount:2;defvalues:@dv_round;fun:mytrunc),
 (name:'ROUND';paramcount:2;defvalues:@dv_round;fun:myround;),
 (name:'HEX';paramcount:1;fun:myhex)
 );

 const
 cGetVarValuenotset               {$ifdef AF_MULTILANG}: string {$endif} = 'GetVarValue not set!';
 cGetVarsCountorGetVarValuenotset {$ifdef AF_MULTILANG}: string {$endif} = 'GetVarsCount or GetVarValue not set!';
 cReturnsZeroVars                 {$ifdef AF_MULTILANG}: string {$endif} = 'returns zero vars!';
 cDoesNotExists                   {$ifdef AF_MULTILANG}: string {$endif} = 'does not exists';
 cVariable                        {$ifdef AF_MULTILANG}: string {$endif} = 'Variable';
// cVariableDoesNotExists           {$ifdef AF_MULTILANG}: string {$endif} = 'Variable does not exists';
// cVariableAlreadyExists           {$ifdef AF_MULTILANG}: string {$endif} = 'Variable already exists';
 cAlreadyExists                   {$ifdef AF_MULTILANG}: string {$endif} = 'already exists';
// cFunctionAlreadyDefined          {$ifdef AF_MULTILANG}: string {$endif} = 'Function already defined';
 cFunction                        {$ifdef AF_MULTILANG}: string {$endif} = 'Function';
 cAlreadyDefined                  {$ifdef AF_MULTILANG}: string {$endif} = 'already defined';
 cTooManyFunctionsDefined         {$ifdef AF_MULTILANG}: string {$endif} = 'Too many functions defined';
// cUserFunctionAlreadyDefined      {$ifdef AF_MULTILANG}: string {$endif} = 'User Function already defined';
 cUserFunction                    {$ifdef AF_MULTILANG}: string {$endif} = 'User Function';
 cTooManyUserFunctionsDefined     {$ifdef AF_MULTILANG}: string {$endif} = 'Too many user functions defined';
// cConstantAlreadyDefined          {$ifdef AF_MULTILANG}: string {$endif} = 'Constant already defined';
 cConstant                        {$ifdef AF_MULTILANG}: string {$endif} = 'Constant';
{$ifndef AF_MULTILANG}
 cIllegalCharacter                = 'Illegal character';
 cUnknownIdentifier               = 'Unknown identifier';
 cExpected                        = 'expected';
 cSyntaxError                     = 'Syntax error';
 cVariableNotUsed                 = 'Variable not used';
 cNotEnoughParameters             = 'Not enough parameters';
 cIdentifierAlreadyDefined        = 'Identifier already defined';
 cUnsatisfied                     = 'Unsatisfied forward declaration';
{$endif}
 cWrongbytecode                   {$ifdef AF_MULTILANG}: string {$endif} = 'Wrong bytecode!';


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

procedure storeint (p: pointer; value: integer); inline;
begin
  System.Move (value, p^, sizeof(integer));
end;


function getint (p: pointer): integer; inline;
var res: integer;
begin
  res := 0;
  System.Move (p^, res, sizeof(integer));
  result := res;
end;


function isznak(c : char) : boolean;
begin
 result := {$IF Defined(AF_DELPHI2010)}CharInSet(c,{$ELSE}(c in{$IFEND} ['@','+','-','*','/','%','\','^','>','<','=','&','|',F_NE,F_LE,
                 F_GE,F_XOR,F_BXOR,F_BAND,F_SHL,F_SHR,F_BOR,F_LIKE]);
end;

function getN(var x : TCalcItem; AF : TArtFormula) : double;
var val:string;
begin
 if x.typ = fdtgetvar then
 //raise FormulaException.Create('Can''t compute extern variable!');
 begin
   if (Af=nil) or not Assigned(AF.getvarvalue) then
       raise FormulaException.Create(cGetVarValuenotset);
   Af.getvarvalue(x.str,0,val);
   if (AF <> nil) and AF.fzero and (val = '') then
    result := 0
   else
    result := strtofloat(val);
 end
 else if x.typ = fdtnumber then result := x.data
 else
 begin
    if (AF <> nil) and AF.fzero and (x.str = '') then
     result := 0
    else 
     result := strtofloat(x.str);
 end;
end;

procedure setN(var x : TCalcItem; n:double);
begin
 x.typ := fdtnumber;
 x.data := n;
end;

function getS(var x : TCalcItem; AF : TArtFormula) : string;
begin
 if x.typ = fdtgetvar then
 //raise FormulaException.Create('Can''t compute extern variable!');
 begin
   if (Af=nil) or not Assigned(AF.getvarvalue) then
       raise FormulaException.Create(cGetVarValuenotset);
   Af.getvarvalue(x.str,0,result);
 end
 else if x.typ = fdtstring then result := x.str
 else result := floattostr(x.data);
end;

procedure setS(var x : TCalcItem;s:string);
begin
 x.typ := fdtstring;
 x.str := s;
end;

constructor TFormulaStack.Create(i : integer = DATA_INC_STEP);
begin
// inherited Create;
 max := i;
 pos := 0;
 setlength(data,i);
end;

destructor TFormulaStack.Destroy;
begin
 data := nil;
 inherited;
end;

function TFormulaStack.Top : char;
begin
 if pos > 0 then result := data[pos - 1]
 else result := #0;
end;

procedure TFormulaStack.Push(c : char);
begin
 if pos = max then
 begin
  inc(max, DATA_INC_STEP);
  setlength(data,max);
 end;
 data[pos] := c;
 inc(pos);
end;

function TFormulaStack.Pop : char;
begin
if pos > 0 then
begin
 dec(pos);
 result := data[pos];
end
else result := #0;
end;

function TFormulaStack.PopEx : string;
begin
if pos > 0 then
begin
 dec(pos);
 if {$IF Defined(AF_DELPHI2010)}CharInSet(data[pos],{$ELSE}(data[pos] in{$IFEND} [F_USERF, F_FUN, F_SUB]) then
 begin
  result := data[pos] + data[pos-1] + data[pos-2];
  dec(pos,2);
 end
 else
 if data[pos] = F_MFUN then
 begin
  result := data[pos] + data[pos-1] + data[pos-2] + data[pos-3];
  dec(pos,3);
 end
 { else
 if data[pos] = F_FUN then
 begin
  result := F_FUN + data[pos-1] + data[pos-2];
  dec(pos);
 end}
 else result := data[pos];
end
else result := #0;
{ if Parent.StoreLines and (result <> #0) then
 begin
  result := result + F_LINE + stringofchar(#0,sizeof(integer) div sizeof(char));
  storeint (@(result[length(result)-sizeof(integer) div sizeof(char)+1]), Parent.getLPos);
 end;}
end;


// Calculator

destructor TFormulaCalc.Destroy;
//var i : integer;
begin
// for i := 0 to high(data) do freeandnil(data[i]);
 data := nil;
 inherited;
end;

constructor TFormulaCalc.Create(i:integer = DATA_INC_STEP);
begin
// inherited Create;
 max := i;
 pos := 0;
 setlength(data,i);
end;

procedure TFormulaCalc.Clear;
begin
  pos := 0;
end;

function TFormulaCalc.TopN: double;
begin
 result := getN(data[pos - 1],parent)
end;

function TFormulaCalc.TopS: string;
begin
 result := getS(data[pos - 1],parent)
end;

procedure TFormulaCalc.PushN(n:double);
begin
 if pos = max then
 begin
  inc(max,DATA_INC_STEP);
  setlength(data,max);
 end;
 data[pos].data := n;
 data[pos].typ := fdtnumber;
 inc(pos);
end;

procedure TFormulaCalc.Push(var x:TCalcItem);
begin
 if pos = max then
 begin
  inc(max,DATA_INC_STEP);
  setlength(data,max);
 end;

 data[pos].typ := x.typ;
 if x.typ = fdtnumber then
  data[pos].data := x.data
 else
  data[pos].str := x.str;
 inc(pos);
end;

procedure TFormulaCalc.PushS(s:string);
begin
 if pos = max then
 begin
  inc(max,DATA_INC_STEP);
  setlength(data,max);
 end;

 data[pos].str := s;
 data[pos].typ := fdtstring;
 inc(pos);
end;

function TFormulaCalc.PopN : double;
begin
   dec(pos);
   result := getN(data[pos],parent);
end;

procedure TFormulaCalc.Pop(n:integer);
begin
   dec(pos,n);
end;


function TFormulaCalc.PopS : string;
begin
   dec(pos);
   result := getS(data[pos],parent);
end;

function TFormulaCalc.ItemN(i:integer):double;
begin
 result := getN(data[pos-i-1],parent)
end;

function TFormulaCalc.Item(i:integer):PCalcItem;
begin
 result := @(data[pos-i-1])
end;

function TFormulaCalc.ItemS(i:integer):string;
begin
 result := getS(data[pos-i-1],parent)
end;

procedure TFormulaCalc.Plus;
begin
 dec(pos);
 try
  data[pos-1].data := getN(data[pos-1],parent) + getN(data[pos],parent);
  data[pos-1].typ := fdtnumber;
 except
  on econverterror do
  begin
    data[pos-1].str := getS(data[pos-1],parent) + getS(data[pos],parent);
    data[pos-1].typ := fdtstring;
  end;
  on Exception do raise;
 end;
end;

procedure TFormulaCalc.PlusS;
begin
 dec(pos);
 data[pos-1].str := getS(data[pos-1],parent) + getS(data[pos],parent);
 data[pos-1].typ := fdtstring;
end;

procedure TFormulaCalc.EQ;
var t : double;
begin
  dec(pos);
  try
   t := ifthen(getN(data[pos-1],parent)=getN(data[pos],parent),1,0)
  except
  on econverterror do
   if Parent.fcasesensitivestring then
    t := ifthen(getS(data[pos-1],parent)=getS(data[pos],parent),1,0)
   else
    t := ifthen(UpperCase(getS(data[pos-1],parent))=UpperCase(getS(data[pos],parent)),1,0);
   on exception do raise; 
  end;
  data[pos-1].data := t;
  data[pos-1].typ := fdtnumber;
end;

procedure TFormulaCalc.NE;
var t : double;
begin
  dec(pos);
  try
   t := ifthen(getN(data[pos-1],parent)<>getN(data[pos],parent),1,0)
  except
  on econverterror do
   if Parent.fcasesensitivestring then
    t := ifthen(getS(data[pos-1],parent)<>getS(data[pos],parent),1,0)
   else
    t := ifthen(UpperCase(getS(data[pos-1],parent))<>UpperCase(getS(data[pos],parent)),1,0);
   on exception do raise;
  end;
  data[pos-1].data := t;
  data[pos-1].typ := fdtnumber;
end;

procedure TFormulaCalc.LE;
var t : double;
begin
  dec(pos);
  try
   t := ifthen(getN(data[pos-1],parent)<=getN(data[pos],parent),1,0)
  except
   on econverterror do
   if Parent.fcasesensitivestring then
    t := ifthen(getS(data[pos-1],parent)<=getS(data[pos],parent),1,0)
   else
    t := ifthen(UpperCase(getS(data[pos-1],parent))<=UpperCase(getS(data[pos],parent)),1,0);
   on exception do raise;
  end;
  data[pos-1].data := t;
  data[pos-1].typ := fdtnumber;
end;

procedure TFormulaCalc.LT;
var t : double;
begin
  dec(pos);
  try
   t := ifthen(getN(data[pos-1],parent)<getN(data[pos],parent),1,0)
  except
   on econverterror do
   if Parent.fcasesensitivestring then
    t := ifthen(getS(data[pos-1],parent)<getS(data[pos],parent),1,0)
   else
    t := ifthen(UpperCase(getS(data[pos-1],parent))<UpperCase(getS(data[pos],parent)),1,0);
   on exception do raise;
  end;
  data[pos-1].data := t;
  data[pos-1].typ := fdtnumber;
end;

procedure TFormulaCalc.GE;
var t : double;
begin
  dec(pos);
  try
   t := ifthen(getN(data[pos-1],parent)>=getN(data[pos],parent),1,0)
  except
   on econverterror do
   if Parent.fcasesensitivestring then
    t := ifthen(getS(data[pos-1],parent)>=getS(data[pos],parent),1,0)
   else
    t := ifthen(UpperCase(getS(data[pos-1],parent))>=UpperCase(getS(data[pos],parent)),1,0);
   on exception do raise;
  end;
  data[pos-1].data := t;
  data[pos-1].typ := fdtnumber;
end;

procedure TFormulaCalc.GT;
var t : double;
begin
  dec(pos);
  try
   t := ifthen(getN(data[pos-1],parent)>getN(data[pos],parent),1,0)
  except
   on econverterror do
   if Parent.fcasesensitivestring then
    t := ifthen(getS(data[pos-1],parent)>getS(data[pos],parent),1,0)
   else
    t := ifthen(UpperCase(getS(data[pos-1],parent))>UpperCase(getS(data[pos],parent)),1,0);
   on exception do raise;
  end;
  data[pos-1].data := t;
  data[pos-1].typ := fdtnumber;
end;

procedure TFormulaCalc.cAND;
begin
 dec(pos);
 data[pos-1].data := ifthen((getN(data[pos-1],parent)<>0) and (getN(data[pos],parent)<>0),1,0);
 data[pos-1].typ := fdtnumber;
end;

procedure TFormulaCalc.cOR;
begin
 dec(pos);
 data[pos-1].data := ifthen((getN(data[pos-1],parent)<>0) or (getN(data[pos],parent)<>0),1,0);
 data[pos-1].typ := fdtnumber;
end;

procedure TFormulaCalc.cXOR;
begin
 dec(pos);
 data[pos-1].data := ifthen((getN(data[pos-1],parent)<>0) xor (getN(data[pos],parent)<>0),1,0);
 data[pos-1].typ := fdtnumber;
end;


procedure TFormulaCalc.bXOR;
begin
 dec(pos);
 data[pos-1].data := trunc(getN(data[pos-1],parent)) xor trunc(getN(data[pos],parent));
 data[pos-1].typ := fdtnumber;
end;

procedure TFormulaCalc.bOR;
begin
 dec(pos);
 data[pos-1].data := trunc(getN(data[pos-1],parent)) or trunc(getN(data[pos],parent));
 data[pos-1].typ := fdtnumber;
end;

procedure TFormulaCalc.bAND;
begin
 dec(pos);
 data[pos-1].data := trunc(getN(data[pos-1],parent)) and trunc(getN(data[pos],parent));
 data[pos-1].typ := fdtnumber;
end;


procedure TFormulaCalc.bSHR;
begin
 dec(pos);
 data[pos-1].data := trunc(getN(data[pos-1],parent)) shr trunc(getN(data[pos],parent));
 data[pos-1].typ := fdtnumber;
end;

procedure TFormulaCalc.bSHL;
begin
 dec(pos);
 data[pos-1].data := trunc(getN(data[pos-1],parent)) shl trunc(getN(data[pos],parent));
 data[pos-1].typ := fdtnumber;
end;


procedure TFormulaCalc.Minus;
begin
 dec(pos);
 data[pos-1].data := getN(data[pos-1],parent) - getN(data[pos],parent);
 data[pos-1].typ := fdtnumber;
end;

procedure TFormulaCalc.Mult;
begin
  dec(pos);
  data[pos-1].data := getN(data[pos-1],parent) * getN(data[pos],parent);
  data[pos-1].typ := fdtnumber;
end;

procedure TFormulaCalc.Division;
begin
   dec(pos);
   data[pos-1].data := getN(data[pos-1],parent) / getN(data[pos],parent);
   data[pos-1].typ := fdtnumber;
end;

procedure TFormulaCalc.cDiv;
begin
   dec(pos);
   data[pos-1].data := trunc(getN(data[pos-1],parent)) Div trunc(getN(data[pos],parent));
   data[pos-1].typ := fdtnumber;
end;

procedure TFormulaCalc.cMod;
begin
   dec(pos);
   data[pos-1].data := trunc(getN(data[pos-1],parent)) mod trunc(getN(data[pos],parent));
   data[pos-1].typ := fdtnumber;
end;

procedure TFormulaCalc.Like;
begin
   dec(pos);
   data[pos-1].data := ifthen(MatchesMask(getS(data[pos-1],parent), getS(data[pos],parent)),1,0);
   data[pos-1].typ := fdtnumber;
end;


procedure TFormulaCalc.Pow;
begin
   dec(pos);
   data[pos-1].data := power(getN(data[pos-1],parent),getN(data[pos],parent));
   data[pos-1].typ := fdtnumber;
end;

procedure TFormulaCalc.Uminus;
begin
   data[pos-1].data := -getN(data[pos-1],parent);
   data[pos-1].typ := fdtnumber;
end;

procedure TFormulaCalc.cNot;
begin
   data[pos-1].data := ifthen(getN(data[pos-1],parent)=0,1,0);
   data[pos-1].typ := fdtnumber;
end;

procedure TFormulaCalc.bNot;
begin
   data[pos-1].data := not trunc(getN(data[pos-1],parent));
   data[pos-1].typ := fdtnumber;
end;


procedure TFormulaCalc.DoFunction(var fun: FTableItem; cnt:integer; module:boolean; addcnt : integer);
{$IFDEF TestFuncNames}
var s : string;
{$EndIf}
begin
    if cnt = ord(chr(-1)) then cnt := trunc(getN(data[pos-1],parent)+1);
   // if module then inc(cnt);
    if (cnt = 0) then
    begin
     PushN(0);
     cnt := 1;
    end;
    Parent.ffuncname := fun.name;
    Parent.fparamcount := fun.paramcount;

{$IFDEF TestFuncNames}
    if Parent.fModulename <> '' then
      s := Parent.fmodulename+'.'+Parent.ffuncname
    else
      s := Parent.ffuncname;
    Application.MessageBox(pchar(s),'Function Name', 0);
{$EndIf}
    data[pos-cnt-addcnt] := fun.fun(Self);
    dec(pos,cnt-1+addcnt);
end;

function prior(a,b : char) : boolean;
var pa,pb:integer;
begin
 if (a = F_FUN) or (a = F_USERF) or (a = F_MFUN) then pa := 1
 else if a = '^' then pa := 2
 else if {$IF Defined(AF_DELPHI2010)}CharInSet(a,{$ELSE}(a in{$IFEND} ['!',F_UMINUS,F_BNOT]) then pa := 3
 else if {$IF Defined(AF_DELPHI2010)}CharInSet(a,{$ELSE}(a in{$IFEND} ['*','/','%','\',F_BAND,'&',F_SHR,F_SHL]) then pa := 4
 else if {$IF Defined(AF_DELPHI2010)}CharInSet(a,{$ELSE}(a in{$IFEND} ['+','-','@']) then pa := 5
 else if {$IF Defined(AF_DELPHI2010)}CharInSet(a,{$ELSE}(a in{$IFEND} ['|',F_XOR,F_BXOR,F_BOR]) then pa := 6
 else if {$IF Defined(AF_DELPHI2010)}CharInSet(a,{$ELSE}(a in{$IFEND} ['<','>','=',F_NE,F_GE,F_LE,F_LIKE]) then pa := 7
 else if {$IF Defined(AF_DELPHI2010)}CharInSet(a,{$ELSE}(a in{$IFEND} ['(',')']) then pa := 8
 else pa := 100;

 if (b = F_FUN) or (b = F_USERF) or (b = F_MFUN) then pb := 1
 else if b = '^' then pb := 2
 else if {$IF Defined(AF_DELPHI2010)}CharInSet(b,{$ELSE}(b in{$IFEND} ['!',F_UMINUS,F_BNOT]) then pb := 3
 else if {$IF Defined(AF_DELPHI2010)}CharInSet(b,{$ELSE}(b in{$IFEND} ['*','/','%','\',F_BAND,'&',F_SHL,F_SHR]) then pb := 4
 else if {$IF Defined(AF_DELPHI2010)}CharInSet(b,{$ELSE}(b in{$IFEND} ['+','-','@']) then pb := 5
 else if {$IF Defined(AF_DELPHI2010)}CharInSet(b,{$ELSE}(b in{$IFEND} ['|',F_XOR,F_BXOR,F_BOR]) then pb := 6
 else if {$IF Defined(AF_DELPHI2010)}CharInSet(b,{$ELSE}(b in{$IFEND} ['<','>','=',F_NE,F_GE,F_LE,F_LIKE]) then pb := 7
 else if {$IF Defined(AF_DELPHI2010)}CharInSet(b,{$ELSE}(b in{$IFEND} ['(',')']) then pb := 8
 else pb := 100;

 result := pa >= pb;

end;

destructor TArtFormula.Destroy;
var i : integer;
begin

// Thanks to Fabian C.
 for i:=0 to  Length(userfunc) -1 do
  Dispose(userfunc[i]);

 for i:=0 to  Length(fsubformula) -1 do
 begin
  fsubformula[i].varnames := nil;
  fsubformula[i].values := nil;
  if fsubformula[i].defvalues <> nil then
    dispose(fsubformula[i].defvalues);
 end;

 fsubformula := nil;

 S.Free;
 S := nil;
 C.Free;
 C := nil;
 usedvars := nil;
 userfunc := nil;
 formula.varnames := nil;
 formula.values := nil;
 if formula.defvalues <> nil then
  dispose(formula.defvalues);

 {$ifdef AF_Multilang}
  flocalstrings.Free;
  flocalstrings := nil;
 {$endif}

 inherited;
end;

constructor TArtFormula.Create(AOwner: TComponent);
begin
 inherited Create(AOwner);

 pos := 1;
 spos := 1;
 lines := 1;
 soffset := 0;
 offset := 0;
 ferror := ER_Ok;
 input :=#0;
 usedvars := nil;
 S := TFormulaStack.Create;
 S.Parent := self;
 C := TFormulaCalc.Create;
 C.fParent := self;
 fcasesensitivestring := true;
 pformula := @formula;
 fvarname := '_ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
 AddUserConstant('FALSE','0');
 AddUserConstant('TRUE','1');
 AddUserConstant('DIV','\');
 AddUserConstant('MOD','%');
 AddUserConstant('AND','&');
 AddUserConstant('OR','|');
 AddUserConstant('NOT','!');
 AddUserConstant('BAND','&&');
 AddUserConstant('BOR','||');
 AddUserConstant('BNOT','!!');
 AddUserConstant('SHR','>>');
 AddUserConstant('SHL','<<');
 AddUserConstant('BEGIN','BLOCK(');
 AddUserConstant('END',')');
 AddUserConstant('ENDD','))');
 AddUserConstant('VAR','DEFINES(');
 AddUserConstant('IF','CONDITION(');
 AddUserConstant('THEN',',BLOCK(');
 AddUserConstant('ELSE','),BLOCK(');
 AddUserConstant('ENDIF','),0)');
 AddUserConstant('WHILE','LOOP(');
 AddUserConstant('DO',',BLOCK(');
 AddUserConstant('WEND','))');
 AddUserConstant('FOR','SERIES(');
 AddUserConstant('NEXT','))');
 AddUserConstant('REPEAT','TILL(BLOCK(');
 AddUserConstant('UNTIL','),');
 AddUserConstant('LN','LOG');
 AddUserConstant('PROCEDURE','SUB');
 AddUserConstant('FUNCTION','SUB');

 {$ifdef AF_Multilang}
  flocalstrings := TStringList.Create;
  flocalstrings.Delimiter := '=';
 {$endif}

end;

{$ifdef AF_MULTILANG}
const err_strings : array [TFormulaError] of string =
('Ok', 'Illegal character', 'Unknown identifier', '")" expected', '"(" expected',
  'Syntax error', 'Variable not used','Not enough parameters','Identifier already defined',
  'Unsatisfied forward declaration');
{$else}
const err_strings : array [TFormulaError] of string =
('Ok', cIllegalcharacter, cUnknownidentifier, '")" '+ cexpected, '"(" '+cexpected,
  cSyntaxerror, cVariablenotused,cNotenoughparameters,cIdentifierAlreadyDefined,
  cUnsatisfied);
{$endif}


 {$ifdef AF_Multilang}

function TArtFormula.GetLocalString(name : string; defvalue : string) : string;
begin
  if flocalstrings.IndexOfName(name) = -1 then result := defvalue
  else
  begin
   result := flocalstrings.Values[name];
   if result = '' then  result := defvalue;
  end;

end;


procedure TArtFormula.LoadLang(lngfile : string);
var ini : Tinifile;
begin
 try
  ini := TIniFile.Create(lngfile);
  ini.ReadSectionValues('ArtFormula',flocalstrings);
 finally
  FreeAndNil(ini);
 end;

 cGetVarValuenotset               := GetLocalString('cGetVarValueNotSet', 'GetVarValue not set!');
 cGetVarsCountorGetVarValuenotset := GetLocalString('cGetVarsCountorGetVarValuenotset', 'GetVarsCount or GetVarValue not set!');
 cReturnsZeroVars                 := GetLocalString('cReturnsZeroVars', 'returns zero vars!');
 cDoesNotExists                   := GetLocalString('cDoesNotExists', 'does not exists');
 cVariable                        := GetLocalString('cVariable', 'Variable');
// cVariableDoesNotExists           := GetLocalString('cVariableDoesNotExists', 'Variable does not exists');
// cVariableAlreadyExists           := GetLocalString('cVariableAlreadyExists', 'Variable already exists');
 cAlreadyExists                   := GetLocalString('cAlreadyExists', 'already exists');
// cFunctionAlreadyDefined          := GetLocalString('cFunctionAlreadyDefined', 'Function already defined');
 cFunction                        := GetLocalString('cFunction', 'Function');
 cAlreadyDefined                  := GetLocalString('cAlreadyDefined', 'already defined');
 cTooManyFunctionsDefined         := GetLocalString('cTooManyFunctionsDefined', 'Too many functions defined');
// cUserFunctionAlreadyDefined      := GetLocalString('cUserFunctionAlreadyDefined', 'User Function already defined');
 cUserFunction                    := GetLocalString('cUserFunction', 'User Function');
 cTooManyUserFunctionsDefined     := GetLocalString('cTooManyUserFunctionsDefined', 'Too many user functions defined');
// cConstantAlreadyDefined          := GetLocalString('cConstantAlreadyDefined', 'Constant already defined');
 cConstant                        := GetLocalString('cConstant', 'Constant');
 cWrongbytecode                   := GetLocalString('cWrongbytecode', 'Wrong bytecode!');

 err_strings[ER_ILLEGAL] := GetLocalString('cIllegalCharacter', 'Illegal character');
 err_strings[ER_UNKNOWN] := GetLocalString('cUnknownIdentifier', 'Unknown identifier');
 err_strings[ER_RIGHT] :=  '")" '+ GetLocalString('cExpected', 'expected');
 err_strings[ER_LEFT] :=   '"(" '+ GetLocalString('cExpected', 'expected');
 err_strings[ER_SYNTAX] :=  GetLocalString('cSyntaxError', 'Syntax error');
 err_strings[ER_VARS] :=    GetLocalString('cVariableNotUsed', 'Variable not used');
 err_strings[ER_NOTENOUGH] := GetLocalString('cNotEnoughParameters', 'Not enough parameters');
 err_strings[ER_IDENT] := GetLocalString('cIdentifierAlreadyDefined', 'Identifier already defined');
 err_strings[ER_FORWARD] :=  GetLocalString('cUnsatisfied', 'Unsatisfied forward declaration');

  if Assigned(floadlang) then floadlang;
end;


procedure TArtFormula.SetLocalString(name : string; value : string);
begin

  if AnsiSameText('cGetVarValuenotset', name) then
    cGetVarValuenotset := value
  else if AnsiSameText('cGetVarsCountorGetVarValuenotset', name) then
    cGetVarsCountorGetVarValuenotset := value
  else if AnsiSameText('cReturnsZeroVars', name) then
    cReturnsZeroVars := value
  else if AnsiSameText('cDoesNotExists', name) then
    cDoesNotExists := value
  else if AnsiSameText('cVariable', name) then
    cVariable := value
  else if AnsiSameText('cAlreadyExists', name) then
    cAlreadyExists := value
  else if AnsiSameText('cFunction', name) then
    cFunction := value
  else if AnsiSameText('cAlreadyDefined', name) then
    cAlreadyDefined := value
  else if AnsiSameText('cTooManyFunctionsDefined', name) then
    cTooManyFunctionsDefined := value
  else if AnsiSameText('cUserFunction', name) then
    cUserFunction := value
  else if AnsiSameText('cTooManyUserFunctionsDefined', name) then
    cTooManyUserFunctionsDefined := value
  else if AnsiSameText('cConstant', name) then
    cConstant := value
  else if AnsiSameText('cWrongbytecode', name) then
    cWrongbytecode := value
  else if AnsiSameText('cIllegalCharacter', name) then
    err_strings[ER_ILLEGAL] := value
  else if AnsiSameText('cUnsatisfied', name) then
    err_strings[ER_FORWARD] := value
  else if AnsiSameText('cUnknownIdentifier', name) then
    err_strings[ER_UNKNOWN] := value
  else if AnsiSameText('cExpected', name) then
    begin
      err_strings[ER_RIGHT] := '")" '+ value;
      err_strings[ER_LEFT] := '"(" '+ value;
    end
  else if AnsiSameText('cSyntaxError', name) then
    err_strings[ER_SYNTAX] := value
  else if AnsiSameText('cVariableNotUsed', name) then
    err_strings[ER_VARS] := value
  else if AnsiSameText('cNotEnoughParameters', name) then
    err_strings[ER_NOTENOUGH] := value
  else if AnsiSameText('cIdentifierAlreadyDefined', name) then
    err_strings[ER_IDENT] := value;
end;


 {$endif}

function TArtFormula.GetPos:integer;
begin
 result := pos + offset + xoffset;
end;

function TArtFormula.GetSPos:integer;
begin
 result := spos + soffset + xsoffset;
end;

function TArtFormula.GetLPos:integer;
begin
 result := lines+xlines;
end;

procedure TArtFormula.AddLine;
begin
 if flines then
 begin
  temp := temp + F_LINE + stringofchar(#0,sizeof(integer) div sizeof(char));
  storeint (@(temp[length(temp)-sizeof(integer) div sizeof(char)+1]), getLPos);
 end;
end;

procedure TArtFormula.StartGetVars(n : integer);
begin
 npos := 1;
 ncnt := n;
 gvpos := 0;
 gvcnt := 0;
end;

function TArtFormula.GetNextVar(var x : TCalcItem; wantnumber:boolean) : boolean;
var nm:string;
    i:integer;
begin
 if gvcnt > 0 then
 begin
  setS(x,vals[gvpos]);
  inc(gvpos);
  if gvpos = gvcnt then gvcnt := 0;
 end
 else
 if C.Item(npos).typ <> fdtgetvar then
 begin
   x := C.Item(npos)^;
   inc(npos);
 end
 else
 begin
   if not Assigned(fgetvar) or not Assigned(fgetvarscount) then
       raise FormulaException.Create(cGetVarsCountorGetVarValuenotset);
   nm := C.item(npos).str;
   fGetVarsCount(nm,gvcnt,wantnumber);
   if gvcnt = 0 then raise FormulaException.Create('"'+nm+cReturnsZeroVars);
   setlength(vals,gvcnt);
   for i:=gvcnt-1 downto 0 do fGetVar(nm,i,vals[gvcnt-i-1],wantnumber);
   inc(npos);
   gvpos := 1;
   setS(x,vals[0]);
   if gvcnt = 1 then gvcnt := 0;
 end;
 result := (npos <= ncnt) or (gvcnt <> 0);
end;



procedure TArtFormula.SetVar(name : string; value : PCalcItem);
var idx : integer;
    p : PArtSubFormula;
begin
 p := pformula;
 idx := FindVar(name);
 if idx = -1 then
 begin
  if not fautovar then raise FormulaException.Create(cVariable+' '+name+' '+cDoesNotExists)
  else AddVar(name,value);
 end
 else
 begin
  pformula.Values[idx] := value^;
  pformula := p;
 end;
end;

function TArtFormula.GetVar(name : string) : PCalcItem;
var idx : integer;
    p : PArtSubFormula;
begin
 p := pformula;
 idx := FindVar(name);
 if idx = -1 then raise FormulaException.Create(cVariable+' '+name+' '+cDoesNotExists);
 result := @(pformula.Values[idx]);
 pformula := p;
end;

function TArtFormula.IncVar(name : string) : PCalcItem;
var idx : integer;
    p : PArtSubFormula;
begin
 p := pformula;
 idx := FindVar(name);
 if idx = -1 then raise FormulaException.Create(cVariable+' '+name+' '+cDoesNotExists);
 SetN(pformula.Values[idx],getN(pformula.Values[idx],self)+1);
 result := @(pformula.Values[idx]);
 pformula := p;
end;

function TArtFormula.DecVar(name : string) : PCalcItem;
var idx : integer;
    p : PArtSubFormula;
begin
 p := pformula;
 idx := FindVar(name);
 if idx = -1 then raise FormulaException.Create(cVariable+' '+name+' '+cDoesNotExists);
 SetN(pformula.Values[idx],getN(pformula.Values[idx],self)-1);
 result := @(pformula.Values[idx]);
 pformula := p;
end;


function TArtFormula.FindVar(name : string): integer;
var i : integer;
begin
 result := -1;
 for i := 0 to high(pformula.varnames) do
  if fcasesensitive then
  begin
   if pformula.varnames[i] = name then
   begin
    result := i;
    break;
   end
  end
  else
   if uppercase(pformula.varnames[i]) = uppercase(name) then
   begin
    result := i;
    break;
   end;
 if (result = -1) and (pformula <> @formula) then
 begin
 pformula := @formula;
 for i := 0 to high(pformula.varnames) do
  if fcasesensitive then
  begin
   if pformula.varnames[i] = name then
   begin
    result := i;
    break;
   end
  end
  else
   if uppercase(pformula.varnames[i]) = uppercase(name) then
   begin
    result := i;
    break;
   end;
 end; 
end;

procedure TArtFormula.AddVar(name : string; value : PCalcItem);
var idx : integer;
    p : PArtSubFormula;
begin
 p := pformula;
 idx := FindVar(name);
 pformula := p;
 if idx <> -1 then raise FormulaException.Create(cVariable+' '+name+' '+cAlreadyexists);
 idx := high(pformula.varnames) + 1;
 setlength(pformula.varnames,idx+1);
 setlength(pformula.values,idx+1);
 pformula.Values[idx] := value^;
 pformula.varnames[idx] := name;
end;

function TArtFormula.AddModuleFunction(module: PTableItem; name : string; paramcount:integer; fun : pformulafunction; ismodule:boolean;replace:boolean):PTableItem;
var i,k:integer;
begin
 AddUserConstant(name,'',true);
 k := -1;
 for i := 0 to high(module.funs) do
 if uppercase(name) = module.funs[i].name then
  if replace then
  begin
    k := i;
    break;
  end
  else raise FormulaException.Create(cFunction+' "'+name+'" '+cAlreadydefined);
 if k < 0 then
 begin
  k := high(module.funs)+1;
// if i = 255 then raise FormulaException.Create(cToomanyfunctionsdefined);
  setlength(module.funs,k+1);
  new(module.funs[k]);
 end;
 module.funs[k].name := uppercase(name);
 module.funs[k].paramcount := paramcount;
 module.funs[k].fun := fun;
 module.funs[k].module := ismodule;
 result := module.funs[k];
end;

function TArtFormula.AddUserFunction(name : string; paramcount:integer; fun : pformulafunction; defval : PDefArray; ismodule : boolean;replace:boolean):PTableItem;
var i,k:integer;
begin
 AddUserConstant(name,'',true);
 for i := 0 to high(table) do
  if uppercase(name) = table[i].name then
  begin
   if not replace then raise FormulaException.Create(cFunction+' "'+name+'" '+cAlreadydefined);
     table[i].name := uppercase(name);
     table[i].paramcount := paramcount;
     table[i].defvalues := defval;
     table[i].fun := fun;
     table[i].module := ismodule;
     result := @table[i];
     exit;
  end;
 k := -1;
 for i := 0 to high(userfunc) do
  if uppercase(name) = userfunc[i].name then
  if replace then
  begin
    k := i;
    break;
  end
  else raise FormulaException.Create(cUserFunction+' "'+name+'" '+cAlreadyDefined);

 if k < 0 then
 begin
  k := high(userfunc)+1;
 // if i = 255 then raise FormulaException.Create(cToomanyuserfunctionsdefined);
  setlength(userfunc,k+1);
  new(userfunc[k]);
 end;
 userfunc[k].name := uppercase(name);
 userfunc[k].paramcount := paramcount;
 userfunc[k].fun := fun;
 userfunc[k].defvalues := defval;
 userfunc[k].module := ismodule;
 result := userfunc[k];
end;

procedure TArtFormula.AddUserConstant(name,value : string; test : boolean = false);
var i:integer;
begin
 for i := 0 to high(consttable) do
  if uppercase(name) = consttable[i].name then
  begin
   if not fexsyntax or test then
    raise FormulaException.Create(cConstant+' "'+name+'" '+cAlreadydefined)
   else
   begin
    consttable[i].name := uppercase(name);
    consttable[i].value := value;
    exit;
   end;
  end;
 if test then exit;
 
 i := high(consttable)+1;
 setlength(consttable,i+1);
 consttable[i].name := uppercase(name);
 consttable[i].value := value;
end;

function TArtFormula.TestIdent(name : string; testfrwd : boolean = false) : char;
var i:integer;
    s,s1 : string;
begin
  for i := 0 to NUMFUN - 1 do
   if uppercase(tmp) = table[i].name then
   begin
      result := F_FUN;
      data := i;
      exit;
   end;

  for i := 0 to high(userfunc) do
   if uppercase(tmp) = userfunc[i].name then
   begin
      result := F_USERF;
      data := i;
      exit;
   end;

  for i := 0 to pformula.paramcount - 1 do
  begin
   if not fcasesensitive then
   begin
    s := uppercase(pformula.varnames[i]);
    s1 := upperCase(tmp);
   end
   else
   begin
    s1 := tmp;
    s := pformula.varnames[i];
   end;
   if s1 = s then
    begin
      data := i;
      usedvars[i] := true;
      result := F_VAR;
      exit;
    end;
  end;

  if pformula <> @formula then
  for i := 0 to formula.paramcount - 1 do
  begin
   if not fcasesensitive then
   begin
    s := uppercase(formula.varnames[i]);
    s1 := UpperCase(tmp);
   end
   else
   begin
    s := formula.varnames[i];
    s1 := tmp;
   end;
   if s1 = s then
    begin
      data := i;
//      usedvars[i] := true;
      result := F_GLOBAL;
      exit;
    end;
  end;

  for i := 0 to high(fsubformula) do
  begin
   if not fcasesensitive then
   begin
    s := uppercase(fsubformula[i].name);
    s1 := UpperCase(tmp);
   end
   else
   begin
    s := fsubformula[i].name;
    s1 := tmp;
   end;
   if s1 = s then
    begin
      data := i;
      if fsubformula[i].frwd and testfrwd then
      begin
       result := F_FORWARD;
       pformula := @(fsubformula[i]);
      end
      else
       result := F_SUB;
      exit;
    end;
  end;

  result := F_IDENT;

end;

function TArtFormula.Parser(flag:boolean; unq:boolean; getident:boolean): char;
var oldpos,oldspos,oldlines : integer;
function Internal : char;
var s : string;
    i : integer;
    c : char;
begin
 try
  ferror := ER_Ok;
  c := input[pos];
  tmp := '';
  if {$IF Defined(AF_DELPHI2010)}CharInSet(c,{$ELSE}(c in{$IFEND} [' ',#13,#10,#9]) then
  begin
   repeat
    if c = #10 then
    begin
     spos := 1;
     inc(lines);
     soffset := 0;
    end;
    inc(pos);
    inc(spos);
    c := input[pos]
   until not {$IF Defined(AF_DELPHI2010)}CharInSet(c, {$ELSE}(c in {$IFEND}[' ',#13,#10,#9]);
  end;

 if c = '{' then
 begin
  inc(pos);
  inc(spos);
  c := input[pos];
  while (c <> '}') and (c <> #0) do
  begin
   inc(pos);
   inc(spos);
   c := input[pos];
   if c = #10 then
   begin
    spos := 1;
    inc(lines);
   end;
  end;
  while (c = '}') or {$IF Defined(AF_DELPHI2010)}CharInSet(c,{$ELSE}(c in{$IFEND} [' ',#13,#10,#9]) do
  begin
   if c = #10 then
    begin
     spos := 1;
     inc(lines);
    end;
   inc(pos);
   inc(spos);
   c := input[pos];
  end;
 end;

 if (c = '/') and (input[pos+1] = '/') then
 begin
  while not {$IF Defined(AF_DELPHI2010)}CharInSet(c,{$ELSE}(c in{$IFEND} [#10,#0]) do
  begin
   inc(pos);
   c := input[pos];
  end;
  spos := 1;
  inc(lines);
  inc(pos);
  result := Parser(flag, unq, getident);
  exit;
 end;

 if c = #0 then
 begin
  result := F_EOS;
  exit;
 end;

 if (c = '"') or (c = '''') or (c = '#') then
 begin
  while (c = '"') or (c = '''') or (c = '#') do
  begin
   inc(pos);
   inc(spos);
   if (c = '''') or (c = '"') then
   begin
    while input[pos] <> c do
    begin
     tmp := tmp + input[pos];
     inc(pos);
     inc(spos);
     if (input[pos] = c) and (input[pos+1] = c) then
     begin
      tmp := tmp + c;
      inc(pos,2);
      inc(spos,2);
     end;
    end;
    inc(pos);
    inc(spos);
   end
   else
   begin
    s := '';
    while {$IF Defined(AF_DELPHI2010)}CharInSet(input[pos],{$ELSE}(input[pos] in{$IFEND} ['0'..'9']) do
    begin
     s := s + input[pos];
     inc(pos);
     inc(spos);
    end;
    tmp := tmp + chr(strtoint(s));
   end;
   c := input[pos];
  end;
  result := F_STR;
  exit;
 end;

 if system.pos(c,fvarname)>0  then
 begin
  repeat
 {  if not fcasesensitive then
     c := uppercase(c)[1];}
   tmp := tmp + c;
   inc(pos);
   inc(spos);
   c := input[pos];
  until (system.pos(c,fvarname)=0) and not {$IF Defined(AF_DELPHI2010)}CharInSet(c,{$ELSE}(c in{$IFEND} ['0'..'9']);


  if uppercase(tmp) = 'GLOBAL' then
  begin
   result := F_GLOBAL;
   exit;
  end;

  if uppercase(tmp) = 'CONST' then
  begin
   result :=  F_CONST;
   exit;
  end;

  if uppercase(tmp) = 'SUB' then
  begin
   result :=  F_SUB;
   exit;
  end;

  if uppercase(tmp) = 'FORWARD' then
  begin
   result :=  F_FORWARD;
   exit;
  end;

  if uppercase(tmp) = 'XOR' then
  begin
   result :=  F_XOR;
   exit;
  end;

  if uppercase(tmp) = 'BXOR' then
  begin
   result :=  F_BXOR;
   exit;
  end;

  if uppercase(tmp) = 'LIKE' then
  begin
   result :=  F_LIKE;
   exit;
  end;

 if uppercase(tmp) = 'PI' then
  begin
   result :=  F_DATA;
   data := Pi;
   exit;
  end;

  if uppercase(tmp) = 'CONDITION' then
  begin
   result := F_IF;
   exit;
  end;

  if uppercase(tmp) = 'LOOP' then
  begin
   result := F_WHILE;
   exit;
  end;

  if uppercase(tmp) = 'TILL' then
  begin
   result := F_UNTIL;
   exit;
  end;

  if uppercase(tmp) = 'SERIES' then
  begin
   result := F_FOR;
   exit;
  end;

  if uppercase(tmp) = 'RETURN' then
  begin
   result := F_RETURN;
   exit;
  end;

  if not fexsyntax then
  for i := 0 to high(ConstTable) do
  begin
   if uppercase(tmp) = consttable[i].name then
   begin
    input := copy(input,1,pos-1-length(tmp))+ consttable[i].value + copy(input,pos,length(input)-pos+1);
    pos := pos - length(tmp);
    spos := spos - length(tmp);
    soffset := soffset + length(tmp) - length(consttable[i].value);
    offset := offset + length(tmp) - length(consttable[i].value);
    result := Parser(flag,unq,getident);
    exit;
   end;
  end;

  if getident then
  begin
   result := F_IDENT;
   exit;
  end;


  c := TestIdent(tmp);
  if c <> F_IDENT  then
  begin
   result := c;
   exit;
  end;



  if fexgetvar then
  begin
   result := F_GETVAR;
   exit;
  end;

  if funquotedstring or unq then
  begin
   result := F_STR;
   exit;
  end;
  ferror := ER_UNKNOWN;
  dec(pos);
  dec(spos);
  result := #0;
  exit;
 end;

 if c = '$' then
 begin
  inc(pos);
  inc(spos);
  c := input[pos];

  tmp := '$';
  if {$IF Defined(AF_DELPHI2010)}CharInSet(c,{$ELSE}(c in{$IFEND} ['0'..'9']) then
  begin
   tmp := tmp +c;
   inc(pos);
   inc(spos);
   c := input[pos];
   while {$IF Defined(AF_DELPHI2010)}CharInSet(c,{$ELSE}(c in{$IFEND} ['0'..'9','a'..'f','A'..'F']) do
   begin
    tmp := tmp + c;
    inc(pos);
    inc(spos);
    c := input[pos];
   end;
  end;
  if tmp = '$' then
  begin
   result := '$';
   exit;
  end;
  data := strtoint(tmp);
  result := F_DATA;
  exit;
 end;


 if((c>='0')and (c<='9')) or ((c='.') and fnozero) then
 begin
  {if (c='.') and fnozero then
  begin
   dec(pos);
   c := '0';
  end;}
  
  repeat
   tmp := tmp + c;
   inc(pos);
   inc(spos);
   c := input[pos];
  until not((c>='0')and(c<='9'));


  if c = '.' then
  begin
   tmp := tmp + c;
   inc(pos);
   inc(spos);
   c := input[pos];
   while((c>='0')and(c<='9')) do
   begin
    tmp := tmp + c;
    inc(pos);
    inc(spos);
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
  inc(spos);
  c := input[pos];
  if((c = '+')or(c = '-')) then
  begin
   tmp := tmp + c;
   inc(pos);
   inc(spos);
   c := input[pos];
  end;

  while((c>='0')and(c<='9')) do
  begin
    tmp := tmp + c;
    inc(pos);
    inc(spos);
    c := input[pos];
  end;

   data := strtofloat(tmp);
   result := F_DATA;
   exit;

 end;

 if {$IF Defined(AF_DELPHI2010)}CharInSet(c,{$ELSE}(c in{$IFEND} ['%','+','-','[',']','(',')','.','*','/', '^',';',',','!','&','|','@','\']) then
 begin
  inc(pos);
  inc(spos);
  if (c = ';') and (Parser(true) = ')') then
  begin
   c := Parser;
  end;
  if c = ';' then c := ','
  else
  if (c = '+') and (Parser(true) = '+') then
  begin
   Parser();
   c := F_INC;
  end
  else
  if (c = '-') and (Parser(true) = '-') then
  begin
   Parser();
   c := F_DEC;
  end
  else
  if (c = '|') and (Parser(true) = '|') then
  begin
   Parser();
   c := F_BOR;
  end
  else
  if (c = '&') and (Parser(true) = '&') then
  begin
   Parser();
   c := F_BAND;
  end
  else
  if (c = '!') and (Parser(true) = '!') then
  begin
   Parser();
   c := F_BNOT;
  end;


  result := c;
  exit;
 end;



 if c = ':' then
 begin
  inc(pos);
  inc(spos);
  if input[pos] = '=' then
  begin
   inc(pos);
   inc(spos);
   result := F_LET;
   exit;
  end;
  result := #0;
  ferror := ER_SYNTAX;
  exit;
 end;

 if c = '=' then
 begin
  inc(pos);
  inc(spos);
  if input[pos] = '=' then
  begin
   inc(pos);
   inc(spos);
   result := F_LIKE;
   exit;
  end
  else
  result := c;
  exit;
 end;


 if c = '>' then
 begin
  inc(pos);
  inc(spos);
  if input[pos] = '=' then
  begin
   inc(pos);
   inc(spos);
   result := F_GE;
   exit;
  end
  else
  if input[pos] = '>' then
  begin
   inc(pos);
   inc(spos);
   result := F_SHR;
   exit;
  end;
  result := c;
  exit;
 end;

  if c = '<' then
 begin
  inc(pos);
  inc(spos);
  if input[pos] = '=' then
  begin
   inc(pos);
   inc(spos);
   result := F_LE;
   exit;
  end;
  if input[pos] = '<' then
  begin
   inc(pos);
   inc(spos);
   result := F_SHL;
   exit;
  end;
  if input[pos] = '>' then
  begin
   inc(pos);
   inc(spos);
   result := F_NE;
   exit;
  end;
  result := c;
  exit;
 end;

 except
  ferror := ER_SYNTAX;
  result := #0;
  exit;
 end;
 ferror := ER_ILLEGAL;
 result := #0;
 exit;
end;
begin
  oldpos := 0;
  oldspos := 0;
  oldlines := 0;
 if flag then
 begin
  oldpos := pos;
  oldspos := spos;
  oldlines := lines;
 end;
 result := Internal;
 if flag then
 begin
  pos := oldpos;
  spos := oldspos;
  lines := oldlines;
 end;
end;


function TArtFormula.ErrString : string;
begin
 result := err_strings[ferror];
 case ferror of
 ER_ILLEGAL: result := result + ' '''+input[pos]+'''';
 ER_UNKNOWN, ER_IDENT, ER_FORWARD: result := result + ' '''+tmp+'''';
 end;
end;

function TArtFormula.Compile(instr : string; num : integer; vars : PStringArray) : string;
begin
 S.pos := 0;
 C.Clear;
 xlines := 0;
 if not Test(instr, num, vars) then
 begin
  raise FormulaException.Create(ErrString);
 end;
 pformula.fcompiled := temp+F_RETURN;
 result := pformula.fcompiled;
end;


function TArtFormula.ComputeStrN(instr : string; num : integer; vars : PStringArray; vals : PCalcArray) : double;
begin
 Compile(instr, num, vars);
 result := ComputeN(num, vals);
end;

function TArtFormula.ComputeStr(instr : string; num : integer; vars : PStringArray; vals : PCalcArray) : string;
begin
 Compile(instr, num, vars);
 result := Compute(num, vals);
end;

function TArtFormula.Test(instr : string; num : integer; vars : PStringArray) : boolean;
var i:integer;
    ch,p: char;
    fe : boolean;
begin
  ch := decimalseparator;
  decimalseparator := '.';
  pformula.fcompiled := '';
  if num > 0 then
  begin
   setlength(usedvars,num);
   setlength(pformula.varnames,num);
   setlength(pformula.values,num);
   for i:=0 to num-1 do
   begin
    usedvars[i] := false;
    pformula.varnames[i] := vars^[i];
   end;
  end;
  input := instr+#0;
  pos := 1;
  spos := 1;
  lines := 1;
  soffset := 0;
  offset := 0;
  pformula.paramcount := num;
  temp := '';
  AddLine;

 fe := fexsyntax;
 fexsyntax := false;
 p := Form;
 fexsyntax := fe;
 if (p <> F_EOS) and not(fexsyntax and
    ((p = F_GLOBAL) or (p = F_SUB) or (p = F_FORWARD) or (p = F_CONST) or (p=','))) then
 begin
  if ferror = ER_Ok then ferror := ER_SYNTAX;
  result := false;
  decimalseparator := ch;
  exit;
 end;

 while S.Top <> #0 do
 begin
  temp := temp + S.Popex;
 end;

 if ftestused and not fexsyntax then
 for i:=0 to num-1 do
  if usedvars[i] = false then
  begin
   ferror := ER_VARS;
   result := false;
   decimalseparator := ch;
   exit;
  end;

 if length(temp) = 0 then
  result := false
 else
  result := true;
  tc := p;
  decimalseparator := ch;
end;


procedure TArtFormula.CompileProgram(instr : string);
var p, pp:char;
    str, nm : string;
    ca : TCalcItem;
    i : integer;

procedure CompileParams;
begin
      setlength(fsubformula,High(fsubformula)+2);
      pformula := @(fsubformula[high(fsubformula)]);
      pformula.name := tmp;
      pformula.frwd := false;
      pformula.paramcount := 0;
      pformula.defvalues := nil;
      if Parser(true) = '(' then
      begin
        parser;
        p := parser(false,false,true);
        while p <> ')' do
        begin
          if p = F_IDENT then
          begin

            if TestIdent(tmp) <> F_ident then
            begin
             ferror := ER_IDENT;
             raise FormulaException.Create(ErrString);
            end;

           inc(pformula.paramcount);
           if pformula.defvalues = nil then New(pformula.defvalues);
           setlength(pformula.varnames,pformula.paramcount);
           pformula.varnames[pformula.paramcount-1] := tmp;
           pformula.defvalues[pformula.paramcount-1].typ := fdtgetvar;
           if Parser(true) = '=' then
           begin
             Parser;
             p := Parser;
             if p = F_DATA then
             begin
              pformula.defvalues[pformula.paramcount-1].typ := fdtnumber;
              pformula.defvalues[pformula.paramcount-1].data := data;
             end
             else if p = F_STR then
             begin
              pformula.defvalues[pformula.paramcount-1].typ := fdtstring;
              pformula.defvalues[pformula.paramcount-1].str := tmp;
             end
             else
             begin
               ferror := ER_SYNTAX;
               raise FormulaException.Create(ErrString);
             end;

           end;

           if Parser(true) = ',' then Parser;
          end
          else
          begin
           ferror := ER_SYNTAX;
           raise FormulaException.Create(ErrString);
          end;
          p := parser(false,false,true);
        end;
      end;
end;

begin

 xoffset := 0;
 xsoffset := 0;
 xlines := 0;

 pos := 1;
 spos := 1;
 lines := 1;
 soffset := 0;
 offset := 0;

 input := instr+#0;
 p := parser;


 for I := 0 to high(fsubformula) do
 begin
  fsubformula[i].varnames := nil;
  fsubformula[i].values := nil;
  if fsubformula[i].defvalues <> nil then
    dispose(fsubformula[i].defvalues);
 end;

 fsubformula := nil;

 formula.paramcount := 0;
 formula.varnames := nil;
 formula.values := nil;
 if formula.defvalues <> nil then
  dispose(formula.defvalues);
 pformula := @formula;

 try
  while p <> F_EOS do
  begin
    case p of
     F_FORWARD:
     begin
      if Parser(true) = F_SUB then Parser;
      if Parser(false,false,true) <> F_IDENT then
      begin
       ferror := ER_SYNTAX;
       raise FormulaException.Create(ErrString);
      end;
      if TestIdent(tmp,true) <> F_ident then
      begin
       ferror := ER_IDENT;
       raise FormulaException.Create(ErrString);
      end;
      CompileParams;
      pformula.frwd := true;
      pformula := @formula;
      p := Parser();
      if p = ',' then p := Parser();
     end;
     F_SUB:
     begin
      if Parser(false,false,true) <> F_IDENT then
      begin
       ferror := ER_SYNTAX;
       raise FormulaException.Create(ErrString);
      end;

      pp := TestIdent(tmp,true);
      if pp = F_IDENT then
      begin
       CompileParams;
      end
      else
      if pp <> F_FORWARD then
      begin
       ferror := ER_IDENT;
       raise FormulaException.Create(ErrString);
      end
      else
      begin
        pformula.frwd := false;
        if Parser(true) = '(' then
        begin
         parser;
         if parser(false,false,true) <> ')' then
         begin
           ferror := ER_SYNTAX;
           raise FormulaException.Create(ErrString);
         end;
        end;
      end;

      S.pos := 0;
      C.Clear;
      fexsyntax := true;
      xoffset := GetPos;
      xsoffset := GetSPos;
      str := copy(instr,xoffset,length(instr)-xoffset+1);
      xlines := lines-1;
      if not Test(str, pformula.paramcount, @(pformula.varnames)) then
      begin
        raise FormulaException.Create(ErrString);
      end;
      lines := lines + xlines;
      xlines := 0;
      fexsyntax := false;
      pformula.fcompiled := temp+F_RETURN;
      p := tc;
      pformula := @formula;
      if p = ',' then p := Parser();
      
     end;

     F_CONST:
     begin
       pformula := @formula;
       fexsyntax := true;
       p := Parser(false,false,true);
       while p = F_IDENT do
       begin

        if TestIdent(tmp) <> F_ident then
        begin
         ferror := ER_IDENT;
         raise FormulaException.Create(ErrString);
        end;

        nm := tmp;
        if parser <> '=' then
        begin
         ferror := ER_SYNTAX;
         raise FormulaException.Create(ErrString);
        end;
        str := '';
        while not ({$IF Defined(AF_DELPHI2010)}CharInSet(input[pos],{$ELSE}(input[pos] in{$IFEND} [#13,#10,#9])) do
        begin
         str := str+input[pos];
         inc(pos);
        end;
        if (str ='') {or (str[length(str)]<>';')} then
        begin
         ferror := ER_SYNTAX;
         raise FormulaException.Create(ErrString);
        end;

        AddUserConstant(nm,{copy(}str{,1,length(str)-1)});

        p := Parser(false,false,true);
       end;
       fexsyntax := false;
     end;

     F_GLOBAL:
     begin
       pformula := @formula;
       p := Parser(false,false,true);
       while p = F_IDENT do
       begin

        if TestIdent(tmp) <> F_ident then
        begin
         ferror := ER_IDENT;
         raise FormulaException.Create(ErrString);
        end;

         nm := tmp;
         if Parser(true) = '=' then
         begin
           Parser();
           p := Parser;
           if (p = F_DATA) or (p = F_STR) then
           begin
            if p = F_data then
            begin
              ca.typ := fdtnumber;
              ca.data := data;
            end
            else
            begin
              ca.typ := fdtstring;
              ca.str := tmp;
            end;
            pformula := @formula;
            AddVar(nm,@ca);
            inc(formula.paramcount)
           end
           else
           begin
            ferror := ER_SYNTAX;
            raise FormulaException.Create(ErrString);
           end;
         end
         else
         begin
           ca.typ := fdtnumber;
           ca.data := 0;
           pformula := @formula;
           AddVar(nm,@ca);
           inc(formula.paramcount)
         end;
         p := parser;
         if p <> ',' then break;
         p := parser(false,false,true);
       end;
     end

     else
     begin
      ferror := ER_SYNTAX;
      raise FormulaException.Create(ErrString);
     end;
    end;

  end;

  for i := 0 to High(fsubformula) do
    if fsubformula[i].frwd then
    begin
      tmp := fsubformula[i].name;
      ferror := ER_FORWARD;
      raise FormulaException.Create(ErrString);
    end;


 finally
  fexsyntax := false;
  pformula := @formula;
 end;
end;

function TArtFormula.Form:char;
var p : char;
{    u : ^double;
    pi : pinteger;}
    cnt,ps,ps1,ps2,idx:integer;
    module : boolean;
    func : ATableItem;
    fnc : pformulafunction;

function CompileFunction(defvalues : pDefArray = nil; x : integer = 0; idxf : string = '') : char;
var i,pcnt:integer;
    str : string;
    dv : PDefArray;
    needp : boolean;
begin
   p := Parser;
   pcnt := 0;
   if not (module and (p = '.')) then
   begin
    pcnt := cnt;
    if cnt = 0 then
    begin
     if p = '(' then
     begin
      if Parser <> ')' then
      begin
       if ferror = ER_OK then ferror := ER_RIGHT;
       result := #0;
       exit;
      end;
      p := Parser;
     end;
     {if @fnc = nil then
     begin
       ferror := ER_SYNTAX;
       result := #0;
       exit;
     end;}
     temp := temp + idxf + S.PopEx;
     if p <> '.' then
     begin
      result := p;
      exit;
     end;
    end
    else
    begin
     if(p <> '(') then
     begin
      if ferror = ER_OK then ferror := ER_LEFT;
      result := #0;
      exit;
     end;
     S.Push('(');
     if cnt > 0 then
     begin
     needp := true;
     for i := 1 to cnt do
     begin
      S.Push(',');

      if (p=',') and (Parser(true)=')') then needp := true;
      if p <> ')' then p := Parser(true);
      if (p=',') or (p=')') then
      begin

       if (defvalues <> nil) and (High(defvalues^) >= (i-1)) then
       begin
        if defvalues^[i-1].typ = fdtgetvar then
        begin
         ferror := ER_NOTENOUGH;
         result := #0;
         exit;
        end
        else if defvalues^[i-1].typ = fdtnumber then
        begin
         temp := temp + F_DATA;
         temp := temp + stringofchar(#0,sizeof(double) div sizeof(char));
         storedbl (@(temp[length(temp)-sizeof(double) div sizeof(char)+1]), defvalues^[i-1].data);
        end
        else
        begin
         temp := temp + F_STR;
         temp := temp + stringofchar(#0,sizeof(integer) div sizeof(char));
         storeint(@(temp[length(temp)-sizeof(integer) div sizeof(char)+1]),length(defvalues^[i-1].str));
         temp := temp+defvalues^[i-1].str;
        end;
       end
       else
       begin

        ferror := ER_NOTENOUGH;
        result := #0;
        exit;

       // !!!!!!!!!!!!
       (*
        temp := temp + F_STR;
        temp := temp + stringofchar(#0,sizeof(integer) div sizeof(char));
       {pi := @(temp[length(temp)-sizeof(integer) div sizeof(char)+1]);
        pi^ := length(tmp);}
        storeint(@(temp[length(temp)-sizeof(integer) div sizeof(char)+1]),length(''));
        temp := temp+'';
        *)
       end;
       AddLine;
       if (p <> ')') then p := Parser;
      end
      else
      begin
       p := Form;
       needp := false;
      end;

      if p = #0 then
      begin
       result := #0;
       exit;
      end;
      while(S.Top <> ',') do
      begin
       temp := temp + S.Popex;
      end;
      if (p <> ',') and (p <> ')') and (i<cnt) then
      begin
       if ferror = ER_OK then ferror := ER_NOTENOUGH;
       result := #0;
       exit;
      end;
      S.Pop;
     end;
      if needp then p := Parser;
      
     end
     else if cnt = -1 then
     begin
      p := Parser(true);
      cnt := 0;
      while p <> ')' do
      begin
       inc(cnt);
       S.Push(',');
       if p <> ')' then p := Parser(true);
       if (p=',') or (p=')') then
        begin


       if (defvalues <> nil) and (High(defvalues^) >= (i-1)) then
       begin
        if defvalues^[i-1].typ = fdtgetvar then
        begin
         ferror := ER_NOTENOUGH;
         result := #0;
         exit;
        end
        else if defvalues^[i-1].typ = fdtnumber then
        begin
         temp := temp + F_DATA;
         temp := temp + stringofchar(#0,sizeof(double) div sizeof(char));
         storedbl (@(temp[length(temp)-sizeof(double) div sizeof(char)+1]), defvalues^[i-1].data);
        end
        else
        begin
         temp := temp + F_STR;
         temp := temp + stringofchar(#0,sizeof(integer) div sizeof(char));
         storeint(@(temp[length(temp)-sizeof(integer) div sizeof(char)+1]),length(defvalues^[i-1].str));
         temp := temp+defvalues^[i-1].str;
        end;
       end
       else
       begin

        ferror := ER_NOTENOUGH;
        result := #0;
        exit;


         (*
         temp := temp + F_STR;
         temp := temp + stringofchar(#0,sizeof(integer) div sizeof(char));
        {pi := @(temp[length(temp)-sizeof(integer) div sizeof(char)+1]);
         pi^ := length(tmp);}
         storeint(@(temp[length(temp)-sizeof(integer) div sizeof(char)+1]),length(''));
         temp := temp + '';*)
        end;
         AddLine;
         if p <> ')' then p := Parser;
        end
        else
         p := Form;
       if p = #0 then
       begin
        result := #0;
        exit;
       end;
       while(S.Top <> ',') do
       begin
        temp := temp + S.Popex;
       end;
       S.Pop;
       if (p <>',') and (p <> ')') then
       begin
        result := #0;
        exit;
       end;
      end;
      temp := temp + F_DATA;
      temp := temp + stringofchar(#0,sizeof(double) div sizeof(char));
{      u := @(temp[length(temp)-sizeof(double) div sizeof(char)+1]);
      u^ := cnt;}
      storedbl (@(temp[length(temp)-sizeof(double) div sizeof(char)+1]), cnt);
      pcnt := cnt;
      AddLine;

     end
     else p := Parser;

     if cnt = 0 then p := Parser;

     if p <> ')' then
     begin
       if ferror = ER_OK then ferror := ER_RIGHT;
      result := #0;
      exit;
     end;
     while(S.Top <> '(') do
     begin
      temp := temp + S.Popex;
     end;
     S.Pop;
     temp := temp + idxf + S.PopEx;
     p := Parser;
     if p <> '.' then
     begin
      result := p;
      exit;
     end;
    end
   end
   else
   begin
    S.PopEx;
    temp := temp;// + F_DATA + stringofchar(#0,sizeof(double) div sizeof(char));
   end;

   p := Parser(false,false,true);
   if p <> F_IDENT then
   begin
       if ferror = ER_OK then ferror := ER_SYNTAX;
       result := #0;
       exit;
   end;
   if func = nil then
   begin
       ferror := ER_UNKNOWN;
       result := #0;
       exit;
   end;

   str := tmp;
   p := Parser(true);
   tmp := str;
   if p = F_LET then
    str := 'set'+str;

   for i := 0 to high(func) do
   begin
    if UpperCase(str) = func[i].name then
    begin
     cnt := func[i].paramcount;
     S.Push(chr(cnt));
     S.Push(char(pcnt));
     S.Push(chr(i));
     S.Push(char(F_MFUN));
     if idxf = '' then
        idxf := F_IDXF + chr(x)
     else
        idxf := idxf + F_IDXF1 + chr(x);
     case p of
      F_LET:
      begin
       Parser;
       if cnt <> 1 then
       begin
        ferror := ER_SYNTAX;
        result := #0;
        exit;
       end;

       S.Push('(');

       result := Form;

       while(S.Top <> '(') do
       begin
        temp := temp + S.Popex;
       end;
       S.Pop;
       if result <> #0 then
        temp := temp + idxf + S.PopEx;
      end;
      '(', '.':
      begin
       module := func[i].module;
       fnc := func[i].fun;
       dv := func[i].defvalues;
       func := ATableItem(func[i].funs);
       result := CompileFunction(dv, i, idxf)
      end;
      else
      begin
       if cnt <> 0 then
       begin
        ferror := ER_SYNTAX;
        result := #0;
        exit;
       end;
       temp := temp + idxf + S.PopEx;
       result := Parser;
      end;
     end;
     exit;
    end;
   end;

   ferror := ER_UNKNOWN;
   result := #0;
end;

begin
  p := Parser;
  if p = F_EOS then
  begin
   result := #0;
   exit;
  end;

   if p = '+' then p := Parser;

   case p of
   '-':
   begin
     S.Push(F_UMINUS);
     p := Form;
   end;
// Not
   '!',F_BNOT:
   begin
     S.Push(char(p));
     p := Form;
   end;
// SET or VAL
   '$':
   begin
    p := Parser(false,true);
    if (p = F_VAR) or (p = F_STR) or (p = F_GETVAR) or (p = F_GLOBAL) then
    begin
     temp := temp + F_STR;
     temp := temp + stringofchar(#0,sizeof(integer) div sizeof(char));
{     pi := @(temp[length(temp)-sizeof(integer) div sizeof(char)+1]);
     pi^ := length(tmp);}

     storeint (@(temp[length(temp)-sizeof(integer) div sizeof(char)+1]), length(tmp));
     temp := temp + tmp;
     AddLine;

     p := Parser(true);

     if p = '[' then
     begin
      Parser;
      S.Push('(');
      p := Form;
      while(S.Top()<>'(') do
      begin
       temp := temp + S.Popex;
      end;
      S.Pop;

      while p <> ']' do
      begin
       if p <> ',' then
       begin
       if ferror = ER_OK then ferror := ER_SYNTAX;
        result := #0;
        exit;
       end;
       temp := temp + '@' + F_STR + stringofchar(#0,sizeof(integer) div sizeof(char)) + '_@';
{      pi := @(temp[ length(temp)-sizeof(integer) div sizeof(char)-1]);
      pi^ := 1;}
      storeint (@(temp[ length(temp)-sizeof(integer) div sizeof(char)-1]), 1);
      AddLine;

      S.Push('(');
       p := Form;
       while(S.Top()<>'(') do
       begin
         temp := temp + S.Popex;
       end;
       S.Pop;
      end;

      temp := temp + '@';
      AddLine;
     end
    end
    else
    if p = '(' then
    begin
      S.Push('(');
      p := Form;
      while(S.Top()<>'(') do
      begin
       temp := temp + S.Popex;
      end;
      S.Pop;
      if p <> ')' then
      begin
       if ferror = ER_OK then ferror := ER_RIGHT;
       result := #0;
       exit;
      end;
    end
    else
    begin
       if ferror = ER_OK then ferror := ER_SYNTAX;
      result := #0;
      exit;
    end;

     p := Parser;
     case p of
     F_LET:
     begin
      S.Push('(');
      p := Form;
      while(S.Top()<>'(') do
      begin
       temp := temp + S.Popex;
      end;
      S.Pop;
      temp := temp + F_FUN + chr(IDX_SET) + #2;
      AddLine;
     end;
     F_INC:
     begin
      temp := temp + F_FUN + chr(IDX_INC) + #1;
      AddLine;
      p := Parser;
     end;
     F_DEC:
     begin
      temp := temp + F_FUN + chr(IDX_DEC) + #1;
      AddLine;
      p := Parser;
     end;
     else
     begin
      temp := temp + F_FUN + chr(IDX_VAL) + #1;
      AddLine;
     end;
    end;
   end;
// RETURN
   F_RETURN:
   begin
    if(Parser <> '(') then
    begin
     if ferror = ER_OK then  ferror := ER_LEFT;
     result := #0;
     exit;
    end;
    S.Push('(');
    p := Form;
    while(S.Top()<>'(') do
    begin
     temp := temp + S.Popex;
    end;
    S.Pop;
    if p <> ')' then
    begin
     if ferror = ER_OK then ferror := ER_RIGHT;
     result := #0;
     exit;
    end;
    temp := temp + F_RETURN;
    p := Parser;
   end;
// WHILE
   F_WHILE:
   begin
    if(Parser <> '(') then
    begin
     if ferror = ER_OK then  ferror := ER_LEFT;
     result := #0;
     exit;
    end;
    temp := temp + F_DATA;
    temp := temp + stringofchar(#0,sizeof(double) div sizeof(char));
{    u := @(temp[length(temp)-sizeof(double) div sizeof(char)+1]);
    u^ := -1.0;}
    storedbl (@(temp[length(temp)-sizeof(double) div sizeof(char)+1]), -1.0);

    ps1 := length(temp);
    temp := temp + F_DATA;
    temp := temp + stringofchar(#0,sizeof(double) div sizeof(char));
{    u := @(temp[length(temp)-sizeof(double) div sizeof(char)+1]);
    u^ := 1.0;}
    storedbl (@(temp[length(temp)-sizeof(double) div sizeof(char)+1]), 1.0);
    temp := temp + '+';

    S.Push('(');
    p := Form;
    while(S.Top()<>'(') do
    begin
     temp := temp + S.Popex;
    end;
    S.Pop;
    temp := temp + F_IF;
    temp := temp + stringofchar(#0,sizeof(integer) div sizeof(char));
    ps := length(temp)-sizeof(integer) div sizeof(char) +1;
    AddLine;
    if p <> ',' then
    begin
     if ferror = ER_OK then  ferror := ER_NOTENOUGH;
     result := #0;
     exit;
    end;
    S.Push(',');
    p := Form;
    while(S.Top()<>',') do
    begin
     temp := temp + S.Popex;
    end;
    S.Pop;
    temp := temp + F_POP + F_GO;
    temp := temp + stringofchar(#0,sizeof(integer) div sizeof(char));
{    pi := @(temp[ length(temp)-sizeof(integer) div sizeof(char)+1]);
    pi^ := ps1;}
    storeint(@(temp[ length(temp)-sizeof(integer) div sizeof(char)+1]),ps1);
{    pi := @(temp[ps]);
    pi^ := length(temp);}
    storeint(@(temp[ps]),length(temp));
    AddLine;
    if p <> ')' then
    begin
     if ferror = ER_OK then ferror := ER_RIGHT;
     result := #0;
     exit;
    end;
    p := Parser;
   end;

// FOR
   F_FOR:
   begin
    if(Parser <> '(') then
    begin
       if ferror = ER_OK then ferror := ER_LEFT;
     result := #0;
     exit;
    end;

    S.Push('(');
    p := Form;
    while(S.Top()<>'(') do
    begin
     temp := temp + S.Popex;
    end;
    S.Pop;

    temp := temp + F_POP + F_DATA;
    temp := temp + stringofchar(#0,sizeof(double) div sizeof(char));
{    u := @(temp[length(temp)-sizeof(double) div sizeof(char)+1]);
    u^ := -1.0;}
    storedbl(@(temp[length(temp)-sizeof(double) div sizeof(char)+1]),-1.0);
    ps1 := length(temp);
    temp := temp + F_DATA;
    temp := temp + stringofchar(#0,sizeof(double) div sizeof(char));
{    u := @(temp[length(temp)-sizeof(double) div sizeof(char)+1]);
    u^ := 1.0;}
    storedbl(@(temp[length(temp)-sizeof(double) div sizeof(char)+1]),1.0);
    temp := temp + '+';
    AddLine;

    if p <> ',' then
    begin
     if ferror = ER_OK then ferror := ER_NOTENOUGH;
     result := #0;
     exit;
    end;
    S.Push(',');
    p := Form;
    while(S.Top()<>',') do
    begin
     temp := temp + S.Popex;
    end;
    S.Pop;
    temp := temp + F_IF + stringofchar(#0,sizeof(integer) div sizeof(char));
    ps := length(temp)-sizeof(integer)div sizeof(char)+1;

    temp := temp + F_GO + stringofchar(#0,sizeof(integer) div sizeof(char));
    ps2 := length(temp)-sizeof(integer) div sizeof(char)+1;
    AddLine;

    if p <> ',' then
    begin
     if ferror = ER_OK then ferror := ER_NOTENOUGH;
     result := #0;
     exit;
    end;
    S.Push(',');
    p := Form;
    while(S.Top()<>',') do
    begin
     temp := temp + S.Popex;
    end;
    S.Pop;
    temp := temp + F_POP + F_GO + stringofchar(#0,sizeof(integer) div sizeof(char));
{    pi := @(temp[ length(temp)-sizeof(integer) div sizeof(char)+1]);
    pi^ := ps1;}
    storeint(@(temp[ length(temp)-sizeof(integer) div sizeof(char)+1]),ps1);
{    pi := @(temp[ps2]);
    pi^ := length(temp);}
    storeint(@(temp[ps2]),length(temp));
    AddLine;
    if p <> ',' then
    begin
     if ferror = ER_OK then ferror := ER_NOTENOUGH;
     result := #0;
     exit;
    end;
    S.Push(',');
    p := Form;
    while(S.Top()<>',') do
    begin
     temp := temp + S.Popex;
    end;
    S.Pop;
    temp := temp + F_POP + F_GO + stringofchar(#0,sizeof(integer) div sizeof(char));
{    pi := @(temp[ length(temp)-sizeof(integer) div sizeof(char)+1]);
    pi^ := ps2 + sizeof(integer) div sizeof(char)-1;}
    storeint(@(temp[ length(temp)-sizeof(integer) div sizeof(char)+1]),ps2 + sizeof(integer) div sizeof(char)-1);

{    pi := @(temp[ps]);
    pi^ := length(temp);}
    storeint(@(temp[ps]),length(temp));
    AddLine;

    if p <> ')' then
    begin
     if ferror = ER_OK then ferror := ER_RIGHT;
     result := #0;
     exit;
    end;
    p := Parser;
   end;

// UNTILL
   F_UNTIL:
   begin
    if(Parser <> '(') then
    begin
     if ferror = ER_OK then ferror := ER_LEFT;
     result := #0;
     exit;
    end;
    temp := temp + F_DATA;
    temp := temp + stringofchar(#0,sizeof(double) div sizeof(char));
{    u := @(temp[length(temp)-sizeof(double) div sizeof(char)+1]);
    u^ := 0;}
    storedbl(@(temp[length(temp)-sizeof(double) div sizeof(char)+1]),0);
    ps1 := length(temp);
    temp := temp + F_DATA;
    temp := temp + stringofchar(#0,sizeof(double) div sizeof(char));
{    u := @(temp[length(temp)-sizeof(double) div sizeof(char)+1]);
    u^ := 1.0;}
    storedbl(@(temp[length(temp)-sizeof(double) div sizeof(char)+1]),1.0);
    temp := temp + '+';
    AddLine;

    S.Push('(');
    p := Form;
    while(S.Top()<>'(') do
    begin
     temp := temp + S.Popex;
    end;
    S.Pop;
    temp := temp + F_POP;
    AddLine;
    if p <> ',' then
    begin
     if ferror = ER_OK then ferror := ER_NOTENOUGH;
     result := #0;
     exit;
    end;
    S.Push(',');
    p := Form;
    while(S.Top()<>',') do
    begin
     temp := temp + S.Popex;
    end;
    S.Pop;

    temp := temp + F_IF;
    temp := temp + stringofchar(#0,sizeof(integer) div sizeof(char));
{    pi := @(temp[ length(temp)-sizeof(integer) div sizeof(char)+1]);
    pi^ := ps1;}
    storeint(@(temp[ length(temp)-sizeof(integer) div sizeof(char)+1]),ps1);
    AddLine;

    if p <> ')' then
    begin
     if ferror = ER_OK then ferror := ER_RIGHT;
     result := #0;
     exit;
    end;
    p := Parser;
   end;

// IF
   F_IF:
   begin
    if(Parser <> '(') then
    begin
     if ferror = ER_OK then ferror := ER_LEFT;
     result := #0;
     exit;
     end;
    S.Push('(');
    p := Form;
    while(S.Top()<>'(') do
    begin
     temp := temp + S.Popex;
    end;
    S.Pop;
    if p <> ',' then
    begin
     if ferror = ER_OK then ferror := ER_NOTENOUGH;
     result := #0;
     exit;
    end;
    temp := temp + F_IF;
    temp := temp + stringofchar(#0,sizeof(integer) div sizeof(char));
    ps := length(temp)-sizeof(integer) div sizeof(char)+1;
    AddLine;

    S.Push(',');
    p := Form;
    while(S.Top()<>',') do
    begin
     temp := temp + S.Popex;
    end;
    S.Pop;
    if p <> ',' then
    begin
     result := #0;
     if ferror = ER_OK then ferror := ER_NOTENOUGH;
     exit;
    end;
    temp := temp + F_GO;
    temp := temp + stringofchar(#0,sizeof(integer) div sizeof(char));
{    pi := @(temp[ps]);
    pi^ := length(temp);}
    storeint(@(temp[ps]),length(temp));
    ps := length(temp)-sizeof(integer) div sizeof(char)+1;
    AddLine;
    S.Push(',');
    p := Form;
    while(S.Top()<>',') do
    begin
     temp := temp + S.Popex;
    end;
    S.Pop;
    if p <> ')' then
    begin
     if ferror = ER_OK then ferror := ER_RIGHT;
     result := #0;
     exit;
    end;
{    pi := @(temp[ps]);
    pi^ := length(temp);}
    storeint(@(temp[ps]),length(temp));
    p := Parser;
   end;
// (...)
   '(':
   begin
     S.Push('(');
     p := Form;
     if p = #0 then
     begin
      result := #0;
      exit;
     end;
     if(p <> ')') then
     begin
      if ferror = ER_OK then ferror := ER_RIGHT;
      result := #0;
      exit;
     end;
     while(S.Top()<>'(') do
     begin
      temp := temp + S.Popex;
     end;
     S.Pop;
     if {$IF Defined(AF_DELPHI2010)}CharInSet(S.Top,{$ELSE}(S.Top in{$IFEND} [F_FUN, F_USERF]) then
     begin
      temp := temp + S.Pop + S.Pop + S.Top;
     end;
     if S.Top = F_MFUN then
     begin
      temp := temp + S.Pop + S.Pop + S.Pop + S.Top;
     end;
     p := Parser;
    end;
// FUNCTION
   F_FUN:
    begin
     Addline;
     idx := trunc(data);
     cnt := table[idx].paramcount;
//     if cnt = -1 then cnt = 255;

     S.Push(chr(cnt));
     S.Push(char(idx));
     S.Push(F_FUN);
     module := table[idx].module;
     func := nil;
     fnc := table[idx].fun;
     p := CompileFunction(table[idx].defvalues);
     if p = #0 then
     begin
      result := #0;
      exit;
     end;
    end;
// SUB
   F_SUB:
    begin
     Addline;
     idx := trunc(data);
     cnt := fsubformula[idx].paramcount;
     S.Push(chr(cnt));
     S.Push(char(idx));
     S.Push(F_SUB);
     module := false;
     func := nil;
     fnc := nil;
     p := CompileFunction(fsubformula[idx].defvalues);
     if p = #0 then
     begin
      result := #0;
      exit;
     end;
    end;

// USER FUNCTION
   F_USERF:
    begin
     Addline;
     idx := trunc(data);
     cnt := userfunc[idx].paramcount;
     S.Push(char(cnt));
     S.Push(char(idx));
     S.Push(F_USERF);
     module := userfunc[idx].module;
     func := ATableItem(userfunc[idx].funs);
     fnc := userfunc[idx].fun;
     p := CompileFunction(userfunc[idx].defvalues, idx);
     if p = #0 then
     begin
      result := #0;
      exit;
     end;
    end;
// VAR
   F_VAR, F_GLOBAL:
    begin
     temp := temp + p;
     temp := temp + chr(trunc(data));
     AddLine;

     p := Parser;
    end;
// GETVAR
   F_GETVAR:
   begin
    temp := temp + p;
    temp := temp + stringofchar(#0,sizeof(integer) div sizeof(char));
{    pi := @(temp[length(temp)-sizeof(integer) div sizeof(char)+1]);
    pi^ := length(tmp);}
    storeint(@(temp[length(temp)-sizeof(integer) div sizeof(char)+1]),length(tmp));
    temp := temp + tmp;
    AddLine;
    p := Parser;
   end;
// DATA
   F_DATA:
    begin
     temp := temp + p;
     temp := temp + stringofchar(#0,sizeof(double) div sizeof(char));
{     u := @(temp[length(temp)-sizeof(double) div sizeof(char)+1]);
     u^ := data;}
     storedbl(@(temp[length(temp)-sizeof(double) div sizeof(char)+1]), data);
     AddLine;
     p := Parser;
    end;
// STR
   F_STR:
    begin
     temp := temp + p;
     temp := temp + stringofchar(#0,sizeof(integer) div sizeof(char));
{     pi := @(temp[length(temp)-sizeof(integer) div sizeof(char)+1]);
     pi^ := length(tmp);}
     storeint(@(temp[length(temp)-sizeof(integer) div sizeof(char)+1]),length(tmp));
     temp := temp + tmp;
     AddLine;
     p := Parser;
    end
   else
   begin
    result := #0;
    exit;
   end;
  end;

     if p = F_EOS then
     begin
      result :=  F_EOS;
      exit;
     end;
     if not isznak(p) then
     begin
       result := p;
       exit;
     end;

     while prior(p,S.Top) do temp := temp + S.Popex;
     S.Push(p);
     p := Form;
     if p = #0 then
     begin
       result := #0;
       exit;
     end
     else
     begin
      result := p;
      exit;
     end;
end;

procedure TArtFormula.IntCompute(compiled : string; num : integer; vals : PCalcArray);
var i,j,idx,cnt,l:integer;
    funs : ATableItem;
    xval : TCalcArray;
    p : PArtSubFormula;
    cpos : integer;
procedure Step;
var j:integer;
begin
  case compiled[i] of
      '+': C.Plus;
      '-': C.Minus;
      '*': C.Mult;
      '/': C.Division;
      '%': C.cMod;
      '^': C.Pow;
      '\': C.cDiv;
      '&': C.cAnd;
      '|': C.cOr;
      F_XOR: C.cXOR;
      F_BXOR: C.bXOR;
      F_BOR: C.bOR;
      F_BAND: C.bAND;
      F_SHL: C.bSHL;
      F_SHR: C.bSHR;
      '@': C.PlusS;
      F_NE : C.NE;
      '=' : C.EQ;
      '<' : C.LT;
      F_LE : C.LE;
      '>' : C.GT;
      F_GE : C.GE;
      F_LIKE:C.Like;
      F_UMINUS: C.Uminus;
      '!': C.cNot;
      F_BNOT: C.bNOT;
      F_SUB:
        begin
         inc(i);
         idx := ord(compiled[i]);
         inc(i);
         cnt := ord(compiled[i]);
         p := pformula;
         pformula := @fsubformula[idx];
         setlength(xval,cnt);
         for j := 0 to cnt - 1 do
           xval[j] := (c.Item(cnt-1-j))^;
         c.pos := c.pos-cnt;
         IntCompute(pformula.fcompiled,cnt,@xval);
         pformula:= p;
        end;
      F_FUN:
        begin
         inc(i);
         idx := ord(compiled[i]);
         inc(i);
         fModulename := '';
         C.DoFunction(table[idx], ord(compiled[i]));
        end;
      F_USERF:
        begin
         inc(i);
         idx := ord(compiled[i]);
         inc(i);
         fModulename := '';
         C.DoFunction(userfunc[idx]^, ord(compiled[i]))
        end;
      F_MFUN:
        begin
         inc(i);
         idx := ord(compiled[i]);
         inc(i);
         cnt := ord(compiled[i]);
         inc(i);
         C.DoFunction(funs[idx]^, ord(compiled[i]), true, cnt)
        end;
      F_VAR:
       begin
          inc(i);
          C.Push(pformula.values[ord(compiled[i])]);
       end;
      F_GLOBAL:
       begin
          inc(i);
          C.Push(formula.values[ord(compiled[i])]);
       end;
      F_DATA:
       begin
//         C.PushN((pdouble(@(compiled[i+1])))^);
         C.PushN((getdbl(@(compiled[i+1]))));
         inc(i,sizeof(double) div sizeof(char));
       end;
      F_GETVAR:
       begin
//        idx := (pinteger(@(compiled[i+1])))^;
        idx := getint(@(compiled[i+1]));
        inc(i, sizeof(integer) div sizeof(char));
        C.PushS(copy(compiled,i+1,idx));
        C.Item(0).typ := fdtgetvar;
        inc(i, idx);
       end;
      F_STR:
       begin
//         idx := (pinteger(@(compiled[i+1])))^;
         idx := getint(@(compiled[i+1]));
         inc(i, sizeof(integer) div sizeof(char));
         C.PushS(copy(compiled,i+1,idx));
         inc(i, idx);
       end;
      F_GO:
       begin
//         i := (pinteger(@(compiled[i+1])))^;
         i := getint(@(compiled[i+1]));
       end;
      F_IF:
       begin
         if C.PopN = 0 then
         begin
//          i := (pinteger(@(compiled[i+1])))^;
          i := getint(@(compiled[i+1]));
         end
         else inc(i, sizeof(integer) div sizeof(char));
       end;
      F_POP: dec(C.pos);
      F_LINE:
      begin
        idx := getint(@(compiled[i+1]));
        inc(i, sizeof(integer) div sizeof(char));
        lines := idx;
      end;

      F_IDXF:
      begin
       inc(i);
       fModulename := userfunc[ord(compiled[i])].name;
       funs := ATableItem(userfunc[ord(compiled[i])].funs);
      end;
      F_IDXF1:
      begin
       inc(i);
       if fModulename = '' then
         fModulename := funs[ord(compiled[i])].name
       else
         fModulename := fModulename + '.' + funs[ord(compiled[i])].name;
       funs := ATableItem(funs[ord(compiled[i])].funs);
      end;
      F_RETURN:
      begin
       i := l+1;
      end;
      else raise FormulaException.Create(cWrongbytecode);
     end;
end;
begin
 xlines := 0;
 lines := 1;
 fModulename := '';
 setlength(pformula.varnames, pformula.paramcount);
 setlength(pformula.values, pformula.paramcount);
 for i:=1 to num do pformula.values[i-1] := vals^[i-1];
 i := 1;
 l := length(compiled);
 ferror := ER_Ok;
 fstop := false;
 cpos := C.pos;
 while(i<=l) do
 begin
  if fstep then
  begin
   if fstop then break;
   Application.ProcessMessages;
  end;
  Step;
  if fstep and Assigned(fonstep) then fonstep(Self);
  inc(i);
 end;
 for i:=1 to num do vals^[i-1] := pformula.values[i-1];
 fstop := false;
end;

function TArtFormula.RunSub(name : string;vals : PCalcArray = nil):string;
var idx,i:integer;
    str : string;
begin
  idx := -1;
  for i := 0 to high(fsubformula) do
  begin
   if not fcasesensitive then
   begin
    str := uppercase(fsubformula[i].name);
    name := UpperCase(name);
   end
   else str := fsubformula[i].name;
   if name = str then
    begin
      idx := i;
      break;
    end;
  end;

  if idx = -1 then
  begin
    tmp := name;
    ferror := ER_UNKNOWN;
    raise FormulaException.Create(ErrString);
  end;

  result := runsub(idx,vals);

end;

function Tartformula.RunSub(idx : integer; vals : PCalcArray = nil) : string;
var sp, cp : integer;
begin
  sp := S.pos;
  cp :=  C.pos;

  pformula := @(fsubformula[idx]);

  if ((pformula.paramcount > 0) and (vals=nil)) or
     ((vals<>nil) and (pformula.paramcount <> length(vals^))) then
  begin
    ferror := ER_NOTENOUGH;
    raise FormulaException.Create(ErrString);
  end;

 IntCompute(pformula.fcompiled,pformula.paramcount,vals);
 if fstop then result := '' else result := C.PopS;

 pformula := @formula;
 S.pos := sp;
 C.pos := cp;
end;

function TArtFormula.Compute(num : integer; vals : PCalcArray):string;
begin
 C.Clear;
 IntCompute(pformula.fcompiled, num, vals);
 if fstop then result := '' else result := C.PopS;
end;

function TArtFormula.ComputeN(num : integer; vals : PCalcArray):double;
begin
 C.Clear;
 IntCompute(pformula.fcompiled, num, vals);
 if fstop then result := 0 else result := C.PopN;
end;

procedure Register;
begin
  RegisterComponents('Art', [TArtFormula]);
end;

{$IFDEF LCL}
initialization

 {$I tartformula.lrs}
{$ENDIF}


end.
