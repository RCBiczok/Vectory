unit ParameterTool;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, MathParser, Verlauf, ExtCtrls;

type
  TParamTool = class(TForm)
    TrackBar: TTrackBar;
    VarName: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    MinLabel: TLabel;
    MaxLabel: TLabel;
    ZeroLabel: TLabel;
    Edit4: TEdit;
    PaintBox1: TPaintBox;
    procedure TrackBarChange(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure Edit2Exit(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
  private
    procedure AdjustValues;
    { Private declarations }
  public
    Variable: TVariable;
    { Public declarations }
  end;

var
  ParamTool: TParamTool;
  Step: single = 1;

implementation

{$R *.dfm}

uses
  Main;

procedure TParamTool.AdjustValues;
var
  min, max: integer;
begin
  min:= 0; max:= 0;
  if(Edit1.Text <> '') then begin
    min:= Round(StrToInt(Edit1.Text)/Step);
    TrackBar.Min:= min;
    MinLabel.Caption:= Edit1.Text;
    TrackBar.Frequency:= 1;
  end;
  if(Edit2.Text <> '') then begin
    max:= Round(StrToInt(Edit2.Text)/Step);
    TrackBar.Max:= max;
    MaxLabel.Caption:= Edit2.Text;
    TrackBar.Frequency:= 1;
  end;
  ZeroLabel.Caption:= IntToStr(Round((min + max) / 2));
end;

procedure TParamTool.TrackBarChange(Sender: TObject);
begin
  If Edit3.Text<>'' then Step:=StrToFloat(Edit3.Text) else Step:=1;
  Edit4.Text:= FloatToStr(TrackBar.Position*Step);
  If Variable.Value<>TrackBar.Position*Step then begin
    Variable.Value:=TrackBar.Position*Step;
    SaveVar(Variable.Name, Variable.Value, VarsArchive);
    Form1.NotifyVarChange(Variable);
  end;
end;

procedure TParamTool.Edit1Exit(Sender: TObject);
begin
 try
  If not (Edit1.Text = '-') then begin
    AdjustValues;
//    TrackBar.Min:=Round(StrToInt(Edit1.Text)/Step);
//    MinLabel.Caption:=Edit1.Text;
  end;
 except
 end;
end;

procedure TParamTool.Edit2Exit(Sender: TObject);
begin
  try
   If not (Edit2.Text = '-') then begin
    AdjustValues;
//    TrackBar.Max:=Round(StrToInt(Edit2.Text)/Step);
//    MaxLabel.Caption:=Edit2.Text;
   end;
  except
  end;
end;

procedure TParamTool.Edit3Change(Sender: TObject);
begin
  try
    Step:=StrToFloat(Edit3.Text);
    AdjustValues;
//    TrackBar.Min:=Round(StrToInt(MinLabel.Caption)/Step);
//    TrackBar.Max:=Round(StrToInt(MaxLabel.Caption)/Step);
//    TrackBar.Frequency:= round(Step * (TrackBar.Max - TrackBar.Min) / 10);
  except
  end;
end;

procedure TParamTool.FormActivate(Sender: TObject);
begin
  TrackBar.Position:=Round(Variable.Value/Step);
  Edit3.Text:= FloatToStr(Step);
  Edit1.Text:= IntToStr(Round(TrackBar.Min*Step));
  Edit2.Text:= IntToStr(Round(TrackBar.Max*Step));
end;

procedure TParamTool.Edit4Change(Sender: TObject);
begin
  If (Edit4.Text <> '') and (Edit4.Text <> '-') then begin
    Variable.Value:=StrToFloat(Edit4.Text);
    SaveVar(Variable.Name, Variable.Value, VarsArchive);
    Form1.NotifyVarChange(Variable);
  end;
end;

procedure TParamTool.PaintBox1Paint(Sender: TObject);
begin
  VerlaufHorizontal(PaintBox1.Canvas, clMoneyGreen, clGreen, PaintBox1.Width, PaintBox1.Height);
end;

end.
