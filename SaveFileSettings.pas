unit SaveFileSettings;

interface

procedure LoadSettings;
procedure SaveSettings;
function SaveFile(FileName: string): boolean;
function LoadFile(FileName: string): boolean;

implementation

uses
  Main, SysUtils, Classes, Forms, IniFiles, GLContext, GLScene, Primitives,
  GLTreeView, Dialogs, MathParser, Einstellung;

procedure LoadSettings;
var
  Settings: TIniFile;
  S: string;

begin
  If FileExists(ExtractFilePath(Application.Exename)+'config.ini') then begin
    Settings:=TIniFile.Create(ExtractFilePath(Application.Exename)+'config.ini');

// Display
    Main.Settings.FDisplay.AntiAliasing := Settings.ReadBool('Display', 'Anti_Aliasing', False);

// Colors
    Main.Settings.FColors.Background := Settings.ReadInteger('Colors','Background', $00363636);
    Main.Settings.FColors.Grid := Settings.ReadInteger('Colors','Grid', $00363636);
    Main.Settings.FColors.Ticks := Settings.ReadInteger('Colors','Ticks', $00363636);
    Main.Settings.FColors.GroundPlane := Settings.ReadInteger('Colors','GroundPlane', $00363636);
    Main.Settings.FColors.GridAlpha := Settings.ReadFloat('Colors','GridAlpha', $00363636);
    Main.Settings.FColors.TicksAlpha := Settings.ReadFloat('Colors','TicksAlpha', $00363636);
    Main.Settings.FColors.GroundPlaneAlpha := Settings.ReadFloat('Colors','GroundPlaneAlpha', $00363636);

    Main.Settings.NotifyChanges;
  end;
end;

procedure SaveSettings;
var
  Settings: TIniFile;
begin
  Settings:=TIniFile.Create(ExtractFilePath(Application.Exename)+'config.ini');

// Version
  Settings.WriteString('Version', 'Vectory', FILE_VERSION);

// Display
  Settings.WriteBool('Display','Anti_Aliasing', Main.Settings.FDisplay.AntiAliasing);

// Colors
  Settings.WriteInteger('Colors','Background', Main.Settings.FColors.Background);
  Settings.WriteInteger('Colors','Grid', Main.Settings.FColors.Grid);
  Settings.WriteInteger('Colors','Ticks', Main.Settings.FColors.Ticks);
  Settings.WriteInteger('Colors','GroundPlane', Main.Settings.FColors.GroundPlane);
  Settings.WriteFloat('Colors','GridAlpha', Main.Settings.FColors.GridAlpha);
  Settings.WriteFloat('Colors','TicksAlpha', Main.Settings.FColors.TicksAlpha);
  Settings.WriteFloat('Colors','GroundPlaneAlpha', Main.Settings.FColors.GroundPlaneAlpha);

// Grid
  Settings.WriteBool('Grid','Koordinates', Main.Settings.FGrid.Koordinates);
  Settings.WriteBool('Grid','Schrift', Main.Settings.FGrid.Schrift);
  Settings.WriteBool('Grid','X1X2Plane', Main.Settings.FGrid.X1X2Plane);
  Settings.WriteBool('Grid','X1X3Plane', Main.Settings.FGrid.X1X3Plane);
  Settings.WriteBool('Grid','X2X3Plane', Main.Settings.FGrid.X2X3Plane);
  Settings.WriteBool('Grid','X1X2Raster', Main.Settings.FGrid.X1X2Raster);
  Settings.WriteBool('Grid','X1X3Raster', Main.Settings.FGrid.X1X3Raster);
  Settings.WriteBool('Grid','X2X3Raster', Main.Settings.FGrid.X2X3Raster);
//  Settings.WriteFloat('Grid','Scale', Main.Settings.FGrid.Scale);
//  Settings.WriteFloat('Grid','TickScale', Main.Settings.FGrid.TickScale);

