unit ActionList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, GLColor,
  Dialogs, VectorGeometry, GLTreeView, GLScene, MathParser, Primitives, OrtsLinie;

type

  TDynStringArray = array of string;

  TActions = record
    Instruction: string;
    ObjectType: string;
    ObjectVisible: Boolean;
    ObjectIndex: integer;
    ObjectName: string;
    param1,
    param2,
    param3,
    param4,
    param5,
    param6,
    param7,
    param8,
    param9,
    param10,
    param11,
    param12,
    param13,
    param14,
    param15,
    param16: string;
  end;

  TActionsList = class(TStringList)
  private
    FActualIndex: integer;
    procedure DoAction(Act: TActions);
    procedure UndoAction(Act: TActions);
  public
    procedure AddAction(Action: String);
    procedure InsertAction(Action: String);
    procedure ChangeAction(Index: integer; Act: TActions);
    procedure UndoLastAction;
    procedure RedoLastAction;
    procedure UndoAllActions;
    procedure RedoAllActions;
  published
    property ActualIndex: integer read FActualIndex write FActualIndex;
  end;

function StringToAction(Action: string): TActions;
function StringToAffineVector(s1, s2, s3: string): TAffineVector;
function StringToVector(s: string): TVector;
function VectorToString(v: TVector): string;
function AffineVectorToString(v: TAffineVector): string;

implementation

uses
  Main;

function StringToAffineVector(s1, s2, s3: string): TAffineVector;
begin
  Result:=AffineVectorMake(0,0,0);
  Result[0] := ProcessLine(s1, VarsArchive);
  Result[1] := ProcessLine(s2, VarsArchive);
  Result[2] := ProcessLine(s3, VarsArchive);
end;

function StringToVector(s: string): TVector;
var
  i: integer;
  str: string;
  ActS: string;
begin
  str:=s;
  i:=0;
  Result:=VectorMake(0,0,0,0);

  i:=pos(';', str);
  ActS:=Copy(str, 1, i-1);
  Result[0] := ProcessLine(ActS, VarsArchive);
  Delete(str, 1,i);
  i:=pos(';', str);
  ActS:=Copy(str, 1, i-1);
  Result[1] := ProcessLine(ActS, VarsArchive);
  Delete(str, 1,i);
  i:=pos(';', str);
  ActS:=Copy(str, 1, i-1);
  Result[2] := ProcessLine(ActS, VarsArchive);
  Delete(str, 1,i);
  ActS:=str;
  Result[3] := ProcessLine(ActS, VarsArchive);
end;

function VectorToString(v: TVector): string;
begin
  result:=Format('%0.9f;%0.9f;%0.9f;%0.9f',[v[0], v[1], v[2], v[3]]);
end;

function AffineVectorToString(v: TAffineVector): string;
begin
  result:=Format('%0.9f;%0.9f;%0.9f',[v[0], v[1], v[2]]);
end;

function StringToAction(Action: string): TActions;
var
  i, j: integer;
  s, ActStr: string;
begin
  If Action = '' then exit;
  s:=Action;
  i:=0;

//==  Instruction
  i:=pos('|', s);
  Result.Instruction := Copy(s, 1, i-1);
  Delete(s, 1,i);

//==  ObjectType
  i:=pos('|', s);
  Result.ObjectType := Copy(s, 1, i-1);
  Delete(s, 1,i);

//==  ObjectVisible
  i:=pos('|', s);
  If (Copy(s, 1, i-1) = '-1') or (Copy(s, 1, i-1) = '0') then begin
    Result.ObjectVisible := StrToBool(Copy(s, 1, i-1));
    Delete(s, 1,i);
  end else
    Result.ObjectVisible:= True;  

//==  ObjectIndex
  i:=pos('|', s);
  Result.ObjectIndex := StrToInt(Copy(s, 1, i-1));
  Delete(s, 1,i);

//== ObjectName
  i:=pos('|', s);
  Result.ObjectName := Copy(s, 1, i-1);
  Delete(s, 1,i);

//==  Param1
  i:=pos('|', s);
  If i = 0 then begin
    Result.param1 := s;
    Exit;
  end;
  Result.param1 := Copy(s, 1, i-1);
  Delete(s, 1,i);

//==  Param2
  i:=pos('|', s);
  If i = 0 then begin
    Result.param2 := s;
    Exit;
  end;
  Result.param2 := Copy(s, 1, i-1);
  Delete(s, 1,i);

//==  Param3
  i:=pos('|', s);
  If i = 0 then begin
    Result.param3 := s;
    Exit;
  end;
  Result.param3 := Copy(s, 1, i-1);
  Delete(s, 1,i);

//==  Param4
  i:=pos('|', s);
  If i = 0 then begin
    Result.param4 := s;
    Exit;
  end;
  Result.param4 := Copy(s, 1, i-1);
  Delete(s, 1,i);

//==  Param5
  i:=pos('|', s);
  If i = 0 then begin
    Result.param5 := s;
    Exit;
  end;
  Result.param5 := Copy(s, 1, i-1);
  Delete(s, 1,i);

