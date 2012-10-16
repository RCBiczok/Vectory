unit Constructions;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, GLScene, GLWin32Viewer, GLMisc, ToolWin, ComCtrls, Menus,
  StdCtrls, GLObjects, GLNavigator, GLGraph, GLSpaceText, Math,
  VectorGeometry, GLTexture, GLParticles, GLContext, VectorTypes, ExtCtrls, GLCadencer,
  GLTreeView, ActionList, Primitives, Types;

procedure EbeneDurch3Punkte(TreeView1: TTreeView);
procedure EbeneDurchPunktGerade(TreeView1: TTreeView);
procedure GeradeDurch2Punkte(TreeView1: TTreeView);
procedure StreckeDurch2Punkte(TreeView1: TTreeView);
procedure Objekteschneiden(TreeView1: TTreeView);

implementation

uses
  Main, SchnittBerechnung;

procedure Objekteschneiden(TreeView1: TTreeView);
var
  i: integer;
  Objekte, Obj: TSchnittObjekte;
  ResultObject: TGLBaseSceneObject;
  s, str: String;
  Parents: TStringDynArray;
  Strecke: TStrecke;
begin
  SetLength(Objekte, TreeView1.SelectionCount+1);
  SetLength(Obj, TreeView1.SelectionCount);
  s := 'S(';
  for i :=0 to TreeView1.SelectionCount-2 do
    s:=s+TreeView1.Selections[i].Text+';';
  s:=s+TreeView1.Selections[TreeView1.SelectionCount-1].Text+')';

  for i:=0 to TreeView1.SelectionCount-1 do begin
    Objekte[i+1]:=TGLNode(TreeView1.Selections[i]).LinkedObject;
    Obj[i]:=TGLNode(TreeView1.Selections[i]).LinkedObject;
  end;

  SetLength(Parents, Length(Objekte)-1);
  for i:=1 to Length(Objekte)-1 do
    Parents[i-1]:= GetObjName(Objekte[i]);

  ResultObject:=ErmittleSchnittmenge(Objekte);

  If (ResultObject = nil) then begin
    ShowMessage('Keine Schnittmenge vorhanden');
  end else
    for i:=0 to Length(Obj)-1 do
      AddObjChild(Obj[i], S);

  With(Form1) do begin
    If ResultObject is TKreis then begin
      NewKreis(ResultObject.Position.Z, ResultObject.Position.X,
               ResultObject.Position.Y, ResultObject.Direction.Z,
               ResultObject.Direction.X, ResultObject.Direction.Y,
               TKreis(ResultObject).MajorRadius);

      AddObjParent(TGLNode(TreeView1.Selected).LinkedObject, Parents[0]);
      AddObjParent(TGLNode(TreeView1.Selected).LinkedObject, Parents[1]);
      SetObjCreationMode(TGLNode(TreeView1.Selected).LinkedObject, 'Schnitt');
      TreeView1.Selected.Text:=s;
      SetObjName(TGLNode(TreeView1.Selected).LinkedObject, s);
      RegisterActions(TGLNode(TreeView1.Selected).LinkedObject, 'Create');
    end;

    If ResultObject is TStrecke then begin
      NewStrecke(TStrecke(ResultObject).AnfangsPunkt[0], TStrecke(ResultObject).AnfangsPunkt[1],
                 TStrecke(ResultObject).AnfangsPunkt[2], TStrecke(ResultObject).EndPunkt[0],
                 TStrecke(ResultObject).EndPunkt[1], TStrecke(ResultObject).EndPunkt[2],
                 Parents[0], Parents[1], 'Schnitt');

      for i:=0 to Length(Parents)-1 do
        GetObjParents(TGLNode(TreeView1.Selected).LinkedObject)[i]:= Parents[i];

      TreeView1.Selected.Text:=s;
      Strecke:=TStrecke(TGLNode(TreeView1.Selected).LinkedObject);
      SetObjName(Strecke, s);

      If TStrecke(ResultObject).TagFloat = -1 then begin
        RegisterActions(Strecke, 'Create Macro Begin', False);
        Form1.Endpunktezeichnen(Strecke);
        Str:=ActionList1.Strings[ActionList1.ActualIndex-2];
        Str:=StringReplace(Str, 'Create Macro Begin', 'Create', [rfIgnoreCase]);
        ActionList1.Strings[ActionList1.ActualIndex-2]:=Str;
        GetObjNode(Strecke.ObjectName, TreeView1).Destroy;
        Strecke.Visible:= False;
        Strecke.TagFloat:=-2; // do not show at any circumstances
      end else
        RegisterActions(Strecke, 'Create', True);
    end;

    If ResultObject is TGerade then begin
      NewGerade(ResultObject.Position.Z, ResultObject.Position.X, ResultObject.Position.Y,
                TGerade(ResultObject).RichtungsVektor[0], TGerade(ResultObject).RichtungsVektor[1],
                TGerade(ResultObject).RichtungsVektor[2], Parents[0], Parents[1], 'Schnitt');
      TreeView1.Selected.Text:=s;
      SetObjName(TGLNode(TreeView1.Selected).LinkedObject, s);
      RegisterActions(TGLNode(TreeView1.Selected).LinkedObject, 'Create');
    end;

    If ResultObject is TPunkt then begin
      NewPunkt(ResultObject.Position.Z, ResultObject.Position.X, ResultObject.Position.Y,
               '', '', '', 'Schnitt');
      for i:=0 to Length(Parents)-1 do
        GetObjParents(TGLNode(TreeView1.Selected).LinkedObject)[i]:= Parents[i];

      TreeView1.Selected.Text:=s;
      SetObjName(TGLNode(TreeView1.Selected).LinkedObject, s);
      RegisterActions(TGLNode(TreeView1.Selected).LinkedObject, 'Create');
    end;
  end;
