
unit KoordinatensystemEinstellungen;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Verlauf;

type
  TForm10 = class(TForm)
    procedure FormPaint(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form10: TForm10;

implementation

{$R *.dfm}

procedure TForm10.FormPaint(Sender: TObject);
begin
  VerlaufVertical(Canvas, clRed, clBlue, Width, Height);
end;

end.