// Environment
  Settings.WriteBool('Environment','RightPanel', Main.Settings.FEnvironment.RightPanel);
  Settings.WriteBool('Environment','LeftPanel', Main.Settings.FEnvironment.LeftPanel);
  Settings.WriteFloat('Environment','MouseSensity', Main.Settings.FEnvironment.MouseSensity);
//  Settings.WriteFloat('Environment','Massstab', Main.Settings.FEnvironment.Massstab);

end;

function SaveKoordinates(Obj: TGLBaseSceneObject): string;
begin
  Result:='';
  If Obj.ClassName = 'TPunkt' then
    With TPunkt(Obj) do begin
      Result:= Result + 'Position' + #13#10;
      Result:= Result + ParamPosX1 + #13#10;
      Result:= Result + ParamPosX2 + #13#10;
      Result:= Result + ParamPosX3 + #13#10;
    end;
  If Obj.ClassName = 'TStrecke' then
    With TStrecke(Obj) do begin
      Result:= Result + 'Punkt1' + #13#10;
      Result:= Result + ParamP1X1 + #13#10;
      Result:= Result + ParamP1X2 + #13#10;
      Result:= Result + ParamP1X3 + #13#10;
      Result:= Result + 'Punkt2' + #13#10;
      Result:= Result + ParamP2X1 + #13#10;
      Result:= Result + ParamP2X2 + #13#10;
      Result:= Result + ParamP2X3 + #13#10;
    end;
  If Obj.ClassName = 'TGerade' then
    With TGerade(Obj) do begin
      Result:= Result + 'Aufpunkt' + #13#10;
      Result:= Result + ParamPosX1 + #13#10;
      Result:= Result + ParamPosX2 + #13#10;
      Result:= Result + ParamPosX3 + #13#10;
      Result:= Result + 'Richtung' + #13#10;
      Result:= Result + ParamDirX1 + #13#10;
      Result:= Result + ParamDirX2 + #13#10;
      Result:= Result + ParamDirX3 + #13#10;
    end;
  If Obj.ClassName = 'TEbene' then
    With TEbene(Obj) do begin
      Result:= Result + 'Aufpunkt' + #13#10;
      Result:= Result + ParamPosX1 + #13#10;
      Result:= Result + ParamPosX2 + #13#10;
      Result:= Result + ParamPosX3 + #13#10;
      Result:= Result + 'Normale' + #13#10;
      Result:= Result + ParamDirX1 + #13#10;
      Result:= Result + ParamDirX2 + #13#10;
      Result:= Result + ParamDirX3 + #13#10;
    end;
  If Obj.ClassName = 'TKreis' then
    With TKreis(Obj) do begin
      Result:= Result + 'Position' + #13#10;
      Result:= Result + ParamPosX1 + #13#10;
      Result:= Result + ParamPosX2 + #13#10;
      Result:= Result + ParamPosX3 + #13#10;
      Result:= Result + 'Direction' + #13#10;
      Result:= Result + ParamDirX1 + #13#10;
      Result:= Result + ParamDirX2 + #13#10;
      Result:= Result + ParamDirX3 + #13#10;
      Result:= Result + 'Radius' + #13#10;
      Result:= Result + ParamRadius + #13#10;
    end;
  If Obj.ClassName = 'TKugel' then
    With TKugel(Obj) do begin
      Result:= Result + 'Position' + #13#10;
      Result:= Result + ParamPosX1 + #13#10;
      Result:= Result + ParamPosX2 + #13#10;
      Result:= Result + ParamPosX3 + #13#10;
      Result:= Result + 'Radius' + #13#10;
      Result:= Result + ParamRadius + #13#10;
    end;
end;

function SaveObject(Obj: TGLBaseSceneObject): string;
var
  i: integer;
