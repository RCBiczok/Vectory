unit Einstellung;

interface

uses
  Graphics, GLContext, GLScene, SysUtils, VectorGeometry, GLSpaceText;

type

  TDisplay = record
    AntiAliasing: Boolean;

  end;

  TColors = record
    Background,
    Grid,
    Ticks,
    GroundPlane: TColor;
    GridAlpha,
    TicksAlpha,
    GroundPlaneAlpha: single;
  end;

  TGrid = record
    Koordinates,
    Schrift,
    X1X2Plane,
    X2X3Plane,
    X1X3Plane,
    X1X2Raster,
    X1X3Raster,
    X2X3Raster: Boolean;
    Scale: single;
    TickScale: single;
  end;

  THardware = record
  end;

  TEnvironment = record
    MouseSensity: integer;
    RightPanel,
    LeftPanel: Boolean;
    Massstab: single;
  end;

  TSetting = class(TObject)
  public
    FDisplay: TDisplay;
    FColors: TColors;
    FGrid: TGrid;
    FEnvironment: TEnvironment;
    procedure NotifyChanges;
    constructor Create;
    procedure SetColorStandard;
    procedure SetStandard;
  end;

const
  ST_BACKGROUND = $00363636;
  ST_GRID = clWhite;
  ST_TICKS = clWhite;
  ST_GROUNDPLANE = $00CCCCCC;
  ST_GRIDALPHA = 0.5;
  ST_TICKSALPHA = 1;
  ST_GROUNDPLANEALPHA = 0.5;
  ST_M_SENSITY = 10;

implementation

uses
  Main;

constructor TSetting.Create;
begin
  inherited Create;
  SetStandard;
end;

procedure TSetting.SetColorStandard;
begin
  With FColors do begin
    BackGround:= ST_BACKGROUND;
    Grid:= ST_GRID;
    Ticks:= ST_TICKS;
    GroundPlane:= ST_GROUNDPLANE;
    GridAlpha:= ST_GRIDALPHA;
    TicksAlpha:= ST_TICKSALPHA;
    GroundPlaneAlpha:= ST_GROUNDPLANEALPHA;
  end;
end;

procedure TSetting.SetStandard;
begin
  With FDisplay do begin
    AntiAliasing:=True;
  end;

  SetColorStandard;

  With FGrid do begin
    Koordinates:= True;
    Schrift:= True;
    X1X2Plane:= True;
    X2X3Plane:= False;
    X1X3Plane:= False;
    X1X2Raster:= True;
    X2X3Raster:= False;
    X1X3Raster:= False;
    Scale:= 1;
    TickScale:= 1;
  end;

  With FEnvironment do begin
    MouseSensity:= 10;
    RightPanel:=True;
    LeftPanel:=True;
    Massstab:=1;
  end;
end;

procedure TSetting.NotifyChanges;
var
  i, j: integer;
begin
 With Form1 do begin
// Display
  If FDisplay.AntiAliasing then
    GLSceneViewer1.Buffer.AntiAliasing:=aa4xHQ
  else
    GLSceneViewer1.Buffer.AntiAliasing:=aaNone;

