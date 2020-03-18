(*
This unit is part of TArtFormula package.
See formula.pas for notes, License and disclaimer agreement.

(c) Artem V. Parlyuk, e-mail:artsoft@nm.ru, http://artsoft.nm.ru
*)

unit formulanf;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}


interface

function mysin(pos : integer; var data : array of double):double;
function mycos(pos : integer; var data : array of double):double;
function mytan(pos : integer; var data : array of double):double;
function mylog(pos : integer; var data : array of double):double;
function mylg(pos : integer; var data : array of double):double;
function myexp(pos : integer; var data : array of double):double;
function mysqrt(pos : integer; var data : array of double):double;
function myint(pos : integer; var data : array of double):double;
function myfrac(pos : integer; var data : array of double):double;
function myabs(pos : integer; var data : array of double):double;
function myatan(pos : integer; var data : array of double):double;
function myasin(pos : integer; var data : array of double):double;
function myacos(pos : integer; var data : array of double):double;
function myasinh(pos : integer; var data : array of double):double;
function myacosh(pos : integer; var data : array of double):double;
function myatanh(pos : integer; var data : array of double):double;
function mysinh(pos : integer; var data : array of double):double;
function mycosh(pos : integer; var data : array of double):double;
function mytanh(pos : integer; var data : array of double):double;
function mymax(pos : integer; var data : array of double):double;
function mymin(pos : integer; var data : array of double):double;
function myiff(pos : integer; var data : array of double):double;
function mysign(pos : integer; var data : array of double):double;
function mysum(pos : integer; var data : array of double):double;
function mysumofsquares(pos : integer; var data : array of double):double;
function mycount(pos : integer; var data : array of double):double;
function myvar(pos : integer; var data : array of double):double;
function myvarp(pos : integer; var data : array of double):double;
function mystddevp(pos : integer; var data : array of double):double;
function mystddev(pos : integer; var data : array of double):double;
function myavg(pos : integer; var data : array of double):double;
function myrnd(pos : integer; var data : array of double):double;
//function my(pos : integer; var data : array of double):double;

implementation

uses math;

function mysin(pos : integer; var data : array of double):double;
begin
 result := sin(data[pos]);
end;
function mycos(pos : integer; var data : array of double):double;
begin
 result := cos(data[pos]);
end;
function mytan(pos : integer; var data : array of double):double;
begin
 result := tan(data[pos]);
end;
function mylog(pos : integer; var data : array of double):double;
begin
 result := ln(data[pos]);
end;
function mylg(pos : integer; var data : array of double):double;
begin
 result := log10(data[pos]);
end;
function myexp(pos : integer; var data : array of double):double;
begin
 result := exp(data[pos]);
end;
function mysqrt(pos : integer; var data : array of double):double;
begin
 result := sqrt(data[pos]);
end;
function myint(pos : integer; var data : array of double):double;
begin
 result := trunc(data[pos]);
end;
function myfrac(pos : integer; var data : array of double):double;
begin
 result := frac(data[pos]);
end;
function myatan(pos : integer; var data : array of double):double;
begin
 result := arctan(data[pos]);
end;
function myasin(pos : integer; var data : array of double):double;
begin
 result := arcsin(data[pos]);
end;
function myacos(pos : integer; var data : array of double):double;
begin
 result := arccos(data[pos]);
end;
function myasinh(pos : integer; var data : array of double):double;
begin
 result := arcsinh(data[pos]);
end;
function myacosh(pos : integer; var data : array of double):double;
begin
 result := arccosh(data[pos]);
end;
function myatanh(pos : integer; var data : array of double):double;
begin
 result := arctanh(data[pos]);
end;
function mysinh(pos : integer; var data : array of double):double;
begin
 result := sinh(data[pos]);
end;
function mycosh(pos : integer; var data : array of double):double;
begin
 result := cosh(data[pos]);
end;
function mytanh(pos : integer; var data : array of double):double;
begin
 result := tanh(data[pos]);
end;
function myabs(pos : integer; var data : array of double):double;
begin
 result := abs(data[pos]);
end;

function mymax(pos : integer; var data : array of double):double;
var i,cnt:integer;
begin
 cnt := trunc(data[pos]);
 result := data[pos-1];
 for i := 2 to cnt do
  result := max(data[pos-i],result);
end;

function mymin(pos : integer; var data : array of double):double;
var i,cnt:integer;
begin
 cnt := trunc(data[pos]);
 result := data[pos-1];
 for i := 2 to cnt do
  result := min(data[pos-i],result);
end;

function mysum(pos : integer; var data : array of double):double;
var i,cnt:integer;
begin
 cnt := trunc(data[pos]);
 result := data[pos-1];
 for i := 2 to cnt do
  result := result + data[pos-i];
end;

function mysumofsquares(pos : integer; var data : array of double):double;
var i,cnt:integer;
begin
 cnt := trunc(data[pos]);
 result := sqr(data[pos-1]);
 for i := 2 to cnt do
  result := result + sqr(data[pos-i]);
end;

function myavg(pos : integer; var data : array of double):double;
var i,cnt:integer;
begin
 cnt := trunc(data[pos]);
 result := data[pos-1];
 for i := 2 to cnt do
  result := result + data[pos-i];
 result := result/cnt;  
end;

function mycount(pos : integer; var data : array of double):double;
begin
 result := trunc(data[pos]);
end;

function myvar(pos : integer; var data : array of double):double;
var i,cnt:integer;
var s,s2:double;
begin
 cnt := trunc(data[pos]);
 s := data[pos-1];
 s2 := sqr(s);
 for i := 2 to cnt do
 begin
  s := s + data[pos-i];
  s2 := s2 + sqr(data[pos-i]);
 end;
 result := (cnt*s2-sqr(s))/(cnt*(cnt-1));
end;

function myvarp(pos : integer; var data : array of double):double;
var i,cnt:integer;
var s,s2:double;
begin
 cnt := trunc(data[pos]);
 s := data[pos-1];
 s2 := sqr(s);
 for i := 2 to cnt do
 begin
  s := s + data[pos-i];
  s2 := s2 + sqr(data[pos-i]);
 end;
 result := (cnt*s2-sqr(s))/(cnt*cnt);
end;

function mystddev(pos : integer; var data : array of double):double;
var i,cnt:integer;
var s,s2:double;
begin
 cnt := trunc(data[pos]);
 s := data[pos-1];
 s2 := sqr(s);
 for i := 2 to cnt do
 begin
  s := s + data[pos-i];
  s2 := s2 + sqr(data[pos-i]);
 end;
 result := sqrt((cnt*s2-sqr(s))/(cnt*(cnt-1)));
end;

function mystddevp(pos : integer; var data : array of double):double;
var i,cnt:integer;
var s,s2:double;
begin
 cnt := trunc(data[pos]);
 s := data[pos-1];
 s2 := sqr(s);
 for i := 2 to cnt do
 begin
  s := s + data[pos-i];
  s2 := s2 + sqr(data[pos-i]);
 end;
 result := sqrt(cnt*s2-sqr(s))/cnt;
end;

function myiff(pos : integer; var data : array of double):double;
begin
 result := ifthen(data[pos-2]<>0,data[pos-1],data[pos]);
end;

function mysign(pos : integer; var data : array of double):double;
begin
 result := sign(data[pos]);
end;

function myrnd(pos : integer; var data : array of double):double;
begin
 result := random;
end;

end.

