unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,
  ComCtrls, StdCtrls;

type

  { TFormOption }

  TFormOption = class(TForm)
    btnOptionCancel: TBitBtn;
    btnOptionOK: TBitBtn;
    btnOptionSelectFont: TBitBtn;
    cgOptFunction: TCheckGroup;
    chkShowTray: TCheckBox;
    chkMinimizeToTray: TCheckBox;
    chkCloseToTray: TCheckBox;
    ComboBox1: TComboBox;
    dlgFont: TFontDialog;
    Image1: TImage;
    Label3: TLabel;
    lbOptFont: TStaticText;
    PageControl1: TPageControl;
    Panel1: TPanel;
    tsOptionGeneral: TTabSheet;
    tsOptionFunction: TTabSheet;
    procedure btnOptionSelectFontClick(Sender: TObject);
    procedure cgOptFunctionItemClick(Sender: TObject; Index: integer);
    procedure chkShowTrayChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

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

procedure TFormOption.cgOptFunctionItemClick(Sender: TObject; Index: integer);
begin
  if Sender = nil then
  begin
    FormMain.tsCRC.TabVisible      := cgOptFunction.Checked[0];
    FormMain.tsBytes.TabVisible    := cgOptFunction.Checked[1];
    FormMain.tsBase.TabVisible     := cgOptFunction.Checked[2];
    FormMain.tsBigFloat.TabVisible := cgOptFunction.Checked[3];
    FormMain.tsBigInt.TabVisible   := cgOptFunction.Checked[4];
    FormMain.tsBuffer.TabVisible   := cgOptFunction.Checked[5];
    FormMain.tsPCalc.TabVisible    := cgOptFunction.Checked[6];
    FormMain.tsDigit.TabVisible    :=
      cgOptFunction.Checked[1] or cgOptFunction.Checked[2] or
      cgOptFunction.Checked[3] or cgOptFunction.Checked[4];
    if cgOptFunction.Checked[1] then
      FormMain.pcDigit.ActivePageIndex := 0
    else if cgOptFunction.Checked[2] then
      FormMain.pcDigit.ActivePageIndex := 1
    else if cgOptFunction.Checked[3] then
      FormMain.pcDigit.ActivePageIndex := 2
    else
      FormMain.pcDigit.ActivePageIndex := 3;

    if writeable then
    begin
      ini.WriteBool('Option', 'CRC_Enabled', cgOptFunction.Checked[0]);
      ini.WriteBool('Option', 'Bytes_Enabled', cgOptFunction.Checked[1]);
      ini.WriteBool('Option', 'Base_Enabled', cgOptFunction.Checked[2]);
      ini.WriteBool('Option', 'BigFloat_Enabled', cgOptFunction.Checked[3]);
      ini.WriteBool('Option', 'BigInt_Enabled', cgOptFunction.Checked[4]);
      ini.WriteBool('Option', 'Buffer_Enabled', cgOptFunction.Checked[5]);
      ini.WriteBool('Option', 'pCalc_Enabled', cgOptFunction.Checked[6]);
      ini.UpdateFile;
    end;
  end;
end;

procedure TFormOption.chkShowTrayChange(Sender: TObject);
begin
  chkMinimizeToTray.Enabled := chkShowTray.Checked;
  chkCloseToTray.Enabled := chkShowTray.Checked;
end;

procedure TFormOption.FormShow(Sender: TObject);
begin
  Font := FormMain.Font;
  showFont;
  dlgFont.Tag := 1;

  chkShowTray.Checked    := FormMain.TrayIcon.Visible;
  chkMinimizeToTray.Enabled := chkShowTray.Checked;
  chkCloseToTray.Enabled := chkShowTray.Checked;
  chkMinimizeToTray.Checked := FormMain.MinimizeToTray;
  chkCloseToTray.Checked := FormMain.CloseToTray;

  cgOptFunction.Checked[0] := FormMain.tsCRC.TabVisible;
  cgOptFunction.Checked[1] := FormMain.tsBytes.TabVisible;
  cgOptFunction.Checked[2] := FormMain.tsBase.TabVisible;
  cgOptFunction.Checked[3] := FormMain.tsBigFloat.TabVisible;
  cgOptFunction.Checked[4] := FormMain.tsBigInt.TabVisible;
  cgOptFunction.Checked[5] := FormMain.tsBuffer.TabVisible;
  cgOptFunction.Checked[6] := FormMain.tsPCalc.TabVisible;

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
