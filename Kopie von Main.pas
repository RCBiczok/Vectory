unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GLScene, GLWin32Viewer, GLMisc, ToolWin, ComCtrls, Menus,
  StdCtrls, GLObjects, GLNavigator, GLGraph, GLHUDObjects, GLSpaceText, Math,
  Geometry, GLTexture, GLParticles, VectorTypes, ExtCtrls;

type
  TGerade = class(TLines)
  public
    Richtung: TCone;
    RichtungsVektor: TVector3f;
    Aufpunkt: TVector3f;
  end;

  TEbene = class(TPlane)
  public
    NormalenVektor: TVector3f;
    Aufpunkt: TVector3f;
    Achsenabschnitte: TVector3f;
  end;

  TForm1 = class(TForm)
    StatusBar1: TStatusBar;
    GroupBox1: TGroupBox;
    TreeView1: TTreeView;
    MainMenu1: TMainMenu;
    Datei1: TMenuItem;
    GLScene1: TGLScene;
    GLSceneViewer1: TGLSceneViewer;
    GLCamera1: TGLCamera;
    GLLightSource1: TGLLightSource;
    DummyCube1: TDummyCube;
    x1: TLines;
    x2: TLines;
    x3: TLines;
    Cone1: TCone;
    Cone2: TCone;
    Cone3: TCone;
    X2X3Grid1: TXYZGrid;
    X1X3Grid2: TXYZGrid;
    X1X2Grid1: TXYZGrid;
    SpaceText1: TSpaceText;
    SpaceText2: TSpaceText;
    SpaceText3: TSpaceText;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    NeuesObjekterstellen1: TMenuItem;
    Ebene1: TMenuItem;
    Ebene2: TMenuItem;
    Planes: TGLParticles;
    EbenenMenu: TPopupMenu;
    NeueEbeneerstellen1: TMenuItem;
    AlleEbenenlschen1: TMenuItem;
    GeradenMenu: TPopupMenu;
    GeradeErstellen: TMenuItem;
    Memo1: TMemo;
    Splitter1: TSplitter;
    AlleGeradenlschen1: TMenuItem;
    Lines: TDummyCube;
    procedure GLSceneViewer1MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure GLSceneViewer1MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure Ebene2Click(Sender: TObject);
    procedure SetEbene(Ebene: TEbene; pos, dir: TGLCoordinates);
    procedure SetGerade(Gerade: TGerade; pos, dir: TGLCoordinates);
    procedure FormCreate(Sender: TObject);
    procedure TreeView1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure NeueEbeneerstellen1Click(Sender: TObject);
    procedure AlleEbenenlschen1Click(Sender: TObject);
    procedure GeradeErstellenClick(Sender: TObject);
    procedure AlleGeradenlschen1Click(Sender: TObject);
  private
    { Private declarations }
    mdx, mdy : Integer;
  public
    { Public declarations }
    procedure NewEbene(n1,n2,n3,n0: single); overload;
    procedure NewEbene(p1,p2,p3,a1,a2,a3,b1,b2,b3: single); overload;
    procedure NewGerade(p1,p2,p3,v1,v2,v3: single); overload;
  end;

var
  Form1: TForm1;

//  PlaneArray: Array[0..9] of TPlane;
//  LineArray: Array[0..9] of TLines;


implementation

uses GeradenTool, EbenenTool;

{$R *.dfm}

procedure ZeigeDaten(Ebene: TEbene; Memo: TMemo);
begin
  With Memo.Lines do begin
    Clear;
    Add('Eigenschaften'); Add('=====================');
    Add('');
    Add('Aufpunkt:');
    Add(Format('(%3.3f| %3.3f| %3.3f)',
        [Ebene.Aufpunkt[0],Ebene.Aufpunkt[1],Ebene.Aufpunkt[2]]));
    Add('');
    Add('Normalenvektor:');
    Add(Format('(%3.3f| %3.3f| %3.3f)',
        [Ebene.NormalenVektor[0],Ebene.NormalenVektor[1],Ebene.NormalenVektor[2]]));
    Add('');
    Add('Achsenabschnitte:');
    Add('x1: ' + Format('%3.3f', [Ebene.Achsenabschnitte[0]]));
    Add('x2: ' + Format('%3.3f', [Ebene.Achsenabschnitte[1]]));
    Add('x3: ' + Format('%3.3f', [Ebene.Achsenabschnitte[2]]));
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

