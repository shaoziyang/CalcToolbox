unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  ExtCtrls, Buttons, Grids, lclintf, DateUtils,
  Clipbrd, Menus,
  SynEdit,
  UBigFloatV3,
  //UBigIntsForFloatV4,
  UBigIntsV5,
  IniFiles;

const
  GITHUB_URL = 'https://github.com/shaoziyang/CalcToolbox';
  GITEE_URL = 'https://gitee.com/shaoziyang/CalcToolbox';
  VERSION = '0.4';

type
  SingleBytes = array[0..3] of byte;
  DoubleBytes = array[0..7] of byte;

  { TFormMain }

  TFormMain = class(TForm)
    btnBufferConvert: TBitBtn;
    btnBigIntAdd: TToolButton;
    btnBigIntDiv: TToolButton;
    btnBigIntFib: TToolButton;
    btnBigIntElapsed: TToolButton;
    btnBigIntNRoot: TToolButton;
    btnBigIntGcd: TToolButton;
    btnBigIntFact: TToolButton;
    btnBigIntPrime: TToolButton;
    btnBigIntMul: TToolButton;
    btnBigIntRandom: TToolButton;
    btnBigIntPower: TToolButton;
    btnBigIntMod: TToolButton;
    btnBigIntSqrt: TToolButton;
    btnBigIntSub: TToolButton;
    btnOpenGITEE: TSpeedButton;
    btnOpenGITHUB: TSpeedButton;
    btnOptionSelectFont: TBitBtn;
    chkBigIntComma: TCheckBox;
    chkCrcInvOut: TCheckBox;
    chkCrcInvIn: TCheckBox;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    edtBigFloatPrec: TEdit;
    edtBytesNum: TEdit;
    edtCrcXOROUT: TEdit;
    edtCrcResult: TEdit;
    edtCrcPolygon: TEdit;
    edtCrcInitV: TEdit;
    dlgFont: TFontDialog;
    edtNumericNum: TEdit;
    GroupBox1: TGroupBox;
    ImageList: TImageList;
    ilDigit: TImageList;
    imgLaz: TImage;
    imgLogo: TImage;
    imgLogo1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lbVer: TLabel;
    mmoBufferStr: TMemo;
    mmoBufferHEX: TMemo;
    mmoBufferPython: TMemo;
    mmoAboutReadme: TMemo;
    mmoAboutChangeLog: TMemo;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    mmoBigFloatA: TMemo;
    mmoBigIntA: TMemo;
    mmoBigFloatB: TMemo;
    mmoBigIntB: TMemo;
    mmoBigIntC: TMemo;
    mmoCRC: TMemo;
    mmoBigFloatC: TMemo;
    PageControl1: TPageControl;
    PageControl2: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    pnlBigFloatA: TPanel;
    pnlBigIntB: TPanel;
    pnlBigIntC: TPanel;
    pnlBufferStr: TPanel;
    pnlBufferHEX: TPanel;
    pnlBufferPython: TPanel;
    pnlBigFloatB: TPanel;
    pnlBigFloatC: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    pnlBigIntA: TPanel;
    pcDigit: TPageControl;
    pcMain: TPageControl;
    pmBitIntBase: TPopupMenu;
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
    sgBase: TStringGrid;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    Splitter3: TSplitter;
    lbOptFont: TStaticText;
    sgConstantMath: TStringGrid;
    Splitter4: TSplitter;
    Splitter5: TSplitter;
    Splitter6: TSplitter;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    StaticText4: TStaticText;
    StaticText5: TStaticText;
    StaticText6: TStaticText;
    StaticText7: TStaticText;
    StaticText8: TStaticText;
    StaticText9: TStaticText;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    tsBuffer: TTabSheet;
    tbBigInt: TToolBar;
    tmrLogo: TTimer;
    ToolButton23: TToolButton;
    ToolButton24: TToolButton;
    ToolButton25: TToolButton;
    btnBigIntHint: TToolButton;
    ToolButton26: TToolButton;
    btnBigFloatHint: TToolButton;
    ToolButton27: TToolButton;
    btnBigIntBase: TToolButton;
    tsBigInt: TTabSheet;
    tsBigFloat: TTabSheet;
    tbBigFloat: TToolBar;
    btnBigFloatReciprocal: TToolButton;
    btnBigFloatPI: TToolButton;
    btnBigFloatPower: TToolButton;
    btnBigFloatLog: TToolButton;
    btnBigFloatLn: TToolButton;
    btnBigFloatExp: TToolButton;
    btnBigFloatLog2: TToolButton;
    ToolButton19: TToolButton;
    ToolButton20: TToolButton;
    btnBigFloatAdd: TToolButton;
    ToolButton22: TToolButton;
    btnBigFloatSub: TToolButton;
    btnBigFloatMul: TToolButton;
    btnBigFloatDiv: TToolButton;
    btnBigFloatSqrt: TToolButton;
    btnBigFloatE: TToolButton;
    btnBigFloatElapsed: TToolButton;
    tsPCalc: TTabSheet;
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
    btnCrcBufLen: TToolButton;
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
    procedure btnBufferConvertClick(Sender: TObject);
    procedure btnBigFloatAddClick(Sender: TObject);
    procedure btnBigIntAddClick(Sender: TObject);
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
    procedure btnOptionSelectFontClick(Sender: TObject);
    procedure edtBigFloatPrecEditingDone(Sender: TObject);
    procedure edtBytesNumChange(Sender: TObject);
    procedure edtCrcResultClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure imgLazClick(Sender: TObject);
    procedure mmoBigFloatCMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure mmoBigIntCMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure mmoBufferPythonMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure rbBigBytesChange(Sender: TObject);
    procedure sgBytesEditingDone(Sender: TObject);
    procedure sgConstantMathClick(Sender: TObject);
    procedure sgBaseEditingDone(Sender: TObject);
    procedure tmrAlphaTimer(Sender: TObject);
    procedure btnCrc_CRC4_ITUClick(Sender: TObject);
    procedure btnCrc_CRC8_ITUClick(Sender: TObject);
    procedure btnCrc_CRC16_CCITT_FALSEClick(Sender: TObject);
    procedure btnCrc_CRC32_MPEG2Click(Sender: TObject);
    procedure tmrLogoTimer(Sender: TObject);
  private
    function getCrcBit: integer;
    procedure setCrcBit(bit: integer);
    procedure bfCalc(Sender: TObject);
    procedure biCalc(Sender: TObject);
    procedure saveFont;
  public
    function BufferToStr(buf: TByteArray; N: integer): string;
    function BufferToHEX(buf: TByteArray; N: integer): string;
    function BufferToPyStr(buf: TByteArray; N: integer): string;
    function NumToBytes(d: int64; n: integer): string;
    function SingleToBytes(fd: single): string;
    function DoubleToBytes(fd: double): string;
    function BigBytes(s: string): string;
    procedure StrToBytes(s: string; n: integer; var buf: TByteArray);
    procedure StrToByteBuf(s: string; out bs: string);
    function IntToByteStr(d: dword): string;
    function ChrToByte(ch: char): byte;
    function Chr2ToByte(c1: char; c2: char): byte;
    function StrBytesToChrs(s: string; Len: integer): string;
    procedure setCrcMode(bit: integer; poly: longword; v0: longword;
      XOROUT: longword; InvIn: boolean; InvOut: boolean);
  end;


