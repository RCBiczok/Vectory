unit ActionTest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Main;

type
  TActTest = class(TForm)
    Memo1: TMemo;
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ActTest: TActTest;

implementation

{$R *.dfm}

procedure TActTest.Timer1Timer(Sender: TObject);
begin
  If Memo1.Text <> ActionList1.Text then begin
    Memo1.Text:=ActionList1.Text;
    Memo1.Lines[ActionList1.ActualIndex-1]:=Memo1.Lines[ActionList1.ActualIndex-1]+'   <===';
  end;
end;

end.
