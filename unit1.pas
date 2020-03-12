unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  ExtCtrls, Buttons, Grids, lclintf, Clipbrd,
  FastIniFile;

const
  GITHUB_URL = 'https://github.com/shaoziyang/CalcToolbox';
  GITEE_URL = 'https://gitee.com/shaoziyang/CalcToolbox';
  VERSION = '0.2';

type
  //TBytes = array of byte;
  //PBytes = ^TBytes;
  SingleBytes = array[0..3] of byte;
  DoubleBytes = array[0..7] of byte;

  { TFormMain }

  TFormMain = class(TForm)
    btnOptionSelectFont: TBitBtn;
    chkCrcInvOut: TCheckBox;
    chkCrcInvIn: TCheckBox;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    edtBytesNum: TEdit;
    edtCrcXOROUT: TEdit;
    edtCrcResult: TEdit;
    edtCrcPolygon: TEdit;
    edtCrcInitV: TEdit;
    dlgFont: TFontDialog;
    edtNumericNum: TEdit;
    GroupBox1: TGroupBox;
    ImageList: TImageList;
    imgLogo: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lbVer: TLabel;
    mmoCRC: TMemo;
    PageControl1: TPageControl;
    pcDigit: TPageControl;
    pcMain: TPageControl;
    rbBigBytes: TRadioButton;
    rbCrc7bits: TRadioButton;
    rbCrc6bits: TRadioButton;
    rbCrc8bits: TRadioButton;
    rbCrc32bits: TRadioButton;
    rbCrc12bits: TRadioButton;
    rbCrc16bits: TRadioButton;
    rbCrc5bits: TRadioButton;
    rbCrc4bits: TRadioButton;
    rbLittleBytes: TRadioButton;
    sgBytes: TStringGrid;
    sgDigit: TStringGrid;
    btnOpenGITHUB: TSpeedButton;
    btnOpenGITEE: TSpeedButton;
    StaticText1: TStaticText;
    sgConstantMath: TStringGrid;
    TabSheet1: TTabSheet;
    tsBytes: TTabSheet;
    tbByteErr: TToolButton;
    ToolBar3: TToolBar;
    ToolBar6: TToolBar;
    ToolButton17: TToolButton;
    ToolButton18: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    tsBase: TTabSheet;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    ToolButton21: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    tsAbout: TTabSheet;
    tsDigit: TTabSheet;
    btnCrc_CRC8: TToolButton;
    btnCrc_CRC8_ITU: TToolButton;
    btnCrc_CRC8_ROHC: TToolButton;
    btnCrc_CRC8_MAXIM: TToolButton;
    btnCrc_CRC16_IBM: TToolButton;
    btnCrc_CRC16_MAXIM: TToolButton;
    btnCrc_CRC16_USB: TToolButton;
    btnCrc_CRC16_MODBUS: TToolButton;
    btnCrc_CRC16_CCITT: TToolButton;
    btnCrc_CRC5_EPC: TToolButton;
    btnCrc_CRC5_ITU: TToolButton;
    btnCrc_CRC5_USB: TToolButton;
    btnCrc_CRC16_CCITT_FALSE: TToolButton;
    btnCrc_CRC16_X25: TToolButton;
    btnCrc_CRC16_XMODEM: TToolButton;
    btnCrc_CRC16_DNP: TToolButton;
    btnCrc_CRC32: TToolButton;
    btnCrc_CRC32_MPEG2: TToolButton;
    btnCrc_CRC4_ITU: TToolButton;
    btnCrc_CRC6_ITU: TToolButton;
    btnCrc_CRC7_MMC: TToolButton;
    ToolBar5: TToolBar;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    btnCrcCalc: TToolButton;
    tsCRC: TTabSheet;
    tsConstant: TTabSheet;
    tsConstantMath: TTabSheet;
    tsContantPhysics: TTabSheet;
    tsConstantChemistry: TTabSheet;
    tsOption: TTabSheet;
    tmrAlpha: TTimer;
    ToolBar1: TToolBar;
    ToolBar2: TToolBar;
    ToolBar4: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    procedure btnCrc1wireClick(Sender: TObject);
    procedure btnCrcCalcClick(Sender: TObject);
    procedure btnCrc_CRC16_CCITTClick(Sender: TObject);
    procedure btnCrc_CRC16_DNPClick(Sender: TObject);
    procedure btnCrc_CRC16_IBMClick(Sender: TObject);
    procedure btnCrc_CRC16_MAXIMClick(Sender: TObject);
    procedure btnCrc_CRC16_MODBUSClick(Sender: TObject);
    procedure btnCrc_CRC16_USBClick(Sender: TObject);
    procedure btnCrc_CRC16_X25Click(Sender: TObject);
    procedure btnCrc_CRC16_XMODEMClick(Sender: TObject);
    procedure btnCrc_CRC32Click(Sender: TObject);
    procedure btnCrc_CRC5_EPCClick(Sender: TObject);
    procedure btnCrc_CRC5_ITUClick(Sender: TObject);
    procedure btnCrc_CRC5_USBClick(Sender: TObject);
    procedure btnCrc_CRC6_ITUClick(Sender: TObject);
    procedure btnCrc_CRC7_MMCClick(Sender: TObject);
    procedure btnCrc_CRC8Click(Sender: TObject);
    procedure btnCrc_CRC8_MAXIMClick(Sender: TObject);
    procedure btnCrc_CRC8_ROHCClick(Sender: TObject);
    procedure btnOpenGITEEClick(Sender: TObject);
    procedure btnOpenGITHUBClick(Sender: TObject);
    procedure edtBytesNumChange(Sender: TObject);
    procedure edtCrcResultClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure imgLogoClick(Sender: TObject);
    procedure rbBigBytesChange(Sender: TObject);
    procedure sgBytesEditingDone(Sender: TObject);
    procedure sgConstantMathClick(Sender: TObject);
    procedure sgDigitEditingDone(Sender: TObject);
    procedure tmrAlphaTimer(Sender: TObject);
    procedure btnCrc_CRC4_ITUClick(Sender: TObject);
    procedure btnCrc_CRC8_ITUClick(Sender: TObject);
    procedure btnCrc_CRC16_CCITT_FALSEClick(Sender: TObject);
    procedure btnCrc_CRC32_MPEG2Click(Sender: TObject);
  private
    function getCrcBit: integer;
    procedure setCrcBit(bit: integer);
  public
    function NumToBytes(d: int64; n: integer): string;
    function SingleToBytes(fd: single): string;
    function DoubleToBytes(fd: double): string;
    function BigBytes(s: string): string;
    procedure StrToBytes(s: string; n: integer; var buf: TByteArray);
    procedure StrToByteBuf(s: string; out bs: string);
    function IntToByteStr(d: dword): string;
    function ChrToByte(ch: char): byte;
    function Chr2ToByte(c1: char; c2: char): byte;
    procedure setCrcMode(bit: integer; poly: longword; v0: longword;
      XOROUT: longword; InvIn: boolean; InvOut: boolean);
  end;


