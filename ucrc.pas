unit uCRC;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, crc;

function CalcCrc(buf: TByteArray; len: integer; bit: integer; poly: dword;
  v0: dword; XOROUT: dword; invIn: boolean; invOut: boolean): dword;


function CalcCrc8(buf: TByteArray; len: integer; poly: byte; v0: byte;
  XOROUT: byte; invIn: boolean; invOut: boolean): byte;

function CalcCrc16(buf: TByteArray; len: integer; poly: word; v0: word;
  XOROUT: word; invIn: boolean; invOut: boolean): word;

function CalcCrc32(buf: TByteArray; len: integer; poly: dword;
  v0: dword; XOROUT: dword; invIn: boolean; invOut: boolean): dword;

function CalcCrc8L(buf: TByteArray; len: integer; N: integer; poly: byte;
  v0: byte; XOROUT: byte; invIn: boolean; invOut: boolean): byte;

function Crc32File(FileName: string): dword;

implementation

function invByte(b: byte): byte;
var
  i: integer;
begin
  Result := 0;
  for i := 0 to 7 do
  begin
    Result := Result shl 1;
    if (b shr i) mod 2 = 1 then
      Result := Result + 1;
  end;
end;

function invWord(w: word): word;
var
  i: integer;
begin
  Result := 0;
  for i := 0 to 15 do
  begin
    Result := Result shl 1;
    if (W shr i) mod 2 = 1 then
      Result := Result + 1;
  end;
end;

function invDWord(w: dword): dword;
var
  i: integer;
begin
  Result := 0;
  for i := 0 to 31 do
  begin
    Result := Result shl 1;
    if (W shr i) mod 2 = 1 then
      Result := Result + 1;
  end;
end;

function invDWordN(w: dword; N: integer): dword;
var
  i: integer;
begin
  Result := 0;
  for i := 0 to N - 1 do
  begin
    Result := Result shl 1;
    if (W shr i) mod 2 = 1 then
      Result := Result + 1;
  end;
end;

function CalcCrc(buf: TByteArray; len: integer; bit: integer; poly: dword;
  v0: dword; XOROUT: dword; invIn: boolean; invOut: boolean): dword;
begin
  case bit of
    4, 5, 6, 7: Result :=
        CalcCrc8L(buf, len, bit, poly, v0, XOROUT, invIn, invOut);
    8: Result := CalcCrc8(buf, len, poly, v0, XOROUT, invIn, invOut);
    12: ;
    16: Result := CalcCrc16(buf, len, poly, v0, XOROUT, invIn, invOut);
    32: Result := CalcCrc32(buf, len, poly, v0, XOROUT, invIn, invOut);
    else

  end;
end;

function CalcCrc8(buf: TByteArray; len: integer; poly: byte; v0: byte;
  XOROUT: byte; invIn: boolean; invOut: boolean): byte;
var
  i: integer;
  t: byte;
begin
  Result := v0;
  for i := 0 to len - 1 do
  begin
    if invIn then
      t := invByte(buf[i])
    else
      t := buf[i];
    Result := Result xor t;
    for t := 1 to 8 do
    begin
      if ((Result and $80) = $80) then
        Result := (Result * 2) xor poly
      else
        Result := Result * 2;
    end;
  end;
  if invOut then
    Result := invByte(Result);

  Result := Result xor XOROUT;
end;

function CalcCrc16(buf: TByteArray; len: integer; poly: word; v0: word;
  XOROUT: word; invIn: boolean; invOut: boolean): word;
var
  i: integer;
  t: word;
begin
  Result := v0;
  for i := 0 to len - 1 do
  begin
    if invIn then
      t := invByte(buf[i])
    else
      t := buf[i];
    t := t * 256;
    Result := Result xor t;
    for t := 1 to 8 do
    begin
      if ((Result and $8000) = $8000) then
        Result := (Result * 2) xor poly
      else
        Result := Result * 2;
    end;
  end;
  if invOut then
    Result := invWord(Result);

  Result := Result xor XOROUT;
end;

function CalcCrc32(buf: TByteArray; len: integer; poly: dword; v0: dword;
  XOROUT: dword; invIn: boolean; invOut: boolean): dword;
var
  i: integer;
  t: dword;
begin
  Result := v0;
  for i := 0 to len - 1 do
  begin
    if invIn then
      t := invByte(buf[i])
    else
      t := buf[i];
    t := t shl 24;
    Result := Result xor t;
    for t := 1 to 8 do
    begin
      if ((Result and $80000000) = $80000000) then
        Result := (Result * 2) xor poly
      else
        Result := Result * 2;
    end;
  end;
  if invOut then
    Result := invDWord(Result);

  Result := Result xor XOROUT;
end;

function CalcCrc8L(buf: TByteArray; len: integer; N: integer; poly: byte;
  v0: byte; XOROUT: byte; invIn: boolean; invOut: boolean): byte;
var
  i, j: integer;
  mask: byte;
begin
  if invIn then
  begin
    mask := 1;
    poly := invByte(poly) shr (8 - N);
  end
  else
  begin
    mask := $80;
    poly := poly shl (8 - N);
  end;

  if invOut then
  begin
    Result := v0;
  end
  else
  begin
    Result := v0 shl (8 - N);
  end;

  for i := 0 to len - 1 do
  begin
    Result := Result xor buf[i];
    for j := 1 to 8 do
    begin
      if invIn then
      begin
        if (Result and mask) = mask then
          Result := (Result shr 1) xor poly
        else
          Result := (Result shr 1);
      end
      else
      begin
        if (Result and mask) = mask then
          Result := (Result * 2) xor poly
        else
          Result := (Result * 2);
      end;
    end;
  end;

  if not invOut then
    Result := Result shr (8 - N);

  Result := Result xor XOROUT;
end;

function Crc32File(FileName: string): dword;
var
  i, len: integer;
  f: file of byte;
  buf: TByteArray;
begin
  Assign(f, FileName);
  Reset(f);

  Result := 0;
  while not EOF(f) do
  begin
    BlockRead(f, buf, 4096, len);
    Result:=crc32(Result, buf, len);
  end;

  Close(f);
end;

end.
