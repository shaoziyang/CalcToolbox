unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  LCLType, ExtCtrls, Buttons, Grids, lclintf, DateUtils, Math,
  Clipbrd, Menus, Spin, ExtDlgs, process,
  IniFiles, Types,
  uPSComponent,
  UBigFloatV3,
  //UBigIntsForFloatV4,
  UBigIntsV5,
  SynEdit, SynHighlighterPas, SynHighlighterPython,
  SynEditTypes, SynHighlighterLua, SynEditHighlighter, SynHighlighterCpp,
  RichMemo;

const
  GITHUB_URL = 'https://github.com/shaoziyang/CalcToolbox';
  GITEE_URL = 'https://gitee.com/shaoziyang/CalcToolbox';
  VERSION = '1.5.2.4';
  OUTPUT_MAX_LINES = 4096;

{$ifdef Windows}
  MICROPYTHON_BIN_NAME = 'bin\micropython\windows\micropython.exe';
  LUA_BIN_NAME = 'bin\lua\windows\lua.exe';
{$else}
{$ifdef Linux}
  MICROPYTHON_BIN_NAME = 'bin/micropython/linux/micropython';
  LUA_BIN_NAME = 'bin/lua/linux/lua';
{$endif}
{$endif}

type
  SingleBytes = array[0..3] of byte;
  DoubleBytes = array[0..7] of byte;

  { TFormMain }

  TFormMain = class(TForm)
    ApplicationProperties: TApplicationProperties;
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
    btnCaret_Graph: TToolButton;
    btnCaret_Lua: TToolButton;
    btnCaret_C: TToolButton;
    btnClear_Graph: TToolButton;
    btnClear_Calc: TToolButton;
    btnClear_Lua: TToolButton;
    btnClear_C: TToolButton;
    btnCmd_Lua: TToolButton;
    btnConvertTimeNow: TSpeedButton;
    btnHelp_Graph: TToolButton;
    btnHelp_Calc: TToolButton;
    btnHelp_Lua: TToolButton;
    btnHelp_C: TToolButton;
    btnNew_Graph: TToolButton;
    btnNew_Calc: TToolButton;
    btnNew_Lua: TToolButton;
    btnNew_C: TToolButton;
    btnNoteConvertSpeed: TSpeedButton;
    btnNoteConvertMass: TSpeedButton;
    btnNoteConvertTemperature: TSpeedButton;
    btnNoteConvertPower: TSpeedButton;
    btnOpenGITEE: TSpeedButton;
    btnOpenGITHUB: TSpeedButton;
    btnOpenGITHUB1: TSpeedButton;
    btnExit: TSpeedButton;
    btnCaret_MPY: TToolButton;
    btnClear_MPY: TToolButton;
    btnHelp_MPY: TToolButton;
    btnNew_MPY: TToolButton;
    btnOpen_Graph: TToolButton;
    btnOpen_Calc: TToolButton;
    btnOpen_C: TToolButton;
    btnOpen_MPY: TToolButton;
    btnOpen_Lua: TToolButton;
    btnPanelMode_Graph: TToolButton;
    btnPanelMode_MPY: TToolButton;
    btnPanelMode_Lua: TToolButton;
    btnPanelMode_C: TToolButton;
    btnRun_C: TToolButton;
    btnRun_Graph: TToolButton;
    btnRun_MPY: TToolButton;
    btnRun_Lua: TToolButton;
    btnSaveAs_Graph: TToolButton;
    btnSaveAs_Calc: TToolButton;
    btnSaveAs_Lua: TToolButton;
    btnSaveAs_C: TToolButton;
    btnSavePic_Graph: TToolButton;
    btnSave_Graph: TToolButton;
    btnSave_Calc: TToolButton;
    btnSave_C: TToolButton;
    btnSave_MPY: TToolButton;
    btnSaveAs_MPY: TToolButton;
    btnSave_Lua: TToolButton;
    btnStop_C: TToolButton;
    btnStop_Graph: TToolButton;
    btnStop_MPY: TToolButton;
    btnStop_Lua: TToolButton;
    cbbCalc: TComboBox;
    chkBigIntComma: TCheckBox;
    chkCrcInvOut: TCheckBox;
    chkCrcInvIn: TCheckBox;
    dlgOpen_Calc: TOpenDialog;
    dlgOpen_Graph: TOpenDialog;
    dlgOpen_Lua: TOpenDialog;
    dlgOpen_C: TOpenDialog;
    dlgSave_Calc: TSaveDialog;
    dlgSave_Graph: TSaveDialog;
    dlgSave_Lua: TSaveDialog;
    dlgSave_C: TSaveDialog;
    edtConvertTimeDay: TLabeledEdit;
    edtConvertTimeHour: TLabeledEdit;
    edtConvertTimeMin: TLabeledEdit;
    edtConvertTimeMonth: TLabeledEdit;
    edtConvertTimeSec: TLabeledEdit;
    edtConvertTimeYear: TLabeledEdit;
    edtBigFloatPrec: TEdit;
    edtBytesNum: TEdit;
    edtCrcXOROUT: TEdit;
    edtCrcResult: TEdit;
    edtCrcPolygon: TEdit;
    edtCrcInitV: TEdit;
    edtDecimalDigitsConvertArea: TSpinEdit;
    edtDecimalDigitsConvertVolume: TSpinEdit;
    edtDecimalDigitsConvertSpeed: TSpinEdit;
    edtDecimalDigitsConvertMass: TSpinEdit;
    edtDecimalDigitsConvertPower: TSpinEdit;
    edtDecimalDigitsConvertDistance: TSpinEdit;
    ilMain: TImageList;
    ilDigit: TImageList;
    ilOption: TImageList;
    ilTray: TImageList;
    ilAB: TImageList;
    ilNoteIcon: TImageList;
    imgLaz: TImage;
    imgLogo: TImage;
    imgLogo1: TImage;
    Label1: TLabel;
    Label3: TLabel;
    lbRunTime: TLabel;
    lbRunCnt: TLabel;
    lbName: TLabel;
    Label2: TLabel;
    lbFont: TLabel;
    lbVer: TLabel;
    mmoLicense: TMemo;
    mmoNoteConvertSpeed: TMemo;
    mmoNoteConvertMass: TMemo;
    mmoNoteConvertTemperature: TMemo;
    mmoNoteConvertDistance: TMemo;
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
    mmoNoteConvertPower: TMemo;
    mmoOutGraph: TMemo;
    mmoOutCalc: TMemo;
    mmoOutC: TMemo;
    mmoOutPascalScript: TMemo;
    dlgOpen_PascalScript: TOpenDialog;
    mmoOutMPY: TMemo;
    mmoOutLua: TMemo;
    mmoOut_Temp: TMemo;
    dlgOpen_MPY: TOpenDialog;
    pcCalcMode: TPageControl;
    pmHelp_Calc: TPopupMenu;
    pmHelp_Lua: TPopupMenu;
    pmHelp_C: TPopupMenu;
    pmHis_Calc: TPopupMenu;
    pmHis_Graph: TPopupMenu;
    pmHis_Lua: TPopupMenu;
    pmHis_C: TPopupMenu;
    pnlCalc: TPanel;
    pcScript: TPageControl;
    pcConvert: TPageControl;
    pmTrayShow: TMenuItem;
    miTrayOption: TMenuItem;
    miTrayExit: TMenuItem;
    N1: TMenuItem;
    mmoBigFloatA: TMemo;
    mmoBigIntA: TMemo;
    mmoBigFloatB: TMemo;
    mmoBigIntB: TMemo;
    mmoBigIntC: TMemo;
    mmoCRC: TMemo;
    mmoBigFloatC: TMemo;
    pcConstant: TPageControl;
    pcAbout: TPageControl;
    pnlBigFloatA: TPanel;
    pnlBigIntB: TPanel;
    pnlBigIntC: TPanel;
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
    ProcessC: TProcess;
    ProcessMPY: TProcess;
    dlgSave_MPY: TSaveDialog;
    ProcessLua: TProcess;
    dlgSavePic_Graph: TSavePictureDialog;
    Script_Graph: TPSScript;
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
    sgConstantDecimalMultiple: TStringGrid;
    sgConstantPeriodicTable: TStringGrid;
    sgConvertArea: TStringGrid;
    sgConvertVolume: TStringGrid;
    sgConvertSpeed: TStringGrid;
    sgConvertMass: TStringGrid;
    sgConvertPower: TStringGrid;
    sgConvertDistance: TStringGrid;
    sgConvertTime: TStringGrid;
    sgBytes: TStringGrid;
    sgBase: TStringGrid;
    sgConstantPhysics: TStringGrid;
    sgConvertTemperature: TStringGrid;
    sgExpr_Calc: TStringGrid;
    sgVar_Calc: TStringGrid;
    btnShowOption: TSpeedButton;
    edtBaseCustom: TSpinEdit;
    Shape2: TShape;
    edtDecimalDigitsConvertTemperature: TSpinEdit;
    btnNoteConvertDistance: TSpeedButton;
    splGraph: TSplitter;
    Splitter1: TSplitter;
    splMPY: TSplitter;
    Splitter11: TSplitter;
    Splitter12: TSplitter;
    splLua: TSplitter;
    splC: TSplitter;
    Splitter2: TSplitter;
    Splitter3: TSplitter;
    sgConstantMath: TStringGrid;
    Splitter5: TSplitter;
    splPascalScript: TSplitter;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    StaticText4: TStaticText;
    StaticText5: TStaticText;
    StaticText6: TStaticText;
    StaticText7: TStaticText;
    SynCppSyn: TSynCppSyn;
    SynEditGraph: TSynEdit;
    SynEditFunc_Calc: TSynEdit;
    SynEditC: TSynEdit;
    SynEditPascalScript: TSynEdit;
    SynEditMPY: TSynEdit;
    SynEditLua: TSynEdit;
    SynPasSyn: TSynPasSyn;
    SynPythonSyn: TSynPythonSyn;
    btnCaret_PascalScript: TToolButton;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    ToolBar18: TToolBar;
    ToolBar19: TToolBar;
    ToolButton46: TToolButton;
    ToolButton47: TToolButton;
    tsConstantPeriodicTable: TTabSheet;
    ToolBar17: TToolBar;
    ToolButton45: TToolButton;
    tsConvertSpeed: TTabSheet;
    ToolBar16: TToolBar;
    ToolButton42: TToolButton;
    ToolButton43: TToolButton;
    ToolButton44: TToolButton;
    btnShowGraphForm: TToolButton;
    tsConvertArea: TTabSheet;
    tsConvertVolume: TTabSheet;
    tsGraph: TTabSheet;
    ToolBar15: TToolBar;
    ToolButton41: TToolButton;
    tsConvertMass: TTabSheet;
    ToolBar13: TToolBar;
    ToolBar14: TToolBar;
    ToolBar7: TToolBar;
    ToolButton14: TToolButton;
    ToolButton23: TToolButton;
    ToolButton31: TToolButton;
    btnPanelMode_PascalScript: TToolButton;
    ToolButton32: TToolButton;
    ToolButton33: TToolButton;
    ToolButton39: TToolButton;
    ToolButton40: TToolButton;
    tsConstantDecimalMultiple: TTabSheet;
    tsConvertDistance: TTabSheet;
    tsConvertPower: TTabSheet;
    tsConvertTemperature: TTabSheet;
    tsConvertTime: TTabSheet;
    ToolBar12: TToolBar;
    btnCmd_MPY: TToolButton;
    ToolButton30: TToolButton;
    ToolButton38: TToolButton;
    tsC: TTabSheet;
    tsLicense: TTabSheet;
    ToolBar11: TToolBar;
    btnBigFloatNRoot: TToolButton;
    ToolButton29: TToolButton;
    ToolButton37: TToolButton;
    tsLua: TTabSheet;
    ToolBar10: TToolBar;
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
    tsConvert: TTabSheet;
    TrayIcon: TTrayIcon;
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
    tsConstantPhysics: TTabSheet;
    tmrAlpha: TTimer;
    ToolBar1: TToolBar;
    ToolBar2: TToolBar;
    ToolBar4: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    procedure ApplicationPropertiesException(Sender: TObject; E: Exception);
    procedure btnBigFloatAddClick(Sender: TObject);
    procedure btnBigIntAddClick(Sender: TObject);
    procedure btnClear_CalcClick(Sender: TObject);
    procedure btnClear_PascalScriptClick(Sender: TObject);
    procedure btnCmd_LuaClick(Sender: TObject);
    procedure btnCmd_MPYClick(Sender: TObject);
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
    procedure btnNew_CClick(Sender: TObject);
    procedure btnNew_GraphClick(Sender: TObject);
    procedure btnNew_LuaClick(Sender: TObject);
    procedure btnNew_MPYClick(Sender: TObject);
    procedure btnNew_PascalScriptClick(Sender: TObject);
    procedure btnNoteConvertDistanceClick(Sender: TObject);
    procedure btnOpenGITEEClick(Sender: TObject);
    procedure btnOpenGITHUBClick(Sender: TObject);
    procedure btnOpen_CalcClick(Sender: TObject);
    procedure btnOpen_CClick(Sender: TObject);
    procedure btnOpen_GraphClick(Sender: TObject);
    procedure btnOpen_LuaClick(Sender: TObject);
    procedure btnOpen_MPYClick(Sender: TObject);
    procedure btnOpen_PascalScriptClick(Sender: TObject);
    procedure btnPanelMode_PascalScriptClick(Sender: TObject);
    procedure btnRun_CClick(Sender: TObject);
    procedure btnRun_GraphClick(Sender: TObject);
    procedure btnRun_LuaClick(Sender: TObject);
    procedure btnRun_MPYClick(Sender: TObject);
    procedure btnRun_PascalScriptClick(Sender: TObject);
    procedure btnSaveAs_CalcClick(Sender: TObject);
    procedure btnSaveAs_CClick(Sender: TObject);
    procedure btnSaveAs_GraphClick(Sender: TObject);
    procedure btnSaveAs_LuaClick(Sender: TObject);
    procedure btnSaveAs_MPYClick(Sender: TObject);
    procedure btnSaveAs_PascalScriptClick(Sender: TObject);
    procedure btnSavePic_GraphClick(Sender: TObject);
    procedure btnSave_CalcClick(Sender: TObject);
    procedure btnSave_CClick(Sender: TObject);
    procedure btnSave_GraphClick(Sender: TObject);
    procedure btnSave_LuaClick(Sender: TObject);
    procedure btnSave_MPYClick(Sender: TObject);
    procedure btnSave_PascalScriptClick(Sender: TObject);
    procedure btnShowGraphFormClick(Sender: TObject);
    procedure btnStop_CClick(Sender: TObject);
    procedure btnStop_GraphClick(Sender: TObject);
    procedure btnStop_LuaClick(Sender: TObject);
    procedure btnStop_MPYClick(Sender: TObject);
    procedure btnStop_PascalScriptClick(Sender: TObject);
    procedure btnShowOptionClick(Sender: TObject);
    procedure cbbCalcDblClick(Sender: TObject);
    procedure cbbCalcKeyPress(Sender: TObject; var Key: char);
    procedure cbbCalcMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure edtBigFloatPrecEditingDone(Sender: TObject);
    procedure edtBytesNumChange(Sender: TObject);
    procedure edtConvertTimeYearEditingDone(Sender: TObject);
    procedure edtCrcResultClick(Sender: TObject);
    procedure edtDecimalDigitsConvertAreaChange(Sender: TObject);
    procedure edtDecimalDigitsConvertDistanceChange(Sender: TObject);
    procedure edtDecimalDigitsConvertMassChange(Sender: TObject);
    procedure edtDecimalDigitsConvertPowerChange(Sender: TObject);
    procedure edtDecimalDigitsConvertSpeedChange(Sender: TObject);
    procedure edtDecimalDigitsConvertTemperatureChange(Sender: TObject);
    procedure edtDecimalDigitsConvertVolumeChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormWindowStateChange(Sender: TObject);
    procedure imgLazClick(Sender: TObject);
    procedure lbVerClick(Sender: TObject);
    procedure miTrayExitClick(Sender: TObject);
    procedure mmoBigFloatCMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure mmoBigIntCMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure pcCalcModeChange(Sender: TObject);
    procedure Script_PascalCompile(Sender: TPSScript);
    procedure rbBigBytesChange(Sender: TObject);
    procedure sgBytesEditingDone(Sender: TObject);
    procedure sgConstantMathClick(Sender: TObject);
    procedure sgBaseEditingDone(Sender: TObject);
    procedure edtBaseCustomChange(Sender: TObject);
    procedure sgConvertAreaEditingDone(Sender: TObject);
    procedure sgConvertDistanceEditingDone(Sender: TObject);
    procedure sgConvertMassEditingDone(Sender: TObject);
    procedure sgConvertPowerEditingDone(Sender: TObject);
    procedure sgConvertSpeedEditingDone(Sender: TObject);
    procedure sgConvertTemperatureEditingDone(Sender: TObject);
    procedure sgConvertTimeEditingDone(Sender: TObject);
    procedure sgConvertVolumeEditingDone(Sender: TObject);
    procedure sgExpr_CalcEditingDone(Sender: TObject);
    procedure sgExpr_CalcKeyPress(Sender: TObject; var Key: char);
    procedure sgVar_CalcEditingDone(Sender: TObject);
    procedure splPascalScriptMoved(Sender: TObject);
    procedure SynEditGraphChange(Sender: TObject);
    procedure SynEditGraphStatusChange(Sender: TObject; Changes: TSynStatusChanges);
    procedure SynEditCChange(Sender: TObject);
    procedure SynEditCStatusChange(Sender: TObject; Changes: TSynStatusChanges);
    procedure SynEditLuaChange(Sender: TObject);
    procedure SynEditLuaStatusChange(Sender: TObject; Changes: TSynStatusChanges);
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
    RunTime, RunTimeM: integer;

    winstat: TWindowState;
    DateTimefmt: TFormatSettings;
    FHighlighters: TFPList;

    function getCrcBit: integer;
    procedure setCrcBit(bit: integer);
    procedure bfCalc(Sender: TObject);
    procedure biCalc(Sender: TObject);
    procedure saveFont;

  private
    CalcExpressionStr: string;
    function CalcExpression(Sender: TObject; expr: string): integer;

  private
    Compiled_PascalScript: boolean;
    Compiled_Graph: boolean;
    EditorAutoSaveFileName_PascalScript: string;
    EditorAutoSaveFileName_micropython: string;
    EditorAutoSaveFileName_Lua: string;
    EditorAutoSaveFileName_C: string;
    EditorAutoSaveFileName_calc: string;
    EditorAutoSaveFileName_Graph: string;

    Script_Calc_CodeVar, Script_Calc_CodeFunc, Script_Calc_CodeMain: string;

    procedure mmoOutPosCheck(syn: TSynEdit; mmo: TMemo);

    function shortFileName(FileName: string): string;
    procedure mmoOutAdd(var mmo: TMemo; msg: string);
    procedure mmoOutAdd_PascalScript(msg: string);
    procedure mmoOutAdd_MPY(msg: string);
    procedure mmoOutAdd_Lua(msg: string);
    procedure mmoOutAdd_C(msg: string);
    procedure mmoOutAdd_Calc(msg: string);
    procedure mmoOutAdd_Graph(msg: string);

    procedure pmAddHis(var pm: TPopupMenu; FileName: string);
    procedure pmHisClick_PascalScript(Sender: TObject);
    procedure pmHisClick_MPY(Sender: TObject);
    procedure pmHisClick_Lua(Sender: TObject);
    procedure pmHisClick_C(Sender: TObject);
    procedure pmHisClick_Calc(Sender: TObject);
    procedure pmHisClick_Graph(Sender: TObject);

    procedure LoadFile_PascalScript(FileName: string);
    procedure SaveFile_PascalScript(FileName: string);
    procedure LoadFile_MPY(FileName: string);
    procedure SaveFile_MPY(FileName: string);
    procedure LoadFile_Lua(FileName: string);
    procedure SaveFile_Lua(FileName: string);
    procedure LoadFile_C(FileName: string);
    procedure SaveFile_C(FileName: string);
    procedure LoadFile_Calc(FileName: string);
    procedure SaveFile_Calc(FileName: string);
    procedure LoadFile_Graph(FileName: string);
    procedure SaveFile_Graph(FileName: string);

  public
    use_external_micropython: boolean;
    external_micropython_bin_name: string;

    use_external_lua: boolean;
    external_lua_bin_name: string;

    external_c_bin_name: string;

    errlog_en: boolean;
    errlogfile: string;
    procedure errlog(msg: string);

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
    procedure updateTemperature(C: Float);
    procedure updatePower(P: Float);
    procedure updateDistance(V: Float);
    procedure updateArea(A: Float);
    procedure updateVolume(V: Float);
    procedure updateSpeed(SP: Float);
    procedure updateMass(M: Float);

    procedure updateTabVisible;
    procedure updateTSPC(ts: TTabSheet; pc: TPageControl);

    function RunTimeToDHMStr(T: integer): string;
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
  uCRC, uBase, unit2, unit3;


