(*
This unit is part of TArtFormula package.
See formula.pas for notes, License and disclaimer agreement.

(c) Artem V. Parlyuk, e-mail:artsoft@nm.ru, http://artsoft.nm.ru
*)

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}
{$I artformula.inc}
unit formulaf;

interface

uses formula;

function mysin(var Calc : TFormulaCalc):TCalcItem;
function mycos(var Calc : TFormulaCalc):TCalcItem;
function mytan(var Calc : TFormulaCalc):TCalcItem;
function mylog(var Calc : TFormulaCalc):TCalcItem;
function mylg(var Calc : TFormulaCalc):TCalcItem;
function myexp(var Calc : TFormulaCalc):TCalcItem;
function mysqrt(var Calc : TFormulaCalc):TCalcItem;
function myint(var Calc : TFormulaCalc):TCalcItem;
function myfrac(var Calc : TFormulaCalc):TCalcItem;
function myabs(var Calc : TFormulaCalc):TCalcItem;
function myatan(var Calc : TFormulaCalc):TCalcItem;
function myasin(var Calc : TFormulaCalc):TCalcItem;
function myacos(var Calc : TFormulaCalc):TCalcItem;
function myasinh(var Calc : TFormulaCalc):TCalcItem;
function myacosh(var Calc : TFormulaCalc):TCalcItem;
function myatanh(var Calc : TFormulaCalc):TCalcItem;
function mysinh(var Calc : TFormulaCalc):TCalcItem;
function mycosh(var Calc : TFormulaCalc):TCalcItem;
function mytanh(var Calc : TFormulaCalc):TCalcItem;
function mymax(var Calc : TFormulaCalc):TCalcItem;
function mymin(var Calc : TFormulaCalc):TCalcItem;
function myiff(var Calc : TFormulaCalc):TCalcItem;
function mysign(var Calc : TFormulaCalc):TCalcItem;
function mysum(var Calc : TFormulaCalc):TCalcItem;
function mysumofsquares(var Calc : TFormulaCalc):TCalcItem;
function mycount(var Calc : TFormulaCalc):TCalcItem;
function myvariance(var Calc : TFormulaCalc):TCalcItem;
function myvarp(var Calc : TFormulaCalc):TCalcItem;
function mystddevp(var Calc : TFormulaCalc):TCalcItem;
function mystddev(var Calc : TFormulaCalc):TCalcItem;
function myavg(var Calc : TFormulaCalc):TCalcItem;
function myrnd(var Calc : TFormulaCalc):TCalcItem;
function myrandomize(var Calc : TFormulaCalc):TCalcItem;
function mychr(var Calc : TFormulaCalc):TCalcItem;
function myinput(var Calc : TFormulaCalc):TCalcItem;
function mylength(var Calc : TFormulaCalc):TCalcItem;
function mytrim(var Calc : TFormulaCalc):TCalcItem;
function mytrimleft(var Calc : TFormulaCalc):TCalcItem;
function mytrimright(var Calc : TFormulaCalc):TCalcItem;
function myuppercase(var Calc : TFormulaCalc):TCalcItem;
function mylowercase(var Calc : TFormulaCalc):TCalcItem;
function mymidstr(var Calc : TFormulaCalc):TCalcItem;
function myleftstr(var Calc : TFormulaCalc):TCalcItem;
function myrightstr(var Calc : TFormulaCalc):TCalcItem;
function mypos(var Calc : TFormulaCalc):TCalcItem;
function mydate(var Calc : TFormulaCalc):TCalcItem;
function mynow(var Calc : TFormulaCalc):TCalcItem;
function myweek(var Calc : TFormulaCalc):TCalcItem;
function myyear(var Calc : TFormulaCalc):TCalcItem;
function mymonth(var Calc : TFormulaCalc):TCalcItem;
function myday(var Calc : TFormulaCalc):TCalcItem;
function myhour(var Calc : TFormulaCalc):TCalcItem;
function myminute(var Calc : TFormulaCalc):TCalcItem;
function mysecond(var Calc : TFormulaCalc):TCalcItem;
function mymillisecond(var Calc : TFormulaCalc):TCalcItem;
function myleapyear(var Calc : TFormulaCalc):TCalcItem;
function myencodedate(var Calc : TFormulaCalc):TCalcItem;
function myformat(var Calc : TFormulaCalc):TCalcItem;
function myformatf(var Calc : TFormulaCalc):TCalcItem;
function myformatdate(var Calc : TFormulaCalc):TCalcItem;
function myisnumber(var Calc : TFormulaCalc):TCalcItem;
function mymsg(var Calc : TFormulaCalc):TCalcItem;
function mycode(var Calc : TFormulaCalc):TCalcItem;
function mystring(var Calc : TFormulaCalc):TCalcItem;
function myset(var Calc : TFormulaCalc):TCalcItem;
function myvar(var Calc : TFormulaCalc):TCalcItem;
function myvars(var Calc : TFormulaCalc):TCalcItem;
function myval(var Calc : TFormulaCalc):TCalcItem;
function myblock(var Calc : TFormulaCalc):TCalcItem;
function myinc(var Calc : TFormulaCalc):TCalcItem;
function mydec(var Calc : TFormulaCalc):TCalcItem;
function myconcat(var Calc : TFormulaCalc):TCalcItem;
function myexists(var Calc : TFormulaCalc):TCalcItem;
function mytrunc(var Calc : TFormulaCalc):TCalcItem;
function myround(var Calc : TFormulaCalc):TCalcItem;
function myhex(var Calc : TFormulaCalc):TCalcItem;