begin
  Result:= 'Begin'+#13#10;
  Result:= Result + Copy(Obj.ClassName, 2, Length(Obj.ClassName)-1)+#13#10;
  Result:= Result + GetObjName(Obj)+#13#10;

  Result:= Result + SaveKoordinates(Obj);

  Result:= Result + 'CreationMode'+#13#10;
  Result:= Result + GetObjCreationMode(Obj)+#13#10;

  Result:= Result + 'Farbe'+#13#10;
  Result:= Result + IntToStr(TGLSceneObject(Obj).Material.FrontProperties.Diffuse.AsWinColor +
                             Round(TGLSceneObject(Obj).Material.FrontProperties.Diffuse.Alpha * 100) shl 24) + #13#10;

  for i:=1 to GetObjParentCount(Obj) do begin
    Result:= Result + 'Parent'+ IntToStr(i) + #13#10;
    Result:= Result + GetObjName(GetObjParent(Obj, i-1)) + #13#10;
  end;

  for i:=0 to GetObjChildCount(Obj)-1 do begin
    Result:= Result + 'Child'+ IntToStr(i+1) + #13#10;
    Result:= Result + GetObjName(GetObjChild(Obj, i)) + #13#10;
  end;

  Result:= Result + 'End'+#13#10;
end;

function SaveFile(FileName: string): boolean;
var
  i: integer;
  Stream: TStream;
  s: string;

begin
 With Form1 do begin

  for i:=0 to Length(VarsArchive)-1 do begin
    S:= S + VarsArchive[i].Name +#13#10;
    S:= S + FloatToStr(VarsArchive[i].Value)+#13#10;
  end;

  for i:=0 to TreeView1.Items.Count-1 do
    If TreeView1.Items[i].Level=1 then
      S:= S+SaveObject(TGLNode(TreeView1.Items[i]).LinkedObject);

  Stream:=TFileStream.Create(SaveDialog1.FileName, fmCreate);

  try
    Stream.WriteBuffer(Pointer(s)^, length(s));
  finally
    Stream.Free;
  end;
 end;
end;

procedure LoadPunkt(S: Array of string);
var
  Count: integer;
  ActStr: string;
  ObjName: string;
  Parents: Array of string;
  Children: Array of string;
  p1, p2, p3: single;
  CreationMode: string;
  Punkt: TPunkt;
begin
// Lade feste Größen zuerst
  ObjName:=S[2];
  p1:=ProcessLine(S[4], VarsArchive);
  p2:=ProcessLine(S[5], VarsArchive);
  p3:=ProcessLine(S[6], VarsArchive);

// Dann variable: Parents + Children
  Count:=7; ActStr:=S[Count];
  while ActStr <> 'End' do begin

    if Copy(ActStr, 1, 6) = 'Parent' then begin
      inc(Count);
      SetLength(Parents, Length(Parents)+1);
      Parents[StrToInt(Copy(ActStr, 7, Length(ActStr)-6))-1]:=S[Count];
    end;

    if Copy(ActStr, 1, 5) = 'Child' then begin
      inc(Count);
      SetLength(Children, Length(Children)+1);
      Children[StrToInt(Copy(ActStr, 6, Length(ActStr)-5))-1]:=S[Count];
    end;

    if ActStr = 'CreationMode' then begin
      inc(Count);
      CreationMode:=S[Count];
    end;

    inc(Count); ActStr:=S[Count];
  end;

// Erstelle den Punkt
  Form1.NewPunkt(p1, p2, p3);
  Punkt:= TPunkt(TGLNode(Form1.TreeView1.Selected).LinkedObject);

  for Count:=0 to Length(Parents)-1 do
    AddObjParent(Punkt, Parents[Count]);

  for Count:=0 to Length(Children)-1 do
    AddObjChild(Punkt, Children[Count]);

  Punkt.ObjectName:=ObjName;
  Form1.TreeView1.Selected.Text:=ObjName;
  Punkt.Bezeichnung.Text:=ObjName;

  SetObjCreationMode(Punkt, CreationMode);

  Punkt.ParamPosX1:=S[4];
  Punkt.ParamPosX2:=S[5];
  Punkt.ParamPosX3:=S[6];

  Punkt.Material.FrontProperties.Diffuse.AsWinColor:=StrToInt(S[10]) and $FFFFFF;
  Punkt.Bezeichnung.Material.FrontProperties.Diffuse.AsWinColor:=StrToInt(S[10]) and $FFFFFF;