var
  FormMain: TFormMain;
  ini: TFastIniFile;
  writeable: boolean;
  path: string;

implementation

uses
  uCRC, udigit;

{$R *.lfm}

{ TFormMain }

procedure TFormMain.FormCreate(Sender: TObject);
begin
  path := ExtractFilePath(Application.ExeName);
  ini  := TFastIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));

  lbVer.Caption := 'ver ' + VERSION;

  // test inifile writeable
  try
    ini.WriteDateTime('Last', 'run', now());
    ini.UpdateFile;
    writeable := True;
  except
    writeable := False;
    // set unwriteable flag
    Caption   := '#' + Caption;
  end;

  // load values from ini file
  try
    BoundsRect := ini.ReadRect('Last', 'Position', BoundsRect);
    pcMain.PageIndex := ini.ReadInteger('Last', 'Page', 0);

    // Digit
    rbBigBytes.Checked      := ini.ReadBoolean('Digit', 'BigBytes', True);
    pcDigit.ActivePageIndex := ini.ReadInteger('Digit', 'Page', 0);

    // crc
    edtCrcPolygon.Text   := ini.ReadString('CRC', 'poly', '1021');
    edtCrcInitV.Text     := ini.ReadString('CRC', 'v0', '0');
    edtCrcXOROUT.Text    := ini.ReadString('CRC', 'XOROUT', '0');
    chkCrcInvIn.Checked  := ini.ReadBoolean('CRC', 'InvIn', False);
    chkCrcInvOut.Checked := ini.ReadBoolean('CRC', 'InvOut', False);
    setCrcBit(ini.ReadInteger('CRC', 'bit', 16));

  except

  end;

end;

