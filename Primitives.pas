unit Primitives;

interface

uses
  GLScene, GLSpaceText, GLObjects, VectorTypes, Classes, SysUtils, GLTreeView,
  GLGeomObjects, ComCtrls, MathParser;

type
  TPunkt = class(TGLSphere)
  public
    ObjectName: string;
    Bezeichnung: TGLSpaceText;
    Koordinaten: TVector3f;
    ParamPosX1,
    ParamPosX2,
    ParamPosX3: string;
    Parents: TStringList;
    Children: TStringList;
    CreationMode: string;
    constructor Create(AOwner: TComponent); override;
  end;

  TStrecke = class(TGLCylinder)
  public
    ObjectName: string;
    Richtung: TGLCone;
    RichtungsVektor: TVector3f;
    AnfangsPunkt,
    EndPunkt: TVector3f;
    ParamP1X1,
    ParamP1X2,
    ParamP1X3,
    ParamP2X1,
    ParamP2X2,
    ParamP2X3: string;
    Parents: TStringList;
    Children: TStringList;
    CreationMode: string;
    constructor Create(AOwner: TComponent); override;
  end;

  TGerade = class(TGLCylinder)
  public
    ObjectName: string;
    Richtung: TGLCone;
    RichtungsVektor: TVector3f;
    Aufpunkt: TVector3f;
    ParamPosX1,
    ParamPosX2,
    ParamPosX3,
    ParamDirX1,
    ParamDirX2,
    ParamDirX3: string;
    Parents: TStringList;
    Children: TStringList;
    CreationMode: string;
    constructor Create(AOwner: TComponent); override;
  end;

  TEbene = class(TGLPlane)
  public
    ObjectName: string;
    NormalenVektor: TVector3f;
    Aufpunkt: TVector3f;
    Achsenabschnitte: TVector3f;
    AchsenschnittpunktX1,
    AchsenschnittpunktX2,
    AchsenschnittpunktX3: TPunkt;
    ParamPosX1,
    ParamPosX2,
    ParamPosX3,
    ParamDirX1,
    ParamDirX2,
    ParamDirX3,
    Param_N0: string;
    Parents: TStringList;
    Children: TStringList;
    CreationMode: string;
    constructor Create(AOwner: TComponent); override;
  end;

  TKreis = class(TGLTorus)
  public
    ObjectName: string;
    Koordinaten: TVector3f;
    ParamPosX1,
    ParamPosX2,
    ParamPosX3,
    ParamDirX1,
    ParamDirX2,
    ParamDirX3,
    ParamRadius: string;
    Parents: TStringList;
    Children: TStringList;
    CreationMode: string;
    constructor Create(AOwner: TComponent); override;
  end;

  TKugel = class(TGLSphere)
  public
    ObjectName: string;
    Koordinaten: TVector3f;
    ParamPosX1,
    ParamPosX2,
    ParamPosX3,
    ParamRadius: string;
    Parents: TStringList;
    Children: TStringList;
    CreationMode: string;
    constructor Create(AOwner: TComponent); override;
  end;

  TOrtsLinie = class(TGLLines)
  public
    ObjectName: string;
    Punkt: string;
    Variable: PVariable;
    RangeTop,
    RangeBottom: single;
    Accuracy: integer;
    Parents,
    Children: TStringList;
    CreationMode: string;
    constructor Create(AOwner: TComponent); override;
  end;

function FindPunkt(ObjName: string): TPunkt;
function FindGerade(ObjName: string): TGerade;
function FindStrecke(ObjName: string): TStrecke;
function FindEbene(ObjName: string): TEbene;
function FindKugel(ObjName: string): TKugel;
function FindObject(ObjName: string): TGLBaseSceneObject;
function GetObjNode(ObjName: string; Tree: TTreeView): TGLNode;
function NameUsed(ObjName: string): Boolean;
function GetObjName(Obj: TGLBaseSceneObject): string;
procedure SetObjName(Obj: TGLBaseSceneObject; Name: string);
procedure AddObjChild(Obj: TGLBaseSceneObject; ChildName: string);
function GetObjChild(Obj: TGLBaseSceneObject; Index: integer): TGLBaseSceneObject;
function GetObjChildren(Obj: TGLBaseSceneObject): TStringList;
function GetObjChildCount(Obj: TGLBaseSceneObject): integer;
procedure DeleteObjChild(Obj: TGLBaseSceneObject; ChildName: string);
function GetObjParent(Obj: TGLBaseSceneObject; Index: integer): TGLBaseSceneObject;
function GetObjParents(Obj: TGLBaseSceneObject): TStringList;
function GetObjParentCount(Obj: TGLBaseSceneObject): integer;
procedure AddObjParent(Obj: TGLBaseSceneObject; ParentName: string);
procedure DeleteObjParent(Obj: TGLBaseSceneObject; ParentName: string);
procedure DeleteAllObjParents(Obj: TGLBaseSceneObject);
procedure SetObjCreationMode(Obj: TGLBaseSceneObject; Mode: string);
function GetObjCreationMode(Obj: TGLBaseSceneObject): string;

