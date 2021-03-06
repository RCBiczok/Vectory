unit ParserTest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Types, ComCtrls, MathParser;

type
  TParserTestForm = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Label1: TLabel;
    Edit2: TEdit;
    Button2: TButton;
    TrackBar1: TTrackBar;
    Label2: TLabel;
    Button3: TButton;
    Memo1: TMemo;
    Button4: TButton;
    Button5: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ParserTestForm: TParserTestForm;
  Archive: TVarsArray;

implementation


{$R *.dfm}

procedure TParserTestForm.Button1Click(Sender: TObject);
var
  S: string;
begin
  Label1.Caption:='';
  try
    s:=Edit1.Text;
//    Edit1.Text:=MakeNiceNumber(StrToFloat(S));
    Edit1.Text:= MakeNiceNumber(ProcessLine(S, Archive));
  except
    MessageDlg('Überprüfen Sie Ihre Angaben', mtError, [mbOK], 0);
  end;
end;

procedure TParserTestForm.Button2Click(Sender: TObject);
begin
  SaveVar(Edit2.Text, TrackBar1.Position/5, Archive);
end;

procedure TParserTestForm.TrackBar1Change(Sender: TObject);
begin
  label2.Caption:=FloatToStr(TrackBar1.Position/5);
end;

procedure TParserTestForm.Button3Click(Sender: TObject);
begin
  Edit1.Text:= DetermineValue(Edit1.Text);
end;

procedure TParserTestForm.Button4Click(Sender: TObject);
var
  Triads: TTriadArray;
  i, j: integer;
  ResultPoly: TPolynom;
  ResStr: string;
begin
//  Edit1.Text:=ProcessTriadLine(Edit1.Text);
  Memo1.Lines.Clear;
  Triads:=ExtractTriads(Edit1.Text);
  for i:=0 to Length(Triads)-1 do begin
    ResStr:='';
    Memo1.Lines.Add('{'+IntToStr(i+1)+'}: '+Triads[i].Op1Type+' '+Triads[i].Action+' '+Triads[i].Op2Type+' => '+
                       Triads[i].Operand1+Triads[i].Action+Triads[i].Operand2);
  Memo1.Lines.Add(PresentResult(Triads, i));
  end;
  Memo1.Lines.Add('');
  Memo1.Lines.Add(ProcessTriadLine(Edit1.Text));
end;

procedure TParserTestForm.Button5Click(Sender: TObject);
var
  Temp: string;
begin
  Temp:=Edit1.Text;
  CleanParentheses(Temp);
  Edit1.Text:=Temp;
end;

end.
