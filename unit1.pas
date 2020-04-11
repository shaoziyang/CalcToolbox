unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  LCLType, ExtCtrls, Buttons, Grids, lclintf, DateUtils, Math,
  Clipbrd, Menus, ValEdit, Spin, process,
  IniFiles, Types,
  SynEdit, SynHighlighterPas, SynHighlighterCpp,
  uPSComponent,
  UBigFloatV3,
  //UBigIntsForFloatV4,
  UBigIntsV5,
  SynEditTypes, SynHighlighterPython, RichMemo;

const
  GITHUB_URL = 'https://github.com/shaoziyang/CalcToolbox';
  GITEE_URL = 'https://gitee.com/shaoziyang/CalcToolbox';
  VERSION = '0.9';
  OUTPUT_MAX_LINES = 4096;

{$ifdef Windows}
  MICROPYTHON_BIN_NAME = '\micropython.exe';
{$else}
{$ifdef Linux}
  MICROPYTHON_BIN_NAME = '/micropython';
{$endif}
{$endif}

type
  SingleBytes = array[0..3] of byte;
  DoubleBytes = array[0..7] of byte;

  { TFormMain }

  TFormMain = class(TForm)
    ApplicationProperties: TApplicationProperties;
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
    btnClear_Calc: TToolButton;
    btnHelp_Calc: TToolButton;
    btnNew_Calc: TToolButton;
    btnOpenGITEE: TSpeedButton;
    btnOpenGITHUB: TSpeedButton;
    btnOpenGITHUB1: TSpeedButton;
    btnExit: TSpeedButton;
    btnCaret_MPY: TToolButton;
    btnClear_MPY: TToolButton;
    btnHelp_MPY: TToolButton;
    btnNew_MPY: TToolButton;
    btnOpen_Calc: TToolButton;
    btnOpen_MPY: TToolButton;
    btnRun_Calc: TToolButton;
    btnRun_MPY: TToolButton;
    btnSaveAs_Calc: TToolButton;
    btnSave_Calc: TToolButton;
    btnSave_MPY: TToolButton;
    btnSaveAs_MPY: TToolButton;
    btnStop_Calc: TToolButton;
    btnStop_MPY: TToolButton;
    cbbCalc: TComboBox;
    chkBigIntComma: TCheckBox;
    chkCrcInvOut: TCheckBox;
    chkCrcInvIn: TCheckBox;
    dlgOpen_Calc: TOpenDialog;
    dlgSave_Calc: TSaveDialog;
    edtConvertTimeWeek: TLabeledEdit;
    edtConvertTimeYHour: TLabeledEdit;
    edtConvertTimeYMin: TLabeledEdit;
    edtConvertTimeYSec: TLabeledEdit;
    edtConvertTimeYWeek: TLabeledEdit;
    edtConvertTimeYDay: TLabeledEdit;
    edtPythonConvertTime: TEdit;
    edtConvertTime: TEdit;
    edtConvertTimeUTC: TEdit;
    edtBigFloatPrec: TEdit;
    edtBytesNum: TEdit;
    edtCrcXOROUT: TEdit;
    edtCrcResult: TEdit;
    edtCrcPolygon: TEdit;
    edtCrcInitV: TEdit;
    ilMain: TImageList;
    ilDigit: TImageList;
    ilOption: TImageList;
    ilTray: TImageList;
    ilAB: TImageList;
    imgLaz: TImage;
    imgLogo: TImage;
    imgLogo1: TImage;
    lbName: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtConvertTimeYear: TLabeledEdit;
    edtConvertTimeMonth: TLabeledEdit;
    edtConvertTimeDay: TLabeledEdit;
    edtConvertTimeHour: TLabeledEdit;
    edtConvertTimeMin: TLabeledEdit;
    edtConvertTimeSec: TLabeledEdit;
    Label5: TLabel;
    lbFont: TLabel;
    lbVer: TLabel;
    miPascalScriptHelpDemo10: TMenuItem;
    miPascalScriptHelpDemo5: TMenuItem;
    miPascalScriptHelpDemo4: TMenuItem;
    miPascalScriptHelpDemo3: TMenuItem;
    miPascalScriptHelpDemo2: TMenuItem;
    miPascalScriptHelpDemo1: TMenuItem;
    miPascalScriptHelpDemo6: TMenuItem;
    miPascalScriptHelpDemo7: TMenuItem;
    miPascalScriptHelpDemo8: TMenuItem;
    miPascalScriptHelpDemo9: TMenuItem;
    mmoOutCalc: TMemo;
    mmoOutPascalScript: TMemo;
    dlgOpen_PascalScript: TOpenDialog;
    mmoOutMPY: TMemo;
    mmoOut_Temp: TMemo;
    dlgOpen_MPY: TOpenDialog;
    Panel3: TPanel;
    pmHelp_Calc: TPopupMenu;
    pmHis_Calc: TPopupMenu;
    pnlCalc: TPanel;
    pcScript: TPageControl;
    pcConvert: TPageControl;
    pmTrayShow: TMenuItem;
    miTrayOption: TMenuItem;
    miTrayExit: TMenuItem;
    N1: TMenuItem;
    mmoBufferStr: TMemo;
    mmoBufferHEX: TMemo;
    mmoBufferPython: TMemo;
    mmoBigFloatA: TMemo;
    mmoBigIntA: TMemo;
    mmoBigFloatB: TMemo;
    mmoBigIntB: TMemo;
    mmoBigIntC: TMemo;
    mmoCRC: TMemo;
    mmoBigFloatC: TMemo;
    PageControl1: TPageControl;
    pcAbout: TPageControl;
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
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    pnlBigIntA: TPanel;
    pcDigit: TPageControl;
    pcMain: TPageControl;
    pmTray: TPopupMenu;
    pmHis_PascalScript: TPopupMenu;
    pmHelp_PascalScript: TPopupMenu;
    pmHis_MPY: TPopupMenu;
    pmHelp_MPY: TPopupMenu;
    ProcessMPY: TProcess;
    dlgSave_MPY: TSaveDialog;
    rmoAboutReadme: TRichMemo;
    rmoAboutChangeLog: TRichMemo;
    Script_Pascal: TPSScript;
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
    dlgSave_PascalScript: TSaveDialog;
    Script_Calc: TPSScript;
    sgBytes: TStringGrid;
    sgBase: TStringGrid;
    sgVar_Calc: TStringGrid;
    btnShowOption: TSpeedButton;
    btnConvertTimeNow: TSpeedButton;
    edtBaseCustom: TSpinEdit;
    Shape2: TShape;
    Splitter1: TSplitter;
    Splitter10: TSplitter;
    Splitter11: TSplitter;
    Splitter12: TSplitter;
    Splitter2: TSplitter;
    Splitter3: TSplitter;
    sgConstantMath: TStringGrid;
    Splitter4: TSplitter;
    Splitter5: TSplitter;
    Splitter6: TSplitter;
    Splitter9: TSplitter;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    StaticText4: TStaticText;
    StaticText5: TStaticText;
    StaticText6: TStaticText;
    StaticText7: TStaticText;
    StaticText8: TStaticText;
    StaticText9: TStaticText;
    SynEditFunc_Calc: TSynEdit;
    SynEditPascalScript: TSynEdit;
    SynEditMPY: TSynEdit;
    SynPasSyn: TSynPasSyn;
    SynPythonSyn: TSynPythonSyn;
    TabSheet1: TTabSheet;
    btnCaret_PascalScript: TToolButton;
    ToolBar10: TToolBar;
    ToolButton23: TToolButton;
    ToolButton36: TToolButton;
    tsCalc: TTabSheet;
    ToolBar9: TToolBar;
    ToolButton28: TToolButton;
    ToolButton35: TToolButton;
    tsMicropython: TTabSheet;
    ToolBar8: TToolBar;
    btnNew_PascalScript: TToolButton;
    btnOpen_PascalScript: TToolButton;
    btnSave_PascalScript: TToolButton;
    btnSaveAs_PascalScript: TToolButton;
    btnRun_PascalScript: TToolButton;
    btnClear_PascalScript: TToolButton;
    ToolButton17: TToolButton;
    ToolButton34: TToolButton;
    btnStop_PascalScript: TToolButton;
    btnHelp_PascalScript: TToolButton;
    tsPascalScript: TTabSheet;
    tsScript: TTabSheet;
    tsChangeLog: TTabSheet;
    tsReadme: TTabSheet;
    tsConvertTime: TTabSheet;
    tsConvert: TTabSheet;
    TrayIcon: TTrayIcon;
    tsBuffer: TTabSheet;
    tbBigInt: TToolBar;
    tmrLogo: TTimer;
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
    tsBytes: TTabSheet;
    tbByteErr: TToolButton;
    ToolBar3: TToolBar;
    ToolBar6: TToolBar;
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
    procedure btnClear_CalcClick(Sender: TObject);
    procedure btnClear_MPYClick(Sender: TObject);
    procedure btnClear_PascalScriptClick(Sender: TObject);
    procedure btnConvertTimeNowClick(Sender: TObject);
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
    procedure btnNew_CalcClick(Sender: TObject);
    procedure btnNew_MPYClick(Sender: TObject);
    procedure btnNew_PascalScriptClick(Sender: TObject);
    procedure btnOpenGITEEClick(Sender: TObject);
    procedure btnOpenGITHUBClick(Sender: TObject);
    procedure btnOpen_CalcClick(Sender: TObject);
    procedure btnOpen_MPYClick(Sender: TObject);
    procedure btnOpen_PascalScriptClick(Sender: TObject);
    procedure btnRun_CalcClick(Sender: TObject);
    procedure btnRun_MPYClick(Sender: TObject);
    procedure btnRun_PascalScriptClick(Sender: TObject);
    procedure btnSaveAs_CalcClick(Sender: TObject);
    procedure btnSaveAs_MPYClick(Sender: TObject);
    procedure btnSaveAs_PascalScriptClick(Sender: TObject);
    procedure btnSave_CalcClick(Sender: TObject);
    procedure btnSave_MPYClick(Sender: TObject);
    procedure btnSave_PascalScriptClick(Sender: TObject);
    procedure btnStop_CalcClick(Sender: TObject);
    procedure btnStop_MPYClick(Sender: TObject);
    procedure btnStop_PascalScriptClick(Sender: TObject);
    procedure btnShowOptionClick(Sender: TObject);
    procedure cbbCalcKeyPress(Sender: TObject; var Key: char);
    procedure cbbCalcMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure edtBigFloatPrecEditingDone(Sender: TObject);
    procedure edtBytesNumChange(Sender: TObject);
    procedure edtConvertTimeEditingDone(Sender: TObject);
    procedure edtConvertTimeUTCEditingDone(Sender: TObject);
    procedure edtConvertTimeYearEditingDone(Sender: TObject);
    procedure edtCrcResultClick(Sender: TObject);
    procedure edtPythonConvertTimeEditingDone(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormWindowStateChange(Sender: TObject);
    procedure imgLazClick(Sender: TObject);
    procedure lbVerClick(Sender: TObject);
    procedure miTrayExitClick(Sender: TObject);
    procedure mmoBigFloatCMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure mmoBigIntCMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure mmoBufferPythonMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure Script_PascalCompile(Sender: TPSScript);
    procedure rbBigBytesChange(Sender: TObject);
    procedure sgBytesEditingDone(Sender: TObject);
    procedure sgConstantMathClick(Sender: TObject);
    procedure sgBaseEditingDone(Sender: TObject);
    procedure edtBaseCustomChange(Sender: TObject);
    procedure sgVar_CalcEditingDone(Sender: TObject);
    procedure SynEditMPYChange(Sender: TObject);
    procedure SynEditMPYStatusChange(Sender: TObject; Changes: TSynStatusChanges);
    procedure SynEditPascalScriptChange(Sender: TObject);
    procedure SynEditPascalScriptStatusChange(Sender: TObject;
      Changes: TSynStatusChanges);
    procedure tmrAlphaTimer(Sender: TObject);
    procedure btnCrc_CRC4_ITUClick(Sender: TObject);
    procedure btnCrc_CRC8_ITUClick(Sender: TObject);
    procedure btnCrc_CRC16_CCITT_FALSEClick(Sender: TObject);
    procedure btnCrc_CRC32_MPEG2Click(Sender: TObject);
    procedure tmrLogoTimer(Sender: TObject);
    procedure TrayIconClick(Sender: TObject);
  private

    winstat: TWindowState;

    DateTimefmt: TFormatSettings;
    function getCrcBit: integer;
    procedure setCrcBit(bit: integer);
    procedure bfCalc(Sender: TObject);
    procedure biCalc(Sender: TObject);
    procedure saveFont;

  private
    Compiled_PascalScript: boolean;
    EditorAutoSaveFileName_PascalScript: string;
    EditorAutoSaveFileName_micropython: string;
    EditorAutoSaveFileName_calc: string;

    Script_Calc_CodeVar, Script_Calc_CodeFunc, Script_Calc_CodeMain: string;

    procedure mmoOutAdd(var mmo: TMemo; msg: string);

    function shortFileName(FileName: string): string;
    procedure mmoOutAdd_PascalScript(msg: string);
    procedure mmoOutAdd_MPY(msg: string);
    procedure mmoOutAdd_Calc(msg: string);

    procedure pmAddHis(var pm: TPopupMenu; FileName: string);
    procedure pmHisClick_PascalScript(Sender: TObject);
    procedure pmHisClick_MPY(Sender: TObject);
    procedure pmHisClick_Calc(Sender: TObject);

    procedure LoadFile_PascalScript(FileName: string);
    procedure SaveFile_PascalScript(FileName: string);
    procedure LoadFile_MPY(FileName: string);
    procedure SaveFile_MPY(FileName: string);
    procedure LoadFile_Calc(FileName: string);
    procedure SaveFile_Calc(FileName: string);

  public
    MinimizeToTray, CloseToTray: boolean;
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
    procedure updateTime(d: TDateTime);

    procedure updateTabVisible;
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
  uCRC, uBase, unit2;


{$R *.lfm}

{$I NewFileTemplate.pas}

{ pascal script addon functions
}

procedure PSsprint_Calc(sep: string; v: array of variant);
var
  i: integer;
  s, ss: string;
begin
  s := '';
  for i := low(v) to high(v) do
  begin
    ss := v[i];
    s  := s + ss;
    if i < high(v) then
      s := s + sep;
  end;
  FormMain.mmoOutAdd_Calc(s);
  Application.ProcessMessages;
end;

procedure PSprint_Calc(v: array of variant);
var
  i: integer;
  s, ss: string;
begin
  s := '';
  for i := low(v) to high(v) do
  begin
    ss := v[i];
    s  := s + ss;
  end;
  FormMain.mmoOutAdd_Calc(s);
  Application.ProcessMessages;
end;

procedure PSWrite_Calc(const s: variant);
var
  ss: string;
begin
  ss := s;
  FormMain.mmoOutAdd_Calc(ss);
end;

procedure PSWriteln_Calc(const s: variant);
begin
  PSWrite_Calc(s);
  FormMain.mmoOutCalc.Lines.Add('');
end;

procedure PSsprint(sep: string; v: array of variant);
var
  i: integer;
  s, ss: string;
begin
  s := '';
  for i := low(v) to high(v) do
  begin
    ss := v[i];
    s  := s + ss;
    if i < high(v) then
      s := s + sep;
  end;
  FormMain.mmoOutAdd_PascalScript(s);
  Application.ProcessMessages;
end;

procedure PSprint(v: array of variant);
var
  i: integer;
  s, ss: string;
begin
  s := '';
  for i := low(v) to high(v) do
  begin
    ss := v[i];
    s  := s + ss;
  end;
  FormMain.mmoOutAdd_PascalScript(s);
  Application.ProcessMessages;
end;

procedure PSWrite(const s: variant);
var
  ss: string;
begin
  ss := s;
  FormMain.mmoOutAdd_PascalScript(ss);
end;

procedure PSWriteln(const s: variant);
begin
  PSWrite(s);
  FormMain.mmoOutPascalScript.Lines.Add('');
end;

function PSlog(x: extended): extended;
begin
  Result := ln(x);
end;

function PSlog10(x: extended): extended;
begin
  Result := log10(x);
end;

function PSPower(x, y: extended): extended;
begin
  Result := power(x, y);
  random;
end;

function PSExp(x: extended): extended;
begin
  Result := exp(x);
end;

function PSRandom: extended;
begin
  Result := Random;
end;

function PSRandomRange(x, y: integer): integer;
begin
  Result := Randomrange(x, y);
end;

function PSReadln(const question: string): string;
begin
  Result := InputBox(question, '', '');
end;

procedure PSclear;
begin
  FormMain.mmoOutPascalScript.Lines.Clear;
end;

procedure PSsleep(x: integer = 1000);
begin
  Sleep(x);
  Application.ProcessMessages;
end;

procedure PSbeep;
begin
  beep;
end;

{ pascal script end }


{ TFormMain }

procedure TFormMain.FormCreate(Sender: TObject);
var
  i: integer;
  s: string;
begin

  path := ExtractFilePath(Application.ExeName);
  ini  := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));

  lbVer.Caption := 'ver ' + VERSION;

  tsConstant.TabVisible := False;

  DateTimefmt.ShortDateFormat := 'yyyy-mm-dd';
  DateTimefmt.DateSeparator   := '-';
  DateTimefmt.TimeSeparator   := ':';
  DateTimefmt.LongTimeFormat  := 'hh:nn:ss';


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
    lbFont.Font.Name := ini.ReadString('Option', 'FontName', Font.Name);
    lbFont.Font.Size := ini.ReadInteger('Option', 'FontSize', Font.Size);
    lbFont.Font.Size := max(min(lbFont.Font.Size, 24), 7);
    if ini.ReadBool('Option', 'FontBold', False) then
    begin
      lbFont.Font.Style := [fsBold];
    end;
    Font := lbFont.Font;

    TrayIcon.Visible := ini.ReadBool('Option', 'TrayIcon', True);
    MinimizeToTray   := ini.ReadBool('Option', 'MinimizeToTray', True);
    CloseToTray      := ini.ReadBool('Option', 'CloseToTray', True);

    // visible
    updateTabVisible;

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

    // Calc
    EditorAutoSaveFileName_calc :=      ExtractFilePath(Application.ExeName) + 'autosave.calc';

    if FileExists(EditorAutoSaveFileName_calc) then
      LoadFile_Calc(EditorAutoSaveFileName_calc)
    else
    btnNew_CalcClick(Sender);

    for i := 1 to ini.ReadInteger('HisFile_Calc', 'Count', 0) do
      pmAddHis(pmHis_Calc, ini.ReadString('HisFile_Calc', IntToStr(i), ''));

    cbbCalc.Text      := ini.ReadString('calc', 'express', '');
    pnlCalc.Width     := ini.ReadInteger('calc', 'width', 300);
    sgVar_Calc.Height := ini.ReadInteger('calc', 'var', 128);
    sgVar_Calc.ColWidths[0] := ini.ReadInteger('calc', 'col0', 40);
    sgVar_Calc.ColWidths[2] := ini.ReadInteger('calc', 'col2', 80);
    cbbCalc.Items.CommaText := ini.ReadString('calc', 'exphis', '');

    // Convert Time
    btnConvertTimeNowClick(nil);

    // Script
    tsScript.TabVisible := tsPascalScript.TabVisible;

    // pascal script
    SynEditPascalScript.Height := ini.ReadInteger('PascalScript', 'Height', 300);
    EditorAutoSaveFileName_PascalScript :=
      ExtractFilePath(Application.ExeName) + 'autosave.pas';
    if FileExists(EditorAutoSaveFileName_PascalScript) then
      SynEditPascalScript.Lines.LoadFromFile(EditorAutoSaveFileName_PascalScript)
    else
      btnNew_PascalScriptClick(Sender);

    for i := 1 to ini.ReadInteger('HisFile_PascalScript', 'Count', 0) do
      pmAddHis(pmHis_PascalScript, ini.ReadString('HisFile_PascalScript',
        IntToStr(i), ''));

    Compiled_PascalScript := False;

    // micropython
    SynEditMPY.Height := ini.ReadInteger('micropython', 'Height', 300);
    EditorAutoSaveFileName_micropython :=
      ExtractFilePath(Application.ExeName) + 'autosave.py';
    if FileExists(EditorAutoSaveFileName_micropython) then
      SynEditMPY.Lines.LoadFromFile(EditorAutoSaveFileName_micropython)
    else
      btnNew_MPYClick(Sender);

    for i := 1 to ini.ReadInteger('HisFile_micropython', 'Count', 0) do
      pmAddHis(pmHis_MPY, ini.ReadString('HisFile_micropython', IntToStr(i), ''));

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

  SynEditFunc_Calc.Modified := True;
  sgVar_Calc.Modified := True;

  lbName.Tag := 1;