function MakeRealName(S: String): string;

function FindVariable(Name: string; VarsArray: TVarsArray): PVariable;
function VarIsIn(S, V: string): Boolean;
function VarInObj(Obj: TGLBaseSceneObject; V: string): Boolean;

implementation

uses
  Main;

//=== constructors ===\\

constructor TPunkt.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Parents:=TStringList.Create;
  Children:=TStringList.Create;
end;

constructor TStrecke.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Parents:=TStringList.Create;
  Children:=TStringList.Create;
end;

constructor TGerade.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Parents:=TStringList.Create;
  Children:=TStringList.Create;
end;

constructor TEbene.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Parents:=TStringList.Create;
  Children:=TStringList.Create;
end;

constructor TKreis.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Parents:= TStringList.Create;
  Children:= TStringList.Create;
end;

constructor TKugel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Parents:=TStringList.Create;
  Children:=TStringList.Create;
end;

constructor TOrtsLinie.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Parents:=TStringList.Create;
  Children:=TStringList.Create;
end;

//=== end constructors ===\\

// Punkt \\

function FindPunkt(ObjName: string): TPunkt;
var
  i: integer;
begin
  with Main.Form1.Points do begin
    i:=1;
    while (i < Count) and (TPunkt(Children[i]).ObjectName <> ObjName) do
      i:=i+1;

    if i = Count then
      Result:= NIL
    else
      Result:=TPunkt(Children[i]);
  end;
end;

// Gerade \\

function FindGerade(ObjName: string): TGerade;
var
  i: integer;
begin
  with Main.Form1.Lines do begin
    i:=0;
    while (i < Count) and (TGerade(Children[i]).ObjectName <> ObjName) do
      i:=i+1;

    if i = Count then
      Result:= NIL
    else
      Result:=TGerade(Children[i]);
  end;
end;

// Strecke \\

function FindStrecke(ObjName: string): TStrecke;
var
  i: integer;
begin
  with Main.Form1.Strecken do begin
    i:=1;
    while (i < Count) and (TStrecke(Children[i]).ObjectName <> ObjName) do
      i:=i+1;

    if i = Count then
      Result:= NIL
    else
      Result:=TStrecke(Children[i]);
  end;
end;

// Ebene \\

function FindEbene(ObjName: string): TEbene;
var
  i: integer;
begin
  with Main.Form1.Planes do begin
    i:=1;
    while (i < Count) and (TEbene(Children[i]).ObjectName <> ObjName) do
      i:=i+1;

    if i = Count then
      Result:= NIL
    else
      Result:=TEbene(Children[i]);
  end;
end;

// Kreis \\

function FindKreis(ObjName: string): TKreis;
var
  i: integer;
begin
  with Main.Form1.Circles do begin
    i:=1;
    while (i < Count) and (TKreis(Children[i]).ObjectName <> ObjName) do
      i:=i+1;

    if i = Count then
      Result:= NIL
    else
      Result:=TKreis(Children[i]);
  end;
end;

// Kugel \\

function FindKugel(ObjName: string): TKugel;
var
  i: integer;
begin
  with Main.Form1.Spheres do begin
    i:=1;
    while (i < Count) and (TKugel(Children[i]).ObjectName <> ObjName) do
      i:=i+1;

    if i = Count then
      Result:= NIL
    else
      Result:=TKugel(Children[i]);
  end;
end;

// OrtsLinie \\

function FindOrtsLinie(ObjName: string): TOrtsLinie;
var
  i: integer;