var
  FormMain: TFormMain;
  ini: TIniFile;
  writeable: boolean;
  path: string;
  bfA, bfB: TBigFloat;
  biA, biB: TInteger;
  bfPrec: integer;

implementation

uses
  uCRC, uBase;

{$R *.lfm}

{ TFormMain }

procedure TFormMain.FormCreate(Sender: TObject);
begin
  path := ExtractFilePath(Application.ExeName);
  ini  := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));

  lbVer.Caption := 'ver ' + VERSION;

  tsPCalc.TabVisible    := False;
  tsConstant.TabVisible := False;

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
    Top    := ini.ReadInteger('Last', 'Top', Top);
    Left   := ini.ReadInteger('Last', 'Left', Left);
    Width  := ini.ReadInteger('Last', 'Width', Width);
    Height := ini.ReadInteger('Last', 'Height', Height);

    pcMain.PageIndex := ini.ReadInteger('Last', 'Page', 0);

    // option
    lbOptFont.Font.Name := ini.ReadString('Option', 'FontName', Font.Name);
    lbOptFont.Font.Size := ini.ReadInteger('Option', 'FontSize', Font.Size);
    if lbOptFont.Font.Size < 7 then
      lbOptFont.Font.Size := 7
    else if lbOptFont.Font.Size > 24 then
      lbOptFont.Font.Size := 24;
    if ini.ReadBool('Option', 'FontBold', False) then
    begin
      lbOptFont.Font.Style := [fsBold];
      lbOptFont.Caption    := ', Bold';
    end;
    Font := lbOptFont.Font;
    lbOptFont.Caption := Format('%s, %d', [Font.Name, Font.Size]) + lbOptFont.Caption;

    // Digit
    rbBigBytes.Checked      := ini.ReadBool('Digit', 'BigBytes', True);
    pcDigit.ActivePageIndex := ini.ReadInteger('Digit', 'Page', 0);

    // crc
    edtCrcPolygon.Text   := ini.ReadString('CRC', 'poly', '1021');
    edtCrcInitV.Text     := ini.ReadString('CRC', 'v0', '0');
    edtCrcXOROUT.Text    := ini.ReadString('CRC', 'XOROUT', '0');
    chkCrcInvIn.Checked  := ini.ReadBool('CRC', 'InvIn', False);
    chkCrcInvOut.Checked := ini.ReadBool('CRC', 'InvOut', False);
    setCrcBit(ini.ReadInteger('CRC', 'bit', 16));

    // BigFloat
    edtBigFloatPrec.Text := ini.ReadString('BigFloat', 'prec', '100');
    pnlBigFloatA.Height  := ini.ReadInteger('BigFloat', 'PanelA', 80);
    pnlBigFloatB.Height  := ini.ReadInteger('BigFloat', 'PanelB', 80);
    mmoBigFloatA.Text    := '';
    mmoBigFloatB.Text    := '';

    // BigInt
    chkBigIntComma.Checked := ini.ReadBool('BigInt', 'comma', False);
    pnlBigIntA.Height := ini.ReadInteger('BigInt', 'PanelA', 80);
    pnlBigIntB.Height := ini.ReadInteger('BigInt', 'PanelB', 80);
    mmoBigIntA.Text := '';
    mmoBigIntB.Text := '';

    // Buffer
    pnlBufferPython.Height := ini.ReadInteger('Buffer', 'PanelPython', 120);
    pnlBufferHEX.Height    := ini.ReadInteger('Buffer', 'PanelHex', 120);
    mmoBufferPython.Text   := '';
    mmoBufferHex.Text      := '';
    mmoBufferStr.Text      := '';

  except

  end;


  try
    bfA := TBigFloat.Create;
    bfB := TBigFloat.Create;
    edtBigFloatPrecEditingDone(Sender);
  except
    tsBigFloat.TabVisible := False;
  end;

  try
    biA := TInteger.Create;
    biB := TInteger.Create;
  except
    tsBigInt.TabVisible := False;
  end;