//==  Param6
  i:=pos('|', s);
  If i = 0 then begin
    Result.param6 := s;
    Exit;
  end;
  Result.param6 := Copy(s, 1, i-1);
  Delete(s, 1,i);

//==  Param7
  i:=pos('|', s);
  If i = 0 then begin
    Result.param7 := s;
    Exit;
  end;
  Result.param7 := Copy(s, 1, i-1);
  Delete(s, 1,i);

//==  Param8
  i:=pos('|', s);
  If i = 0 then begin
    Result.param8 := s;
    Exit;
  end;
  Result.param8 := Copy(s, 1, i-1);
  Delete(s, 1,i);

//==  Param9
  i:=pos('|', s);
  If i = 0 then begin
    Result.param9 := s;
    Exit;
  end;
  Result.param9 := Copy(s, 1, i-1);
  Delete(s, 1,i);

//==  Param10
  i:=pos('|', s);
  If i = 0 then begin
    Result.param10 := s;
    Exit;
  end;
  Result.param10 := Copy(s, 1, i-1);
  Delete(s, 1,i);

//==  Param11
  i:=pos('|', s);
  If i = 0 then begin
    Result.param11 := s;
    Exit;
  end;
  Result.param11 := Copy(s, 1, i-1);
  Delete(s, 1,i);

//==  Param12
  i:=pos('|', s);
  If i = 0 then begin
    Result.param12 := s;
    Exit;
  end;
  Result.param12 := Copy(s, 1, i-1);
  Delete(s, 1,i);

//==  Param13
  i:=pos('|', s);
  If i = 0 then begin
    Result.param13 := s;
    Exit;
  end;
  Result.param13 := Copy(s, 1, i-1);
  Delete(s, 1,i);

//==  Param14
  i:=pos('|', s);
  If i = 0 then begin
    Result.param14 := s;
    Exit;
  end;
  Result.param14 := Copy(s, 1, i-1);
  Delete(s, 1,i);

//==  Param15
  i:=pos('|', s);
  If i = 0 then begin
    Result.param15 := s;
    Exit;
  end;
  Result.param15 := Copy(s, 1, i-1);
  Delete(s, 1,i);

//==  Param16
  i:=pos('|', s);
  If i = 0 then begin
    Result.param16 := s;
    Exit;
  end;
  Result.param16 := Copy(s, 1, i-1);
  Delete(s, 1,i);

//==  CreationMode
{  i:=pos('|',s);
  If i = 0 then begin
    Result.CreationMode := s;
    Exit;
  end;
  Result.CreationMode := Copy(s, i, i-1);
  Delete(s, 1,i);

//==  Parents
  i:=pos('|',s);
  If i = 0 then begin
    SetLength(Result.Parents, 1);
    Result.Parents[0] := s;
    Exit;
  end;

  ActStr := Copy(s, i, i-1);
  Delete(s, 1, i);

  j:=1;
  repeat
    i:=pos(',', ActStr);
    SetLength(Result.Parents, j);
    Result.Parents[j-1] := Copy(ActStr, i, i-1);
    Delete(ActStr, 1,i);
    inc(j);
  until i = 0;

//==  Children
  i:=pos('|',s);
  If i = 0 then begin
    SetLength(Result.Children, 1);
    Result.Children[0] := s;
    Exit;
  end;

  ActStr := Copy(s, i, i-1);
  Delete(s, 1, i);

  j:=1;
  repeat
    i:=pos(',', ActStr);
    SetLength(Result.Children, j);
    Result.Children[j-1] := Copy(ActStr, i, i-1);
    Delete(ActStr, 1,i);
    inc(j);
  until i = 0;}

end;

procedure ReadList(var List: TStringList; S: string);
var
  i: integer;
  ActStr: string;
begin
  If S = '' then Exit;

  ActStr:=S;
  i:=pos('#', ActStr);
  while i > 0 do begin
    List.Add(Copy(ActStr, 1, i-1));
    Delete(ActStr, 1,i);
    i:=pos('#', ActStr);
  end;
  List.Add(ActStr);
end;

procedure TActionsList.DoAction(Act: TActions);
var
  AffineVector1, AffineVector2, DummyAffineVector: TAffineVector;
  Vector: TVector;
  VLength: single;
  RememberAct: TActions;
  Ebene: TEbene;
  Gerade: TGerade;
  Punkt: TPunkt;
  Kreis: TKreis;
  Kugel: TKugel;
  Strecke: TStrecke;
  OrtsLinie: TOrtsLinie;
  Obj: TGLBaseSceneObject;
  S1, S2, S3: string;
  i: integer;
  MacroIndex: integer;
  MacroAct: TActions;
  Color: TColorVector;
begin