{$R *.lfm}

{$I NewFileTemplate.pas}

{ pascal script grapg addon functions }
var
  PSG_sx1: integer = 0;     // map coordinate
  PSG_sy1: integer = 0;
  PSG_sx2: integer = 1000;
  PSG_sy2: integer = 1000;  // windows widtg/height
  PSG_W: integer = 500;
  PSG_H: integer = 500;
  PSG_PenDown: boolean = True;
  PSG_lgx: double = 0;       // Logo position and angle
  PSG_lgy: double = 0;
  PSG_Angle: Float = 0;

function PSG_cx(x: double): double;
begin
  Result := PSG_W * (x - PSG_sx1) / (PSG_sx2 - PSG_sx1);
end;

function PSG_cy(y: double): double;
begin
  Result := PSG_H - PSG_H * (y - PSG_sy1) / (PSG_sy2 - PSG_sy1);
end;

function PSG_cxi(x: double): integer;
begin
  Result := Round(PSG_W * (x - PSG_sx1) / (PSG_sx2 - PSG_sx1));
end;

function PSG_cyi(y: double): integer;
begin
  Result := Round(PSG_H - PSG_H * (y - PSG_sy1) / (PSG_sy2 - PSG_sy1));
end;

procedure PSG_print(v: array of variant);
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
  FormMain.mmoOutAdd_Graph(s);
  Application.ProcessMessages;
end;

procedure PSG_Map(x1, y1, x2, y2: integer);
begin
  PSG_sx1 := x1;
  PSG_sy1 := y1;
  PSG_sx2 := x2;
  PSG_sy2 := y2;
end;

procedure PSG_Widows(Left, Top, Width, Height: integer);
begin
  FormGraph.Left := Left;
  FormGraph.Top := Top;
  FormGraph.ClientWidth := Width;
  FormGraph.ClientHeight := Height;
  FormGraph.image.Picture.Bitmap.Width := Width;
  FormGraph.image.Picture.Bitmap.Height := Height;
  PSG_W := Width;
  PSG_H := Height;
  PSG_Map(0, 0, Width, Height);
end;

function PSG_Width: integer;
begin
  Result := PSG_sx2 - PSG_sx1;
end;

function PSG_Height: integer;
begin
  Result := PSG_sy2 - PSG_sy1;
end;

procedure PSG_Title(Caption: variant; Show: boolean = True);
begin
  if Show then
    FormGraph.BorderStyle := bsSizeable
  else
    FormGraph.BorderStyle := bsNone;
  FormGraph.Caption := Caption;
end;

procedure PSG_Clean(color: TColor);
begin
  FormGraph.image.Picture.Bitmap.Canvas.Brush.Color := color;
  FormGraph.image.Picture.Bitmap.Canvas.FillRect(FormGraph.image.ClientRect);
end;

procedure PSG_Color(color: TColor);
begin
  FormGraph.image.Picture.Bitmap.Canvas.Pen.Color := color;
end;

procedure PSG_BackColor(color: TColor);
begin
  FormGraph.image.Picture.Bitmap.Canvas.Brush.Color := color;
end;

procedure PSG_Dot(x, y: Float; color: TColor = 0);
var
  cx, cy: integer;
begin
  cx := PSG_cxi(x);
  cy := PSG_cxi(y);
  if (cx < 0) or (cx >= PSG_W) or (cy < 0) or (cy >= PSG_H) then
    Exit;
  FormGraph.image.Picture.Bitmap.Canvas.Pixels[cx, cy] := Color;
end;

procedure PSG_Pixel(x, y: double);
begin
  PSG_Dot(x, y, FormGraph.image.Picture.Bitmap.Canvas.Pen.Color);
end;

procedure PSG_LineTo(x, y: double);
begin
  FormGraph.image.Picture.Bitmap.Canvas.LineTo(PSG_cxi(x), PSG_cxi(y));
end;

procedure PSG_MoveTo(x, y: double);
begin
  FormGraph.image.Picture.Bitmap.Canvas.MoveTo(PSG_cxi(x), PSG_cxi(y));
end;

procedure PSG_Line(x1, y1, x2, y2: double);
begin
  FormGraph.image.Picture.Bitmap.Canvas.Line(PSG_cxi(x1), PSG_cyi(y1),
    PSG_cxi(x2), PSG_cyi(y2));
end;

procedure PSG_Arc(ALeft, ATop, ARight, ABottom, SX, SY, EX, EY: double);
begin
  FormGraph.image.Picture.Bitmap.Canvas.arc(PSG_cxi(ALeft),
    PSG_cyi(ATop), PSG_cxi(ARight), PSG_cyi(ABottom), PSG_cxi(SX),
    PSG_cyi(SY), PSG_cxi(EX), PSG_cyi(EY));
end;

procedure PSG_Circle(x, y, rx, ry: double);
begin
  FormGraph.image.Picture.Bitmap.Canvas.arc(PSG_cxi(x - rx),
    PSG_cyi(y - ry), PSG_cxi(x + rx), PSG_cyi(y + ry), PSG_cxi(x + rx),
    PSG_cyi(y), PSG_cxi(x + rx), PSG_cyi(y));
end;

procedure PSG_Ellipse(x1, y1, x2, y2: double);
begin
  FormGraph.image.Picture.Bitmap.Canvas.Ellipse(PSG_cxi(x1), PSG_cyi(y1),
    PSG_cxi(x2), PSG_cyi(y2));
end;

procedure PSG_Fill(X, Y: Float; Color: TColor);
var
  c: TColor;
begin
  c := FormGraph.image.Picture.Bitmap.Canvas.Pixels[PSG_cxi(x), PSG_cyi(y)];
  FormGraph.image.Picture.Bitmap.Canvas.Brush.Color := color;
  FormGraph.image.Picture.Bitmap.Canvas.FloodFill(PSG_cxi(x), PSG_cyi(y), c, fsSurface);
end;

procedure PSG_LOGOPU;
begin
  PSG_PenDown := False;
end;

procedure PSG_LOGOPD;
begin
  PSG_PenDown := True;
end;

procedure PSG_LOGOHome;
begin
  PSG_lgx     := 0;
  PSG_lgy     := 0;
  PSG_Angle   := 0;
  PSG_PenDown := True;
end;

procedure PSG_LOGOFD(len: double);
var
  x, y: float;
begin
  x := PSG_lgx;
  y := PSG_lgy;
  PSG_lgx := PSG_lgx + len * cos(PSG_Angle * PI / 180);
  PSG_lgy := PSG_lgy + len * sin(PSG_Angle * PI / 180);
  if PSG_PenDown then
    PSG_Line(x, y, PSG_lgx, PSG_lgy);
end;

procedure PSG_LOGOBK(len: double);
var
  x, y: float;
begin
  x := PSG_lgx;
  y := PSG_lgy;
  PSG_lgx := PSG_lgx - len * cos(PSG_Angle * PI / 180);
  PSG_lgy := PSG_lgy - len * sin(PSG_Angle * PI / 180);
  if PSG_PenDown then
    PSG_Line(x, y, PSG_lgx, PSG_lgy);
end;

procedure PSG_LOGOLT(angle: double);
begin
  PSG_Angle := PSG_Angle + angle;
end;

procedure PSG_LOGORT(angle: double);
begin
  PSG_Angle := PSG_Angle - angle;
end;


{ graph addon end }

{ pascal script addon functions }

procedure PSreservedprint(sep: string; v: array of variant);
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
  FormMain.CalcExpressionStr := FormMain.CalcExpressionStr + s;
end;

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

function PSlog(x: double): double;
begin
  Result := ln(x);
end;

function PSlog10(x: double): double;
begin
  Result := log10(x);
end;

function PSPower(x, y: double): double;
begin
  Result := power(x, y);
end;

function PSExp(x: double): double;
begin
  Result := exp(x);
end;

function PStan(x: double): double;
begin
  Result := tan(x);
end;

function PSarcsin(x: double): double;
begin
  Result := arcsin(x);
end;

function PSarccos(x: double): double;
begin
  Result := arccos(x);
end;

function PSarctan(x: double): double;
begin
  Result := arctan2(x, 1);
end;

function PSsinh(x: double): double;
begin
  Result := sinh(x);
end;

function PScosh(x: double): double;
begin
  Result := cosh(x);
end;

function PStanh(x: double): double;
begin
  Result := tanh(x);
end;