begin
  with Main.Form1.OrtsLinien do begin
    i:=1;
    while (i < Count) and (TOrtsLinie(Children[i]).ObjectName <> ObjName) do
      i:=i+1;

    if i = Count then
      Result:= NIL
    else
      Result:=TOrtsLinie(Children[i]);
  end;
end;

// Alle Objecte \\

function FindObject(ObjName: string): TGLBaseSceneObject;
begin
  Result:= FindPunkt(ObjName);
  if Result = NIL then
    Result:= FindGerade(ObjName);
  if Result = NIL then
    Result:= FindStrecke(ObjName);
  if Result = NIL then
    Result:= FindEbene(ObjName);
  if Result = NIL then
    Result:= FindKreis(ObjName);
  if Result = NIL then
    Result:= FindKugel(ObjName);
  if Result = NIL then
    Result:= FindOrtsLinie(ObjName);
end;

function GetObjNode(ObjName: string; Tree: TTreeView): TGLNode;
var
  i: integer;
begin
  Result:=NIL;

  i:=0;
  while i < Tree.Items.Count do begin
    If Tree.Items[i].Text = ObjName then begin
      Result:= TGLNode(Tree.Items[i]);
      Break;
    end;
    inc(i);
  end;
end;

function NameUsed(ObjName:string): Boolean;
var
  i: integer;
begin
  Result:=True;

  If FindObject(ObjName) = NIL then
    Result:=False;
end;

function GetObjName(Obj: TGLBaseSceneObject): string;
begin
  Result:='';
  
  If not Assigned(Obj) then Exit;

  If Obj.ClassType = TPunkt then
    Result:=TPunkt(Obj).ObjectName;
  If Obj.ClassType = TStrecke then
    Result:=TStrecke(Obj).ObjectName;
  If Obj.ClassType = TGerade then
    Result:=TGerade(Obj).ObjectName;
  If Obj.ClassType = TEbene then
    Result:=TEbene(Obj).ObjectName;
  If Obj.ClassType = TKreis then
    Result:=TKreis(Obj).ObjectName;
  If Obj.ClassType = TKugel then
    Result:=TKugel(Obj).ObjectName;
  If Obj.ClassType = TOrtsLinie then
    Result:=TOrtsLinie(Obj).ObjectName;
end;

procedure SetObjName(Obj: TGLBaseSceneObject; Name: string);
var
  i, index: integer;
  OldName: string;
begin
  OldName:=GetObjName(Obj);

// Change Name
  If Obj.ClassType = TPunkt then begin
    TPunkt(Obj).ObjectName:= Name;
    If Assigned(TPunkt(Obj).Bezeichnung) then
      TPunkt(Obj).Bezeichnung.Text:= Name;
  end;
  If Obj.ClassType = TStrecke then
    TStrecke(Obj).ObjectName:= Name;
  If Obj.ClassType = TGerade then
    TGerade(Obj).ObjectName:= Name;
  If Obj.ClassType = TEbene then
    TEbene(Obj).ObjectName:= Name;
  If Obj.ClassType = TKreis then
    TKreis(Obj).ObjectName:= Name;
  If Obj.ClassType = TKugel then
    TKugel(Obj).ObjectName:= Name;
  If Obj.ClassType = TOrtsLinie then
    TOrtsLinie(Obj).ObjectName:= Name;

// Change all parents
  for i:=0 to GetObjParentCount(Obj)-1 do begin
    If GetObjParents(Obj)[i] <> '' then begin
      index:=GetObjChildren(GetObjParent(Obj, i)).IndexOf(OldName);
      if index > -1 then
        GetObjChildren(GetObjParent(Obj, i))[index]:=Name;
    end;
  end;
end;

procedure AddObjChild(Obj: TGLBaseSceneObject; ChildName: string);
begin
  GetObjChildren(Obj).Add(ChildName);
end;

function GetObjChildren(Obj: TGLBaseSceneObject): TStringList;
begin
  Result:=NIL;
  If Obj.ClassType = TPunkt then
    Result:=TPunkt(Obj).Children;
  If Obj.ClassType = TStrecke then
    Result:=TStrecke(Obj).Children;
  If Obj.ClassType = TGerade then
    Result:=TGerade(Obj).Children;
  If Obj.ClassType = TEbene then
    Result:=TEbene(Obj).Children;
  If Obj.ClassType = TKreis then
    Result:=TKreis(Obj).Children;
  If Obj.ClassType = TKugel then
    Result:=TKugel(Obj).Children;
  If Obj.ClassType = TOrtsLinie then
    Result:=TOrtsLinie(Obj).Children;