end;

procedure LoadGerade(S: Array of string);
var
  Count: integer;
  ActStr: string;
  ObjName: string;
  Parents: Array of string;
  Children: Array of string;
  p1, p2, p3: single;
  d1, d2, d3: single;
  CreationMode: string;
  Gerade: TGerade;
begin
// Lade feste Größen zuerst
  ObjName:=S[2];
  p1:=ProcessLine(S[4], VarsArchive);
  p2:=ProcessLine(S[5], VarsArchive);
  p3:=ProcessLine(S[6], VarsArchive);
  d1:=ProcessLine(S[8], VarsArchive);
  d2:=ProcessLine(S[9], VarsArchive);
  d3:=ProcessLine(S[10], VarsArchive);

// Dann variable: Parents + Children
  Count:=7; ActStr:=S[Count];
  while ActStr <> 'End' do begin

    if Copy(ActStr, 1, 6) = 'Parent' then begin
      inc(Count);
      SetLength(Parents, Length(Parents)+1);
      Parents[StrToInt(Copy(ActStr, 7, Length(ActStr)-6))-1]:=S[Count];
    end;

    if Copy(ActStr, 1, 5) = 'Child' then begin
      inc(Count);
      SetLength(Children, Length(Children)+1);
      Children[StrToInt(Copy(ActStr, 6, Length(ActStr)-5))-1]:=S[Count];
    end;

    if ActStr = 'CreationMode' then begin
      inc(Count);
      CreationMode:=S[Count];
    end;

    inc(Count); ActStr:=S[Count];
  end;

// Erstelle die Gerade
  Form1.NewGerade(p1, p2, p3, d1, d2, d3);
  Gerade:= TGerade(TGLNode(Form1.TreeView1.Selected).LinkedObject);

  for Count:=0 to Length(Parents)-1 do
    AddObjParent(Gerade, Parents[Count]);

  for Count:=0 to Length(Children)-1 do
    AddObjChild(Gerade, Children[Count]);

  Gerade.ObjectName:=ObjName;
  Form1.TreeView1.Selected.Text:=ObjName;

  SetObjCreationMode(Gerade, CreationMode);

  Gerade.ParamPosX1:=S[4];
  Gerade.ParamPosX2:=S[5];
  Gerade.ParamPosX3:=S[6];
  Gerade.ParamDirX1:=S[8];
  Gerade.ParamDirX2:=S[9];
  Gerade.ParamDirX3:=S[10];

  Gerade.Material.FrontProperties.Diffuse.AsWinColor:=StrToInt(S[14]) and $FFFFFF;
end;

procedure LoadEbene(S: Array of string);
var
  Count: integer;
  ActStr: string;
  ObjName: string;
  Parents: Array of string;
  Children: Array of string;
  p1, p2, p3: single;
  d1, d2, d3: single;
  CreationMode: string;
  Ebene: TEbene;
begin
// Lade feste Größen zuerst
  ObjName:=S[2];
  p1:=ProcessLine(S[4], VarsArchive);
  p2:=ProcessLine(S[5], VarsArchive);
  p3:=ProcessLine(S[6], VarsArchive);
  d1:=ProcessLine(S[8], VarsArchive);
  d2:=ProcessLine(S[9], VarsArchive);
  d3:=ProcessLine(S[10], VarsArchive);