function PSRandom: double;
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
  errlogfile := ChangeFileExt(Application.ExeName, '.err');

  lbVer.Caption     := 'ver ' + VERSION;
  lbRunTime.Caption := ' ';

  DateTimefmt.ShortDateFormat := 'yyyy-mm-dd';
  DateTimefmt.DateSeparator   := '-';
  DateTimefmt.TimeSeparator   := ':';
  DateTimefmt.LongTimeFormat  := 'hh:nn:ss';

  FHighlighters := TFPList.Create;
  FHighlighters.Add(TSynLuaSyn.Create(Self));
  SynEditLua.Highlighter := TSynCustomHighlighter(FHighlighters[0]);

  // test inifile writeable
  try
    ini.WriteDateTime('Last', 'run', now());
    ini.UpdateFile;
    lbRunCnt.Tag := ini.ReadInteger('Run', 'Cnt', 1);
    ini.WriteInteger('Run', 'Cnt', lbRunCnt.Tag + 1);
    lbRunCnt.Caption := 'Run:  ' + IntToStr(lbRunCnt.Tag);
    lbRunCnt.Hint := 'Start: ' + FormatDateTime('yyyy-m-d hh:nn', now);
    writeable := True;
    RunTime   := ini.ReadInteger('run', 'Time', 0);
    RunTimeM  := MinuteOf(now);
    lbRunTime.Tag := 0;
  except
    writeable := False;
    // set unwriteable flag
    Caption   := '#' + Caption;
    lbRunCnt.Visible := False;
    lbRunTime.Visible := False;
  end;

  // load values from ini file
  try
    Top    := ini.ReadInteger('Last', 'Top', Top);
    Left   := ini.ReadInteger('Last', 'Left', Left);
    Width  := ini.ReadInteger('Last', 'Width', Width);
    Height := ini.ReadInteger('Last', 'Height', Height);

    pcMain.PageIndex := ini.ReadInteger('Last', 'Page', 0);
  except

  end;

  try
    // option
    lbFont.Font.Name := ini.ReadString('Option', 'FontName', Font.Name);
    lbFont.Font.Size := ini.ReadInteger('Option', 'FontSize', Font.Size);
    lbFont.Font.Size := max(min(lbFont.Font.Size, 24), 7);
    if ini.ReadBool('Option', 'FontBold', False) then
    begin
      lbFont.Font.Style := [fsBold];
    end;
    Font      := lbFont.Font;
    errlog_en := ini.ReadBool('option', 'errlog', False);

    TrayIcon.Visible := ini.ReadBool('Option', 'TrayIcon', True);
    MinimizeToTray   := ini.ReadBool('Option', 'MinimizeToTray', True);
    CloseToTray      := ini.ReadBool('Option', 'CloseToTray', True);
  except
    on E: Exception do
      errlog(E.Message);
  end;

  try
    // Digit
    rbBigBytes.Checked      := ini.ReadBool('Digit', 'BigBytes', True);
    pcDigit.ActivePageIndex := ini.ReadInteger('last', 'page_digit', 0);
  except
    on E: Exception do
      errlog(E.Message);
  end;

  try
    // crc
    edtCrcPolygon.Text   := ini.ReadString('CRC', 'poly', '1021');
    edtCrcInitV.Text     := ini.ReadString('CRC', 'v0', '0');
    edtCrcXOROUT.Text    := ini.ReadString('CRC', 'XOROUT', '0');
    chkCrcInvIn.Checked  := ini.ReadBool('CRC', 'InvIn', False);
    chkCrcInvOut.Checked := ini.ReadBool('CRC', 'InvOut', False);
    setCrcBit(ini.ReadInteger('CRC', 'bit', 16));
  except
    on E: Exception do
      errlog(E.Message);
  end;

  try
    // BigFloat
    edtBigFloatPrec.Text := ini.ReadString('BigFloat', 'prec', '100');
    pnlBigFloatA.Height  := ini.ReadInteger('BigFloat', 'PanelA', 80);
    pnlBigFloatB.Height  := ini.ReadInteger('BigFloat', 'PanelB', 80);
    mmoBigFloatA.Text    := '';
    mmoBigFloatB.Text    := '';
  except
    on E: Exception do
      errlog(E.Message);
  end;

  try
    // BigInt
    chkBigIntComma.Checked := ini.ReadBool('BigInt', 'comma', False);
    pnlBigIntA.Height := ini.ReadInteger('BigInt', 'PanelA', 80);
    pnlBigIntB.Height := ini.ReadInteger('BigInt', 'PanelB', 80);
    mmoBigIntA.Text := '';
    mmoBigIntB.Text := '';
  except
    on E: Exception do
      errlog(E.Message);
  end;

  try
    // Calc
    SynEditFunc_Calc.Modified := True;
    sgVar_Calc.Modified := True;
    EditorAutoSaveFileName_calc :=
      ExtractFilePath(Application.ExeName) + 'autosave.calc';

    if FileExists(EditorAutoSaveFileName_calc) then
      LoadFile_Calc(EditorAutoSaveFileName_calc)
    else
      btnNew_CalcClick(Sender);

    for i := 1 to ini.ReadInteger('HisFile_Calc', 'Count', 0) do
      pmAddHis(pmHis_Calc, ini.ReadString('HisFile_Calc', IntToStr(i), ''));

    cbbCalc.Text      := ini.ReadString('calc', 'express', '');
    pnlCalc.Width     := ini.ReadInteger('calc', 'width', 300);
    sgVar_Calc.Height := ini.ReadInteger('calc', 'var_height', 128);
    sgVar_Calc.ColWidths[0] := ini.ReadInteger('calc', 'var_col0', 40);
    sgVar_Calc.ColWidths[2] := ini.ReadInteger('calc', 'var_col2', 80);
    cbbCalc.Items.CommaText := ini.ReadString('calc', 'exphis', '');
    mmoOutCalc.Lines.CommaText := ini.ReadString('calc', 'cmdout', '');

    sgExpr_Calc.ColWidths[1]   := ini.ReadInteger('calc', 'tab_col1', 200);
    pcCalcMode.ActivePageIndex := ini.ReadInteger('calc', 'mode', 0);

    sgExpr_Calc.RowCount := ini.ReadInteger('calcTable', 'count', 1) + 1;
    for i := 1 to sgExpr_Calc.RowCount - 1 do
      sgExpr_Calc.Rows[i].CommaText := ini.ReadString('calcTable', IntToStr(i), '');

  except
    on E: Exception do
      errlog(E.Message);
  end;

  try
    // Convert Time
    btnConvertTimeNowClick(nil);
    pcConvert.ActivePageIndex := ini.ReadInteger('last', 'page_convert', 0);

    edtDecimalDigitsConvertTemperature.Value :=
      ini.ReadInteger('convert', 'DigitTemperature', 2);
    edtDecimalDigitsConvertPower.Value    := ini.ReadInteger('convert', 'DigitPower', 3);
    edtDecimalDigitsConvertDistance.Value :=
      ini.ReadInteger('convert', 'DigitDistance', 4);
    edtDecimalDigitsConvertArea.Value     := ini.ReadInteger('convert', 'DigitArea', 6);
    edtDecimalDigitsConvertVolume.Value   :=
      ini.ReadInteger('convert', 'DigitVolume', 6);
    edtDecimalDigitsConvertSpeed.Value    := ini.ReadInteger('convert', 'DigitSpeed', 4);
    edtDecimalDigitsConvertMass.Value     :=
      ini.ReadInteger('convert', 'DigitMass', 3);
  except
    on E: Exception do
      errlog(E.Message);
  end;

  try
    // Script
    pcScript.PageIndex := ini.ReadInteger('last', 'page_script', 0);

    // pascal script
    if ini.ReadBool('PascalScript', 'Vert', False) then
      splPascalScript.Align := alTop
    else
      splPascalScript.Align := alLeft;
    btnPanelMode_PascalScriptClick(btnPanelMode_PascalScript);

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
  except
    on E: Exception do
      errlog(E.Message);
  end;

  try
    // micropython
    if ini.ReadBool('MPY', 'Vert', False) then
      splMPY.Align := alTop
    else
      splMPY.Align := alLeft;
    btnPanelMode_PascalScriptClick(btnPanelMode_MPY);

    EditorAutoSaveFileName_micropython :=
      ExtractFilePath(Application.ExeName) + 'autosave.py';
    if FileExists(EditorAutoSaveFileName_micropython) then
      SynEditMPY.Lines.LoadFromFile(EditorAutoSaveFileName_micropython)
    else
      btnNew_MPYClick(Sender);

    for i := 1 to ini.ReadInteger('HisFile_micropython', 'Count', 0) do
      pmAddHis(pmHis_MPY, ini.ReadString('HisFile_micropython', IntToStr(i), ''));

    use_external_micropython      :=
      ini.ReadBool('MPY', 'use_external_micropython', False);
    external_micropython_bin_name :=
      ini.ReadString('MPY', 'external_micropythn_bin', '');
  except
    on E: Exception do
      errlog(E.Message);
  end;

  try
    // Lua
    if ini.ReadBool('Lua', 'Vert', False) then
      splLua.Align := alTop
    else
      splLua.Align := alLeft;
    btnPanelMode_PascalScriptClick(btnPanelMode_Lua);

    EditorAutoSaveFileName_Lua :=
      ExtractFilePath(Application.ExeName) + 'autosave.lua';
    if FileExists(EditorAutoSaveFileName_Lua) then
      SynEditLua.Lines.LoadFromFile(EditorAutoSaveFileName_Lua)
    else
      btnNew_LuaClick(Sender);

    for i := 1 to ini.ReadInteger('HisFile_Lua', 'Count', 0) do
      pmAddHis(pmHis_Lua, ini.ReadString('HisFile_Lua', IntToStr(i), ''));

    use_external_lua      := ini.ReadBool('lua', 'use_external_lua', False);
    external_lua_bin_name := ini.ReadString('lua', 'external_lua_bin', '');
  except
    on E: Exception do
      errlog(E.Message);
  end;

  try
    // C
    if ini.ReadBool('C', 'Vert', False) then
      splC.Align := alTop
    else
      splC.Align := alLeft;
    btnPanelMode_PascalScriptClick(btnPanelMode_C);

    EditorAutoSaveFileName_C :=
      ExtractFilePath(Application.ExeName) + 'autosave.c';
    if FileExists(EditorAutoSaveFileName_C) then
      SynEditC.Lines.LoadFromFile(EditorAutoSaveFileName_C)
    else
      btnNew_CClick(Sender);

    for i := 1 to ini.ReadInteger('HisFile_C', 'Count', 0) do
      pmAddHis(pmHis_C, ini.ReadString('HisFile_C', IntToStr(i), ''));

    external_c_bin_name := ini.ReadString('C', 'TinyC_bin', '');
  except
    on E: Exception do
      errlog(E.Message);
  end;

  try
    // graph
    if ini.ReadBool('graph', 'Vert', False) then
      splGraph.Align := alTop
    else
      splGraph.Align := alLeft;
    btnPanelMode_PascalScriptClick(btnPanelMode_Graph);

    EditorAutoSaveFileName_Graph :=
      ExtractFilePath(Application.ExeName) + 'autosave.lgs';
    if FileExists(EditorAutoSaveFileName_Graph) then
      SynEditGraph.Lines.LoadFromFile(EditorAutoSaveFileName_Graph)
    else
      btnNew_GraphClick(Sender);

    for i := 1 to ini.ReadInteger('HisFile_Graph', 'Count', 0) do
      pmAddHis(pmHis_Graph, ini.ReadString('HisFile_Graph', IntToStr(i), ''));

    Compiled_Graph := False;
  except
    on E: Exception do
      errlog(E.Message);
  end;

  try
    // Constant
    pcConstant.PageIndex := ini.ReadInteger('last', 'page_constant', 0);

    for i := 0 to ComponentCount - 1 do
    begin
      if copy(Components[i].Name, 1, Length('mmoNote')) = 'mmoNote' then
      begin
        s := Components[i].Name;
        Delete(s, 1, 3);
        TMemo(FindComponent(Components[i].Name)).Visible :=
          ini.ReadBool('Note', s, True);
        TSpeedButton((FindComponent('btn' + s))).ImageIndex :=
          1 - ini.ReadInteger('Note', s, 1);
      end;
    end;

  except
    on E: Exception do
      errlog(E.Message);
  end;

  // visible
  updateTabVisible;

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

  // set His flag
  lbName.Tag := 1;

  if writeable then
  begin
    try
      s := ChangeFileExt(Application.ExeName, '.ini');
      if FileExists(s + '.3') then
        DeleteFile(s + '.3');
      if FileExists(s + '.2') then
        RenameFile(s + '.2', s + '.3');
      if FileExists(s + '.1') then
        RenameFile(s + '.1', s + '.2');
      RenameFile(s, s + '.1');
      ini.UpdateFile;
    except

    end;
  end;
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
      ini.WriteInteger('last', 'page_digit', pcDigit.ActivePageIndex);

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

      // Calc
      SaveFile_Calc(EditorAutoSaveFileName_calc);

      ini.EraseSection('HisFile_Calc');
      ini.WriteInteger('HisFile_Calc', 'Count', pmHis_Calc.Items.Count);
      for i := 0 to pmHis_Calc.Items.Count - 1 do
        ini.WriteString('HisFile_Calc', IntToStr(i + 1), pmHis_Calc.Items[i].Caption);

      ini.WriteString('calc', 'express', cbbCalc.Text);
      ini.WriteInteger('calc', 'width', pnlCalc.Width);
      ini.WriteInteger('calc', 'var_height', sgVar_Calc.Height);
      ini.WriteInteger('calc', 'var_col0', sgVar_Calc.ColWidths[0]);
      ini.WriteInteger('calc', 'var_col2', sgVar_Calc.ColWidths[2]);
      ini.WriteString('calc', 'exphis', cbbCalc.Items.CommaText);
      ini.WriteString('calc', 'cmdout', mmoOutCalc.Lines.CommaText);

      ini.WriteInteger('calc', 'tab_col1', sgExpr_Calc.ColWidths[1]);
      ini.WriteInteger('calc', 'mode', pcCalcMode.ActivePageIndex);

      ini.EraseSection('calcTable');
      ini.WriteInteger('calcTable', 'count', sgExpr_Calc.RowCount - 1);
      for i := 1 to sgExpr_Calc.RowCount - 1 do
        ini.WriteString('calcTable', IntToStr(i), sgExpr_Calc.Rows[i].CommaText);

      // convert
      ini.WriteInteger('last', 'page_convert', pcConvert.ActivePageIndex);

      ini.WriteInteger('convert',
        'DigitTemperature', edtDecimalDigitsConvertTemperature.Value);
      ini.WriteInteger('convert', 'DigitPower', edtDecimalDigitsConvertPower.Value);
      ini.WriteInteger('convert', 'DigitDistance',
        edtDecimalDigitsConvertDistance.Value);
      ini.WriteInteger('convert', 'DigitArea', edtDecimalDigitsConvertArea.Value);
      ini.WriteInteger('convert', 'DigitVolume', edtDecimalDigitsConvertVolume.Value);
      ini.WriteInteger('convert', 'DigitSpeed', edtDecimalDigitsConvertSpeed.Value);
      ini.WriteInteger('convert', 'DigitMass', edtDecimalDigitsConvertMass.Value);

      // Script
      ini.WriteInteger('last', 'page_script', pcScript.ActivePageIndex);

      // pascal script
      SynEditPascalScript.Lines.SaveToFile(EditorAutoSaveFileName_PascalScript);

      ini.EraseSection('HisFile_PascalScript');
      ini.WriteInteger('HisFile_PascalScript', 'Count', pmHis_PascalScript.Items.Count);
      for i := 0 to pmHis_PascalScript.Items.Count - 1 do
        ini.WriteString('HisFile_PascalScript', IntToStr(i + 1),
          pmHis_PascalScript.Items[i].Caption);

      // micropython
      SynEditMPY.Lines.SaveToFile(EditorAutoSaveFileName_micropython);

      ini.EraseSection('HisFile_micropython');
      ini.WriteInteger('HisFile_micropython', 'Count', pmHis_MPY.Items.Count);
      for i := 0 to pmHis_MPY.Items.Count - 1 do
        ini.WriteString('HisFile_micropython', IntToStr(i + 1),
          pmHis_MPY.Items[i].Caption);

      // Lua
      SynEditLua.Lines.SaveToFile(EditorAutoSaveFileName_Lua);

      ini.EraseSection('HisFile_Lua');
      ini.WriteInteger('HisFile_Lua', 'Count', pmHis_Lua.Items.Count);
      for i := 0 to pmHis_Lua.Items.Count - 1 do
        ini.WriteString('HisFile_Lua', IntToStr(i + 1),
          pmHis_Lua.Items[i].Caption);

      // C
      SynEditC.Lines.SaveToFile(EditorAutoSaveFileName_C);

      ini.EraseSection('HisFile_C');
      ini.WriteInteger('HisFile_C', 'Count', pmHis_C.Items.Count);
      for i := 0 to pmHis_C.Items.Count - 1 do
        ini.WriteString('HisFile_C', IntToStr(i + 1),
          pmHis_C.Items[i].Caption);

      // Graph
      SynEditGraph.Lines.SaveToFile(EditorAutoSaveFileName_Graph);

      ini.EraseSection('HisFile_Graph');
      ini.WriteInteger('HisFile_Graph', 'Count', pmHis_Graph.Items.Count);
      for i := 0 to pmHis_Graph.Items.Count - 1 do
        ini.WriteString('HisFile_Graph', IntToStr(i + 1),
          pmHis_Graph.Items[i].Caption);

      // COnstant
      ini.WriteInteger('last', 'page_constant', pcConstant.ActivePageIndex);

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

    FHighlighters.Free;

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
          btnRun_MPYClick(Sender)
        else if pcScript.ActivePage = tsLua then
          btnRun_LuaClick(Sender)
        else if pcScript.ActivePage = tsC then
          btnRun_CClick(Sender)
        else if pcScript.ActivePage = tsGraph then
          btnRun_GraphClick(Sender);
      end;
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
          end
          else if pcScript.ActivePage = tsLua then
          begin
            if btnSave_Lua.Enabled then
              btnSave_LuaClick(Sender);
          end
          else if pcScript.ActivePage = tsC then
          begin
            if btnSave_C.Enabled then
              btnSave_CClick(Sender);
          end
          else if pcScript.ActivePage = tsGraph then
          begin
            if btnSave_Graph.Enabled then
              btnSave_GraphClick(Sender);
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