end;

procedure StreckeDurch2Punkte(TreeView1: TTreeView);
var
  p, q: TVector3f;
  p1,p2: TPunkt;
  s, RealName: string;
  o1, o2: TGLBaseSceneObject;
begin
  // test objects
  o1:= TGLNode(TreeView1.Selections[0]).LinkedObject;
  o2:= TGLNode(TreeView1.Selections[1]).LinkedObject;
  if not ((o1 is TPunkt) and (o2 is TPunkt)) then begin
    Application.MessageBox('Wählen Sie bitte zwei Punkte aus', 'Vectory', mb_OK);
    Exit;
  end;

  s:=' ('+TreeView1.Selections[0].Text+', '+TreeView1.Selections[1].Text+')';
  p1:=TPunkt(TGLNode(TreeView1.Selections[0]).LinkedObject);
  p2:=TPunkt(TGLNode(TreeView1.Selections[1]).LinkedObject);
  p:=p1.Koordinaten;
  q:=p2.Koordinaten;
  If VectorLength(VectorSubtract(p,q))=0 then
    Application.MessageBox('Die Strecke kann nicht gezeichnet werden (Punkte sind identisch)', 'Vectory', mb_OK)
  else
    With(Form1) do begin
      NewStrecke(p[0], p[1], p[2], q[0], q[1], q[2]);
      TreeView1.Selected.Text:=TreeView1.Selected.Text+s;
      RealName:=TreeView1.Selected.Text;
      SetObjName(TGLNode(TreeView1.Selected).LinkedObject, RealName);
      SetObjCreationMode(TGLNode(TreeView1.Selected).LinkedObject, 'Sdurch2P');
      AddObjParent(TGLNode(TreeView1.Selected).LinkedObject, p1.ObjectName);
      AddObjParent(TGLNode(TreeView1.Selected).LinkedObject, p2.ObjectName);
      AddObjChild(p1, RealName);
      AddObjChild(p2, RealName);
      RegisterActions(TGLNode(TreeView1.Selected).LinkedObject, 'Create');
    end;
end;

procedure GeradeDurch2Punkte(TreeView1: TTreeView);
var
  p1,p2: TPunkt;
  a, v: TVector3f;
  s, RealName: string;
  o1, o2: TGLBaseSceneObject;
begin
  // test objects
  o1:= TGLNode(TreeView1.Selections[0]).LinkedObject;
  o2:= TGLNode(TreeView1.Selections[1]).LinkedObject;
  if not ((o1 is TPunkt) and (o2 is TPunkt)) then begin
    Application.MessageBox('Wählen Sie bitte zwei Punkte aus', 'Vectory', mb_OK);
    Exit;
  end;

  s:=' ('+TreeView1.Selections[1].Text+', '+TreeView1.Selections[0].Text+')';
  p1:=TPunkt(TGLNode(TreeView1.Selections[0]).LinkedObject);
  p2:=TPunkt(TGLNode(TreeView1.Selections[1]).LinkedObject);
  a:=p1.Koordinaten;
  v:=VectorSubtract(p2.Koordinaten, a);
  If VectorLength(v)=0 then
    Application.MessageBox('Die Gerade ist nicht eindeutig (Punkte sind identisch)', 'Vectory', mb_OK)
  else
    With(Form1) do begin
      NewGerade(a[0], a[1], a[2], v[0], v[1], v[2]);
      TreeView1.Selected.Text:=TreeView1.Selected.Text+s;
      RealName:=TreeView1.Selected.Text;
      SetObjName(TGLNode(TreeView1.Selected).LinkedObject, RealName);
      SetObjCreationMode(TGLNode(TreeView1.Selected).LinkedObject, 'Gdurch2P');
      AddObjParent(TGLNode(TreeView1.Selected).LinkedObject, p1.ObjectName);
      AddObjParent(TGLNode(TreeView1.Selected).LinkedObject, p2.ObjectName);
      AddObjChild(p1, RealName);
      AddObjChild(p2, RealName);
      RegisterActions(TGLNode(TreeView1.Selected).LinkedObject, 'Create');
    end;
end;

procedure EbeneDurchPunktGerade(TreeView1: TTreeView);
var
  p, a, b: TVector3f;
  Punkt: Primitives.TPunkt;
  Gerade: Primitives.TGerade;
  s, RealName: string;
  o1, o2: TGLBaseSceneObject;
