unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,
  LCLType, LCLIntf, ComCtrls, StdCtrls, EditBtn;

type

  { TFormOption }

  TFormOption = class(TForm)
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    btnOptionOK: TBitBtn;
    btnOptionCancel: TBitBtn;
    btnOptionSelectFont: TBitBtn;
    chkErrlog_En: TCheckBox;
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
    lbMPYWebSite: TLabel;
    lbTinyCWeb: TLabel;
    lbOptFont: TStaticText;
    lbLuaWebSite: TLabel;
    lbTinyCWebSite1: TLabel;
    lbTinyCWebSite2: TLabel;
    pcOption: TPageControl;
    pnlButton: TPanel;
    Panel2: TPanel;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    tvFunctions: TTreeView;
    tsOptionGeneral: TTabSheet;
    procedure btnOptionOKClick(Sender: TObject);
    procedure btnOptionSelectFontClick(Sender: TObject);
    procedure chkShowTrayChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lbLuaWebSiteClick(Sender: TObject);
    procedure lbMPYWebSiteClick(Sender: TObject);
    procedure lbTinyCWebSite1Click(Sender: TObject);
    procedure lbTinyCWebSite2Click(Sender: TObject);
    procedure tvFunctionsClick(Sender: TObject);
    procedure tvFunctionsKeyDown(Sender: TObject; var Key: word;
      Shift: TShiftState);
  private

    procedure tvSetCheck(node: TTreeNode; check: boolean = True);

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
var
  i: integer;
  s: string;
begin
  for i := 0 to tvFunctions.Items.Count - 1 do
  begin
    if tvFunctions.Items[i].Parent = nil then
      s := ''
    else
      s := tvFunctions.Items[i].Parent.Text + '_';
    ini.WriteBool('Enabled', s + tvFunctions.Items[i].Text,
      tvFunctions.Items[i].StateIndex = 1);
  end;
  FormMain.updateTabVisible;

end;

procedure TFormOption.chkShowTrayChange(Sender: TObject);
begin
  chkMinimizeToTray.Enabled := chkShowTray.Checked;
  chkCloseToTray.Enabled    := chkShowTray.Checked;
end;

procedure TFormOption.FormCreate(Sender: TObject);
begin
  pcOption.ActivePageIndex := 0;
end;

procedure TFormOption.FormShow(Sender: TObject);
var
  s: string;
  i: integer;
begin
  Font := FormMain.Font;
  showFont;
  dlgFont.Tag := 1;

  chkShowTray.Checked    := FormMain.TrayIcon.Visible;
  chkMinimizeToTray.Enabled := chkShowTray.Checked;
  chkCloseToTray.Enabled := chkShowTray.Checked;
  chkMinimizeToTray.Checked := FormMain.MinimizeToTray;
  chkCloseToTray.Checked := FormMain.CloseToTray;
  chkErrlog_En.Checked   := FormMain.errlog_en;

  for i := 0 to tvFunctions.Items.Count - 1 do
  begin
    tvFunctions.Items[i].SelectedIndex:=tvFunctions.Items[i].ImageIndex;
    if tvFunctions.Items[i].Parent = nil then
      s := ''
    else
      s := tvFunctions.Items[i].Parent.Text + '_';
    tvSetCheck(tvFunctions.Items[i], ini.ReadBool('Enabled', s +
      tvFunctions.Items[i].Text, True));
  end;

  chkUse_external_micropython.Checked := FormMain.use_external_micropython;
  edtExternal_micropython_bin.Text := FormMain.external_micropython_bin_name;
  chkUse_external_lua.Checked := FormMain.use_external_lua;
  edtExternal_lua_bin.Text    := FormMain.external_lua_bin_name;
  edtExternal_c_bin.Text      := FormMain.external_c_bin_name;

end;

procedure TFormOption.lbLuaWebSiteClick(Sender: TObject);
begin
  OpenURL('https://www.lua.org');
end;

procedure TFormOption.lbMPYWebSiteClick(Sender: TObject);
begin
  OpenURL('https://github.com/micropython/micropython');
end;

procedure TFormOption.lbTinyCWebSite1Click(Sender: TObject);
begin
  OpenURL('https://bellard.org/tcc/');
end;

procedure TFormOption.lbTinyCWebSite2Click(Sender: TObject);
begin
  OpenURL('https://github.com/TinyCC/tinycc');
end;

procedure TFormOption.tvFunctionsClick(Sender: TObject);
begin
  tvSetCheck(tvFunctions.Selected, tvFunctions.Selected.StateIndex = 0);
end;

procedure TFormOption.tvFunctionsKeyDown(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if Key = VK_SPACE then
    tvSetCheck(tvFunctions.Selected, tvFunctions.Selected.StateIndex = 0);
end;

procedure TFormOption.tvSetCheck(node: TTreeNode; check: boolean);
begin
  if check then
    node.StateIndex := 1
  else
    node.StateIndex := 0;
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