procedure TFormMain.FormResize(Sender: TObject);
begin
  mmoOutPosCheck(SynEditPascalScript, mmoOutPascalScript);
  mmoOutPosCheck(SynEditMPY, mmoOutMPY);
  mmoOutPosCheck(SynEditLua, mmoOutLua);
  mmoOutPosCheck(SynEditC, mmoOutC);
  mmoOutPosCheck(SynEditGraph, mmoOutGraph);
  if pcCalcMode.Width = 0 then
    pnlCalc.Width := Width - 40;
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
    begin
      Hide;
      if FormGraph.Visible then
        FormGraph.Hide;
    end;
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

procedure TFormMain.pcCalcModeChange(Sender: TObject);
begin
  case pcCalcMode.ActivePageIndex of
    0: cbbCalc.SetFocus;
    1: sgExpr_Calc.SetFocus;
  end;
end;

procedure TFormMain.Script_PascalCompile(Sender: TPSScript);
begin
  if Sender = Script_Pascal then
  begin
    Sender.AddFunction(@PSprint, 'procedure print(v:array of Variant);');
    Sender.AddFunction(@PSsprint, 'procedure sprint(sep:string; v:array of Variant);');
    Sender.AddFunction(@PSwriteln, 'procedure Writeln(s: Variant);');
    Sender.AddFunction(@PSwrite, 'procedure Write(s: Variant);');
    Sender.AddFunction(@PSclear, 'procedure clear;');
  end
  else if Sender = Script_Calc then
  begin
    Sender.AddFunction(@PSprint_Calc, 'procedure print(v:array of Variant);');
    Sender.AddFunction(@PSsprint_Calc,
      'procedure sprint(sep:string; v:array of Variant);');
    Sender.AddFunction(@PSwriteln_Calc, 'procedure Writeln(s: Variant);');
    Sender.AddFunction(@PSwrite_Calc, 'procedure Write(s: Variant);');
  end
  else if Sender = Script_Graph then
  begin
    Sender.AddFunction(@PSG_print, 'procedure print(v:array of Variant);');
    Sender.AddFunction(@PSG_Map, 'procedure map(x1,y1,x2,y2:integer);');
    Sender.AddFunction(@PSG_Widows,
      'procedure windows(Left, Top, Width, Height:integer);');
    Sender.AddFunction(@PSG_Width, 'function Width:integer;');
    Sender.AddFunction(@PSG_Height, 'function Height:integer;');
    Sender.AddFunction(@PSG_Title, 'procedure Title(caption:Variant;show:Boolean);');
    Sender.AddFunction(@PSG_Clean, 'procedure clean(color:integer);');
    Sender.AddFunction(@PSG_Color, 'procedure color(color:integer);');
    Sender.AddFunction(@PSG_BackColor, 'procedure backcolor(color:integer);');
    Sender.AddFunction(@PSG_Dot, 'procedure dot(x,y:double;color:integer);');
    Sender.AddFunction(@PSG_Pixel, 'procedure pixel(x,y:double);');
    Sender.AddFunction(@PSG_Line, 'procedure line(x1,y1,x2,y2:double);');
    Sender.AddFunction(@PSG_LineTo, 'procedure lineto(x,y:double);');
    Sender.AddFunction(@PSG_MoveTo, 'procedure moveto(x,y:double);');
    Sender.AddFunction(@PSG_Arc,
      'procedure arc(ALeft, ATop, ARight, ABottom, SX, SY, EX, EY:double);');
    Sender.AddFunction(@PSG_Circle, 'procedure Circle(x,y,rx,ry:double);');
    Sender.AddFunction(@PSG_Ellipse, 'procedure Ellipse(x1,y1,x2,y2:double);');
    Sender.AddFunction(@PSG_Fill, 'procedure Fill(X, Y: extended; Color: integer);');
    Sender.AddFunction(@PSG_LOGOHome, 'procedure HOME;');
    Sender.AddFunction(@PSG_LOGOPU, 'procedure PU;');
    Sender.AddFunction(@PSG_LOGOPD, 'procedure PD;');
    Sender.AddFunction(@PSG_LOGOFD, 'procedure FD(len:double);');
    Sender.AddFunction(@PSG_LOGOBK, 'procedure BK(len:double);');
    Sender.AddFunction(@PSG_LOGOLT, 'procedure LT(angle:double);');
    Sender.AddFunction(@PSG_LOGORT, 'procedure RT(angle:double);');

  end;

  Sender.AddFunction(@PSreservedprint,
    'procedure _reserved_print(sep:string; v:array of Variant);');
  Sender.AddFunction(@PSreadln, 'function Readln(question: string): string;');
  Sender.AddFunction(@PSreadln, 'function Read(question: string): string;');
  Sender.AddFunction(@PSlog, 'function ln(x: double): double;');
  Sender.AddFunction(@PSlog10, 'function log10(x: double): double;');
  Sender.AddFunction(@PSexp, 'function exp(x: double): double;');
  Sender.AddFunction(@PStan, 'function tan(x: double): double;');
  Sender.AddFunction(@PSarcsin, 'function arcsin(x: double): double;');
  Sender.AddFunction(@PSarccos, 'function arccos(x: double): double;');
  Sender.AddFunction(@PSarctan, 'function arctan(x: double): double;');
  Sender.AddFunction(@PSsinh, 'function sinh(x: double): double;');
  Sender.AddFunction(@PScosh, 'function cosh(x: double): double;');
  Sender.AddFunction(@PStanh, 'function tanh(x: double): double;');
  Sender.AddFunction(@PSpower, 'function power(x,y: double): double;');
  Sender.AddFunction(@PSRandom, 'function random: double;');
  Sender.AddFunction(@PSRandomRange, 'function RandomRange(x,y: integer): integer;');
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

procedure TFormMain.edtDecimalDigitsConvertAreaChange(Sender: TObject);
begin
  sgConvertArea.Modified := True;
  sgConvertAreaEditingDone(Sender);
end;

procedure TFormMain.edtDecimalDigitsConvertDistanceChange(Sender: TObject);
begin
  sgConvertDistance.Modified := True;
  sgConvertDistanceEditingDone(Sender);
end;

procedure TFormMain.edtDecimalDigitsConvertMassChange(Sender: TObject);
begin
  sgConvertMass.Modified := True;
  sgConvertMassEditingDone(Sender);
end;

procedure TFormMain.edtDecimalDigitsConvertPowerChange(Sender: TObject);
begin
  sgConvertPower.Modified := True;
  sgConvertPowerEditingDone(Sender);
end;

procedure TFormMain.edtDecimalDigitsConvertSpeedChange(Sender: TObject);
begin
  sgConvertSpeed.Modified := True;
  sgConvertSpeedEditingDone(Sender);
end;

procedure TFormMain.edtDecimalDigitsConvertTemperatureChange(Sender: TObject);
begin
  sgConvertTemperature.Modified := True;
  sgConvertTemperatureEditingDone(Sender);
end;

procedure TFormMain.edtDecimalDigitsConvertVolumeChange(Sender: TObject);
begin
  sgConvertVolume.Modified := True;
  sgConvertVolumeEditingDone(Sender);
end;

procedure TFormMain.btnBigFloatAddClick(Sender: TObject);
begin
  bfCalc(Sender);
end;

procedure TFormMain.ApplicationPropertiesException(Sender: TObject; E: Exception);
begin
  errlog(E.Message);
end;

procedure TFormMain.btnBigIntAddClick(Sender: TObject);
begin
  biCalc(Sender);
end;

procedure TFormMain.btnClear_CalcClick(Sender: TObject);
begin
  case pcCalcMode.ActivePageIndex of
    0: mmoOutCalc.Clear;
    1: sgExpr_Calc.Clean;
  end;
end;

procedure TFormMain.btnClear_PascalScriptClick(Sender: TObject);
var
  s: string;
begin
  s := TToolButton(Sender).Name;
  Delete(s, 1, Length('btnClear_'));
  TMemo(FindComponent('mmoOut' + s)).Clear;
end;

procedure TFormMain.btnCmd_LuaClick(Sender: TObject);
var
  AProcess: TProcess;
begin
  AProcess := TProcess.Create(nil);
  if use_external_lua then
    AProcess.Executable := external_lua_bin_name
  else
    AProcess.Executable := ExtractFilePath(Application.ExeName) + LUA_BIN_NAME;
  AProcess.Options := AProcess.Options + [poNewConsole];
  AProcess.Execute;
  AProcess.Free;
end;

procedure TFormMain.btnCmd_MPYClick(Sender: TObject);
var
  AProcess: TProcess;
begin
  AProcess := TProcess.Create(nil);
  if use_external_micropython then
    AProcess.Executable := external_micropython_bin_name
  else
    AProcess.Executable := ExtractFilePath(Application.ExeName) + MICROPYTHON_BIN_NAME;
  AProcess.Options := AProcess.Options + [poNewConsole];
  AProcess.Execute;
  AProcess.Free;
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
    if FormGraph.Visible then
      FormGraph.Hide;
  end
  else
  begin
    CanClose     := tmrAlpha.Tag = 4;
    tmrAlpha.Tag := 3;
    tmrAlpha.Enabled := True;
  end;
end;


procedure TFormMain.sgBytesEditingDone(Sender: TObject);
const
  MaxLen = 256;
var
  i, j, sy, len, d, bufN: integer;
  buf: TByteArray;
  nd: int64;
  s, ss, s1, s2: string;
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

        StrToByteBuf(ss, s);
        ss   := '';
        bufN := (Length(s) + 2) div 3;
        for i := 1 to (bufN div MaxLen) + 1 do
        begin
          if i * MaxLen < bufN then
            len := MaxLen
          else
            len := bufN - (i - 1) * MaxLen;
          StrToBytes(s, len, buf);
          Delete(s, 1, len * 3);
          ss := ss + BufferToPyStr(buf, len);
        end;
        sgBytes.Cells[1, 13] := ss;
      end;
      12: // string
      begin
        s := '';
        for i := 1 to Length(ss) do
          s  := s + Format('%.02X ', [Ord(ss[i])]);
        sgBytes.Cells[1, 11] := s;
        s    := '';
        bufN := Length(ss);
        for i := 1 to (bufN div MaxLen) + 1 do
        begin
          if i * MaxLen < bufN then
            len := MaxLen
          else
            len := bufN - (i - 1) * MaxLen;
          for j := 0 to len - 1 do
          begin
            buf[j] := Ord(ss[j + 1]);
          end;
          s := s + BufferToPyStr(buf, len);
          Delete(ss, 1, len);
        end;
        sgBytes.Cells[1, 13] := s;
      end;
      13: // python
      begin
        bufN := Length(ss);
        i    := 1;
        len  := 0;
        s1   := '';
        s2   := '';
        while i <= bufN do
        begin
          if ss[i] = '\' then
          begin
            if i < bufN then
            begin
              case Ord(ss[i + 1]) of
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
                    buf[len] := Chr2ToByte(ss[i + 2], ss[i + 3])
                  else
                    buf[len] := Chr2ToByte('0', ss[i + 2]);
                  i := i + 2;
                end;
                Ord('0')..Ord('7'): // Octal number
                begin
                  j := 1;
                  if (Ord(ss[i + 2]) <= Ord('7')) and (Ord(ss[i + 2]) >= Ord('0')) then
                  begin
                    j := 2;
                    if (Ord(ss[i + 3]) <= Ord('7')) and (Ord(ss[i + 3]) >= Ord('0')) then
                      j := 3;
                  end;
                  s := Copy(ss, i + 1, j);
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
                  buf[len] := Ord(ss[i]);
                  len      := len + 1;
                  buf[len] := Ord(ss[i + 1]);
              end;
              i := i + 1;
            end
            else
              buf[len] := 0;
          end
          else
            buf[len] := Ord(ss[i]);
          len := len + 1;
          i   := i + 1;
          if (len >= MaxLen) or (i >= bufN) then
          begin
            s1  := s1 + BufferToStr(buf, len);
            s2  := s2 + BufferToHex(buf, len);
            len := 0;
          end;
        end;
        sgBytes.Cells[1, 11] := s1;
        sgBytes.Cells[1, 12] := s2;
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

  dat := StrToBase(s, base, neg, system.maxLongint);

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

procedure TFormMain.sgConvertAreaEditingDone(Sender: TObject);
var
  A: Float;
  sy: integer;
begin
  if not sgConvertArea.Modified then
    Exit;

  sy := sgConvertArea.Row;
  if not TryStrToFloat(sgConvertArea.Cells[1, sy], A) then
    Exit;
  case sy of
    1: // square centimeter
      updateArea(A / 10000);
    2: // square meter
      updateArea(A);
    3: // square kilometer
      updateArea(A * 1000000);
    5: // square inch
      updateArea(A / 1550.0031000062);
    6: // square foot (UK)
      updateArea(A / 10.7639104167097);
    7: // square foot (US survey)
      updateArea(A / 10.7638673611111);
    8: // square yard
      updateArea(A / 1.19599004630108);
    9: // square mile
      updateArea(A / 3.86102158542446e-007);
    11: // acer
      updateArea(A / 0.000247105381467);
    12: // hectare
      updateArea(A / 0.0001);
    13: // rood
      updateArea(A / 0.000988421525869);
    14: // mu
      updateArea(A / 0.0015);
    15: // circular inch
      updateArea(A / 1973.52524138998);
    16: // township
      updateArea(A / 1.07250599595124e-008);
    else
  end;
  sgConvertArea.Modified := False;
end;

procedure TFormMain.sgConvertDistanceEditingDone(Sender: TObject);
var
  V: Float;
  sy: integer;
begin
  if not sgConvertDistance.Modified then
    Exit;

  sy := sgConvertDistance.Row;
  if not TryStrToFloat(sgConvertDistance.Cells[1, sy], V) then
    Exit;
  case sy of
    1: // mm
      updateDistance(V / 1000);
    2: // m
      updateDistance(V);
    3: // km
      updateDistance(V * 1000);
    5: // mil
      updateDistance(V * 0.0000254);
    6: // inch
      updateDistance(V * 0.0254);
    7: // foot
      updateDistance(V * 0.0254 * 12);
    8: // yard
      updateDistance(V * 0.0254 * 36);
    9: // mile
      updateDistance(V * 0.0254 * 36 * 1760);
    10: //nautical mile (NM)
      updateDistance(V * 1852);
    11: //nautical mile (UK)
      updateDistance(V * 1854.55);
    12: //nautical mile (US)
      updateDistance(V * 1851.01);
    14: // chi
      updateDistance(V / 3);
    15: // zhang
      updateDistance(V * 10 / 3);
    else
  end;
  sgConvertDistance.Modified := False;
end;

procedure TFormMain.sgConvertMassEditingDone(Sender: TObject);
var
  M: Float;
  sy: integer;
begin
  if not sgConvertMass.Modified then
    Exit;

  sy := sgConvertMass.Row;
  if not TryStrToFloat(sgConvertMass.Cells[1, sy], M) then
    Exit;
  case sy of
    1: // gram
      updateMass(M / 1000);
    2: // kilogram
      updateMass(M);
    3: // tonne
      updateMass(M * 1000);
    4: // ton (UK)
      updateMass(M * 1000 / 0.984206527611061);
    5: // ton (US)
      updateMass(M * 1000 / 1.10231131092439);
    6: // carat
      updateMass(M / 5000);
    7: // ounce (oz)
      updateMass(M / 35.2739619495804);
    8: // ounce (troy)
      updateMass(M / 32.150746568628);
    9: // pound (lb)
      updateMass(M / 2.20462262184878);
    10: // pound (troy)
      updateMass(M / 2.679228880719);
    11: // stone (st)
      updateMass(M / 0.15747304441777);
    12: // slug
      updateMass(M / 0.068521765843675);
    13: // hundredweight (UK)
      updateMass(M / 0.019684130552221);
    14: // hundredweight (UK)
      updateMass(M / 0.022046226218488);

    16: // qian
      updateMass(M / 200);
    17: // liang
      updateMass(M / 20);
    18: // jin
      updateMass(M / 2);
    else
  end;
  sgConvertMass.Modified := False;
