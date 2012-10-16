unit OrtsLinienTool;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, AppEvnts, Verlauf, MathParser,
  GLTreeView, OrtsLinie, Primitives, GLScene, GLColor;

type
  TOrtsLinieTool = class(TForm)
    VarChoice: TTreeView;
    PaintBox1: TPaintBox;
    PaintBox2: TPaintBox;
    ApplicationEvents1: TApplicationEvents;
    OK: TButton;
    Cancel: TButton;
    Label19: TLabel;
    ObjectName: TEdit;
    Farbe: TLabel;
    ColorBox1: TColorBox;
    Label1: TLabel;
    MinEdit: TEdit;
    MaxEdit: TEdit;
    AccuracyEdit: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure PaintBox1Paint(Sender: TObject);
    procedure PaintBox2Paint(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure OKClick(Sender: TObject);
    procedure CancelClick(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  OrtsLinieTool: TOrtsLinieTool;
  Punkt: TPunkt;

implementation

{$R *.dfm}

uses
  Main;

procedure TOrtsLinieTool.PaintBox1Paint(Sender: TObject);
begin
  VerlaufDiagonalUp(TPaintBox(Sender).Canvas, clGreen, clMoneyGreen, TPaintBox(Sender).Width, TPaintBox(Sender).Height);
end;

procedure TOrtsLinieTool.PaintBox2Paint(Sender: TObject);
begin
  VerlaufDiagonalDown(TPaintBox(Sender).Canvas, clGreen, clMoneyGreen, TPaintBox(Sender).Width, TPaintBox(Sender).Height);
end;

procedure TOrtsLinieTool.FormActivate(Sender: TObject);
var
  i, Number: integer;
  Name, FullName: string;
begin
  Punkt:= TPunkt(TGLNode(Form1.TreeView1.Selected).LinkedObject);

  VarChoice.Items.Clear;

  // give name
  Name:='OL';
  Number:=1; FullName:=Name+IntToStr(Number);
  while NameUsed(FullName) do begin
    Number:=Number+1;
    FullName:=Name+IntToStr(Number);
  end;
  ObjectName.Text:= FullName;
  
  ColorBox1.Selected:=Random($F)*$100000+Random($F)*$1000+random($F)*$10;

  for i:=0 to Length(VarsArchive)-1 do
    If VarInObj(Punkt, VarsArchive[i].Name) then
      VarChoice.Items.Add(VarChoice.Items.GetFirstNode, VarsArchive[i].Name);

  If VarChoice.Items.Count = 0 then
    ShowMessage('Sie müssen einen Punkt wählen der von mindestens einem Parameter abhängig ist')
  else
    VarChoice.Selected:= VarChoice.Items[0];
end;

procedure TOrtsLinieTool.OKClick(Sender: TObject);
var
  min, max: single;
  accuracy: integer;
  Color: TColor;
  colorVector: TColorVector;
begin
 try
  try
    If StrToInt(AccuracyEdit.Text) < 1 then begin
      ShowMessage('Die Genauigkeit muss mindestens 1 betragen');
      Exit;
    end;
  except
    ShowMessage('Die Genauigkeit muss eine ganze Zahl sein');
    Exit;
  end;

  min:= StrToFloat(MinEdit.Text);
  max:= StrToFloat(MaxEdit.Text);
  accuracy:= StrToint(AccuracyEdit.Text);
  Color:= ColorBox1.Selected;
  colorVector:= ConvertWinColor(Color);

  ErstelleOrtsLinie(ObjectName.Text , colorVector, Punkt, FindVariable(VarChoice.Selected.Text, VarsArchive), max, min, accuracy, False);

  Close;
 except
   ShowMessage('Ein Fehler ist aufgetreten. Überprüfen Sie bitte ihre Angaben');
 end;
end;

procedure TOrtsLinieTool.CancelClick(Sender: TObject);
begin
  Close;
end;

procedure TOrtsLinieTool.FormPaint(Sender: TObject);
begin
  If VarChoice.Items.Count = 0 then begin
    Close;
  end;
end;

end.