//function my(var Calc : TFormulaCalc):TCalcItem;

implementation

uses math, dialogs,sysutils,forms, dateutils;

function mysin(var Calc : TFormulaCalc):TCalcItem;
begin
 setN(result,sin(Calc.TopN));
end;

function mycos(var Calc : TFormulaCalc):TCalcItem;
begin
 setN(result, cos(Calc.TopN));
end;
function mytan(var Calc : TFormulaCalc):TCalcItem;
begin
 setN(result, tan(Calc.TopN));
end;
function mylog(var Calc : TFormulaCalc):TCalcItem;
begin
 setN(result, ln(Calc.TopN));
end;
function mylg(var Calc : TFormulaCalc):TCalcItem;
begin
 setN(result, log10(Calc.TopN));
end;
function myexp(var Calc : TFormulaCalc):TCalcItem;
begin
 setN(result, exp(Calc.TopN));
end;
function mysqrt(var Calc : TFormulaCalc):TCalcItem;
begin
 setN(result, sqrt(Calc.TopN));
end;
function myint(var Calc : TFormulaCalc):TCalcItem;
begin
 setN(result, trunc(Calc.TopN));
end;
function myfrac(var Calc : TFormulaCalc):TCalcItem;
begin
 setN(result, frac(Calc.TopN));
end;
function myatan(var Calc : TFormulaCalc):TCalcItem;
begin
 setN(result, arctan(Calc.TopN));
end;
function myasin(var Calc : TFormulaCalc):TCalcItem;
begin
 setN(result, arcsin(Calc.TopN));
end;
function myacos(var Calc : TFormulaCalc):TCalcItem;
begin
 setN(result, arccos(Calc.TopN));
end;
function myasinh(var Calc : TFormulaCalc):TCalcItem;
begin
 setN(result, arcsinh(Calc.TopN));
end;
function myacosh(var Calc : TFormulaCalc):TCalcItem;
begin
 setN(result, arccosh(Calc.TopN));
end;
function myatanh(var Calc : TFormulaCalc):TCalcItem;
begin
 setN(result, arctanh(Calc.TopN));
end;
function mysinh(var Calc : TFormulaCalc):TCalcItem;
begin
 setN(result, sinh(Calc.TopN));
