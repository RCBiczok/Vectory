unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GLObjects, GLScene, GLWin32Viewer, GLMisc, Math;

type
  TForm1 = class(TForm)
    GLScene1: TGLScene;
    GLSceneViewer1: TGLSceneViewer;
    Cam: TGLCamera;
    Punkt: TSphere;
    GLLightSource1: TGLLightSource;
    Target: TDummyCube;
    Lines1: TLines;
    Lines2: TLines;
    Lines3: TLines;
    procedure GLSceneViewer1MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure GLSceneViewer1MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  mx, my: integer;

implementation

{$R *.dfm}

procedure TForm1.GLSceneViewer1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  mx:=X; my:=Y;
end;

procedure TForm1.GLSceneViewer1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  dx, dy: integer;
begin
  dx:= mx-X; dy:=my-Y;
  If ssLeft in Shift then
    Cam.MoveAroundTarget(dy, dx);

  If ssRight in Shift then begin
    If abs( dx / dy ) > 4 then
      Punkt.Position.X:=Punkt.Position.X-dx/100
    else
    If abs( dy / dx ) > 4 then
      Punkt.Position.Y:=Punkt.Position.Y+dy/100
    else
      Punkt.Position.Z:=Punkt.Position.Z+sqrt(dx*dx/10000+dy*dy/10000)*Sign(dy);
  end;
  mx:=X; my:=Y;
end;

end.