procedure TForm1.GLSceneViewer1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 mdx:=x; mdy:=y;
end;

procedure TForm1.GLSceneViewer1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
 dx, dy : Integer;
begin
 // calculate delta since last move or last mousedown
 dx:=mdx-x; dy:=mdy-y;
 mdx:=x; mdy:=y;
 if ssLeft in Shift then
 if not (ssShift in Shift) then begin
  GLCamera1.MoveAroundTarget(dy, dx);
  GlLightSource1.SpotDirection.X:=-GlCamera1.Position.X;
  GlLightSource1.SpotDirection.Y:=-GlCamera1.Position.Y;
  GlLightSource1.SpotDirection.Z:=-GlCamera1.Position.Z;
 end else
  GLCamera1.RotateObject(DummyCube1, dy, dx);
end;

procedure TForm1.FormMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
 GLCamera1.SceneScale:=GLCamera1.SceneScale+WheelDelta*0.001;
end;

procedure TForm1.SetEbene(Ebene: TEbene; pos, dir: TGLCoordinates);
begin
  With Ebene do begin
    Position:=Pos;
    Direction:=Dir;
  end;

//== Werte speichern
  Ebene.Aufpunkt:=Pos.AsAffineVector;
  Ebene.NormalenVektor:=Dir.AsAffineVector;
  Ebene.Achsenabschnitte[0]:=VectorDotProduct(Dir.AsAffineVector, Pos.AsAffineVector)/Dir.X;
  Ebene.Achsenabschnitte[1]:=VectorDotProduct(Dir.AsAffineVector, Pos.AsAffineVector)/Dir.Y;
  Ebene.Achsenabschnitte[2]:=VectorDotProduct(Dir.AsAffineVector, Pos.AsAffineVector)/Dir.Z;
end;

procedure TForm1.NewEbene(n1,n2,n3,n0: single);
var
  Dir, Pos: TGLCoordinates;
  VLength: single;
  Node: TTreeNode;
  Vector: TVector4f;
  i: integer;
begin

//== Neue Ebene als Particle erzeugen
  With TEbene(Planes.CreateParticle) do begin
    Material.FaceCulling:=fcNoCull;
    SetVector(Vector,Random,Random,Random,0.8);
    Material.FrontProperties.Diffuse.Initialize(Vector);
    Material.BackProperties.Diffuse.Initialize(Vector);
  end;

//== Direction und Position initialisieren(Umgekehrte Achsen beachten)
  VLength:=VectorLength(n1,n2,n3);
  Pos:=TGLCoordinates.Create(Form1);
  Dir:=TGLCoordinates.Create(Form1);
  Pos.X:=-n2*n0/(VLength*VLength);
  Pos.Y:=-n3*n0/(VLength*VLength);
  Pos.Z:=-n1*n0/(VLength*VLength);
  Dir.X:=n2; Dir.Y:=n3; Dir.Z:=n1;

//== Ebene registrieren
  i:=0;
  while TreeView1.Items[i].Text<>'Ebenen' do
    i:=i+1;
  Node:=TreeView1.Items[i];
  Node:=TreeView1.Items.AddChild(Node, 'E'+IntToStr(Planes.Count-1));
  Node.Selected:=True;
  Node.EditText;

//== Ebene zeichnen
  SetEbene(TEbene(Planes.Children[Planes.Count-1]), pos, dir);
  ZeigeDaten(TEbene(Planes.Children[Planes.Count-1]), Memo1);
  Pos.Destroy; Dir.Destroy;
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

