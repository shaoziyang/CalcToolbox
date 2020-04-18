unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,
  LCLType, ComCtrls, StdCtrls, EditBtn;

type

  { TFormOption }

  TFormOption = class(TForm)
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    btnOptionCancel: TBitBtn;
    btnOptionOK: TBitBtn;
    btnOptionSelectFont: TBitBtn;
    chkUse_external_micropython: TCheckBox;
    chkUse_external_lua: TCheckBox;
    chkShowTray: TCheckBox;
    chkMinimizeToTray: TCheckBox;
    chkCloseToTray: TCheckBox;
    ComboBox1: TComboBox;
    dlgFont: TFontDialog;
    edtExternal_micropython_bin: TFileNameEdit;
    edtExternal_lua_bin: TFileNameEdit;
    edtExternal_c_bin: TFileNameEdit;
    Image1: TImage;
    ilCheckBox: TImageList;
    Label3: TLabel;
    Label4: TLabel;
    lbOptFont: TStaticText;
    PageControl1: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    tvFunctions: TTreeView;
    tsOptionGeneral: TTabSheet;
    procedure btnOptionOKClick(Sender: TObject);
    procedure btnOptionSelectFontClick(Sender: TObject);
    procedure chkShowTrayChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tvFunctionsClick(Sender: TObject);
    procedure tvFunctionsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private

    procedure tvSetCheck(node: TTreeNode; check:Boolean=True);

  public
    procedure showFont;
  end;

var
  FormOption: TFormOption;

implementation

uses
  unit1;

{$R *.lfm}

{ TFormOption }

procedure TFormOption.btnOptionSelectFontClick(Sender: TObject);
begin
  dlgFont.Font := Font;

  if dlgFont.Execute then
  begin
    Font := dlgFont.Font;
    dlgFont.Tag := 2;
    showFont;
  end;

end;

procedure TFormOption.btnOptionOKClick(Sender: TObject);
begin
  ini.WriteBool('Option', 'CRC_Enabled', tvFunctions.Items[0].StateIndex=1);
  ini.WriteBool('Option', 'Dital_Enabled', tvFunctions.Items[1].StateIndex=1);
  ini.WriteBool('Option', 'Bytes_Enabled', tvFunctions.Items[2].StateIndex=1);
  ini.WriteBool('Option', 'Base_Enabled', tvFunctions.Items[3].StateIndex=1);
  ini.WriteBool('Option', 'BigFloat_Enabled', tvFunctions.Items[4].StateIndex=1);
  ini.WriteBool('Option', 'BigInt_Enabled', tvFunctions.Items[5].StateIndex=1);
  ini.WriteBool('Option', 'Convert_Enabled', tvFunctions.Items[6].StateIndex=1);
  ini.WriteBool('Option', 'Time_Enabled', tvFunctions.Items[7].StateIndex=1);
  ini.WriteBool('Option', 'Calc_Enabled', tvFunctions.Items[8].StateIndex=1);
  ini.WriteBool('Option', 'Script_Enabled', tvFunctions.Items[9].StateIndex=1);
  ini.WriteBool('Option', 'Pascal_Enabled', tvFunctions.Items[10].StateIndex=1);
  ini.WriteBool('Option', 'micropython_Enabled', tvFunctions.Items[11].StateIndex=1);
  ini.WriteBool('Option', 'Lua_Enabled', tvFunctions.Items[12].StateIndex=1);
  ini.WriteBool('Option', 'C_Enabled', tvFunctions.Items[13].StateIndex=1);
  ini.WriteBool('Option', 'Constant_Enabled', tvFunctions.Items[14].StateIndex=1);
  ini.WriteBool('Option', 'ConstantMath_Enabled', tvFunctions.Items[15].StateIndex=1);
  ini.WriteBool('Option', 'ConstantPhysics_Enabled', tvFunctions.Items[16].StateIndex=1);

  FormMain.updateTabVisible;

end;

procedure TFormOption.chkShowTrayChange(Sender: TObject);
begin
  chkMinimizeToTray.Enabled := chkShowTray.Checked;
  chkCloseToTray.Enabled    := chkShowTray.Checked;