end;

procedure TFormMain.FormDestroy(Sender: TObject);
var
  i: integer;
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

      // Calc
      SaveFile_Calc(EditorAutoSaveFileName_calc);

      ini.EraseSection('HisFile_Calc');
      ini.WriteInteger('HisFile_Calc', 'Count', pmHis_Calc.Items.Count);
      for i := 0 to pmHis_Calc.Items.Count - 1 do
        ini.WriteString('HisFile_Calc', IntToStr(i + 1), pmHis_Calc.Items[i].Caption);

      ini.WriteString('calc', 'express', cbbCalc.Text);
      ini.WriteInteger('calc', 'width', pnlCalc.Width);
      ini.WriteInteger('calc', 'var', sgVar_Calc.Height);
      ini.WriteInteger('calc', 'col0', sgVar_Calc.ColWidths[0]);
      ini.WriteInteger('calc', 'col2', sgVar_Calc.ColWidths[2]);
      ini.WriteString('calc', 'exphis', cbbCalc.Items.CommaText);

      // Script
      ini.WriteInteger('last', 'page_script', pcScript.ActivePageIndex);

      // pascal script
      ini.WriteInteger('PascalScript', 'Height', SynEditPascalScript.Height);
      SynEditPascalScript.Lines.SaveToFile(EditorAutoSaveFileName_PascalScript);

      ini.EraseSection('HisFile_PascalScript');
      ini.WriteInteger('HisFile_PascalScript', 'Count', pmHis_PascalScript.Items.Count);
      for i := 0 to pmHis_PascalScript.Items.Count - 1 do
        ini.WriteString('HisFile_PascalScript', IntToStr(i + 1),
          pmHis_PascalScript.Items[i].Caption);

      // micropython
      ini.WriteInteger('micropython', 'Height', SynEditMPY.Height);
      SynEditMPY.Lines.SaveToFile(EditorAutoSaveFileName_micropython);

      ini.EraseSection('HisFile_micropython');
      ini.WriteInteger('HisFile_micropython', 'Count', pmHis_PascalScript.Items.Count);
      for i := 0 to pmHis_MPY.Items.Count - 1 do
        ini.WriteString('HisFile_micropython', IntToStr(i + 1),
          pmHis_MPY.Items[i].Caption);


      // update ini
      ini.UpdateFile;
    end;
  finally
    if bfA <> nil then
      bfA.Free;
    if bfB <> nil then
      bfB.Free;
    if biA <> nil then
      biA.Free;
    if biB <> nil then
      biB.Free;

    ini.Free;
  end;