end;

function GetObjChild(Obj: TGLBaseSceneObject; Index: integer): TGLBaseSceneObject;
begin
  Result:=FindObject(GetObjChildren(Obj)[Index]);
end;

function GetObjChildCount(Obj: TGLBaseSceneObject): integer;
begin
  Result:=GetObjChildren(Obj).Count;
end;

procedure DeleteObjChild(Obj: TGLBaseSceneObject; ChildName: string);
var
  index: integer;
  Children: TStringList;
begin
  Children:=GetObjChildren(Obj);
  index:=Children.IndexOf(ChildName);
  If index > -1 then
    Children.Delete(index);
end;

function GetObjParents(Obj: TGLBaseSceneObject): TStringList;
begin
  Result:=NIL;
  If Obj.ClassType = TPunkt then
    Result:=TPunkt(Obj).Parents;
  If Obj.ClassType = TStrecke then
    Result:=TStrecke(Obj).Parents;
  If Obj.ClassType = TGerade then
    Result:=TGerade(Obj).Parents;
  If Obj.ClassType = TEbene then
    Result:=TEbene(Obj).Parents;
  If Obj.ClassType = TKreis then
    Result:=TKreis(Obj).Parents;
  If Obj.ClassType = TKugel then
    Result:=TKugel(Obj).Parents;
  If Obj.ClassType = TOrtsLinie then
    Result:=TOrtsLinie(Obj).Parents;
end;

function GetObjParent(Obj: TGLBaseSceneObject; Index: integer): TGLBaseSceneObject;
begin
  Result:=FindObject(GetObjParents(Obj)[Index]);
end;

procedure SetObjParent(Obj: TGLBaseSceneObject; Parent: string; Index: integer);
begin

end;

function GetObjParentCount(Obj: TGLBaseSceneObject): integer;
begin
  If Assigned(Obj) then
    Result:=GetObjParents(Obj).Count
  else
    Result:=-1;
end;

procedure AddObjParent(Obj: TGLBaseSceneObject; ParentName: string);
begin
  GetObjParents(Obj).Add(ParentName)
end;

procedure DeleteObjParent(Obj: TGLBaseSceneObject; ParentName: string);
var
  index: integer;
  Parents: TStringList;
begin
  Parents:=GetObjParents(Obj);
  index:=Parents.IndexOf(ParentName);
  If index > -1 then
    Parents.Delete(index);
end;

procedure DeleteAllObjParents(Obj: TGLBaseSceneObject);
var
  Parents: TStringList;
  i: integer;
begin
  If Assigned(Obj) then begin
    Parents:=GetObjParents(Obj);
    Parents.Clear;
  end;  
end;

procedure SetObjCreationMode(Obj: TGLBaseSceneObject; Mode: string);
begin
  If Obj.ClassType = TPunkt then
    TPunkt(Obj).CreationMode:= Mode;
  If Obj.ClassType = TStrecke then
    TStrecke(Obj).CreationMode:= Mode;
  If Obj.ClassType = TGerade then
    TGerade(Obj).CreationMode:= Mode;
  If Obj.ClassType = TEbene then
    TEbene(Obj).CreationMode:= Mode;
  If Obj.ClassType = TKreis then
    TKreis(Obj).CreationMode:= Mode;
  If Obj.ClassType = TKugel then
    TKugel(Obj).CreationMode:= Mode;
  If Obj.ClassType = TOrtsLinie then
    TOrtsLinie(Obj).CreationMode:= Mode;
end;

function GetObjCreationMode(Obj: TGLBaseSceneObject): string;
begin
  If Obj.ClassType = TPunkt then
    Result:=TPunkt(Obj).CreationMode;
  If Obj.ClassType = TStrecke then
    Result:=TStrecke(Obj).CreationMode;
  If Obj.ClassType = TGerade then
    Result:=TGerade(Obj).CreationMode;
  If Obj.ClassType = TEbene then
    Result:=TEbene(Obj).CreationMode;
  If Obj.ClassType = TKreis then
    Result:=TKreis(Obj).CreationMode;
  If Obj.ClassType = TKugel then
    Result:=TKugel(Obj).CreationMode;
  If Obj.ClassType = TOrtsLinie then
    Result:=TOrtsLinie(Obj).CreationMode;