end;
function mycosh(var Calc : TFormulaCalc):TCalcItem;
begin
 setN(result, cosh(Calc.TopN));
end;
function mytanh(var Calc : TFormulaCalc):TCalcItem;
begin
 setN(result, tanh(Calc.TopN));
end;
function myabs(var Calc : TFormulaCalc):TCalcItem;
begin
 setN(result, abs(Calc.TopN));
end;

function mymax(var Calc : TFormulaCalc):TCalcItem;
var x : TCalcItem;
    res : boolean;
begin
 Calc.Parent.StartGetVars(trunc(Calc.TopN));
 res := Calc.Parent.GetNextVar(x,true);
 result.data := getn(x, Calc.Parent);
 while res do
 begin
  res := Calc.Parent.GetNextVar(x,true);
  result.data := max(getn(x, Calc.Parent),result.data);
 end;
end;

function mymin(var Calc : TFormulaCalc):TCalcItem;
var x : TCalcItem;
    res : boolean;
begin
 Calc.Parent.StartGetVars(trunc(Calc.TopN));
 res := Calc.Parent.GetNextVar(x,true);
 result.data := getn(x, Calc.Parent);
 while res do
 begin
  res := Calc.Parent.GetNextVar(x,true);
  result.data := min(getn(x, Calc.Parent),result.data);
 end;
end;

function myconcat(var Calc : TFormulaCalc):TCalcItem;
var x : TCalcItem;
    res : boolean;
begin
 Calc.Parent.StartGetVars(trunc(Calc.TopN));
 res := Calc.Parent.GetNextVar(x);

 sets(result,gets(x));
 while res do
 begin
  res := Calc.Parent.GetNextVar(x);
  result.str := gets(x)+result.str;
 end;
end;


function mysum(var Calc : TFormulaCalc):TCalcItem;
var x : TCalcItem;
    res : boolean;
begin
 Calc.Parent.StartGetVars(trunc(Calc.TopN));
 res := Calc.Parent.GetNextVar(x,true);
 result.data := getn(x, Calc.Parent);
 while res do
 begin
  res := Calc.Parent.GetNextVar(x,true);
  result.data := getn(x, Calc.Parent)+result.data;
 end;
end;


function myhex(var Calc : TFormulaCalc):TCalcItem;
{var s : string;
    res : double;
    i : integer;}
begin
 SetN(result,strtoint64('$'+Calc.TopS));
{
 s := UpperCase(Calc.TopS);
 res := 0;
 SetN(result,0);
 for I := 1 to length(s) do
 if (('0'<=s[i]) and ('9'>=s[i])) or (('A'<=s[i]) and ('F'>=s[i])) then
 begin
  res := res*16;
  if (('0'<=s[i]) and ('9'>=s[i])) then res := res + ord(s[i])-ord('0')
  else res := res + ord(s[i])-ord('A')+10;
 end
 else exit;
 SetN(result,res);
}
end;



function mysumofsquares(var Calc : TFormulaCalc):TCalcItem;
var x : TCalcItem;
    res : boolean;
begin
 Calc.Parent.StartGetVars(trunc(Calc.TopN));
 res := Calc.Parent.GetNextVar(x,true);
 result.data := sqr(getn(x, Calc.Parent));
 while res do
 begin
  res := Calc.Parent.GetNextVar(x,true);
  result.data := sqr(getn(x, Calc.Parent))+result.data;
 end;
end;

function myavg(var Calc : TFormulaCalc):TCalcItem;
var x : TCalcItem;
    res : boolean;
    cnt:integer;
begin
 cnt := 1;
 Calc.Parent.StartGetVars(trunc(Calc.TopN));
 res := Calc.Parent.GetNextVar(x,true);
 result.data := getn(x, Calc.Parent);
 while res do
 begin
  res := Calc.Parent.GetNextVar(x,true);
  result.data := getn(x, Calc.Parent)+result.data;
  inc(cnt);
 end;
 result.data := result.data/cnt;