end;

procedure TFormMain.sgConvertPowerEditingDone(Sender: TObject);
var
  P: Float;
  sy: integer;
begin
  if not sgConvertPower.Modified then
    Exit;
  sy := sgConvertPower.Row;
  if not TryStrToFloat(sgConvertPower.Cells[1, sy], P) then
    Exit;
  case sy of
    1: // watt
      updatePower(P);
    2: // mW
      updatePower(P / 1000.0);
    3: // dBm
      updatePower(power(10, P / 10) / 1000);
    else
  end;
  sgConvertPower.Modified := False;
end;

procedure TFormMain.sgConvertSpeedEditingDone(Sender: TObject);
var
  SP: Float;
  sy: integer;
begin
  if not sgConvertSpeed.Modified then
    Exit;

  sy := sgConvertSpeed.Row;
  if not TryStrToFloat(sgConvertSpeed.Cells[1, sy], SP) then
    Exit;
  case sy of
    1: // cm/sec
      updateSpeed(SP / 100);
    2: // cm/min
      updateSpeed(SP / 6000);
    3: // cm/hr
      updateSpeed(SP / 360000);
    4: // m/sec
      updateSpeed(SP);
    5: // m/min
      updateSpeed(SP / 60);
    6: // m/hr
      updateSpeed(SP / 3600);
    7: // km/sec
      updateSpeed(SP * 1000);
    8: // km/min
      updateSpeed(SP * 1000 / 60);
    9: // km/hr
      updateSpeed(SP * 1000 / 3600);
    11: // inch/second (ips
      updateSpeed(SP / 39.3700787401575);
    12: // inch/minute (ipm)
      updateSpeed(SP / 2362.20472440945);
    13: // foot/second (fps)
      updateSpeed(SP / 3.28083989501312);
    14: // foot/minute (fpm)
      updateSpeed(SP / 196.850393700787);
    15: // foot/hour (ft/hr)
      updateSpeed(SP / 11811.0236220472);
    16: // yard/second
      updateSpeed(SP / 1.09361329833771);
    17: // yard/minute
      updateSpeed(SP / 65.6167979002625);
    18: // yard/hour
      updateSpeed(SP / 3937.00787401575);
    19: // mile/second
      updateSpeed(SP / 0.000621371192237);
    20: // mile/minute
      updateSpeed(SP / 0.03728227153424);
    21: // mile/hour
      updateSpeed(SP / 2.2369362920544);
    23: // knot (kn or kt) (UK)
      updateSpeed(SP / 1.94260256941567);
    24: // knot (kn or kt)
      updateSpeed(SP / 1.94384449244061);
    25: // mach (M or Ma)
      updateSpeed(SP / 0.003016106101135);
    27: // speed of light (c)
      updateSpeed(SP * 299792458);
    else
  end;
  sgConvertSpeed.Modified := False;
end;

procedure TFormMain.sgConvertTemperatureEditingDone(Sender: TObject);
var
  T: Float;
  sy: integer;
begin
  if not sgConvertTemperature.Modified then
    Exit;

  sy := sgConvertTemperature.Row;
  if not TryStrToFloat(sgConvertTemperature.Cells[1, sy], T) then
    Exit;
  case sy of
    1: // C
      updateTemperature(T);
    2: // F
      updateTemperature((T - 32) / 1.8);
    3: // Kelvin
      updateTemperature(T - 273.15);
    4: // newton
      updateTemperature(T / 0.33);
    5: // Reaumur
      updateTemperature(T * 1.25);
    6: // rankine
      updateTemperature(T / 1.8 - 273.15);
    else
  end;
  sgConvertTemperature.Modified := False;
end;

procedure TFormMain.sgConvertTimeEditingDone(Sender: TObject);
var
  d: TDateTime;
  sy: integer;
  n: int64;
  ss: TStringList;
  year, mon, day, hour, min, sec: dword;
