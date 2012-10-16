unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, GLScene, GLWin32Viewer, GLMisc, ToolWin, ComCtrls, Menus,
  StdCtrls, GLObjects, GLNavigator, GLGraph, GLSpaceText, Math,
  VectorGeometry, GLTexture, GLParticles, GLContext, VectorTypes, ExtCtrls, GLCadencer,
  GLTreeView, ActionList, AppEvnts, MathParser, Spin, Primitives, SaveFileSettings,
  Verlauf, Einstellung, ImgList, Konstruktionen, Buttons, GLBehaviours, Types,
  OrtsLinie, OpenGL1x, Registry, MultiButton, GLGeomObjects, GLCrossPlatform;

type
  // Reference to Primitives
  TPunkt = Primitives.TPunkt;
  TStrecke = Primitives.TStrecke;
  TGerade = Primitives.TGerade;
  TEbene = Primitives.TEbene;
  TKreis = Primitives.TKreis;
  TKugel = Primitives.TKugel;
  TOrtsLinie = Primitives.TOrtsLinie;

  TForm1 = class(TForm)
    StatusBar1: TStatusBar;
    MainMenu1: TMainMenu;
    Datei1: TMenuItem;
    GLScene1: TGLScene;
    GLCamera1: TGLCamera;
    GLLightSource1: TGLLightSource;
    DummyCube1: TGLDummyCube;
    X1X2Grid: TGLXYZGrid;
    SpaceText1: TGLSpaceText;
    SpaceText2: TGLSpaceText;
    SpaceText3: TGLSpaceText;
    NeuesObjekterstellen1: TMenuItem;
    Gerade1: TMenuItem;
    Ebene1: TMenuItem;
    Planes: TGLParticles;
    EbenenMenu: TPopupMenu;
    PunkteMenu: TPopupMenu;
    KugelMenu: TPopupMenu;
    NeueEbeneerstellen1: TMenuItem;
    AlleEbenenlschen1: TMenuItem;
    GeradenMenu: TPopupMenu;
    GeradeErstellen: TMenuItem;
    AlleGeradenlschen1: TMenuItem;
    Points: TGLParticles;
    Spheres: TGLParticles;
    Lines: TGLDummyCube;
    SichtMenu: TPopupMenu;
    Ansichtzurcksetzen1: TMenuItem;
    GLCadencer1: TGLCadencer;
    TargetCube: TGLDummyCube;
    Beenden1: TMenuItem;
    Punkt1: TMenuItem;
    Kugel1: TMenuItem;
    Einstellungen: TMenuItem;
    InZRichtungschauen1: TMenuItem;
    InYRichtungschauen1: TMenuItem;
    InXRichtungschauen1: TMenuItem;
    N1: TMenuItem;
    MultiSelectMenu: TPopupMenu;
    Objekteschneiden1: TMenuItem;
    SingleSelectMenu: TPopupMenu;
    Bearbeiten1: TMenuItem;
    Rckgngig1: TMenuItem;
    Wiederherstellen1: TMenuItem;
    Verschiedenes: TMenuItem;
    Rckblende2: TMenuItem;
    N2: TMenuItem;
    Speichern1: TMenuItem;
    Laden1: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Neu1: TMenuItem;
    Strecken: TGLParticles;
    AnsichtalsBitmapspeichern1: TMenuItem;
    StreckenMenu: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    Strecke1: TMenuItem;
    Koordinates: TGLDummyCube;
    Grid: TGLDummyCube;
    X1Ticks: TGLParticles;
    X2Ticks: TGLParticles;
    X3Ticks: TGLParticles;
    X1Tick: TGLSpaceText;
    Objects: TGLDummyCube;
    Hilfe1: TMenuItem;
    Variablen1: TMenuItem;
    Alle1: TMenuItem;
    X2Tick: TGLSpaceText;
    Ticks: TGLDummyCube;
    X1X3Grid: TGLXYZGrid;
    X2X3Grid: TGLXYZGrid;
    ApplicationEvents1: TApplicationEvents;
    PanelLeft: TPanel;
    SettingLeft: TPaintBox;
    Massstab: TPanel;
    HeaderBox1: TPaintBox;
    Label5: TLabel;
    Label4: TLabel;
    k: TLabel;
    Label1: TLabel;
    TrackBar1: TTrackBar;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Panel4: TPanel;
    HeaderBox2: TPaintBox;
    Label2: TLabel;
    Panel6: TPanel;
    HeaderBox3: TPaintBox;
    Label9: TLabel;
    PanelRight: TPanel;
    TreeView1: TGLTreeView;
    SetRightDown: TPanel;
    PaintBox1: TPaintBox;
    Label10: TLabel;
    Memo1: TMemo;
    PaintBox2: TPaintBox;
    Label11: TLabel;
    X1X2Plane: TGLPlane;
    X1X3Plane: TGLPlane;
    X2X3Plane: TGLPlane;
    KoordSys: TCheckBox;
    KoordSchr: TCheckBox;
    X1X2Ebene: TCheckBox;
    X1X3Ebene: TCheckBox;
    X2X3Ebene: TCheckBox;
    X2X3Raster: TCheckBox;
    X1X3Raster: TCheckBox;
    X1X2Raster: TCheckBox;
    KoordPlanes: TGLDummyCube;
    ToolImages: TImageList;
    Panel1: TPanel;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    MakeNormal: TToolButton;
    ToolButton8: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToggleLeftPanel: TToolButton;
    ToggleRightPanel: TToolButton;
    PanelCenter: TPanel;
    GLSceneViewer1: TGLSceneViewer;
    Image1: TImage;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    X2Rotation: TLabel;
    X1Rotation: TLabel;
    X3Rotation: TLabel;
    KameraPosition: TLabel;
    CamPosX1: TEdit;
    CamPosX3: TEdit;
    CamPosX2: TEdit;
    Label3: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    ZoomEdit: TEdit;
    Label8: TLabel;
    Image2: TImage;
    ZoomPlus: TButton;
    ZoomMinus: TButton;
    Button1: TButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    Info1: TMenuItem;
    KonstruktionsverlaufSpeichern1: TMenuItem;
    Splitter1: TSplitter;
    Circles: TGLParticles;
    ToolButton16: TToolButton;
    KreisMenu: TPopupMenu;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    Button2: TButton;
    DarstellungsArtLabel: TLabel;
    OrtsLinien: TGLParticles;
    ToolButton17: TToolButton;
    ToolButton18: TToolButton;
    MultiButton1: TMultiButton;
    ToolButton19: TToolButton;
    ToolButton20: TToolButton;
    ToolButton21: TToolButton;
    MultiButton2: TMultiButton;
    ToolButton9: TToolButton;
    ToolButton22: TToolButton;
    ToolButton23: TToolButton;

    procedure GLSceneViewer1MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure GLSceneViewer1MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure Ebene1Click(Sender: TObject);
    procedure SetEbene(Ebene: TEbene; pos, dir: TVector3f);
    procedure SetGerade(Gerade: TGerade; pos, dir: TVector3f);
    procedure SetKreis(Kreis: TKreis; pos, dir: TVector3f; r: Single);
    procedure SetKugel(Kugel: TKugel; pos: TVector3f; r: Single);
    procedure SetStrecke(Strecke: TStrecke; p1, p2: TVector3f);
    procedure FormCreate(Sender: TObject);
    procedure TreeView1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure NeueEbeneerstellen1Click(Sender: TObject);
    procedure AlleEbenenlschen1Click(Sender: TObject);
    procedure GeradeErstellenClick(Sender: TObject);
    procedure AlleGeradenlschen1Click(Sender: TObject);
    procedure NeuenPunkterstellen1Click(Sender: TObject);
    procedure NeueKugelhinzufgen1Click(Sender: TObject);
    procedure AllePunktelschen1Click(Sender: TObject);
    procedure AlleKugelnlschen1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Ansichtzurcksetzen1Click(Sender: TObject);
    procedure GLCadencer1Progress(Sender: TObject; const deltaTime,
      newTime: Double);
    procedure HandleKeys(deltaTime: double);
    procedure Punkt1Click(Sender: TObject);
    procedure Gerade1Click(Sender: TObject);
    procedure Kugel1Click(Sender: TObject);
    procedure Beenden1Click(Sender: TObject);
    procedure InXRichtungschauen1Click(Sender: TObject);
    procedure InYRichtungschauen1Click(Sender: TObject);
    procedure InZRichtungschauen1Click(Sender: TObject);
    procedure TreeView1DblClick(Sender: TObject);
    procedure ToggleVisibility(Sender: TObject);
    procedure Grafik1Click(Sender: TObject);
    procedure Rckgngig1Click(Sender: TObject);
    procedure Wiederherstellen1Click(Sender: TObject);
    procedure Rckblende2Click(Sender: TObject);
    procedure Speichern1Click(Sender: TObject);
    procedure Laden1Click(Sender: TObject);
    procedure TreeView1Edited(Sender: TObject; Node: TTreeNode;
      var S: String);
    procedure Neu1Click(Sender: TObject);
    procedure AnsichtalsBitmapspeichern1Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure Strecke1Click(Sender: TObject);
    procedure Spurgeraden(Sender: TObject);
    procedure Endpunktezeichnen(Sender: TObject); overload;
    procedure ApplicationEvents1Message(var Msg: tagMSG;
      var Handled: Boolean);
    procedure Winkel2EbenenBestimmen(Sender: TObject);
    procedure Winkel2GeradenBestimmen(Sender: TObject);
    procedure WinkelGeradeEbeneBestimmen(Sender: TObject);
    procedure WinkelEbeneGeradeBestimmen(Sender: TObject);
    procedure Abstand2PunkteBestimmen(Sender: TObject);
    procedure AbstandPunktGeradeBestimmen(Sender: TObject);
    procedure AbstandGeradePunktBestimmen(Sender: TObject);
    procedure Abstand2GeradenBestimmen(Sender: TObject);
    procedure AbstandEbeneGeradeBestimmen(Sender: TObject);
    procedure AbstandGeradeEbeneBestimmen(Sender: TObject);
    procedure AbstandEbenePunktBestimmen(Sender: TObject);
    procedure AbstandPunktEbeneBestimmen(Sender: TObject);
    procedure Abstand2EbenenBestimmen(Sender: TObject);
    procedure AbstandPunktStreckeBestimmen(Sender: TObject);
    procedure AbstandStreckePunktBestimmen(Sender: TObject);
    procedure AbstandStreckeGeradeBestimmen(Sender: TObject);
    procedure AbstandGeradeStreckeBestimmen(Sender: TObject);
    procedure Abstand2StreckenBestimmen(Sender: TObject);
    procedure AbstandStreckeEbeneBestimmen(Sender: TObject);
    procedure AbstandEbeneStreckeBestimmen(Sender: TObject);
    procedure AbstandPunktKugelBestimmen(Sender: TObject);
    procedure AbstandKugelPunktBestimmen(Sender: TObject);
    procedure AbstandStreckeKugelBestimmen(Sender: TObject);
    procedure AbstandKugelStreckeBestimmen(Sender: TObject);
    procedure AbstandGeradeKugelBestimmen(Sender: TObject);
    procedure AbstandKugelGeradeBestimmen(Sender: TObject);
    procedure AbstandEbeneKugelBestimmen(Sender: TObject);
    procedure AbstandKugelEbeneBestimmen(Sender: TObject);
    procedure Abstand2KugelnBestimmen(Sender: TObject);
    procedure AbstandPunktKreisBestimmen(Sender: TObject);
    procedure AbstandKreisPunktBestimmen(Sender: TObject);
    procedure AbstandGeradeKreisBestimmen(Sender: TObject);
    procedure AbstandKreisGeradeBestimmen(Sender: TObject);
    procedure AbstandStreckeKreisBestimmen(Sender: TObject);
    procedure AbstandKreisStreckeBestimmen(Sender: TObject);

    procedure GLSceneViewer1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Edit1Change(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Variablen1Click(Sender: TObject);
    procedure OpenVarWindow(Sender: TObject);
    procedure CreateVarWindow(Sender: TObject);
    procedure AllVarWindows(Sender: TObject);
    procedure TreeView1Editing(Sender: TObject; Node: TTreeNode;
      var AllowEdit: Boolean);
    procedure Koordinatensystem1Click(Sender: TObject);
    procedure SettingLeftPaint(Sender: TObject);
    procedure HeaderBox1Paint(Sender: TObject);
    procedure KoordSysClick(Sender: TObject);
    procedure KoordSchrClick(Sender: TObject);
    procedure X1X2EbeneClick(Sender: TObject);
    procedure X1X3EbeneClick(Sender: TObject);
    procedure X2X3EbeneClick(Sender: TObject);
    procedure X1X2RasterClick(Sender: TObject);
    procedure X1X3RasterClick(Sender: TObject);
    procedure X2X3RasterClick(Sender: TObject);
    procedure ToggleLeftPanelClick(Sender: TObject);
    procedure ToggleRightPanelClick(Sender: TObject);
    procedure MakeNormalClick(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
    procedure ToolButton1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ToolButton2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ToolButton3MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ToolButton4MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ToolButton5MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure MakeNormalMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ToolButton8MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure BitBtn3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BitBtn3MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BitBtn4MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BitBtn4MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BitBtn1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BitBtn1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BitBtn2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BitBtn2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BitBtn6MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BitBtn6MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BitBtn5MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BitBtn5MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DummyCube1Progress(Sender: TObject; const deltaTime,
      newTime: Double);
    procedure GLCamera1Progress(Sender: TObject; const deltaTime,
      newTime: Double);
    procedure CamPosX1Change(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ZoomPlusClick(Sender: TObject);
    procedure ZoomMinusClick(Sender: TObject);
    procedure ZoomEditChange(Sender: TObject);
    procedure ToolButton9Click(Sender: TObject);
    procedure ToolButton10Click(Sender: TObject);
    procedure ToolButton11Click(Sender: TObject);
    procedure ToolButton12Click(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
    procedure ToolButton9MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ToolButton10MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ToolButton11MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ToolButton12MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ToolButton7MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ToolButton13Click(Sender: TObject);
    procedure ToolButton14Click(Sender: TObject);
    procedure KonstruktionsverlaufSpeichern1Click(Sender: TObject);
    procedure Bearbeiten1Click(Sender: TObject);
    procedure Info1Click(Sender: TObject);
    procedure ToolButton16Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure HeaderBox3Click(Sender: TObject);
    procedure HeaderBox2Click(Sender: TObject);
    procedure HeaderBox1Click(Sender: TObject);
    procedure ToolButton17MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ToolButton17Click(Sender: TObject);
    procedure EbeneDurch3Punkte(Sender: TObject);
    procedure EbeneDurchPunktGerade(Sender: TObject);
    procedure GeradeDurch2Punkte(Sender: TObject);
    procedure StreckeDurch2Punkte(Sender: TObject);
    procedure Objekteschneiden(Sender: TObject);
  private
    { Private declarations }
    mdx, mdy : Integer;
    TwoBZoom: integer;
//    WheelZoom: integer;
  public
    { Public declarations }
    procedure NewEbene(n1,n2,n3,n0: single); overload;
    procedure NewEbene(p1,p2,p3,a1,a2,a3,b1,b2,b3: single); overload;
    procedure NewEbene(p1,p2,p3,n1,n2,n3: single); overload;
    procedure NewGerade(p1,p2,p3,v1,v2,v3: single); overload;
    procedure NewGerade(p1,p2,p3,v1,v2,v3: single; Parent1, Parent2: string; CreationMode: string); overload;
    procedure NewKreis(p1, p2, p3, d1, d2, d3, r: single); overload;
    procedure NewPunkt(p1,p2,p3: single); overload;
    procedure NewPunkt(p1,p2,p3: single; Parent1, Parent2, Parent3: string; CreationMode: string); overload;
    procedure NewKugel(m1,m2,m3,r: Single);
    procedure NewStrecke(p1,p2,p3,q1,q2,q3: single); overload;
    procedure NewStrecke(p1,p2,p3,q1,q2,q3: single; Parent1, Parent2, CreationMode: string); overload;
    procedure Highlight(Grade: single);
    procedure OptimiereGerade(var Gerade: TGerade);
    procedure OptimiereEbene(var Ebene: TEbene);
    procedure MoveCamWithTarget(Cam: TGLCamera; Target: TGLCustomSceneObject; X,Y: double);
    procedure DeleteObject(Sender: TObject); overload;
    procedure DeleteObject(Node: TGLNode; RegisterAction: Boolean); overload;
    procedure DeleteObject(Node: TGLNode; RegisterAction, DeleteChildren: Boolean); overload;
    procedure RegisterActions(Sender: TGLBaseSceneObject; Action: string; Visible: Boolean = True); overload;
    procedure RegisterActions(NewSender, OldSender: TGLBaseSceneObject; Action: string; Visible: Boolean = True); overload;
    procedure NotifyVarChange(Variable: TVariable);
    procedure Endpunktezeichnen(Strecke: TStrecke); overload;
  end;

const
  PUNKT_RADIUS: single = 0.05;
  GERADE_DICKE: single = 0.02; GERADE_LANGE = 14;
  FILE_VERSION = '1.0.1.0';

  ST_SCENE_SCALE = 1.1;

  GermanColors: array[1..20] of string = (
    ('Schwarz'),
    ('Maroon'),
    ('Grün'),
    ('Olive'),
    ('Navy'),
    ('Purpur'),
    ('Teal'),
    ('Grau'),
    ('Silber'),
    ('Rot'),
    ('Lime'),
    ('Gelb'),
    ('Blau'),
    ('Fuchsia'),
    ('Aqua'),
    ('Weiß'),
    ('Dollar Grün'),
    ('Himmel Blau'),
    ('Cream'),
    ('Mittel Grau'));

var
  Form1: TForm1;
  DefDir, DefUp: TVector4f;
  OldSelectedObjects, SelectedObjects: Array of TGLSceneObject;
  MOUSE_SENSITY: integer = 10;
  DRAG_SENSITY: single = 0.002;
  ZOOM_SENSITY: single = 2;
  ROTATE_SENSITY: single = 0.1;
  ActionList1: TActionsList;
  VarsArchive: TVarsArray;
  ActualGridScale: single = 1;
  ParamForms: TComponent;
  TreeViewEditing: Boolean;
  Settings: TSetting;
  KameraTurning: Integer;

procedure ZeigeDaten(Punkt: TPunkt; Memo: TMemo); overload;
procedure ZeigeDaten(Strecke: TStrecke; Memo: TMemo); overload;
procedure ZeigeDaten(Gerade: TGerade; Memo: TMemo); overload;
procedure ZeigeDaten(Ebene: TEbene; Memo: TMemo); overload;
procedure ZeigeDaten(Kreis: TKreis; Memo: TMemo); overload;
procedure ZeigeDaten(Kugel: TKugel; Memo: TMemo); overload;
procedure DoZoom(Grade: single);
procedure ChangeChild(ChildObj: TGLBaseSceneObject; Variable: string = '');
procedure ChangeChildren(Obj: TGLBaseSceneObject; Variable: string = '');

implementation

uses GeradenTool, EbenenTool,  PunkteTool, KugelTool, KeyBoard, SchnittBerechnung,
  DoppelKlickTool, GrafikOptions, Rueckblende, StreckenTool, Profiles, AbstandWinkel,
  KoordinatensystemEinstellungen, Info, KreisTool, OrtsLinienTool, Constructions;

{$R *.dfm}

procedure TForm1.MoveCamWithTarget(Cam: TGLCamera; Target: TGLCustomSceneObject; X,Y: double);
var
  Vector, VectorUp: TVector3f;
begin
  Vector:=VectorNormalize(VectorSubtract(Target.Position.AsAffineVector, Cam.Position.AsAffineVector));
  VectorUp:=Vector;
  Vector:=VectorNormalize(VectorCrossProduct(Vector, Cam.Up.AsAffineVector));
  VectorUp:=VectorCrossProduct(Vector, VectorUp);
  Vector:=VectorAdd(VectorScale(VectorUp, Y), VectorScale(Vector, X));
  Target.Position.Translate(Vector);
  Cam.Position.Translate(Vector);
end;

function  FinalFormat(S: string): string;
var
  i: integer;
  Number: Boolean;
begin
  Result:=S;

  If Result='' then
    Exit;

  Number:=True;
  for i:=1 to Length(S) do begin
    If not (S[i] in ['0'..'9',',','e','E','-']) then
      Number:=False;
  end;
  If Number then
    If pos('E', S) > 0 then
      S:='0';

  Result:= MakeNiceNumber(ProcessLine(S, VarsArchive));

  If Pos(',', Result) > 0 then
    Result:=Format('%0.3f',[StrToFloat(Result)]);
end;

procedure ZeigeDaten(Ebene: TEbene; Memo: TMemo); overload;
var
  Ursprung{, ParX1, ParX2, ParX3}: boolean;
  Parallel: array of string;
begin
  With Memo.Lines do begin
    Clear;
    Add('Aufpunkt:');

    Add(FinalFormat(Ebene.ParamPosX1)+' | '+FinalFormat(Ebene.ParamPosX2)+' | '+FinalFormat(Ebene.ParamPosX3));
    Add('');
    Add('Normalenvektor:');
    Add(FinalFormat(Ebene.ParamDirX1)+' | '+FinalFormat(Ebene.ParamDirX2)+' | '+FinalFormat(Ebene.ParamDirX3));
    Add('');
    Add('Achsenabschnitte:');
    Add('x1: ' + FinalFormat(FloatToStr(Ebene.Achsenabschnitte[0])));
    Add('x2: ' + FinalFormat(FloatToStr(Ebene.Achsenabschnitte[1])));
    Add('x3: ' + FinalFormat(FloatToStr(Ebene.Achsenabschnitte[2])));

//== besondere Lage feststellen
    If VectorLength(Ebene.Aufpunkt)=0 then Ursprung:=True else Ursprung:=False;
    If Ebene.NormalenVektor[0]=0 then begin
      SetLength(Parallel, length(Parallel)+1);
      Parallel[length(Parallel)-1]:='X1';
    end;
    If Ebene.NormalenVektor[1]=0 then begin
      SetLength(Parallel, length(Parallel)+1);
      Parallel[length(Parallel)-1]:='X2';
    end;
    If Ebene.NormalenVektor[2]=0 then begin
      SetLength(Parallel, length(Parallel)+1);
      Parallel[length(Parallel)-1]:='X3';
    end;
    Add('');
    If Ursprung then begin
      Case length(Parallel) of
        0: Add('Die Ebene geht durch den Ursprung');
        1: Add('Die Ebene enthält die '+Parallel[0]+'-Koordinatenachse');
        2: Add('Diese Ebene ist die '+Parallel[0]+'-'+Parallel[1]+'-Koordinatenebene');
      end;
    end else begin
      Case length(Parallel) of
        0: Delete(Count);
        1: Add('Die Ebene ist parallel zur '+Parallel[0]+'-Koordinatenachse');
        2: Add('Die Ebene ist parallel zur '+Parallel[0]+'-'+Parallel[1]+'-Koordinatenebene');
      end;
    end;
  end;
end;

procedure ZeigeDaten(Punkt: TPunkt; Memo: TMemo); overload;
var
  Ursprung : boolean;
  Lage: array of string;

begin
  With Memo.Lines do begin
    Clear;
    Add('Position:');
    If (Punkt.ParamPosX1 <> '') and (Punkt.ParamPosX2 <> '') and (Punkt.ParamPosX3 <> '') then
      Add('('+FinalFormat(Punkt.ParamPosX1)+' | '+FinalFormat(Punkt.ParamPosX2)+' | '+FinalFormat(Punkt.ParamPosX3)+')')
    else
      Add('(' + FinalFormat(FloatToStr(Punkt.Koordinaten[0])) + ' | ' +
                FinalFormat(FloatToStr(Punkt.Koordinaten[1])) + ' | ' +
                FinalFormat(FloatToStr(Punkt.Koordinaten[2])) + ')');

//== besondere Lage feststellen
    If VectorLength(Punkt.Position.AsAffineVector)=0 then Ursprung:=True else Ursprung:=False;
    If not IsZero(Punkt.Position.Z, 0.000001) then begin
      SetLength(Lage, length(Lage)+1);
      Lage[length(Lage)-1]:='X1';
    end;
    If not IsZero(Punkt.Position.X, 0.000001) then begin
      SetLength(Lage, length(Lage)+1);
      Lage[length(Lage)-1]:='X2';
    end;
    If not IsZero(Punkt.Position.Y, 0.000001) then begin
      SetLength(Lage, length(Lage)+1);
      Lage[length(Lage)-1]:='X3';
    end;
    Add('');
    If Ursprung then
      Add('Der Punkt liegt im Ursprung')
    else begin
      Case length(Lage) of
        0: Delete(Count);
        1: Add('Der Punkt liegt auf der '+Lage[0]+'-Koordinatenachse');
        2: Add('Der Punkt liegt in der '+Lage[0]+'-'+Lage[1]+'-Koordinatenebene');
      end;
    end;
  end;
end;

procedure ZeigeDaten(Kreis: TKreis; Memo: TMemo); overload;
begin
  With Memo.Lines do begin
    Clear;
    Add('Aufpunkt:');
    Add(FinalFormat(Kreis.ParamPosX1)+' | '+FinalFormat(Kreis.ParamPosX2)+' | '+FinalFormat(Kreis.ParamPosX3));
    Add('');
    Add('Normalenvektor:');
    Add(FinalFormat(Kreis.ParamDirX1)+' | '+FinalFormat(Kreis.ParamDirX2)+' | '+FinalFormat(Kreis.ParamDirX3));
    Add('');
    Add('Radius:');
    Add(FinalFormat(Kreis.ParamRadius));
    Add('');

  end; {With}
end;

procedure ZeigeDaten(Kugel: TKugel; Memo: TMemo); overload;
begin
  With Memo.Lines do begin
    Clear;
    Add('Position:');
    Add('(' + FinalFormat(Kugel.ParamPosX1) + ' | ' +
              FinalFormat(Kugel.ParamPosX2) + ' | ' +
              FinalFormat(Kugel.ParamPosX3) + ')');
    Add('');
    Add('Radius: '+ FinalFormat(Kugel.ParamRadius));
  end;
end;

procedure ZeigeDaten(Gerade: TGerade; Memo: TMemo); overload;
var
  Ursprung : boolean;
  Lage: array of string;

begin
  With Memo.Lines do begin
    Clear;
    Add('Aufpunkt:');
    Add(FinalFormat(Gerade.ParamPosX1)+' | '+FinalFormat(Gerade.ParamPosX2)+' | '+FinalFormat(Gerade.ParamPosX3));
    Add('');
    Add('Richtungsvektor:');
    Add(FinalFormat(Gerade.ParamDirX1)+' | '+FinalFormat(Gerade.ParamDirX2)+' | '+FinalFormat(Gerade.ParamDirX3));

//== besondere Lage feststellen
    If VectorLength(Gerade.Aufpunkt)=0 then Ursprung:=True else Ursprung:=False;
    If Gerade.RichtungsVektor[0]<>0 then begin
      SetLength(Lage, length(Lage)+1);
      Lage[length(Lage)-1]:='X1';
    end;
    If Gerade.RichtungsVektor[1]<>0 then begin
      SetLength(Lage, length(Lage)+1);
      Lage[length(Lage)-1]:='X2';
    end;
    If Gerade.RichtungsVektor[2]<>0 then begin
      SetLength(Lage, length(Lage)+1);
      Lage[length(Lage)-1]:='X3';
    end;
    Add('');
    If Ursprung then begin
      Case length(Lage) of
        0: Add('Die Gerade geht durch den Ursprung');
        1: Add('Diese Gerade ist die '+Lage[0]+'-Koordinatenachse');
        2: Add('Diese Gerade liegt in der '+Lage[0]+'-'+Lage[1]+'-Koordinatenebene');
      end;
    end else begin
      Case length(Lage) of
        0: Delete(Count);
        1: Add('Die Gerade ist parallel zur '+Lage[0]+'-Koordinatenachse');
        2: Add('Die Gerade ist parallel zur '+Lage[0]+'-'+Lage[1]+'-Koordinatenebene');
      end;
    end;
  end;
end;

procedure ZeigeDaten(Strecke: TStrecke; Memo: TMemo); overload;
begin
  With Memo.Lines do begin
    Clear;
    Add('Anfangspunkt:');
    Add(FinalFormat(Strecke.ParamP1X1)+' | '+FinalFormat(Strecke.ParamP1X2)+' | '+FinalFormat(Strecke.ParamP1X3));
    Add('');
    Add('Endpunkt:');
    Add(FinalFormat(Strecke.ParamP2X1)+' | '+FinalFormat(Strecke.ParamP2X2)+' | '+FinalFormat(Strecke.ParamP2X3));

  end;
end;

procedure TForm1.RegisterActions(Sender: TGLBaseSceneObject; Action: string; Visible: Boolean);
var
  Act: string;
  i: integer;
begin

  Act:='';

//== Handle Create and Delete
 If (Copy(Action, 1, 6) = 'Create') or (Copy(Action, 1, 6) = 'Delete') then begin
  If Sender is TEbene then
    Act:=Action+'|Ebene|'+BoolToStr(Visible)+'|'+IntToStr(TreeView1.Selected.AbsoluteIndex)+'|'
         + TreeView1.Selected.Text+'|'
         + TEbene(Sender).ParamDirX1+'|'
         + TEbene(Sender).ParamDirX2+'|'
         + TEbene(Sender).ParamDirX3+'|'
         + TEbene(Sender).Param_N0+'|'
         + VectorToString(TEbene(Sender).Material.FrontProperties.Diffuse.Color)+'|';

  If Sender is TStrecke then
    Act:=Action+'|Strecke|'+BoolToStr(Visible)+'|'+IntToStr(TreeView1.Selected.AbsoluteIndex)
         + '|'+TreeView1.Selected.Text+'|'
         + TStrecke(Sender).ParamP1X1 +'|'
         + TStrecke(Sender).ParamP1X2 +'|'
         + TStrecke(Sender).ParamP1X3 +'|'
         + TStrecke(Sender).ParamP2X1 +'|'
         + TStrecke(Sender).ParamP2X2 +'|'
         + TStrecke(Sender).ParamP2X3 +'|'
         + VectorToString(TStrecke(Sender).Material.FrontProperties.Diffuse.Color)+'|';
  If Sender is TGerade then
    Act:=Action+'|Gerade|'+BoolToStr(Visible)+'|'+IntToStr(TreeView1.Selected.AbsoluteIndex)+'|'
         + TreeView1.Selected.Text+'|'
         + TGerade(Sender).ParamPosX1+'|'
         + TGerade(Sender).ParamPosX2+'|'
         + TGerade(Sender).ParamPosX3+'|'
         + TGerade(Sender).ParamDirX1+'|'
         + TGerade(Sender).ParamDirX2+'|'
         + TGerade(Sender).ParamDirX3+'|'
         + VectorToString(TGerade(Sender).Material.FrontProperties.Diffuse.Color)+'|';
  If Sender is TKreis then
    Act:=Action+'|Kreis|'+BoolToStr(Visible)+'|'+IntToStr(TreeView1.Selected.AbsoluteIndex)+'|'
         + TreeView1.Selected.Text+'|'
         + TKreis(Sender).ParamPosX1+'|'
         + TKreis(Sender).ParamPosX2+'|'
         + TKreis(Sender).ParamPosX3+'|'
         + TKreis(Sender).ParamDirX1+'|'
         + TKreis(Sender).ParamDirX2+'|'
         + TKreis(Sender).ParamDirX3+'|'
         + TKreis(Sender).ParamRadius+'|'
         + VectorToString(TKreis(Sender).Material.FrontProperties.Diffuse.Color)+'|';
  If Sender is TKugel then
    Act:=Action+'|Kugel|'+BoolToStr(Visible)+'|'+IntToStr(TreeView1.Selected.AbsoluteIndex)+'|'
         + TreeView1.Selected.Text+'|'
         + TKugel(Sender).ParamPosX1+'|'
         + TKugel(Sender).ParamPosX2+'|'
         + TKugel(Sender).ParamPosX3+'|'
         + TKugel(Sender).ParamRadius+'|'
         + VectorToString(TKugel(Sender).Material.FrontProperties.Diffuse.Color)+'|';
  If Sender is TPunkt then
    Act:=Action+'|Punkt|'+BoolToStr(Visible)+'|'+IntToStr(TreeView1.Selected.AbsoluteIndex)+'|'
         + TreeView1.Selected.Text+'|'
         + TPunkt(Sender).ParamPosX1+'|'
         + TPunkt(Sender).ParamPosX2+'|'
         + TPunkt(Sender).ParamPosX3+'|'
         + VectorToString(TPunkt(Sender).Material.FrontProperties.Diffuse.Color)+'|';
  If Sender is TOrtsLinie then
    Act:=Action+'|Ortslinie|'+BoolToStr(Visible)+'|'+IntToStr(TreeView1.Selected.AbsoluteIndex)+'|'
         + TreeView1.Selected.Text+'|'
         + TOrtsLinie(Sender).Punkt+'|'
         + TOrtsLinie(Sender).Variable.Name +'|'
         + FloatToStr(TOrtsLinie(Sender).RangeTop) +'|'
         + FloatToStr(TOrtsLinie(Sender).RangeBottom) +'|'
         + IntToStr(TOrtsLinie(Sender).Accuracy) +'|'
         + VectorToString(TOrtsLinie(Sender).LineColor.Color)+'|';

  Act:=Act + GetObjCreationMode(Sender)+'|';

  for i:=0 to GetObjParentCount(Sender)-1 do
    if GetObjName(GetObjParent(Sender, i)) <> '' then
      Act:=Act+GetObjName(GetObjParent(Sender, i))+'#';
  Act[Length(Act)]:='|';

  ActionList1.AddAction(Act);
 end;
end;

procedure TForm1.RegisterActions(NewSender, OldSender: TGLBaseSceneObject; Action: string; Visible: Boolean);
var
  Act: string;
begin

//== Handle ChangeName
  If Action = 'ChangeName' then begin
    Act:=Action+'||100||'+ GetObjName(OldSender)+'|'+GetObjName(NewSender);
    ActionList1.AddAction(Act);
  end;

//== Handle ChangeObject

  If Action = 'ChangeObject' then begin
    If OldSender is TEbene then
      Act:=Action+'|Ebene|'+BoolToStr(Visible)+'|'+IntToStr(TreeView1.Selected.AbsoluteIndex)+'|'
           + TreeView1.Selected.Text+'|'
           + TEbene(OldSender).ParamDirX1+'|'
           + TEbene(OldSender).ParamDirX2+'|'
           + TEbene(OldSender).ParamDirX3+'|'
           + TEbene(OldSender).Param_N0+'|'
           + TEbene(NewSender).ParamDirX1+'|'
           + TEbene(NewSender).ParamDirX2+'|'
           + TEbene(NewSender).ParamDirX3+'|'
           + TEbene(NewSender).Param_N0+'|'
           + VectorToString(TEbene(OldSender).Material.FrontProperties.Diffuse.Color)+'|'
           + VectorToString(TEbene(NewSender).Material.FrontProperties.Diffuse.Color)+'|';
    If OldSender is TStrecke then
      Act:=Action+'|Strecke|'+BoolToStr(Visible)+'|'+IntToStr(TreeView1.Selected.AbsoluteIndex)+'|'
           + TreeView1.Selected.Text+'|'
           + TStrecke(OldSender).ParamP1X1+'|'
           + TStrecke(OldSender).ParamP1X2+'|'
           + TStrecke(OldSender).ParamP1X3+'|'
           + TStrecke(OldSender).ParamP2X1+'|'
           + TStrecke(OldSender).ParamP2X2+'|'
           + TStrecke(OldSender).ParamP2X3+'|'
           + TStrecke(NewSender).ParamP1X1+'|'
           + TStrecke(NewSender).ParamP1X2+'|'
           + TStrecke(NewSender).ParamP1X3+'|'
           + TStrecke(NewSender).ParamP2X1+'|'
           + TStrecke(NewSender).ParamP2X2+'|'
           + TStrecke(NewSender).ParamP2X3+'|'
           + VectorToString(TStrecke(OldSender).Material.FrontProperties.Diffuse.Color)+'|'
           + VectorToString(TStrecke(NewSender).Material.FrontProperties.Diffuse.Color)+'|';
    If OldSender is TGerade then
      Act:=Action+'|Gerade|'+BoolToStr(Visible)+'|'+IntToStr(TreeView1.Selected.AbsoluteIndex)+'|'
           + TreeView1.Selected.Text+'|'
           + TGerade(OldSender).ParamPosX1+'|'
           + TGerade(OldSender).ParamPosX2+'|'
           + TGerade(OldSender).ParamPosX3+'|'
           + TGerade(OldSender).ParamDirX1+'|'
           + TGerade(OldSender).ParamDirX2+'|'
           + TGerade(OldSender).ParamDirX3+'|'
           + TGerade(NewSender).ParamPosX1+'|'
           + TGerade(NewSender).ParamPosX2+'|'
           + TGerade(NewSender).ParamPosX3+'|'
           + TGerade(NewSender).ParamDirX1+'|'
           + TGerade(NewSender).ParamDirX2+'|'
           + TGerade(NewSender).ParamDirX3+'|'
           + VectorToString(TGerade(OldSender).Material.FrontProperties.Diffuse.Color)+'|'
           + VectorToString(TGerade(NewSender).Material.FrontProperties.Diffuse.Color)+'|';
    If OldSender is TKreis then
      Act:=Action+'|Kreis|'+BoolToStr(Visible)+'|'+IntToStr(TreeView1.Selected.AbsoluteIndex)+'|'
           + TreeView1.Selected.Text+'|'
           + TKreis(OldSender).ParamPosX1+'|'
           + TKreis(OldSender).ParamPosX2+'|'
           + TKreis(OldSender).ParamPosX3+'|'
           + TKreis(OldSender).ParamDirX1+'|'
           + TKreis(OldSender).ParamDirX2+'|'
           + TKreis(OldSender).ParamDirX3+'|'
           + TKreis(OldSender).ParamRadius+'|'
           + TKreis(NewSender).ParamPosX1+'|'
           + TKreis(NewSender).ParamPosX2+'|'
           + TKreis(NewSender).ParamPosX3+'|'
           + TKreis(NewSender).ParamDirX1+'|'
           + TKreis(NewSender).ParamDirX2+'|'
           + TKreis(NewSender).ParamDirX3+'|'
           + TKreis(NewSender).ParamRadius+'|'
           + VectorToString(TKreis(OldSender).Material.FrontProperties.Diffuse.Color)+'|'
           + VectorToString(TKreis(NewSender).Material.FrontProperties.Diffuse.Color)+'|';
    If OldSender is TKugel then
      Act:=Action+'|Kugel|'+BoolToStr(Visible)+'|'+IntToStr(TreeView1.Selected.AbsoluteIndex)+'|'
           + TreeView1.Selected.Text+'|'
           + TKugel(OldSender).ParamPosX1+'|'
           + TKugel(OldSender).ParamPosX2+'|'
           + TKugel(OldSender).ParamPosX3+'|'
           + TKugel(OldSender).ParamRadius+'|'
           + TKugel(NewSender).ParamPosX1+'|'
           + TKugel(NewSender).ParamPosX2+'|'
           + TKugel(NewSender).ParamPosX3+'|'
           + TKugel(NewSender).ParamRadius+'|'
           + VectorToString(TKugel(OldSender).Material.FrontProperties.Diffuse.Color)+'|'
           + VectorToString(TKugel(NewSender).Material.FrontProperties.Diffuse.Color)+'|';
    If OldSender is TPunkt then
      Act:=Action+'|Punkt|'+BoolToStr(Visible)+'|'+IntToStr(TreeView1.Selected.AbsoluteIndex)+'|'
           + TreeView1.Selected.Text+'|'
           + TPunkt(OldSender).ParamPosX1+'|'
           + TPunkt(OldSender).ParamPosX2+'|'
           + TPunkt(OldSender).ParamPosX3+'|'
           + TPunkt(NewSender).ParamPosX1+'|'
           + TPunkt(NewSender).ParamPosX2+'|'
           + TPunkt(NewSender).ParamPosX3+'|'
           + VectorToString(TPunkt(OldSender).Material.FrontProperties.Diffuse.Color)+'|'
           + VectorToString(TPunkt(NewSender).Material.FrontProperties.Diffuse.Color)+'|';
    If OldSender is TOrtsLinie then
      Act:=Action+'|Ortslinie|'+BoolToStr(Visible)+'|'+IntToStr(TreeView1.Selected.AbsoluteIndex)+'|'
           + TreeView1.Selected.Text+'|'
           + TOrtsLinie(OldSender).Punkt+'|'
           + TOrtsLinie(NewSender).Punkt+'|'
           + TOrtsLinie(OldSender).Variable.Name +'|'
           + TOrtsLinie(NewSender).Variable.Name +'|'
           + FloatToStr(TOrtsLinie(OldSender).RangeTop) +'|'
           + FloatToStr(TOrtsLinie(NewSender).RangeTop) +'|'
           + FloatToStr(TOrtsLinie(OldSender).RangeBottom) +'|'
           + FloatToStr(TOrtsLinie(NewSender).RangeBottom) +'|'
           + IntToStr(TOrtsLinie(OldSender).Accuracy) +'|'
           + IntToStr(TOrtsLinie(NewSender).Accuracy) +'|'
           + VectorToString(TOrtsLinie(OldSender).LineColor.Color)+'|'
           + VectorToString(TOrtsLinie(NewSender).LineColor.Color)+'|';

    ActionList1.AddAction(Act);
  end;
end;

function ParameterToKoord(p,a,b: TVector3f): TVector4f;
var
  Vector: TVector3f;
begin
  Vector:=VectorCrossProduct(a,b);
  result[0]:=Vector[0];
  result[1]:=Vector[1];
  result[2]:=Vector[2];
  result[3]:=-VectorDotProduct(p,Vector);
end;

procedure OptimizeView(Grade: single);
var
  ZoomVector: TAffineVector;
begin
  MakeVector(ZoomVector, 1/Grade, 1/Grade, 1/Grade);
  With Form1 do begin
    Koordinates.Scale.AsAffineVector:=ZoomVector;
  end;
end;

procedure AdjustGrid(var Grid: TGLXYZGrid; ZoomGrade, GridScale: single);
begin
  Grid.XSamplingScale.Step:=ZoomGrade*GridScale;
  Grid.YSamplingScale.Step:=ZoomGrade*GridScale;
  Grid.ZSamplingScale.Step:=ZoomGrade*GridScale;
end;

procedure AdjustTicks(var TicksDummy: TGLDummyCube; ZoomGrade, GridScale: single);
var
  i, TickCount, Max, Min: integer;
  Ticks: TGLParticles;
  X, Y, Z{, Buf}: single;
  ZoomVector: TAffineVector;
  DirVector: TAffineVector;

begin
  MakeVector(ZoomVector, 1/(3), 1/(3), 1/(3));

//  Buf:=Round(5/ZoomGrade/GridScale)*GridScale;

// X1 - Richtung
  Ticks:=TGLParticles(TicksDummy.Children[0]);
  Max:=round(Form1.X1X2Grid.XSamplingScale.Max/(GridScale*ZoomGrade));
  Min:=round(Form1.X1X2Grid.XSamplingScale.Min/(GridScale*ZoomGrade));
  TickCount:=Max - Min - Ticks.Count + 2;
  If TickCount > 0 then
    for i:=1 to TickCount do
      Ticks.CreateParticle
  else begin
    for i:=1 to -TickCount do
      Ticks.KillParticle(Ticks.Children[Ticks.Count-1]);
  end;

  for i := Min to Max do
    With TGLSpaceText(Ticks.Children[i-Min+1]) do begin
      Position.Z := i*GridScale*ZoomGrade;
      Text:=Format('%.5g',[i*GridScale]);
    end;

  for i:=1 to Ticks.Count-1 do begin
    Ticks.Children[i].Up.AsAffineVector:=AffineVectorMake(0,1,0);
    X:=Form1.GLCamera1.Position.X-Ticks.Children[i].AbsolutePosition[0];
    Y:=Form1.GLCamera1.Position.Y-Ticks.Children[i].AbsolutePosition[1];
    Z:=Form1.GLCamera1.Position.Z-Ticks.Children[i].AbsolutePosition[2];
    DirVector:=Ticks.AbsoluteToLocal(AffineVectorMake(X, Y, Z));
    Ticks.Children[i].Direction.AsAffineVector:=DirVector;
    Ticks.Children[i].Scale.AsAffineVector:=ZoomVector;
  end;

// X2 - Richtung
  Ticks:=TGLParticles(TicksDummy.Children[1]);
  Max:=round(Form1.X1X2Grid.XSamplingScale.Max/(GridScale*ZoomGrade));
  Min:=round(Form1.X1X2Grid.XSamplingScale.Min/(GridScale*ZoomGrade));
  TickCount:=Max - Min - Ticks.Count + 2;
  If TickCount > 0 then
    for i:=1 to TickCount do
      Ticks.CreateParticle
  else begin
    for i:=1 to -TickCount do
      Ticks.KillParticle(Ticks.Children[Ticks.Count-1]);
  end;

  for i := Min to Max do
    With TGLSpaceText(Ticks.Children[i-Min+1]) do begin
      Position.X := i*GridScale*ZoomGrade;
      Text:=Format('%.5g',[i*GridScale]);
    end;

  for i:=1 to Ticks.Count-1 do begin
    Ticks.Children[i].Up.AsAffineVector:=AffineVectorMake(0,1,0);
    X:=Form1.GLCamera1.Position.X-Ticks.Children[i].AbsolutePosition[0];
    Y:=Form1.GLCamera1.Position.Y-Ticks.Children[i].AbsolutePosition[1];
    Z:=Form1.GLCamera1.Position.Z-Ticks.Children[i].AbsolutePosition[2];
    DirVector:=Ticks.AbsoluteToLocal(AffineVectorMake(X, Y, Z));
    Ticks.Children[i].Direction.AsAffineVector:=DirVector;
    Ticks.Children[i].Scale.AsAffineVector:=ZoomVector;
  end;

// X3 - Richtung
  Ticks:=TGLParticles(TicksDummy.Children[2]);
  Max:=round(Form1.X1X2Grid.XSamplingScale.Max/(GridScale*ZoomGrade));
  Min:=round(Form1.X1X2Grid.XSamplingScale.Min/(GridScale*ZoomGrade));
  TickCount:=Max - Min - Ticks.Count + 2;
  If TickCount > 0 then
    for i:=1 to TickCount do
      Ticks.CreateParticle
  else begin
    for i:=1 to -TickCount do
      Ticks.KillParticle(Ticks.Children[Ticks.Count-1]);
  end;

  for i := Min to Max do
    With TGLSpaceText(Ticks.Children[i-Min+1]) do begin
      Position.Y := i*GridScale*ZoomGrade;
      Text:=Format('%.5g',[i*GridScale]);
    end;

  for i:=1 to Ticks.Count-1 do begin
    Ticks.Children[i].Up.AsAffineVector:=AffineVectorMake(0,1,0);
    X:=Form1.GLCamera1.Position.X-Ticks.Children[i].AbsolutePosition[0];
    Y:=Form1.GLCamera1.Position.Y-Ticks.Children[i].AbsolutePosition[1];
    Z:=Form1.GLCamera1.Position.Z-Ticks.Children[i].AbsolutePosition[2];
    DirVector:=Ticks.AbsoluteToLocal(AffineVectorMake(X, Y, Z));
    Ticks.Children[i].Direction.AsAffineVector:=DirVector;
    Ticks.Children[i].Scale.AsAffineVector:=ZoomVector;
  end;

end;

procedure DoZoom(Grade: single);
var
  ZoomVector, V1: TAffineVector;
  i: integer;
begin
  MakeVector(ZoomVector, 1/Grade, 1/Grade, 1/Grade);
// Adjust lines according to zoom
    With Form1 do begin
      for i:=0 to Lines.Count-1 do begin
        TGerade(Lines.Children[i]).Scale.AsAffineVector:=ZoomVector;
      end;
// and Strecken >:o)
      for i:=1 to Strecken.Count-1 do begin
        TStrecke(Strecken.Children[i]).TopRadius:= GERADE_DICKE/Grade;
        TStrecke(Strecken.Children[i]).BottomRadius:= GERADE_DICKE/Grade;
      end;
// and points
      for i:=1 to Points.Count-1 do begin
//        TPunkt(Points.Children[i]).Radius:=PUNKT_RADIUS/Grade;
        TPunkt(Points.Children[i]).Scale.AsAffineVector:=ZoomVector;;

        // adjust the names
        V1:= VectorSubtract(Form1.GLCamera1.Position.AsAffineVector,
                            TPunkt(Points.Children[i]).Position.AsAffineVector);
        TPunkt(Points.Children[i]).Bezeichnung.Direction.AsAffineVector:= V1;
        TPunkt(Points.Children[i]).Bezeichnung.Up.AsVector:=VectorMake(0,1,0,1); //GLCamera1.AbsoluteUp;
      end;
// and planes
      for i:=1 to Planes.Count-1 do begin
        TEbene(Planes.Children[i]).Height := 14/Grade;
        TEbene(Planes.Children[i]).Width := 14/Grade;
        TEbene(Planes.Children[i]).AchsenschnittpunktX1.Radius:=PUNKT_RADIUS/Grade;
        TEbene(Planes.Children[i]).AchsenschnittpunktX2.Radius:=PUNKT_RADIUS/Grade;
        TEbene(Planes.Children[i]).AchsenschnittpunktX3.Radius:=PUNKT_RADIUS/Grade;
      end;
// and circles
      for i:=1 to Circles.Count-1 do begin
        TKreis(Circles.Children[i]).MinorRadius := GERADE_DICKE/Grade;
      end;
// zoom the grid
      AdjustGrid(X1X2Grid, Grade, Settings.FGrid.Scale);
      AdjustGrid(X1X3Grid, Grade, Settings.FGrid.Scale);
      AdjustGrid(X2X3Grid, Grade, Settings.FGrid.Scale);
      AdjustTicks(Ticks, Grade, Settings.FGrid.Scale);
// update the Zoom-display
      if Grade < 1 then begin
         Edit1.Text:='1';
         Edit2.Text:=Format('%0.5g',[1/Grade]);
         Edit3.Text:=Format('%0.5g',[Settings.FGrid.Scale]);
      end else begin
         Edit1.Text:=Format('%0.5g',[Grade]);
         Edit2.Text:='1';
         Edit3.Text:=Format('%0.5g',[Settings.FGrid.Scale]);
      end;
// and circles
      for i:=1 to Circles.Count-1 do begin
        TKreis(Circles.Children[i]).MinorRadius:= Settings.FGrid.Scale * GERADE_DICKE;;
      end;
    end;
end;

procedure AdjustNames;
var
  i: integer;
  V1, V2: TVector;
  vy: TVector;
//  VL: single;
//  l: single;
begin
 With Form1 do
  for i:=1 to Points.Count-1 do begin

    // adjust the names
    V2:= VectorSubtract(GLCamera1.AbsolutePosition, Points.Children[i].AbsolutePosition);
    V1:= VectorSubtract(GLCamera1.AbsolutePosition, TargetCube.Position.AsVector);
    VY:= VectorMake(0,1,0,1);

    TPunkt(Points.Children[i]).Bezeichnung.Up.AsVector:= vy;
    TPunkt(Points.Children[i]).Bezeichnung.Direction.AsVector:= DummyCube1.AbsoluteToLocal(V1);

{    l:= VectorLength(V1);
    NormalizeVector(V1);
    Vl:= 0.5*abs(VectorDotProduct(V2, V1))/l;
    TPunkt(Points.Children[i]).Bezeichnung.Scale.AsAffineVector:= AffineVectorMake(Vl, Vl, Vl);}
  end;
end;

procedure TForm1.GLSceneViewer1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  If not GLSceneViewer1.Focused then
    GLSceneViewer1.SetFocus;
  mdx:=x; mdy:=y;
  GLSceneViewer1.PopupMenu:=SichtMenu;
  If ssLeft in Shift then GLSceneViewer1.PopupMenu:=NIL;
end;

procedure TForm1.GLSceneViewer1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
 dx, dy: Integer;
 Target: TAffineVector;
begin
  dx:=mdx-x; dy:=mdy-y;
  mdx:=x; mdy:=y;
  TwoBZoom:=TwoBZoom+dy;
  if ssLeft in Shift then

//==  Two-Button-Zoom
    if ssRight in Shift then begin

      Target:=GLCamera1.Position.AsAffineVector;
      GLCamera1.Position.AsAffineVector:=VectorScale(Target, 1-dy/(Settings.FEnvironment.MouseSensity*10));
      AdjustNames;

//== Left-Button-Rotate
    end else if not (ssShift in Shift) then begin
        GLCamera1.MoveAroundTarget(dy*(ROTATE_SENSITY*Settings.FEnvironment.MouseSensity), dx*(ROTATE_SENSITY*Settings.FEnvironment.MouseSensity));
        AdjustTicks(Ticks, Objects.Scale.X, Settings.FGrid.Scale);
        AdjustNames;
      end else
        GLCamera1.RotateObject(DummyCube1, dy*ROTATE_SENSITY*Settings.FEnvironment.MouseSensity*0.1, dx*ROTATE_SENSITY*Settings.FEnvironment.MouseSensity*0.1);

//== Middle-Button-Drag
  if ssMiddle in Shift then begin
    MoveCamWithTarget(GLCamera1, TargetCube, dx*(Settings.FEnvironment.MouseSensity*DRAG_SENSITY), -dy*(Settings.FEnvironment.MouseSensity*DRAG_SENSITY));
    AdjustTicks(Ticks, Objects.Scale.X, ActualGridScale);
  end;  
end;

procedure TForm1.FormMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
var
  Target: TAffineVector;
begin
 If (ssShift in Shift) then begin // Maßstab scale
  If (MousePos.X>PanelLeft.Width) and (MousePos.Y > Panel1.Height+38) and
     (MousePos.X<GLSceneViewer1.Width+PanelLeft.Width) and (MousePos.Y < (GLSceneViewer1.Height+Panel1.Height+38)) then begin
      Settings.FEnvironment.Massstab:= Settings.FEnvironment.Massstab*power(2, sign(WheelDelta));
      Settings.FGrid.Scale:= 1/Settings.FEnvironment.Massstab;
      Settings.NotifyChanges;
  end
 end else begin  // Camera move
  If (MousePos.X>PanelLeft.Width) and (MousePos.Y > Panel1.Height+38) and
     (MousePos.X<GLSceneViewer1.Width+PanelLeft.Width) and (MousePos.Y < (GLSceneViewer1.Height+Panel1.Height+38)) then begin
//    GLCamera1.SceneScale:=GLCamera1.SceneScale+wheeldelta/1000;
    If GLCamera1.CameraStyle = csPerspective then begin
      Target:=GLCamera1.Position.AsAffineVector;
      GLCamera1.Position.AsAffineVector:=VectorScale(Target, 1-wheeldelta/1000);
    end else
      If GLCamera1.CameraStyle = csOrthogonal then begin
        GLCamera1.SceneScale:=GLCamera1.SceneScale*(1+wheeldelta/1000);
      end;
    AdjustNames;
  end
 end;
 Handled:= True;
end;

procedure TForm1.SetEbene(Ebene: TEbene; pos, dir: TVector3f);
var
  p: TVector3f;
begin
  With Ebene do begin
    Position.AsAffineVector:=pos;
    Direction.AsAffineVector:=dir;

//== Werte speichern
    Aufpunkt[0]:=Pos[2];
    Aufpunkt[1]:=Pos[0];
    Aufpunkt[2]:=Pos[1];
    NormalenVektor[0]:=Dir[2];
    NormalenVektor[1]:=Dir[0];
    NormalenVektor[2]:=Dir[1];
    Achsenabschnitte[0]:=VectorDotProduct(Dir, Pos)/Dir[2];
    Achsenabschnitte[1]:=VectorDotProduct(Dir, Pos)/Dir[0];
    Achsenabschnitte[2]:=VectorDotProduct(Dir, Pos)/Dir[1];

  end;

//== Achsenschnittpunkte
  SetVector(p,0,0,Ebene.Achsenabschnitte[0]);
//  SubtractVector(p, Ebene.Position.AsAffineVector);
  ScaleVector(p, Settings.FEnvironment.Massstab);
  p:=Ebene.AbsoluteToLocal(DummyCube1.LocalToAbsolute(p));
  SetKugel(TKugel(Ebene.AchsenschnittpunktX1),p,PUNKT_RADIUS);
  SetVector(Ebene.AchsenschnittpunktX1.Koordinaten, Ebene.Achsenabschnitte[0],0,0);
  SetVector(p,Ebene.Achsenabschnitte[1],0,0);
//  SubtractVector(p, Ebene.Position.AsAffineVector);
  ScaleVector(p, Settings.FEnvironment.Massstab);
  p:=Ebene.AbsoluteToLocal(DummyCube1.LocalToAbsolute(p));
  SetKugel(TKugel(Ebene.AchsenschnittpunktX2),p,PUNKT_RADIUS);
  SetVector(Ebene.AchsenschnittpunktX2.Koordinaten,0, Ebene.Achsenabschnitte[1],0);
  SetVector(p,0,Ebene.Achsenabschnitte[2],0);
//  SubtractVector(p, Ebene.Position.AsAffineVector);
  ScaleVector(p, Settings.FEnvironment.Massstab);
  p:=Ebene.AbsoluteToLocal(DummyCube1.LocalToAbsolute(p));
  SetKugel(TKugel(Ebene.AchsenschnittpunktX3),p,PUNKT_RADIUS);
  SetVector(Ebene.AchsenschnittpunktX3.Koordinaten, 0,0,Ebene.Achsenabschnitte[2]);

  ZeigeDaten(Ebene, Memo1);
end;

procedure TForm1.NewEbene(n1,n2,n3,n0: single);
var
  Dir, Pos: TVector3f;
  VLength: single;
  Node: TGLNode;
  Vector: TVector4f;
  i: integer;
begin

//== Neue Ebene als Particle erzeugen
  With TEbene(Planes.CreateParticle) do begin
    Material.FaceCulling:=fcNoCull;
    SetVector(Vector,Random,Random,Random,0.8);
    Material.FrontProperties.Diffuse.Color:=Vector;
    Material.BackProperties.Diffuse.Color:=Vector;
    AchsenschnittpunktX1:=TPunkt(AddNewChild(TPunkt));
    AchsenschnittpunktX2:=TPunkt(AddNewChild(TPunkt));
    AchsenschnittpunktX3:=TPunkt(AddNewChild(TPunkt));
    With AchsenschnittpunktX1.Material.FrontProperties.Diffuse  do begin
     Red := 1 - Material.FrontProperties.Diffuse.Red;
     Blue := 1 - Material.FrontProperties.Diffuse.Blue;
     Green := 1 - Material.FrontProperties.Diffuse.Green;
    end;
    With AchsenschnittpunktX2.Material.FrontProperties.Diffuse  do begin
     Red := 1 - Material.FrontProperties.Diffuse.Red;
     Blue := 1 - Material.FrontProperties.Diffuse.Blue;
     Green := 1 - Material.FrontProperties.Diffuse.Green;
    end;
    With AchsenschnittpunktX3.Material.FrontProperties.Diffuse  do begin
     Red := 1 - Material.FrontProperties.Diffuse.Red;
     Blue := 1 - Material.FrontProperties.Diffuse.Blue;
     Green := 1 - Material.FrontProperties.Diffuse.Green;
    end;

//== Direction und Position initialisieren(Umgekehrte Achsen beachten)
   VLength:=VectorLength(n1,n2,n3);
    SetVector(pos, -n2*n0/(VLength*VLength), -n3*n0/(VLength*VLength), -n1*n0/(VLength*VLength));
    SetVector(Dir, n2,n3,n1);
    Pos[0]:=round(pos[0]*1000000)/1000000;  // runden auf 6 stellen
    Pos[1]:=round(pos[1]*1000000)/1000000;
    Pos[2]:=round(pos[2]*1000000)/1000000;
    ParamPosX1:=MakeNiceNumber(pos[2]);
    ParamPosX2:=MakeNiceNumber(pos[0]);
    ParamPosX3:=MakeNiceNumber(pos[1]);
    ParamDirX1:=MakeNiceNumber(n1);
    ParamDirX2:=MakeNiceNumber(n2);
    ParamDirX3:=MakeNiceNumber(n3);
    Param_N0:=MakeNiceNumber(n0);

//== Ebene registrieren
    i:=0;
    while TreeView1.Items[i].Text<>'Ebenen' do
      i:=i+1;
    Node:=TGLNode(TreeView1.Items[i]);
    Node:=TGLNode(TreeView1.Items.AddChild(Node, 'E'+IntToStr(Planes.Count-1)));
    Node.LinkedObject:=Planes.Children[Planes.Count-1];
    Node.ImageIndex:=3;
    Node:=TGLNode(TreeView1.Items.AddChild(Node,'SX1'));
    Node.LinkedObject:=Planes.Children[Planes.Count-1].Children[0];
    Node.ImageIndex:=1;
    Node:=TGLNode(TreeView1.Items.Add(Node,'SX2'));
    Node.LinkedObject:=Planes.Children[Planes.Count-1].Children[1];
    Node.ImageIndex:=1;
    Node:=TGLNode(TreeView1.Items.Add(Node,'SX3'));
    Node.LinkedObject:=Planes.Children[Planes.Count-1].Children[2];
    Node.ImageIndex:=1;
    Node.Parent.Selected:=True;

//== ObjectName setzen
    ObjectName:=Node.Text;

  end;{With Ebene...}

//== Ebene zeichnen
  DoZoom(Objects.Scale.X);
  SetEbene(TEbene(Planes.Children[Planes.Count-1]), pos, dir);
end;

procedure TForm1.NewEbene(p1,p2,p3,a1,a2,a3,b1,b2,b3: single);
var
  p,a,b: TVector3f;
begin
  SetVector(p,p1,p2,p3);
  SetVector(a,a1,a2,a3);
  SetVector(b,b1,b2,b3);
  NewEbene(ParameterToKoord(p,a,b)[0],ParameterToKoord(p,a,b)[1],ParameterToKoord(p,a,b)[2],ParameterToKoord(p,a,b)[3]);
end;

procedure TForm1.NewEbene(p1,p2,p3,n1,n2,n3: single);
var
  v1, v2: TVector3f;
begin
  SetVector(v1,p1,p2,p3);
  SetVector(v2, n1,n2,n3);
  NewEbene(n1,n2,n3,-VectorDotProduct(v1,v2));
end;

procedure TForm1.SetGerade(Gerade: TGerade; pos, dir: TVector3f);
begin
  With Gerade do begin
    Position.AsAffineVector:=pos;
    Up.AsAffineVector:=dir;

//== Werte speichern
    Aufpunkt[0]:=Pos[2];
    Aufpunkt[1]:=Pos[0];
    Aufpunkt[2]:=Pos[1];
    RichtungsVektor[0]:=Dir[2];
    RichtungsVektor[1]:=Dir[0];
    RichtungsVektor[2]:=Dir[1];

  end;

//== Daten zeigen und Position optimieren
  ZeigeDaten(Gerade,Memo1);
  OptimiereGerade(Gerade);
end;

procedure TForm1.NewGerade(p1,p2,p3,v1,v2,v3: single);
var
  pos, dir: TVector3f;
  Node: TGLNode;
  i: integer;

begin
//== Neue Gerade erstellen
  With TGerade(Lines.AddNewChild(TGerade)) do begin
    BottomRadius:=GERADE_DICKE; TopRadius:=GERADE_DICKE;
    Height:=GERADE_LANGE;
    Material.FrontProperties.Diffuse.Color:=VectorMake(Random, Random, Random,1);

    Richtung:=TGLCone(AddNewChild(TGLCone));
    Richtung.Scale.AsAffineVector:=AffineVectorMake(0.2,0.2,0.2);
    Richtung.Position.Y:=Richtung.Position.Y+1;
    Richtung.Material:=Material;
    Richtung.Visible:=False;

//== Direction und Position initialisieren
    SetVector(pos, p2,p3,p1);
    SetVector(dir, v2,v3,v1);
    ParamPosX1:= MakeNiceNumber(p1);
    ParamPosX2:= MakeNiceNumber(p2);
    ParamPosX3:= MakeNiceNumber(p3);
    ParamDirX1:= MakeNiceNumber(v1);
    ParamDirX2:= MakeNiceNumber(v2);
    ParamDirX3:= MakeNiceNumber(v3);

//== Gerade registrieren
    i:=0;
    while TreeView1.Items[i].Text<>'Geraden' do
      i:=i+1;
    Node:=TGLNode(TreeView1.Items[i]);
    Node:=TGLNode(TreeView1.Items.AddChild(Node, 'g'+IntToStr(Lines.Count)));
    Node.LinkedObject:=Lines.Children[Lines.Count-1];
    Node.ImageIndex:=2;
    Node.Selected:=True;

//== ObjectName setzen
    ObjectName:=Node.Text;

  end;{With Gerade...}

//== Gerade zeichnen
  DoZoom(Objects.Scale.X);
  SetGerade(TGerade(Lines.Children[Lines.Count-1]),pos,dir);
end;

procedure TForm1.NewGerade(p1,p2,p3,v1,v2,v3: single; Parent1, Parent2: string; CreationMode: string);
begin
  NewGerade(p1,p2,p3,v1,v2,v3);
  TGerade(Lines.Children[Lines.Count-1]).Parents.Add(Parent1);
  TGerade(Lines.Children[Lines.Count-1]).Parents.Add(Parent2) ;
  TGerade(Lines.Children[Lines.Count-1]).CreationMode:=CreationMode;
end;

procedure TForm1.SetStrecke(Strecke: TStrecke; p1, p2: TVector3f);
begin
  With Strecke do begin
    Position.AsAffineVector:=VectorScale(VectorAdd(p1,p2),0.5);
    Up.AsAffineVector:=VectorSubtract(p2,p1);
    Height:=VectorLength(VectorSubtract(p2,p1));

//== Werte speichern
    AnfangsPunkt[0]:=P1[2];
    AnfangsPunkt[1]:=P1[0];
    AnfangsPunkt[2]:=P1[1];
    EndPunkt[0]:=P2[2];
    EndPunkt[1]:=P2[0];
    EndPunkt[2]:=P2[1];

  end;

//== Daten zeigen und Position optimieren
  ZeigeDaten(Strecke,Memo1);

end;

procedure TForm1.NewStrecke(p1,p2,p3,q1,q2,q3: single);
var
  pI, pII: TVector3f;
  Node: TGLNode;
  i: integer;

begin

//== Neue Strecke erstellen
  With TStrecke(Strecken.AddNewChild(TStrecke)) do begin

//== Direction und Position initialisieren
    SetVector(pI, p2,p3,p1);
    SetVector(pII, q2,q3,q1);
    ParamP1X1:=MakeNiceNumber(p1);
    ParamP1X2:=MakeNiceNumber(p2);
    ParamP1X3:=MakeNiceNumber(p3);
    ParamP2X1:=MakeNiceNumber(q1);
    ParamP2X2:=MakeNiceNumber(q2);
    ParamP2X3:=MakeNiceNumber(q3);

    BottomRadius:=GERADE_DICKE; TopRadius:=GERADE_DICKE;
    Height:=VectorLength(VectorSubtract(pII,pI));
    Material.FrontProperties.Diffuse.Color:=VectorMake(Random, Random, Random,1);

    Richtung:=TGLCone(AddNewChild(TGLCone));
    Richtung.Scale.AsAffineVector:=AffineVectorMake(0.2,0.2,0.2);
    Richtung.Position.Y:=Richtung.Position.Y+1;
    Richtung.Material:=Material;
    Richtung.Visible:=False;

//== Gerade registrieren
    i:=0;
    while TreeView1.Items[i].Text<>'Strecken' do
      i:=i+1;
    Node:=TGLNode(TreeView1.Items[i]);
    Node:=TGLNode(TreeView1.Items.AddChild(Node, 's'+IntToStr(Strecken.Count-1)));
    Node.LinkedObject:=Strecken.Children[Strecken.Count-1];
    Node.ImageIndex:=5;
    Node.Selected:=True;

//== ObjectName setzen
    ObjectName:=Node.Text;

  end;{With Strecke...}

//== Gerade zeichnen
  DoZoom(Objects.Scale.X);
  SetStrecke(TStrecke(Strecken.Children[Strecken.Count-1]),pI,pII);

end;

procedure TForm1.NewStrecke(p1, p2, p3, q1, q2, q3: single; Parent1, Parent2, CreationMode: string);
begin
  NewStrecke(p1, p2, p3, q1, q2, q3);
  AddObjParent(Strecken.Children[Strecken.Count-1], Parent1);
  AddObjParent(Strecken.Children[Strecken.Count-1], Parent2);
  SetObjCreationMode(Strecken.Children[Strecken.Count-1], CreationMode);
end;

procedure TForm1.SetKreis(Kreis: TKreis; pos, dir: TVector3f; r: single);
begin
  Kreis.Position.AsAffineVector:= pos;
  Kreis.Direction.AsAffineVector:= dir;
  Kreis.MajorRadius:= r;
  Kreis.MinorRadius:= GERADE_DICKE;
  ZeigeDaten(Kreis, Memo1);
end;

procedure TForm1.NewKreis(p1, p2, p3, d1, d2, d3, r: single);
var
  Vector: TVector;
  pos, dir: TAffineVector;
  i: integer;
  Node: TGLNode;
begin
//== Erstelle Kreis als Parikel
  With TKreis(Circles.CreateParticle) do begin
    Material.FaceCulling:= fcNoCull;
    SetVector(Vector, Random, Random, Random, 0.8);
    Material.FrontProperties.Diffuse.Color:= Vector;
    SetVector(pos, p2,p3,p1);
    SetVector(dir, d2,d3,d1);
    ParamPosX1:=MakeNiceNumber(p1);
    ParamPosX2:=MakeNiceNumber(p2);
    ParamPosX3:=MakeNiceNumber(p3);
    ParamDirX1:=MakeNiceNumber(d1);
    ParamDirX2:=MakeNiceNumber(d2);
    ParamDirX3:=MakeNiceNumber(d3);
    ParamRadius:=MakeNiceNumber(r);
    MajorRadius := r;
    Rings:=100; Sides:=25;

//== Kreis registrieren
    i:=0;
    while TreeView1.Items[i].Text<>'Kreise' do
      i:=i+1;
    Node:=TGLNode(TreeView1.Items[i]);
    Node:=TGLNode(TreeView1.Items.AddChild(Node, 'k'+IntToStr(Circles.Count-1)));
    Node.LinkedObject:=Circles.Children[Circles.Count-1];
    Node.ImageIndex:=6;
    Node.Selected:=True;

//== ObjectName setzen
    ObjectName:=Node.Text;

  end;{With Kreis...}

//== Kreis zeichnen
  DoZoom(Objects.Scale.X);
  SetKreis(TKreis(Circles.Children[Circles.Count-1]),pos, dir, r);
end;

procedure TForm1.NewPunkt(p1,p2,p3: single);
var pos: TVector3f;
    Node: TGLNode;

begin
//== Punkt als Partikel erzeugen
  With TPunkt(Points.CreateParticle) do begin
   Material.FrontProperties.Diffuse.Color:=VectorMake(Random, Random, Random, 1);
   SetVector(pos, p2,p3,p1);
   ParamPosX1:=MakeNiceNumber(p1);
   ParamPosX2:=MakeNiceNumber(p2);
   ParamPosX3:=MakeNiceNumber(p3);
   Bezeichnung:=TGLSpaceText(Points.Children[Points.Count-1].AddNewChild(TGLSpaceText));                       // *F*
   Bezeichnung.Text :='P'+IntToStr(Points.Count-1);
   Bezeichnung.Material.FrontProperties := Material.FrontProperties;
   Bezeichnung.Material.FrontProperties.Diffuse.Alpha:=0.8;
   Bezeichnung.Scale.SetVector(0.3,0.3,0.3);
   Bezeichnung.Extrusion :=0.08;
   Bezeichnung.Position.SetPoint(0.1,-0.3,0);

//== Punkt registrieren
    Node:=TGLNode(TreeView1.Items.AddChild(TreeView1.Items[0], 'P'+IntToStr(Points.Count-1)));
    Node.LinkedObject:=Points.Children[Points.Count-1];
    Node.ImageIndex:=1;
    Node.Selected:=True;

//== ObjectName setzen
    ObjectName:=Node.Text;

  end;{With Punkt...}

//== Punkt zeichnen
  DoZoom(Objects.Scale.X);
  SetKugel(TKugel(Points.Children[Points.Count-1]),pos,PUNKT_RADIUS);
end;

procedure TForm1.NewPunkt(p1,p2,p3: single; Parent1, Parent2, Parent3: string; CreationMode: string);
begin
  NewPunkt(p1,p2,p3);
  TPunkt(Points.Children[Points.Count-1]).Parents.Add(Parent1);
  TPunkt(Points.Children[Points.Count-1]).Parents.Add(Parent2);
  TPunkt(Points.Children[Points.Count-1]).Parents.Add(Parent3);
  TPunkt(Points.Children[Points.Count-1]).CreationMode:=CreationMode;
end;

procedure TForm1.SetKugel(Kugel: TKugel; pos: TVector3f; r: Single);
begin
  if Kugel.ClassName='TPunkt' then begin
    With TPunkt(Kugel) do begin
      Position.AsAffineVector:=pos;
      Koordinaten:=AffineVectorMake(pos[2], pos[0], pos[1]);
      Radius:=PUNKT_RADIUS;
    end;
    ZeigeDaten(TPunkt(Kugel), Memo1);
  end else begin
    With Kugel do begin
      Position.AsAffineVector:=pos;
      Koordinaten:=AffineVectorMake(pos[2], pos[0], pos[1]);
      Radius:=r;
    end;
    ZeigeDaten(Kugel,Memo1);
  end;
end;


procedure TForm1.NewKugel(m1,m2,m3,r: Single);
var pos: TVector3f;
    Node: TGLNode;
    i: integer;
    Vector: TVector;

begin
//== Erstelle Kugel als Parikel
  With TKugel(Spheres.CreateParticle) do begin
    Material.FaceCulling:= fcCull;
    SetVector(Vector, Random, Random, Random, 0.8);
    Material.FrontProperties.Diffuse.Color:= Vector;
    SetVector(pos, m2,m3,m1);
    ParamPosX1:=MakeNiceNumber(m1);
    ParamPosX2:=MakeNiceNumber(m2);
    ParamPosX3:=MakeNiceNumber(m3);
    ParamRadius:=MakeNiceNumber(r);
    Radius := r;

//== Kugel registrieren
    i:=0;
    while TreeView1.Items[i].Text<>'Kugeln' do
      i:=i+1;
    Node:=TGLNode(TreeView1.Items[i]);
    Node:=TGLNode(TreeView1.Items.AddChild(Node, 'K'+IntToStr(Spheres.Count-1)));
    Node.LinkedObject:=Spheres.Children[Spheres.Count-1];
    Node.ImageIndex:=4;
    Node.Selected:=True;

//== ObjectName setzen
    ObjectName:=Node.Text;

  end;{With Kugel...}

//== Kugel zeichnen
  DoZoom(Objects.Scale.X);
  SetKugel(TKugel(Spheres.Children[Spheres.Count-1]),pos,r);
end;

procedure TForm1.Ebene1Click(Sender: TObject);
begin
  Form2.Show;
end;

procedure AdjustLabels;
var
  i: integer;
  s: string;
begin
  With Form1 do begin
    KameraPosition.Caption:='Kamera - '+#10#13+'Position';

    s:=X1Rotation.Caption;
    for i:=Length(s) downto 4 do
      If i mod 2 = 1 then
        Insert(#10#13, s, i);
    X1Rotation.Caption:=s;

    s:=X3Rotation.Caption;
    for i:=Length(s) downto 4 do
      If i mod 2 = 1 then
        Insert(#10#13, s, i);
    X3Rotation.Caption:=s;

  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  s: string;
begin
  Randomize;

  ActionList1:=TActionsList.Create;

//== Create Settings
  Settings:=TSetting.Create;

//== Do changes to the labels where required
  AdjustLabels;

//== Set View
  DefDir:=Dummycube1.Direction.AsVector;
  DefUp:=DummyCube1.Up.AsVector;

//== Setup Grid
  AdjustGrid(X1X2Grid, 1, ActualGridScale);

//== Initialize Objects
  With TEbene(Planes.AddNewChild(TEbene)) do begin
    Height:=11; Width:=11;
    Material.BlendingMode:=bmTransparency;
  end;
  With TStrecke(Strecken.AddNewChild(TStrecke)) do begin
    Material.BlendingMode:=bmTransparency;
  end;
  With TPunkt(Points.AddNewChild(TPunkt)) do begin
    Radius := 0.05;
    Bezeichnung := TGLSpaceText.Create(DummyCube1);
    Bezeichnung.Text := 'P';
    Bezeichnung.Scale.SetVector(0.5,0.5,0.5);
    Bezeichnung.Extrusion :=0.08;
    Bezeichnung.Position.X := 0.1;
    Bezeichnung.Position.Y := -0.1;
    Bezeichnung.Material.BlendingMode:=bmTransparency;
  end;

  Circles.AddNewChild(TKreis);

  OrtsLinien.AddNewChild(TOrtsLinie);

  With TKugel(Spheres.AddNewChild(TKugel)) do begin
    Material.BlendingMode:=bmTransparency;
    Slices:=50; Stacks:=50;
  end;

// Initialize the ParamForms
  ParamForms:=TComponent.Create(Form1);

// Load settings
  LoadSettings;

// Load from Command Line
  s := ParamStr(1);
  If s='-acttest' then begin
    Tag:=1;
    Delete(s, Pos('-acttest', s), 9);
    s:= ParamStr(2);
  end;

  If s<>'' then
    try
      If UpperCase(Copy(s, Length(s)-2, 3))='VEC' then
        LoadFile(s)
      else begin
        ActionList1.LoadFromFile(s);
        ActionList1.RedoAllActions;
      end;
    except
      ShowMessage('Ein Fehler beim laden ist eingetreten. Beschweren Sie sich bitte sofort beim Programmierer!');
    end;

// Adjust SceneScale to ScreenSize
  GLCamera1.SceneScale:= ST_SCENE_SCALE / 1160 * Form1.Width;

  DoZoom(1);
end;

procedure TForm1.TreeView1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
    MenuItem: TMenuItem;
    i: integer;

begin
  Memo1.Lines.Clear;
//== Right-Click Selection
  If (ssRight in Shift) and (htOnItem in TreeView1.GetHitTestInfoAt(X,Y)) then
    TreeView1.GetNodeAt(X, Y).Selected := True;

//== When nothing is selected, un-select the previous selected items
  If not (htOnItem in TreeView1.GetHitTestInfoAt(X,Y)) and (TreeView1.SelectionCount > 0) then begin
    TreeView1.Selections[0].Selected:=False;{check ich net!!!}
    TreeView1.PopupMenu:= NIL;
  end;

//== Highlight Selected Objects
  SetLength(SelectedObjects, TreeView1.SelectionCount);
  for i:=0 to TreeView1.SelectionCount-1 do
//    SelectedObjects[i]:=TGLNode(TreeView1.Selections[i]).LinkedObject as TGLSceneObject;
    SelectedObjects[i]:=TGLSceneObject(FindObject(TreeView1.Selections[i].Text));
  HighLight(2);

//== MultiSelection
  If TreeView1.SelectionCount > 1 then begin
    MultiSelectMenu.Items.Clear;
    MenuItem := TMenuItem.Create(Self);
    MenuItem.Caption := 'Objekte schneiden';
    MenuItem.OnClick := ObjekteSchneiden;
    MultiSelectMenu.Items.Add(MenuItem);
    if TreeView1.SelectionCount = 2 then begin
      if (TreeView1.Selections[0].ImageIndex = 1) and (TreeView1.Selections[1].ImageIndex = 1)then begin
        MenuItem := TMenuItem.Create(Self);
        MenuItem.Caption := '-';
        MultiSelectMenu.Items.Add(MenuItem);
        MenuItem := TMenuItem.Create(Self);
        MultiSelectMenu.Items.Add(MenuItem);
        MenuItem.Caption := 'Gerade durch ' + TreeView1.Selections[1].Text + ' und '+TreeView1.Selections[0].Text+' erstellen';
        MenuItem.OnClick := GeradeDurch2Punkte;
        MenuItem := TMenuItem.Create(Self);
        MultiSelectMenu.Items.Add(MenuItem);
        MenuItem.Caption := 'Strecke zwischen ' + TreeView1.Selections[1].Text + ' und '+TreeView1.Selections[0].Text+' erstellen';
        MenuItem.OnClick := StreckeDurch2Punkte;
      end;
      if ((TreeView1.Selections[0].ImageIndex = 2) and (TreeView1.Selections[1].ImageIndex = 1))
      or ((TreeView1.Selections[0].ImageIndex = 1) and (TreeView1.Selections[1].ImageIndex = 2)) then begin
        MenuItem := TMenuItem.Create(Self);
        MenuItem.Caption := '-';
        MultiSelectMenu.Items.Add(MenuItem);
        MenuItem := TMenuItem.Create(Self);
        MultiSelectMenu.Items.Add(MenuItem);
        MenuItem.Caption := 'Ebene durch ' + TreeView1.Selections[1].Text + ' und '+TreeView1.Selections[0].Text+' erstellen';
        MenuItem.OnClick := EbeneDurchPunktGerade;
      end;
      if ((TreeView1.Selections[0].ImageIndex = 1) and (TreeView1.Selections[1].ImageIndex = 1)) then begin
        MenuItem := TMenuItem.Create(Self);
        MenuItem.Caption := '-';
        MultiSelectMenu.Items.Add(MenuItem);
        MenuItem := TMenuItem.Create(Self);
        MultiSelectMenu.Items.Add(MenuItem);
        MenuItem.Caption := 'Abstand zwischen den Punkten ' + TreeView1.Selections[1].Text + ' und '+TreeView1.Selections[0].Text+' bestimmen';
        MenuItem.OnClick := Abstand2PunkteBestimmen;
      end;
      if ((TreeView1.Selections[0].ImageIndex = 1) and (TreeView1.Selections[1].ImageIndex = 2)) then begin
        MenuItem := TMenuItem.Create(Self);
        MenuItem.Caption := '-';
        MultiSelectMenu.Items.Add(MenuItem);
        MenuItem := TMenuItem.Create(Self);
        MultiSelectMenu.Items.Add(MenuItem);
        MenuItem.Caption := 'Abstand zwischen dem Punkt ' + TreeView1.Selections[0].Text + ' und der Geraden '+TreeView1.Selections[1].Text+' bestimmen';
        MenuItem.OnClick := AbstandPunktGeradeBestimmen;
      end;
      if ((TreeView1.Selections[0].ImageIndex = 2) and (TreeView1.Selections[1].ImageIndex = 1)) then begin
        MenuItem := TMenuItem.Create(Self);
        MenuItem.Caption := '-';
        MultiSelectMenu.Items.Add(MenuItem);
        MenuItem := TMenuItem.Create(Self);
        MultiSelectMenu.Items.Add(MenuItem);
        MenuItem.Caption := 'Abstand zwischen der Geraden ' + TreeView1.Selections[0].Text + ' und dem Punkt '+TreeView1.Selections[1].Text+' bestimmen';
        MenuItem.OnClick := AbstandGeradePunktBestimmen;
      end;
      if ((TreeView1.Selections[0].ImageIndex = 2) and (TreeView1.Selections[1].ImageIndex = 2)) then begin
        MenuItem := TMenuItem.Create(Self);
        MenuItem.Caption := '-';
        MultiSelectMenu.Items.Add(MenuItem);
        MenuItem := TMenuItem.Create(Self);
        MultiSelectMenu.Items.Add(MenuItem);
        MenuItem.Caption := 'Abstand zwischen den Geraden ' + TreeView1.Selections[1].Text + ' und '+TreeView1.Selections[0].Text+' bestimmen';
        MenuItem.OnClick := Abstand2GeradenBestimmen;
      end;
      if ((TreeView1.Selections[0].ImageIndex = 1) and (TreeView1.Selections[1].ImageIndex = 3)) then begin
        MenuItem := TMenuItem.Create(Self);
        MenuItem.Caption := '-';
        MultiSelectMenu.Items.Add(MenuItem);
        MenuItem := TMenuItem.Create(Self);
        MultiSelectMenu.Items.Add(MenuItem);
        MenuItem.Caption := 'Abstand zwischen dem Punkt ' + TreeView1.Selections[0].Text + ' und der Ebene '+TreeView1.Selections[1].Text+' bestimmen';
        MenuItem.OnClick := AbstandPunktEbeneBestimmen;
      end;
      if ((TreeView1.Selections[0].ImageIndex = 3) and (TreeView1.Selections[1].ImageIndex = 1)) then begin
        MenuItem := TMenuItem.Create(Self);
        MenuItem.Caption := '-';
        MultiSelectMenu.Items.Add(MenuItem);
        MenuItem := TMenuItem.Create(Self);
        MultiSelectMenu.Items.Add(MenuItem);
        MenuItem.Caption := 'Abstand zwischen der Ebene ' + TreeView1.Selections[0].Text + ' und dem Punkt '+TreeView1.Selections[1].Text+' bestimmen';
        MenuItem.OnClick := AbstandEbenePunktBestimmen;
      end;
      if ((TreeView1.Selections[0].ImageIndex = 2) and (TreeView1.Selections[1].ImageIndex = 3)) then begin
        MenuItem := TMenuItem.Create(Self);
        MenuItem.Caption := '-';
        MultiSelectMenu.Items.Add(MenuItem);
        MenuItem := TMenuItem.Create(Self);
        MultiSelectMenu.Items.Add(MenuItem);
        MenuItem.Caption := 'Abstand zwischen der Geraden ' + TreeView1.Selections[0].Text + ' und der Ebene '+TreeView1.Selections[1].Text+' bestimmen';
        MenuItem.OnClick := AbstandGeradeEbeneBestimmen;
        MenuItem := TMenuItem.Create(Self);
        MenuItem.Caption := '-';
        MultiSelectMenu.Items.Add(MenuItem);
        MenuItem := TMenuItem.Create(Self);
        MultiSelectMenu.Items.Add(MenuItem);
        MenuItem.Caption := 'Winkel zwischen der Geraden ' + TreeView1.Selections[0].Text + ' und der Ebene '+TreeView1.Selections[1].Text+' bestimmen';
        MenuItem.OnClick := WinkelGeradeEbeneBestimmen;
      end;
      if ((TreeView1.Selections[0].ImageIndex = 3) and (TreeView1.Selections[1].ImageIndex = 2)) then begin
        MenuItem := TMenuItem.Create(Self);
        MenuItem.Caption := '-';
        MultiSelectMenu.Items.Add(MenuItem);
        MenuItem := TMenuItem.Create(Self);
        MultiSelectMenu.Items.Add(MenuItem);
        MenuItem.Caption := 'Abstand zwischen der Ebene ' + TreeView1.Selections[0].Text + ' und der Geraden '+TreeView1.Selections[1].Text+' bestimmen';
        MenuItem.OnClick := AbstandEbeneGeradeBestimmen;
        MenuItem := TMenuItem.Create(Self);
        MenuItem.Caption := '-';
        MultiSelectMenu.Items.Add(MenuItem);
        MenuItem := TMenuItem.Create(Self);
        MultiSelectMenu.Items.Add(MenuItem);
        MenuItem.Caption := 'Winkel zwischen der Ebene ' + TreeView1.Selections[0].Text + ' und der Geraden '+TreeView1.Selections[1].Text+' bestimmen';
        MenuItem.OnClick := WinkelEbeneGeradeBestimmen;
      end;
      if ((TreeView1.Selections[0].ImageIndex = 2) and (TreeView1.Selections[1].ImageIndex = 2)) then begin
        MenuItem := TMenuItem.Create(Self);
        MenuItem.Caption := '-';
        MultiSelectMenu.Items.Add(MenuItem);
        MenuItem := TMenuItem.Create(Self);
        MultiSelectMenu.Items.Add(MenuItem);
        MenuItem.Caption := 'Winkel zwischen den Geraden ' + TreeView1.Selections[1].Text + ' und '+TreeView1.Selections[0].Text+' bestimmen';
        MenuItem.OnClick := Winkel2GeradenBestimmen;
      end;
      if ((TreeView1.Selections[0].ImageIndex = 3) and (TreeView1.Selections[1].ImageIndex = 3)) then begin
        MenuItem := TMenuItem.Create(Self);
        MenuItem.Caption := '-';
        MultiSelectMenu.Items.Add(MenuItem);
        MenuItem := TMenuItem.Create(Self);
        MultiSelectMenu.Items.Add(MenuItem);
        MenuItem.Caption := 'Abstand zwischen den Ebenen ' + TreeView1.Selections[1].Text + ' und '+TreeView1.Selections[0].Text+' bestimmen';
        MenuItem := TMenuItem.Create(Self);
        MenuItem.Caption := '-';
        MultiSelectMenu.Items.Add(MenuItem);
        MenuItem.OnClick := Abstand2EbenenBestimmen;
        MenuItem := TMenuItem.Create(Self);
        MultiSelectMenu.Items.Add(MenuItem);
        MenuItem.Caption := 'Winkel zwischen den Ebenen ' + TreeView1.Selections[1].Text + ' und '+TreeView1.Selections[0].Text+' bestimmen';
        MenuItem.OnClick := Winkel2EbenenBestimmen;
      end;
    end;
    if TreeView1.SelectionCount = 3 then begin
      if (TreeView1.Selections[0].ImageIndex = 1) and (TreeView1.Selections[1].ImageIndex = 1) and (TreeView1.Selections[2].ImageIndex = 1) then begin
        MenuItem := TMenuItem.Create(Self);
        MenuItem.Caption := '-';
        MultiSelectMenu.Items.Add(MenuItem);
        MenuItem := TMenuItem.Create(Self);
        MultiSelectMenu.Items.Add(MenuItem);
        MenuItem.Caption := 'Ebene durch ' + TreeView1.Selections[2].Text + ' , '+TreeView1.Selections[0].Text + ' und ' + TreeView1.Selections[1].Text+' erstellen';
        MenuItem.OnClick := EbeneDurch3Punkte;
      end;
    end;
    TreeView1.PopupMenu := MultiSelectMenu;
  end else begin

//== Normal Selection

   If TreeView1.SelectionCount > 0 then begin
    SingleSelectMenu.Items.Clear;

    If TreeView1.Selected.Level = 0 then
      Case TreeView1.Selected.Index of
        0: begin
             TreeView1.PopupMenu := PunkteMenu;
           end;
        1: begin
             TreeView1.PopupMenu := StreckenMenu;
           end;
        2: begin
             TreeView1.PopupMenu := GeradenMenu;
           end;
        3: begin
             TreeView1.PopupMenu := EbenenMenu;
           end;
        4: begin
             TreeView1.PopupMenu := KreisMenu;
           end;
        5: begin
             TreeView1.PopupMenu := KugelMenu;
           end;
       end;

    If TGLNode(TreeView1.Selected).LinkedObject is TPunkt then begin
      ZeigeDaten(TPunkt(TGLNode(TreeView1.Selected).LinkedObject),Memo1);
      MenuItem := TMenuItem.Create(Self);
      SingleSelectMenu.Items.Add(MenuItem);
      MenuItem.Caption := 'Punkt löschen';
      MenuItem.OnClick := DeleteObject;
      TreeView1.PopupMenu := SingleSelectMenu;
    end;

    If TGLNode(TreeView1.Selected).LinkedObject is TStrecke then begin
      ZeigeDaten(TStrecke(TGLNode(TreeView1.Selected).LinkedObject),Memo1);
      MenuItem := TMenuItem.Create(Self);
      SingleSelectMenu.Items.Add(MenuItem);
      MenuItem.Caption := 'Endpunkte einzeichnen';
      MenuItem.OnClick := EndpunkteZeichnen;
      MenuItem := TMenuItem.Create(Self);
      SingleSelectMenu.Items.Add(MenuItem);
      MenuItem.Caption := 'Strecke löschen';
      MenuItem.OnClick := DeleteObject;
      TreeView1.PopupMenu := SingleSelectMenu;
    end;

    If TGLNode(TreeView1.Selected).LinkedObject is TGerade then begin
      ZeigeDaten(TGerade(TGLNode(TreeView1.Selected).LinkedObject),Memo1);
      MenuItem := TMenuItem.Create(Self);
      SingleSelectMenu.Items.Add(MenuItem);
      MenuItem.Caption := 'Gerade löschen';
      MenuItem.OnClick := DeleteObject;
      TreeView1.PopupMenu := SingleSelectMenu;
    end;

    If TGLNode(TreeView1.Selected).LinkedObject is TEbene then begin
      ZeigeDaten(TEbene(TGLNode(TreeView1.Selected).LinkedObject),Memo1);
      MenuItem := TMenuItem.Create(Self);
      SingleSelectMenu.Items.Add(MenuItem);
      MenuItem.Caption := 'Spurgeraden einzeichnen';
      MenuItem.OnClick := Spurgeraden;
      MenuItem := TMenuItem.Create(Self);
      SingleSelectMenu.Items.Add(MenuItem);
      MenuItem.Caption := 'Ebene löschen';
      MenuItem.OnClick := DeleteObject;
      TreeView1.PopupMenu := SingleSelectMenu;
    end;

    If TGLNode(TreeView1.Selected).LinkedObject is TKreis then begin
      ZeigeDaten(TKreis(TGLNode(TreeView1.Selected).LinkedObject),Memo1);
      MenuItem := TMenuItem.Create(Self);
      SingleSelectMenu.Items.Add(MenuItem);
      MenuItem.Caption := 'Kreis löschen';
      MenuItem.OnClick := DeleteObject;
      TreeView1.PopupMenu := SingleSelectMenu;
    end;

    If TGLNode(TreeView1.Selected).LinkedObject is TKugel then begin
      ZeigeDaten(TKugel(TGLNode(TreeView1.Selected).LinkedObject),Memo1);
      MenuItem := TMenuItem.Create(Self);
      SingleSelectMenu.Items.Add(MenuItem);
      MenuItem.Caption := 'Kugel löschen';
      MenuItem.OnClick := DeleteObject;
      TreeView1.PopupMenu := SingleSelectMenu;
    end;

    MenuItem := TMenuItem.Create(Self);
    SingleSelectMenu.Items.Add(MenuItem);
    If Assigned(TGLNode(TreeView1.Selected).LinkedObject) then
      If TGLNode(TreeView1.Selected).LinkedObject.Visible then
        MenuItem.Caption := 'Objekt ausblenden'
      else
        MenuItem.Caption := 'Objekt einblenden';
    MenuItem.OnClick := ToggleVisibility;
   end; {SelectionCount > 0}

  end; {SelectionCount < 2}
end;

procedure TForm1.NeueEbeneerstellen1Click(Sender: TObject);
begin
  Form2.Show;
end;

procedure TForm1.AlleEbenenlschen1Click(Sender: TObject);
var
  i: integer;
  Node: TTreeNode;
begin
  i:=0;
  while TreeView1.Items[i].Text<>'Ebenen' do
    i:=i+1;
  Node:=TreeView1.Items[i];

  for i:=Node.Count-1 downto 0 do
    DeleteObject(TGLNode(Node.Item[i]), True, True);
end;

procedure TForm1.GeradeErstellenClick(Sender: TObject);
begin
 Form3.Show;
end;

procedure TForm1.AlleGeradenlschen1Click(Sender: TObject);
var
  i: integer;
  Node: TTreeNode;
begin
  i:=0;
  while TreeView1.Items[i].Text<>'Geraden' do
    i:=i+1;
  Node:=TreeView1.Items[i];

  for i:=Node.Count-1 downto 0 do
    DeleteObject(TGLNode(Node.Item[i]), True, True);

end;

procedure TForm1.NeuenPunkterstellen1Click(Sender: TObject);
begin
  Form4.Show;
end;

procedure TForm1.NeueKugelhinzufgen1Click(Sender: TObject);
begin
  Form5.Show;
end;

procedure TForm1.AllePunktelschen1Click(Sender: TObject);
var
  i: integer;
  Node: TTreeNode;
begin
  i:=0;
  while TreeView1.Items[i].Text<>'Punkte' do
    i:=i+1;
  Node:=TreeView1.Items[i];

  for i:=Node.Count-1 downto 0 do
    DeleteObject(TGLNode(Node.Item[i]), True, True);
end;

procedure TForm1.AlleKugelnlschen1Click(Sender: TObject);
var
  i: integer;
  Node: TTreeNode;
begin
  i:=0;
  while TreeView1.Items[i].Text<>'Kugeln' do
    i:=i+1;
  Node:=TreeView1.Items[i];

  for i:=Node.Count-1 downto 0 do
    DeleteObject(TGLNode(Node.Item[i]), True, True);
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  try
    SaveSettings;
  except
  end;
end;

procedure TForm1.GLCadencer1Progress(Sender: TObject; const deltaTime,
  newTime: Double);
begin
  If Form1.Active then
    HandleKeys(deltaTime);
end;

procedure TForm1.Punkt1Click(Sender: TObject);
begin
  Form4.Show;
end;

procedure TForm1.Gerade1Click(Sender: TObject);
begin
  Form3.Show;
end;

procedure TForm1.Kugel1Click(Sender: TObject);
begin
  Form5.Show;
end;

procedure TForm1.Beenden1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.Ansichtzurcksetzen1Click(Sender: TObject);
begin
  GLCamera1.Position.SetPoint(0,0,10);
  GLCamera1.Up.AsAffineVector:=AffineVectorMake(0,1,0);
  If GLCamera1.CameraStyle = csPerspective then
    GLCamera1.SceneScale:=1.1
  else if GLCamera1.CameraStyle = csOrthogonal then
    GLCamera1.SceneScale:=0.11;

  TargetCube.Position.SetPoint(0,0,0);
  DummyCube1.Direction.AsVector:=DefDir;
  DummyCube1.Up.AsVector:=DefUp;
  Objects.Scale.AsAffineVector:=AffineVectorMake(1,1,1);
  DoZoom(1);
end;

procedure TForm1.InXRichtungschauen1Click(Sender: TObject);
begin
  GLCamera1.Position.SetPoint(0,0,10);
  If GLCamera1.CameraStyle = csPerspective then
    GLCamera1.SceneScale:=1.5
  else if GLCamera1.CameraStyle = csOrthogonal then
    GLCamera1.SceneScale:=0.15;

  TargetCube.Position.SetPoint(0,0,0);
  DummyCube1.Direction.SetVector(0,0,1);
  DummyCube1.Up.SetVector(0,1,0);
  Objects.Scale.AsAffineVector:=AffineVectorMake(1,1,1);
  DoZoom(1);
end;

procedure TForm1.InYRichtungschauen1Click(Sender: TObject);
begin
  GLCamera1.Position.SetPoint(0,0,10);
  If GLCamera1.CameraStyle = csPerspective then
    GLCamera1.SceneScale:=1.5
  else if GLCamera1.CameraStyle = csOrthogonal then
    GLCamera1.SceneScale:=0.15;

  TargetCube.Position.SetPoint(0,0,0);
  DummyCube1.Direction.SetVector(-1,0,0);
  DummyCube1.Up.SetVector(0,1,0);
  Objects.Scale.AsAffineVector:=AffineVectorMake(1,1,1);
  DoZoom(1);
end;

procedure TForm1.InZRichtungschauen1Click(Sender: TObject);
begin
  GLCamera1.Position.SetPoint(0,0,10);
  If GLCamera1.CameraStyle = csPerspective then
    GLCamera1.SceneScale:=1.5
  else if GLCamera1.CameraStyle = csOrthogonal then
    GLCamera1.SceneScale:=0.15;
    
  TargetCube.Position.SetPoint(0,0,0);
  DummyCube1.Direction.SetVector(0,1,0);
  DummyCube1.Up.SetVector(0,0,1);
  Objects.Scale.AsAffineVector:=AffineVectorMake(1,1,1);
  DoZoom(1);
end;

procedure TForm1.TreeView1DblClick(Sender: TObject);
begin
 If TreeView1.SelectionCount > 0 then
  Case TreeView1.Selected.Level of
    0: begin
         TreeView1.Selected.Expand(False);
         If TreeView1.Selected.Text = 'Punkte' then
           Form4.Show;
         If TreeView1.Selected.Text = 'Strecken' then
           Form9.Show;
         If TreeView1.Selected.Text = 'Geraden' then
           Form3.Show;
         If TreeView1.Selected.Text = 'Ebenen' then
           Form2.Show;
         If TreeView1.Selected.Text = 'Kreise' then
           KreisForm.Show;
         If TreeView1.Selected.Text = 'Kugeln' then
           Form5.Show;
       end;
    1: begin
         TreeView1.Selected.Collapse(False);
         Form6.Show;
       end;
    2: begin
       end;
  end;
end;

procedure TForm1.Highlight(Grade: single);
var
  i: integer;
begin
  If Length(OldSelectedObjects)<Length(SelectedObjects) then SetLength(OldSelectedObjects, Length(SelectedObjects));
  for i:=0 to Length(OldSelectedObjects)-1 do
    If Assigned(OldSelectedObjects[i]) then begin
      If (OldSelectedObjects[i] is TGerade) or (OldSelectedObjects[i] is TStrecke) then begin
        TGLCylinder(OldSelectedObjects[i]).BottomRadius:= TGLCylinder(OldSelectedObjects[i]).BottomRadius-0.001;
        TGLCylinder(OldSelectedObjects[i]).TopRadius:= TGLCylinder(OldSelectedObjects[i]).TopRadius-0.001;
      end;

      OldSelectedObjects[i].Material.FrontProperties.Emission.Color:=VectorMake(0,0,0,1);
      OldSelectedObjects[i].Material.BackProperties.Emission.Color:=VectorMake(0,0,0,1);
      If OldSelectedObjects[i].Count>0 then begin
        TGLSceneObject(OldSelectedObjects[i].Children[0]).Material.FrontProperties.Emission.Color:=VectorMake(0,0,0,1);
        TGLSceneObject(OldSelectedObjects[i].Children[0]).Material.BackProperties.Emission.Color:=VectorMake(0,0,0,1);
      end;
      OldSelectedObjects[i]:=NIL;
    end;
  for i:=0 to Length(SelectedObjects)-1 do begin
    If SelectedObjects[i]<>OldSelectedObjects[i] then begin
      If Assigned(SelectedObjects[i]) then begin
        If SelectedObjects[i] is TPunkt then begin
//== rot...
          SelectedObjects[i].Material.FrontProperties.Emission.Color:=VectorMake(1,1,1,1);
          SelectedObjects[i].Material.BackProperties.Emission.Color:=VectorMake(1,1,1,1);
//== Benennung, falls vorhanden
          If SelectedObjects[i].Count>0 then begin
            TGLSceneObject(SelectedObjects[i].Children[0]).Material.FrontProperties.Emission.Color:=VectorMake(1,1,1,1);
            TGLSceneObject(SelectedObjects[i].Children[0]).Material.BackProperties.Emission.Color:=VectorMake(1,1,1,1);
          end;
        end else begin
          If (SelectedObjects[i] is TGerade) or (SelectedObjects[i] is TStrecke) then begin
            TGLCylinder(SelectedObjects[i]).BottomRadius:= TGLCylinder(SelectedObjects[i]).BottomRadius+0.001;
            TGLCylinder(SelectedObjects[i]).TopRadius:= TGLCylinder(SelectedObjects[i]).TopRadius+0.001;
          end;
//== oder hell
//          SelectedObjects[i].Material.FrontProperties.Emission.Color:=VectorScale(SelectedObjects[i].Material.FrontProperties.Diffuse.Color, Grade);
//          SelectedObjects[i].Material.BackProperties:=SelectedObjects[i].Material.FrontProperties;
          SelectedObjects[i].Material.FrontProperties.Emission.Color:=VectorMake(1,1,1,1);
          SelectedObjects[i].Material.BackProperties.Emission.Color:=VectorMake(1,1,1,1);
        end;
      end;
      SetLength(OldSelectedObjects, Length(SelectedObjects));
      OldSelectedObjects[i]:=SelectedObjects[i];
    end;
  end;
end;

procedure TForm1.DeleteObject(Sender: TObject);
begin
  DeleteObject(TGLNode(TreeView1.Selected), True);
end;

procedure TForm1.DeleteObject(Node: TGLNode; RegisterAction: Boolean);
var
  Ans: integer;
begin
  If RegisterAction then
    Ans:=MessageDlg('Wirklich löschen?', mtConfirmation, [mbYes, mbNo], 0)
  else
    Ans:=mrYes;
  If Ans = mrYes then begin
    If GetObjChildCount(Node.LinkedObject) > 0 then
      If RegisterAction then
        Ans:=MessageDlg('Möchten Sie alle Objekte, die von diesem abhängen ebenfalls löschen?',mtConfirmation, [mbYes, mbNo], 0)
      else
        Ans:=mrNo;
    DeleteObject(Node, RegisterAction, Ans = mrYes);
  end;
end;

procedure TForm1.DeleteObject(Node: TGLNode; RegisterAction, DeleteChildren: Boolean);
var
  i, j: integer;
  ChildNode: TGLNode;
  Child: TGLBaseSceneObject;
begin
//== Save Action in ActionList first
  If RegisterAction then begin
    RegisterActions(Node.LinkedObject , 'Delete');
  end;

  If DeleteChildren then begin
//== Delete object's children
    for i:=GetObjChildCount(Node.LinkedObject)-1 downto 0 do begin
      ChildNode:=GetObjNode(GetObjName(GetObjChild(Node.LinkedObject, i)), TreeView1);
      If Assigned(ChildNode) then
        DeleteObject(ChildNode, True, True);
    end;
  end else begin
//== Delete children's references
    for i:=GetObjChildCount(Node.LinkedObject)-1 downto 0 do begin
      Child:=GetObjChild(Node.LinkedObject, i);

      // Free the Child from all parents and delete also all references to this object
      for j:=0 to GetObjParentCount(Child)-1 do
        If Assigned(GetObjParent(Child, j)) then
          DeleteObjChild(GetObjParent(Child, j), GetObjName(Child));

      DeleteAllObjParents(Child);
    end;
  end;

//== Delete References of all parents
    for i:=0 to GetObjParentCount(Node.LinkedObject)-1 do
      If Assigned(GetObjParent(Node.LinkedObject, i)) then
        DeleteObjChild(GetObjParent(Node.LinkedObject, i), GetObjName(Node.LinkedObject));

//== Delete Object and the reference in the TreeView
  Node.LinkedObject.Free;
  Node.Free;
  If Assigned(OldSelectedObjects) then
    OldSelectedObjects:=NIL;
end;

procedure TForm1.OptimiereGerade(var Gerade: TGerade);
var
  l: Single;
begin
  With Gerade do
  l:=-VectorDotProduct(Position.AsAffineVector, Up.AsAffineVector)/Vectorlength(Up.AsAffineVector);
  Gerade.Position.AsAffineVector:=VectorAdd(Gerade.Position.AsAffineVector, VectorScale(Gerade.Up.AsAffineVector,l));
end;

procedure TForm1.OptimiereEbene(var Ebene: TEbene);
var
  p, d: TAffineVector;
  l: single;
begin
  p:=Ebene.Position.AsAffineVector;
  d:=Ebene.Direction.AsAffineVector;
  l:=VectorDotProduct(p, d)/ VectorDotProduct(d, d);
  p:=VectorScale(d, l);
  SetEbene(Ebene, p, d);
end;

procedure TForm1.Grafik1Click(Sender: TObject);
begin
  Form7.Show;
end;

procedure TForm1.Rckgngig1Click(Sender: TObject);
begin
  ActionList1.UndoLastAction;
end;

procedure TForm1.Wiederherstellen1Click(Sender: TObject);
begin
  ActionList1.RedoLastAction;
end;

procedure TForm1.Rckblende2Click(Sender: TObject);
begin
  Form8.Show;
end;

procedure TForm1.Speichern1Click(Sender: TObject);
begin
  SaveDialog1.Filter:='Vectory - Datei|*.vec';
  If SaveDialog1.Execute then
    SaveFile(SaveDialog1.FileName);
end;

procedure TForm1.Laden1Click(Sender: TObject);
var
 FileName: string;
begin
  Neu1Click(Sender);
  If TForm(Sender).Tag = mrCancel then begin
    TForm(Sender).Tag:=mrYes;
    Exit;
  end;
  If OpenDialog1.Execute then begin
    FileName:=OpenDialog1.FileName;
    If UpperCase(Copy(FileName, Length(FileName)-2, 3)) = 'VEC' then
      LoadFile(FileName)
    else begin
      ActionList1.LoadFromFile(FileName);
      ActionList1.RedoAllActions;
    end;
  end;
end;

procedure TForm1.TreeView1Edited(Sender: TObject; Node: TTreeNode;
  var S: String);
var
  ObjName, FullName: string;
  Number: integer;
  OldObject: TGLBaseSceneObject;
begin
  TreeViewEditing:=False;
  If TGLNode(Node).LinkedObject is TPunkt then
    TPunkt(OldObject):=TPunkt.Create(Form1);
  If TGLNode(Node).LinkedObject is TGerade then
    TGerade(OldObject):=TGerade.Create(Form1);
  If TGLNode(Node).LinkedObject is TStrecke then
    TStrecke(OldObject):=TStrecke.Create(Form1);
  If TGLNode(Node).LinkedObject is TEbene then
    TEbene(OldObject):=TEbene.Create(Form1);
  If TGLNode(Node).LinkedObject is TKugel then
    TKugel(OldObject):=TKugel.Create(Form1);

  If Assigned(TGLNode(Node).LinkedObject) then begin
    If not NameUsed(S) or
       (GetObjName(TGLNode(Node).LinkedObject) = S) then begin
      SetObjName(TGLNode(Node).LinkedObject, S);
      If TGLNode(Node).LinkedObject is TPunkt then
        TPunkt(TGLNode(Node).LinkedObject).Bezeichnung.Text:=S;
    end else begin
      ShowMessage('Name schon vorhanden');

      ObjName:=S;
      while (ObjName[Length(ObjName)] in ['0'..'9']) do
        Delete(ObjName, Length(ObjName), 1);

      Number:=1; FullName:= ObjName + IntToStr(Number);
      while (NameUsed(FullName)) and
            not (GetObjName(TGLNode(Node).LinkedObject) = FullName) do begin
        Number:=Number+1;
        FullName:=ObjName+IntToStr(Number);
      end;

      S:=FullName;
      SetObjName(TGLNode(Node).LinkedObject,FullName);
    end;

    SetObjName(OldObject, Node.Text);
    RegisterActions(TGLNode(Node).LinkedObject, OldObject, 'ChangeName');
    OldObject.Free;
  end;
end;

procedure TForm1.Neu1Click(Sender: TObject);
var
  count, i: integer;
  VarName: string;
  Ans: integer;
begin
  If TreeView1.Items.Count > 6 then
    Ans:= MessageDlg('Die vorhandene Szene wird gelöscht, wollen Sie erst speichern?', mtWarning, mbYesNoCancel, 0);
  If Ans = mrYes then
    Speichern1Click(Self);
  If Ans = mrCancel then begin
    TForm(Sender).Tag:=mrcancel;
    Exit;
  end else begin
    ActionList1.Clear;
    ActionList1.ActualIndex:=0;

    for i:=TreeView1.Items.Count-1 downto 0 do begin
      If TGLNode(TreeView1.Items[i]).LinkedObject <> NIL then
        DeleteObject(TGLNode(TreeView1.Items[i]), False, False);
    end;
    Memo1.Text:='';
    Caption:='Vectory';
    for count:=0 to Length(VarsArchive)-1 do begin
      VarName:=VarsArchive[count].Name;
      If Assigned(ParamForms.FindComponent(VarName)) then
        ParamForms.FindComponent(VarName).Destroy;
    end;
    SetLength(VarsArchive, 0);
  end;  
end;

procedure TForm1.AnsichtalsBitmapspeichern1Click(Sender: TObject);
begin
  SaveDialog1.Filter:='Bitmap-Datei|*.bmp';
  if SaveDialog1.Execute then
    GLSceneViewer1.Buffer.CreateSnapShot.Create32BitsBitmap.SaveToFile(SaveDialog1.FileName);
end;

procedure TForm1.HandleKeys(deltaTime: double);
begin
 If GLSceneViewer1.Focused then begin
  If IsKeyDown(VK_LEFT) then begin
    MoveCamWithTarget(GLCamera1, TargetCube, -deltaTime*5, 0);
  end;
  If IsKeyDown(VK_RIGHT) then begin
    MoveCamWithTarget(GLCamera1, TargetCube, deltaTime*5, 0);
  end;
  If IsKeyDown(VK_UP) then begin
    MoveCamWithTarget(GLCamera1, TargetCube,0 , deltaTime*5);
  end;
  If IsKeyDown(VK_DOWN) then begin
    MoveCamWithTarget(GLCamera1, TargetCube,0 , -deltaTime*5);
  end;
 end;
end;

procedure TForm1.ToggleVisibility(Sender: TObject);
var
  i: integer;
begin
  for i:=0 to TreeView1.SelectionCount-1 do
    If TreeView1.Selections[i].Level = 1 then begin
      TGLNode(TreeView1.Selections[i]).LinkedObject.Visible:=not TGLNode(TreeView1.Selections[i]).LinkedObject.Visible;
      TGLNode(TreeView1.Selections[i]).LinkedObject.TagFloat:=
         abs(TGLNode(TreeView1.Selections[i]).LinkedObject.TagFloat) - 2;
    end;
end;

procedure TForm1.MenuItem1Click(Sender: TObject);
begin
  Form9.Show;
end;

procedure TForm1.MenuItem2Click(Sender: TObject);
var
  i: integer;
  Node: TTreeNode;
begin
  i:=0;
  while TreeView1.Items[i].Text<>'Strecken' do
    i:=i+1;
  Node:=TreeView1.Items[i];

  for i:=Node.Count-1 downto 0 do
    DeleteObject(TGLNode(Node.Item[i]), True, True);
end;

procedure TForm1.Strecke1Click(Sender: TObject);
begin
  Form9.Show;
end;

procedure TForm1.Spurgeraden(Sender: TObject);
var
  Ebene: TEbene;
  X1, X2, X3: single;
  NewColor: TVector4f;
  i: integer;
begin
  Ebene:=TEbene(TGLNode(TreeView1.Selected).LinkedObject);

  X1:= Ebene.Achsenabschnitte[0];
  X2:= Ebene.Achsenabschnitte[1];
  X3:= Ebene.Achsenabschnitte[2];

  If (X1 = 0) and (X2 = 0) and (X3 = 0) then
    ShowMessage('Keine Spurgeraden vorhanden, da diese Ebene eine Ursprungsebene ist')

  else begin

    NewColor:=Ebene.AchsenschnittpunktX1.Material.FrontProperties.Diffuse.Color;

    If not (IsInfinite(X1) or IsInfinite(X2)) then begin
      NewGerade(X1, 0, 0, -X1, X2, 0, GetObjName(Ebene), '', 'Spurgerade');

      i:=1;
      While NameUsed('Sg'+IntToStr(i)) do
        inc(i);
      SetObjName(TGLNode(TreeView1.Selected).LinkedObject, 'Sg'+IntToStr(i));
      TreeView1.Selected.Text:= 'Sg'+IntToStr(i);

      RegisterActions(TGLNode(TreeView1.Selected).LinkedObject, 'Create');
      AddObjChild(Ebene, GetObjName(TGLNode(TreeView1.Selected).LinkedObject));
      TGerade(TGLNode(TreeView1.Selected).LinkedObject).Material.FrontProperties.Diffuse.Color := NewColor;
    end;
    If not (IsInfinite(X2) or IsInfinite(X3)) then begin
      NewGerade(0, X2, 0, 0, -X2, X3, GetObjName(Ebene), '', 'Spurgerade');

      i:=1;
      While NameUsed('Sg'+IntToStr(i)) do
        inc(i);
      SetObjName(TGLNode(TreeView1.Selected).LinkedObject, 'Sg'+IntToStr(i));
      TreeView1.Selected.Text:= 'Sg'+IntToStr(i);

      RegisterActions(TGLNode(TreeView1.Selected).LinkedObject, 'Create');
      AddObjChild(Ebene, GetObjName(TGLNode(TreeView1.Selected).LinkedObject));
      TGerade(TGLNode(TreeView1.Selected).LinkedObject).Material.FrontProperties.Diffuse.Color := NewColor;
    end;
    If not (IsInfinite(X3) or IsInfinite(X1)) then begin
      NewGerade(0, 0, X3, X1, 0, -X3, GetObjName(Ebene), '', 'Spurgerade');

      i:=1;
      While NameUsed('Sg'+IntToStr(i)) do
        inc(i);
      SetObjName(TGLNode(TreeView1.Selected).LinkedObject, 'Sg'+IntToStr(i));
      TreeView1.Selected.Text:= 'Sg'+IntToStr(i);

      RegisterActions(TGLNode(TreeView1.Selected).LinkedObject, 'Create');
      AddObjChild(Ebene, GetObjName(TGLNode(TreeView1.Selected).LinkedObject));
      TGerade(TGLNode(TreeView1.Selected).LinkedObject).Material.FrontProperties.Diffuse.Color := NewColor;
    end;
  end;
end;

procedure TForm1.Endpunktezeichnen(Sender: TObject);
begin
  EndpunkteZeichnen(TStrecke(TGLNode(TreeView1.Selected).LinkedObject));
end;

procedure TForm1.EndpunkteZeichnen(Strecke: TStrecke);
var
  i: integer;
  NewColor: TVector4f;
begin
  NewColor:= Strecke.Material.FrontProperties.Diffuse.Color;

// Anfangspunkt
  i:=1;
  While NameUsed('P'+IntToStr(i)) do
    inc(i);

  NewPunkt(Strecke.Anfangspunkt[0], Strecke.Anfangspunkt[1],
           Strecke.Anfangspunkt[2], GetObjName(Strecke),'', '', 'Anfangspunkt');

  SetObjName(TGLNode(TreeView1.Selected).LinkedObject, 'P'+IntToStr(i));
  TreeView1.Selected.Text:= 'P'+IntToStr(i);

  AddObjChild(Strecke, GetObjName(TGLNode(TreeView1.Selected).LinkedObject));

  TPunkt(TGLNode(TreeView1.Selected).LinkedObject).Material.FrontProperties.Diffuse.Color := NewColor;
  TPunkt(TGLNode(TreeView1.Selected).LinkedObject).Bezeichnung.Material.FrontProperties.Diffuse.Color := NewColor;

  RegisterActions(TGLNode(TreeView1.Selected).LinkedObject, 'Create Macro Begin');

// Endpunkt
  i:=1;
  While NameUsed('P'+IntToStr(i)) do
    inc(i);

  NewPunkt(Strecke.Endpunkt[0], Strecke.Endpunkt[1],
           Strecke.Endpunkt[2], GetObjName(Strecke), '','', 'Endpunkt');

  SetObjName(TGLNode(TreeView1.Selected).LinkedObject, 'P'+IntToStr(i));
  TreeView1.Selected.Text:= 'P'+IntToStr(i);

  AddObjChild(Strecke, GetObjName(TGLNode(TreeView1.Selected).LinkedObject));

  TPunkt(TGLNode(TreeView1.Selected).LinkedObject).Material.FrontProperties.Diffuse.Color := NewColor;
  TPunkt(TGLNode(TreeView1.Selected).LinkedObject).Bezeichnung.Material.FrontProperties.Diffuse.Color := NewColor;

  RegisterActions(TGLNode(TreeView1.Selected).LinkedObject, 'Create Macro End');
end;

procedure TForm1.ApplicationEvents1Message(var Msg: tagMSG;
  var Handled: Boolean);
var
  Ans, count, i: integer;
  Selections: array of TTreeNode;
begin
 If Msg.message = WM_KEYDOWN then begin
   If (Msg.wParam = VK_DELETE) and not (TreeView1.IsEditing) and (TreeView1.Focused) and
      Assigned(TGLNode(TreeView1.Selected).LinkedObject) then begin

     Ans:=MessageDlg('Wirklich löschen?', mtConfirmation, [mbYes, mbNo], 0);
     If Ans = mrYes then begin
       If GetObjChildCount(TGLNode(TreeView1.Selected).LinkedObject) > 0 then
         Ans:=MessageDlg('Möchten Sie alle Objekte, die von diesem abhängen ebenfalls löschen?',mtConfirmation, [mbYes, mbNo], 0);
       Count:=TreeView1.SelectionCount;
       SetLength(Selections, Count);
       for i:=0 to Count-1 do
         Selections[i]:=TreeView1.Selections[i];

       for i:=0 to Count-1 do begin
         If (Selections[i].Level = 1) or
            (TGLNode(Selections[i]).LinkedObject is TOrtslinie){Alle normalen Objekte} then begin
           DeleteObject(TGLNode(Selections[i]), True, Ans = mrYes);
           Handled:=True;
         end;
       end;
     end;
   end;
   If (Msg.wParam = VK_SPACE) and not (TreeView1.IsEditing) and (TreeView1.Focused) then begin
     ToggleVisibility(Self);
     Handled:=True;
   end;
 end;
end;

procedure TForm1.Winkel2EbenenBestimmen(Sender: TObject);
var
  Result: single;
begin
  Result:=Winkel2Ebenen(TEbene(TGLNode(TreeView1.Selections[0]).LinkedObject), TEbene(TGlNode(TreeView1.Selections[1]).LinkedObject));
  If IsZero(Result, 0.000001) then
    MessageDlg('Die Ebenen sind parallel', mtInformation, [mbOK], 0)
  else
    MessageDlg(Format('Der Winkel beträgt %0.1f°',[Result]), mtInformation, [mbOK], 0);
end;

procedure TForm1.Winkel2GeradenBestimmen(Sender: TObject);
var
  Result: single;
begin
  Result:=Winkel2Geraden(TGerade(TGLNode(TreeView1.Selections[0]).LinkedObject), TGerade(TGlNode(TreeView1.Selections[1]).LinkedObject));
  If IsZero(Result, 0.000001) then
    MessageDlg('Die Geraden schneiden sich nicht, oder sind identisch', mtInformation, [mbOK], 0)
  else
    MessageDlg(Format('Der Winkel beträgt %0.1f°',[Result]), mtInformation, [mbOK], 0);
end;

procedure TForm1.WinkelGeradeEbeneBestimmen(Sender: TObject);
var
  Result: single;
begin
  Result:=WinkelGeradeEbene(TGerade(TGLNode(TreeView1.Selections[0]).LinkedObject), TEbene(TGlNode(TreeView1.Selections[1]).LinkedObject));
  If IsZero(Result, 0.000001) then
    MessageDlg('Die Geraden schneiden sich nicht, oder sind identisch', mtInformation, [mbOK], 0)
  else
    MessageDlg(Format('Der Winkel beträgt %0.1f°',[Result]), mtInformation, [mbOK], 0);
end;

procedure TForm1.WinkelEbeneGeradeBestimmen(Sender: TObject);
var
  Result: single;
begin
  Result:=WinkelGeradeEbene(TGerade(TGLNode(TreeView1.Selections[1]).LinkedObject), TEbene(TGlNode(TreeView1.Selections[0]).LinkedObject));
  If IsZero(Result, 0.000001) then
    MessageDlg('Die Gerade ist parallel zur Ebene, oder liegt in der Ebene', mtInformation, [mbOK], 0)
  else
    MessageDlg(Format('Der Winkel beträgt %0.1f°',[Result]), mtInformation, [mbOK], 0);
end;

procedure TForm1.Abstand2PunkteBestimmen(Sender: TObject);
var
  Result: single;
begin
  Result:=Abstand2Punkte(TPunkt(TGlNode(TreeView1.Selections[0]).LinkedObject), TPunkt(TGlNode(TreeView1.Selections[1]).LinkedObject));
  MessageDlg(Format('Der Abstand ist '+MakeNiceNumber(Result)+' (~ %0.3f)',[Result]), mtInformation, [mbOK], 0);
end;

procedure TForm1.AbstandGeradePunktBestimmen(Sender: TObject);
var
  Result: single;
begin
  Result:=AbstandPunktGerade(TPunkt(TGlNode(TreeView1.Selections[1]).LinkedObject), TGerade(TGlNode(TreeView1.Selections[0]).LinkedObject));
  MessageDlg(Format('Der Abstand ist '+MakeNiceNumber(Result)+' (~ %0.3f)',[Result]), mtInformation, [mbOK], 0);
end;

procedure TForm1.AbstandPunktGeradeBestimmen(Sender: TObject);
var
  Result: single;
begin
  Result:=AbstandPunktGerade(TPunkt(TGlNode(TreeView1.Selections[0]).LinkedObject), TGerade(TGlNode(TreeView1.Selections[1]).LinkedObject));
  MessageDlg(Format('Der Abstand ist '+MakeNiceNumber(Result)+' (~ %0.3f)',[Result]), mtInformation, [mbOK], 0);
end;

procedure TForm1.Abstand2GeradenBestimmen(Sender: TObject);
var
  Result: single;
begin
  Result:=Abstand2Geraden(TGerade(TGlNode(TreeView1.Selections[0]).LinkedObject), TGerade(TGlNode(TreeView1.Selections[1]).LinkedObject));
  If Result = 0 then
    MessageDlg('Die Geraden schneiden sich, oder sind identisch', mtInformation, [mbOK], 0)
  else
    MessageDlg(Format('Der Abstand ist '+MakeNiceNumber(Result)+' (~ %0.3f)',[Result]), mtInformation, [mbOK], 0);
end;

procedure TForm1.AbstandEbenePunktBestimmen(Sender: TObject);
var
  Result: single;
begin
  Result:=AbstandEbenePunkt(TEbene(TGlNode(TreeView1.Selections[0]).LinkedObject), TPunkt(TGlNode(TreeView1.Selections[1]).LinkedObject));
  If Result = 0 then
    MessageDlg('Der Punkt liegt in der Ebene', mtInformation, [mbOK], 0)
  else
    MessageDlg(Format('Der Abstand ist '+MakeNiceNumber(Result)+' (~ %0.3f)',[Result]), mtInformation, [mbOK], 0);
end;

procedure TForm1.AbstandPunktEbeneBestimmen(Sender: TObject);
var
  Result: single;
begin
  Result:=AbstandEbenePunkt(TEbene(TGlNode(TreeView1.Selections[1]).LinkedObject), TPunkt(TGlNode(TreeView1.Selections[0]).LinkedObject));
  If Result = 0 then
    MessageDlg('Der Punkt liegt in der Ebene', mtInformation, [mbOK], 0)
  else
    MessageDlg(Format('Der Abstand ist '+MakeNiceNumber(Result)+' (~ %0.3f)',[Result]), mtInformation, [mbOK], 0);
end;

procedure TForm1.AbstandEbeneGeradeBestimmen(Sender: TObject);
var
  Result: single;
begin
  Result:=AbstandEbeneGerade(TEbene(TGlNode(TreeView1.Selections[0]).LinkedObject), TGerade(TGlNode(TreeView1.Selections[1]).LinkedObject));
  If Result = 0 then
    MessageDlg('Die Gerade schneidet die Ebene, oder liegt in der Ebene', mtInformation, [mbOK], 0)
  else
    MessageDlg(Format('Der Abstand ist '+MakeNiceNumber(Result)+' (~ %0.3f)',[Result]), mtInformation, [mbOK], 0);
end;

procedure TForm1.AbstandGeradeEbeneBestimmen(Sender: TObject);
var
  Result: single;
begin
  Result:=AbstandEbeneGerade(TEbene(TGlNode(TreeView1.Selections[1]).LinkedObject), TGerade(TGlNode(TreeView1.Selections[0]).LinkedObject));
  If Result = 0 then
    MessageDlg('Die Gerade schneidet die Ebene', mtInformation, [mbOK], 0)
  else
    MessageDlg(Format('Der Abstand ist '+MakeNiceNumber(Result)+' (~ %0.3f)',[Result]), mtInformation, [mbOK], 0);
end;

procedure TForm1.Abstand2EbenenBestimmen(Sender: TObject);
var
  Result: single;
begin
  Result:=Abstand2Ebenen(TEbene(TGlNode(TreeView1.Selections[1]).LinkedObject), TEbene(TGlNode(TreeView1.Selections[0]).LinkedObject));
  If Result = 0 then
    MessageDlg('Die Ebenen schneiden sich, oder sind identisch', mtInformation, [mbOK], 0)
  else
    MessageDlg(Format('Der Abstand ist '+MakeNiceNumber(Result)+' (~ %0.3f)',[Result]), mtInformation, [mbOK], 0);
end;

procedure TForm1.AbstandPunktStreckeBestimmen(Sender: TObject);
var
  Result: single;
begin
  Result:=AbstandPunktStrecke(TPunkt(TGlNode(TreeView1.Selections[0]).LinkedObject), TStrecke(TGlNode(TreeView1.Selections[1]).LinkedObject));
  If Result = 0 then
    MessageDlg('Der Punkt liegt auf der Strecke', mtInformation, [mbOK], 0)
  else
    MessageDlg(Format('Der Abstand ist '+MakeNiceNumber(Result)+' (~ %0.3f)',[Result]), mtInformation, [mbOK], 0);
end;

procedure TForm1.AbstandStreckePunktBestimmen(Sender: TObject);
var
  Result: single;
begin
  Result:=AbstandPunktStrecke(TPunkt(TGlNode(TreeView1.Selections[1]).LinkedObject), TStrecke(TGlNode(TreeView1.Selections[0]).LinkedObject));
  If Result = 0 then
    MessageDlg('Der Punkt liegt auf der Strecke', mtInformation, [mbOK], 0)
  else
    MessageDlg(Format('Der Abstand ist '+MakeNiceNumber(Result)+' (~ %0.3f)',[Result]), mtInformation, [mbOK], 0);
end;

procedure TForm1.AbstandStreckeGeradeBestimmen(Sender: TObject);
var
  Result: single;
begin
  Result:=AbstandStreckeGerade(TStrecke(TGlNode(TreeView1.Selections[0]).LinkedObject), TGerade(TGlNode(TreeView1.Selections[1]).LinkedObject));
  If Result = 0 then
    MessageDlg('Die Strecke schneidet die Gerade', mtInformation, [mbOK], 0)
  else
    MessageDlg(Format('Der Abstand ist '+MakeNiceNumber(Result)+' (~ %0.3f)',[Result]), mtInformation, [mbOK], 0);
end;

procedure TForm1.AbstandGeradeStreckeBestimmen(Sender: TObject);
var
  Result: single;
begin
  Result:=AbstandStreckeGerade(TStrecke(TGlNode(TreeView1.Selections[1]).LinkedObject), TGerade(TGlNode(TreeView1.Selections[0]).LinkedObject));
  If Result = 0 then
    MessageDlg('Die Strecke schneidet die Gerade', mtInformation, [mbOK], 0)
  else
    MessageDlg(Format('Der Abstand ist '+MakeNiceNumber(Result)+' (~ %0.3f)',[Result]), mtInformation, [mbOK], 0);
end;

procedure TForm1.Abstand2StreckenBestimmen(Sender: TObject);
var
  Result: single;
begin
  Result:=Abstand2Strecken(TStrecke(TGlNode(TreeView1.Selections[0]).LinkedObject), TStrecke(TGlNode(TreeView1.Selections[1]).LinkedObject));
  If Result = 0 then
    MessageDlg('Die Strecken schneiden sich', mtInformation, [mbOK], 0)
  else
    MessageDlg(Format('Der Abstand ist '+MakeNiceNumber(Result)+' (~ %0.3f)',[Result]), mtInformation, [mbOK], 0);
end;

procedure TForm1.AbstandStreckeEbeneBestimmen(Sender: TObject);
var
  Result: single;
begin
  Result:=AbstandStreckeEbene(TStrecke(TGlNode(TreeView1.Selections[0]).LinkedObject), TEbene(TGlNode(TreeView1.Selections[1]).LinkedObject));
  If Result = 0 then
    MessageDlg('Die Strecke schneidet die Ebene', mtInformation, [mbOK], 0)
  else
    MessageDlg(Format('Der Abstand ist '+MakeNiceNumber(Result)+' (~ %0.3f)',[Result]), mtInformation, [mbOK], 0);
end;

procedure TForm1.AbstandEbeneStreckeBestimmen(Sender: TObject);
var
  Result: single;
begin
  Result:=AbstandStreckeEbene(TStrecke(TGlNode(TreeView1.Selections[1]).LinkedObject), TEbene(TGlNode(TreeView1.Selections[0]).LinkedObject));
  If Result = 0 then
    MessageDlg('Die Strecke schneidet die Ebene', mtInformation, [mbOK], 0)
  else
    MessageDlg(Format('Der Abstand ist '+MakeNiceNumber(Result)+' (~ %0.3f)',[Result]), mtInformation, [mbOK], 0);
end;

procedure TForm1.AbstandPunktKugelBestimmen(Sender: TObject);
var
  Result: single;
begin
  Result:=AbstandPunktKugel(TPunkt(TGlNode(TreeView1.Selections[0]).LinkedObject), TKugel(TGlNode(TreeView1.Selections[1]).LinkedObject));
  If Result < -0.000001 then
    MessageDlg('Der Punkt liegt in der Kugel', mtInformation, [mbOK], 0)
  else
    If IsZero(Result, 0.000001) then
      MessageDlg('Der Punkt liegt auf der Kugel', mtInformation, [mbOK], 0)
    else
      MessageDlg(Format('Der Abstand ist '+MakeNiceNumber(Result)+' (~ %0.3f)',[Result]), mtInformation, [mbOK], 0);
end;

procedure TForm1.AbstandKugelPunktBestimmen(Sender: TObject);
var
  Result: single;
begin
  Result:=AbstandPunktKugel(TPunkt(TGlNode(TreeView1.Selections[1]).LinkedObject), TKugel(TGlNode(TreeView1.Selections[0]).LinkedObject));
  If Result < -0.000001 then
    MessageDlg('Der Punkt liegt in der Kugel', mtInformation, [mbOK], 0)
  else
    If IsZero(Result, 0.000001) then
      MessageDlg('Der Punkt liegt auf der Kugel', mtInformation, [mbOK], 0)
    else
      MessageDlg(Format('Der Abstand ist '+MakeNiceNumber(Result)+' (~ %0.3f)',[Result]), mtInformation, [mbOK], 0);
end;

procedure TForm1.AbstandStreckeKugelBestimmen(Sender: TObject);
var
  Result: single;
begin
  Result:=AbstandStreckeKugel(TStrecke(TGlNode(TreeView1.Selections[0]).LinkedObject), TKugel(TGlNode(TreeView1.Selections[1]).LinkedObject));
  If Result < -0.000001 then
    MessageDlg('Die Strecke schneidet die Kugel', mtInformation, [mbOK], 0)
  else
    If IsZero(Result, 0.000001) then
      MessageDlg('Die Strecke berührt die Kugel', mtInformation, [mbOK], 0)
    else
      MessageDlg(Format('Der Abstand ist '+MakeNiceNumber(Result)+' (~ %0.3f)',[Result]), mtInformation, [mbOK], 0);
end;

procedure TForm1.AbstandKugelStreckeBestimmen(Sender: TObject);
var
  Result: single;
begin
  Result:=AbstandStreckeKugel(TStrecke(TGlNode(TreeView1.Selections[1]).LinkedObject), TKugel(TGlNode(TreeView1.Selections[0]).LinkedObject));
  If Result < -0.000001 then
    MessageDlg('Die Strecke schneidet die Kugel', mtInformation, [mbOK], 0)
  else
    If IsZero(Result, 0.000001) then
      MessageDlg('Die Strecke berührt die Kugel', mtInformation, [mbOK], 0)
    else
      MessageDlg(Format('Der Abstand ist '+MakeNiceNumber(Result)+' (~ %0.3f)',[Result]), mtInformation, [mbOK], 0);
end;

procedure TForm1.AbstandGeradeKugelBestimmen(Sender: TObject);
var
  Result: single;
begin
  Result:=AbstandGeradeKugel(TGerade(TGlNode(TreeView1.Selections[0]).LinkedObject), TKugel(TGlNode(TreeView1.Selections[1]).LinkedObject));
  If Result < -0.000001 then
    MessageDlg('Die Gerade schneidet die Kugel', mtInformation, [mbOK], 0)
  else
    If IsZero(Result, 0.000001) then
      MessageDlg('Die Gerade berührt die Kugel', mtInformation, [mbOK], 0)
    else
      MessageDlg(Format('Der Abstand ist '+MakeNiceNumber(Result)+' (~ %0.3f)',[Result]), mtInformation, [mbOK], 0);
end;

procedure TForm1.AbstandKugelGeradeBestimmen(Sender: TObject);
var
  Result: single;
begin
  Result:=AbstandGeradeKugel(TGerade(TGlNode(TreeView1.Selections[1]).LinkedObject), TKugel(TGlNode(TreeView1.Selections[0]).LinkedObject));
  If Result < -0.000001 then
    MessageDlg('Die Gerade schneidet die Kugel', mtInformation, [mbOK], 0)
  else
    If IsZero(Result, 0.000001) then
      MessageDlg('Die Gerade berührt die Kugel', mtInformation, [mbOK], 0)
    else
      MessageDlg(Format('Der Abstand ist '+MakeNiceNumber(Result)+' (~ %0.3f)',[Result]), mtInformation, [mbOK], 0);
end;

procedure TForm1.AbstandEbeneKugelBestimmen(Sender: TObject);
var
  Result: single;
begin
  Result:=AbstandEbeneKugel(TEbene(TGlNode(TreeView1.Selections[0]).LinkedObject), TKugel(TGlNode(TreeView1.Selections[1]).LinkedObject));
  If Result < -0.000001 then
    MessageDlg('Die Ebene schneidet die Kugel', mtInformation, [mbOK], 0)
  else
    If IsZero(Result, 0.000001) then
      MessageDlg('Die Ebene berührt die Kugel', mtInformation, [mbOK], 0)
    else
      MessageDlg(Format('Der Abstand ist '+MakeNiceNumber(Result)+' (~ %0.3f)',[Result]), mtInformation, [mbOK], 0);
end;

procedure TForm1.AbstandKugelEbeneBestimmen(Sender: TObject);
var
  Result: single;
begin
  Result:=AbstandEbeneKugel(TEbene(TGlNode(TreeView1.Selections[1]).LinkedObject), TKugel(TGlNode(TreeView1.Selections[0]).LinkedObject));
  If Result < -0.000001 then
    MessageDlg('Die Ebene schneidet die Kugel', mtInformation, [mbOK], 0)
  else
    If IsZero(Result, 0.000001) then
      MessageDlg('Die Ebene berührt die Kugel', mtInformation, [mbOK], 0)
    else
      MessageDlg(Format('Der Abstand ist '+MakeNiceNumber(Result)+' (~ %0.3f)',[Result]), mtInformation, [mbOK], 0);
end;

procedure TForm1.Abstand2KugelnBestimmen(Sender: TObject);
var
  Result, dif: single;
begin
  Result:=Abstand2Kugeln(TKugel(TGlNode(TreeView1.Selections[0]).LinkedObject), TKugel(TGlNode(TreeView1.Selections[1]).LinkedObject));
  dif:= TKugel(TGlNode(TreeView1.Selections[0]).LinkedObject).Radius -
        TKugel(TGlNode(TreeView1.Selections[1]).LinkedObject).Radius;

  If Result < -0.000001 then
    If Result + abs(dif) < -0.000001 then
      MessageDlg('Eine Kugel liegt in der anderen', mtInformation, [mbOK], 0)
    else
      If IsZero(Result + abs(dif), 0.000001) then
        MessageDlg('Die Kugeln berühren sich von innen', mtInformation, [mbOK], 0)
      else
        MessageDlg('Die Kugeln schneiden sich', mtInformation, [mbOK], 0)
  else
    If IsZero(Result, 0.000001) then
      MessageDlg('Die Kugeln berühren sich von außen', mtInformation, [mbOK], 0)
    else
      MessageDlg(Format('Der Abstand ist '+MakeNiceNumber(Result)+' (~ %0.3f)',[Result]), mtInformation, [mbOK], 0);
end;

procedure TForm1.AbstandPunktKreisBestimmen(Sender: TObject);
var
  Result: single;
begin
  Result:=AbstandPunktKreis(TPunkt(TGlNode(TreeView1.Selections[0]).LinkedObject), TKreis(TGlNode(TreeView1.Selections[1]).LinkedObject));

  If IsZero(Result, 0.000001) then
    MessageDlg('Der Punkt liegt auf dem Kreis', mtInformation, [mbOK], 0)
  else
    MessageDlg(Format('Der Abstand ist '+MakeNiceNumber(Result)+' (~ %0.3f)',[Result]), mtInformation, [mbOK], 0);
end;

procedure TForm1.AbstandKreisPunktBestimmen(Sender: TObject);
var
  Result: single;
begin
  Result:=AbstandPunktKreis(TPunkt(TGlNode(TreeView1.Selections[1]).LinkedObject), TKreis(TGlNode(TreeView1.Selections[0]).LinkedObject));

  If IsZero(Result, 0.000001) then
    MessageDlg('Der Punkt liegt auf dem Kreis', mtInformation, [mbOK], 0)
  else
    MessageDlg(Format('Der Abstand ist '+MakeNiceNumber(Result)+' (~ %0.3f)',[Result]), mtInformation, [mbOK], 0);
end;

procedure TForm1.AbstandGeradeKreisBestimmen(Sender: TObject);
var
  Result: single;
begin
  Result:=AbstandGeradeKreis(TGerade(TGlNode(TreeView1.Selections[0]).LinkedObject), TKreis(TGlNode(TreeView1.Selections[1]).LinkedObject));

  If IsZero(Result, 0.000001) then
    MessageDlg('Die Gerade schneidet den Kreis', mtInformation, [mbOK], 0)
  else
    MessageDlg(Format('Der Abstand ist '+MakeNiceNumber(Result)+' (~ %0.3f)',[Result]), mtInformation, [mbOK], 0);
end;

procedure TForm1.AbstandKreisGeradeBestimmen(Sender: TObject);
var
  Result: single;
begin
  Result:=AbstandGeradeKreis(TGerade(TGlNode(TreeView1.Selections[1]).LinkedObject), TKreis(TGlNode(TreeView1.Selections[0]).LinkedObject));

  If IsZero(Result, 0.000001) then
    MessageDlg('Die Gerade schneidet den Kreis', mtInformation, [mbOK], 0)
  else
    MessageDlg(Format('Der Abstand ist '+MakeNiceNumber(Result)+' (~ %0.3f)',[Result]), mtInformation, [mbOK], 0);
end;

procedure TForm1.AbstandStreckeKreisBestimmen(Sender: TObject);
var
  Result: single;
begin
  Result:=AbstandStreckeKreis(TStrecke(TGlNode(TreeView1.Selections[0]).LinkedObject), TKreis(TGlNode(TreeView1.Selections[1]).LinkedObject));

  If IsZero(Result, 0.000001) then
    MessageDlg('Die Strecke schneidet den Kreis', mtInformation, [mbOK], 0)
  else
    MessageDlg(Format('Der Abstand ist '+MakeNiceNumber(Result)+' (~ %0.3f)',[Result]), mtInformation, [mbOK], 0);
end;

procedure TForm1.AbstandKreisStreckeBestimmen(Sender: TObject);
var
  Result: single;
begin
  Result:=AbstandStreckeKreis(TStrecke(TGlNode(TreeView1.Selections[1]).LinkedObject), TKreis(TGlNode(TreeView1.Selections[0]).LinkedObject));

  If IsZero(Result, 0.000001) then
    MessageDlg('Die Strecke schneidet den Kreis', mtInformation, [mbOK], 0)
  else
    MessageDlg(Format('Der Abstand ist '+MakeNiceNumber(Result)+' (~ %0.3f)',[Result]), mtInformation, [mbOK], 0);
end;

procedure CopyStats(var ResObj: TGLBaseSceneObject; Obj: TGLBaseSceneObject);
var
  i: integer;
begin
  TGLSceneObject(ResObj).Material.FrontProperties.Diffuse.Color:=
                              TGLSceneObject(Obj).Material.FrontProperties.Diffuse.Color;
  TGLSceneObject(ResObj).Material.BackProperties.Diffuse.Color:=
                              TGLSceneObject(Obj).Material.FrontProperties.Diffuse.Color;
  If ResObj is TPunkt then
    TPunkt(ResObj).Bezeichnung.Material.FrontProperties.Diffuse.Color:=
                              TGLSceneObject(Obj).Material.FrontProperties.Diffuse.Color;

  SetObjName(ResObj, GetObjName(Obj));
  for i:=0 to GetObjChildCount(Obj)-1 do
    AddObjChild(ResObj, GetObjName(GetObjChild(Obj, i)));
  for i:=0 to GetObjParentCount(Obj)-1 do
    AddObjParent(ResObj, GetObjName(GetObjParent(Obj, i)));
  SetObjCreationMode(ResObj, GetObjCreationMode(Obj));
end;

procedure ChangeChild(ChildObj: TGLBaseSceneObject; Variable: string);
var
  V1, V2, Pos, Dir: TVector3f;
  Obj, AltObj: TGLBaseSceneObject;
  Objekte: TSchnittObjekte;
  ResultObj: TGLBaseSceneObject;
  ResGerade: TGerade;
  Ebene: TEbene;
  Strecke: TStrecke;
  S: string;
  Node: TGLNode;
  i, c: integer;
  V: Boolean;
begin

  Obj:= ChildObj;

{  V:= True; i:=0;
  c:= GetObjParentCount(Obj);
  while V and (c > i) do begin
    if GetObjParent(Obj, i).Visible = False then
      V:= False;
    inc(i);
  end;
  If not V then begin
    Obj.Visible:= False;
    ChangeChildren(Obj);
    Exit;
  end; }

{  If not VarInObj(Obj, Variable) and (Variable <> '') then begin
    ChangeChildren(Obj, Variable);
    Exit;
  end;                            }

  If GetObjCreationMode(Obj) = 'Sdurch2P' then begin
    If VectorLength(VectorSubtract(TPunkt(GetObjParent(Obj, 0)).Position.AsAffineVector,
       TPunkt(GetObjParent(Obj, 1)).Position.AsAffineVector)) = 0 then

      Obj.Visible:=False
    else begin
      If Obj.TagFloat <> -2 then
        Obj.Visible:=True;
      V1:=TPunkt(GetObjParent(Obj, 0)).Koordinaten;
      V2:=TPunkt(GetObjParent(Obj, 1)).Koordinaten;
      TStrecke(Obj).ParamP1X1:=FloatToStr(V1[0]);
      TStrecke(Obj).ParamP1X2:=FloatToStr(V1[1]);
      TStrecke(Obj).ParamP1X3:=FloatToStr(V1[2]);
      TStrecke(Obj).ParamP2X1:=FloatToStr(V2[0]);
      TStrecke(Obj).ParamP2X2:=FloatToStr(V2[1]);
      TStrecke(Obj).ParamP2X3:=FloatToStr(V2[2]);
      Form1.SetStrecke(TStrecke(Obj), TPunkt(GetObjParent(Obj, 0)).Position.AsAffineVector,
                                      TPunkt(GetObjParent(Obj, 1)).Position.AsAffineVector);
    end;
  end;

  If GetObjCreationMode(Obj) = 'Gdurch2P' then begin
    If VectorLength(VectorSubtract(TPunkt(GetObjParent(Obj, 0)).Position.AsAffineVector,
       TPunkt(GetObjParent(Obj, 1)).Position.AsAffineVector)) = 0 then

      Obj.Visible:=False
    else begin
      If Obj.TagFloat <> -2 then
        Obj.Visible:=True;
      V1:=TPunkt(GetObjParent(Obj, 0)).Koordinaten;
      V2:=VectorSubtract(TPunkt(GetObjParent(Obj, 1)).Koordinaten,
                         TPunkt(GetObjParent(Obj, 0)).Koordinaten);
      TGerade(Obj).ParamPosX1:=FloatToStr(V1[0]);
      TGerade(Obj).ParamPosX2:=FloatToStr(V1[1]);
      TGerade(Obj).ParamPosX3:=FloatToStr(V1[2]);
      TGerade(Obj).ParamDirX1:=FloatToStr(V2[0]);
      TGerade(Obj).ParamDirX2:=FloatToStr(V2[1]);
      TGerade(Obj).ParamDirX3:=FloatToStr(V2[2]);
      Form1.SetGerade(TGerade(Obj), TPunkt(GetObjParent(Obj, 0)).Position.AsAffineVector,
                      VectorSubtract(TPunkt(GetObjParent(Obj, 1)).Position.AsAffineVector,
                                     TPunkt(GetObjParent(Obj, 0)).Position.AsAffineVector));
    end;
  end;

  If GetObjCreationMode(Obj) = 'Edurch3P' then begin
    Pos:=TPunkt(GetObjParent(Obj, 0)).Position.AsAffineVector;
    V1:=VectorSubtract(TPunkt(GetObjParent(Obj, 1)).Position.AsAffineVector, Pos);
    V2:=VectorSubtract(TPunkt(GetObjParent(Obj, 2)).Position.AsAffineVector, Pos);
    Dir:=VectorCrossProduct(V1, V2);
    If VectorLength(Dir) = 0 then
      Obj.Visible:=False
    else begin
      If Obj.TagFloat <> -2 then
        Obj.Visible:=True;
      TEbene(Obj).ParamPosX1:=FloatToStr(Pos[2]);
      TEbene(Obj).ParamPosX2:=FloatToStr(Pos[0]);
      TEbene(Obj).ParamPosX3:=FloatToStr(Pos[1]);
      TEbene(Obj).ParamDirX1:=FloatToStr(Dir[2]);
      TEbene(Obj).ParamDirX2:=FloatToStr(Dir[0]);
      TEbene(Obj).ParamDirX3:=FloatToStr(Dir[1]);
      TEbene(Obj).Param_N0:=FloatToStr(VectorDotProduct(Pos, Dir));
      Form1.SetEbene(TEbene(Obj), Pos, Dir);
      Form1.OptimiereEbene(TEbene(Obj));
    end;
  end;

  If GetObjCreationMode(Obj) = 'EdurchPG' then begin
    Pos:=TPunkt(GetObjParent(Obj, 0)).Position.AsAffineVector;
    V1:=VectorSubtract(TPunkt(GetObjParent(Obj, 1)).Position.AsAffineVector, Pos);
    V2:=TGerade(GetObjParent(Obj, 1)).Up.AsAffineVector;
    Dir:=VectorCrossProduct(V1, V2);
    If VectorLength(Dir) = 0 then
      Obj.Visible:=False
    else begin
      If Obj.TagFloat <> -2 then
        Obj.Visible:=True;
      TEbene(Obj).ParamPosX1:=FloatToStr(Pos[2]);
      TEbene(Obj).ParamPosX2:=FloatToStr(Pos[0]);
      TEbene(Obj).ParamPosX3:=FloatToStr(Pos[1]);
      TEbene(Obj).ParamDirX1:=FloatToStr(Dir[2]);
      TEbene(Obj).ParamDirX2:=FloatToStr(Dir[0]);
      TEbene(Obj).ParamDirX3:=FloatToStr(Dir[1]);
      TEbene(Obj).Param_N0:=FloatToStr(VectorDotProduct(Pos, Dir));
      Form1.SetEbene(TEbene(Obj), Pos, Dir);
      Form1.OptimiereEbene(TEbene(Obj));
   end;
  end;

  If GetObjCreationMode(Obj) = 'Schnitt' then begin
    If (GetObjParentCount(Obj) > 2) and Assigned(GetObjParent(Obj, 2)) then begin
      SetLength(Objekte, 4);
      Objekte[1]:=GetObjParent(Obj, 0);
      Objekte[2]:=GetObjParent(Obj, 1);
      Objekte[3]:=GetObjParent(Obj, 2);
      ResultObj:=ErmittleSchnittmenge(Objekte);
    end else begin
      SetLength(Objekte, 3);
      Objekte[1]:=GetObjParent(Obj, 0);
      Objekte[2]:=GetObjParent(Obj, 1);
      ResultObj:=ErmittleSchnittmenge(Objekte);
    end;
    If Assigned(ResultObj) then begin
      If Obj.TagFloat <> -2 then
        Obj.Visible:=True;

      If Obj.ClassType <> ResultObj.ClassType then begin

        If ResultObj is TPunkt then begin
          Form1.NewPunkt(0,0,0);
          AltObj:=Form1.Points.Children[Form1.Points.Count-1];
        end;

        If ResultObj is TStrecke then begin
          Form1.NewStrecke(0,0,0, 1, 0, 0);
          AltObj:=Form1.Strecken.Children[Form1.Strecken.Count-1];
        end;

        If ResultObj is TGerade then begin
          Form1.NewGerade(0,0,0, 1, 0, 0);
          AltObj:=Form1.Lines.Children[Form1.Lines.Count-1];
        end;

        If ResultObj is TKreis then begin
          Form1.NewKreis(0,0,0,0,1,0,1);
          AltObj:=Form1.Circles.Children[Form1.Circles.Count-1];
        end;

        If Assigned(AltObj) then
          AltObj.TagFloat:= ResultObj.TagFloat;

        S:= GetObjName(AltObj);

        // Copy the stats to the new Object
        CopyStats(AltObj, Obj);

        // Delete the old Object
        Node:= GetObjNode(GetObjName(Obj), Form1.TreeView1);
        Node.LinkedObject.Free;
        Node.Free;
        If Assigned(OldSelectedObjects) then
          OldSelectedObjects:=NIL;

        GetObjNode(S, Form1.TreeView1).Text:= GetObjName(AltObj);
        Obj:= AltObj;
      end;

      If Obj is TPunkt then begin
        V1:=ResultObj.Position.AsAffineVector;
        TPunkt(Obj).ParamPosX1:=FloatToStr(V1[2]);
        TPunkt(Obj).ParamPosX2:=FloatToStr(V1[0]);
        TPunkt(Obj).ParamPosX3:=FloatToStr(V1[1]);
        Form1.SetKugel(TKugel(Obj), V1, PUNKT_RADIUS);
      end;

      If Obj is TStrecke then begin
        V1[0]:=TStrecke(ResultObj).AnfangsPunkt[1];
        V1[1]:=TStrecke(ResultObj).AnfangsPunkt[2];
        V1[2]:=TStrecke(ResultObj).AnfangsPunkt[0];
        V2[0]:=TStrecke(ResultObj).EndPunkt[1];
        V2[1]:=TStrecke(ResultObj).EndPunkt[2];
        V2[2]:=TStrecke(ResultObj).EndPunkt[0];
        TStrecke(Obj).ParamP1X1:=FloatToStr(V1[2]);
        TStrecke(Obj).ParamP1X2:=FloatToStr(V1[0]);
        TStrecke(Obj).ParamP1X3:=FloatToStr(V1[1]);
        TStrecke(Obj).ParamP2X1:=FloatToStr(V2[2]);
        TStrecke(Obj).ParamP2X2:=FloatToStr(V2[0]);
        TStrecke(Obj).ParamP2X3:=FloatToStr(V2[1]);
        Form1.SetStrecke(TStrecke(Obj), V1, V2);

        If Obj.TagFloat = -1 then begin
          Form1.Endpunktezeichnen(TStrecke(Obj));
          GetObjNode(GetObjName(Obj), Form1.TreeView1).Destroy;
          Obj.Visible:= False;
          Obj.TagFloat:=-2; // do not show at any circumstances
        end;
      end;

      If Obj is TGerade then begin
        V1:=ResultObj.Position.AsAffineVector;
        V2:=ResultObj.Up.AsAffineVector;
        TGerade(Obj).ParamPosX1:=FloatToStr(V1[2]);
        TGerade(Obj).ParamPosX2:=FloatToStr(V1[0]);
        TGerade(Obj).ParamPosX3:=FloatToStr(V1[1]);
        TGerade(Obj).ParamDirX1:=FloatToStr(V2[2]);
        TGerade(Obj).ParamDirX2:=FloatToStr(V2[0]);
        TGerade(Obj).ParamDirX3:=FloatToStr(V2[1]);
        Form1.SetGerade(TGerade(Obj), V1, V2);
      end;

      If Obj is TKreis then begin
        V1:= ResultObj.Position.AsAffineVector;
        V2:= ResultObj.Direction.AsAffineVector;
        TKreis(Obj).ParamPosX1:=FloatToStr(V1[2]);
        TKreis(Obj).ParamPosX2:=FloatToStr(V1[0]);
        TKreis(Obj).ParamPosX3:=FloatToStr(V1[1]);
        TKreis(Obj).ParamDirX1:=FloatToStr(V2[2]);
        TKreis(Obj).ParamDirX2:=FloatToStr(V2[0]);
        TKreis(Obj).ParamDirX3:=FloatToStr(V2[1]);
        TKreis(Obj).ParamRadius:=FloatToStr(TKreis(ResultObj).MajorRadius);
        Form1.SetKreis(TKreis(Obj), V1, V2, TKreis(ResultObj).MajorRadius);
      end;

    end else begin
      Obj.Visible:=False;
    end;
  end;

  If GetObjCreationMode(Obj) = 'Normale' then begin
    If (GetObjParent(Obj, 1) is TGerade) or (GetObjParent(Obj, 1) is TStrecke) then begin
      V1:=GetObjParent(Obj, 0).Position.AsAffineVector;
      V2:=GetObjParent(Obj, 1).Up.AsAffineVector;
      V1:=VectorSubtract(GetObjParent(Obj, 1).Position.AsAffineVector, V1);
      If IsZero(abs(VectorAngleCosine(V1, V2))-1, 0.0000001)  then begin
        Obj.Visible:=False;
      end else begin
        If GetObjParent(Obj, 1) is TStrecke then begin
          V1[0]:= TStrecke(GetObjParent(Obj, 1)).AnfangsPunkt[1];
          V1[1]:= TStrecke(GetObjParent(Obj, 1)).AnfangsPunkt[2];
          V1[2]:= TStrecke(GetObjParent(Obj, 1)).AnfangsPunkt[0];
          V1:= VectorSubtract(GetObjParent(Obj, 0).Position.AsAffineVector, V1);
          V2[0]:= TStrecke(GetObjParent(Obj, 1)).EndPunkt[1];
          V2[1]:= TStrecke(GetObjParent(Obj, 1)).EndPunkt[2];
          V2[2]:= TStrecke(GetObjParent(Obj, 1)).EndPunkt[0];
          V2:= VectorSubtract(GetObjParent(Obj, 0).Position.AsAffineVector, V2);
          If ((VectorDotProduct(V1, GetObjParent(Obj, 1).Up.AsAffineVector) > 0) and
             (VectorDotProduct(V2, GetObjParent(Obj, 1).Up.AsAffineVector) > 0)) or
             ((VectorDotProduct(V1, GetObjParent(Obj, 1).Up.AsAffineVector) < 0) and
             (VectorDotProduct(V2, GetObjParent(Obj, 1).Up.AsAffineVector) < 0)) then begin
            Obj.Visible:= False;
            ChangeChildren(Obj);
            Exit; 
          end
        end;
        If Obj.TagFloat <> -2 then
          Obj.Visible:=True;
        ResGerade:=TGerade.Create(Form1);
        NormalePG(TGerade(ResGerade), TPunkt(GetObjParent(Obj, 0)), TGerade(GetObjParent(Obj, 1)));
        Pos[0]:=ResGerade.Aufpunkt[1];
        Pos[1]:=ResGerade.Aufpunkt[2];
        Pos[2]:=ResGerade.Aufpunkt[0];
        Dir[0]:=ResGerade.RichtungsVektor[1];
        Dir[1]:=ResGerade.RichtungsVektor[2];
        Dir[2]:=ResGerade.RichtungsVektor[0];
        TGerade(Obj).ParamPosX1:=FloatToStr(ResGerade.Aufpunkt[0]);
        TGerade(Obj).ParamPosX2:=FloatToStr(ResGerade.Aufpunkt[1]);
        TGerade(Obj).ParamPosX3:=FloatToStr(ResGerade.Aufpunkt[2]);
        TGerade(Obj).ParamDirX1:=FloatToStr(ResGerade.Richtungsvektor[0]);
        TGerade(Obj).ParamDirX2:=FloatToStr(ResGerade.Richtungsvektor[1]);
        TGerade(Obj).ParamDirX3:=FloatToStr(ResGerade.Richtungsvektor[2]);
        Form1.SetGerade(TGerade(Obj), pos, dir);
      end;
    end;
    If GetObjParent(Obj, 1) is TEbene then begin
      ResGerade:=TGerade.Create(Form1);
      NormalePE(TGerade(ResGerade), TPunkt(GetObjParent(Obj, 0)), TEbene(GetObjParent(Obj, 1)));
      Pos[0]:=ResGerade.Aufpunkt[1];
      Pos[1]:=ResGerade.Aufpunkt[2];
      Pos[2]:=ResGerade.Aufpunkt[0];
      Dir[0]:=ResGerade.RichtungsVektor[1];
      Dir[1]:=ResGerade.RichtungsVektor[2];
      Dir[2]:=ResGerade.RichtungsVektor[0];
      TGerade(Obj).ParamPosX1:=FloatToStr(ResGerade.Aufpunkt[0]);
      TGerade(Obj).ParamPosX2:=FloatToStr(ResGerade.Aufpunkt[1]);
      TGerade(Obj).ParamPosX3:=FloatToStr(ResGerade.Aufpunkt[2]);
      TGerade(Obj).ParamDirX1:=FloatToStr(ResGerade.Richtungsvektor[0]);
      TGerade(Obj).ParamDirX2:=FloatToStr(ResGerade.Richtungsvektor[1]);
      TGerade(Obj).ParamDirX3:=FloatToStr(ResGerade.Richtungsvektor[2]);
      Form1.SetGerade(TGerade(Obj), pos, dir);
    end;
  end;

  If GetObjCreationMode(Obj) = 'Spurgerade' then begin
    Ebene:= TEbene(GetObjParent(Obj, 0));

    If Obj.TagFloat <> -2 then
      Obj.Visible:=True;

    If Obj.Up.X = 0 then begin  // X1-X3-Ebene
      Pos:=AffineVectorMake(0, 0, Ebene.Achsenabschnitte[0]);
      Dir:=AffineVectorMake(0, Ebene.Achsenabschnitte[2], -Ebene.Achsenabschnitte[0]);
      If IsInfinite(VectorLength(dir)) then
        Obj.Visible:=False
      else
        Form1.SetGerade(TGerade(Obj), pos, dir);
    end;
    If Obj.Up.Y = 0 then begin  // X1-X2-Ebene
      Pos:=AffineVectorMake(0, 0, Ebene.Achsenabschnitte[0]);
      Dir:=AffineVectorMake(Ebene.Achsenabschnitte[1],0, -Ebene.Achsenabschnitte[0]);
      If IsInfinite(VectorLength(dir)) then
        Obj.Visible:=False
      else
        Form1.SetGerade(TGerade(Obj), pos, dir);
    end;
    If Obj.Up.Z = 0 then begin  // X2-X3-Ebene
      Pos:=AffineVectorMake(Ebene.Achsenabschnitte[1], 0, 0);
      Dir:=AffineVectorMake(-Ebene.Achsenabschnitte[1], Ebene.Achsenabschnitte[2], 0);
      If IsInfinite(VectorLength(dir)) then
        Obj.Visible:=False
      else
        Form1.SetGerade(TGerade(Obj), pos, dir);
    end;
  end;

  If GetObjCreationMode(Obj) = 'Anfangspunkt' then begin
    If Obj.TagFloat <> -2 then
      Obj.Visible:=True;

    Strecke:= TStrecke(GetObjParent(Obj, 0));

    TPunkt(Obj).Koordinaten:= Strecke.AnfangsPunkt;
    pos:=AffineVectorMake(Strecke.AnfangsPunkt[1],
                          Strecke.AnfangsPunkt[2],
                          Strecke.AnfangsPunkt[0]);
    Form1.SetKugel(TKugel(Obj), pos, 0);
  end;

  If GetObjCreationMode(Obj) = 'Endpunkt' then begin
    If Obj.TagFloat <> -2 then
      Obj.Visible:=True;

    Strecke:= TStrecke(FindObject(GetObjName(GetObjParent(Obj, 0))));

    TPunkt(Obj).Koordinaten:= Strecke.EndPunkt;
    pos:=AffineVectorMake(Strecke.EndPunkt[1],
                          Strecke.EndPunkt[2],
                          Strecke.EndPunkt[0]);
    Form1.SetKugel(TKugel(Obj), pos, 0);
  end;

  If GetObjCreationMode(Obj) = 'Ortslinie' then begin
    If not VarInObj(Obj, Variable) then
      ActualizeOrtsLinie(TOrtsLinie(Obj));
  end;

  // Change children of the children
  ChangeChildren(Obj, Variable);
end;

procedure ChangeChildren(Obj: TGLBaseSceneObject; Variable: string);
var
  Counter: integer;
begin
  for Counter:=0 to GetObjChildCount(Obj)-1 do
    If Assigned(GetObjChild(Obj, Counter)) then
      ChangeChild(GetObjChild(Obj, Counter), Variable);
end;

procedure TForm1.NotifyVarChange(Variable: TVariable);
var
  i, ChildCounter: integer;
  Punkt: TPunkt;
  Gerade: TGerade;
  Ebene: TEbene;
  Strecke: TStrecke;
  Kreis: TKreis;
  Kugel: TKugel;
  AffineVector1, AffineVector2: TAffineVector;
begin
  for i:=1 to Points.Count-1 do begin
    Punkt:=TPunkt(Points.Children[i]);
    if (pos(Variable.Name, Punkt.ParamPosX1)>0) or (pos(Variable.Name, Punkt.ParamPosX2)>0) or ((pos(Variable.Name, Punkt.ParamPosX3)>0)) then begin
      try
        SetVector(AffineVector1, ProcessLine(Punkt.ParamPosX2, VarsArchive),
                                 ProcessLine(Punkt.ParamPosX3, VarsArchive),
                                 ProcessLine(Punkt.ParamPosX1, VarsArchive));
        SetKugel(TKugel(Punkt), AffineVector1, PUNKT_RADIUS);
        If Punkt.TagFloat <> -2 then
          Punkt.Visible:= True;
      except
        Punkt.Visible:=False;
      end;

      ChangeChildren(Punkt, Variable.Name);

    end;
  end;

  for i:=1 to Strecken.Count-1 do begin
    Strecke:=TStrecke(Strecken.Children[i]);

    if (pos(Variable.Name, Strecke.ParamP1X1)>0) or (pos(Variable.Name, Strecke.ParamP1X2)>0)
    or (pos(Variable.Name, Strecke.ParamP1X3)>0) or (pos(Variable.Name, Strecke.ParamP2X1)>0)
    or (pos(Variable.Name, Strecke.ParamP2X2)>0) or (pos(Variable.Name, Strecke.ParamP2X3)>0) then begin
      try
        SetVector(AffineVector1, ProcessLine(Strecke.ParamP1X2, VarsArchive),
                                 ProcessLine(Strecke.ParamP1X3, VarsArchive),
                                 ProcessLine(Strecke.ParamP1X1, VarsArchive));
        SetVector(AffineVector2, ProcessLine(Strecke.ParamP2X2, VarsArchive),
                                 ProcessLine(Strecke.ParamP2X3, VarsArchive),
                                 ProcessLine(Strecke.ParamP2X1, VarsArchive));
        SetStrecke(Strecke, AffineVector1, AffineVector2);
        If Strecke.TagFloat <> -2 then
          Strecke.Visible:= True;
      except
        Strecke.Visible:=False;
      end;

      ChangeChildren(Strecke, Variable.Name);
    end;
  end;

  for i:=0 to Lines.Count-1 do begin
    Gerade:=TGerade(Lines.Children[i]);

    if (pos(Variable.Name, Gerade.ParamPosX1)>0) or (pos(Variable.Name, Gerade.ParamPosX2)>0)
    or (pos(Variable.Name, Gerade.ParamPosX3)>0) or (pos(Variable.Name, Gerade.ParamDirX1)>0)
    or (pos(Variable.Name, Gerade.ParamDirX2)>0) or (pos(Variable.Name, Gerade.ParamDirX3)>0) then begin
      try
        SetVector(AffineVector1, ProcessLine(Gerade.ParamPosX2, VarsArchive),
                                 ProcessLine(Gerade.ParamPosX3, VarsArchive),
                                 ProcessLine(Gerade.ParamPosX1, VarsArchive));
        SetVector(AffineVector2, ProcessLine(Gerade.ParamDirX2, VarsArchive),
                                 ProcessLine(Gerade.ParamDirX3, VarsArchive),
                                 ProcessLine(Gerade.ParamDirX1, VarsArchive));
        SetGerade(Gerade, AffineVector1, AffineVector2);
        If Gerade.TagFloat <> -2 then
          Gerade.Visible:= True;
      except
        Gerade.Visible:=False;
      end;

      ChangeChildren(Gerade, Variable.Name);
    end;
  end;

  for i:=1 to Planes.Count-1 do begin
    Ebene:=TEbene(Planes.Children[i]);
    if (pos(Variable.Name, Ebene.ParamPosX1)>0) or (pos(Variable.Name, Ebene.ParamPosX2)>0)
    or (pos(Variable.Name, Ebene.ParamPosX3)>0) or (pos(Variable.Name, Ebene.ParamDirX1)>0)
    or (pos(Variable.Name, Ebene.ParamDirX2)>0) or (pos(Variable.Name, Ebene.ParamDirX3)>0) then begin
      try
        SetVector(AffineVector1, ProcessLine(Ebene.ParamPosX2, VarsArchive),
                                 ProcessLine(Ebene.ParamPosX3, VarsArchive),
                                 ProcessLine(Ebene.ParamPosX1, VarsArchive));
        SetVector(AffineVector2, ProcessLine(Ebene.ParamDirX2, VarsArchive),
                                 ProcessLine(Ebene.ParamDirX3, VarsArchive),
                                 ProcessLine(Ebene.ParamDirX1, VarsArchive));
        Ebene.Visible:=True;
        SetEbene(Ebene, AffineVector1, AffineVector2);
        OptimiereEbene(Ebene);
        If Ebene.TagFloat <> -2 then
          Ebene.Visible:= True;
      except
        Ebene.Visible:=False;
      end;

{      for ChildCounter:=0 to GetObjChildCount(Ebene)-1 do
        ChangeChild(GetObjChild(Ebene, ChildCounter)); }

      ChangeChildren(Ebene, Variable.Name);
    end;
  end;

  for i:=1 to Circles.Count-1 do begin
    Kreis:=TKreis(Circles.Children[i]);
    if (pos(Variable.Name, Kreis.ParamPosX1)>0) or (pos(Variable.Name, Kreis.ParamPosX2)>0)
    or (pos(Variable.Name, Kreis.ParamPosX3)>0) or (pos(Variable.Name, Kreis.ParamDirX1)>0)
    or (pos(Variable.Name, Kreis.ParamDirX2)>0) or (pos(Variable.Name, Kreis.ParamDirX3)>0)
    or (pos(Variable.Name, Kreis.ParamRadius)>0) then begin
      try
        SetVector(AffineVector1, ProcessLine(Kreis.ParamPosX2, VarsArchive),
                                 ProcessLine(Kreis.ParamPosX3, VarsArchive),
                                 ProcessLine(Kreis.ParamPosX1, VarsArchive));
        SetVector(AffineVector2, ProcessLine(Kreis.ParamDirX2, VarsArchive),
                                 ProcessLine(Kreis.ParamDirX3, VarsArchive),
                                 ProcessLine(Kreis.ParamDirX1, VarsArchive));
        If Kreis.TagFloat <> -2 then
          Kreis.Visible:= True;
        If ProcessLine(Kreis.ParamRadius, VarsArchive) > 0 then
          SetKreis(Kreis, AffineVector1, AffineVector2, ProcessLine(Kreis.ParamRadius, VarsArchive))
        else
          Kreis.Visible:= False;
      except
        Kreis.Visible:=False;
      end;

{      for ChildCounter:=0 to GetObjChildCount(Kreis)-1 do
       ChangeChild(GetObjChild(Kreis, ChildCounter));}

      ChangeChildren(Kreis, Variable.Name);
    end;
  end;
  
  for i:=1 to Spheres.Count-1 do begin
    Kugel:=TKugel(Spheres.Children[i]);
    if (pos(Variable.Name, Kugel.ParamPosX1)>0) or (pos(Variable.Name, Kugel.ParamPosX2)>0)
    or (pos(Variable.Name, Kugel.ParamPosX3)>0) or (pos(Variable.Name, Kugel.ParamRadius)>0) then begin
      try
        SetVector(AffineVector1, ProcessLine(Kugel.ParamPosX2, VarsArchive),
                                 ProcessLine(Kugel.ParamPosX3, VarsArchive),
                                 ProcessLine(Kugel.ParamPosX1, VarsArchive));
        Kugel.Visible:=True;
        SetKugel(Kugel, AffineVector1, ProcessLine(Kugel.ParamRadius, VarsArchive));
        If Kugel.TagFloat <> -2 then
          Kugel.Visible:= True;
      except
        Kugel.Visible:=False;
      end;

{      for ChildCounter:=0 to GetObjChildCount(Kugel)-1 do
        ChangeChild(GetObjChild(Kugel, ChildCounter)); }

      ChangeChildren(Kugel, Variable.Name);
    end;
  end;

end;

procedure TForm1.GLSceneViewer1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
//  OptimizeGridScale(X1X2Grid);
end;

procedure TForm1.Edit1Change(Sender: TObject);
var
  s1, s2, s3: single;
begin
  try
    If (Edit1.Text <> '') and (Edit1.Text <> '0') and (pos(',', Edit1.Text) <> Length(Edit1.Text)) then begin
      s1:=StrToFloat(Edit1.Text);
      s2:=StrToFloat(Edit2.Text);
      Settings.FGrid.Scale:=s2/s1;
      Settings.FEnvironment.Massstab:=s1/s2;
      Settings.NotifyChanges;
    end;
  except
    Edit1.Undo;
  end;
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
  try
    if TrackBar1.Position < 0 then begin
      Edit1.Text:=IntToStr(round(intpower(10, -TrackBar1.Position)));
      Edit2.Text:='1';
    end else begin
      Edit2.Text:=IntToStr(round(intpower(10, TrackBar1.Position)));
      Edit1.Text:='1';
    end;
    Edit1.Modified:=True;
    Edit2.Modified:=True;
  except
  end;
end;

procedure TForm1.Edit2Change(Sender: TObject);
var
  s1, s2, s3: single;
begin
  try
    If (Edit2.Text <> '') and (Edit2.Text <> '0') then begin
      s1:=StrToFloat(Edit1.Text);
      s2:=StrToFloat(Edit2.Text);
      Settings.FGrid.Scale:=s2/s1;
      Settings.FEnvironment.Massstab:=s1/s2;
      Settings.NotifyChanges;
    end;
  except
  end;
end;

procedure TForm1.Edit3Change(Sender: TObject);
begin
  try
    If (StrToFloat(Edit3.Text) <> 0) and (Edit3.Text <> '') and (pos(',', Edit3.Text) <> Length(Edit3.Text)) then begin
//      ActualGridScale:=StrToFloat(Edit3.Text);
//      Settings.FGrid.Scale:=StrToFloat(Edit3.Text);
//      DoZoom(Settings.FEnvironment.Massstab);
      Settings.FGrid.Scale:=StrToFloat(Edit3.Text);
      Settings.NotifyChanges;
    end;
  except
  end;
end;

procedure TForm1.OpenVarWindow(Sender: TObject);
var
  VarName: string;
  i: integer;
begin
  VarName:=TMenuItem(Sender).Caption;
  Delete(VarName, 1, 1);
  i:=0;
  while (i < ParamForms.ComponentCount) and (ParamForms.Components[i].Name <> VarName) do
    inc(i);
  if i < ParamForms.ComponentCount then
    TForm(ParamForms.Components[i]).Show;
end;

procedure TForm1.CreateVarWindow(Sender: TObject);
var
  Variable: TVariable;
begin
  Variable:=VarsArchive[TMenuItem(Sender).MenuIndex];
  CreateParamForm(ParamForms, Variable);
end;

procedure TForm1.AllVarWindows(Sender: TObject);
var
  i, j: integer;
  OK: Boolean;
begin
  for i:=0 to Length(VarsArchive)-1 do begin
    OK:=True;
    for j:=0 to ParamForms.ComponentCount-1 do
      If (ParamForms.Components[j].Name = VarsArchive[i].Name) then begin
        OK:=False;
        If not (TForm(ParamForms.Components[j]).Visible) then begin
          TForm(ParamForms.Components[j]).Show;
        end;
      end;
    If OK then
      CreateVarWindow(TMenuItem(Sender).Parent.Items[i]);
  end;
end;

procedure TForm1.Variablen1Click(Sender: TObject);
var
  i, j: integer;
  Versch, Vars, Item: TMenuItem;
  OK: Boolean;
begin
 if Length(VarsArchive) > 0 then begin
  i:=0;
  while (i<MainMenu1.Items.Count) and (MainMenu1.Items[i].Name <> 'Verschiedenes') do
    i:=i+1;
  If i<MainMenu1.Items.Count then begin
    Versch:=MainMenu1.Items[i];
    Vars:=Versch.Find('Variablen');

    for i:=2 to Vars.Count do   // Seltsame Methode, aber geht net anders
      Vars.Delete(1);

    for i:= 0 to length(VarsArchive)-1 do begin
      OK:=True;
      for j:=0 to ParamForms.ComponentCount-1 do
        If (ParamForms.Components[j].Name = VarsArchive[i].Name) then begin
          OK:=False;
          If not (TForm(ParamForms.Components[j]).Visible) then begin
            Item:=TMenuItem.Create(Form1);
            Item.OnClick:=OpenVarWindow;
            Item.Caption:=VarsArchive[i].Name;
            Vars.Add(Item);
          end;
        end;
      If OK then begin
        Item:=TMenuItem.Create(Form1);
        Item.OnClick:=CreateVarWindow;
        Item.Caption:=VarsArchive[i].Name;
        Vars.Add(Item);
      end;
    end;

    Item:=TMenuItem.Create(Vars);
    Item.Caption:='Alle';
    Item.OnClick:=AllVarWindows;
    Vars.Add(Item);
    Vars.Delete(0); //Sehr seltsames Verhalten
  end;
 end;
end;

procedure TForm1.TreeView1Editing(Sender: TObject; Node: TTreeNode;
  var AllowEdit: Boolean);
begin
  TreeViewEditing:=True;
  If (TreeView1.Selected.Text = 'Punkte') or
     (TreeView1.Selected.Text = 'Strecken') or
     (TreeView1.Selected.Text = 'Geraden') or
     (TreeView1.Selected.Text = 'Ebenen') or
     (TreeView1.Selected.Text = 'Kugeln') then
    TreeView1.Selected.EndEdit(True);
end;

procedure TForm1.Koordinatensystem1Click(Sender: TObject);
begin
  Form10.Show;
end;

procedure TForm1.SettingLeftPaint(Sender: TObject);
begin
  VerlaufVertical(SettingLeft.Canvas, clMoneyGreen, clWhite, SettingLeft.Width, SettingLeft.Height);
end;

procedure TForm1.HeaderBox1Paint(Sender: TObject);
begin
  VerlaufVertical(TPaintBox(Sender).Canvas, clMoneyGreen, clGreen, TPaintBox(Sender).Width, TPaintBox(Sender).Height);
end;

procedure TForm1.KoordSysClick(Sender: TObject);
begin
  Settings.FGrid.Koordinates:= not Settings.FGrid.Koordinates;
  Settings.NotifyChanges;
end;

procedure TForm1.KoordSchrClick(Sender: TObject);
begin
  Settings.FGrid.Schrift:= not Settings.FGrid.Schrift;
  Settings.NotifyChanges;
end;

procedure TForm1.X1X2EbeneClick(Sender: TObject);
begin
  Settings.FGrid.X1X2Plane := not Settings.FGrid.X1X2Plane;
  Settings.NotifyChanges;
end;

procedure TForm1.X1X3EbeneClick(Sender: TObject);
begin
  Settings.FGrid.X1X3Plane := not Settings.FGrid.X1X3Plane;
  Settings.NotifyChanges;
end;

procedure TForm1.X2X3EbeneClick(Sender: TObject);
begin
  Settings.FGrid.X2X3Plane := not Settings.FGrid.X2X3Plane;
  Settings.NotifyChanges;
end;

procedure TForm1.X1X2RasterClick(Sender: TObject);
begin
  Settings.FGrid.X1X2Raster := not Settings.FGrid.X1X2Raster;
  Settings.NotifyChanges;
end;

procedure TForm1.X1X3RasterClick(Sender: TObject);
begin
  Settings.FGrid.X1X3Raster := not Settings.FGrid.X1X3Raster;
  Settings.NotifyChanges;
end;

procedure TForm1.X2X3RasterClick(Sender: TObject);
begin
  Settings.FGrid.X2X3Raster := not Settings.FGrid.X2X3Raster;
  Settings.NotifyChanges;
end;

procedure TForm1.ToggleLeftPanelClick(Sender: TObject);
var
  Ratio: single;
begin
  Ratio:= 1 + PanelLeft.Width / Form1.Width;

  If ToggleLeftPanel.Hint = 'Einstellungsleiste ausblenden' then begin
    ToggleLeftPanel.Hint:= 'Einstellungsleiste einblenden';

    // Adjust SceneScale
    GLCamera1.SceneScale:= GLCamera1.SceneScale * Ratio;
  end else begin
    ToggleLeftPanel.Hint:= 'Einstellungsleiste ausblenden';

    // Adjust SceneScale
    GLCamera1.SceneScale:= GLCamera1.SceneScale / Ratio;
  end;

  PanelLeft.Visible:= not PanelLeft.Visible;

end;

procedure TForm1.ToggleRightPanelClick(Sender: TObject);
var
  Ratio: single;
begin
  Ratio:= 1 + PanelRight.Width / Form1.Width;

  If ToggleRightPanel.Hint = 'Objektleiste ausblenden' then begin
    ToggleRightPanel.Hint:= 'Objektleiste einblenden';

    // Adjust SceneScale
    GLCamera1.SceneScale:= GLCamera1.SceneScale * Ratio;
  end else begin
    ToggleRightPanel.Hint:= 'Objektleiste ausblenden';

    // Adjust SceneScale
    GLCamera1.SceneScale:= GLCamera1.SceneScale / Ratio;
  end;
  PanelRight.Visible:= not PanelRight.Visible;
end;

procedure TForm1.MakeNormalClick(Sender: TObject);
var
  Gerade, Normale: TGerade;
  Obj1, Obj2: TGLBaseSceneObject;
  S: string;
  V1, V2: TAffineVector;
begin
  Gerade:= TGerade.Create(Self);
  If (TreeView1.SelectionCount = 2) and
     (((TreeView1.Selections[0].ImageIndex = 1) and
     ((TreeView1.Selections[1].ImageIndex = 2) or (TreeView1.Selections[1].ImageIndex = 3) or
     (TreeView1.Selections[1].ImageIndex = 5))) or
     ((TreeView1.Selections[1].ImageIndex = 1) and
     ((TreeView1.Selections[0].ImageIndex = 2) or (TreeView1.Selections[0].ImageIndex = 3) or
     (TreeView1.Selections[0].ImageIndex = 5)))) then begin

    If TreeView1.Selections[0].ImageIndex = 1 then begin
      Obj1:=TGLNode(TreeView1.Selections[0]).LinkedObject;
      Obj2:=TGLNode(TreeView1.Selections[1]).LinkedObject;
      If (TreeView1.Selections[1].ImageIndex = 2) or (TreeView1.Selections[1].ImageIndex = 5) then begin
        V1:=VectorSubtract(Obj1.Position.AsAffineVector, Obj2.Position.AsAffineVector);
        V2:=Obj2.Up.AsAffineVector;
        If IsZero(VectorLength(VectorCrossProduct(V1, V2)), 0.000001) then begin
           // Punkt auf der Geraden oder Strecke
           If TreeView1.Selections[0].ImageIndex = 2 then
             ShowMessage('Der Punkt liegt auf der Geraden, deswegen kann keine eindeutige Normale konstruiert werden')
           else
             ShowMessage('Der Punkt liegt auf der Strecke, deswegen kann keine eindeutige Normale konstruiert werden');
           Gerade.Free;
           Exit;
        end;
        S:='n(' + TreeView1.Selections[0].Text + ';' + TreeView1.Selections[1].Text + ')';

        // Prüfen ob die Normale die Strecke schneidet
        If TreeView1.Selections[0].ImageIndex = 5 then begin
          V1[0]:= TStrecke(Obj2).AnfangsPunkt[1];
          V1[1]:= TStrecke(Obj2).AnfangsPunkt[2];
          V1[2]:= TStrecke(Obj2).AnfangsPunkt[0];
          V1:= VectorSubtract(Obj1.Position.AsAffineVector, V1);
          V2[0]:= TStrecke(Obj2).EndPunkt[1];
          V2[1]:= TStrecke(Obj2).EndPunkt[2];
          V2[2]:= TStrecke(Obj2).EndPunkt[0];
          V2:= VectorSubtract(Obj1.Position.AsAffineVector, V2);
          If ((VectorDotProduct(V1, Obj2.Up.AsAffineVector) > 0) and
             (VectorDotProduct(V2, Obj2.Up.AsAffineVector) > 0)) or
             ((VectorDotProduct(V1, Obj2.Up.AsAffineVector) < 0) and
             (VectorDotProduct(V2, Obj2.Up.AsAffineVector) < 0)) then begin

            ShowMessage('Die Normale schneidet die Strecke nicht');
            Gerade.Free;
            Exit;
          end;
        end;

        NormalePG(Gerade, TPunkt(Obj1), TGerade(Obj2));
      end;
      If TreeView1.Selections[1].ImageIndex = 3 then begin
        S:='n(' + TreeView1.Selections[0].Text + ';' + TreeView1.Selections[1].Text + ')';
        NormalePE(Gerade, TPunkt(Obj1), TEbene(Obj2));
      end;
    end;

    If TreeView1.Selections[1].ImageIndex = 1 then begin
      Obj2:=TGLNode(TreeView1.Selections[0]).LinkedObject;
      Obj1:=TGLNode(TreeView1.Selections[1]).LinkedObject;
      If (TreeView1.Selections[0].ImageIndex = 2) or (TreeView1.Selections[0].ImageIndex = 5) then begin
        V1:=VectorSubtract(Obj1.Position.AsAffineVector, Obj2.Position.AsAffineVector);
        V2:=Obj2.Up.AsAffineVector;
        If IsZero(VectorLength(VectorCrossProduct(V1, V2)), 0.000001) then begin
           // Punkt auf der Geraden oder Strecke
           If TreeView1.Selections[0].ImageIndex = 2 then
             ShowMessage('Der Punkt liegt auf der Geraden, deswegen kann keine eindeutige Normale konstruiert werden')
           else
             ShowMessage('Der Punkt liegt auf der Strecke, deswegen kann keine eindeutige Normale konstruiert werden');
           Gerade.Free;
           Exit;
        end;

        S:='n(' + TreeView1.Selections[1].Text + ';' + TreeView1.Selections[0].Text + ')';

        // Prüfen ob die Normale die Strecke schneidet
        If TreeView1.Selections[0].ImageIndex = 5 then begin
          V1[0]:= TStrecke(Obj2).AnfangsPunkt[1];
          V1[1]:= TStrecke(Obj2).AnfangsPunkt[2];
          V1[2]:= TStrecke(Obj2).AnfangsPunkt[0];
          V1:= VectorSubtract(Obj1.Position.AsAffineVector, V1);
          V2[0]:= TStrecke(Obj2).EndPunkt[1];
          V2[1]:= TStrecke(Obj2).EndPunkt[2];
          V2[2]:= TStrecke(Obj2).EndPunkt[0];
          V2:= VectorSubtract(Obj1.Position.AsAffineVector, V2);
          If ((VectorDotProduct(V1, Obj2.Up.AsAffineVector) > 0) and
             (VectorDotProduct(V2, Obj2.Up.AsAffineVector) > 0)) or
             ((VectorDotProduct(V1, Obj2.Up.AsAffineVector) < 0) and
             (VectorDotProduct(V2, Obj2.Up.AsAffineVector) < 0)) then begin

            ShowMessage('Die Normale schneidet die Strecke nicht');
            Gerade.Free;
            Exit;
          end;
        end;

        NormalePG(Gerade, TPunkt(Obj1), TGerade(Obj2));
      end;
      If TreeView1.Selections[0].ImageIndex = 3 then begin
        S:='n(' + TreeView1.Selections[1].Text + ';' + TreeView1.Selections[0].Text + ')';
        NormalePE(Gerade, TPunkt(Obj1), TEbene(Obj2));
      end;
    end;

    // create new line as 'normal'
    NewGerade(Gerade.Aufpunkt[0], Gerade.Aufpunkt[1], Gerade.Aufpunkt[2],
              Gerade.RichtungsVektor[0], Gerade.RichtungsVektor[1], Gerade.RichtungsVektor[2],
              GetObjName(Obj1), GetObjName(Obj2), 'Normale');
    Normale:=TGerade(TGLNode(TreeView1.Selected).LinkedObject);
    Normale.ParamPosX1:=FloatToStr(Gerade.Aufpunkt[0]);
    Normale.ParamPosX2:=FloatToStr(Gerade.Aufpunkt[1]);
    Normale.ParamPosX3:=FloatToStr(Gerade.Aufpunkt[2]);
    Normale.ParamDirX1:=FloatToStr(Gerade.RichtungsVektor[0]);
    Normale.ParamDirX2:=FloatToStr(Gerade.RichtungsVektor[1]);
    Normale.ParamDirX3:=FloatToStr(Gerade.RichtungsVektor[2]);
    TreeView1.Selected.Text:=S;
    SetObjName(TGLNode(TreeView1.Selected).LinkedObject, S);
    RegisterActions(TGLNode(TreeView1.Selected).LinkedObject, 'Create');
    AddObjChild(Obj1, S);
    AddObjChild(Obj2, S);
    TreeView1Edited(Self, TreeView1.Selected, S);
    ActionList1.Delete(ActionList1.Count-1);
    ActionList1.ActualIndex:=ActionList1.ActualIndex-1;

    // Highlight the new object
    SetLength(SelectedObjects, 1);
    SelectedObjects[0]:=TGLNode(TreeView1.Selected).LinkedObject as TGLSceneObject;
    HighLight(2);

  end else begin
    ShowMessage('Wählen Sie bitte zuerst einen Punkt und eine Gerade oder Ebene aus');
  end;
  Gerade.Free;
end;

procedure TForm1.ToolButton8Click(Sender: TObject);
var
  i: integer;
begin
  If TreeView1.SelectionCount = 0 then begin
    ShowMessage('Markieren Sie bitte erst die Objekte, die Sie schneiden wollen');
    Exit;
  end;

  If TreeView1.SelectionCount = 1 then begin
    ShowMessage('Markieren Sie bitte mindestens zwei Objekte, die Sie schneiden wollen');
    Exit;
  end;

  Objekteschneiden(Self);
end;

procedure TForm1.ToolButton1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  StatusBar1.SimpleText:='Drei Koordinaten angeben';
end;

procedure TForm1.ToolButton2MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  StatusBar1.SimpleText:='Zwei Punkte durch Koordinaten angeben';
end;

procedure TForm1.ToolButton3MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  StatusBar1.SimpleText:='Zwei Punkte durch Koordinaten angeben, oder Punkt und Richtung';
end;

procedure TForm1.ToolButton4MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  StatusBar1.SimpleText:='Einen Punkt und zwei Richtungsvektoren, einen Punkt und die Normale, oder die Parameterform angeben';
end;

procedure TForm1.ToolButton5MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  StatusBar1.SimpleText:='Den Mittelpunkt und den Radius angeben';
end;

procedure TForm1.MakeNormalMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  StatusBar1.SimpleText:='Punkt und Gerade, oder Punkt und Ebene markieren';
end;

procedure TForm1.ToolButton8MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  StatusBar1.SimpleText:='Zwei oder mehr Objekte markieren zum Schneiden';
end;

procedure TForm1.BitBtn3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  GetOrCreateInertia(DummyCube1.Behaviours).RollSpeed:=1000*ROTATE_SENSITY;
end;

procedure TForm1.BitBtn3MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  If GetTickCount - TButton(Sender).Tag > 200 then
    GetOrCreateInertia(DummyCube1.Behaviours).RollSpeed:=0;
  TButton(Sender).Tag:= GetTickCount;
end;

procedure TForm1.BitBtn4MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  GetOrCreateInertia(DummyCube1.Behaviours).RollSpeed:=-1000*ROTATE_SENSITY;
end;

procedure TForm1.BitBtn4MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  If GetTickCount - TButton(Sender).Tag > 200 then
    GetOrCreateInertia(DummyCube1.Behaviours).RollSpeed:=0;
  TButton(Sender).Tag:= GetTickCount;
end;

procedure TForm1.BitBtn1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  GetOrCreateInertia(DummyCube1.Behaviours).TurnSpeed:=1000*ROTATE_SENSITY;
end;

procedure TForm1.BitBtn1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  If GetTickCount - TButton(Sender).Tag > 200 then
    GetOrCreateInertia(DummyCube1.Behaviours).TurnSpeed:=0;
  TButton(Sender).Tag:= GetTickCount;
end;

procedure TForm1.BitBtn2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  GetOrCreateInertia(DummyCube1.Behaviours).TurnSpeed:=-1000*ROTATE_SENSITY;
end;

procedure TForm1.BitBtn2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  If GetTickCount - TButton(Sender).Tag > 200 then
    GetOrCreateInertia(DummyCube1.Behaviours).TurnSpeed:=0;
  TButton(Sender).Tag:= GetTickCount;
end;

procedure TForm1.BitBtn6MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  GetOrCreateInertia(DummyCube1.Behaviours).PitchSpeed:=-1000*ROTATE_SENSITY;
end;

procedure TForm1.BitBtn6MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  If GetTickCount - TButton(Sender).Tag > 200 then
    GetOrCreateInertia(DummyCube1.Behaviours).PitchSpeed:=0;
  TButton(Sender).Tag:= GetTickCount;
end;

procedure TForm1.BitBtn5MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  GetOrCreateInertia(DummyCube1.Behaviours).PitchSpeed:=1000*ROTATE_SENSITY;
end;

procedure TForm1.BitBtn5MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  If GetTickCount - TButton(Sender).Tag > 200 then
    GetOrCreateInertia(DummyCube1.Behaviours).PitchSpeed:=0;
  TButton(Sender).Tag:= GetTickCount;
end;

procedure TForm1.DummyCube1Progress(Sender: TObject; const deltaTime,
  newTime: Double);
begin
  AdjustTicks(Ticks, Objects.Scale.X, Settings.FGrid.Scale);
end;

procedure TForm1.GLCamera1Progress(Sender: TObject; const deltaTime,
  newTime: Double);
begin
  If KameraTurning <> 0 then
    GLCamera1.Roll(KameraTurning*ROTATE_SENSITY*4);

  If not (CamPosX1.Focused or CamPosX2.Focused or CamPosX3.Focused) then begin
    CamPosX1.Text:= Format('%0.2g',[DummyCube1.AbsoluteToLocal(GLCamera1.Position.AsAffineVector)[2]]);
    CamPosX2.Text:= Format('%0.2g',[DummyCube1.AbsoluteToLocal(GLCamera1.Position.AsAffineVector)[0]]);
    CamPosX3.Text:= Format('%0.2g',[DummyCube1.AbsoluteToLocal(GLCamera1.Position.AsAffineVector)[1]]);
  end;
  
  If not (ZoomEdit.Focused) then
    ZoomEdit.Text:=Format('%0.3g',[GLCamera1.SceneScale]);
end;

procedure TForm1.CamPosX1Change(Sender: TObject);
var
  PosVector: TAffineVector;
begin
  If (TEdit(Sender).Text <> '') and (TEdit(Sender).Text <> '-') and
     (CamPosX1.Focused or CamPosX2.Focused or CamPosX3.Focused) then begin

    PosVector:=AffineVectorMake(StrToFloat(CamPosX2.Text),
                                StrToFloat(CamPosX3.Text),
                                StrToFloat(CamPosX1.Text));
    PosVector:=DummyCube1.LocalToAbsolute(PosVector);
//    Res:=GLCamera1.Position.AsAffineVector;
//    Res[TEdit(Sender).Tag]:=PosVector[TEdit(Sender).Tag];
    GLCamera1.Position.AsAffineVector:=PosVector;
  end;
end;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  If Button = TMouseButton(mbLeft) then
    KameraTurning:=1;
  If Button = TMouseButton(mbRight) then
    KameraTurning:=-1;
end;

procedure TForm1.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  KameraTurning:=0;
end;

procedure TForm1.ZoomPlusClick(Sender: TObject);
begin
  GLCamera1.SceneScale:=GLCamera1.SceneScale+0.1;
end;

procedure TForm1.ZoomMinusClick(Sender: TObject);
begin
  GLCamera1.SceneScale:=GLCamera1.SceneScale-0.1;
end;

procedure TForm1.ZoomEditChange(Sender: TObject);
begin
  If StrToFloat(ZoomEdit.Text) < 0 then
    ZoomEdit.Text:='0';

  If StrToFloat(ZoomEdit.Text) > 100 then
    ZoomEdit.Text:='100';

  try
    GLCamera1.SceneScale:=StrToFloat(ZoomEdit.Text);
  except
  end;
end;

procedure TForm1.ToolButton9Click(Sender: TObject);
begin
  With Form1 do
    If TreeView1.SelectionCount < 2 then
      ShowMessage('Wählen Sie bitte zuerst zwei Punkte aus')
    else
      StreckeDurch2Punkte(Self);
end;

procedure TForm1.ToolButton10Click(Sender: TObject);
begin
  With Form1 do
    If TreeView1.SelectionCount < 2 then
      ShowMessage('Wählen Sie bitte zuerst zwei Punkte aus')
    else
      GeradeDurch2Punkte(Self);
end;

procedure TForm1.ToolButton11Click(Sender: TObject);
begin
  With Form1 do
    If TreeView1.SelectionCount < 3 then
      ShowMessage('Wählen Sie bitte zuerst drei Punkte aus')
    else
      Constructions.EbeneDurch3Punkte(TreeView1);
end;

procedure TForm1.ToolButton12Click(Sender: TObject);
begin
  With Form1 do
    If TreeView1.SelectionCount < 2 then
      ShowMessage('Wählen Sie bitte zuerst einen Punkt und eine Gerade aus')
    else
      Constructions.EbeneDurchPunktGerade(TreeView1);
end;

procedure TForm1.ToolButton7Click(Sender: TObject);
begin
  If TreeView1.SelectionCount < 2 then
    ShowMessage('Wählen Sie bitte zuerst einen Punkt und eine Gerade aus')
  else
    Constructions.EbeneDurchPunktGerade(TreeView1);
end;

procedure TForm1.ToolButton9MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  StatusBar1.SimpleText:='Zwei Punkte markieren';
end;

procedure TForm1.ToolButton10MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  StatusBar1.SimpleText:='Zwei Punkte markieren';
end;

procedure TForm1.ToolButton11MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  StatusBar1.SimpleText:='Drei Punkte markieren';
end;

procedure TForm1.ToolButton12MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  StatusBar1.SimpleText:='Punkt und Gerade markieren';
end;

procedure TForm1.ToolButton7MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  StatusBar1.SimpleText:='Einen Punkt und eine Gerade markieren';
end;

procedure TForm1.ToolButton13Click(Sender: TObject);
var
  methods: array[1..6, 1..6] of TNotifyEvent;
  o1, o2: TGLBaseSceneObject;
begin
  methods[1,1]:= Abstand2PunkteBestimmen;
  methods[1,2]:= AbstandPunktGeradeBestimmen;
  methods[1,3]:= AbstandPunktEbeneBestimmen;
  methods[1,4]:= AbstandPunktKugelBestimmen;
  methods[1,5]:= AbstandPunktStreckeBestimmen;
  methods[1,6]:= AbstandPunktKreisBestimmen;
  methods[2,1]:= AbstandGeradePunktBestimmen;
  methods[2,2]:= Abstand2GeradenBestimmen;
  methods[2,3]:= AbstandGeradeEbeneBestimmen;
  methods[2,4]:= AbstandGeradeKugelBestimmen;
  methods[2,5]:= AbstandGeradeStreckeBestimmen;
  methods[2,6]:= AbstandGeradeKreisBestimmen;
  methods[3,1]:= AbstandEbenePunktBestimmen;
  methods[3,2]:= AbstandEbeneGeradeBestimmen;
  methods[3,3]:= Abstand2EbenenBestimmen;
  methods[3,4]:= AbstandEbeneKugelBestimmen;
  methods[3,5]:= AbstandEbeneStreckeBestimmen;
  methods[3,6]:= nil;
  methods[4,1]:= AbstandKugelPunktBestimmen;
  methods[4,2]:= AbstandKugelGeradeBestimmen;
  methods[4,3]:= AbstandKugelEbeneBestimmen;
  methods[4,4]:= Abstand2KugelnBestimmen;
  methods[4,5]:= AbstandKugelStreckeBestimmen;
  methods[4,6]:= nil;
  methods[5,1]:= AbstandStreckePunktBestimmen;
  methods[5,2]:= AbstandStreckeGeradeBestimmen;
  methods[5,3]:= AbstandStreckeEbeneBestimmen;
  methods[5,4]:= AbstandStreckeKugelBestimmen;
  methods[5,5]:= Abstand2StreckenBestimmen;
  methods[5,6]:= nil;
  methods[6,1]:= AbstandKreisPunktBestimmen;
  methods[6,2]:= AbstandKreisGeradeBestimmen;
  methods[6,3]:= nil;
  methods[6,4]:= nil;
  methods[6,5]:= nil;
  methods[6,6]:= nil;

  If TreeView1.SelectionCount < 2 then
    ShowMessage('Wählen Sie bitte zuerst zwei Objekte aus, zwischen denen der Abstand bestimmt werden soll');
  If TreeView1.SelectionCount > 2 then
    ShowMessage('Wählen Sie bitte nur zwei Objekte aus');
  If TreeView1.SelectionCount = 2 then begin
    o1:= TGLNode(TreeView1.Selections[0]).LinkedObject;
    o2:= TGLNode(TreeView1.Selections[1]).LinkedObject;
      If (o1 is TPunkt) and (o2 is TPunkt) then
        Abstand2PunkteBestimmen(Self);
      If (o1 is TGerade) and (o2 is TGerade) then
        Abstand2GeradenBestimmen(Self);
      If (o1 is TPunkt) and (o2 is TGerade) then
        AbstandPunktGeradeBestimmen(Self);
      If (o1 is TGerade) and (o2 is TPunkt) then
        AbstandGeradePunktBestimmen(Self);
      If (o1 is TPunkt) and (o2 is TEbene) then
        AbstandPunktEbeneBestimmen(Self);
      If (o1 is TEbene) and (o2 is TPunkt) then
        AbstandEbenePunktBestimmen(Self);
      If (o1 is TGerade) and (o2 is TEbene) then
        AbstandGeradeEbeneBestimmen(Self);
      If (o1 is TEbene) and (o2 is TGerade) then
        AbstandEbeneGeradeBestimmen(Self);
      If (o1 is TEbene) and (o2 is TEbene) then
        Abstand2EbenenBestimmen(Self);
      If (o1 is TPunkt) and (o2 is TStrecke) then
        AbstandPunktStreckeBestimmen(Self);
      If (TreeView1.Selections[0].ImageIndex = 5) and (TreeView1.Selections[1].ImageIndex = 1) then
        AbstandStreckePunktBestimmen(Self);
      If (TreeView1.Selections[0].ImageIndex = 5) and (TreeView1.Selections[1].ImageIndex = 2) then
        AbstandStreckeGeradeBestimmen(Self);
      If (TreeView1.Selections[0].ImageIndex = 2) and (TreeView1.Selections[1].ImageIndex = 5) then
        AbstandGeradeStreckeBestimmen(Self);
      If (TreeView1.Selections[0].ImageIndex = 5) and (TreeView1.Selections[1].ImageIndex = 5) then
        Abstand2StreckenBestimmen(Self);
      If (TreeView1.Selections[0].ImageIndex = 3) and (TreeView1.Selections[1].ImageIndex = 5) then
        AbstandEbeneStreckeBestimmen(Self);
      If (TreeView1.Selections[0].ImageIndex = 5) and (TreeView1.Selections[1].ImageIndex = 3) then
        AbstandStreckeEbeneBestimmen(Self);
      If (TreeView1.Selections[0].ImageIndex = 1) and (TreeView1.Selections[1].ImageIndex = 4) then
        AbstandPunktKugelBestimmen(Self);
      If (TreeView1.Selections[0].ImageIndex = 4) and (TreeView1.Selections[1].ImageIndex = 1) then
        AbstandKugelPunktBestimmen(Self);
      If (TreeView1.Selections[0].ImageIndex = 2) and (TreeView1.Selections[1].ImageIndex = 4) then
        AbstandGeradeKugelBestimmen(Self);
      If (TreeView1.Selections[0].ImageIndex = 4) and (TreeView1.Selections[1].ImageIndex = 2) then
        AbstandKugelGeradeBestimmen(Self);
      If (TreeView1.Selections[0].ImageIndex = 5) and (TreeView1.Selections[1].ImageIndex = 4) then
        AbstandStreckeKugelBestimmen(Self);
      If (TreeView1.Selections[0].ImageIndex = 4) and (TreeView1.Selections[1].ImageIndex = 5) then
        AbstandKugelStreckeBestimmen(Self);
      If (TreeView1.Selections[0].ImageIndex = 3) and (TreeView1.Selections[1].ImageIndex = 4) then
        AbstandEbeneKugelBestimmen(Self);
      If (TreeView1.Selections[0].ImageIndex = 4) and (TreeView1.Selections[1].ImageIndex = 3) then
        AbstandKugelEbeneBestimmen(Self);
      If (TreeView1.Selections[0].ImageIndex = 4) and (TreeView1.Selections[1].ImageIndex = 4) then
        Abstand2KugelnBestimmen(Self);
      If (TreeView1.Selections[0].ImageIndex = 1) and (TreeView1.Selections[1].ImageIndex = 6) then
        AbstandPunktKreisBestimmen(Self);
      If (TreeView1.Selections[0].ImageIndex = 6) and (TreeView1.Selections[1].ImageIndex = 1) then
        AbstandKreisPunktBestimmen(Self);
      If (TreeView1.Selections[0].ImageIndex = 2) and (TreeView1.Selections[1].ImageIndex = 6) then
        AbstandGeradeKreisBestimmen(Self);
      If (TreeView1.Selections[0].ImageIndex = 6) and (TreeView1.Selections[1].ImageIndex = 2) then
        AbstandKreisGeradeBestimmen(Self);
      If (TreeView1.Selections[0].ImageIndex = 5) and (TreeView1.Selections[1].ImageIndex = 6) then
        AbstandStreckeKreisBestimmen(Self);
      If (TreeView1.Selections[0].ImageIndex = 6) and (TreeView1.Selections[1].ImageIndex = 5) then
        AbstandKreisStreckeBestimmen(Self);
  end;
end;

procedure TForm1.ToolButton14Click(Sender: TObject);
begin
  If TreeView1.SelectionCount < 2 then
    ShowMessage('Wählen Sie bitte zuerst zwei Objekte aus, zwischen denen der Winkel bestimmt werden soll');
  If TreeView1.SelectionCount > 2 then
    ShowMessage('Wählen Sie bitte nur zwei Objekte aus');
  If TreeView1.SelectionCount = 2 then begin
      If (TreeView1.Selections[0].ImageIndex = 2) and (TreeView1.Selections[1].ImageIndex = 3) then
        WinkelGeradeEbeneBestimmen(Self);
      If (TreeView1.Selections[0].ImageIndex = 3) and (TreeView1.Selections[1].ImageIndex = 2) then
        WinkelEbeneGeradeBestimmen(Self);
      If (TreeView1.Selections[0].ImageIndex = 3) and (TreeView1.Selections[1].ImageIndex = 3) then
        Winkel2EbenenBestimmen(Self);
      If (TreeView1.Selections[0].ImageIndex = 2) and (TreeView1.Selections[1].ImageIndex = 2) then
        Winkel2GeradenBestimmen(Self);

      // Strecken mit anderen(genau wie Geraden)  
      If (TreeView1.Selections[0].ImageIndex = 2) and (TreeView1.Selections[1].ImageIndex = 5) then
        Winkel2GeradenBestimmen(Self);
      If (TreeView1.Selections[0].ImageIndex = 5) and (TreeView1.Selections[1].ImageIndex = 2) then
        Winkel2GeradenBestimmen(Self);
      If (TreeView1.Selections[0].ImageIndex = 5) and (TreeView1.Selections[1].ImageIndex = 5) then
        Winkel2GeradenBestimmen(Self);
      If (TreeView1.Selections[0].ImageIndex = 5) and (TreeView1.Selections[1].ImageIndex = 3) then
        WinkelGeradeEbeneBestimmen(Self);
      If (TreeView1.Selections[0].ImageIndex = 3) and (TreeView1.Selections[1].ImageIndex = 5) then
        WinkelEbeneGeradeBestimmen(Self);
  end;
end;

procedure TForm1.KonstruktionsverlaufSpeichern1Click(Sender: TObject);
begin
  SaveDialog1.Filter:='Vectory - Skript|*.vsc';
  If SaveDialog1.Execute then
    ActionList1.SaveToFile(SaveDialog1.FileName);
end;

procedure TForm1.Bearbeiten1Click(Sender: TObject);
begin
  If ActionList1.ActualIndex = 0 then
    Rckgngig1.Enabled:=False
  else
    Rckgngig1.Enabled:=True;

  If ActionList1.ActualIndex = ActionList1.Count then
    Wiederherstellen1.Enabled:=False
  else
    Wiederherstellen1.Enabled:=True;
end;

procedure TForm1.Info1Click(Sender: TObject);
begin
  InfoScreen.Show;
end;

procedure TForm1.ToolButton16Click(Sender: TObject);
begin
  KreisForm.Show;
end;

procedure TForm1.MenuItem4Click(Sender: TObject);
var
  i: integer;
  Node: TTreeNode;
begin
  i:=0;
  while TreeView1.Items[i].Text<>'Kreise' do
    i:=i+1;
  Node:=TreeView1.Items[i];

  for i:=Node.Count-1 downto 0 do
    DeleteObject(TGLNode(Node.Item[i]), True, True);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  If GLCamera1.CameraStyle = csPerspective then begin
    GLCamera1.CameraStyle:= csOrthogonal;
    GLCamera1.SceneScale:= GLCamera1.SceneScale / 10;
    DarstellungsArtLabel.Caption:='orthogonal';
  end else
    If GLCamera1.CameraStyle = csOrthogonal then begin
      GLCamera1.CameraStyle:= csPerspective;
      GLCamera1.SceneScale:= GLCamera1.SceneScale * 10;
      DarstellungsArtLabel.Caption:='perspektivisch';
    end;
end;

procedure TForm1.HeaderBox3Click(Sender: TObject);
begin
  If Panel6.Height = 332 then
    Panel6.Height:= HeaderBox3.Height + 4
  else
    Panel6.Height:= 332;
end;

procedure TForm1.HeaderBox2Click(Sender: TObject);
begin
  If Panel4.Height = 161 then
    Panel4.Height:= HeaderBox2.Height + 4
  else
    Panel4.Height:= 161;
end;

procedure TForm1.HeaderBox1Click(Sender: TObject);
begin
  If Massstab.Height = 108 then
    Massstab.Height:= HeaderBox1.Height + 4
  else
    Massstab.Height:= 108;
end;

procedure TForm1.ToolButton17MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  StatusBar1.SimpleText:='Einen Punkt markieren';
end;

procedure TForm1.ToolButton17Click(Sender: TObject);
begin
  If (TreeView1.SelectionCount <> 1) or not (TGLNode(TreeView1.Selected).LinkedObject is TPunkt) then
    ShowMessage('Wählen Sie bitte erst einen Punkt aus')
  else
    OrtsLinieTool.Show;
end;

procedure TForm1.EbeneDurch3Punkte(Sender: TObject);
begin
  Constructions.EbeneDurch3Punkte(TreeView1);
end;

procedure TForm1.EbeneDurchPunktGerade(Sender: TObject);
begin
  Constructions.EbeneDurchPunktGerade(TreeView1);
end;

procedure TForm1.GeradeDurch2Punkte(Sender: TObject);
begin
  Constructions.GeradeDurch2Punkte(TreeView1);
end;
procedure TForm1.StreckeDurch2Punkte(Sender: TObject);
begin
  Constructions.StreckeDurch2Punkte(TreeView1);
end;
procedure TForm1.Objekteschneiden(Sender: TObject);
begin
  Constructions.ObjekteSchneiden(TreeView1);
end;

end.