end;

function MakeRealName(S: String): string;
begin
  Result:=S;
{  Result:=StringReplace(Result, ' ', '', [rfReplaceAll]);
  Result:=StringReplace(Result, '(', '', [rfReplaceAll]);
  Result:=StringReplace(Result, ')', '', [rfReplaceAll]);
  Result:=StringReplace(Result, ';', '', [rfReplaceAll]);
  Result:=StringReplace(Result, ',', '', [rfReplaceAll]);
  Result:=StringReplace(Result, '|', '', [rfReplaceAll]);}
end;

function FindVariable(Name: string; VarsArray: TVarsArray): PVariable;
var
  i: integer;
begin
  i:=0;
  Result:= nil;
  while i < Length(VarsArray) do
    if VarsArray[i].Name = Name then begin
      Result:= @VarsArray[i];
      i:= Length(VarsArray);
    end else
      inc(i);
end;

function VarIsIn(S, V: string): Boolean;
var
  str: string;
  i: integer;
begin
  for i:= 0 to Length(ReservedWords)-1 do
    Str:=StringReplace(S, ReservedWords[i], '#'+IntToStr(i), [rfReplaceAll, rfIgnoreCase]);

  Result:= (Pos(V, S) <> 0);
end;

function VarInObj(Obj: TGLBaseSceneObject; V: string): Boolean;
var
  i: integer;
begin
 Result:= False;
 If Assigned(Obj) then begin
  If Obj is TPunkt then begin
    Result:= VarIsIn(TPunkt(Obj).ParamPosX1, V) or
             VarIsIn(TPunkt(Obj).ParamPosX2, V) or
             VarIsIn(TPunkt(Obj).ParamPosX3, V);
  end;
  If Obj is TStrecke then begin
    Result:= VarIsIn(TStrecke(Obj).ParamP1X1, V) or
             VarIsIn(TStrecke(Obj).ParamP1X2, V) or
             VarIsIn(TStrecke(Obj).ParamP1X3, V) or
             VarIsIn(TStrecke(Obj).ParamP2X1, V) or
             VarIsIn(TStrecke(Obj).ParamP2X2, V) or
             VarIsIn(TStrecke(Obj).ParamP2X3, V);
  end;
  If Obj is TGerade then begin
    Result:= VarIsIn(TGerade(Obj).ParamPosX1, V) or
             VarIsIn(TGerade(Obj).ParamPosX2, V) or
             VarIsIn(TGerade(Obj).ParamPosX3, V) or
             VarIsIn(TGerade(Obj).ParamDirX1, V) or
             VarIsIn(TGerade(Obj).ParamDirX2, V) or
             VarIsIn(TGerade(Obj).ParamDirX3, V);
  end;
  If Obj is TEbene then begin
    Result:= VarIsIn(TEbene(Obj).ParamPosX1 , V) or
             VarIsIn(TEbene(Obj).ParamPosX2, V) or
             VarIsIn(TEbene(Obj).ParamPosX3, V) or
             VarIsIn(TEbene(Obj).Param_N0 , V);
  end;
  If Obj is TKreis then begin
    Result:= VarIsIn(TKreis(Obj).ParamPosX1 , V) or
             VarIsIn(TKreis(Obj).ParamPosX2, V) or
             VarIsIn(TKreis(Obj).ParamPosX3, V) or
             VarIsIn(TKreis(Obj).ParamDirX1 , V) or
             VarIsIn(TKreis(Obj).ParamDirX2, V) or
             VarIsIn(TKreis(Obj).ParamDirX3, V) or
             VarIsIn(TKreis(Obj).ParamRadius , V);
  end;
  If Obj is TKugel then begin
    Result:= VarIsIn(TKugel(Obj).ParamPosX1 , V) or
             VarIsIn(TKugel(Obj).ParamPosX2, V) or
             VarIsIn(TKugel(Obj).ParamPosX3, V) or
             VarIsIn(TKugel(Obj).ParamRadius , V);
  end;
  If Obj is TOrtsLinie then begin
    Result:= V = TOrtsLinie(Obj).Variable.Name;
  end;

  If not Result then begin
    i:= 0;
    while (i < GetObjParentCount(Obj)) and (not Result) do begin
      Result:= VarInObj(GetObjParent(Obj, i), V);
      inc(i);
    end;
  end;
 end;
end;

end.
