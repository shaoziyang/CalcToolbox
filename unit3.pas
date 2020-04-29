unit Unit3;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, LCLType,
  Unit1;

type

  { TFormGraph }

  TFormGraph = class(TForm)
    image: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure imageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure imageMouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
  private
    fx, fy: integer;
  public

  end;

var
  FormGraph: TFormGraph;

implementation

{$R *.lfm}

{ TFormGraph }

procedure TFormGraph.FormCreate(Sender: TObject);
begin
  Left := 100;
  Top  := 100;
  ClientWidth := 500;
  ClientHeight := 500;
  image.Picture.Bitmap.Width := ClientWidth;
  image.Picture.Bitmap.Height := ClientHeight;
end;

procedure TFormGraph.FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  case key of
    VK_F9: FormMain.btnRun_GraphClick(Sender);
    VK_S:
      if Shift = [ssCtrl] then
        FormMain.btnSavePic_GraphClick(Sender);
  end;
end;

procedure TFormGraph.imageMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  fx := X;
  fy := Y;
end;

procedure TFormGraph.imageMouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
begin
  if Shift = [ssLeft] then
  begin
    Left := Left + X - fx;
    Top  := Top + Y - fy;
  end;
end;

end.