procedure TForm1.SetGerade(Gerade: TGerade; pos, dir: TGLCoordinates);
begin
  With Gerade do begin
    Position:=Pos;
    Direction:=Dir;
  end;
end;

procedure TForm1.NewGerade(p1,p2,p3,v1,v2,v3: single);
var
  pos, dir: TGLCoordinates;
  Node: TTreeNode;
  i: integer;
begin
//== Neue Gerade erstellen
  With TGerade(Lines.AddNewChild(TGerade)) do begin
    Nodes.AddNode(0,0,-7);
    Nodes.AddNode(0,0,7);
    NodesAspect:=lnaInvisible;
  end;
//== Direction und Position initialisieren
  pos:=TGLCoordinates.Create(Form1);
  dir:=TGLCoordinates.Create(Form1);
  pos.X:=p2; pos.Y:=p3; pos.Z:=p1;
  dir.X:=v2; dir.Y:=v3; dir.Z:=v1;

//== Gerade registrieren
  i:=0;
  while TreeView1.Items[i].Text<>'Geraden' do
    i:=i+1;
  Node:=TreeView1.Items[i];
  Node:=TreeView1.Items.AddChild(Node, 'g'+IntToStr(Lines.Count));
  Node.Selected:=True;
  Node.EditText;

//== Gerade zeichnen
  SetGerade(TGerade(Lines.Children[Lines.Count-1]),pos,dir);
  Pos.Destroy; Dir.Destroy;
end;

procedure TForm1.Ebene2Click(Sender: TObject);
begin
  Form2.Show;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Randomize;
  With TEbene(Planes.AddNewChild(TEbene)) do begin
    Height:=11; Width:=11;
    Material.BlendingMode:=bmTransparency;
  end;
end;

procedure TForm1.TreeView1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Memo1.Lines.Clear;
  Memo1.Lines.Add('Eigenschaften');
  Memo1.Lines.Add('=====================');
  If ssRight in Shift then TreeView1.GetNodeAt(X, Y).Selected := True;
    Case TreeView1.Selected.Level of
      0: begin
           Case TreeView1.Selected.Index of
             0: begin
                end;
             1: begin
                  TreeView1.PopupMenu := GeradenMenu;
                end;
             2: begin
                  TreeView1.PopupMenu := EbenenMenu;
                end;
             3: begin
                end;
           end;
         end;
      1: begin
           Case TreeView1.Selected.Parent.Index of
             0: begin
                  // Punkt
                end;
             1: begin
                  // Gerade
                end;
             2: begin
                  // Ebene
                  ZeigeDaten(TEbene(Planes.Children[TreeView1.Selected.Index+1]),Memo1);
{                  TEbene(Planes.Children[TreeView1.Selected.Index+1]).Material.FrontProperties.Diffuse.Red:=
                  TEbene(Planes.Children[TreeView1.Selected.Index+1]).Material.FrontProperties.Diffuse.Red*2;
                  TEbene(Planes.Children[TreeView1.Selected.Index+1]).Material.FrontProperties.Diffuse.Blue:=
                  TEbene(Planes.Children[TreeView1.Selected.Index+1]).Material.FrontProperties.Diffuse.Blue*2;
                  TEbene(Planes.Children[TreeView1.Selected.Index+1]).Material.FrontProperties.Diffuse.Green:=
                  TEbene(Planes.Children[TreeView1.Selected.Index+1]).Material.FrontProperties.Diffuse.Green*2;}
                end;
             3: begin
                  // Kugel
                end;
           end;
         end;
    end;
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
  Node.DeleteChildren;
  for i:=1 to Planes.Count-1 do
    Planes.KillParticle(Planes.Children[1]);
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
  Node.DeleteChildren;
  Lines.DeleteChildren;
  Lines.StructureChanged;
end;

end.
