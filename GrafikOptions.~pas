unit GrafikOptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Verlauf, ComCtrls, Einstellung;

type
  TForm7 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Panel1: TPanel;
    AntiAliasing: TCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    PaintBox1: TPaintBox;
    Panel2: TPanel;
    PaintBox2: TPaintBox;
    Panel3: TPanel;
    PaintBox3: TPaintBox;
    GrPlaneColor: TColorBox;
    GridColor: TColorBox;
    TicksColor: TColorBox;
    GrPlaneAlpha: TEdit;
    GridAlpha: TEdit;
    TicksAlpha: TEdit;
    UpDown1: TUpDown;
    UpDown2: TUpDown;
    UpDown3: TUpDown;
    Background: TColorBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    PaintBox4: TPaintBox;
    PaintBox5: TPaintBox;
    PaintBox6: TPaintBox;
    SensityBar: TTrackBar;
    Label13: TLabel;
    Button3: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
    procedure PaintBox3Paint(Sender: TObject);
    procedure PaintBox2Paint(Sender: TObject);
    procedure PaintBox6Paint(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure GrPlaneAlphaChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form7: TForm7;

implementation

{$R *.dfm}

uses Main, GLContext;

procedure TForm7.Button2Click(Sender: TObject);
begin
  Hide;
end;

procedure TForm7.Button1Click(Sender: TObject);
begin

//Display
  Settings.FDisplay.AntiAliasing:= AntiAliasing.Checked;

// Colors
  Settings.FColors.Background:= Background.Selected;
  Settings.FColors.GroundPlane:= GrPlaneColor.Selected;
  Settings.FColors.GroundPlaneAlpha:= StrToInt(GrPlaneAlpha.Text)/100;
  Settings.FColors.Grid:= GridColor.Selected;
  Settings.FColors.GridAlpha:= StrToInt(GridAlpha.Text)/100;
  Settings.FColors.Ticks:= TicksColor.Selected;
  Settings.FColors.TicksAlpha:= StrToInt(TicksAlpha.Text)/100;

// Environment
  Settings.FEnvironment.MouseSensity:= SensityBar.Position;

  Settings.NotifyChanges;

  Hide;
end;

procedure TForm7.FormActivate(Sender: TObject);
begin

//Display
  AntiAliasing.Checked:= Settings.FDisplay.AntiAliasing;

// Colors
  Background.Selected:= Settings.FColors.Background;
  GrPlaneColor.Selected:= Settings.FColors.GroundPlane;
  GrPlaneAlpha.Text:= IntToStr(Round(Settings.FColors.GroundPlaneAlpha*100));
  GridColor.Selected:= Settings.FColors.Grid;
  GridAlpha.Text:= IntToStr(Round(Settings.FColors.GridAlpha*100));
  TicksColor.Selected:= Settings.FColors.Ticks;
  TicksAlpha.Text:= IntToStr(Round(Settings.FColors.TicksAlpha*100));

// Environment
  SensityBar.Position:= Settings.FEnvironment.MouseSensity;

end;

procedure TForm7.FormPaint(Sender: TObject);
begin
  VerlaufVertical(Canvas, clMoneyGreen, clGreen, Width, Height);
end;

procedure TForm7.PaintBox1Paint(Sender: TObject);
begin
  VerlaufHorizontal(PaintBox1.Canvas, $007CB16D, $00C6DDBF, PaintBox1.Width, PaintBox1.Height);
end;

procedure TForm7.PaintBox3Paint(Sender: TObject);
begin
  VerlaufHorizontal(PaintBox3.Canvas, $00C6DDBF, $007CB16D, PaintBox3.Width, PaintBox3.Height);
end;

procedure TForm7.PaintBox2Paint(Sender: TObject);
begin
  VerlaufHorizontal(PaintBox2.Canvas,  $00C6DDBF, $007CB16D, PaintBox2.Width, PaintBox2.Height);
end;

procedure TForm7.PaintBox6Paint(Sender: TObject);
begin
  VerlaufHorizontal(TPaintBox(Sender).Canvas, clGreen, clMoneyGreen, TPaintBox(Sender).Width, TPaintBox(Sender).Height);
end;

procedure TForm7.Label1Click(Sender: TObject);
begin
  AntiAliasing.Checked:= not AntiAliasing.Checked;
end;

procedure TForm7.FormCreate(Sender: TObject);
var
  i: integer;
begin
  for i:=1 to High(GermanColors) do
    BackGround.Items[i]:=GermanColors[i];
  BackGround.Items[0]:='benutzerdefiniert...';

  for i:=1 to High(GermanColors) do
    GrPlaneColor.Items[i]:=GermanColors[i];
  GrPlaneColor.Items[0]:='benutzerdefiniert...';

  for i:=1 to High(GermanColors) do
    GridColor.Items[i]:=GermanColors[i];
  GridColor.Items[0]:='benutzerdefiniert...';

  for i:=1 to High(GermanColors) do
    TicksColor.Items[i]:=GermanColors[i];
  TicksColor.Items[0]:='benutzerdefiniert...';
end;

procedure TForm7.Button3Click(Sender: TObject);
begin
  Settings.SetColorStandard;
  Settings.FEnvironment.MouseSensity:= ST_M_SENSITY;

  FormActivate(Self);
end;

procedure TForm7.GrPlaneAlphaChange(Sender: TObject);
begin
  Try
    If not ((TEdit(Sender).Text = '') or (TEdit(Sender).Text = '-')) then begin
      If (StrToInt(TEdit(Sender).Text) > 100) then
        TEdit(Sender).Text:= '100';

      If (StrToInt(TEdit(Sender).Text) < 0) then
        TEdit(Sender).Text:= '0';
    end;    
  except
    ShowMessage('Bitte eine Zahl zwischen 0 und 100 eingeben');
  end;
end;

end.