end;

procedure TFormMain.FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  case Key of
    VK_F9:
    begin
      if pcMain.ActivePage = tsScript then
      begin
        if pcScript.ActivePage = tsPascalScript then
          btnRun_PascalScriptClick(Sender)
        else if pcScript.ActivePage = tsMicropython then
          btnRun_MPYClick(Sender);
      end
      else if pcMain.ActivePage = tsCalc then
        btnRun_CalcClick(Sender);
    end;
    VK_S:
    begin
      if Shift = [ssCtrl] then
      begin
        if pcMain.ActivePage = tsScript then
        begin
          if pcScript.ActivePage = tsPascalScript then
          begin
            if btnSave_PascalScript.Enabled then
              btnSave_PascalScriptClick(Sender);
          end
          else if pcScript.ActivePage = tsMicropython then
          begin
            if btnSave_MPY.Enabled then
              btnSave_MPYClick(Sender);
          end;
        end
        else if pcMain.ActivePage = tsCalc then
        begin
          btnSave_CalcClick(Sender);
        end;
      end;
    end;
  end;
end;

procedure TFormMain.FormShow(Sender: TObject);
begin
  tmrAlpha.Tag     := 1;
  tmrAlpha.Enabled := True;
end;

procedure TFormMain.FormWindowStateChange(Sender: TObject);
begin
  if WindowState = wsMinimized then
  begin
    if TrayIcon.Visible and MinimizeToTray then
      Hide;
  end
  else
    winstat := WindowState;