end;

function mycount(var Calc : TFormulaCalc):TCalcItem;
var x : TCalcItem;
    res : boolean;
    cnt:integer;
begin
 cnt := 0;
 Calc.Parent.StartGetVars(trunc(Calc.TopN));
 res := Calc.Parent.GetNextVar(x);
 if gets(x) <> '' then inc(cnt);
 while res do
 begin
  res := Calc.Parent.GetNextVar(x);
  if gets(x) <> '' then inc(cnt);
 end;
 setN(result, cnt);
end;

function myvariance(var Calc : TFormulaCalc):TCalcItem;
var x : TCalcItem;
    res : boolean;
var cnt:integer;
    s,s2:double;
begin
 cnt := 1;
 Calc.Parent.StartGetVars(trunc(Calc.TopN));
 res := Calc.Parent.GetNextVar(x,true);
 s := getn(x, Calc.Parent);
 s2 := sqr(s);
 while res do
 begin
  res := Calc.Parent.GetNextVar(x,true);
  s := s + getn(x, Calc.Parent);
  s2 := s2 + sqr(getn(x, Calc.Parent));
  inc(cnt);
 end;
 setN(result, (cnt*s2-sqr(s))/(cnt*(cnt-1)));
end;

function myvarp(var Calc : TFormulaCalc):TCalcItem;
var x : TCalcItem;
    res : boolean;
var cnt:integer;
    s,s2:double;
begin
 cnt := 1;
 Calc.Parent.StartGetVars(trunc(Calc.TopN));
 res := Calc.Parent.GetNextVar(x,true);
 s := getn(x, Calc.Parent);
 s2 := sqr(s);
 while res do
 begin
  res := Calc.Parent.GetNextVar(x,true);
  s := s + getn(x, Calc.Parent);
  s2 := s2 + sqr(getn(x, Calc.Parent));
  inc(cnt);
 end;
 setN(result, (cnt*s2-sqr(s))/(cnt*cnt));
end;

function mystddev(var Calc : TFormulaCalc):TCalcItem;
var x : TCalcItem;
    res : boolean;
var cnt:integer;
    s,s2:double;
begin
 cnt := 1;
 Calc.Parent.StartGetVars(trunc(Calc.TopN));
 res := Calc.Parent.GetNextVar(x,true);
 s := getn(x, Calc.Parent);
 s2 := sqr(s);
 while res do
 begin
  res := Calc.Parent.GetNextVar(x,true);
  s := s + getn(x, Calc.Parent);
  s2 := s2 + sqr(getn(x, Calc.Parent));
  inc(cnt);
 end;
 setN(result, sqrt((cnt*s2-sqr(s))/(cnt*(cnt-1))));
end;

function mystddevp(var Calc : TFormulaCalc):TCalcItem;
var x : TCalcItem;
    res : boolean;
var cnt:integer;
    s,s2:double;
begin
 cnt := 1;
 Calc.Parent.StartGetVars(trunc(Calc.TopN));
 res := Calc.Parent.GetNextVar(x,true);
 s := getn(x, Calc.Parent);
 s2 := sqr(s);
 while res do
 begin
  res := Calc.Parent.GetNextVar(x,true);
  s := s + getn(x, Calc.Parent);
  s2 := s2 + sqr(getn(x, Calc.Parent));
  inc(cnt);
 end;
 setN(result, sqrt(cnt*s2-sqr(s))/cnt);
end;

function myiff(var Calc : TFormulaCalc):TCalcItem;
begin
 //setN(result, ifthen(Calc.ItemN(2)<>0,Calc.ItemN(1),Calc.TopN));
 if Calc.ItemN(2)<>0 then result := Calc.Item(1)^ else
  result := Calc.Item(0)^;
end;

function mysign(var Calc : TFormulaCalc):TCalcItem;
begin
 setN(result, sign(Calc.TopN));
end;