//== Objekt erstellen
  If Copy(Act.Instruction, 1, 6) = 'Create' then begin
    If Act.ObjectType = 'Punkt' then begin
      AffineVector1:=StringToAffineVector(Act.param1, Act.param2, Act.param3);
      Form1.NewPunkt(AffineVector1[0],AffineVector1[1],AffineVector1[2]);
      Form1.TreeView1.Selected.Text:=Act.ObjectName;
      Punkt:=TPunkt(TGLNode(Form1.TreeView1.Selected).LinkedObject);
      Punkt.ObjectName:= Act.ObjectName;
      Punkt.Bezeichnung.Text:= Act.ObjectName;
      Punkt.ParamPosX1:=Act.param1;
      Punkt.ParamPosX2:=Act.param2;
      Punkt.ParamPosX3:=Act.param3;
      Punkt.Material.FrontProperties.Diffuse.Color:=StringToVector(Act.param4);
      Punkt.Material.BackProperties.Diffuse.Color:=StringToVector(Act.param4);
      Punkt.Bezeichnung.Material.FrontProperties.Diffuse.Color:=StringToVector(Act.param4);
      Punkt.Bezeichnung.Material.BackProperties.Diffuse.Color:=StringToVector(Act.param4);
      Punkt.CreationMode:=Act.param5;
      ReadList(Punkt.Parents, Act.param6);
      ReadList(Punkt.Children, Act.param7);

      for i:=0 to Punkt.Parents.Count-1 do begin
        AddObjChild(GetObjParent(Punkt, i), Punkt.ObjectName);
      end;

//      ChangeChild(Punkt);

    end;
    If Act.ObjectType = 'Strecke' then begin
      AffineVector1:=StringToAffineVector(Act.param1, Act.param2, Act.param3);
      AffineVector2:=StringToAffineVector(Act.param4, Act.param5, Act.param6);
      Form1.NewStrecke(AffineVector1[0],AffineVector1[1],AffineVector1[2], AffineVector2[0],AffineVector2[1],AffineVector2[2]);
      Form1.TreeView1.Selected.Text:=Act.ObjectName;
      Strecke:=TStrecke(TGLNode(Form1.TreeView1.Selected).LinkedObject);
      Strecke.ObjectName:=Act.ObjectName;
      Strecke.AnfangsPunkt:=AffineVectorMake(ProcessLine(Act.param1, VarsArchive),
                                             ProcessLine(Act.param2, VarsArchive),
                                             ProcessLine(Act.param3, VarsArchive));
      Strecke.EndPunkt:=AffineVectorMake(ProcessLine(Act.param4, VarsArchive),
                                             ProcessLine(Act.param5, VarsArchive),
                                             ProcessLine(Act.param6, VarsArchive));
      Strecke.ParamP1X1:=Act.param1;
      Strecke.ParamP1X2:=Act.param2;
      Strecke.ParamP1X3:=Act.param3;
      Strecke.ParamP2X1:=Act.param4;
      Strecke.ParamP2X2:=Act.param5;
      Strecke.ParamP2X3:=Act.param6;
      Strecke.Material.FrontProperties.Diffuse.Color:=StringToVector(Act.param7);
      Strecke.Material.BackProperties.Diffuse.Color:=StringToVector(Act.param7);
      Strecke.CreationMode:=Act.param8;
      ReadList(Strecke.Parents, Act.param9);
      ReadList(Strecke.Children, Act.param10);

      for i:=0 to Strecke.Parents.Count-1 do begin
        AddObjChild(GetObjParent(Strecke, i), Strecke.ObjectName);
      end;

//      ChangeChild(Strecke);
    end;
   If Act.ObjectType = 'Gerade' then begin
      AffineVector1:=StringToAffineVector(Act.param1, Act.param2, Act.param3);
      AffineVector2:=StringToAffineVector(Act.param4, Act.param5, Act.param6);
      Form1.NewGerade(AffineVector1[0],AffineVector1[1],AffineVector1[2], AffineVector2[0],AffineVector2[1],AffineVector2[2]);
      Form1.TreeView1.Selected.Text:=Act.ObjectName;
      Gerade:=TGerade(TGLNode(Form1.TreeView1.Selected).LinkedObject);
      Gerade.ObjectName:=Act.ObjectName;
      Gerade.ParamPosX1:=Act.param1;
      Gerade.ParamPosX2:=Act.param2;
      Gerade.ParamPosX3:=Act.param3;
      Gerade.ParamDirX1:=Act.param4;
      Gerade.ParamDirX2:=Act.param5;
      Gerade.ParamDirX3:=Act.param6;
      Gerade.Material.FrontProperties.Diffuse.Color:=StringToVector(Act.param7);
      Gerade.Material.BackProperties.Diffuse.Color:=StringToVector(Act.param7);
      Gerade.CreationMode:=Act.param8;
      ReadList(Gerade.Parents, Act.param9);
      ReadList(Gerade.Children, Act.param10);

      for i:=0 to Gerade.Parents.Count-1 do begin
        AddObjChild(GetObjParent(Gerade, i), Gerade.ObjectName);
      end;