// Dann variable: Parents + Children
  Count:=7; ActStr:=S[Count];
  while ActStr <> 'End' do begin

    if Copy(ActStr, 1, 6) = 'Parent' then begin
      inc(Count);
      SetLength(Parents, Length(Parents)+1);
      Parents[StrToInt(Copy(ActStr, 7, Length(ActStr)-6))-1]:=S[Count];
    end;

    if Copy(ActStr, 1, 5) = 'Child' then begin
      inc(Count);
      SetLength(Children, Length(Children)+1);
      Children[StrToInt(Copy(ActStr, 6, Length(ActStr)-5))-1]:=S[Count];
    end;

    if ActStr = 'CreationMode' then begin
      inc(Count);
      CreationMode:=S[Count];
    end;

    inc(Count); ActStr:=S[Count];
  end;

// Erstelle die Ebene
  Form1.NewEbene(p1, p2, p3, d1, d2, d3);
  Ebene:= TEbene(TGLNode(Form1.TreeView1.Selected).LinkedObject);

  for Count:=0 to Length(Parents)-1 do
    AddObjParent(Ebene, Parents[Count]);

  for Count:=0 to Length(Children)-1 do
    AddObjChild(Ebene, Children[Count]);

  Ebene.ObjectName:=ObjName;
  Form1.TreeView1.Selected.Text:=ObjName;

  SetObjCreationMode(Ebene, CreationMode);

  Ebene.ParamPosX1:=S[4];
  Ebene.ParamPosX2:=S[5];
  Ebene.ParamPosX3:=S[6];
  Ebene.ParamDirX1:=S[8];
  Ebene.ParamDirX2:=S[9];
  Ebene.ParamDirX3:=S[10];

  Ebene.Material.FrontProperties.Diffuse.AsWinColor:=StrToInt(S[14]) and $FFFFFF;
  Ebene.Material.BackProperties.Diffuse.AsWinColor:=StrToInt(S[14]) and $FFFFFF;
  If StrToInt(S[14]) shr 24 > 0 then begin
    Ebene.Material.FrontProperties.Diffuse.Alpha:=(StrToInt(S[14]) shr 24)/100;
    Ebene.Material.BackProperties.Diffuse.Alpha:=(StrToInt(S[14]) shr 24)/100;
  end else begin
    Ebene.Material.FrontProperties.Diffuse.Alpha:=0.8;
    Ebene.Material.BackProperties.Diffuse.Alpha:=0.8;
  end;  
end;

procedure LoadStrecke(S: Array of string);
var
  Count: integer;
  ActStr: string;
  ObjName: string;
  Parents: Array of string;
  Children: Array of string;
  p1, p2, p3: single;
  q1, q2, q3: single;
  CreationMode: string;
  Strecke: TStrecke;
begin
// Lade feste Größen zuerst
  ObjName:=S[2];
  p1:=ProcessLine(S[4], VarsArchive);
  p2:=ProcessLine(S[5], VarsArchive);
  p3:=ProcessLine(S[6], VarsArchive);
  q1:=ProcessLine(S[8], VarsArchive);
  q2:=ProcessLine(S[9], VarsArchive);
  q3:=ProcessLine(S[10], VarsArchive);

// Dann variable: Parents + Children
  Count:=7; ActStr:=S[Count];
  while ActStr <> 'End' do begin

    if Copy(ActStr, 1, 6) = 'Parent' then begin
      inc(Count);
      SetLength(Parents, Length(Parents)+1);
      Parents[StrToInt(Copy(ActStr, 7, Length(ActStr)-6))-1]:=S[Count];
    end;

    if Copy(ActStr, 1, 5) = 'Child' then begin
      inc(Count);
      SetLength(Children, Length(Children)+1);
      Children[StrToInt(Copy(ActStr, 6, Length(ActStr)-5))-1]:=S[Count];
    end;

    if ActStr = 'CreationMode' then begin
      inc(Count);
      CreationMode:=S[Count];
    end;

    inc(Count); ActStr:=S[Count];
  end;

