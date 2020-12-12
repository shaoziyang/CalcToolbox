unit uMorse;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

const

  MorseASC: array [0..53] of string = (
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J',
    'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U',
    'V', 'W', 'X', 'Y', 'Z',
    '0', '1', '2', '3', '4',
    '5', '6', '7', '8', '9',
    '.', ':', ',', ';',
    '?', '=', '\', '/',
    '!', '-', '_', '"', '(',
    ')', '$', '&', '@', '+'
    );

  MorseCode: array[0..53] of string = (
    '.-', '-...', '-.-.', '-..', '.', '..-.', '--.', '....', '..', '.---', // J
    '-.-', '.-..', '--', '-.', '---', '.--.', '--.-', '.-.', '...', '-', '..-', //U
    '...-', '.--', '-..-', '-.--', '--..', //Z
    '-----', '.----', '..---', '...--', '....-', //4
    '.....', '-....', '--...', '---..', '----.', //9
    '.-.-.-', '---...', '--..--', '-.-.-.', //;
    '..--..', '-...-', '.----.', '-..-.', // /
    '-.-.--', '-....-', '..--.-', '.-..-.', '-.--.', //(
    '-.--.-', '...-..-', '.-...', '.--.-', '.-.-.' //+
    );


function MorseToStr(var mor, res: string; var n: integer): boolean;
function StrToMorse(var mes: string): string;

implementation

function indexof(s: string; ss: array of string): integer;
var
  i: integer;
begin
  Result := -1;
  for i := 0 to Length(ss) - 1 do
    if s = ss[i] then
    begin
      Result := i;
      Exit;
    end;
end;

function MorseToChar(mor: string): string;
var
  n: integer;
begin
  Result := '';
  n      := indexof(mor, MorseCode);
  if n <> -1 then
    Result := MorseASC[n];
end;

function CharToMorse(ch: string): string;
var
  n: integer;
begin
  Result := '';
  n      := indexof(ch, MorseASC);
  if n <> -1 then
    Result := MorseCode[n];
end;

function MorseToStr(var mor, res: string; var n: integer): boolean;
var
  i: integer;
  s, ss: string;
begin
  res    := '';
  Result := False;
  n      := 1;
  s      := '';
  while n <= Length(mor) do
  begin
    if mor[n] in ['.', '-', ' ', '/'] then
    begin
      if (mor[n] = '.') or (mor[n] = '-') then
        s := s + mor[n]
      else
      begin
        ss := MorseToChar(s);
        s:='';
        if ss = '' then
          Exit
        else
          res := res + ss;
      end;
    end
    else
      Exit;
    n := n + 1;
  end;
  if s <> '' then
  begin
    ss := MorseToChar(s);
        if ss = '' then
          Exit
        else
          res := res + ss;
  end;

  Result := True;
end;

function StrToMorse(var mes: string): string;
var
  i: integer;
  s, ms, c: string;
begin
  Result := '';
  ms     := mes;
  mes    := '';
  for i := 1 to Length(ms) do
  begin
    c := upCase(ms[i]);
    s := CharToMorse(c);
    if s <> '' then
    begin
      if Result = '' then
        Result := s
      else
        Result := Result + ' ' + s;
      mes := mes + c;
    end;
  end;
end;

end.