//      ChangeChild(Gerade);
    end;
    If Act.ObjectType = 'Ebene' then begin
      Vector:=VectorMake(StringToAffineVector(Act.param1, Act.param2, Act.param3), ProcessLine(Act.param4, VarsArchive));
      Form1.NewEbene(Vector[0],Vector[1],Vector[2], Vector[3]);
      Form1.TreeView1.Selected.Text:=Act.ObjectName;
      Ebene:=TEbene(TGLNode(Form1.TreeView1.Selected).LinkedObject);
      Ebene.ObjectName:=Act.ObjectName;
      Ebene.ParamDirX1:=Act.param1;
      Ebene.ParamDirX2:=Act.param2;
      Ebene.ParamDirX3:=Act.param3;
      Ebene.ParamPosX1:=ProcessTriadLine('-('+Act.param1+')*('+Act.param4+')/(('+Act.param1+')^2+('+Act.param2+')^2+('+Act.param3+')^2'+')');
      Ebene.ParamPosX2:=ProcessTriadLine('-('+Act.param2+')*('+Act.param4+')/(('+Act.param1+')^2+('+Act.param2+')^2+('+Act.param3+')^2'+')');
      Ebene.ParamPosX3:=ProcessTriadLine('-('+Act.param3+')*('+Act.param4+')/(('+Act.param1+')^2+('+Act.param2+')^2+('+Act.param3+')^2'+')');
      Ebene.Param_N0:=Act.param4;
      Ebene.Material.FrontProperties.Diffuse.Color:=StringToVector(Act.param5);
      Ebene.Material.BackProperties.Diffuse.Color:=StringToVector(Act.param5);
      Ebene.CreationMode:=Act.param6;
      ReadList(Ebene.Parents, Act.param7);
      ReadList(Ebene.Children, Act.param8);

      for i:=0 to Ebene.Parents.Count-1 do begin
        AddObjChild(GetObjParent(Ebene, i), Ebene.ObjectName);
      end;

//      ChangeChild(Ebene);
    end;

    If Act.ObjectType = 'Kreis' then begin
      AffineVector1:=StringToAffineVector(Act.param1, Act.param2, Act.param3);
      Vector:=VectorMake(StringToAffineVector(Act.param4, Act.param5, Act.param6), ProcessLine(Act.param7, VarsArchive));
      Form1.NewKreis(AffineVector1[0],AffineVector1[1],AffineVector1[2],
                     Vector[0], Vector[1], Vector[2], Vector[3]);
      Form1.TreeView1.Selected.Text:=Act.ObjectName;
      Kreis:=TKreis(TGLNode(Form1.TreeView1.Selected).LinkedObject);
      Kreis.ObjectName:=Act.ObjectName;
      Kreis.ParamPosX1:=Act.param1;
      Kreis.ParamPosX2:=Act.param2;
      Kreis.ParamPosX3:=Act.param3;
      Kreis.ParamDirX1:=Act.param4;
      Kreis.ParamDirX2:=Act.param5;
      Kreis.ParamDirX3:=Act.param6;
      Kreis.ParamRadius:=Act.param7;
      Kreis.Material.FrontProperties.Diffuse.Color:=StringToVector(Act.param8);
      Kreis.Material.BackProperties.Diffuse.Color:=StringToVector(Act.param8);
      Kreis.CreationMode:=Act.param9;
      ReadList(Kreis.Parents, Act.param10);
      ReadList(Kreis.Children, Act.param11);

      for i:=0 to Kreis.Parents.Count-1 do begin
        AddObjChild(GetObjParent(Kreis, i), Kreis.ObjectName);
      end;

//      ChangeChild(Kreis);
    end;

    If Act.ObjectType = 'Kugel' then begin
      Vector:=VectorMake(StringToAffineVector(Act.param1, Act.param2, Act.param3), ProcessLine(Act.param4, VarsArchive));
      Form1.NewKugel(Vector[0],Vector[1],Vector[2], Vector[3]);
      Form1.TreeView1.Selected.Text:=Act.ObjectName;
      Kugel:=TKugel(TGLNode(Form1.TreeView1.Selected).LinkedObject);
      Kugel.ObjectName:=Act.ObjectName;
      Kugel.ParamPosX1:=Act.param1;
      Kugel.ParamPosX2:=Act.param2;
      Kugel.ParamPosX3:=Act.param3;
      Kugel.ParamRadius:=Act.param4;
      Kugel.Material.FrontProperties.Diffuse.Color:=StringToVector(Act.param5);
      Kugel.Material.BackProperties.Diffuse.Color:=StringToVector(Act.param5);
      Kugel.CreationMode:=Act.param6;
      ReadList(Kugel.Parents, Act.param7);
      ReadList(Kugel.Children, Act.param8);

      for i:=0 to Kugel.Parents.Count-1 do begin
        AddObjChild(GetObjParent(Kugel, i), Kugel.ObjectName);
      end;

//      ChangeChild(Kugel);
    end;

    If Act.ObjectType = 'Ortslinie' then begin
      Color:= StringToVector(Act.param6); 
      ErstelleOrtsLinie(Act.ObjectName, Color, TPunkt(FindObject(Act.param1)), FindVariable(Act.param2, VarsArchive), StrToFloat(Act.param3),
                        StrToFloat(Act.param4), StrToInt(Act.param5), False, False);
    end;

