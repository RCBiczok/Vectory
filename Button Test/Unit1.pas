unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, MultiButton, ImgList, ComCtrls, ToolWin, Buttons,
  Menus, StdCtrls;

type
  TForm1 = class(TForm)
    ImageList1: TImageList;
    MultiButton1: TMultiButton;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    Label1: TLabel;
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.ToolButton2Click(Sender: TObject);
begin
  ShowMessage('Ich bin ein Punkt');
end;

procedure TForm1.ToolButton3Click(Sender: TObject);
begin
  ShowMessage('Ich bin eine Strecke');
end;

procedure TForm1.ToolButton4Click(Sender: TObject);
begin
  ShowMessage('Ich bin eine Gerade');
end;

procedure TForm1.ToolButton5Click(Sender: TObject);
begin
  ShowMessage('Ich bin eine Ebene');
end;

end.
