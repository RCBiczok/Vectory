unit Rueckblende;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, ToolWin, ImgList;

type
  TForm8 = class(TForm)
    ToolBar1: TToolBar;
    Play: TToolButton;
    Pause: TToolButton;
    Stop: TToolButton;
    AllBack: TToolButton;
    StepBack: TToolButton;
    StepForward: TToolButton;
    AllForward: TToolButton;
    Timer1: TTimer;
    ImageList1: TImageList;
    procedure StepForwardClick(Sender: TObject);
    procedure StepBackClick(Sender: TObject);
    procedure AllForwardClick(Sender: TObject);
    procedure AllBackClick(Sender: TObject);
    procedure PlayClick(Sender: TObject);
    procedure PauseClick(Sender: TObject);
    procedure StopClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form8: TForm8;

implementation

{$R *.dfm}

uses Main, ActionList;

procedure TForm8.StepForwardClick(Sender: TObject);
begin
  ActionList1.RedoLastAction;
end;

procedure TForm8.StepBackClick(Sender: TObject);
begin
  ActionList1.UndoLastAction;
end;

procedure TForm8.AllForwardClick(Sender: TObject);
begin
  ActionList1.RedoAllActions;
end;

procedure TForm8.AllBackClick(Sender: TObject);
begin
  ActionList1.UndoAllActions;
end;

procedure TForm8.PlayClick(Sender: TObject);
begin
  ActionList1.RedoLastAction;
  If ActionList1.ActualIndex=ActionList1.Count then
    MessageDlg('Die Animation ist fertig', mtInformation, [mbOK], 0)
  else
    Timer1.Enabled:=True;
end;

procedure TForm8.PauseClick(Sender: TObject);
begin
  Timer1.Enabled:=False;
end;

procedure TForm8.StopClick(Sender: TObject);
begin
  Timer1.Enabled:=False;
  ActionList1.UndoAllActions;
end;

procedure TForm8.Timer1Timer(Sender: TObject);
begin
  ActionList1.RedoLastAction;
  If ActionList1.ActualIndex=ActionList1.Count then begin
    Timer1.Enabled:=False;
    MessageDlg('Die Animation ist fertig', mtInformation, [mbOK], 0);
  end;
end;

end.