//== Objekt unsichtbar machen, wenn n�tig
  If not Act.ObjectVisible then begin
    GetObjNode(Act.ObjectName, Form1.TreeView1).Destroy;
    FindObject(Act.ObjectName).Visible:=False;
    FindObject(Act.ObjectName).TagFloat:=-2;
  end;

  If Assigned(Punkt) then
    ChangeChild(Punkt);
  If Assigned(Strecke) then
    ChangeChild(Strecke);
  If Assigned(Gerade) then
    ChangeChild(Gerade);
  If Assigned(Ebene) then
    ChangeChild(Ebene);
  If Assigned(Kugel) then
    ChangeChild(Kugel);
  If Assigned(Kreis) then
    ChangeChild(Kreis);
  end;

//== Objekt entfernen
  If Copy(Act.Instruction, 1, 6) = 'Delete' then
    If GetObjNode(Act.ObjectName, Form1.TreeView1) <> NIL then
      Form1.DeleteObject(GetObjNode(Act.ObjectName, Form1.TreeView1), False)
    else begin
      Obj:=FindObject(Act.ObjectName);
//== Delete References of all parents
      for i:=0 to GetObjParentCount(Obj)-1 do
        If Assigned(GetObjParent(Obj, i)) then
          DeleteObjChild(GetObjParent(Obj, i), GetObjName(Obj));

//== Delete the Object
      Obj.Free;
    end;

//== Macro Create behandeln
  If Act.Instruction = 'Create Macro Begin' then begin
    MacroAct:=StringToAction(Get(FActualIndex));
    inc(FActualIndex);
    while MacroAct.Instruction <> 'Create Macro End' do begin
      MacroAct:=StringToAction(Get(FActualIndex));
      RedoLastAction;
    end;
    dec(FActualIndex);
  end;

//== Macro Delete behandeln
  If Act.Instruction = 'Delete Macro Begin' then begin
    MacroAct:=StringToAction(Get(FActualIndex));
//    dec(FActualIndex);
    while MacroAct.Instruction <> 'Create Macro Begin' do begin
      UndoLastAction;
      MacroAct:=StringToAction(Get(FActualIndex));
    end;
  end;

//== Objekt ver�ndern
  If Act.Instruction = 'ChangeObject' then begin

//== PUNKT
    If Act.ObjectType = 'Punkt' then begin
      Punkt:=TPunkt(TGLNode(Form1.TreeView1.Items[Act.ObjectIndex]).LinkedObject);
      AffineVector1:=StringToAffineVector(Act.param5, Act.param6, Act.param4);
//== Swap Koordinates
{      DummyAffineVector:=AffineVector1;
      SetVector(AffineVector1, DummyAffineVector[1], DummyAffineVector[2], DummyAffineVector[0]);
      S1:=Act.param1; S2:=Act.param2; S3:=Act.param3;
      Act.param1:=Act.param4; Act.param2:=Act.param5; Act.param3:=Act.param6;
      Act.param4:=S1; Act.param5:=S2; Act.param6:=S3;
//== Remember the old parameters
      RememberAct:=Act;
      RememberAct.ObjectName:=Form1.TreeView1.Items[Act.ObjectIndex].Text;
      RememberAct.param1:=AffineVectorToString(Punkt.Koordinaten);
      RememberAct.param2:=VectorToString(Punkt.Material.FrontProperties.Diffuse.Color);
      ChangeAction(FActualIndex, RememberAct);}

      Form1.TreeView1.Items[Act.ObjectIndex].Text:=Act.ObjectName;
      TPunkt(TGLNode(Form1.TreeView1.Items[Act.ObjectIndex]).LinkedObject).Bezeichnung.Text:=Act.ObjectName;
      Form1.SetKugel(TKugel(TGLNode(Form1.TreeView1.Items[Act.ObjectIndex]).LinkedObject), AffineVector1, PUNKT_RADIUS);
      Punkt.ParamPosX1:=Act.param4;
      Punkt.ParamPosX2:=Act.param5;
      Punkt.ParamPosX3:=Act.param6;
      Punkt.Material.FrontProperties.Diffuse.Color:=StringToVector(Act.param8);
      Punkt.Material.BackProperties.Diffuse.Color:=StringToVector(Act.param8);
      Punkt.Bezeichnung.Material.FrontProperties.Diffuse.Color:=StringToVector(Act.param8);
      Punkt.Bezeichnung.Material.BackProperties.Diffuse.Color:=StringToVector(Act.param8);

      ChangeChildren(Punkt);

      ZeigeDaten(Punkt, Form1.Memo1);
    end;

//== STRECKE
    If Act.ObjectType = 'Strecke' then begin
      Strecke:=TStrecke(TGLNode(Form1.TreeView1.Items[Act.ObjectIndex]).LinkedObject);
      AffineVector1:=StringToAffineVector(Act.param8, Act.param9, Act.param7);
      AffineVector2:=StringToAffineVector(Act.param11, Act.param12, Act.param10);