// Erstelle die Strecke
  Form1.NewStrecke(p1, p2, p3, q1, q2, q3);
  Strecke:= TStrecke(TGLNode(Form1.TreeView1.Selected).LinkedObject);

  for Count:=0 to Length(Parents)-1 do
    AddObjParent(Strecke, Parents[Count]);

  for Count:=0 to Length(Children)-1 do
    AddObjChild(Strecke, Children[Count]);

  Strecke.ObjectName:=ObjName;
  Form1.TreeView1.Selected.Text:=ObjName;

  SetObjCreationMode(Strecke, CreationMode);

  Strecke.ParamP1X1:=S[4];
  Strecke.ParamP1X2:=S[5];
  Strecke.ParamP1X3:=S[6];
  Strecke.ParamP2X1:=S[8];
  Strecke.ParamP2X2:=S[9];
  Strecke.ParamP2X3:=S[10];

  Strecke.Material.FrontProperties.Diffuse.AsWinColor:=StrToInt(S[14]) and $FFFFFF;
end;

procedure LoadKreis(S: Array of string);
var
  Count: integer;
  ActStr: string;
  ObjName: string;
  Parents: Array of string;
  Children: Array of string;
  p1, p2, p3: single;
  n1, n2, n3: single;
  r: single;
  CreationMode: string;
  Kugel: TKugel;
  Kreis: TKreis;
begin
// Lade feste Größen zuerst
  ObjName:=S[2];
  p1:=ProcessLine(S[4], VarsArchive);
  p2:=ProcessLine(S[5], VarsArchive);
  p3:=ProcessLine(S[6], VarsArchive);
  n1:=ProcessLine(S[8], VarsArchive);
  n2:=ProcessLine(S[9], VarsArchive);
  n3:=ProcessLine(S[10], VarsArchive);
  r:= ProcessLine(S[12], VarsArchive);

// Dann variable: Parents + Children
  Count:=14; ActStr:=S[Count];
  while ActStr <> 'End' do begin

    if Copy(ActStr, 1, 6) = 'Parent' then begin
      inc(Count);
      SetLength(Parents, Length(Parents)+1);
      Parents[StrToInt(Copy(ActStr, 7, Length(ActStr)-6))-1]:=S[Count];
    end;

    if Copy(ActStr, 1, 5) = 'Child' then begin
      inc(Count);
      SetLength(Children, Length(Children)+1);
      Children[StrToInt(Copy(ActStr, 6, Length(ActStr)-5))-1]:=S[Count];
    end;

    if ActStr = 'CreationMode' then begin
      inc(Count);
      CreationMode:=S[Count];
    end;

    inc(Count); ActStr:=S[Count];
  end;

// Erstelle den Kreis
  Form1.NewKreis(p1, p2, p3, n1, n2, n3, r);
  Kreis:= TKreis(TGLNode(Form1.TreeView1.Selected).LinkedObject);

  for Count:=0 to Length(Parents)-1 do
    AddObjParent(Kreis, Parents[Count]);

  for Count:=0 to Length(Children)-1 do
    AddObjChild(Kreis, Children[Count]);

  SetObjCreationMode(Kreis, CreationMode);

  Kreis.ObjectName:=ObjName;
  Form1.TreeView1.Selected.Text:=ObjName;

  Kreis.ParamPosX1:=S[4];
  Kreis.ParamPosX2:=S[5];
  Kreis.ParamPosX3:=S[6];

  Kreis.ParamDirX1:=S[8];
  Kreis.ParamDirX2:=S[9];
  Kreis.ParamDirX3:=S[10];

  Kreis.ParamRadius:=S[12];

  Kreis.Material.FrontProperties.Diffuse.AsWinColor:=StrToInt(S[16]) and $FFFFFF;
end;

procedure LoadKugel(S: Array of string);
var
  Count: integer;
  ActStr: string;
  ObjName: string;
  Parents: Array of string;
  Children: Array of string;
  p1, p2, p3: single;
  r: single;
  CreationMode: string;
  Kugel: TKugel;