begin
  if not sgConvertTime.Modified then
    Exit;

  sy := sgConvertTime.Row;

  case sy of
    1: // DateTime
    begin
      if TryStrToDateTime(sgConvertTime.Cells[1, 1], d, DateTimefmt) then
        updateTime(d);
    end;
    2:// UTC
    begin
      try
        if TryStrToInt64(sgConvertTime.Cells[1, 2], n) then
        begin
          d := UnixToDateTime(n);
          updateTime(d);
        end;
      except
      end;
    end;
    3:// python
    begin
      ss := TStringList.Create;
      try
        try
          if ExtractStrings([','], [' ', '(', ')'], PChar(sgConvertTime.Cells[1, 3]),
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
    else

  end;
  sgConvertTime.Modified := False;
end;

procedure TFormMain.sgConvertVolumeEditingDone(Sender: TObject);
var
  V: Float;
  sy: integer;
begin
  if not sgConvertVolume.Modified then
    Exit;

  sy := sgConvertVolume.Row;
  if not TryStrToFloat(sgConvertVolume.Cells[1, sy], V) then
    Exit;
  case sy of
    1: // cm^3
      updateVolume(V / 1e6);
    2: // dm^3
      updateVolume(V / 1e3);
    3: // m^3
      updateVolume(V);
    4: // cubic inch
      updateVolume(V / 61023.7440947323);
    5: // cubic foot
      updateVolume(V / 35.3146667214886);
    6: // cubic yard
      updateVolume(V / 1.30795061931439);
    7: // liter
      updateVolume(V / 1000);
    9: // gallon (UK)
      updateVolume(V / 219.969248299088);
    10: // gallon (US)
      updateVolume(V / 264.172052358148);
    11: // gallon (dry)
      updateVolume(V / 227.020746067214);
    13: // barrel (UK)
      updateVolume(V / 6.11025689719688);
    14: // barrel (US)
      updateVolume(V / 8.38641436057614);
    15: // barrel (dry)
      updateVolume(V / 8.6484093739891);
    16: // barrel (petroleum)
      updateVolume(V / 6.2898107704321);
    18: // ounce (UK)
      updateVolume(V / 35195.079727854);
    19: // ounce (US)
      updateVolume(V / 33814.022701843);
    21: // pint (UK)
      updateVolume(V / 1759.7539863927);
    22: // pint (US)
      updateVolume(V / 2113.37641886519);
    23: // pint (dry)
      updateVolume(V / 1816.16596853771);
    25: // quart (UK)
      updateVolume(V / 879.876993196351);
    26: // quart (US)
      updateVolume(V / 1056.68820943259);
    27: // quart (dry)
      updateVolume(V / 908.082984268856);
    29: // cup (metric)
      updateVolume(V / 4000);
    30: // cup (US)
      updateVolume(V / 4226.75283773037);
    31: // cup (Canadian)
      updateVolume(V / 4399.38496598176);
    33: // table spoon (UK)
      updateVolume(V / 56312.1275645665);
    34: // table spoon (US)
      updateVolume(V / 67628.045403686);
    35: // table spoon (Canadian)
      updateVolume(V / 70390.1594557081);
    36: // table spoon (metric)
      updateVolume(V * 3 / 200000);
    38: // tea spoon (UK)
      updateVolume(V / 168936.382693699);
    39: // tea spoon (US)
      updateVolume(V / 202884.136211058);
    40: // tea spoon (Canadian)
      updateVolume(V / 211170.478367124);
    41: // tea spoon (metric)
      updateVolume(V / 202884.136211058);
    else
  end;
  sgConvertVolume.Modified := False;
end;

procedure TFormMain.sgExpr_CalcEditingDone(Sender: TObject);
var
  n, sy: integer;
  s: string;
begin
  try
    sgExpr_Calc.OnEditingDone := nil;
    sy := sgExpr_Calc.Row;
    if sy < 1 then
      Exit;
    s := Trim(sgExpr_Calc.Cells[1, sy]);
    if s = '' then
      Exit;

    CalcExpressionStr := '';
    n := CalcExpression(sgExpr_Calc, s);
    if n = 0 then
    begin
      sgExpr_Calc.Cells[2, sy] := CalcExpressionStr;
      if sy = sgExpr_Calc.RowCount - 1 then
      begin
        sgExpr_Calc.RowCount := sgExpr_Calc.RowCount + 1;
        if sgExpr_Calc.RowCount > 100 then
          sgExpr_Calc.DeleteRow(1);
        sgExpr_Calc.Col := 1;
        sgExpr_Calc.Row := sy + 1;
        sgExpr_Calc.SetFocus;
      end;
    end
    else
    begin
      if (n = 1) or (n = 5) then
      begin
        sgExpr_Calc.Cells[2, sy] := 'Error';
        sgExpr_Calc.Col := 1;
        sgExpr_Calc.Row := sy;
        sgExpr_Calc.SetFocus;
      end;
      beep;
    end;

  finally
    sgExpr_Calc.OnEditingDone := @sgExpr_CalcEditingDone;
  end;
end;

procedure TFormMain.sgExpr_CalcKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
    Key := #0;
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

procedure TFormMain.splPascalScriptMoved(Sender: TObject);
var
  spl: TSplitter;
  syn: TSynEdit;
  btn: TToolButton;
  s: string;
begin
  spl := TSplitter(Sender);
  s   := spl.Name;
  Delete(s, 1, Length('spl'));
  syn := TSynEdit(FindComponent('SynEdit' + s));
  if spl.Align = alLeft then
    ini.WriteInteger(s, 'Width', syn.Width)
  else
    ini.WriteInteger(s, 'Height', syn.Height);
end;

procedure TFormMain.SynEditGraphChange(Sender: TObject);
begin
  Compiled_Graph := False;
  btnSave_Graph.Enabled := SynEditGraph.Modified;
  btnSaveAs_Graph.Enabled := SynEditGraph.Modified;
end;

procedure TFormMain.SynEditGraphStatusChange(Sender: TObject;
  Changes: TSynStatusChanges);
begin
  btnCaret_Graph.Caption := IntToStr(SynEditGraph.CaretX) + ', ' +
    IntToStr(SynEditGraph.CaretY);
  if SynEditGraph.SelAvail then
    btnCaret_Graph.Caption := btnCaret_Graph.Caption + ' Sel: ' +
      IntToStr(Length(SynEditGraph.SelText));
end;

procedure TFormMain.SynEditCChange(Sender: TObject);
begin
  btnSave_C.Enabled   := SynEditC.Modified;
  btnSaveAs_C.Enabled := SynEditC.Modified;
end;

procedure TFormMain.SynEditCStatusChange(Sender: TObject; Changes: TSynStatusChanges);
begin
  btnCaret_C.Caption := IntToStr(SynEditC.CaretX) + ', ' + IntToStr(SynEditC.CaretY);
  if SynEditC.SelAvail then
    btnCaret_C.Caption := btnCaret_C.Caption + ' Sel: ' +
      IntToStr(Length(SynEditC.SelText));
end;

procedure TFormMain.SynEditLuaChange(Sender: TObject);
begin
  btnSave_Lua.Enabled   := SynEditLua.Modified;
  btnSaveAs_Lua.Enabled := SynEditLua.Modified;
end;

procedure TFormMain.SynEditLuaStatusChange(Sender: TObject; Changes: TSynStatusChanges);
begin
  btnCaret_Lua.Caption := IntToStr(SynEditLua.CaretX) + ', ' +
    IntToStr(SynEditLua.CaretY);
  if SynEditLua.SelAvail then
    btnCaret_Lua.Caption := btnCaret_Lua.Caption + ' Sel: ' +
      IntToStr(Length(SynEditLua.SelText));
end;

procedure TFormMain.SynEditMPYChange(Sender: TObject);
begin
  btnSave_MPY.Enabled   := SynEditMPY.Modified;
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
  sgVar_Calc.Modified   := True;
  sgVar_Calc.RowCount   := 4;
  sgVar_Calc.Rows[1].CommaText := 'x,12,variant';
  sgVar_Calc.Rows[2].CommaText := 'y,5.6,variant';
  SynEditFunc_Calc.Text := NewFileTemplate_Calc;
  SynEditFunc_Calc.Modified := True;
  dlgSave_Calc.FileName := '';
  if pmHis_Calc.Items.Count > 0 then
    pmHis_Calc.Items[0].Checked := False;
end;

procedure TFormMain.btnNew_CClick(Sender: TObject);
begin
  if Sender <> nil then
    SynEditC.Text := NewFileTemplate_C;
  SynEditC.Modified := False;
  btnSave_C.Enabled := False;
  btnSaveAs_C.Enabled := False;
  tsC.Caption := 'C';
  dlgSave_C.FileName := '';
  if pmHis_C.Items.Count > 0 then
    pmHis_C.Items[0].Checked := False;
end;

procedure TFormMain.btnNew_GraphClick(Sender: TObject);
begin
  if Sender <> nil then
    SynEditGraph.Text := NewFileTemplate_Graph;
  SynEditGraph.Modified := False;
  btnSave_Graph.Enabled := False;
  btnSaveAs_Graph.Enabled := False;
  tsGraph.Caption := 'Graph';
  dlgSave_Graph.FileName := '';
  if pmHis_Graph.Items.Count > 0 then
    pmHis_Graph.Items[0].Checked := False;
  Compiled_Graph := False;
end;

procedure TFormMain.btnNew_LuaClick(Sender: TObject);
begin
  if Sender <> nil then
    SynEditLua.Text := NewFileTemplate_Lua;
  SynEditLua.Modified := False;
  btnSave_Lua.Enabled := False;
  btnSaveAs_Lua.Enabled := False;
  tsLua.Caption := 'Lua';
  dlgSave_Lua.FileName := '';
  if pmHis_Lua.Items.Count > 0 then
    pmHis_Lua.Items[0].Checked := False;
end;

procedure TFormMain.btnNew_MPYClick(Sender: TObject);
begin
  if Sender <> nil then
    SynEditMPY.Text     := NewFileTemplate_MPY;
  SynEditMPY.Modified   := False;
  btnSave_MPY.Enabled   := False;
  btnSaveAs_MPY.Enabled := False;
  tsMicropython.Caption := 'micropython';
  dlgSave_MPY.FileName  := '';
  if pmHis_MPY.Items.Count > 0 then
    pmHis_MPY.Items[0].Checked := False;
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
  if pmHis_PascalScript.Items.Count > 0 then
    pmHis_PascalScript.Items[0].Checked := False;
end;

procedure TFormMain.btnNoteConvertDistanceClick(Sender: TObject);
var
  mmo: TMemo;
  btn: TSpeedButton;
  s: string;
begin
  btn := TSpeedButton(Sender);
  btn.ImageIndex := 1 - btn.ImageIndex;
  s   := btn.Name;
  Delete(s, 1, 3);
  mmo := TMemo(FindComponent('mmo' + s));
  if mmo <> nil then
  begin
    mmo.Visible := btn.ImageIndex = 0;
    mmo.Top     := btn.Top + 20;
    ini.WriteBool('Note', s, mmo.Visible);
  end;
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

procedure TFormMain.btnOpen_CClick(Sender: TObject);
begin
  if dlgOpen_C.Execute then
  begin
    LoadFile_C(dlgOpen_C.FileName);
    pmAddHis(pmHis_C, dlgOpen_C.FileName);
  end;
end;

procedure TFormMain.btnOpen_GraphClick(Sender: TObject);
begin
  if dlgOpen_Graph.Execute then
  begin
    LoadFile_Graph(dlgOpen_Graph.FileName);
    pmAddHis(pmHis_Graph, dlgOpen_Graph.FileName);
  end;
end;

procedure TFormMain.btnOpen_LuaClick(Sender: TObject);
begin
  if dlgOpen_Lua.Execute then
  begin
    LoadFile_Lua(dlgOpen_Lua.FileName);
    pmAddHis(pmHis_Lua, dlgOpen_Lua.FileName);
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

procedure TFormMain.btnPanelMode_PascalScriptClick(Sender: TObject);
var
  spl: TSplitter;
  syn: TSynEdit;
  btn: TToolButton;
  mmo: TMemo;
  s: string;
begin
  btn := TToolButton(Sender);
  s   := btn.Name;
  Delete(s, 1, Length('btnPanelMode_'));
  spl := TSplitter(FindComponent('spl' + s));
  syn := TSynEdit(FindComponent('SynEdit' + s));
  mmo := TMemo(FindComponent('mmoOut' + s));
  if spl.Align = alTop then
  begin
    syn.Align := alLeft;
    syn.Width := ini.ReadInteger(s, 'Width', 320);
    spl.Align := alLeft;
    spl.Left  := syn.Left + 10;
    btn.ImageIndex := 43;
  end
  else
  begin
    syn.Align  := alTop;
    syn.Height := ini.ReadInteger(s, 'Height', 300);
    spl.Align  := alTop;
    spl.Top    := syn.Top + 10;
    btn.ImageIndex := 44;
  end;
  mmoOutPosCheck(syn, mmo);
  ini.WriteBool(s, 'Vert', spl.Align = alLeft);
end;

procedure TFormMain.btnRun_CClick(Sender: TObject);
var
  tmpfile: string;
  CharBuffer: array [0..511] of char;
  ReadCount: integer;
begin
  btnStop_C.Enabled := True;
  btnRun_C.Enabled  := False;
  try
    try
      tmpfile := GetTempFileName + '.c';
      SynEditC.Lines.SaveToFile(tmpfile);

      ProcessC.Executable := external_c_bin_name;
      ProcessC.Parameters.Clear;
      ProcessC.Parameters.Add('-run');
      ProcessC.Parameters.Add(tmpfile);

      if FileExists(ProcessC.Executable) then
      begin
        ProcessC.Execute;
      end
      else
      begin
        mmoOutAdd_C(#13#10 +
          'C interpreter not found. Please check the settings in the options.' +
          #13#10);
      end;

      while ProcessC.Running or (ProcessC.Output.NumBytesAvailable > 0) or
        (ProcessC.Stderr.NumBytesAvailable > 0) do
      begin
        while ProcessC.Output.NumBytesAvailable > 0 do
        begin
          ReadCount := Min(512, ProcessC.Output.NumBytesAvailable);
          //Read up to buffer, not more
          ProcessC.Output.Read(CharBuffer, ReadCount);
          mmoOutAdd_C(Copy(CharBuffer, 0, ReadCount));
          Application.ProcessMessages;
        end;
        // read stderr and write to our stderr
        while ProcessC.Stderr.NumBytesAvailable > 0 do
        begin
          ReadCount := Min(512, ProcessC.Stderr.NumBytesAvailable);
          //Read up to buffer, not more
          ProcessC.Stderr.Read(CharBuffer, ReadCount);
          mmoOutAdd_C(Copy(CharBuffer, 0, ReadCount));
          Application.ProcessMessages;
        end;
      end;
    except

    end;
  finally
    btnStop_C.Enabled := False;
    btnRun_C.Enabled  := True;
  end;
end;

procedure TFormMain.btnRun_GraphClick(Sender: TObject);
var
  res: boolean;
  i: integer;
begin
  btnStop_Graph.Enabled := True;
  btnRun_Graph.Enabled  := False;
  try
    try
      if not Compiled_Graph then
      begin
        // compile
        Script_Graph.Script.Text := SynEditGraph.Text;
        Compiled_Graph := Script_Graph.Compile;

        if not Compiled_Graph then
        begin
          if Script_Graph.CompilerMessageCount > 0 then
            for i := 0 to Script_Graph.CompilerMessageCount - 1 do
              mmoOutGraph.Lines.add(Script_Graph.CompilerErrorToStr(i));
          Exit;
        end;
      end;

      Application.ProcessMessages;
      // run
      FormGraph.Show;
      res := Script_Graph.Execute;
      if not res then
        mmoOutGraph.Lines.add('Run-time error:' + Script_Graph.ExecErrorToString);

    except
      on E: Exception do
      begin
        mmoOutGraph.Lines.add(E.Message);
      end;
    end;
  finally
    btnStop_Graph.Enabled := False;
    btnRun_Graph.Enabled  := True;
  end;
end;

procedure TFormMain.btnRun_LuaClick(Sender: TObject);
var
  tmpfile: string;
  CharBuffer: array [0..511] of char;
  ReadCount: integer;
begin
  btnStop_Lua.Enabled := True;
  btnRun_Lua.Enabled  := False;
  try
    try
      tmpfile := GetTempFileName + '.lua';
      SynEditLua.Lines.SaveToFile(tmpfile);

      if use_external_lua then
        ProcessLua.Executable := external_lua_bin_name
      else
        ProcessLua.Executable :=
          ExtractFilePath(Application.ExeName) + LUA_BIN_NAME;

      ProcessLua.Parameters.Clear;
      ProcessLua.Parameters.Add(tmpfile);

      if FileExists(ProcessLua.Executable) then
      begin
        ProcessLua.Execute;
      end
      else
      begin
        mmoOutAdd_Lua(#13#10 +
          'Lua interpreter not found. Please check the settings in the options.'
          +
          #13#10);
      end;

      while ProcessLua.Running or (ProcessLua.Output.NumBytesAvailable > 0) or
        (ProcessLua.Stderr.NumBytesAvailable > 0) do
      begin
        while ProcessLua.Output.NumBytesAvailable > 0 do
        begin
          ReadCount := Min(512, ProcessLua.Output.NumBytesAvailable);
          //Read up to buffer, not more
          ProcessLua.Output.Read(CharBuffer, ReadCount);
          mmoOutAdd_Lua(Copy(CharBuffer, 0, ReadCount));
          Application.ProcessMessages;
        end;
        // read stderr and write to our stderr
        while ProcessLua.Stderr.NumBytesAvailable > 0 do
        begin
          ReadCount := Min(512, ProcessLua.Stderr.NumBytesAvailable);
          //Read up to buffer, not more
          ProcessLua.Stderr.Read(CharBuffer, ReadCount);
          mmoOutAdd_Lua(Copy(CharBuffer, 0, ReadCount));
          Application.ProcessMessages;
        end;
      end;
    except

    end;
  finally
    btnStop_Lua.Enabled := False;
    btnRun_Lua.Enabled  := True;
  end;
end;

procedure TFormMain.btnRun_MPYClick(Sender: TObject);
var
  tmpfile: string;
  CharBuffer: array [0..511] of char;
  ReadCount: integer;
begin
  btnStop_MPY.Enabled := True;
  btnRun_MPY.Enabled  := False;
  try
    try
      tmpfile := GetTempFileName + '.py';
      SynEditMPY.Lines.SaveToFile(tmpfile);

      if use_external_micropython then
        ProcessMPY.Executable := external_micropython_bin_name
      else
        ProcessMPY.Executable :=
          ExtractFilePath(Application.ExeName) + MICROPYTHON_BIN_NAME;

      ProcessMPY.Parameters.Clear;
      ProcessMPY.Parameters.Add(tmpfile);

      if FileExists(ProcessMPY.Executable) then
      begin
        ProcessMPY.Execute;
      end
      else
      begin
        mmoOutAdd_MPY(#13#10 +
          'micropython interpreter not found. Please check the settings in the options.'
          +
          #13#10);
      end;

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

procedure TFormMain.btnSaveAs_CClick(Sender: TObject);
begin
  if dlgSave_C.Execute then
  begin
    SaveFile_C(dlgSave_C.FileName);
    pmAddHis(pmHis_C, dlgSave_C.FileName);
  end;
end;

procedure TFormMain.btnSaveAs_GraphClick(Sender: TObject);
begin
  if dlgSave_Graph.Execute then
  begin
    SaveFile_Graph(dlgSave_Graph.FileName);
    pmAddHis(pmHis_Graph, dlgSave_Graph.FileName);
  end;
end;

procedure TFormMain.btnSaveAs_LuaClick(Sender: TObject);
begin
  if dlgSave_Lua.Execute then
  begin
    SaveFile_Lua(dlgSave_Lua.FileName);
    pmAddHis(pmHis_Lua, dlgSave_Lua.FileName);
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

procedure TFormMain.btnSavePic_GraphClick(Sender: TObject);
begin
  if dlgSavePic_Graph.Execute then
  begin
    FormGraph.image.Picture.SaveToFile(dlgSavePic_Graph.FileName);
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

procedure TFormMain.btnSave_CClick(Sender: TObject);
begin
  if dlgSave_C.FileName = '' then
  begin
    if not dlgSave_C.Execute then
      Exit;
    pmAddHis(pmHis_C, dlgSave_C.FileName);
  end;
  SaveFile_C(dlgSave_C.FileName);
end;

procedure TFormMain.btnSave_GraphClick(Sender: TObject);
begin
  if dlgSave_Graph.FileName = '' then
  begin
    if not dlgSave_Graph.Execute then
      Exit;
    pmAddHis(pmHis_Graph, dlgSave_Graph.FileName);
  end;
  SaveFile_Graph(dlgSave_Graph.FileName);
end;

procedure TFormMain.btnSave_LuaClick(Sender: TObject);
begin
  if dlgSave_Lua.FileName = '' then
  begin
    if not dlgSave_Lua.Execute then
      Exit;
    pmAddHis(pmHis_Lua, dlgSave_Lua.FileName);
  end;
  SaveFile_Lua(dlgSave_Lua.FileName);
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

procedure TFormMain.btnShowGraphFormClick(Sender: TObject);
begin
  FormGraph.Show;
end;

procedure TFormMain.btnStop_CClick(Sender: TObject);
begin
  btnStop_C.Enabled := False;
  btnRun_C.Enabled  := True;
  if ProcessC.Running then
  begin
    ProcessC.Terminate(0);
  end;
end;

procedure TFormMain.btnStop_GraphClick(Sender: TObject);
begin
  btnStop_Graph.Enabled := False;
  btnRun_Graph.Enabled  := True;
  Script_Graph.Stop;
end;

procedure TFormMain.btnStop_LuaClick(Sender: TObject);
begin
  btnStop_Lua.Enabled := False;
  btnRun_Lua.Enabled  := True;
  if ProcessLua.Running then
  begin
    ProcessLua.Terminate(0);
  end;
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
    MinimizeToTray := FormOption.chkMinimizeToTray.Checked;
    CloseToTray := FormOption.chkCloseToTray.Checked;
    errlog_en := FormOption.chkErrlog_En.Checked;

    ini.WriteBool('Option', 'TrayIcon', TrayIcon.Visible);
    ini.WriteBool('Option', 'MinimizeToTray', MinimizeToTray);
    ini.WriteBool('Option', 'CloseToTray', CloseToTray);
    ini.WriteBool('Option', 'errlog', errlog_en);

    if FormOption.dlgFont.Tag = 2 then
    begin
      Font := FormOption.Font;
      saveFont;
    end;

    use_external_micropython := FormOption.chkUse_external_micropython.Checked;
    external_micropython_bin_name := FormOption.edtExternal_micropython_bin.Text;
    use_external_lua      := FormOption.chkUse_external_lua.Checked;
    external_lua_bin_name := FormOption.edtExternal_lua_bin.Text;
    external_c_bin_name   := FormOption.edtExternal_c_bin.Text;

    ini.WriteBool('MPY', 'use_external_micropython', use_external_micropython);
    ini.WriteString('MPY', 'external_micropythn_bin',
      external_micropython_bin_name);
    ini.WriteBool('lua', 'use_external_lua', use_external_lua);
    ini.WriteString('lua', 'external_lua_bin', external_lua_bin_name);
    ini.WriteString('C', 'TinyC_bin', external_c_bin_name);

    if writeable then
      ini.UpdateFile;
  end;
end;

procedure TFormMain.cbbCalcDblClick(Sender: TObject);
var
  n, i: integer;
begin
  n := CalcExpression(cbbCalc, cbbCalc.Text);
  if n = 0 then
  begin
    mmoOutCalc.Lines.add('');
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
  end
  else
  begin
    beep;
    if n = 1 then
      mmoOutCalc.Lines.add('Run-time error:' + Script_Calc.ExecErrorToString);
  end;

end;

procedure TFormMain.cbbCalcKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
  begin
    Key := #0;
    //btnRun_CalcClick(Sender);
    cbbCalcDblClick(Sender);
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
var
  s: string;
begin
  // change Tray Icon
  ilTray.Tag := ilTray.Tag + 1;
  if ilTray.Tag > 0 then
    ilTray.GetIcon((ilTray.Tag div 5) mod ilTray.Count, TrayIcon.Icon);

  // change time interval
  ilOption.Tag := ilOption.Tag + 1;
  if ilOption.Tag > 300 then
  begin
    ilOption.Tag     := 0;
    tmrLogo.Interval := Random(15) * 10 + 50;
    if MinuteOf(now) <> RunTimeM then
    begin
      RunTimeM := MinuteOf(now);
      RunTime  := RunTime + 1;
      lbRunTime.Tag := lbRunTime.Tag + 1;
      if writeable then
        ini.WriteInteger('run', 'time', RunTime);
      s := RunTimeToDHMStr(RunTime);
      if s <> '' then
      begin
        lbRunTime.Caption := 'Time: ' + s;
        lbRunTime.Hint    := 'Uptime: ' + RunTimeToDHMStr(lbRunTime.Tag);
      end;
    end;
  end;

  if (pcMain.ActivePage = tsAbout) and Visible then
  begin
    // option image animation
    tmrLogo.Tag := (tmrLogo.Tag + btnShowOption.Tag) mod ilOption.Count;
    btnShowOption.ImageIndex := tmrLogo.Tag;
    if tmrLogo.Tag mod 5 = 0 then
    begin
      // change logo
      imgLogo.Visible := not imgLogo.Visible;

      // option iamge animation dir
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
        111: // N Root
        begin
          bfA.Assign(sa);
          bfB.Assign(sb);
          bfB.Reciprocal(bfPrec);
          bfA.Power(bfB, bfPrec);
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

          if biB.Compare(2) <> 1 then
            sa := '2' + #13#10
          else
            sa := '';
          repeat
            biB.Getnextprime;
            if biA.Compare(biB) = 1 then    // A > B
            begin
              sa := sa + biB.ConvertToDecimalString(chkBigIntComma.Checked) + #13#10;
            end
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

// 0: ok
// 1: runtime error
// 2: input = blank
// 3: Var define error
// 4: Function define error
// 5: express error
function TFormMain.CalcExpression(Sender: TObject; expr: string): integer;
var
  res: boolean;
  i: integer;
begin
  Result := 2;
  expr   := Trim(expr);
  if expr = '' then
  begin
    Exit;
  end;

  try
    try
      // compile variables
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
            ShowMessage('Variables define error!');
            Beep;
            sgVar_Calc.SetFocus;
            Result := 3;
            Exit;
          end;
        end;
        sgVar_Calc.Modified := False;
      end;

      // compile functions
      if SynEditFunc_Calc.Modified then
      begin
        Script_Calc_CodeFunc := #13#10 + SynEditFunc_Calc.Text + #13#10;
        Script_Calc.Script.Text :=
          Script_Calc_CodeVar + Script_Calc_CodeFunc + Script_Calc_CodeMain + 'end.';
        res := Script_Calc.Compile;
        if not res then
        begin
          ShowMessage('Function define error!');
          Beep;
          SynEditFunc_Calc.SetFocus;
          Result := 4;
          Exit;
        end;
        SynEditFunc_Calc.Modified := False;
      end;

      // compile expression
      if Sender = cbbCalc then
        Script_Calc.Script.Text :=
          Script_Calc_CodeVar + Script_Calc_CodeFunc + Script_Calc_CodeMain +
          #13#10 + 'sprint('' '',[' + expr + ']);' + #13#10 + 'End.'
      else
        Script_Calc.Script.Text :=
          Script_Calc_CodeVar + Script_Calc_CodeFunc + Script_Calc_CodeMain +
          #13#10 + '_reserved_print('' '',[' + expr + ']);' + #13#10 + 'End.';

      res := Script_Calc.Compile;
      if not res then
      begin
        if Sender = cbbCalc then
        begin
          mmoOutCalc.Lines.Add('Express error!');
          cbbCalc.SetFocus;
        end
        else
          sgExpr_Calc.SetFocus;

        Beep;
        Result := 5;
        Exit;
      end;

      Application.ProcessMessages;

      // run
      if Sender = cbbCalc then
      begin
        mmoOutCalc.Lines.Add('> ' + cbbCalc.Text);
        mmoOutCalc.Lines.Add('= ');
      end;

      Script_Calc.Execute;

      Result := 0;
    except
      on E: Exception do
      begin
        Result := 1;
        if Sender = cbbCalc then
          mmoOutCalc.Lines.add(E.Message);
      end;
    end;
  finally

  end;
end;

procedure TFormMain.mmoOutPosCheck(syn: TSynEdit; mmo: TMemo);
begin
  if syn.Align = alLeft then
  begin
    if mmo.Width = 0 then
      syn.Width := pcScript.Width - 40;
  end
  else
  begin
    if mmo.Height = 0 then
      syn.Height := pcScript.Height - 70;
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
    edtConvertTimeYear.Text  := IntToStr(YearOf(d));
    edtConvertTimeMonth.Text := IntToStr(MonthOf(d));
    edtConvertTimeDay.Text   := IntToStr(DayOf(d));
    edtConvertTimeHour.Text  := IntToStr(HourOf(d));
    edtConvertTimeMin.Text   := IntToStr(MinuteOf(d));
    edtConvertTimeSec.Text   := IntToStr(SecondOf(d));

    sgConvertTime.Cells[1, 1] := DateTimeToStr(d, DateTimefmt);
    sgConvertTime.Cells[1, 2] := IntToStr(DateTimeToUnix(d));
    sgConvertTime.Cells[1, 3] :=
      Format('(%d, %d, %d, %d, %d, %d, %d, %d, %d)',
      [YearOf(d), MonthOf(d), DayOf(d), HourOf(d), MinuteOf(d),
      SecondOf(d), DayOfTheWeek(d) - 1, DayOfTheYear(d), 0]);

    sgConvertTime.Cells[1, 4]  := '';
    sgConvertTime.Cells[1, 5]  := IntToStr(WeekOfTheYear(d));
    sgConvertTime.Cells[1, 6]  := IntToStr(DayOfTheYear(d));
    sgConvertTime.Cells[1, 7]  := IntToStr(HourOfTheYear(d));
    sgConvertTime.Cells[1, 8]  := IntToStr(MinuteOfTheYear(d));
    sgConvertTime.Cells[1, 9]  := IntToStr(SecondOfTheYear(d));
    sgConvertTime.Cells[1, 10] := IntToStr(DayOfTheWeek(d));
  except

  end;
end;

procedure TFormMain.updateTemperature(C: Float);
begin
  sgConvertTemperature.Cells[1, 1] :=
    FloatToStrF(C, ffFixed, 0, edtDecimalDigitsConvertTemperature.Value);
  sgConvertTemperature.Cells[1, 2] :=
    FloatToStrF(C * 1.8 + 32, ffFixed, 0, edtDecimalDigitsConvertTemperature.Value);
  sgConvertTemperature.Cells[1, 3] :=
    FloatToStrF(C + 273.15, ffFixed, 0, edtDecimalDigitsConvertTemperature.Value);
  sgConvertTemperature.Cells[1, 4] :=
    FloatToStrF(C * 0.33, ffFixed, 0, edtDecimalDigitsConvertTemperature.Value);
  sgConvertTemperature.Cells[1, 5] :=
    FloatToStrF(C * 0.8, ffFixed, 0, edtDecimalDigitsConvertTemperature.Value);
  sgConvertTemperature.Cells[1, 6] :=
    FloatToStrF((C + 273.15) * 1.8, ffFixed, 0,
    edtDecimalDigitsConvertTemperature.Value);
end;

procedure TFormMain.updatePower(P: Float);
begin
  sgConvertPower.Cells[1, 1] :=
    FloatToStrF(P, ffFixed, 0, edtDecimalDigitsConvertPower.Value);
  sgConvertPower.Cells[1, 2] :=
    FloatToStrF(P * 1000, ffFixed, 0, edtDecimalDigitsConvertPower.Value);
  sgConvertPower.Cells[1, 3] :=
    FloatToStrF(10 * log10(P * 1000), ffFixed, 0, edtDecimalDigitsConvertPower.Value);
end;

procedure TFormMain.updateDistance(V: Float);
begin
  sgConvertDistance.Cells[1, 1]  :=
    FloatToStrF(V * 1000, ffFixed, 0, edtDecimalDigitsConvertDistance.Value);
  sgConvertDistance.Cells[1, 2]  :=
    FloatToStrF(V, ffFixed, 0, edtDecimalDigitsConvertDistance.Value);
  sgConvertDistance.Cells[1, 3]  :=
    FloatToStrF(V / 1000, ffFixed, 0, edtDecimalDigitsConvertDistance.Value);
  sgConvertDistance.Cells[1, 4]  := '';
  sgConvertDistance.Cells[1, 5]  :=
    FloatToStrF(V / 0.0000254, ffFixed, 0, edtDecimalDigitsConvertDistance.Value);
  sgConvertDistance.Cells[1, 6]  :=
    FloatToStrF(V / 0.0254, ffFixed, 0, edtDecimalDigitsConvertDistance.Value);
  sgConvertDistance.Cells[1, 7]  :=
    FloatToStrF(V / 0.0254 / 12, ffFixed, 0, edtDecimalDigitsConvertDistance.Value);
  sgConvertDistance.Cells[1, 8]  :=
    FloatToStrF(V / 0.0254 / 36, ffFixed, 0, edtDecimalDigitsConvertDistance.Value);
  sgConvertDistance.Cells[1, 9]  :=
    FloatToStrF(V / 0.0254 / 36 / 1760, ffFixed, 0,
    edtDecimalDigitsConvertDistance.Value);
  sgConvertDistance.Cells[1, 10] :=
    FloatToStrF(V / 1852, ffFixed, 0, edtDecimalDigitsConvertDistance.Value);
  sgConvertDistance.Cells[1, 11] :=
    FloatToStrF(V / 1854.55, ffFixed, 0, edtDecimalDigitsConvertDistance.Value);
  sgConvertDistance.Cells[1, 12] :=
    FloatToStrF(V / 1851.01, ffFixed, 0, edtDecimalDigitsConvertDistance.Value);
  sgConvertDistance.Cells[1, 13] := '';
  sgConvertDistance.Cells[1, 14] :=
    FloatToStrF(V * 3, ffFixed, 0, edtDecimalDigitsConvertDistance.Value);
  sgConvertDistance.Cells[1, 15] :=
    FloatToStrF(V * 3 / 10, ffFixed, 0, edtDecimalDigitsConvertDistance.Value);
end;

procedure TFormMain.updateArea(A: Float);
begin
  sgConvertArea.Cells[1, 1]  :=
    FloatToStrF(A * 10000, ffFixed, 0, edtDecimalDigitsConvertArea.Value);
  sgConvertArea.Cells[1, 2]  :=
    FloatToStrF(A, ffFixed, 0, edtDecimalDigitsConvertArea.Value);
  sgConvertArea.Cells[1, 3]  :=
    FloatToStrF(A / 1000000, ffFixed, 0, edtDecimalDigitsConvertArea.Value);
  sgConvertArea.Cells[1, 5]  :=
    FloatToStrF(A * 1550.0031000062, ffFixed, 0, edtDecimalDigitsConvertArea.Value);
  sgConvertArea.Cells[1, 6]  :=
    FloatToStrF(A * 10.7639104167097, ffFixed, 0, edtDecimalDigitsConvertArea.Value);
  sgConvertArea.Cells[1, 7]  :=
    FloatToStrF(A * 10.7638673611111, ffFixed, 0, edtDecimalDigitsConvertArea.Value);
  sgConvertArea.Cells[1, 8]  :=
    FloatToStrF(A * 1.19599004630108, ffFixed, 0, edtDecimalDigitsConvertArea.Value);
  sgConvertArea.Cells[1, 9]  :=
    FloatToStrF(A * 3.86102158542446e-007, ffFixed, 0,
    edtDecimalDigitsConvertArea.Value);
  sgConvertArea.Cells[1, 11] :=
    FloatToStrF(A * 0.000247105381467, ffFixed, 0, edtDecimalDigitsConvertArea.Value);
  sgConvertArea.Cells[1, 12] :=
    FloatToStrF(A * 0.0001, ffFixed, 0, edtDecimalDigitsConvertArea.Value);
  sgConvertArea.Cells[1, 13] :=
    FloatToStrF(A * 0.000988421525869, ffFixed, 0, edtDecimalDigitsConvertArea.Value);
  sgConvertArea.Cells[1, 14] :=
    FloatToStrF(A * 0.0015, ffFixed, 0, edtDecimalDigitsConvertArea.Value);
  sgConvertArea.Cells[1, 15] :=
    FloatToStrF(A * 1973.52524138998, ffFixed, 0, edtDecimalDigitsConvertArea.Value);
  sgConvertArea.Cells[1, 16] :=
    FloatToStrF(A * 1.07250599595124e-008, ffFixed, 0,
    edtDecimalDigitsConvertArea.Value);
end;

procedure TFormMain.updateVolume(V: Float);
begin
  sgConvertVolume.Cells[1, 1]  :=
    FloatToStrF(V * 1e6, ffFixed, 0, edtDecimalDigitsConvertVolume.Value);
  sgConvertVolume.Cells[1, 2]  :=
    FloatToStrF(V * 1e3, ffFixed, 0, edtDecimalDigitsConvertVolume.Value);
  sgConvertVolume.Cells[1, 3]  :=
    FloatToStrF(V, ffFixed, 0, edtDecimalDigitsConvertVolume.Value);
  sgConvertVolume.Cells[1, 4]  :=
    FloatToStrF(V * 61023.7440947323, ffFixed, 0, edtDecimalDigitsConvertVolume.Value);
  sgConvertVolume.Cells[1, 5]  :=
    FloatToStrF(V * 35.3146667214886, ffFixed, 0, edtDecimalDigitsConvertVolume.Value);
  sgConvertVolume.Cells[1, 6]  :=
    FloatToStrF(V * 1.30795061931439, ffFixed, 0, edtDecimalDigitsConvertVolume.Value);
  sgConvertVolume.Cells[1, 7]  :=
    FloatToStrF(V * 1000, ffFixed, 0, edtDecimalDigitsConvertVolume.Value);
  sgConvertVolume.Cells[1, 9]  :=
    FloatToStrF(V * 219.969248299088, ffFixed, 0, edtDecimalDigitsConvertVolume.Value);
  sgConvertVolume.Cells[1, 10] :=
    FloatToStrF(V * 264.172052358148, ffFixed, 0, edtDecimalDigitsConvertVolume.Value);
  sgConvertVolume.Cells[1, 11] :=
    FloatToStrF(V * 227.020746067214, ffFixed, 0, edtDecimalDigitsConvertVolume.Value);
  sgConvertVolume.Cells[1, 13] :=
    FloatToStrF(V * 6.11025689719688, ffFixed, 0, edtDecimalDigitsConvertVolume.Value);
  sgConvertVolume.Cells[1, 14] :=
    FloatToStrF(V * 8.38641436057614, ffFixed, 0, edtDecimalDigitsConvertVolume.Value);
  sgConvertVolume.Cells[1, 15] :=
    FloatToStrF(V * 8.6484093739891, ffFixed, 0, edtDecimalDigitsConvertVolume.Value);
  sgConvertVolume.Cells[1, 16] :=
    FloatToStrF(V * 6.2898107704321, ffFixed, 0, edtDecimalDigitsConvertVolume.Value);
  sgConvertVolume.Cells[1, 18] :=
    FloatToStrF(V * 35195.079727854, ffFixed, 0, edtDecimalDigitsConvertVolume.Value);
  sgConvertVolume.Cells[1, 19] :=
    FloatToStrF(V * 33814.022701843, ffFixed, 0, edtDecimalDigitsConvertVolume.Value);
  sgConvertVolume.Cells[1, 21] :=
    FloatToStrF(V * 1759.7539863927, ffFixed, 0, edtDecimalDigitsConvertVolume.Value);
  sgConvertVolume.Cells[1, 22] :=
    FloatToStrF(V * 2113.37641886519, ffFixed, 0, edtDecimalDigitsConvertVolume.Value);
  sgConvertVolume.Cells[1, 23] :=
    FloatToStrF(V * 1816.16596853771, ffFixed, 0, edtDecimalDigitsConvertVolume.Value);
  sgConvertVolume.Cells[1, 25] :=
    FloatToStrF(V * 879.876993196351, ffFixed, 0, edtDecimalDigitsConvertVolume.Value);
  sgConvertVolume.Cells[1, 26] :=
    FloatToStrF(V * 1056.68820943259, ffFixed, 0, edtDecimalDigitsConvertVolume.Value);
  sgConvertVolume.Cells[1, 27] :=
    FloatToStrF(V * 908.082984268856, ffFixed, 0, edtDecimalDigitsConvertVolume.Value);
  sgConvertVolume.Cells[1, 29] :=
    FloatToStrF(V * 4000, ffFixed, 0, edtDecimalDigitsConvertVolume.Value);
  sgConvertVolume.Cells[1, 30] :=
    FloatToStrF(V * 4226.75283773037, ffFixed, 0, edtDecimalDigitsConvertVolume.Value);
  sgConvertVolume.Cells[1, 31] :=
    FloatToStrF(V * 4399.38496598176, ffFixed, 0, edtDecimalDigitsConvertVolume.Value);
  sgConvertVolume.Cells[1, 33] :=
    FloatToStrF(V * 56312.1275645665, ffFixed, 0, edtDecimalDigitsConvertVolume.Value);
  sgConvertVolume.Cells[1, 34] :=
    FloatToStrF(V * 67628.045403686, ffFixed, 0, edtDecimalDigitsConvertVolume.Value);
  sgConvertVolume.Cells[1, 35] :=
    FloatToStrF(V * 70390.1594557081, ffFixed, 0, edtDecimalDigitsConvertVolume.Value);
  sgConvertVolume.Cells[1, 36] :=
    FloatToStrF(V * 200000 / 3, ffFixed, 0, edtDecimalDigitsConvertVolume.Value);
  sgConvertVolume.Cells[1, 38] :=
    FloatToStrF(V * 168936.382693699, ffFixed, 0, edtDecimalDigitsConvertVolume.Value);
  sgConvertVolume.Cells[1, 39] :=
    FloatToStrF(V * 202884.136211058, ffFixed, 0, edtDecimalDigitsConvertVolume.Value);
  sgConvertVolume.Cells[1, 40] :=
    FloatToStrF(V * 211170.478367124, ffFixed, 0, edtDecimalDigitsConvertVolume.Value);
  sgConvertVolume.Cells[1, 41] :=
    FloatToStrF(V * 202884.136211058, ffFixed, 0, edtDecimalDigitsConvertVolume.Value);
end;

procedure TFormMain.updateSpeed(SP: Float);
begin
  sgConvertSpeed.Cells[1, 1] :=
    FloatToStrF(SP * 100, ffFixed, 0, edtDecimalDigitsConvertSpeed.Value);
  sgConvertSpeed.Cells[1, 2] :=
    FloatToStrF(SP * 6000, ffFixed, 0, edtDecimalDigitsConvertSpeed.Value);
  sgConvertSpeed.Cells[1, 3] :=
    FloatToStrF(SP * 360000, ffFixed, 0, edtDecimalDigitsConvertSpeed.Value);
  sgConvertSpeed.Cells[1, 4] :=
    FloatToStrF(SP, ffFixed, 0, edtDecimalDigitsConvertSpeed.Value);
  sgConvertSpeed.Cells[1, 5] :=
    FloatToStrF(SP * 60, ffFixed, 0, edtDecimalDigitsConvertSpeed.Value);
  sgConvertSpeed.Cells[1, 6] :=
    FloatToStrF(SP * 3600, ffFixed, 0, edtDecimalDigitsConvertSpeed.Value);
  sgConvertSpeed.Cells[1, 7] :=
    FloatToStrF(SP / 1000, ffFixed, 0, edtDecimalDigitsConvertSpeed.Value);
  sgConvertSpeed.Cells[1, 8] :=
    FloatToStrF(SP * 60 / 1000, ffFixed, 0, edtDecimalDigitsConvertSpeed.Value);
  sgConvertSpeed.Cells[1, 9] :=
    FloatToStrF(SP * 3600 / 1000, ffFixed, 0, edtDecimalDigitsConvertSpeed.Value);

  sgConvertSpeed.Cells[1, 11] :=
    FloatToStrF(SP * 39.3700787401575, ffFixed, 0, edtDecimalDigitsConvertSpeed.Value);
  sgConvertSpeed.Cells[1, 12] :=
    FloatToStrF(SP * 2362.20472440945, ffFixed, 0, edtDecimalDigitsConvertSpeed.Value);
  sgConvertSpeed.Cells[1, 13] :=
    FloatToStrF(SP * 3.28083989501312, ffFixed, 0, edtDecimalDigitsConvertSpeed.Value);
  sgConvertSpeed.Cells[1, 14] :=
    FloatToStrF(SP * 196.850393700787, ffFixed, 0, edtDecimalDigitsConvertSpeed.Value);
  sgConvertSpeed.Cells[1, 15] :=
    FloatToStrF(SP * 11811.0236220472, ffFixed, 0, edtDecimalDigitsConvertSpeed.Value);
  sgConvertSpeed.Cells[1, 16] :=
    FloatToStrF(SP * 1.09361329833771, ffFixed, 0, edtDecimalDigitsConvertSpeed.Value);
  sgConvertSpeed.Cells[1, 17] :=
    FloatToStrF(SP * 65.6167979002625, ffFixed, 0, edtDecimalDigitsConvertSpeed.Value);
  sgConvertSpeed.Cells[1, 18] :=
    FloatToStrF(SP * 3937.00787401575, ffFixed, 0, edtDecimalDigitsConvertSpeed.Value);
  sgConvertSpeed.Cells[1, 19] :=
    FloatToStrF(SP * 0.000621371192237, ffFixed, 0, edtDecimalDigitsConvertSpeed.Value);
  sgConvertSpeed.Cells[1, 20] :=
    FloatToStrF(SP * 0.03728227153424, ffFixed, 0, edtDecimalDigitsConvertSpeed.Value);
  sgConvertSpeed.Cells[1, 21] :=
    FloatToStrF(SP * 2.2369362920544, ffFixed, 0, edtDecimalDigitsConvertSpeed.Value);

  sgConvertSpeed.Cells[1, 23] :=
    FloatToStrF(SP * 1.94260256941567, ffFixed, 0, edtDecimalDigitsConvertSpeed.Value);
  sgConvertSpeed.Cells[1, 24] :=
    FloatToStrF(SP * 1.94384449244061, ffFixed, 0, edtDecimalDigitsConvertSpeed.Value);
  sgConvertSpeed.Cells[1, 25] :=
    FloatToStrF(SP * 0.003016106101135, ffFixed, 0, edtDecimalDigitsConvertSpeed.Value);

  sgConvertSpeed.Cells[1, 27] :=
    FloatToStrF(SP / 299792458, ffFixed, 0, edtDecimalDigitsConvertSpeed.Value);
end;

procedure TFormMain.updateMass(M: Float);
begin
  sgConvertMass.Cells[1, 1]  :=
    FloatToStrF(M * 1000, ffFixed, 0, edtDecimalDigitsConvertMass.Value);
  sgConvertMass.Cells[1, 2]  :=
    FloatToStrF(M, ffFixed, 0, edtDecimalDigitsConvertMass.Value);
  sgConvertMass.Cells[1, 3]  :=
    FloatToStrF(M / 1000, ffFixed, 0, edtDecimalDigitsConvertMass.Value);
  sgConvertMass.Cells[1, 4]  :=
    FloatToStrF(M * 0.984206527611061 / 1000, ffFixed, 0,
    edtDecimalDigitsConvertMass.Value);
  sgConvertMass.Cells[1, 5]  :=
    FloatToStrF(M * 1.10231131092439 / 1000, ffFixed, 0,
    edtDecimalDigitsConvertMass.Value);
  sgConvertMass.Cells[1, 6]  :=
    FloatToStrF(M * 5000, ffFixed, 0, edtDecimalDigitsConvertMass.Value);
  sgConvertMass.Cells[1, 7]  :=
    FloatToStrF(M * 35.2739619495804, ffFixed, 0, edtDecimalDigitsConvertMass.Value);
  sgConvertMass.Cells[1, 8]  :=
    FloatToStrF(M * 32.150746568628, ffFixed, 0, edtDecimalDigitsConvertMass.Value);
  sgConvertMass.Cells[1, 9]  :=
    FloatToStrF(M * 2.20462262184878, ffFixed, 0, edtDecimalDigitsConvertMass.Value);
  sgConvertMass.Cells[1, 10] :=
    FloatToStrF(M * 2.679228880719, ffFixed, 0, edtDecimalDigitsConvertMass.Value);
  sgConvertMass.Cells[1, 11] :=
    FloatToStrF(M * 0.15747304441777, ffFixed, 0, edtDecimalDigitsConvertMass.Value);
  sgConvertMass.Cells[1, 12] :=
    FloatToStrF(M * 0.068521765843675, ffFixed, 0, edtDecimalDigitsConvertMass.Value);
  sgConvertMass.Cells[1, 13] :=
    FloatToStrF(M * 0.019684130552221, ffFixed, 0, edtDecimalDigitsConvertMass.Value);
  sgConvertMass.Cells[1, 14] :=
    FloatToStrF(M * 0.022046226218488, ffFixed, 0, edtDecimalDigitsConvertMass.Value);
  sgConvertMass.Cells[1, 15] := '';
  sgConvertMass.Cells[1, 16] :=
    FloatToStrF(M * 200, ffFixed, 0, edtDecimalDigitsConvertMass.Value);
  sgConvertMass.Cells[1, 17] :=
    FloatToStrF(M * 20, ffFixed, 0, edtDecimalDigitsConvertMass.Value);
  sgConvertMass.Cells[1, 18] :=
    FloatToStrF(M * 2, ffFixed, 0, edtDecimalDigitsConvertMass.Value);

end;

procedure TFormMain.updateTabVisible;
begin
  tsCRC.TabVisible := ini.ReadBool('Enabled', 'CRC', True);

  tsBase.TabVisible     := ini.ReadBool('Enabled', 'Dital_Base', True);
  tsBigFloat.TabVisible := ini.ReadBool('Enabled', 'Dital_BigFloat', True);
  tsBigInt.TabVisible   := ini.ReadBool('Enabled', 'Dital_BigInt', True);
  tsBytes.TabVisible    := ini.ReadBool('Enabled', 'Dital_Bytes', True);
  tsDigit.TabVisible    := ini.ReadBool('Enabled', 'Dital', True);
  updateTSPC(tsDigit, pcDigit);

  tsConvertTime.TabVisible := ini.ReadBool('Enabled', 'Convert_Time', True);
  tsConvertTemperature.TabVisible :=
    ini.ReadBool('Enabled', 'Convert_Temperature', True);
  tsConvertPower.TabVisible := ini.ReadBool('Enabled', 'Convert_Power', True);
  tsConvertDistance.TabVisible := ini.ReadBool('Enabled', 'Convert_Distance', True);
  tsConvertArea.TabVisible := ini.ReadBool('Enabled', 'Convert_Area', True);
  tsConvertVolume.TabVisible := ini.ReadBool('Enabled', 'Convert_Volume', True);
  tsConvertSpeed.TabVisible := ini.ReadBool('Enabled', 'Convert_Speed', True);
  tsConvertMass.TabVisible := ini.ReadBool('Enabled', 'Convert_Mass', True);
  tsConvert.TabVisible := ini.ReadBool('Enabled', 'Convert', True);
  updateTSPC(tsConvert, pcConvert);

  tsCalc.TabVisible := ini.ReadBool('Enabled', 'Calc', True);

  tsPascalScript.TabVisible := ini.ReadBool('Enabled', 'Script_Pascal', True);
  tsMicropython.TabVisible := ini.ReadBool('Enabled', 'Script_micropython', True);
  tsLua.TabVisible    := ini.ReadBool('Enabled', 'Script_Lua', True);
  tsC.TabVisible      := ini.ReadBool('Enabled', 'Script_C', True);
  tsGraph.TabVisible  := ini.ReadBool('Enabled', 'Script_Graph', True);
  tsScript.TabVisible := ini.ReadBool('Enabled', 'Script', True);
  updateTSPC(tsScript, pcScript);

  tsConstantMath.TabVisible := ini.ReadBool('Enabled', 'Constant_Math', True);
  tsConstantPhysics.TabVisible := ini.ReadBool('Enabled', 'Constant_Physics', True);
  tsConstantDecimalMultiple.TabVisible :=
    ini.ReadBool('Enabled', 'Constant_DecimalMultiple', True);
  tsConstantPeriodicTable.TabVisible :=
    ini.ReadBool('Enabled', 'Constant_PeriodicTable', True);
  tsConstant.TabVisible := ini.ReadBool('Enabled', 'Constant', True);
  updateTSPC(tsConstant, pcConstant);
end;

procedure TFormMain.updateTSPC(ts: TTabSheet; pc: TPageControl);
var
  i, n, p: integer;
begin
  if not ts.TabVisible then
    Exit;
  n := 0;
  for i := 0 to pc.PageCount - 1 do
  begin
    if pc.Pages[i].TabVisible then
    begin
      n := n + 1;
      p := i;
    end;
  end;
  if n > 0 then
    if pc.ActivePageIndex = -1 then
      pc.ActivePageIndex := p;
  ts.TabVisible := n > 0;
end;

function TFormMain.RunTimeToDHMStr(T: integer): string;
var
  D, H, M: integer;
begin
  D := T div (60 * 24);
  T := T mod (60 * 24);
  H := T div 60;
  M := T mod 60;
  if (D = 0) and (H = 0) then
  begin
    if M = 0 then
      Result := ''
    else
      Result := IntToStr(M) + 'm';
  end
  else
  begin
    if D = 0 then
      Result := IntToStr(H) + 'h ' + IntToStr(M) + 'm'
    else
      Result := IntToStr(D) + 'd ' + IntToStr(H) + 'h ' + IntToStr(M) + 'm';
  end;
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

procedure TFormMain.mmoOutAdd_Lua(msg: string);
begin
  mmoOutAdd(mmoOutLua, msg);
end;

procedure TFormMain.mmoOutAdd_C(msg: string);
begin
  mmoOutAdd(mmoOutC, msg);
end;

procedure TFormMain.mmoOutAdd_Calc(msg: string);
begin
  mmoOutAdd(mmoOutCalc, msg);
end;

procedure TFormMain.mmoOutAdd_Graph(msg: string);
begin
  mmoOutAdd(mmoOutGraph, msg);
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
      else if pm = pmHis_Lua then
      begin
        mi.OnClick := @pmHisClick_Lua;
      end
      else if pm = pmHis_C then
      begin
        mi.OnClick := @pmHisClick_C;
      end
      else if pm = pmHis_Graph then
      begin
        mi.OnClick := @pmHisClick_Graph;
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

procedure TFormMain.pmHisClick_Lua(Sender: TObject);
begin
  // load history file
  LoadFile_Lua(TMenuItem(Sender).Caption);
  // move to first
  pmAddHis(pmHis_Lua, TMenuItem(Sender).Caption);
end;

procedure TFormMain.pmHisClick_C(Sender: TObject);
begin
  // load history file
  LoadFile_C(TMenuItem(Sender).Caption);
  // move to first
  pmAddHis(pmHis_C, TMenuItem(Sender).Caption);
end;

procedure TFormMain.pmHisClick_Calc(Sender: TObject);
begin
  // load history file
  LoadFile_Calc(TMenuItem(Sender).Caption);
  // move to first
  pmAddHis(pmHis_Calc, TMenuItem(Sender).Caption);
end;

procedure TFormMain.pmHisClick_Graph(Sender: TObject);
begin
  // load history file
  LoadFile_Graph(TMenuItem(Sender).Caption);
  // move to first
  pmAddHis(pmHis_Graph, TMenuItem(Sender).Caption);
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

procedure TFormMain.LoadFile_Lua(FileName: string);
begin
  btnNew_LuaClick(nil);
  SynEditLua.Lines.LoadFromFile(FileName);
  dlgSave_Lua.FileName := FileName;
  SynEditLua.Hint := FileName;
  tsLua.Caption := 'Lua - ' + shortFileName(FileName);
end;

procedure TFormMain.SaveFile_Lua(FileName: string);
begin
  try
    SynEditLua.Lines.SaveToFile(FileName);
    SynEditLua.Modified := False;
    btnSave_Lua.Enabled := False;
    btnSaveAs_Lua.Enabled := False;
    tsLua.Caption := 'Lua - ' + shortFileName(FileName);
  except

  end;
end;

procedure TFormMain.LoadFile_C(FileName: string);
begin
  btnNew_CClick(nil);
  SynEditC.Lines.LoadFromFile(FileName);
  dlgSave_C.FileName := FileName;
  SynEditC.Hint := FileName;
  tsC.Caption := 'C - ' + shortFileName(FileName);
end;

procedure TFormMain.SaveFile_C(FileName: string);
begin
  try
    SynEditC.Lines.SaveToFile(FileName);
    SynEditC.Modified := False;
    btnSave_C.Enabled := False;
    btnSaveAs_C.Enabled := False;
    tsC.Caption := 'C - ' + shortFileName(FileName);
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

procedure TFormMain.LoadFile_Graph(FileName: string);
begin
  btnNew_GraphClick(nil);
  SynEditGraph.Lines.LoadFromFile(FileName);
  dlgSave_Graph.FileName := FileName;
  SynEditGraph.Hint := FileName;
  tsGraph.Caption := 'Graph - ' + shortFileName(FileName);
end;

procedure TFormMain.SaveFile_Graph(FileName: string);
begin
  try
    SynEditGraph.Lines.SaveToFile(FileName);
    SynEditGraph.Modified := False;
    btnSave_Graph.Enabled := False;
    btnSaveAs_Graph.Enabled := False;
    tsGraph.Caption := 'Graph - ' + shortFileName(FileName);
  except

  end;
end;

procedure TFormMain.errlog(msg: string);
var
  f: Textfile;
begin
  if not errlog_en then
    Exit;

  AssignFile(f, errlogfile);
  if FileExists(errlogfile) then
    Append(f)
  else
    Rewrite(f);
  writeln(f, DateTimeToSTr(now), ' ', msg);
  CloseFile(f);
end;

end.