//== Swap Koordinates
{      DummyAffineVector:=AffineVector1;
      SetVector(AffineVector1, DummyAffineVector[1], DummyAffineVector[2], DummyAffineVector[0]);
      DummyAffineVector:=AffineVector2;
      SetVector(AffineVector2, DummyAffineVector[1], DummyAffineVector[2], DummyAffineVector[0]);
//== Remember the old parameters
      RememberAct:=Act;
      RememberAct.ObjectName:=Form1.TreeView1.Items[Act.ObjectIndex].Text;
      RememberAct.param1:=AffineVectorToString(Gerade.Aufpunkt);
      RememberAct.param2:=AffineVectorToString(Gerade.RichtungsVektor);
      RememberAct.param3:=VectorToString(Gerade.Material.FrontProperties.Diffuse.Color);
      ChangeAction(FActualIndex, RememberAct);}

      Form1.TreeView1.Items[Act.ObjectIndex].Text:=Act.ObjectName;
      Form1.SetStrecke(TStrecke(TGLNode(Form1.TreeView1.Items[Act.ObjectIndex]).LinkedObject), AffineVector1,AffineVector2);
      Strecke.ParamP1X1:=Act.param7;
      Strecke.ParamP1X2:=Act.param8;
      Strecke.ParamP1X3:=Act.param9;
      Strecke.ParamP2X1:=Act.param10;
      Strecke.ParamP2X2:=Act.param11;
      Strecke.ParamP2X3:=Act.param12;
      Strecke.Material.FrontProperties.Diffuse.Color:=StringToVector(Act.param14);
      Strecke.Material.BackProperties.Diffuse.Color:=StringToVector(Act.param14);

      ChangeChildren(Strecke);

      ZeigeDaten(Strecke, Form1.Memo1);
    end;

//== GERADE
    If Act.ObjectType = 'Gerade' then begin
      Gerade:=TGerade(TGLNode(Form1.TreeView1.Items[Act.ObjectIndex]).LinkedObject);
      AffineVector1:=StringToAffineVector(Act.param8, Act.param9, Act.param7);
      AffineVector2:=StringToAffineVector(Act.param11, Act.param12, Act.param10);
//== Swap Koordinates
{      DummyAffineVector:=AffineVector1;
      SetVector(AffineVector1, DummyAffineVector[1], DummyAffineVector[2], DummyAffineVector[0]);
      DummyAffineVector:=AffineVector2;
      SetVector(AffineVector2, DummyAffineVector[1], DummyAffineVector[2], DummyAffineVector[0]);
//== Remember the old parameters
      RememberAct:=Act;
      RememberAct.ObjectName:=Form1.TreeView1.Items[Act.ObjectIndex].Text;
      RememberAct.param1:=AffineVectorToString(Gerade.Aufpunkt);
      RememberAct.param2:=AffineVectorToString(Gerade.RichtungsVektor);
      RememberAct.param3:=VectorToString(Gerade.Material.FrontProperties.Diffuse.Color);
      ChangeAction(FActualIndex, RememberAct);}

      Form1.TreeView1.Items[Act.ObjectIndex].Text:=Act.ObjectName;
      Form1.SetGerade(TGerade(TGLNode(Form1.TreeView1.Items[Act.ObjectIndex]).LinkedObject), AffineVector1,AffineVector2);
      Gerade.ParamPosX1:=Act.param7;
      Gerade.ParamPosX2:=Act.param8;
      Gerade.ParamPosX3:=Act.param9;
      Gerade.ParamDirX1:=Act.param10;
      Gerade.ParamDirX2:=Act.param11;
      Gerade.ParamDirX3:=Act.param12;
      Gerade.Material.FrontProperties.Diffuse.Color:=StringToVector(Act.param14);
      Gerade.Material.BackProperties.Diffuse.Color:=StringToVector(Act.param14);

      ChangeChildren(Gerade);

      ZeigeDaten(Gerade, Form1.Memo1);
    end;

//== EBENE
    If Act.ObjectType = 'Ebene' then begin
      Ebene:=TEbene(TGLNode(Form1.TreeView1.Items[Act.ObjectIndex]).LinkedObject);
      Vector:=VectorMake(StringToAffineVector(Act.param6, Act.param7, Act.param5), ProcessLine(Act.param8, VarsArchive));
      AffineVector2:=AffineVectorMake(Vector);
      VLength:=VectorLength(AffineVector2);
      SetVector(AffineVector1, -Vector[0]*Vector[3]/(VLength*VLength), -Vector[1]*Vector[3]/(VLength*VLength), -Vector[2]*Vector[3]/(VLength*VLength));