//Colors
  if GLSceneViewer1.Buffer.BackgroundColor <> FColors.Background then
    GLSceneViewer1.Buffer.BackgroundColor:=FColors.Background;

  if (X1X2Grid.LineColor.AsWinColor <> FColors.Grid) or
     (X1X2Grid.LineColor.Alpha <> FColors.GridAlpha) then begin
    X1X2Grid.LineColor.AsWinColor:= FColors.Grid;
    X1X2Grid.LineColor.Alpha:= FColors.GridAlpha;
  end;

  if (X1X3Grid.LineColor.AsWinColor <> FColors.Grid) or
     (X1X3Grid.LineColor.Alpha <> FColors.GridAlpha) then begin
    X1X3Grid.LineColor.AsWinColor:= FColors.Grid;
    X1X3Grid.LineColor.Alpha:= FColors.GridAlpha;
  end;

  if (X2X3Grid.LineColor.AsWinColor <> FColors.Grid) or
     (X2X3Grid.LineColor.Alpha <> FColors.GridAlpha) then begin
    X2X3Grid.LineColor.AsWinColor:= FColors.Grid;
    X2X3Grid.LineColor.Alpha:= FColors.GridAlpha;
  end;

  If (X1X2Plane.Material.FrontProperties.Diffuse.AsWinColor <> FColors.GroundPlane) or
     (X1X2Plane.Material.FrontProperties.Diffuse.Alpha <> FColors.GroundPlaneAlpha)then begin
    X1X2Plane.Material.FrontProperties.Diffuse.AsWinColor := FColors.GroundPlane;
    X1X2Plane.Material.BackProperties.Diffuse.AsWinColor := FColors.GroundPlane;
    X1X2Plane.Material.FrontProperties.Diffuse.Alpha := FColors.GroundPlaneAlpha;
    X1X2Plane.Material.BackProperties.Diffuse.Alpha := FColors.GroundPlaneAlpha;
  end;

  If (X1X3Plane.Material.FrontProperties.Diffuse.AsWinColor <> FColors.GroundPlane) or
     (X1X3Plane.Material.FrontProperties.Diffuse.Alpha <> FColors.GroundPlaneAlpha)then begin
    X1X3Plane.Material.FrontProperties.Diffuse.AsWinColor := FColors.GroundPlane;
    X1X3Plane.Material.BackProperties.Diffuse.AsWinColor := FColors.GroundPlane;
    X1X3Plane.Material.FrontProperties.Diffuse.Alpha := FColors.GroundPlaneAlpha;
    X1X3Plane.Material.BackProperties.Diffuse.Alpha := FColors.GroundPlaneAlpha;
  end;

  If (X2X3Plane.Material.FrontProperties.Diffuse.AsWinColor <> FColors.GroundPlane) or
     (X2X3Plane.Material.FrontProperties.Diffuse.Alpha <> FColors.GroundPlaneAlpha)then begin
    X2X3Plane.Material.FrontProperties.Diffuse.AsWinColor := FColors.GroundPlane;
    X2X3Plane.Material.BackProperties.Diffuse.AsWinColor := FColors.GroundPlane;
    X2X3Plane.Material.FrontProperties.Diffuse.Alpha := FColors.GroundPlaneAlpha;
    X2X3Plane.Material.BackProperties.Diffuse.Alpha := FColors.GroundPlaneAlpha;
  end;

  if (TGLSpaceText(X1Ticks.Children[0]).Material.FrontProperties.Diffuse.AsWinColor <> FColors.Ticks) or
     (TGLSpaceText(X1Ticks.Children[0]).Material.FrontProperties.Diffuse.Alpha <> FColors.TicksAlpha) then
    for i:=0 to X1Ticks.Count-1 do begin
      TGLSpaceText(X1Ticks.Children[i]).Material.FrontProperties.Diffuse.AsWinColor:= FColors.Ticks;
      TGLSpaceText(X1Ticks.Children[i]).Material.FrontProperties.Diffuse.Alpha:= FColors.TicksAlpha;
      TGLSpaceText(X1Ticks.Children[i]).Material.FrontProperties.Emission.AsWinColor:= FColors.Ticks;
      TGLSpaceText(X1Ticks.Children[i]).Material.FrontProperties.Emission.Alpha:= FColors.TicksAlpha;
    end;

  if (TGLSpaceText(X2Ticks.Children[0]).Material.FrontProperties.Diffuse.AsWinColor <> FColors.Ticks) or
     (TGLSpaceText(X2Ticks.Children[0]).Material.FrontProperties.Diffuse.Alpha <> FColors.TicksAlpha) then
    for i:=0 to X2Ticks.Count-1 do begin
      TGLSpaceText(X2Ticks.Children[i]).Material.FrontProperties.Diffuse.AsWinColor:= FColors.Ticks;
      TGLSpaceText(X2Ticks.Children[i]).Material.FrontProperties.Diffuse.Alpha:= FColors.TicksAlpha;
      TGLSpaceText(X2Ticks.Children[i]).Material.FrontProperties.Emission.AsWinColor:= FColors.Ticks;
      TGLSpaceText(X2Ticks.Children[i]).Material.FrontProperties.Emission.Alpha:= FColors.TicksAlpha;
    end;

  if (TGLSpaceText(X3Ticks.Children[0]).Material.FrontProperties.Diffuse.AsWinColor <> FColors.Ticks) or
     (TGLSpaceText(X3Ticks.Children[0]).Material.FrontProperties.Diffuse.Alpha <> FColors.TicksAlpha) then
    for i:=0 to X3Ticks.Count-1 do begin
      TGLSpaceText(X3Ticks.Children[i]).Material.FrontProperties.Diffuse.AsWinColor:= FColors.Ticks;
      TGLSpaceText(X3Ticks.Children[i]).Material.FrontProperties.Diffuse.Alpha:= FColors.TicksAlpha;
      TGLSpaceText(X3Ticks.Children[i]).Material.FrontProperties.Emission.AsWinColor:= FColors.Ticks;
      TGLSpaceText(X3Ticks.Children[i]).Material.FrontProperties.Emission.Alpha:= FColors.TicksAlpha;
    end;