function myrnd(var Calc : TFormulaCalc):TCalcItem;
begin
 setN(result, random);
end;

function myrandomize(var Calc : TFormulaCalc):TCalcItem;
begin
 randomize;
 setN(result, 0);
end;

function mychr(var Calc : TFormulaCalc):TCalcItem;
begin
{$IF Defined(AF_DELPHI2010)}
  setS(result, widechar(trunc(Calc.TopN)));
{$ELSE}
  setS(result, ansichar(trunc(Calc.TopN)));
{$IFEND}
end;

function myinput(var Calc : TFormulaCalc):TCalcItem;
var s:string;
begin
 s := Calc.TopS;
 if not inputquery(Calc.ItemS(2),Calc.ItemS(1),s) then s := '';
 setS(result, s);
end;

function mylength(var Calc : TFormulaCalc):TCalcItem;
begin
 setN(result, length(Calc.TopS));
end;

function mytrim(var Calc : TFormulaCalc):TCalcItem;
begin
 setS(result, trim(Calc.TopS));
end;

function mytrimleft(var Calc : TFormulaCalc):TCalcItem;
begin
 setS(result, trimleft(Calc.TopS));
end;

function mytrimright(var Calc : TFormulaCalc):TCalcItem;
begin
 setS(result, trimright(Calc.TopS));
end;

function myuppercase(var Calc : TFormulaCalc):TCalcItem;
begin
 setS(result, AnsiUpperCase(Calc.TopS));
end;

function mylowercase(var Calc : TFormulaCalc):TCalcItem;
begin
 setS(result, AnsiLowerCase(Calc.TopS));
end;

function mymidstr(var Calc : TFormulaCalc):TCalcItem;
begin
 setS(result, copy(Calc.ItemS(2),trunc(Calc.ItemN(1)),trunc(Calc.TopN)));
end;

function myleftstr(var Calc : TFormulaCalc):TCalcItem;
begin
 setS(result, copy(Calc.ItemS(1),1,trunc(Calc.TopN)));
end;

function myrightstr(var Calc : TFormulaCalc):TCalcItem;
var s: string;
    len : integer;
begin
 s := Calc.ItemS(1);
 len := trunc(Calc.TopN);
 setS(result, copy(s,length(s) - len + 1,len));
end;

function mypos(var Calc : TFormulaCalc):TCalcItem;
begin
 if Calc.Parent.CaseSensitiveString then
  setN(result, pos(Calc.ItemS(1),Calc.TopS))
 else
  setN(result, pos(Uppercase(Calc.ItemS(1)),UpperCase(Calc.TopS)))
end;

function mydate(var Calc : TFormulaCalc):TCalcItem;
begin
 setN(result, strtodatetime(Calc.TopS));
end;

function mynow(var Calc : TFormulaCalc):TCalcItem;
begin
 setN(result, Now);
end;

function myweek(var Calc : TFormulaCalc):TCalcItem;
begin
 setN(result, DayOfTheWeek(Calc.TopN));
end;

function myencodedate(var Calc : TFormulaCalc):TCalcItem;
begin
 setN(result, Encodedate(trunc(Calc.ItemN(2)),trunc(Calc.ItemN(1)),
                         trunc(Calc.TopN)));
end;

function myyear(var Calc : TFormulaCalc):TCalcItem;
begin
 setN(result, YearOf(Calc.TopN));
end;

function mymonth(var Calc : TFormulaCalc):TCalcItem;
begin
 setN(result, MonthOf(Calc.TopN));
end;

function myday(var Calc : TFormulaCalc):TCalcItem;
begin
 setN(result, DayOf(Calc.TopN));
end;

function myhour(var Calc : TFormulaCalc):TCalcItem;
begin
 setN(result, HourOf(Calc.TopN));
end;

function myminute(var Calc : TFormulaCalc):TCalcItem;
begin
 setN(result, MinuteOf(Calc.TopN));
end;