end;

procedure TFormMain.FormDestroy(Sender: TObject);
begin
  try
    if writeable then
    begin
      // save value to inifile
      ini.WriteInteger('Last', 'Top', Top);
      ini.WriteInteger('Last', 'Left', Left);
      ini.WriteInteger('Last', 'Width', Width);
      ini.WriteInteger('Last', 'Height', Height);

      ini.WriteInteger('Last', 'Page', pcMain.PageIndex);

      // Digit
      ini.WriteBool('Digit', 'BigBytes', rbBigBytes.Checked);
      ini.WriteInteger('Digit', 'Page', pcDigit.ActivePageIndex);

      // crc
      ini.WriteString('CRC', 'poly', edtCrcPolygon.Text);
      ini.WriteString('CRC', 'v0', edtCrcInitV.Text);
      ini.WriteString('CRC', 'XOROUT', edtCrcXOROUT.Text);
      ini.WriteBool('CRC', 'InvIn', chkCrcInvIn.Checked);
      ini.WriteBool('CRC', 'InvOut', chkCrcInvOut.Checked);
      ini.WriteInteger('CRC', 'bit', getCrcBit);

      // BigFloat
      ini.WriteString('BigFloat', 'prec', edtBigFloatPrec.Text);
      ini.WriteInteger('BigFloat', 'PanelA', pnlBigFloatA.Height);
      ini.WriteInteger('BigFloat', 'PanelB', pnlBigFloatB.Height);

      // BigInt
      ini.WriteBool('BigInt', 'comma', chkBigIntComma.Checked);
      ini.WriteInteger('BigInt', 'PanelA', pnlBigIntA.Height);
      ini.WriteInteger('BigInt', 'PanelB', pnlBigIntB.Height);

      // Buffer
      ini.WriteInteger('Buffer', 'PanelPython', pnlBufferPython.Height);
      ini.WriteInteger('Buffer', 'PanelHex', pnlBufferHex.Height);

      ini.UpdateFile;
    end;
  finally
    bfA.Free;
    bfB.Free;
    biA.Free;
    biB.Free;

    ini.Free;
  end;