begin
// Lade feste Größen zuerst
  ObjName:=S[2];
  p1:=ProcessLine(S[4], VarsArchive);
  p2:=ProcessLine(S[5], VarsArchive);
  p3:=ProcessLine(S[6], VarsArchive);
  r:= ProcessLine(S[8], VarsArchive);

// Dann variable: Parents + Children
  Count:=9; ActStr:=S[Count];
  while ActStr <> 'End' do begin

    if Copy(ActStr, 1, 6) = 'Parent' then begin
      inc(Count);
      SetLength(Parents, Length(Parents)+1);
      Parents[StrToInt(Copy(ActStr, 7, Length(ActStr)-6))-1]:=S[Count];
    end;

    if Copy(ActStr, 1, 5) = 'Child' then begin
      inc(Count);
      SetLength(Children, Length(Children)+1);
      Children[StrToInt(Copy(ActStr, 6, Length(ActStr)-5))-1]:=S[Count];
    end;

    if ActStr = 'CreationMode' then begin
      inc(Count);
      CreationMode:=S[Count];
    end;

    inc(Count); ActStr:=S[Count];
  end;

// Erstelle die Kugel
  Form1.NewKugel(p1, p2, p3, r);
  Kugel:= TKugel(TGLNode(Form1.TreeView1.Selected).LinkedObject);

  for Count:=0 to Length(Parents)-1 do
    AddObjParent(Kugel, Parents[Count]);

  for Count:=0 to Length(Children)-1 do
    AddObjChild(Kugel, Children[Count]);

  SetObjCreationMode(Kugel, CreationMode);

  Kugel.ObjectName:=ObjName;
  Form1.TreeView1.Selected.Text:=ObjName;

  Kugel.ParamPosX1:=S[4];
  Kugel.ParamPosX2:=S[5];
  Kugel.ParamPosX3:=S[6];
  Kugel.ParamRadius:=S[8];

  Kugel.Material.FrontProperties.Diffuse.AsWinColor:=StrToInt(S[12]) and $FFFFFF;
  If StrToInt(S[12]) shr 24 > 0 then
    Kugel.Material.FrontProperties.Diffuse.Alpha:=(StrToInt(S[12]) shr 24)/100
  else
    Kugel.Material.FrontProperties.Diffuse.Alpha:=0.8;
end;

procedure LoadObject(S: Array of string);
var
  ActualString: string;
begin
  ActualString:=S[1];
  If ActualString = 'Punkt' then
    LoadPunkt(S);
  If ActualString = 'Strecke' then
    LoadStrecke(S);
  If ActualString = 'Gerade' then
    LoadGerade(S);
  If ActualString = 'Ebene' then
    LoadEbene(S);
  If ActualString = 'Kreis' then
    LoadKreis(S);
  If ActualString = 'Kugel' then
    LoadKugel(S);
end;

function LoadFile(FileName: string): boolean;
var
  Count: integer;
  s: Array of string;
  GeoFile: TextFile;
  ActStr: string;
begin
 If FileExists(FileName) then
   With Form1 do begin
     AssignFile(GeoFile, FileName);
     Reset(GeoFile);
     Count:=0;
     while not EOF(GeoFile) do begin
       ReadLn(GeoFile, ActStr);

       // Load the variables
       If ActStr[1] in ['a'..'z'] then begin
         SetLength(VarsArchive, Count+1);
         VarsArchive[Count].Name:=ActStr;
         ReadLn(GeoFile, ActStr);
         VarsArchive[Count].Value:=StrToFloat(ActStr);
         inc(Count);
       end;

       //Load the objects
       If ActStr = 'Begin' then begin
         while ActStr <> 'End' do begin
           SetLength(S, Length(S)+1);
           S[Length(S)-1]:=ActStr;
           ReadLn(GeoFile, ActStr);
         end;
         SetLength(S, Length(S)+1);
         S[Length(S)-1]:=ActStr;
         LoadObject(S);
         SetLength(S, 0);
       end;
     end;

     CloseFile(GeoFile);
   end;
end;

end.