end;

procedure TFormMain.imgLazClick(Sender: TObject);
begin
  OpenURL('http://www.lazarus-ide.org/');
end;

procedure TFormMain.lbVerClick(Sender: TObject);
begin
  Caption := IntToStr(TLabel(Sender).Tag);
  pcAbout.PageIndex := TLabel(Sender).Tag;
end;

procedure TFormMain.miTrayExitClick(Sender: TObject);
begin
  TrayIcon.Visible := False;
  Close;
end;

procedure TFormMain.mmoBigFloatCMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  if mmoBigFloatC.SelLength = 0 then
  begin
    btnBigFloatHint.Caption := IntToStr(Length(mmoBigFloatC.Text));
    if mmoBigFloatC.Text <> '' then
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
    if mmoBigIntC.Text <> '' then
      Clipboard.AsText := mmoBigIntC.Text;
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

procedure TFormMain.Script_PascalCompile(Sender: TPSScript);
begin
  if Sender = Script_Pascal then
  begin
    Sender.AddFunction(@PSprint, 'procedure print(v:array of Variant);');
    Sender.AddFunction(@PSsprint, 'procedure sprint(sep:string; v:array of Variant);');
    Sender.AddFunction(@PSwriteln, 'procedure Writeln(s: Variant);');
    Sender.AddFunction(@PSwrite, 'procedure Write(s: Variant);');
  end
  else
  begin
    Sender.AddFunction(@PSprint_Calc, 'procedure print(v:array of Variant);');
    Sender.AddFunction(@PSsprint_Calc,
      'procedure sprint(sep:string; v:array of Variant);');
    Sender.AddFunction(@PSwriteln_Calc, 'procedure Writeln(s: Variant);');
    Sender.AddFunction(@PSwrite_Calc, 'procedure Write(s: Variant);');
  end;
  Sender.AddFunction(@PSreadln, 'function Readln(question: string): string;');
  Sender.AddFunction(@PSreadln, 'function Read(question: string): string;');
  Sender.AddFunction(@PSlog, 'function ln(x: extended): extended;');
  Sender.AddFunction(@PSlog10, 'function log10(x: extended): extended;');
  Sender.AddFunction(@PSexp, 'function exp(x: extended): extended;');
  Sender.AddFunction(@PSpower, 'function power(x,y: extended): extended;');
  Sender.AddFunction(@PSRandom, 'function random: extended;');
  Sender.AddFunction(@PSRandomRange, 'function RandomRange(x,y: integer): integer;');
  Sender.AddFunction(@PSclear, 'procedure clear;');
  Sender.AddFunction(@PSbeep, 'procedure beep;');
  Sender.AddFunction(@PSsleep, 'procedure sleep(x:integer);');
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

procedure TFormMain.edtConvertTimeEditingDone(Sender: TObject);
var
  d: TDateTime;
begin
  if TryStrToDateTime(edtConvertTime.Text, d, DateTimefmt) then
    updateTime(d);
end;

procedure TFormMain.edtConvertTimeUTCEditingDone(Sender: TObject);
var
  d: TDateTime;
  n: int64;
begin
  try
    if TryStrToInt64(edtConvertTimeUTC.Text, n) then
    begin
      d := UnixToDateTime(n);
      updateTime(d);
    end;
  except
  end;
end;

procedure TFormMain.edtConvertTimeYearEditingDone(Sender: TObject);
var
  d: TDateTime;
  year, mon, day, hour, min, sec: dword;
begin
  year := 0;
  mon  := 0;
  day  := 0;
  hour := 0;
  min  := 0;
  sec  := 0;
  TryStrToDWord(edtConvertTimeYear.Text, year);
  TryStrToDWord(edtConvertTimeMonth.Text, mon);
  TryStrToDWord(edtConvertTimeDay.Text, day);
  TryStrToDWord(edtConvertTimeHour.Text, hour);
  TryStrToDWord(edtConvertTimeMin.Text, min);
  TryStrToDWord(edtConvertTimeSec.Text, sec);
  if TryEncodeDateTime(year, mon, day, hour, min, sec, 0, d) then
    updateTime(d);
end;

procedure TFormMain.edtCrcResultClick(Sender: TObject);
begin
  if edtCrcResult.Text <> '' then
    Clipboard.AsText := edtCrcResult.Text;
end;

procedure TFormMain.edtPythonConvertTimeEditingDone(Sender: TObject);
var
  d: TDateTime;
  ss: TStringList;
  i: integer;
  year, mon, day, hour, min, sec: dword;
begin
  ss := TStringList.Create;
  try
    try
      if ExtractStrings([','], [' ', '(', ')'], PChar(edtPythonConvertTime.Text),
        ss) > 5 then
      begin
        year := 0;
        mon  := 0;
        day  := 0;
        hour := 0;
        min  := 0;
        sec  := 0;
        TryStrToDWord(ss[0], year);
        TryStrToDWord(ss[1], mon);
        TryStrToDWord(ss[2], day);
        TryStrToDWord(ss[3], hour);
        TryStrToDWord(ss[4], min);
        TryStrToDWord(ss[5], sec);
        if TryEncodeDateTime(year, mon, day, hour, min, sec, 0, d) then
          updateTime(d);
      end;
    except

    end
  finally
    ss.Free;
  end;
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
              d := StrToBase(s, 8, False, system.MaxInt);
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

procedure TFormMain.btnClear_CalcClick(Sender: TObject);
begin
  mmoOutCalc.Clear;
end;

procedure TFormMain.btnClear_MPYClick(Sender: TObject);
begin
  mmoOutMPY.Clear;
end;