begin
  // test objects
  o1:= TGLNode(TreeView1.Selections[0]).LinkedObject;
  o2:= TGLNode(TreeView1.Selections[1]).LinkedObject;
  if not (((o1 is TGerade) and (o2 is TPunkt)) or
          ((o1 is TPunkt) and (o2 is TGerade))) then begin
    Application.MessageBox('Wählen Sie bitte einen Punkt und eine Gerade aus', 'Vectory', mb_OK);
    Exit;
  end;

  s:=' ('+TreeView1.Selections[1].Text+', '+TreeView1.Selections[0].Text+')';
  If TGLNode(TreeView1.Selections[0]).LinkedObject is TGerade then begin
    Punkt:=TPunkt(TGLNode(TreeView1.Selections[1]).LinkedObject);
    Gerade:=TGerade(TGLNode(TreeView1.Selections[0]).LinkedObject);
  end else begin
    Punkt:=TPunkt(TGLNode(TreeView1.Selections[0]).LinkedObject);
    Gerade:=TGerade(TGLNode(TreeView1.Selections[1]).LinkedObject);
  end;
  p:=Gerade.Aufpunkt;
  a:=Gerade.RichtungsVektor;
  b:=VectorSubtract(Punkt.Koordinaten, p);

  If (abs(VectorAngleCosine(a,b))=1) then
    Application.MessageBox('Die Ebene ist nicht eindeutig (Punkt liegt auf der Geraden)', 'Vectory', mb_OK)
  else
    With(Form1) do begin
      NewEbene(p[0], p[1], p[2], a[0], a[1], a[2], b[0], b[1], b[2]);
      TreeView1.Selected.Text:=TreeView1.Selected.Text+s;
      RealName:=TreeView1.Selected.Text;
      SetObjName(TGLNode(TreeView1.Selected).LinkedObject, RealName);
      SetObjCreationMode(TGLNode(TreeView1.Selected).LinkedObject, 'EdurchPG');
      AddObjParent(TGLNode(TreeView1.Selected).LinkedObject, Punkt.ObjectName);
      AddObjParent(TGLNode(TreeView1.Selected).LinkedObject, Gerade.ObjectName);
      AddObjChild(Punkt, RealName);
      AddObjChild(Gerade, RealName);
      RegisterActions(TGLNode(TreeView1.Selected).LinkedObject, 'Create');
    end;
end;

procedure EbeneDurch3Punkte(TreeView1: TTreeView);
var
  p1, p2, p3: TPunkt;
  p, a, b: TVector3f;
  s, RealName: string;
  o1, o2, o3: TGLBaseSceneObject;
begin
  // test objects
  o1:= TGLNode(TreeView1.Selections[0]).LinkedObject;
  o2:= TGLNode(TreeView1.Selections[1]).LinkedObject;
  o3:= TGLNode(TreeView1.Selections[2]).LinkedObject;
  if not ((o1 is TPunkt) and (o2 is TPunkt) and (o3 is TPunkt)) then begin
    Application.MessageBox('Wählen Sie bitte drei Punkte aus', 'Vectory', mb_OK);
    Exit;
  end;
  
  s:=' ('+TreeView1.Selections[2].Text+', '+TreeView1.Selections[0].Text+', '+TreeView1.Selections[1].Text+')';
  p1:=TPunkt(TGLNode(TreeView1.Selections[0]).LinkedObject);
  p2:=TPunkt(TGLNode(TreeView1.Selections[1]).LinkedObject);
  p3:=TPunkt(TGLNode(TreeView1.Selections[2]).LinkedObject);
  p:=p1.Koordinaten;
  a:=VectorSubtract(p2.Koordinaten, p);
  b:=VectorSubtract(p3.Koordinaten, p);
  If IsZero(VectorLength(VectorCrossProduct(a,b)), 0.0000001) then
    Application.MessageBox('Die Ebene ist nicht eindeutig (Punkte liegen auf einer Geraden)', 'Vectory', mb_OK)
  else
    With(Form1) do begin
      NewEbene(p[0], p[1], p[2], a[0], a[1], a[2], b[0], b[1], b[2]);
      TreeView1.Selected.Text:=TreeView1.Selected.Text+s;
      RealName:=TreeView1.Selected.Text;
      SetObjName(TGLNode(TreeView1.Selected).LinkedObject, RealName);
      SetObjCreationMode(TGLNode(TreeView1.Selected).LinkedObject, 'Edurch3P');
      AddObjParent(TGLNode(TreeView1.Selected).LinkedObject, p1.ObjectName);
      AddObjParent(TGLNode(TreeView1.Selected).LinkedObject, p2.ObjectName);
      AddObjParent(TGLNode(TreeView1.Selected).LinkedObject, p3.ObjectName);
      AddObjChild(p1, RealName);
      AddObjChild(p2, RealName);
      AddObjChild(p3, RealName);
      RegisterActions(TGLNode(TreeView1.Selected).LinkedObject, 'Create');
    end;
end;

end.