procedure TFormMain.FormDestroy(Sender: TObject);
begin
  try
    if writeable then
    begin
      // save value to inifile
      ini.WriteRect('Last', 'Position', BoundsRect);
      ini.WriteInteger('Last', 'Page', pcMain.PageIndex);

      // Digit
      ini.WriteBoolean('Digit', 'BigBytes', rbBigBytes.Checked);
      ini.WriteInteger('Digit', 'Page', pcDigit.ActivePageIndex);

      // crc
      ini.WriteString('CRC', 'poly', edtCrcPolygon.Text);
      ini.WriteString('CRC', 'v0', edtCrcInitV.Text);
      ini.WriteString('CRC', 'XOROUT', edtCrcXOROUT.Text);
      ini.WriteBoolean('CRC', 'InvIn', chkCrcInvIn.Checked);
      ini.WriteBoolean('CRC', 'InvOut', chkCrcInvOut.Checked);
      ini.WriteInteger('CRC', 'bit', getCrcBit);

      ini.UpdateFile;
    end;
  finally
    ini.Free;
  end;
end;

procedure TFormMain.FormShow(Sender: TObject);
begin
  tmrAlpha.Tag     := 1;
  tmrAlpha.Enabled := True;
end;

procedure TFormMain.imgLogoClick(Sender: TObject);
begin
  OpenURL('http://www.lazarus-ide.org/');
end;

procedure TFormMain.rbBigBytesChange(Sender: TObject);
begin
  sgBytes.Cells[1, 2] := BigBytes(sgBytes.Cells[1, 2]);
  sgBytes.Cells[1, 3] := BigBytes(sgBytes.Cells[1, 3]);
  sgBytes.Cells[1, 4] := BigBytes(sgBytes.Cells[1, 4]);
end;

procedure TFormMain.edtBytesNumChange(Sender: TObject);
var
  nd: int64;
  fd: double;
  s: string;
begin
  s := edtBytesNum.Text;

  // Whether decimal point exists
  if pos('.', s) > 0 then
  begin
    tbByteErr.Visible := not TryStrToFloat(s, fd);
    if tbByteErr.Visible then
      exit;
    nd := Trunc(fd);
  end
  else
  begin
    tbByteErr.Visible := not TryStrToInt64(s, nd);
    if tbByteErr.Visible then
      exit;
    fd := nd;
  end;

  sgBytes.Cells[1, 1] := NumToBytes(nd, 1);
  sgBytes.Cells[1, 2] := NumToBytes(nd, 2);
  sgBytes.Cells[1, 3] := NumToBytes(nd, 4);
  sgBytes.Cells[1, 4] := NumToBytes(nd, 8);

  sgBytes.Cells[1, 5] := SingleToBytes(fd);
  sgBytes.Cells[1, 6] := DoubleToBytes(fd);

  if rbBigBytes.Checked then
    rbBigBytesChange(Sender);

end;

procedure TFormMain.edtCrcResultClick(Sender: TObject);
begin
  Clipboard.AsText := edtCrcResult.Text;
end;

procedure TFormMain.btnCrc1wireClick(Sender: TObject);
begin
  edtCrcInitV.Text   := '107';
  rbCrc8bits.Checked := True;
  edtCrcInitV.Text   := '0';
end;

procedure TFormMain.btnCrcCalcClick(Sender: TObject);
const
  MaxLen = 4096;
var
  poly, v0, xorout, len, bit: dword;
  _poly, _v0, _xorout: integer;
  bufN, i: integer;
  buf: TByteArray;
  s: string;
begin
  bit := getCrcBit;

  if not TryStrToInt('0x' + edtCrcPolygon.Text, _poly) or not
    TryStrToInt('0x' + edtCrcInitV.Text, _v0) or not
    TryStrToInt('0x' + edtCrcXOROUT.Text, _xorout) then
  begin
    beep();
    Exit;
  end;

  poly   := _poly;
  v0     := _v0;
  xorout := _xorout;

  if mmoCRC.Modified then
  begin
    StrToByteBuf(mmoCRC.Text, s);
    mmoCRC.Text     := s;
    mmoCRC.Modified := False;
  end;

  s    := mmoCRC.Text;
  bufN := (Length(s) + 2) div 3;
  if bufN = 0 then
    Exit;

  for i := 1 to (bufN div MaxLen) + 1 do
  begin
    if i * MaxLen < bufN then
      len := MaxLen
    else
      len := bufN - (i - 1) * MaxLen;
    StrToBytes(s, len, buf);
    v0 := CalcCrc(buf, len, bit, poly, v0, xorout, chkCrcInvIn.Checked,
      chkCrcInvOut.Checked);
    Delete(s, 1, len * 3);
  end;
  edtCrcResult.Text := IntToByteStr(v0);