//Grid
  if Koordinates.Visible <> FGrid.Koordinates then
    Koordinates.Visible:= FGrid.Koordinates;

  if Ticks.Visible <> FGrid.Schrift then
    Ticks.Visible:= FGrid.Schrift;

  if X1X2Grid.Visible <> FGrid.X1X2Raster then
    X1X2Grid.Visible:= FGrid.X1X2Raster;

  if X1X3Grid.Visible <> FGrid.X1X3Raster then
    X1X3Grid.Visible:= FGrid.X1X3Raster;

  if X2X3Grid.Visible <> FGrid.X2X3Raster then
    X2X3Grid.Visible:= FGrid.X2X3Raster;

  if X1X2Plane.Visible <> FGrid.X1X2Plane then
    X1X2Plane.Visible:= FGrid.X1X2Plane;

  if X1X3Plane.Visible <> FGrid.X1X3Plane then
    X1X3Plane.Visible:= FGrid.X1X3Plane;

  if X2X3Plane.Visible <> FGrid.X2X3Plane then
    X2X3Plane.Visible:= FGrid.X2X3Plane;

  if Edit3.Text <> Format('%0.5g',[FGrid.Scale]) then begin
    Edit3.Text:= Format('%0.5g', [FGrid.Scale]);
  end;

  if 1/(FGrid.Scale*FEnvironment.Massstab) > 15 then begin
    FGrid.Scale:=1/FEnvironment.Massstab;
    Edit3.Text:= Format('%0.5g', [FGrid.Scale]);
  end;

// Environment

  if abs(StrToFloat(Edit1.Text)/StrToFloat(Edit2.Text)-FEnvironment.Massstab) >= 0.000001 then begin
    If FEnvironment.Massstab < 1 then begin
      Edit2.Text:=Format('%0.5g',[1/FEnvironment.Massstab]);
      Edit1.Text:='1';
    end else begin
      Edit2.Text:='1';
      Edit1.Text:=Format('%0.5g',[FEnvironment.Massstab]);
    end;
  end;

  if (Objects.Scale.X <> FEnvironment.Massstab) or (X1X2Grid.XSamplingScale.Step <> FGrid.Scale) then begin
    Objects.Scale.AsAffineVector:=AffineVectorMake(FEnvironment.Massstab,
                                                   FEnvironment.Massstab,
                                                   FEnvironment.Massstab);
    DoZoom(FEnvironment.Massstab);
  end;

 end;
end;

end.