end;

procedure TFormOption.FormShow(Sender: TObject);
var
  node:TTreeNode;
  i:integer;
begin
  Font := FormMain.Font;
  showFont;
  dlgFont.Tag := 1;

  chkShowTray.Checked    := FormMain.TrayIcon.Visible;
  chkMinimizeToTray.Enabled := chkShowTray.Checked;
  chkCloseToTray.Enabled := chkShowTray.Checked;
  chkMinimizeToTray.Checked := FormMain.MinimizeToTray;
  chkCloseToTray.Checked := FormMain.CloseToTray;

  tvSetCheck(tvFunctions.Items[0], ini.ReadBool('Option', 'CRC_Enabled', True));
  tvSetCheck(tvFunctions.Items[1], ini.ReadBool('Option', 'Dital_Enabled', True));
  tvSetCheck(tvFunctions.Items[2], ini.ReadBool('Option', 'Bytes_Enabled', True));
  tvSetCheck(tvFunctions.Items[3], ini.ReadBool('Option', 'Base_Enabled', True));
  tvSetCheck(tvFunctions.Items[4], ini.ReadBool('Option', 'BigFloat_Enabled', True));
  tvSetCheck(tvFunctions.Items[5], ini.ReadBool('Option', 'BigInt_Enabled', True));
  tvSetCheck(tvFunctions.Items[6], ini.ReadBool('Option', 'Convert_Enabled', True));
  tvSetCheck(tvFunctions.Items[7], ini.ReadBool('Option', 'Time_Enabled', True));
  tvSetCheck(tvFunctions.Items[8], ini.ReadBool('Option', 'Calc_Enabled', True));
  tvSetCheck(tvFunctions.Items[9], ini.ReadBool('Option', 'Script_Enabled', True));
  tvSetCheck(tvFunctions.Items[10], ini.ReadBool('Option', 'Pascal_Enabled', True));
  tvSetCheck(tvFunctions.Items[11], ini.ReadBool('Option', 'micropython_Enabled', True));
  tvSetCheck(tvFunctions.Items[12], ini.ReadBool('Option', 'Lua_Enabled', True));
  tvSetCheck(tvFunctions.Items[13], ini.ReadBool('Option', 'C_Enabled', True));
  tvSetCheck(tvFunctions.Items[14], ini.ReadBool('Option', 'Constant_Enabled', True));
  tvSetCheck(tvFunctions.Items[15], ini.ReadBool('Option', 'ConstantMath_Enabled', True));
  tvSetCheck(tvFunctions.Items[16], ini.ReadBool('Option', 'ConstantPhysics_Enabled', True));

  chkUse_external_micropython.Checked:=FormMain.use_external_micropython;
  edtExternal_micropython_bin.Text:=FormMain.external_micropython_bin_name;
  chkUse_external_lua.Checked:=FormMain.use_external_lua;
  edtExternal_lua_bin.Text:=FormMain.external_lua_bin_name;
  edtExternal_c_bin.Text:=FormMain.external_c_bin_name;

end;

procedure TFormOption.tvFunctionsClick(Sender: TObject);
begin
  tvSetCheck(tvFunctions.Selected, tvFunctions.Selected.StateIndex=0);
end;

procedure TFormOption.tvFunctionsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_SPACE then
     tvSetCheck(tvFunctions.Selected, tvFunctions.Selected.StateIndex=0);
end;

procedure TFormOption.tvSetCheck(node: TTreeNode; check: Boolean);
begin
  if check then
    node.StateIndex:=1
  else
    node.StateIndex:=0;
end;

procedure TFormOption.showFont;
begin
  lbOptFont.Font    := Font;
  lbOptFont.Caption := lbOptFont.Font.Name + ', ' + IntToStr(lbOptFont.Font.Size);
  if lbOptFont.Font.Style = [fsBold] then
  begin
    lbOptFont.Caption := lbOptFont.Caption + ', Bold';
  end;
end;

{ TFormOption }

end.