end;


procedure TFormMain.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  CanClose     := tmrAlpha.Tag = 4;
  tmrAlpha.Tag := 3;
  tmrAlpha.Enabled := True;
end;


procedure TFormMain.sgBytesEditingDone(Sender: TObject);
var
  i, j, sy: integer;
  nd: int64;
  s, ss: string;
  pb: TByteArray;
  ps: ^single;
  pd: ^double;
  fs: single;
  fd: double;
begin
  sy := sgBytes.Selection.Location.y;
  ss := sgBytes.Cells[1, sy];

  try
    case sy of
      1..4:
      begin
        if rbBigBytes.Checked then
          ss := BigBytes(ss);
        s    := '';
        j    := 0;
        for i := 1 to Length(ss) do
          if ss[i] <> ' ' then
          begin
            insert(ss[i], s, j mod 2 + 1);
            Inc(j);
          end;
        nd := StrToInt64('0x' + s);
        edtBytesNum.Text := IntToStr(nd);
      end;
      5:
      begin
        ;
        try
          StrToBytes(ss, 4, pb);
          ps := @pb;
          fs := ps^;
          edtBytesNum.Text := FloatToStr(fs);
        except

        end;
      end;
      6:
      begin
        try
          StrToBytes(ss, 8, pb);
          pd := @pb;
          fd := pd^;
          edtBytesNum.Text := FloatToStr(fd);
        except

        end;
      end;
    end;
    edtBytesNumChange(Sender);
  except

  end;
end;

procedure TFormMain.sgConstantMathClick(Sender: TObject);
var
  sx, sy: integer;
begin
  sx := TStringGrid(Sender).Selection.Location.x;
  sy := TStringGrid(Sender).Selection.Location.y;
  Clipboard.AsText := TStringGrid(Sender).Cells[sx, sy];
end;

procedure TFormMain.sgDigitEditingDone(Sender: TObject);
var
  sx, sy: integer;
  dat, base: integer;
  s: string;
  neg: boolean;
begin
  sx := sgDigit.Selection.Location.x;
  sy := sgDigit.Selection.Location.y;
  s  := sgDigit.Cells[sx, sy];

  s := Trim(s);
  if s = '' then
    Exit;

  neg := s[1] = '-';

  case sy of
    1:
    begin
      base := 2;
    end;
    2:
    begin
      base := 8;
    end;
    3:
    begin
      base := 10;
    end;
    4:
    begin
      base := 16;
    end;
    else

  end;

  dat := StrToBase(s, base, neg, MaxInt);

  sgDigit.Cells[1, 1] := BaseToStr(dat, 1, 2, neg, '0');
  sgDigit.Cells[1, 2] := BaseToStr(dat, 1, 8, neg, '0');
  sgDigit.Cells[1, 3] := BaseToStr(dat, 1, 10, neg, '0');
  sgDigit.Cells[1, 4] := BaseToStr(dat, 1, 16, neg, '0');

end;

procedure TFormMain.tmrAlphaTimer(Sender: TObject);
begin
  case tmrAlpha.Tag of
    1:
    begin
      AlphaBlend      := True;
      AlphaBlendValue := 0;
      tmrAlpha.Tag    := 2;
    end;
    2:
    begin
      if AlphaBlendValue < 150 then
        AlphaBlendValue := AlphaBlendValue + 25
      else
        AlphaBlendValue := AlphaBlendValue + 5;
      if AlphaBlendValue = 255 then
        tmrAlpha.Enabled := False;
    end;
    3:
    begin
      AlphaBlend      := True;
      AlphaBlendValue := 255;
      tmrAlpha.Tag    := 4;
    end;
    4:
    begin
      if AlphaBlendValue > 150 then
        AlphaBlendValue := AlphaBlendValue - 5
      else
        AlphaBlendValue := AlphaBlendValue - 15;
      if AlphaBlendValue < 45 then
      begin
        tmrAlpha.Enabled := False;
        FormMain.Close;
      end;

    end;
  end;
end;

procedure TFormMain.btnCrc_CRC4_ITUClick(Sender: TObject);
begin
  setCrcMode(4, 3, 0, 0, True, True);
end;

procedure TFormMain.btnCrc_CRC5_EPCClick(Sender: TObject);
begin
  setCrcMode(5, 9, 9, 0, False, False);