//== Swap Koordinates
{      DummyAffineVector:=AffineVector1;
      SetVector(AffineVector1, DummyAffineVector[1], DummyAffineVector[2], DummyAffineVector[0]);
      DummyAffineVector:=AffineVector2;
      SetVector(AffineVector2, DummyAffineVector[1], DummyAffineVector[2], DummyAffineVector[0]);
//== Remember the old parameters
      RememberAct:=Act;
      RememberAct.ObjectName:=Form1.TreeView1.Items[Act.ObjectIndex].Text;
      RememberAct.param1:=AffineVectorToString(Ebene.NormalenVektor)+';'+
                          FloatToStr(VectorDotProduct(Ebene.Aufpunkt, Ebene.NormalenVektor));
      RememberAct.param2:=VectorToString(Ebene.Material.FrontProperties.Diffuse.Color);
      ChangeAction(FActualIndex, RememberAct);  }

      Form1.TreeView1.Items[Act.ObjectIndex].Text:=Act.ObjectName;
      Form1.SetEbene(TEbene(TGLNode(Form1.TreeView1.Items[Act.ObjectIndex]).LinkedObject), AffineVector1, AffineVector2);
      Ebene.ParamDirX1:=Act.param5;
      Ebene.ParamDirX2:=Act.param6;
      Ebene.ParamDirX3:=Act.param7;
      Ebene.ParamPosX1:=ProcessTriadLine('-('+Act.param5+')*('+Act.param8+')/(('+Act.param5+')^2+('+Act.param6+')^2+('+Act.param7+')^2'+')');
      Ebene.ParamPosX2:=ProcessTriadLine('-('+Act.param6+')*('+Act.param8+')/(('+Act.param5+')^2+('+Act.param6+')^2+('+Act.param7+')^2'+')');
      Ebene.ParamPosX3:=ProcessTriadLine('-('+Act.param7+')*('+Act.param8+')/(('+Act.param5+')^2+('+Act.param6+')^2+('+Act.param7+')^2'+')');
      Ebene.Param_N0:=Act.param8;
      Ebene.Material.FrontProperties.Diffuse.Color:=StringToVector(Act.param10);
      Ebene.Material.BackProperties.Diffuse.Color:=StringToVector(Act.param10);

      ChangeChildren(Ebene);

      ZeigeDaten(Ebene, Form1.Memo1);
    end;

//== KREIS
    If Act.ObjectType = 'Kreis' then begin
      Kreis:=TKreis(TGLNode(Form1.TreeView1.Items[Act.ObjectIndex]).LinkedObject);
      AffineVector1:=StringToAffineVector(Act.param9, Act.param10, Act.param8);
      Vector:=VectorMake(StringToAffineVector(Act.param12, Act.param13, Act.param11), ProcessLine(Act.param14, VarsArchive));
      AffineVector2:=AffineVectorMake(Vector);

      Form1.TreeView1.Items[Act.ObjectIndex].Text:=Act.ObjectName;
      Form1.SetKreis(TKreis(TGLNode(Form1.TreeView1.Items[Act.ObjectIndex]).LinkedObject), AffineVector1, AffineVector2, Vector[3]);

      Kreis.ParamPosX1:=Act.param8;
      Kreis.ParamPosX2:=Act.param9;
      Kreis.ParamPosX3:=Act.param10;
      Kreis.ParamDirX1:=Act.param11;
      Kreis.ParamDirX2:=Act.param12;
      Kreis.ParamDirX3:=Act.param13;
      Kreis.ParamRadius:=Act.param14;
      Kreis.Material.FrontProperties.Diffuse.Color:=StringToVector(Act.param16);
      Kreis.Material.BackProperties.Diffuse.Color:=StringToVector(Act.param16);

      ChangeChildren(Kreis);

      ZeigeDaten(Kreis, Form1.Memo1);
    end;

//== KUGEL
    If Act.ObjectType = 'Kugel' then begin
      Kugel:=TKugel(TGLNode(Form1.TreeView1.Items[Act.ObjectIndex]).LinkedObject);
      Vector:=VectorMake(StringToAffineVector(Act.param6, Act.param7, Act.param5), ProcessLine(Act.param8, VarsArchive));
      AffineVector1:=AffineVectorMake(Vector);

      Form1.TreeView1.Items[Act.ObjectIndex].Text:=Act.ObjectName;
      Form1.SetKugel(TKugel(TGLNode(Form1.TreeView1.Items[Act.ObjectIndex]).LinkedObject), AffineVector1, Vector[3]);

      Kugel.ParamPosX1:=Act.param5;
      Kugel.ParamPosX2:=Act.param6;
      Kugel.ParamPosX3:=Act.param7;
      Kugel.ParamRadius:=Act.param8;
      Kugel.Material.FrontProperties.Diffuse.Color:=StringToVector(Act.param10);
      Kugel.Material.BackProperties.Diffuse.Color:=StringToVector(Act.param10);

      ChangeChildren(Kugel);

      ZeigeDaten(Kugel, Form1.Memo1);
    end;
  end;

// Namen �ndern
  If Act.Instruction = 'ChangeName' then begin
    if GetObjNode(Act.param1, Form1.TreeView1) <> nil then begin
      GetObjNode(Act.param1, Form1.TreeView1).Text:=Act.param2;
      SetObjName(FindObject(Act.param1), Act.param2);
    end;  
  end;
end;

procedure TActionsList.UndoAction(Act: TActions);
var
  NewAct: TActions;