function mysecond(var Calc : TFormulaCalc):TCalcItem;
begin
 setN(result, SecondOf(Calc.TopN));
end;

function mymillisecond(var Calc : TFormulaCalc):TCalcItem;
begin
 setN(result, MillisecondOf(Calc.TopN));
end;

function myleapyear(var Calc : TFormulaCalc):TCalcItem;
begin
 setN(result, ifthen(IsLeapYear(trunc(Calc.TopN)),1,0));
end;

function myformat(var Calc : TFormulaCalc):TCalcItem;
begin
 setS(result, formatfloat(Calc.ItemS(1), Calc.TopN));
end;

function myformatf(var Calc : TFormulaCalc):TCalcItem;
begin
 setS(result, format(Calc.ItemS(1), [Calc.TopN]));
end;

function myformatdate(var Calc : TFormulaCalc):TCalcItem;
begin
 setS(result, formatdatetime(Calc.ItemS(1), Calc.TopN));
end;

function myisnumber(var Calc : TFormulaCalc):TCalcItem;
var yes : integer;
begin
 yes := 1;
 try
  Calc.TopN;
 except
  yes := 0;
 end;
 setN(result, yes);
end;

function mymsg(var Calc : TFormulaCalc):TCalcItem;
begin
 setN(result, Application.MessageBox(pchar(Calc.ItemS(2)),pchar(Calc.ItemS(1)),trunc(Calc.TopN)));
end;

function mycode(var Calc : TFormulaCalc):TCalcItem;
begin
 setN(result, ord(Calc.TopS[1]));
end;

function mystring(var Calc : TFormulaCalc):TCalcItem;
begin
 setS(result, stringofchar(Calc.ItemS(1)[1],trunc(Calc.TopN)));
end;

function myset(var Calc : TFormulaCalc):TCalcItem;
begin
 Calc.Parent.SetVar(Calc.ItemS(1),Calc.Item(0));
 result := Calc.Item(0)^;
end;

function myvar(var Calc : TFormulaCalc):TCalcItem;
begin
 Calc.Parent.AddVar(Calc.ItemS(1),Calc.Item(0));
 result := Calc.Item(0)^;
end;

function myval(var Calc : TFormulaCalc):TCalcItem;
begin
 result := Calc.Parent.GetVar(Calc.Tops)^;
end;

function myinc(var Calc : TFormulaCalc):TCalcItem;
begin
 result := Calc.Parent.IncVar(Calc.Tops)^;
end;

function mydec(var Calc : TFormulaCalc):TCalcItem;
begin
 result := Calc.Parent.DecVar(Calc.Tops)^;
end;

function myblock(var Calc : TFormulaCalc):TCalcItem;
begin
 if Calc.TopN > 0 then
  result := Calc.Item(1)^
 else setN(result,0);
end;

function myvars(var Calc : TFormulaCalc):TCalcItem;
var i,cnt:integer;
    x : TCalcItem;
begin
 cnt := trunc(Calc.TopN);
 x.data := 0;
 x.typ := fdtnumber;
 for i := 1 to cnt do Calc.Parent.AddVar(Calc.ItemS(i),@x);
 setN(result,cnt);
end;

function myexists(var Calc : TFormulaCalc):TCalcItem;
begin
  if Calc.Parent.FindVar(calc.TopS)=-1 then
   setn(result,0)
  else
   setn(result,1);
end;

function mytrunc(var Calc : TFormulaCalc):TCalcItem;
var x,y:double;
begin
 y := math.Power(10,trunc(Calc.TopN));
 x := Calc.ItemN(1)*y;

 setN(result,trunc(x)/y);
end;

function myround(var Calc : TFormulaCalc):TCalcItem;
//var x,y:double;
begin
{ y := math.Power(10,trunc(Calc.TopN));
 x := Calc.ItemN(1)*y;

 setN(result,round(x)/y);}

 setN(result,simpleroundto(Calc.ItemN(1),-trunc(Calc.TopN)));
end;


end.