end;

procedure TFormMain.btnCrc_CRC5_ITUClick(Sender: TObject);
begin
  setCrcMode(5, $15, 0, 0, True, True);
end;

procedure TFormMain.btnCrc_CRC5_USBClick(Sender: TObject);
begin
  setCrcMode(5, 5, $1F, $1F, True, True);
end;

procedure TFormMain.btnCrc_CRC6_ITUClick(Sender: TObject);
begin
  setCrcMode(6, 3, 0, 0, True, True);
end;

procedure TFormMain.btnCrc_CRC7_MMCClick(Sender: TObject);
begin
  setCrcMode(7, 9, 0, 0, False, False);
end;

procedure TFormMain.btnCrc_CRC8Click(Sender: TObject);
begin
  setCrcMode(8, 7, 0, 0, False, False);
end;

procedure TFormMain.btnCrc_CRC8_ITUClick(Sender: TObject);
begin
  setCrcMode(8, 7, 0, $55, False, False);
end;

procedure TFormMain.btnCrc_CRC8_ROHCClick(Sender: TObject);
begin
  setCrcMode(8, 7, $FF, 0, True, True);
end;

procedure TFormMain.btnOpenGITEEClick(Sender: TObject);
begin
  OpenURL(GITEE_URL);
end;

procedure TFormMain.btnOpenGITHUBClick(Sender: TObject);
begin
  OpenURL(GITHUB_URL);
end;

procedure TFormMain.btnCrc_CRC8_MAXIMClick(Sender: TObject);
begin
  setCrcMode(8, $31, 0, 0, True, True);
end;

procedure TFormMain.btnCrc_CRC16_IBMClick(Sender: TObject);
begin
  setCrcMode(16, $8005, 0, 0, True, True);
end;

procedure TFormMain.btnCrc_CRC16_MAXIMClick(Sender: TObject);
begin
  setCrcMode(16, $8005, 0, $FFFF, True, True);
end;

procedure TFormMain.btnCrc_CRC16_USBClick(Sender: TObject);
begin
  setCrcMode(16, $8005, $FFFF, $FFFF, True, True);
end;

procedure TFormMain.btnCrc_CRC16_MODBUSClick(Sender: TObject);
begin
  setCrcMode(16, $8005, $FFFF, 0, True, True);
end;

procedure TFormMain.btnCrc_CRC16_CCITTClick(Sender: TObject);
begin
  setCrcMode(16, $1021, 0, 0, True, True);
end;

procedure TFormMain.btnCrc_CRC16_CCITT_FALSEClick(Sender: TObject);
begin
  setCrcMode(16, $1021, $FFFF, 0, False, False);
end;

procedure TFormMain.btnCrc_CRC16_X25Click(Sender: TObject);
begin
  setCrcMode(16, $1021, $FFFF, $FFFF, True, True);
end;

procedure TFormMain.btnCrc_CRC16_XMODEMClick(Sender: TObject);
begin
  setCrcMode(16, $1021, 0, 0, False, False);
end;

procedure TFormMain.btnCrc_CRC16_DNPClick(Sender: TObject);
begin
  setCrcMode(16, $3D65, 0, $FFFF, True, True);
end;

procedure TFormMain.btnCrc_CRC32Click(Sender: TObject);
begin
  setCrcMode(32, $04C11DB7, $FFFFFFFF, $FFFFFFFF, True, True);
end;

procedure TFormMain.btnCrc_CRC32_MPEG2Click(Sender: TObject);
begin
  setCrcMode(32, $04C11DB7, $FFFFFFFF, 0, False, False);
end;

function TFormMain.getCrcBit: integer;
begin
  if rbCrc4bits.Checked then
    Result := 4;
  if rbCrc5bits.Checked then
    Result := 5;
  if rbCrc6bits.Checked then
    Result := 6;
  if rbCrc7bits.Checked then
    Result := 7;
  if rbCrc8bits.Checked then
    Result := 8;
  if rbCrc12bits.Checked then
    Result := 12;
  if rbCrc16bits.Checked then
    Result := 16;
  if rbCrc32bits.Checked then
    Result := 32;
end;

procedure TFormMain.setCrcBit(bit: integer);
begin
  case bit of
    4: rbCrc4bits.Checked   := True;
    5: rbCrc5bits.Checked   := True;
    6: rbCrc6bits.Checked   := True;
    7: rbCrc7bits.Checked   := True;
    8: rbCrc8bits.Checked   := True;
    12: rbCrc12bits.Checked := True;
    16: rbCrc16bits.Checked := True;
    32: rbCrc32bits.Checked := True;
    else
      exit;
  end;