begin
  NewAct:=Act;

  If Act.Instruction = 'Create Macro Begin' then
    NewAct.Instruction:= 'Delete Macro End';
  If Act.Instruction = 'Create Macro End' then
    NewAct.Instruction:= 'Delete Macro Begin';
  If Act.Instruction = 'Delete Macro End' then
    NewAct.Instruction:= 'Create Macro Begin';
  If Act.Instruction = 'Delete Macro Begin' then
    NewAct.Instruction:= 'Create Macro End';
  If Act.Instruction = 'Create' then
    NewAct.Instruction:= 'Delete';
  If Act.Instruction = 'Delete' then
    NewAct.Instruction:= 'Create';
  If Act.Instruction = 'ChangeObject' then begin
    If Act.ObjectType = 'Punkt' then begin
      NewAct.param1:=Act.param4; NewAct.param2:=Act.param5; NewAct.param3:=Act.param6;
      NewAct.param4:=Act.param1; NewAct.param5:=Act.param2; NewAct.param6:=Act.param3;
      NewAct.param7:=Act.param8; NewAct.param8:=Act.param7;
    end;
    If Act.ObjectType = 'Strecke' then begin
      NewAct.param1:=Act.param7; NewAct.param2:=Act.param8; NewAct.param3:=Act.param9;
      NewAct.param4:=Act.param10; NewAct.param5:=Act.param11; NewAct.param6:=Act.param12;
      NewAct.param7:=Act.param1; NewAct.param8:=Act.param2; NewAct.param9:=Act.param3;
      NewAct.param10:=Act.param4; NewAct.param11:=Act.param5; NewAct.param12:=Act.param6;
      NewAct.param13:=Act.param14; NewAct.param14:=Act.param13;
    end;
    If Act.ObjectType = 'Gerade' then begin
      NewAct.param1:=Act.param7; NewAct.param2:=Act.param8; NewAct.param3:=Act.param9;
      NewAct.param4:=Act.param10; NewAct.param5:=Act.param11; NewAct.param6:=Act.param12;
      NewAct.param7:=Act.param1; NewAct.param8:=Act.param2; NewAct.param9:=Act.param3;
      NewAct.param10:=Act.param4; NewAct.param11:=Act.param5; NewAct.param12:=Act.param6;
      NewAct.param13:=Act.param14; NewAct.param14:=Act.param13;
    end;
    If Act.ObjectType = 'Ebene' then begin
      NewAct.param1:=Act.param5; NewAct.param2:=Act.param6;
      NewAct.param3:=Act.param7;  NewAct.param4:=Act.param8;
      NewAct.param5:=Act.param1; NewAct.param6:=Act.param2;
      NewAct.param7:=Act.param3; NewAct.param8:=Act.param4;
      NewAct.param9:=Act.param10; NewAct.param10:=Act.param9;
    end;
    If Act.ObjectType = 'Kreis' then begin
      NewAct.param1:=Act.param8; NewAct.param2:=Act.param9;
      NewAct.param3:=Act.param10;  NewAct.param4:=Act.param11;
      NewAct.param5:=Act.param12; NewAct.param6:=Act.param13;
      NewAct.param7:=Act.param14; NewAct.param8:=Act.param1;
      NewAct.param9:=Act.param2; NewAct.param10:=Act.param3;
      NewAct.param11:=Act.param4; NewAct.param12:=Act.param5;
      NewAct.param13:=Act.param6; NewAct.param14:=Act.param7;
      NewAct.param15:=Act.param16; NewAct.param16:=Act.param15;
    end;
    If Act.ObjectType = 'Kugel' then begin
      NewAct.param1:=Act.param5; NewAct.param2:=Act.param6;
      NewAct.param3:=Act.param7;  NewAct.param4:=Act.param8;
      NewAct.param5:=Act.param1; NewAct.param6:=Act.param2;
      NewAct.param7:=Act.param3; NewAct.param8:=Act.param4;
      NewAct.param9:=Act.param10; NewAct.param10:=Act.param9;
    end;
  end;
  If Act.Instruction = 'ChangeName' then begin
    NewAct.param1:=Act.param2;
    NewAct.param2:=Act.param1;
  end;
  DoAction(NewAct);
end;

procedure TActionsList.AddAction(Action: String);
var
  i: integer;
begin
  Insert(FActualIndex, Action);
  Inc(FActualIndex);
  for i:=FActualIndex to Count-1 do
    Delete(FActualIndex);
end;

procedure TActionsList.InsertAction(Action: string);
begin
  Insert(FActualIndex, Action);
  Inc(FActualIndex);
end;

procedure TActionsList.ChangeAction(Index: integer; Act: TActions);
var
  s: string;
begin
  s:=Act.Instruction+'|'+Act.ObjectType+'|'+IntToStr(Act.ObjectIndex)+'|'+Act.ObjectName
     +'|'+Act.param1+'|'+Act.param2+'|'+Act.param3+'|'+Act.param4
     +'|'+Act.param5+'|'+Act.param6;
  Self.Put(Index, s);
end;

procedure TActionsList.UndoLastAction;
var
  Act: TActions;
begin
  If FActualIndex=0 then Exit;
  dec(FActualIndex);
  Act:=StringToAction(Get(FActualIndex));
  UndoAction(Act);
end;

procedure TActionsList.RedoLastAction;
var
  Act: TActions;
begin
  If FActualIndex=Count then Exit;
  Act:=StringToAction(Get(FActualIndex));
  DoAction(Act);
  inc(FActualIndex);
end;

procedure TActionsList.UndoAllActions;
var
  i: integer;
begin
  For i:=FActualIndex downto 1 do
    UndoLastAction;
end;

procedure TActionsList.RedoAllActions;
var
  i: integer;
begin
  For i:=FActualIndex to Count-1 do
    RedoLastAction;
end;

end.