procedure TFormMain.btnClear_PascalScriptClick(Sender: TObject);
begin
  mmoOutPascalScript.Clear;
end;

procedure TFormMain.btnConvertTimeNowClick(Sender: TObject);
begin
  updateTime(Now);
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
  if TrayIcon.Visible and CloseToTray then
  begin
    CanClose := False;
    Hide;
  end
  else
  begin
    CanClose     := tmrAlpha.Tag = 4;
    tmrAlpha.Tag := 3;
    tmrAlpha.Enabled := True;
  end;
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
      1..4:// int8-int64
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
      6:// float32
      begin
        try
          StrToBytes(ss, 4, pb);
          ps := @pb;
          fs := ps^;
          edtBytesNum.Text := FloatToStr(fs);
        except

        end;
      end;
      8:// float64
      begin
        try
          StrToBytes(ss, 8, pb);
          pd := @pb;
          fd := pd^;
          edtBytesNum.Text := FloatToStr(fd);
        except

        end;
      end;
      11: // hex
      begin
        StrToByteBuf(ss, s);
        sgBytes.Cells[1, 11] := s;
        i := (Length(s) + 2) div 3;
        StrToBytes(s, i, pb);
        sgBytes.Cells[1, 12] := BufferToStr(pb, i);
      end;
      12: // string
      begin
        s := '';
        for i := 1 to Length(ss) do
          s := s + Format('%.02X ', [Ord(ss[i])]);
        sgBytes.Cells[1, 11] := s;
      end;
    end;
    if sy <= 8 then
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
  if TStringGrid(Sender).Cells[sx, sy] <> '' then
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
    1: base := 2;
    2: base := 8;
    3: base := 10;
    4: base := 16;
    5: base := edtBaseCustom.Value;
    else
      Exit;
  end;

  dat := StrToBase(s, base, neg, system.MaxInt);

  sgBase.Cells[1, 1] := BaseToStr(dat, 1, 2, neg, '0');
  sgBase.Cells[1, 2] := BaseToStr(dat, 1, 8, neg, '0');
  sgBase.Cells[1, 3] := BaseToStr(dat, 1, 10, neg, '0');
  sgBase.Cells[1, 4] := BaseToStr(dat, 1, 16, neg, '0');
  sgBase.Cells[1, 5] := BaseToStr(dat, 1, edtBaseCustom.Value, neg, '0');

end;

procedure TFormMain.edtBaseCustomChange(Sender: TObject);
begin
  sgBase.Cells[0, 5] := 'custom[' + IntToStr(edtBaseCustom.Value) + ']';
  sgBase.Selection   := Rect(1, 5, 1, 5);
  sgBaseEditingDone(Sender);
end;

procedure TFormMain.sgVar_CalcEditingDone(Sender: TObject);
var
  i: integer;
  s: string;
begin
  i := 1;
  while i < sgVar_Calc.RowCount do
  begin
    s := Trim(sgVar_Calc.Cells[0, i]);
    if (s = '') then
    begin
      sgVar_Calc.DeleteRow(i);
    end
    else
    begin
      sgVar_Calc.Cells[0, i] := s;
      sgVar_Calc.Cells[1, i] := Trim(sgVar_Calc.Cells[1, i]);
      s := Trim(sgVar_Calc.Cells[2, i]);
      if (s <> 'variant') and (s <> 'integer') and (s <> 'double') and
        (s <> 'string') then
        sgVar_Calc.Cells[2, i] := 'variant';
      i := i + 1;
    end;
  end;

  if sgVar_Calc.RowCount < 2 then
    sgVar_Calc.RowCount := 2;

  if sgVar_Calc.Cells[0, sgVar_Calc.RowCount - 1] <> '' then
    sgVar_Calc.RowCount := sgVar_Calc.RowCount + 1;

end;

procedure TFormMain.SynEditMPYChange(Sender: TObject);
begin
  btnSave_MPY.Enabled := SynEditMPY.Modified;


  btnSaveAs_MPY.Enabled := SynEditMPY.Modified;
end;

procedure TFormMain.SynEditMPYStatusChange(Sender: TObject; Changes: TSynStatusChanges);
begin
  btnCaret_MPY.Caption := IntToStr(SynEditMPY.CaretX) + ', ' +
    IntToStr(SynEditMPY.CaretY);
  if SynEditMPY.SelAvail then
    btnCaret_MPY.Caption := btnCaret_MPY.Caption + ' Sel: ' +
      IntToStr(Length(SynEditMPY.SelText));
end;

procedure TFormMain.SynEditPascalScriptChange(Sender: TObject);
begin
  Compiled_PascalScript := False;
  btnSave_PascalScript.Enabled := SynEditPascalScript.Modified;
  btnSaveAs_PascalScript.Enabled := SynEditPascalScript.Modified;
end;

procedure TFormMain.SynEditPascalScriptStatusChange(Sender: TObject;
  Changes: TSynStatusChanges);
begin
  btnCaret_PascalScript.Caption :=
    IntToStr(SynEditPascalScript.CaretX) + ', ' + IntToStr(SynEditPascalScript.CaretY);
  if SynEditPascalScript.SelAvail then
    btnCaret_PascalScript.Caption :=
      btnCaret_PascalScript.Caption + ' Sel: ' +
      IntToStr(Length(SynEditPascalScript.SelText));
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
      begin
        FormMain.OnShow  := nil;
        tmrAlpha.Enabled := False;
      end;
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

procedure TFormMain.btnNew_CalcClick(Sender: TObject);
begin
  sgVar_Calc.Clean;
  sgVar_Calc.Modified := True;
  sgVar_Calc.RowCount := 4;
  sgVar_Calc.Rows[1].CommaText := 'x,12,variant';
  sgVar_Calc.Rows[2].CommaText := 'y,5.6,variant';

  SynEditFunc_Calc.Text     := NewFileTemplate_Calc;
  SynEditFunc_Calc.Modified := True;
  btnSave_Calc.Enabled      := False;
  btnSaveAs_Calc.Enabled    := False;
  dlgSave_Calc.FileName     := '';
end;

procedure TFormMain.btnNew_MPYClick(Sender: TObject);
begin
  if Sender <> nil then
    SynEditMPY.Text     := NewFileTemplate_MPY;
  SynEditMPY.Modified   := False;
  btnSave_MPY.Enabled   := False;
  btnSaveAs_MPY.Enabled := False;
  tsMicropython.Caption := 'micropython';
  dlgSave_Calc.FileName := '';
end;

procedure TFormMain.btnNew_PascalScriptClick(Sender: TObject);
begin
  if Sender <> nil then
    SynEditPascalScript.Text := NewFileTemplate_PascalScript;
  SynEditPascalScript.Modified := False;
  btnSave_PascalScript.Enabled := False;
  btnSaveAs_PascalScript.Enabled := False;
  tsPascalScript.Caption := 'Pascal';
  dlgSave_PascalScript.FileName := '';
  Compiled_PascalScript  := False;
end;

procedure TFormMain.btnOpenGITEEClick(Sender: TObject);
begin
  OpenURL(GITEE_URL);
end;

procedure TFormMain.btnOpenGITHUBClick(Sender: TObject);
begin
  OpenURL(GITHUB_URL);
end;

procedure TFormMain.btnOpen_CalcClick(Sender: TObject);
begin
  if dlgOpen_Calc.Execute then
  begin
    LoadFile_Calc(dlgOpen_Calc.FileName);
    pmAddHis(pmHis_Calc, dlgOpen_Calc.FileName);
  end;
end;

procedure TFormMain.btnOpen_MPYClick(Sender: TObject);
begin
  if dlgOpen_MPY.Execute then
  begin
    LoadFile_MPY(dlgOpen_MPY.FileName);
    pmAddHis(pmHis_MPY, dlgOpen_MPY.FileName);
  end;
