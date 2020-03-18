unit uBase;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

function BaseToStr(num, len, base: integer; neg: boolean; fill: char): string;
function StrToBase(const s: string; base: integer; neg: boolean; max: integer): integer;


implementation

const
  MinBase = 2;
  MaxBase = 36;

// num =  要转换的数
// len =  生成字符串的最小长度
// base = 进制数 2 = 二进制
// neg =  是否允许负数
// fill = 填充字符用于补满字符串长度//
// 用法:
// NumToStr (45, 8, 2, false, '0') > '00101101'
// NumToStr (45, 4, 8, false, '0') > '0055'
// NumToStr (45, 4, 10, false, ' ') > '  45'
// NumToStr (45, 4, 16, false, '0') > '002D'
// NumToStr (45, 0, 36, false, ' ') > '19'

function BaseToStr(num, len, base: integer; neg: boolean; fill: char): string;
var
  s: string;
  digit: integer;
begin
  num := ABS(num);
  if ((base >= MinBase) and (base <= MaxBase)) then
  begin
    s := '';
    repeat
      digit := num mod base;
      if digit < 10 then
        Insert(CHR(digit + 48), s, 1)
      else
        Insert(CHR(digit + 55), s, 1);
      num := num div base;
    until num = 0;
    if neg then
      Insert('-', s, 1);
    while Length(s) < len do
      Insert(fill, s, 1);
  end;
  Result := s;
end;

// s = 要转换的字符串
// base = 进制数
// neg = 是否为负数
// max = 要转换的最大数
// 用法:
// i:= StrToNum ('00101101', 2, false, MaxInt);
// i:= StrToNum ('002D', 16, false, MaxInt);
// i:= StrToNum ('-45', 10, true, MaxInt);
// i:= StrToNum ('ZZ', 36, true, MaxInt);

function StrToBase(const s: string; base: integer; neg: boolean; max: integer): integer;
var
  negate, done: boolean;
  i, ind, len, digit, mmb: integer;
  c: char;
  mdb, res: integer;
begin
  res   := 0;
  i     := 1;
  digit := 0;
  if (base >= MinBase) and (base <= MaxBase) then
  begin
    mmb    := max mod base;
    mdb    := max div base;
    len    := Length(s);
    negate := False;
    while (i <= len) and (s[i] = ' ') do
      Inc(i);
    if neg then
    begin
      case s[i] of
        '+': Inc(i);
        '-':
        begin
          Inc(i);
          negate := True;
        end;
      end;
    end;
    done := len >= i;
    while (i <= len) and done do
    begin
      c := Upcase(s[i]);
      case c of
        '0'..'9': digit := Ord(c) - 48;
        'A'..'Z': digit := Ord(c) - 55;
        else
          done := False
      end;
      done := done and (digit < base);
      if done then
      begin
        done := (res < mdb) or ((res = mdb) and (digit <= mmb));
        if done then
        begin
          res := res * base + digit;
          Inc(i);
        end;
      end;
    end;
    if negate then
      res := -1 * res;
  end;
  Result := res;
end;


end.