end;

procedure TFormMain.FormShow(Sender: TObject);
begin
  tmrAlpha.Tag     := 1;
  tmrAlpha.Enabled := True;
end;

procedure TFormMain.imgLazClick(Sender: TObject);
begin
  OpenURL('http://www.lazarus-ide.org/');
end;

procedure TFormMain.mmoBigFloatCMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  if mmoBigFloatC.SelLength = 0 then
  begin
    btnBigFloatHint.Caption := IntToStr(Length(mmoBigFloatC.Text));
    Clipboard.AsText := mmoBigFloatC.Text;
  end
  else
  begin
    btnBigFloatHint.Caption := IntToStr(mmoBigFloatC.SelLength);
    Clipboard.AsText := mmoBigFloatC.SelText;
  end;
end;

procedure TFormMain.mmoBigIntCMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  if mmoBigIntC.SelLength = 0 then
  begin
    btnBigIntHint.Caption := IntToStr(Length(mmoBigIntC.Text));
    Clipboard.AsText      := mmoBigIntC.Text;
  end
  else
  begin
    btnBigIntHint.Caption := IntToStr(mmoBigIntC.SelLength);
    Clipboard.AsText      := mmoBigIntC.SelText;
  end;
end;

procedure TFormMain.mmoBufferPythonMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
  Clipboard.AsText := TMemo(Sender).Text;
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

  sgBytes.Cells[1, 6] := SingleToBytes(fd);
  sgBytes.Cells[1, 8] := DoubleToBytes(fd);

  if rbBigBytes.Checked then
    rbBigBytesChange(Sender);

  sgBytes.Cells[1, 5] := StrBytesToChrs(sgBytes.Cells[1, 4], 8);
  sgBytes.Cells[1, 7] := StrBytesToChrs(sgBytes.Cells[1, 6], 4);
  sgBytes.Cells[1, 9] := StrBytesToChrs(sgBytes.Cells[1, 8], 8);

end;

procedure TFormMain.edtCrcResultClick(Sender: TObject);
begin
  Clipboard.AsText := edtCrcResult.Text;
end;

procedure TFormMain.btnBigFloatAddClick(Sender: TObject);
begin
  bfCalc(Sender);
end;

procedure TFormMain.btnBufferConvertClick(Sender: TObject);
const
  MaxLen = 256;
var
  i, j, bufN, len, d: integer;
  buf: TByteArray;
  s, ss, s1, s2, s3: string;