end;


function TFormMain.NumToBytes(d: int64; n: integer): string;
var
  i: integer;
  s: string;
begin
  Result := '';
  if d < 0 then
  begin
    d := $ffffffffffffffff - abs(d);
    d := d + 1;
  end;
  s := IntToHex(d, 16);
  for i := 0 to n - 1 do
  begin
    Result := Result + s[16 - i - i - 1] + s[16 - i - i];
    if i < n - 1 then
      Result := Result + ' ';
  end;

end;

function TFormMain.SingleToBytes(fd: single): string;
var
  i: integer;
  b: SingleBytes;
  p: ^single;
begin
  Result := '';
  p      := @b;
  p^     := fd;
  for i := 0 to 3 do
  begin
    Result := Result + IntToHex(b[i], 2);
    if i < 3 then
      Result := Result + ' ';
  end;
end;

function TFormMain.DoubleToBytes(fd: double): string;
var
  i: integer;
  b: DoubleBytes;
  p: ^double;
begin
  Result := '';
  p      := @b;
  p^     := fd;
  for i := 0 to 7 do
  begin
    Result := Result + IntToHex(b[i], 2);
    if i < 7 then
      Result := Result + ' ';
  end;
end;

function TFormMain.BigBytes(s: string): string;
var
  i: integer;
  ss: string;
begin
  ss := '';
  for i := 1 to Length(s) do
  begin
    case i mod 3 of
      0: insert(s[i], ss, 1);
      1: insert(s[i], ss, 1);
      2: insert(s[i], ss, 2);
    end;
  end;
  Result := ss;
end;

procedure TFormMain.StrToBytes(s: string; n: integer; var buf: TByteArray);
var
  i, j: integer;
begin
  if Length(buf) < n then
    exit;

  if Length(s) < (3 * n - 1) then
    for i := 1 to n do
      s := s + '   ';

  j := 1;
  for i := 0 to n - 1 do
  begin
    buf[i] := Chr2ToByte(s[j], s[j + 1]);
    j      := j + 2;
    if s[j] = ' ' then
      j := j + 1;
  end;
end;

procedure TFormMain.StrToByteBuf(s: string; out bs: string);
var
  i, N: integer;
  b: byte;
begin
  i  := 1;
  N  := Length(s);
  bs := '';

  while True do
  begin
    while s[i] = ' ' do
      i := i + 1;

    if i < N then
    begin
      b := Chr2ToByte(s[i], s[i + 1]);
      i := i + 2;
    end
    else
    begin
      if i = N then
      begin
        b := Chr2ToByte(' ', s[i]);
        i := i + 1;
      end
      else
      begin
        Exit;
      end;
    end;
    if bs <> '' then
      bs := bs + ' ';
    bs   := bs + Format('%.02X', [b]);
  end;

end;

function TFormMain.IntToByteStr(d: dword): string;
begin
  Result := '';
  if d = 0 then
  begin
    Result := '00';
    Exit;
  end;
  while d > 0 do
  begin
    if Result <> '' then
      Result := Result + ' ';
    Result := Result + Format('%.02X', [d mod 256]);
    d := d div 256;
  end;
  Result := BigBytes(Result);
end;

function TFormMain.ChrToByte(ch: char): byte;
begin
  case ch of
    '0'..'9': Result := Ord(ch) - Ord('0');
    'A'..'F': Result := Ord(ch) - Ord('A') + 10;
    'a'..'f': Result := Ord(ch) - Ord('a') + 10;
    else
      Result := 0;
  end;
end;

function TFormMain.Chr2ToByte(c1: char; c2: char): byte;
begin
  Result := ChrToByte(c1) * 16 + ChrToByte(c2);
end;

procedure TFormMain.setCrcMode(bit: integer; poly: longword; v0: longword;
  XOROUT: longword; InvIn: boolean; InvOut: boolean);
begin
  setCrcBit(bit);
  edtCrcPolygon.Text   := IntToHex(poly, 2);
  edtCrcInitV.Text     := IntToHex(v0, 2);
  edtCrcXOROUT.Text    := IntToHex(XOROUT, 2);
  chkCrcInvIn.Checked  := InvIn;
  chkCrcInvOut.Checked := InvOut;

  btnCrcCalcClick(nil);
end;

end.