end;

procedure TFormMain.btnOpen_PascalScriptClick(Sender: TObject);
begin
  if dlgOpen_PascalScript.Execute then
  begin
    LoadFile_PascalScript(dlgOpen_PascalScript.FileName);
    pmAddHis(pmHis_PascalScript, dlgOpen_PascalScript.FileName);
  end;
end;

procedure TFormMain.btnRun_CalcClick(Sender: TObject);
var
  s: string;
  res: boolean;
  i, n: integer;
begin
  cbbCalc.Text := Trim(cbbCalc.Text);

  if cbbCalc.Text = ':list' then
  begin
    mmoOutAdd_Calc(Script_Calc.Script.Text);
    Exit;
  end
  else if cbbCalc.Text = ':err' then
  begin
    if Script_Calc.CompilerMessageCount > 0 then
      for i := 0 to Script_Calc.CompilerMessageCount - 1 do
        mmoOutCalc.Lines.add(Script_Calc.CompilerErrorToStr(i))
    else
      mmoOutCalc.Lines.add('No error' + #13#10);
    Exit;
  end
  else if cbbCalc.Text = '' then
    Exit;

  btnStop_Calc.Enabled := True;
  btnRun_Calc.Enabled  := False;
  try
    try
      if sgVar_Calc.Modified then
      begin
        Script_Calc_CodeMain := 'begin' + #13#10;
        if sgVar_Calc.RowCount < 3 then
          Script_Calc_CodeVar := ''
        else
        begin
          Script_Calc_CodeVar := 'var' + #13#10;
          for i := 1 to sgVar_Calc.RowCount - 2 do
          begin
            Script_Calc_CodeVar :=
              Script_Calc_CodeVar + sgVar_Calc.Cells[0, i] + ':' +
              sgVar_Calc.Cells[2, i] + ';' + #13#10;
            if sgVar_Calc.Cells[1, i] <> '' then
            begin
              Script_Calc_CodeMain :=
                Script_Calc_CodeMain + sgVar_Calc.Cells[0, i] + ':=' +
                sgVar_Calc.Cells[1, i] + ';' + #13#10;
            end;
          end;
          Script_Calc.Script.Text := Script_Calc_CodeVar + Script_Calc_CodeMain + 'end.';
          res := Script_Calc.Compile;
          if not res then
          begin
            mmoOutCalc.Lines.Add('Variables define error!');
            mmoOutCalc.Lines.Add('');
            Beep;
            Exit;
          end;
        end;
        sgVar_Calc.Modified := False;
      end;

      if SynEditFunc_Calc.Modified then
      begin
        Script_Calc_CodeFunc := #13#10 + SynEditFunc_Calc.Text + #13#10;
        Script_Calc.Script.Text :=
          Script_Calc_CodeVar + Script_Calc_CodeFunc + Script_Calc_CodeMain + 'end.';
        res := Script_Calc.Compile;
        if not res then
        begin
          mmoOutCalc.Lines.Add('Function define error!');
          mmoOutCalc.Lines.Add('');
          Beep;
          Exit;
        end;
        SynEditFunc_Calc.Modified := False;
      end;

      // compile
      Script_Calc.Script.Text :=
        Script_Calc_CodeVar + Script_Calc_CodeFunc + Script_Calc_CodeMain +
        #13#10 + 'sprint('' '',[' + cbbCalc.Text + ']);' + #13#10 + 'End.';

      res := Script_Calc.Compile;
      if not res then
      begin
        mmoOutCalc.Lines.Add('Express error!');
        mmoOutCalc.Lines.Add('');
        Beep;
        Exit;
      end;

      Application.ProcessMessages;

      // run
      mmoOutCalc.Lines.Add('> ' + cbbCalc.Text);
      mmoOutCalc.Lines.Add('= ');
      res := Script_Calc.Execute;
      if not res then
        mmoOutCalc.Lines.add('Run-time error:' + Script_Calc.ExecErrorToString)
      else
      begin
        //mmoOutCalc.Lines.Add('');

        n := cbbCalc.Items.IndexOf(cbbCalc.Text);
        if n = -1 then
        begin
          cbbCalc.Items.Insert(0, cbbCalc.Text);
          if cbbCalc.Items.Count > 12 then
            cbbCalc.Items.Delete(12);
        end
        else
        begin
          i := cbbCalc.SelStart;
          cbbCalc.Items.Move(n, 0);
          cbbCalc.Text     := cbbCalc.Items[0];
          cbbCalc.SelStart := i;
        end;
      end;
      mmoOutCalc.Lines.Add('');
    except
      on E: Exception do
      begin
        mmoOutCalc.Lines.add(E.Message);
      end;
    end;
  finally
    btnStop_Calc.Enabled := False;
    btnRun_Calc.Enabled  := True;
  end;
end;

procedure TFormMain.btnRun_MPYClick(Sender: TObject);
var
  tmpfile: string;
  s: string;
  CharBuffer: array [0..511] of char;
  ReadCount: integer;
begin
  btnStop_MPY.Enabled := True;
  btnRun_MPY.Enabled  := False;
  try
    try
      tmpfile := GetTempFileName + '.py';
      SynEditMPY.Lines.SaveToFile(tmpfile);
      ProcessMPY.Executable :=
        ExtractFilePath(Application.ExeName) + 'micropython' + MICROPYTHON_BIN_NAME;
      ProcessMPY.Parameters.Add(tmpfile);
      ProcessMPY.Execute;

      while ProcessMPY.Running or (ProcessMPY.Output.NumBytesAvailable > 0) or
        (ProcessMPY.Stderr.NumBytesAvailable > 0) do
      begin
        while ProcessMPY.Output.NumBytesAvailable > 0 do
        begin
          ReadCount := Min(512, ProcessMPY.Output.NumBytesAvailable);
          //Read up to buffer, not more
          ProcessMPY.Output.Read(CharBuffer, ReadCount);
          mmoOutAdd_MPY(Copy(CharBuffer, 0, ReadCount));
          Application.ProcessMessages;
        end;
        // read stderr and write to our stderr
        while ProcessMPY.Stderr.NumBytesAvailable > 0 do
        begin
          ReadCount := Min(512, ProcessMPY.Stderr.NumBytesAvailable);
          //Read up to buffer, not more
          ProcessMPY.Stderr.Read(CharBuffer, ReadCount);
          mmoOutAdd_MPY(Copy(CharBuffer, 0, ReadCount));
          Application.ProcessMessages;
        end;
      end;
    except

    end;
  finally
    btnStop_MPY.Enabled := False;
    btnRun_MPY.Enabled  := True;
  end;
end;

procedure TFormMain.mmoOutAdd(var mmo: TMemo; msg: string);
var
  i, n: integer;
begin
  // add msg to last line end
  // process \n
  // reduce flash on update
  if msg = '' then
    Exit;
  mmoOut_Temp.Text := msg;
  n := mmo.Lines.Count;
  if n > 0 then
    n := n - 1;

  mmo.Lines[n] := mmo.Lines[n] + mmoOut_Temp.Lines[0];
  for i := 1 to mmoOut_Temp.Lines.Count - 1 do
    mmo.Lines.Append(mmoOut_Temp.Lines[i]);
  if (msg[Length(msg)] = #10) then
    mmo.Lines.Add('');
  if mmo.Lines.Count > OUTPUT_MAX_LINES then
  begin
    for n := 1 to 256 do
      mmo.Lines.Delete(0);
  end;
end;

procedure TFormMain.btnRun_PascalScriptClick(Sender: TObject);
var
  res: boolean;
  i: integer;
begin
  btnStop_PascalScript.Enabled := True;
  btnRun_PascalScript.Enabled  := False;
  try
    try
      if not Compiled_PascalScript then
      begin
        // compile
        Script_Pascal.Script.Text := SynEditPascalScript.Text;
        Compiled_PascalScript     := Script_Pascal.Compile;
        Application.ProcessMessages;

        if not Compiled_PascalScript then
        begin
          if Script_Pascal.CompilerMessageCount > 0 then
            for i := 0 to Script_Pascal.CompilerMessageCount - 1 do
              mmoOutPascalScript.Lines.add(Script_Pascal.CompilerErrorToStr(i));
          Exit;
        end;
      end;

      Application.ProcessMessages;
      // run
      res := Script_Pascal.Execute;
      if not res then
        mmoOutPascalScript.Lines.add('Run-time error:' +
          Script_Pascal.ExecErrorToString);

    except
      on E: Exception do
      begin
        mmoOutPascalScript.Lines.add(E.Message);
      end;
    end;
  finally
    btnStop_PascalScript.Enabled := False;
    btnRun_PascalScript.Enabled  := True;
  end;
end;

procedure TFormMain.btnSaveAs_CalcClick(Sender: TObject);
begin
  if dlgSave_Calc.Execute then
  begin
    SaveFile_Calc(dlgSave_Calc.FileName);
    pmAddHis(pmHis_Calc, dlgSave_Calc.FileName);
  end;
end;

procedure TFormMain.btnSaveAs_MPYClick(Sender: TObject);
begin
  if dlgSave_MPY.Execute then
  begin
    SaveFile_MPY(dlgSave_MPY.FileName);
    pmAddHis(pmHis_MPY, dlgSave_MPY.FileName);
  end;
end;

procedure TFormMain.btnSaveAs_PascalScriptClick(Sender: TObject);
begin
  if dlgSave_PascalScript.Execute then
  begin
    SaveFile_PascalScript(dlgSave_PascalScript.FileName);
    pmAddHis(pmHis_PascalScript, dlgSave_PascalScript.FileName);
  end;
end;

procedure TFormMain.btnSave_CalcClick(Sender: TObject);
begin
  if dlgSave_Calc.FileName = '' then
  begin
    if not dlgSave_Calc.Execute then
      Exit;
    pmAddHis(pmHis_Calc, dlgSave_Calc.FileName);
  end;
  SaveFile_Calc(dlgSave_Calc.FileName);
end;

procedure TFormMain.btnSave_MPYClick(Sender: TObject);
begin
  if dlgSave_MPY.FileName = '' then
  begin
    if not dlgSave_MPY.Execute then
      Exit;
    pmAddHis(pmHis_MPY, dlgSave_MPY.FileName);
  end;
  SaveFile_MPY(dlgSave_MPY.FileName);
end;

procedure TFormMain.btnSave_PascalScriptClick(Sender: TObject);
begin
  if dlgSave_PascalScript.FileName = '' then
  begin
    if not dlgSave_PascalScript.Execute then
      Exit;
    pmAddHis(pmHis_PascalScript, dlgSave_PascalScript.FileName);
  end;
  SaveFile_PascalScript(dlgSave_PascalScript.FileName);
end;

procedure TFormMain.btnStop_CalcClick(Sender: TObject);
begin
  btnStop_Calc.Enabled := False;
  btnRun_Calc.Enabled  := True;
  Script_Calc.Stop;
end;

procedure TFormMain.btnStop_MPYClick(Sender: TObject);
begin
  btnStop_MPY.Enabled := False;
  btnRun_MPY.Enabled  := True;
  if ProcessMPY.Running then
  begin
    ProcessMPY.Terminate(0);
  end;
end;

procedure TFormMain.btnStop_PascalScriptClick(Sender: TObject);
begin
  btnStop_PascalScript.Enabled := False;
  btnRun_PascalScript.Enabled  := True;
  Script_Pascal.Stop;
end;

procedure TFormMain.btnShowOptionClick(Sender: TObject);
begin
  if FormOption.ShowModal = mrOk then
  begin

    TrayIcon.Visible := FormOption.chkShowTray.Checked;
    MinimizeToTray   := FormOption.chkMinimizeToTray.Checked;
    CloseToTray      := FormOption.chkCloseToTray.Checked;

    ini.WriteBool('Option', 'TrayIcon', TrayIcon.Visible);
    ini.WriteBool('Option', 'MinimizeToTray', MinimizeToTray);
    ini.WriteBool('Option', 'CloseToTray', CloseToTray);

    if FormOption.dlgFont.Tag = 2 then
    begin
      Font := FormOption.Font;
      saveFont;
    end;
  end;
end;

procedure TFormMain.cbbCalcKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
  begin
    Key := #0;
    btnRun_CalcClick(Sender);
  end;
end;

procedure TFormMain.cbbCalcMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  if (Shift = [ssShift, ssLeft]) then
  begin
    cbbCalc.Items.Clear;
    beep;
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
  // change Tray Icon
  ilTray.Tag := ilTray.Tag + 1;
  if ilTray.Tag > 0 then
    ilTray.GetIcon((ilTray.Tag div 5) mod ilTray.Count, TrayIcon.Icon);

  // change time interval
  ilOption.Tag := ilOption.Tag + 1;
  if ilOption.Tag > 600 then
  begin
    ilOption.Tag     := 0;
    tmrLogo.Interval := Random(15) * 10 + 50;
  end;

  if (pcMain.ActivePage = tsAbout) and Visible then
  begin
    // option animation
    tmrLogo.Tag := (tmrLogo.Tag + btnShowOption.Tag) mod ilOption.Count;
    btnShowOption.ImageIndex := tmrLogo.Tag;
    if tmrLogo.Tag mod 5 = 0 then
    begin
      // change logo
      imgLogo.Visible := not imgLogo.Visible;

      // option animation dir
      if (SecondOf(Now) mod 10) = 0 then
        if Random(2) = 0 then
          btnShowOption.Tag := 1
        else
          btnShowOption.Tag := ilOption.Count - 1;
    end;
  end;
end;

procedure TFormMain.TrayIconClick(Sender: TObject);
begin
  // resotre main form
  if WindowState = wsMinimized then
    WindowState := winstat;
  Show;
  Application.BringToFront;
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
          biA.Assign(sa);
          biB.Assign(sb);
          // biA > biB
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
          biFib1 := TInteger.Create;
          biA.Subtract(biB);  // A=A-B
          biFib1.Random(biA); // Random(A-B)
          biFib1.Add(biB);    // Random(A-B)+B
          biA.Assign(biFib1);
          biFib1.Free;
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
  if Length(s) < Len * 3 - 1 then
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

procedure TFormMain.updateTime(d: TDateTime);
begin
  try
    edtConvertTime.Text      := DateTimeToStr(d, DateTimefmt);
    edtConvertTimeYear.Text  := IntToStr(YearOf(d));
    edtConvertTimeMonth.Text := IntToStr(MonthOf(d));
    edtConvertTimeDay.Text   := IntToStr(DayOf(d));
    edtConvertTimeHour.Text  := IntToStr(HourOf(d));
    edtConvertTimeMin.Text   := IntToStr(MinuteOf(d));
    edtConvertTimeSec.Text   := IntToStr(SecondOf(d));
    edtConvertTimeWeek.Text  := IntToStr(DayOfTheWeek(d));
    edtConvertTimeYWeek.Text := IntToStr(WeekOf(d));
    edtConvertTimeYDay.Text  := IntToStr(DayOfTheYear(d));
    edtConvertTimeYHour.Text := IntToStr(HourOfTheYear(d));
    edtConvertTimeYMin.Text  := IntToStr(MinuteOfTheYear(d));
    edtConvertTimeYSec.Text  := IntToStr(SecondOfTheYear(d));
    edtConvertTimeUTC.Text   := IntToStr(DateTimeToUnix(d));
    edtPythonConvertTime.Text :=
      Format('(%d, %d, %d, %d, %d, %d, %d, %d, %d)',
      [YearOf(d), MonthOf(d), DayOf(d), HourOf(d), MinuteOf(d),
      SecondOf(d), DayOfTheWeek(d) - 1, DayOfTheYear(d), 0]);
  except
  end;
end;

procedure TFormMain.updateTabVisible;
begin
  tsCRC.TabVisible      := ini.ReadBool('Option', 'CRC_Enabled', True);
  tsDigit.TabVisible    := ini.ReadBool('Option', 'Dital_Enabled', True);
  tsBytes.TabVisible    := ini.ReadBool('Option', 'Bytes_Enabled', True);
  tsBase.TabVisible     := ini.ReadBool('Option', 'Base_Enabled', True);
  tsBigFloat.TabVisible := ini.ReadBool('Option', 'BigFloat_Enabled', True);
  tsBigInt.TabVisible   := ini.ReadBool('Option', 'BigInt_Enabled', True);
  tsBuffer.TabVisible   := ini.ReadBool('Option', 'Buffer_Enabled', True);
  tsConvert.TabVisible  := ini.ReadBool('Option', 'Convert_Enabled', True);
  tsConvertTime.TabVisible := ini.ReadBool('Option', 'Time_Enabled', True);
  tsCalc.TabVisible     := ini.ReadBool('Option', 'Calc_Enabled', True);
  tsScript.TabVisible   := ini.ReadBool('Option', 'Script_Enabled', True);
  tsPascalScript.TabVisible := ini.ReadBool('Option', 'Pascal_Enabled', True);
  tsMicropython.TabVisible := ini.ReadBool('Option', 'micropython_Enabled', True);
end;

function TFormMain.shortFileName(FileName: string): string;
begin
  Result := ExtractFileName(FileName);
  if Length(Result) > 16 then
    Result := copy(Result, 1, 13) + '...';
end;

procedure TFormMain.mmoOutAdd_PascalScript(msg: string);
begin
  mmoOutAdd(mmoOutPascalScript, msg);
end;

procedure TFormMain.mmoOutAdd_MPY(msg: string);
begin
  mmoOutAdd(mmoOutMPY, msg);
end;

procedure TFormMain.mmoOutAdd_Calc(msg: string);
begin
  mmoOutAdd(mmoOutCalc, msg);
end;

procedure TFormMain.pmAddHis(var pm: TPopupMenu; FileName: string);
var
  mi: TMenuItem;
begin
  if FileName <> '' then
  begin
    mi := pm.Items.Find(FileName);
    // Add new history file
    if mi = nil then
    begin
      // max 8 history files
      if pm.Items.Count > 8 then
        pm.Items.Delete(7);

      mi := TMenuItem.Create(pm);
      mi.Caption := FileName;
      if pm = pmHis_PascalScript then
      begin
        mi.OnClick := @pmHisClick_PascalScript;
      end
      else if pm = pmHis_MPY then
      begin
        mi.OnClick := @pmHisClick_MPY;
      end
      else if pm = pmHis_Calc then
      begin
        mi.OnClick := @pmHisClick_Calc;
      end;

      mi.GroupIndex := 1;
      mi.RadioItem  := True;
      mi.AutoCheck  := True;

      pm.Items.Insert(0, mi);
      if lbName.Tag > 0 then
        pm.Items[0].Checked := True;
    end
    else
    begin
      // move filename to first
      if mi.MenuIndex = 0 then
        Exit;
      pm.Items.Remove(mi);
      pmAddHis(pm, FileName);
    end;
  end;
end;

procedure TFormMain.pmHisClick_PascalScript(Sender: TObject);
begin
  // load history file
  LoadFile_PascalScript(TMenuItem(Sender).Caption);
  // move to first
  pmAddHis(pmHis_PascalScript, TMenuItem(Sender).Caption);
end;

procedure TFormMain.pmHisClick_MPY(Sender: TObject);
begin
  // load history file
  LoadFile_MPY(TMenuItem(Sender).Caption);
  // move to first
  pmAddHis(pmHis_MPY, TMenuItem(Sender).Caption);
end;

procedure TFormMain.pmHisClick_Calc(Sender: TObject);
begin
  // load history file
  LoadFile_Calc(TMenuItem(Sender).Caption);
  // move to first
  pmAddHis(pmHis_Calc, TMenuItem(Sender).Caption);
end;

procedure TFormMain.LoadFile_PascalScript(FileName: string);
begin
  btnNew_PascalScriptClick(nil);
  SynEditPascalScript.Lines.LoadFromFile(FileName);
  dlgSave_PascalScript.FileName := FileName;
  SynEditPascalScript.Hint := FileName;
  tsPascalScript.Caption := 'Pascal - ' + shortFileName(FileName);
end;

procedure TFormMain.SaveFile_PascalScript(FileName: string);
begin
  try
    SynEditPascalScript.Lines.SaveToFile(FileName);
    SynEditPascalScript.Modified := False;
    btnSave_PascalScript.Enabled := False;
    btnSaveAs_PascalScript.Enabled := False;
    tsPascalScript.Caption := 'Pascal - ' + shortFileName(FileName);
  except

  end;
end;

procedure TFormMain.LoadFile_MPY(FileName: string);
begin
  btnNew_MPYClick(nil);
  SynEditMPY.Lines.LoadFromFile(FileName);
  dlgSave_MPY.FileName := FileName;
  SynEditMPY.Hint      := FileName;
  tsMicropython.Caption := 'micropython - ' + shortFileName(FileName);
end;

procedure TFormMain.SaveFile_MPY(FileName: string);
begin
  try
    SynEditMPY.Lines.SaveToFile(FileName);
    SynEditMPY.Modified   := False;
    btnSave_MPY.Enabled   := False;
    btnSaveAs_MPY.Enabled := False;
    tsMicropython.Caption := 'micropython - ' + shortFileName(FileName);
  except

  end;
end;

procedure TFormMain.LoadFile_Calc(FileName: string);
var
  i, n: integer;
  s: string;
begin
  mmoOut_Temp.Lines.LoadFromFile(FileName);
  s := mmoOut_Temp.Lines[0];
  if not TryStrToInt(s, n) then
    Exit;

  sgVar_Calc.Clean;
  sgVar_Calc.RowCount := n;
  for i := 1 to n - 1 do
  begin
    mmoOut_Temp.Lines.Delete(0);
    sgVar_Calc.Rows[i].CommaText := mmoOut_Temp.Lines[0];
  end;
  mmoOut_Temp.Lines.Delete(0);

  dlgSave_Calc.FileName := FileName;
  SynEditFunc_Calc.Text := mmoOut_Temp.Text;
  SynEditFunc_Calc.Hint := FileName;
  sgVar_Calc.Hint := FileName;
end;

procedure TFormMain.SaveFile_Calc(FileName: string);
var
  i: integer;
begin
  mmoOut_Temp.Text := SynEditFunc_Calc.Text;
  mmoOut_Temp.Lines.Insert(0, IntToStr(sgVar_Calc.RowCount));
  for i := 1 to sgVar_Calc.RowCount - 1 do
    mmoOut_Temp.Lines.Insert(i, sgVar_Calc.Rows[i].CommaText);
  mmoOut_Temp.Lines.SaveToFile(FileName);
  SynEditFunc_Calc.Hint := FileName;
  sgVar_Calc.Hint := FileName;
end;

end.