begin

  if mmoBufferPython.Modified then
  begin
    s1   := '';
    s2   := '';
    s3   := mmoBufferPython.Text;
    mmoBufferStr.Text := '';
    mmoBufferHEX.Text := '';
    bufN := Length(s3);
    i    := 1;
    len  := 0;
    while i <= bufN do
    begin
      if s3[i] = '\' then
      begin
        if i < bufN then
        begin
          case Ord(s3[i + 1]) of
            Ord('\'): buf[len]  := Ord('\');
            Ord('"'): buf[len]  := Ord('"');
            Ord(''''): buf[len] := Ord('''');
            Ord('a'): buf[len]  := 7;
            Ord('b'): buf[len]  := 8;
            Ord('t'): buf[len]  := 9;
            Ord('v'): buf[len]  := 11;
            Ord('f'): buf[len]  := 12;
            Ord('n'): buf[len]  := 10;
            Ord('r'): buf[len]  := 13;
            Ord('x'): // hex number
            begin
              if i < bufN - 1 then
                buf[len] := Chr2ToByte(s3[i + 2], s3[i + 3])
              else
                buf[len] := Chr2ToByte('0', s3[i + 2]);
              i := i + 2;
            end;
            Ord('0')..Ord('7'): // Octal number
            begin
              j := 1;
              if (Ord(s3[i + 2]) <= Ord('7')) and (Ord(s3[i + 2]) >= Ord('0')) then
              begin
                j := 2;
                if (Ord(s3[i + 3]) <= Ord('7')) and (Ord(s3[i + 3]) >= Ord('0')) then
                  j := 3;
              end;
              s := Copy(s3, i + 1, j);
              d := StrToBase(s, 8, False, MaxInt);
              if d > 255 then
              begin
                beep;
                Exit;
              end;
              buf[len] := d;
              i := i + j - 1;
            end
            else
              buf[len] := Ord(s3[i]);
              len      := len + 1;
              buf[len] := Ord(s3[i + 1]);
          end;
          i := i + 1;
        end
        else
          buf[len] := 0;
      end
      else
        buf[len] := Ord(s3[i]);
      len := len + 1;
      i   := i + 1;
      if (len >= MaxLen) or (i >= bufN) then
      begin
        s1  := s1 + BufferToStr(buf, len);
        s2  := s2 + BufferToHex(buf, len);
        len := 0;
      end;
    end;
    mmoBufferStr.Text := s1;
    mmoBufferHEX.Text := s2;
  end
  else
  begin
    if mmoBufferHEX.Modified then
    begin
      s1 := '';
      StrToByteBuf(mmoBufferHEX.Text, s2);
      mmoBufferHEX.Text := s2;
      s3   := '';
      bufN := (Length(s2) + 2) div 3;
      for i := 1 to (bufN div MaxLen) + 1 do
      begin
        if i * MaxLen < bufN then
          len := MaxLen
        else
          len := bufN - (i - 1) * MaxLen;
        StrToBytes(s2, len, buf);
        Delete(s2, 1, len * 3);
        s1 := s1 + BufferToStr(buf, len);
        s3 := s3 + BufferToPyStr(buf, len);
      end;
      mmoBufferStr.Text    := s1;
      mmoBufferPython.Text := s3;
    end
    else
    begin
      if mmoBufferStr.Modified then
      begin
        s1   := mmoBufferStr.Text;
        s2   := '';
        s3   := '';
        bufN := Length(s1);
        for i := 1 to (bufN div MaxLen) + 1 do
        begin
          if i * MaxLen < bufN then
            len := MaxLen
          else
            len := bufN - (i - 1) * 256;
          for j := 0 to len - 1 do
          begin
            buf[j] := Ord(s1[j + 1]);
          end;
          s2 := s2 + BufferToHEX(buf, len);
          s3 := s3 + BufferToPyStr(buf, len);
          Delete(s1, 1, len);
        end;
        mmoBufferHEX.Text    := s2;
        mmoBufferPython.Text := s3;
      end;
    end;
  end;

  mmoBufferPython.Modified := False;
  mmoBufferStr.Modified    := False;
  mmoBufferHEX.Modified    := False;

end;

procedure TFormMain.btnBigIntAddClick(Sender: TObject);
begin
  biCalc(Sender);
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
  btnCrcBufLen.Caption := Format('<%d>', [bufN]);
  edtCrcResult.Text    := IntToByteStr(v0);
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
      6:
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
      8:
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

procedure TFormMain.sgBaseEditingDone(Sender: TObject);
var
  sx, sy: integer;
  dat, base: integer;
  s: string;
  neg: boolean;
begin
  sx := sgBase.Selection.Location.x;
  sy := sgBase.Selection.Location.y;
  s  := sgBase.Cells[sx, sy];

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

  sgBase.Cells[1, 1] := BaseToStr(dat, 1, 2, neg, '0');
  sgBase.Cells[1, 2] := BaseToStr(dat, 1, 8, neg, '0');
  sgBase.Cells[1, 3] := BaseToStr(dat, 1, 10, neg, '0');
  sgBase.Cells[1, 4] := BaseToStr(dat, 1, 16, neg, '0');

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

procedure TFormMain.btnOptionSelectFontClick(Sender: TObject);
begin
  dlgFont.Font := Font;

  if dlgFont.Execute then
  begin
    Font := dlgFont.Font;
    if fsBold in Font.Style then
      lbOptFont.Caption := ', Bold'
    else
      lbOptFont.Caption := '';
    lbOptFont.Caption := Format('%s, %d', [Font.Name, Font.Size]) + lbOptFont.Caption;
    saveFont;
  end;
end;

procedure TFormMain.edtBigFloatPrecEditingDone(Sender: TObject);

begin
  if not TryStrToInt(edtBigFloatPrec.Text, bfPrec) then
  begin
    bfPrec := 100;
    edtBigFloatPrec.Text := '100';
  end;
  if (bfPrec >= 2000) and edtBigFloatPrec.Modified then
  begin
    edtBigFloatPrec.Modified := False;
    MessageDlg('Warning', 'High precision may cause long calculation time',
      mtWarning, [mbOK], 0);
  end;
  bfA.Setsigdigits(bfPrec);
  bfB.Setsigdigits(bfPrec);
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

procedure TFormMain.tmrLogoTimer(Sender: TObject);
begin
  if pcMain.ActivePage = tsAbout then
    imgLogo.Visible := not imgLogo.Visible;
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

procedure TFormMain.bfCalc(Sender: TObject);
var
  sa, sb: string;
  T1, T2: TDateTime;
begin
  if (Sender is TToolButton) then
    if TToolButton(Sender).Parent = tbBigFloat then
    begin
      Screen.Cursor := crHourGlass;
      T1 := Now();
      sa := Trim(mmoBigFloatA.Text);
      sb := Trim(mmoBigFloatB.Text);
      case TToolButton(Sender).Tag of
        101: // add
        begin
          bfA.Assign(sa);
          bfB.Assign(sb);
          bfA.Add(bfB);
        end;
        102: // sub
        begin
          bfA.Assign(sa);
          bfB.Assign(sb);
          bfA.Subtract(bfB);
        end;
        103: // mul
        begin
          bfA.Assign(sa);
          bfB.Assign(sb);
          bfA.Mult(bfB);
        end;
        104: // div
        begin
          bfA.Assign(sa);
          bfB.Assign(sb);
          bfA.Divide(bfB, bfPrec);
        end;
        105: // sqrt
        begin
          bfA.Assign(sa);
          bfA.Sqrt(bfPrec);
        end;
        106: // Reciprocal
        begin
          bfA.Assign(sa);
          bfA.Reciprocal(bfPrec);
        end;
        107: // Power
        begin
          bfA.Assign(sa);
          bfB.Assign(sb);
          bfA.Power(bfB, bfPrec);
        end;
        108:// exp
        begin
          bfA.Assign(sa);
          bfA.Exp(bfPrec);
        end;
        109: // log
        begin
          bfA.Assign(sa);
          bfA.Log(bfPrec);
        end;
        110: // log10
        begin
          bfA.Assign(sa);
          bfA.Log10(bfPrec);
        end;
        201: // Pi
        begin
          bfA.PiConst(bfPrec);
        end;
        202: // e
        begin
          bfA.Assign('1');
          bfA.Exp(bfPrec);
        end;
        203: // log2
        begin
          bfA.Log2Const(bfPrec);
        end
        else
      end;
      mmoBigFloatC.Text := bfA.ConverttoString(normal);
      T2 := Now();
      Screen.Cursor := crDefault;
      btnBigFloatElapsed.Caption := Format('%d ms', [MilliSecondsBetween(T2, T1)]);
      btnBigFloatHint.Caption := IntToStr(Length(mmoBigFloatC.Text));
    end;
end;

procedure TFormMain.biCalc(Sender: TObject);
var
  sa, sb: string;
  T1, T2: TDateTime;
  bt: int64;
  biFib1, biFib2: TInteger;
begin
  if (Sender is TToolButton) then
    if TToolButton(Sender).Parent = tbBigInt then
    begin
      Screen.Cursor := crHourGlass;
      T1 := Now();
      sa := Trim(mmoBigIntA.Text);
      sb := Trim(mmoBigIntB.Text);
      mmoBigIntC.Text := '';
      case TToolButton(Sender).Tag of
        101: // add
        begin
          biA.Assign(sa);
          biB.Assign(sb);
          biA.Add(biB);
        end;
        102: // sub
        begin
          biA.Assign(sa);
          biB.Assign(sb);
          biA.Subtract(biB);
        end;
        103: // mul
        begin
          biA.Assign(sa);
          biB.Assign(sb);
          biA.Mult(biB);
        end;
        104: // div
        begin
          biA.Assign(sa);
          biB.Assign(sb);
          biA.Divide(biB);
        end;
        105: // mod
        begin
          biA.Assign(sa);
          biB.Assign(sb);
          biA.Modulo(biB);
        end;
        106: // Sqrt
        begin
          biA.Assign(sa);
          biA.Sqroot;
        end;
        107: // NRoot
        begin
          biA.Assign(sa);
          biB.Assign(sb);
          biB.ConvertToInt64(bt);
          biA.NRoot(bt);
        end;
        108: // power
        begin
          biA.Assign(sa);
          biB.Assign(sb);
          biB.ConvertToInt64(bt);
          biA.Pow(bt);
        end;
        109: // Fact
        begin
          biA.Assign(sa);
          biA.Factorial;
        end;
        110: // GCD
        begin
          biA.Assign(sa);
          biB.Assign(sb);
          biA.Gcd(biB);
        end;
        201: // random
        begin
          biB.Assign(sa);
          biA.Random(biB);
        end;
        202: // Febocera series
        begin
          biB.Assign(sa);
          biA.Assign('1');
          biFib1 := TInteger.Create(1);
          biFib2 := TInteger.Create(1);
          sa     := '1' + #13#10 + '1' + #13#10;
          biB.Subtract(2);
          while biB.IsPositive do
          begin
            biFib1.Assign(biA);
            biA.Add(biFib2);
            biFib2.Assign(biFib1);
            biB.Subtract(1);
            sa := sa + biA.ConvertToDecimalString(chkBigIntComma.Checked) + #13#10;
          end;
          biFib1.Free;
          biFib2.Free;
          mmoBigIntC.Text := sa;
        end;
        203: // Prime
        begin
          biA.Assign(sa);
          biB.Assign(sb);
          if biA.Compare(biB) = 1 then
          begin
            biA.Assign(sa);
            biB.Assign(sb);
          end
          else
          begin
            biA.Assign(sb);
            biB.Assign(sa);
          end;

          sa := '';
          repeat
            biB.Getnextprime;
            if biA.Compare(biB) = 1 then    // A > B
              sa := sa + biB.ConvertToDecimalString(chkBigIntComma.Checked) + #13#10
            else
              break;
          until False;
          mmoBigIntC.Text := sa;
          if mmoBigIntC.Text = '' then
            mmoBigIntC.Text := '-';
        end;
        300: // base
        begin
          // todo
          biA.Assign(sa);
          mmoBigIntC.Text := sa;
        end
        else
      end;
      if mmoBigIntC.Text = '' then
        mmoBigIntC.Text := biA.ConvertToDecimalString(chkBigIntComma.Checked);
      T2 := Now();
      Screen.Cursor := crDefault;
      btnBigIntElapsed.Caption := Format('%d ms', [MilliSecondsBetween(T2, T1)]);
      btnBigIntHint.Caption := IntToStr(Length(mmoBigIntC.Text));
    end;
end;

procedure TFormMain.saveFont;
begin
  if writeable then
  begin
    ini.WriteString('Option', 'FontName', Font.Name);
    ini.WriteInteger('Option', 'FontSize', Font.Size);
    ini.WriteBool('Option', 'FontBold', fsBold in Font.Style);
    ini.UpdateFile;
  end;
end;

function TFormMain.BufferToStr(buf: TByteArray; N: integer): string;
var
  i: integer;
begin
  Result := '';
  for i := 0 to N - 1 do
  begin
    if (buf[i] < 128) and (buf[i] > 31) then
      Result := Result + Chr(buf[i])
    else
      Result := Result + '.';
  end;
end;

function TFormMain.BufferToHEX(buf: TByteArray; N: integer): string;
var
  i: integer;
begin
  Result := '';
  for i := 0 to N - 1 do
  begin
    Result := Result + Format('%.02X ', [buf[i]]);
  end;
end;

function TFormMain.BufferToPyStr(buf: TByteArray; N: integer): string;
var
  i: integer;
begin
  Result := '';
  for i := 0 to N - 1 do
  begin
    Result := Result + Format('\x%.02X', [buf[i]]);
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
    Result := Result + IntToHex(b[3 - i], 2);
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
    Result := Result + IntToHex(b[7 - i], 2);
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

function TFormMain.StrBytesToChrs(s: string; Len: integer): string;
var
  i: integer;
  b: byte;
begin
  Result := '';
  if Length(s) < Len then
    Len := Length(s);
  for i := 1 to Len do
  begin
    b := Chr2ToByte(s[i * 3 - 2], s[i * 3 - 1]);
    if (b < 128) and (b > 31) then
      Result := Result + Chr(b)
    else
      Result := Result + '.';
  end;
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
