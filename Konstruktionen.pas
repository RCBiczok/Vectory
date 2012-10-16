unit Konstruktionen;

interface

uses
  Primitives, VectorGeometry;

function NormalePG(var ResultObj: TGerade; Punkt: TPunkt; Gerade: TGerade): TGerade;
function NormalePE(var ResultObj: TGerade; Punkt: TPunkt; Ebene: TEbene): TGerade;

implementation

uses
  Main;

function NormalePG(var ResultObj: TGerade; Punkt: TPunkt; Gerade: TGerade): TGerade;
var
  v1, v2, v3, v4: TAffineVector;
begin
  v1:= Punkt.Koordinaten;
  If Gerade.ClassType = TGerade then
    v2:= Gerade.Aufpunkt
  else begin
    v2[0]:= Gerade.Position.AsAffineVector[2];
    v2[1]:= Gerade.Position.AsAffineVector[0];
    v2[2]:= Gerade.Position.AsAffineVector[1];
  end;
  v3:= VectorSubtract(v1, v2);
  If Gerade.ClassType = TGerade then
    v4:= Gerade.RichtungsVektor
  else begin
    v4[0]:= Gerade.Up.AsAffineVector[2];
    v4[1]:= Gerade.Up.AsAffineVector[0];
    v4[2]:= Gerade.Up.AsAffineVector[1];
  end;
  ScaleVector(v4, VectorDotProduct(v3, v4)/VectorDotProduct(v4, v4));
  v3:= VectorSubtract(VectorAdd(v2, v4), v1);
  ResultObj.Aufpunkt:= v1;
  ResultObj.RichtungsVektor:= v3;
//  ResultObj.Position.X:= v1[1]; ResultObj.Position.Y:= v1[2]; ResultObj.Position.Z:= v1[0];
//  ResultObj.Up.X:= v3[1]; ResultObj.Up.Y:= v3[2]; ResultObj.Up.Z:= v3[0];
end;

function NormalePE(var ResultObj: TGerade; Punkt: TPunkt; Ebene: TEbene): TGerade;
var
  v1, v2, v3, v4: TAffineVector;
begin
  ResultObj.Aufpunkt:= Punkt.Koordinaten;
  ResultObj.RichtungsVektor:= Ebene.NormalenVektor;
//  ResultObj.Position.X:= v1[1]; ResultObj.Position.Y:= v1[2]; ResultObj.Position.Z:= v1[0];
//  ResultObj.Up.X:= v3[1]; ResultObj.Up.Y:= v3[2]; ResultObj.Up.Z:= v3[0];
end;

end.
