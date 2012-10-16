unit SchnittBerechnung;

interface

uses GLScene, VectorGeometry, Math;

type TSchnittObjekte = Array of TGLBaseSceneObject;

function ErmittleSchnittmenge(Objekte: TSchnittObjekte): TGLBaseSceneObject;

implementation

uses Main, GLObjects;

function Kollinear(Vector1, Vector2: TAffineVector): Boolean;
begin
  result := IsZero(Abs(VectorAngleCosine(Vector1, Vector2))-1, 0.0000001);
end;

function Schneide(Punkt1, Punkt2: TPunkt): TPunkt; overload;
begin    //==  Prüfe ob zwei Punkte identisch sind
  if (Punkt1 = NIL) or (Punkt2 = NIL) then begin
    result := NIL; exit;
  end;
  if Punkt1.Position = Punkt2.Position then
    result := Punkt1 else result := NIL;
end;

function Schneide(Punkt: TPunkt; Gerade: TGerade): TPunkt; overload;
begin    //== Prüfe ob Punkt auf Gerade liegt
    if (Punkt = NIL) or (Gerade = NIL) then begin
    result := NIL; exit;
  end;
  if Kollinear(Gerade.Up.AsAffineVector,
               VectorSubtract(Punkt.Position.AsAffineVector, Gerade.Position.AsAffineVector)) then
    result := Punkt else result := NIL;
end;

function Schneide(Gerade: TGerade; Punkt: TPunkt): TPunkt; overload;
begin    //== Prüfe ob Gerade durch Punkt geht
  result := Schneide(Punkt, Gerade);
end;

function Schneide(Gerade1, Gerade2: TGerade): TGLBaseSceneObject; overload;
var Matrix: TAffineMatrix;
    m,n,p,q, n2: TAffineVector;
    l: single;
    Punkt: TPunkt;
begin    //== Prüfe ob sich zwei Geraden schneiden
  if (Gerade1 = NIL) or (Gerade2 = NIL) then begin
    result := NIL; exit;
  end;
  Matrix[0] := Gerade1.Up.AsAffineVector;
  Matrix[1] := Gerade2.Up.AsAffineVector;
  Matrix[2] := VectorSubtract(Gerade2.Position.AsAffineVector, Gerade1.Position.AsAffineVector);


  if Kollinear(Gerade1.Up.AsAffineVector, Gerade2.Up.AsAffineVector) then
    if Kollinear(VectorSubtract(Gerade2.Position.AsAffineVector, Gerade1.Position.AsAffineVector), Gerade1.Up.AsAffineVector)
       or IsZero(VectorLength(VectorSubtract(Gerade2.Position.AsAffineVector, Gerade1.Position.AsAffineVector)), 0.00001) then
      TGerade(result) := Gerade1 //== Geraden sind identisch
    else result := NIL //= Geraden sind parallel
  else
    if (MatrixDeterminant(Matrix) >0.0001) or (MatrixDeterminant(Matrix) < -0.0001) then
      result := NIL //== Geraden sind Windschief
    else begin //== Geraden schneiden sich
      n:=Gerade1.Up.AsAffineVector; m:=Gerade2.Up.AsAffineVector;
      n2:=VectorCrossProduct(m, VectorCrossProduct(n,m));
      p:=Gerade1.Position.AsAffineVector; q:=Gerade2.Position.AsAffineVector;
      l:=VectorDotProduct(VectorSubtract(q, p), n2)/VectorDotProduct(n, n2);
      l:=Round(l*10000000)/10000000;
      CombineVector(p, n, l);
      Punkt := TPunkt.Create(Form1.DummyCube1);
      Punkt.Position.AsAffineVector:=p;
      Punkt.Koordinaten[0]:=p[2]; Punkt.Koordinaten[1]:=p[0]; Punkt.Koordinaten[2]:=p[1];
      result := Punkt;
    end;
end;

function Schneide(Punkt: TPunkt; Ebene: TEbene): TPunkt; overload;
begin    //== Prüfe ob Punkt in Ebene liegt
  if (Punkt = NIL) or (Ebene = NIL) then begin
    result := NIL; exit;
  end;
  if abs(VectorDotProduct(VectorSubtract(Punkt.Position.AsAffineVector, Ebene.Position.AsAffineVector),
                       Ebene.Direction.AsAffineVector))<0.000001 then result := Punkt else result := NIL;
end;

function Schneide(Ebene: TEbene; Punkt: TPunkt): TPunkt; overload;
begin    //== Prüfe ob Ebene durch Punkt verläuft
  result := Schneide(Punkt, Ebene);
end;

function Schneide(Gerade: TGerade; Ebene: TEbene): TGLBaseSceneObject; overload;
var
    l: single;
    n, p, v, a: TAffineVector;
    Punkt: TPunkt;
    i: integer;

begin    //== Prüfe ob Gerade Ebene schneidet
  if (Gerade = NIL) or (Ebene = NIL) then begin
    result := NIL; exit;
  end;
  if IsZero(VectorDotProduct(Gerade.Up.AsAffineVector, Ebene.Direction.AsAffineVector), 0.000001) then
    if IsZero(VectorDotProduct(VectorSubtract(Gerade.Position.AsAffineVector, Ebene.Position.AsAffineVector),
                        Ebene.Direction.AsAffineVector), 0.000001) then
      TGerade(result) := Gerade //== Gerade liegt in der Ebene
    else result := NIL //== Gerade ist parallel zur Ebene
  else begin //== Gerade schneidet Ebene - nur wo?
    a:=Ebene.Position.AsAffineVector;
    n:=Ebene.Direction.AsAffineVector;
    p:=Gerade.Position.AsAffineVector;
    v:=Gerade.Up.AsAffineVector;
    l:=VectorDotProduct(n, VectorSubtract(a, p))/VectorDotProduct(v, n);
    CombineVector(p, v, l);
    Punkt:=TPunkt.Create(Form1.DummyCube1);
    for i:=0 to 2 do
      p[i]:=round(p[i]*1000000)/1000000;
    Punkt.Position.AsAffineVector:= p;
    Punkt.Koordinaten[0]:=p[2]; Punkt.Koordinaten[1]:=p[0]; Punkt.Koordinaten[2]:=p[1];
    TPunkt(result) := Punkt;
  end;
end;

function Schneide(Ebene: TEbene; Gerade: TGerade): TGLBaseSceneObject; overload;
begin    //== Prüfe ob Ebene Gerade schneidet
  result := Schneide(Gerade, Ebene);
end;

function Schneide(Ebene1, Ebene2: TEbene): TGLBaseSceneObject; overload;
var LoesungsVektor: TAffineVector;
    X, P, Q, n, n1, n2: TAffineVector;
    l: single;
    Gerade: TGerade;
    i: integer;

begin   //== Prüfe ob sich zwei Ebenen schneiden
  if (Ebene1 = NIL) or (Ebene2 = NIL) then begin
    result := NIL; exit;
  end;
  if Kollinear(Ebene1.Direction.AsAffineVector, Ebene2.Direction.AsAffineVector) then
    if IsZero(VectorDotProduct(VectorSubtract(Ebene2.Position.AsAffineVector, Ebene1.Position.AsAffineVector), Ebene1.Direction.AsAffineVector), 0.000001) then
      TEbene(result) := Ebene1 //== Ebenen identisch
    else result := NIL //== Ebenen parallel
  else begin //== Ebenen schneiden sich - nur wo?

    If (Ebene1.ClassType = TEbene) and (Ebene2.ClassType = TEbene) then
      If not IsZero(VectorLength(Ebene1.NormalenVektor), 0.000001) and
         not IsZero(VectorLength(Ebene2.NormalenVektor), 0.000001) then begin
        n1:=AffineVectorMake(Ebene1.NormalenVektor[1],Ebene1.NormalenVektor[2],Ebene1.NormalenVektor[0]);
        n2:=AffineVectorMake(Ebene2.NormalenVektor[1],Ebene2.NormalenVektor[2],Ebene2.NormalenVektor[0]);
      end else begin
        n1:=Ebene1.Direction.AsAffineVector;
        n2:=Ebene2.Direction.AsAffineVector;
      end
    else begin
      n1:=Ebene1.Direction.AsAffineVector;
      n2:=Ebene2.Direction.AsAffineVector;
    end;  

    LoesungsVektor:=VectorCrossProduct(n1, n2);
    n:=VectorCrossProduct(n1,VectorCrossProduct(n1,n2));
    P:=Ebene1.Position.AsAffineVector; Q:=Ebene2.Position.AsAffineVector;
    l:=VectorDotProduct(VectorSubtract(q, p), n2)/VectorDotProduct(n,n2);
//    l:=Round(l*10000000)/10000000;
    CombineVector(P, n, l); X:=P;
    Gerade:=TGerade.Create(Form1.DummyCube1);
    for i:=0 to 2 do
      X[i]:=round(X[i]*1000000)/1000000;
    Gerade.Aufpunkt:=X;
    Gerade.RichtungsVektor:=AffineVectorMake(LoesungsVektor[2],LoesungsVektor[0],LoesungsVektor[1]);
    Gerade.Position.AsAffineVector:=X;
    Gerade.Up.AsAffineVector:=LoesungsVektor;
    TGerade(result) := Gerade; //== Übergebe Gerade
    //Gerade.Destroy;
  end;
end;

function Schneide(Punkt: TPunkt; Strecke: TStrecke): TGLBaseSceneObject; overload;
var
  V1, V2, V3: TAffineVector;
begin
  Result:= NIL;

  V2:= VectorSubtract(Strecke.AnfangsPunkt, Punkt.Koordinaten);
  V3:= VectorSubtract(Strecke.EndPunkt, Punkt.Koordinaten);
  If IsZero( VectorLength(V2)+VectorLength(V3)-Strecke.Height, 0.000001 ) then
    Result:= Punkt;
end;

function Schneide(Strecke: TStrecke; Punkt: TPunkt): TGLBaseSceneObject; overload;
begin
  Result:= Schneide(Punkt, Strecke);
end;

function Schneide(Strecke1, Strecke2: TStrecke): TGLBaseSceneObject; overload;
var
  Obj: TGLBaseSceneObject;
  Strecke: TStrecke;
  V1, V2: TAffineVector;
  First, Second, Third: Boolean;
begin
  First:= False; Second:= False; Third:= False;
  Result:= NIL;

  Obj:= Schneide(TGerade(Strecke1), TGerade(Strecke2));
  If Assigned(Obj) then begin
    If Obj is TPunkt then begin
      Result:= Schneide( TPunkt(Obj) , Strecke1 );
      Result:= Schneide( TPunkt(Obj) , Strecke2 );
    end else begin
      V1:= VectorSubtract(Strecke1.Position.AsAffineVector, Strecke2.Position.AsAffineVector);
      If VectorLength(V1) < (Strecke1.Height + Strecke2.Height)/2 then
        First:= True;

      V1:= VectorSubtract(Strecke1.AnfangsPunkt, Strecke2.AnfangsPunkt);
      V2:= VectorSubtract(Strecke1.AnfangsPunkt, Strecke2.EndPunkt);
      If IsZero(VectorLength(V1)+VectorLength(V2)-Strecke2.Height, 0.000001) then
        Second:= True;

      V1:= VectorSubtract(Strecke1.EndPunkt, Strecke2.AnfangsPunkt);
      V2:= VectorSubtract(Strecke1.EndPunkt, Strecke2.EndPunkt);
      If IsZero(VectorLength(V1)+VectorLength(V2)-Strecke2.Height, 0.000001) then
        Third:= True;

      If First then
        If Second and Third then
          Result:= Strecke1
        else
        If not (Second or Third) then
          Result:= Strecke2
        else begin
          Strecke:= TStrecke.Create(Form1.DummyCube1);
          If Second and not Third then begin
            Strecke.Anfangspunkt:= Strecke1.AnfangsPunkt;
            Strecke.EndPunkt:= Strecke2.EndPunkt;
          end else begin
            Strecke.Anfangspunkt:= Strecke2.AnfangsPunkt;
            Strecke.EndPunkt:= Strecke1.EndPunkt;
          end;
          V1:= VectorScale(VectorAdd(Strecke.Anfangspunkt, Strecke.EndPunkt), 0.5);
          Strecke.Position.AsAffineVector:= AffineVectorMake(V1[1], V1[2], V1[0]);
          Strecke.Height:=VectorLength(VectorSubtract(Strecke.Anfangspunkt, Strecke.EndPunkt));

          Result:= Strecke;
        end;

    end;
  end;
end;

function Schneide(Gerade: TGerade; Strecke: TStrecke): TGLBaseSceneObject; overload;
var
  Obj: TGLBaseSceneObject;
begin
  Result:= NIL;

  Obj:= Schneide(Gerade, TGerade(Strecke));
  If Assigned(Obj) then begin
    If Obj is TPunkt then
      Result:= Schneide( TPunkt(Obj) , Strecke )
    else
      Result:= Strecke;  
  end;
end;

function Schneide(Strecke: TStrecke; Gerade: TGerade): TGLBaseSceneObject; overload;
begin
  Result:= Schneide(Gerade, Strecke);
end;

function Schneide(Ebene: TEbene; Strecke: TStrecke): TGLBaseSceneObject; overload;
var
  Obj: TGLBaseSceneObject;
begin
  Result:= NIL;

  Obj:= Schneide(Ebene, TGerade(Strecke));
  If Assigned(Obj) then begin
    If Obj is TPunkt then
      Result:= Schneide( TPunkt(Obj) , Strecke )
    else
      Result:= Schneide(TGerade(Obj), Strecke);
  end;
end;

function Schneide(Strecke: TStrecke; Ebene: TEbene): TGLBaseSceneObject; overload;
begin
  Result:= Schneide(Ebene, Strecke);
end;

function Schneide(Punkt: TPunkt; Kugel: TKugel): TGLBaseSceneObject; overload;
var
  V1: TAffineVector;
begin
  Result:= NIL;

  V1:= VectorSubtract(Kugel.Position.AsAffineVector, Punkt.Position.AsAffineVector);
  If VectorLength(V1) < Kugel.Radius then
    Result:= Punkt;
end;

function Schneide(Kugel: TKugel; Punkt: TPunkt): TGLBaseSceneObject; overload;
begin
  Result:= Schneide(Punkt, Kugel);
end;

function Schneide(Gerade: TGerade; Kugel: TKugel): TGLBaseSceneObject; overload;
var
  V1, V2, P: TAffineVector;
  l: single;
  Strecke: TStrecke;
  Punkt: TPunkt;
begin
  V1:= VectorSubtract(Kugel.Position.AsAffineVector, Gerade.Position.AsAffineVector);
  V2:= Gerade.Up.AsAffineVector;
  P:= Gerade.Position.AsAffineVector;
  l:= VectorDotProduct(V1, V2);
  CombineVector(P, V2, l);
  V1:= VectorSubtract(Kugel.Position.AsAffineVector, P);
  If VectorLength(V1) > Kugel.Radius then
    Result:= NIL
  else
    If VectorLength(V1) = Kugel.Radius then begin
      Punkt:= TPunkt.Create(Form1.DummyCube1);

      Punkt.Position.AsAffineVector:= P;
      Punkt.Koordinaten[0]:=P[2];
      Punkt.Koordinaten[1]:=P[0];
      Punkt.Koordinaten[2]:=P[1];

      Result:= Punkt;
    end else begin
      l:= sqrt(Kugel.Radius * Kugel.Radius - VectorDotProduct(V1, V1));
      Strecke:= TStrecke.Create(Form1.DummyCube1);
      Strecke.Position.AsAffineVector:=P;
      Strecke.Height:= 2*l;
      Strecke.Up:= Gerade.Up;

      V1:= VectorCombine(P, V2, 1, -l);
      Strecke.AnfangsPunkt[0]:= V1[2]; Strecke.AnfangsPunkt[1]:= V1[0];
      Strecke.AnfangsPunkt[2]:= V1[1];
      V1:= VectorCombine(P, V2, 1, l);
      Strecke.EndPunkt[0]:= V1[2]; Strecke.EndPunkt[1]:= V1[0];
      Strecke.EndPunkt[2]:= V1[1];

      Strecke.TagFloat:= -1;
      Result:= Strecke;
    end;
end;

function Schneide(Kugel: TKugel; Gerade: TGerade): TGLBaseSceneObject; overload;
begin
  Result:= Schneide(Gerade, Kugel);
end;

function Schneide(Strecke: TStrecke; Kugel: TKugel): TGLBaseSceneObject; overload;
var
  V1, V2: TAffineVector;
  Strecke1: TStrecke;
  Punkt: TPunkt;
begin
  Result:=Schneide(TGerade(Strecke), Kugel);
  If Result is TPunkt then begin
    Result:= Schneide(TPunkt(Result), Strecke);
  end else begin
    Strecke1:= TStrecke(Schneide(TStrecke(Result), Strecke));
    If VectorEquals(TStrecke(Result).AnfangsPunkt, Strecke1.AnfangsPunkt) and
       VectorEquals(TStrecke(Result).EndPunkt, Strecke1.EndPunkt) then begin
      Result:=Strecke1;
      Result.TagFloat:=-1;
    end else
    If VectorEquals(TStrecke(Result).AnfangsPunkt, Strecke1.AnfangsPunkt) then begin
      Punkt:= TPunkt.Create(Form1.DummyCube1);
      Punkt.Koordinaten:= Strecke1.AnfangsPunkt;
      Punkt.Position.AsAffineVector:=AffineVectorMake(Strecke1.AnfangsPunkt[1],
                                                      Strecke1.AnfangsPunkt[2],
                                                      Strecke1.AnfangsPunkt[0]);
      Result:= Punkt;
    end else
    If VectorEquals(TStrecke(Result).EndPunkt, Strecke1.EndPunkt) then begin
      Punkt:= TPunkt.Create(Form1.DummyCube1);
      Punkt.Koordinaten:= Strecke1.EndPunkt;
      Punkt.Position.AsAffineVector:=AffineVectorMake(Strecke1.EndPunkt[1],
                                                      Strecke1.EndPunkt[2],
                                                      Strecke1.EndPunkt[0]);
      Result:= Punkt;
    end;
  end;
end;

function Schneide(Kugel: TKugel; Strecke: TStrecke): TGLBaseSceneObject; overload;
begin
  Result:= Schneide(Strecke, Kugel);
end;

function Schneide(Punkt: TPunkt; Kreis: TKreis): TGLBaseSceneObject; overload;
var
  V1: TAffineVector;
begin
  Result:=Schneide(Punkt, TEbene(Kreis));
  If Assigned(Result) then begin
    V1:= VectorSubtract(Result.Position.AsAffineVector, Kreis.Position.AsAffineVector);
    If IsZero(VectorLength(V1)-Kreis.MajorRadius, 0.000001) then
      Result:= Punkt
    else
      Result:= NIL;
  end;
end;

function Schneide(Kreis: TKreis; Punkt: TPunkt): TGLBaseSceneObject; overload;
begin
  Result:= Schneide(Punkt, Kreis);
end;

function Schneide(Gerade: TGerade; Kreis: TKreis): TGLBaseSceneObject; overload;
var
  V1:  TAffineVector;
  Kugel: TKugel;
  R: single;
begin
  Kugel:= TKugel(Kreis);
  Result:=Schneide(Gerade, TEbene(Kreis));
  If Assigned(Result) then
    If (Result is TPunkt) then
      Result:= Schneide(TPunkt(Result), Kreis)
    else begin
      R:= Kreis.MinorRadius;
      Kugel.Radius:= Kreis.MajorRadius;
      Result:= Schneide(TGerade(Result), Kugel);
      Kreis.MinorRadius:= R;
    end;
end;

function Schneide(Kreis: TKreis; Gerade: TGerade): TGLBaseSceneObject; overload;
begin
  Result:= Schneide(Gerade, Kreis);
end;

function Schneide(Strecke: TStrecke; Kreis: TKreis): TGLBaseSceneObject; overload;
var
  Strecke1: TStrecke;
  Punkt: TPunkt;
begin
  Result:= Schneide(TGerade(Strecke), Kreis);
  If not Assigned(Result) then
    Exit;
  If Result is TPunkt then
    Result:= Schneide(TPunkt(Result), Kreis)
  else begin
    Strecke1:= TStrecke(Schneide(TStrecke(Result), Strecke));
    If VectorEquals(TStrecke(Result).AnfangsPunkt, Strecke1.AnfangsPunkt) and
       VectorEquals(TStrecke(Result).EndPunkt, Strecke1.EndPunkt) then begin
      Result:=Strecke1;
      Result.TagFloat:=-1;
    end else
    If VectorEquals(TStrecke(Result).AnfangsPunkt, Strecke1.AnfangsPunkt) then begin
      Punkt:= TPunkt.Create(Form1.DummyCube1);
      Punkt.Koordinaten:= Strecke1.AnfangsPunkt;
      Punkt.Position.AsAffineVector:=AffineVectorMake(Strecke1.AnfangsPunkt[1],
                                                      Strecke1.AnfangsPunkt[2],
                                                      Strecke1.AnfangsPunkt[0]);
      Result:= Punkt;
    end else
    If VectorEquals(TStrecke(Result).EndPunkt, Strecke1.EndPunkt) then begin
      Punkt:= TPunkt.Create(Form1.DummyCube1);
      Punkt.Koordinaten:= Strecke1.EndPunkt;
      Punkt.Position.AsAffineVector:=AffineVectorMake(Strecke1.EndPunkt[1],
                                                      Strecke1.EndPunkt[2],
                                                      Strecke1.EndPunkt[0]);
      Result:= Punkt;
    end;
  end;
end;

function Schneide(Kreis: TKreis; strecke: TStrecke): TGLBaseSceneObject; overload;
begin
  Result:= Schneide(Strecke, Kreis);
end;

function Schneide(Ebene: TEbene; Kreis: TKreis): TGLBaseSceneObject; overload;
begin
  Result:= Schneide(TEbene(Kreis), Ebene);
  If Assigned(Result) then
    Result:= Schneide(TGerade(Result), Kreis);
end;

function Schneide(Kreis: TKreis; Ebene: TEbene): TGLBaseSceneObject; overload;
begin
  Result:= Schneide(Ebene, Kreis);
end;

function Schneide(Ebene: TEbene; Kugel: TKugel): TGLBaseSceneObject; overload;
var
  Kreis: TKreis;
begin
  Kreis:= TKreis.Create(Form1.DummyCube1);
  Kreis.Position.AsAffineVector:= Kugel.Position.AsAffineVector;
  Kreis.MajorRadius:= Kugel.Radius;
  Kreis.Direction.AsAffineVector:=Ebene.Up.AsAffineVector;
  Result:= Schneide(Ebene, Kreis);

  If Result is TStrecke then begin
    Kreis.Position:= Result.Position;
    Kreis.Direction.AsAffineVector:= Ebene.Direction.AsAffineVector;
    Kreis.MajorRadius:= TStrecke(Result).Height/2;
    
    Result:= Kreis;
  end;
end;

function Schneide(Kugel: TKugel; Ebene: TEbene): TGLBaseSceneObject; overload;
begin
  Result:= Schneide(Ebene, Kugel);
end;

function Schneide(Kreis1, Kreis2: TKreis): TGLBaseSceneObject; overload;
var
  V1, V2, V3: TAffinevector;
  l: single;
  Strecke: TStrecke;
begin
  Result:= Schneide(TEbene(Kreis1), TEbene(Kreis2));
  If Assigned(Result) then
    If Result is TGerade then begin
      Result:= Schneide(TGerade(Result), Kreis1);
      If Result is TPunkt then
        Result:= Schneide(TPunkt(Result), Kreis2);
      If Result is TStrecke then
        Result:= Schneide(TStrecke(Result), Kreis2);
    end else begin
      V1:= Kreis1.Direction.AsAffineVector;
      V2:= VectorSubtract(Kreis2.Position.AsAffineVector, Kreis1.Position.AsAffineVector);
      l:= (VectorDotProduct(V2, V2)+Kreis1.MajorRadius*Kreis1.MajorRadius-Kreis2.MajorRadius*Kreis2.MajorRadius)
          /(2*VectorDotProduct(V2, V2));
      V3:= VectorCombine(Kreis1.Position.AsAffineVector, V2, 1, l);
      V1:= VectorCrossProduct(V1, V2);
      NormalizeVector(V1);
      l:= sqrt(Kreis1.MajorRadius*Kreis1.MajorRadius-VectorDotProduct(V2, V2)*l*l);
      ScaleVector(V1, l);
      Strecke:= TStrecke.Create(Form1.DummyCube1);

      V2:= VectorSubtract(V3, V1);
      Strecke.AnfangsPunkt[0]:= V2[2];
      Strecke.AnfangsPunkt[1]:= V2[0];
      Strecke.AnfangsPunkt[2]:= V2[1];

      V2:= VectorAdd(V3, V1);
      Strecke.EndPunkt[0]:= V2[2];
      Strecke.EndPunkt[1]:= V2[0];
      Strecke.EndPunkt[2]:= V2[1];

      Strecke.Position.AsAffineVector:= V3;
      Strecke.Height:= l*2;
      Result:= Strecke;
      Result.TagFloat:= -1;
    end;
end;

function Schneide(Kugel1, Kugel2: TKugel): TGLBaseSceneObject; overload;
var
  Kreis: TKreis;
  Punkt: TPunkt;
  V1, V2, V3: TAffinevector;
  l: single;
begin
  V2:= VectorSubtract(Kugel2.Position.AsAffineVector, Kugel1.Position.AsAffineVector);

  If (VectorLength(V2) = 0) and (Kugel1.Radius = Kugel2.Radius) then begin
    // Kugeln sind identisch
    Result:= Kugel1;
    Exit;
  end;

  If VectorLength(V2) > Kugel1.Radius + Kugel2.Radius then
    // Kugeln schneiden sich nicht
    Result:=NIL
  else begin
    If Kugel1.Radius + Kugel2.Radius = VectorLength(V2) then begin
      // Kugeln berühren sich in einem Punkt
      Result:= TPunkt.Create(Form1.DummyCube1);
      NormalizeVector(V2);
      ScaleVector(V2, Kugel1.Radius);
      V1:= VectorAdd(Kugel1.Position.AsAffineVector, V2);
      Result.Position.AsAffineVector:=V1;
    end else begin
      // Kugeln schneiden sich in einem Kreis
      l:= (VectorDotProduct(V2, V2)+Kugel1.Radius*Kugel1.Radius-Kugel2.Radius*Kugel2.Radius)
          /(2*VectorDotProduct(V2, V2));
      V3:= VectorCombine(Kugel1.Position.AsAffineVector, V2, 1, l);
      l:= sqrt(Kugel1.Radius*Kugel1.Radius-VectorDotProduct(V2, V2)*l*l);
      Kreis:= TKreis.Create(Form1.DummyCube1);

      Kreis.Position.AsAffineVector:= V3;
      Kreis.Direction.AsAffineVector:= V2;
      Kreis.MajorRadius:= l;
      Result:= Kreis;
    end;  
  end;
end;

function Schneide(Kreis: TKreis; Kugel: TKugel): TGLBaseSceneObject; overload;
var
  Kugel1: TKugel;
  l: single;
begin
  Kugel1:= TKugel(Kreis);
  l:= Kugel1.Radius;
  Kugel1.Radius:= Kreis.MajorRadius;
  Result:= Schneide(Kugel, Kugel1);
  If Result is TPunkt then
    Result:= Schneide(TPunkt(Result), Kreis);
  If Result is TKreis then
    Result:= Schneide(TKreis(Result), Kreis);
  Kugel1.Radius:= l;  
end;

function Schneide(Kugel: TKugel; Kreis: TKreis): TGLBaseSceneObject; overload;
begin
  Result:=Schneide(Kreis, Kugel);
end;

function ErmittleSchnittmenge(Objekte: TSchnittObjekte): TGLBaseSceneObject;
var NewObjekte: TSchnittObjekte;
    i: Integer;
begin
  NewObjekte := Objekte;
  for i := Length(Objekte)-1 downto 2 do begin
    if NewObjekte[i-1] is TPunkt then begin
      if NewObjekte[i] is TPunkt then NewObjekte[i-1] := Schneide(TPunkt(NewObjekte[i]), TPunkt(NewObjekte[i-1]));
      if NewObjekte[i] is TStrecke then NewObjekte[i-1] := Schneide(TStrecke(NewObjekte[i]), TPunkt(NewObjekte[i-1]));
      if NewObjekte[i] is TGerade then NewObjekte[i-1] := Schneide(TGerade(NewObjekte[i]), TPunkt(NewObjekte[i-1]));
      if NewObjekte[i] is TEbene then NewObjekte[i-1] := Schneide(TEbene(NewObjekte[i]), TPunkt(NewObjekte[i-1]));
      if NewObjekte[i] is TKreis then NewObjekte[i-1] := Schneide(TKreis(NewObjekte[i]), TPunkt(NewObjekte[i-1]));
      if NewObjekte[i] is TKugel then NewObjekte[i-1] := Schneide(TKugel(NewObjekte[i]), TPunkt(NewObjekte[i-1]));
    end else
    if NewObjekte[i-1] is TGerade then begin
      if NewObjekte[i] is TPunkt then NewObjekte[i-1] := Schneide(TPunkt(NewObjekte[i]), TGerade(NewObjekte[i-1]));
      if NewObjekte[i] is TStrecke then NewObjekte[i-1] := Schneide(TStrecke(NewObjekte[i]), TGerade(NewObjekte[i-1]));
      if NewObjekte[i] is TGerade then NewObjekte[i-1] := Schneide(TGerade(NewObjekte[i]), TGerade(NewObjekte[i-1]));
      if NewObjekte[i] is TEbene then NewObjekte[i-1] := Schneide(TEbene(NewObjekte[i]), TGerade(NewObjekte[i-1]));
      if NewObjekte[i] is TKreis then NewObjekte[i-1] := Schneide(TKreis(NewObjekte[i]), TGerade(NewObjekte[i-1]));
      if NewObjekte[i] is TKugel then NewObjekte[i-1] := Schneide(TKugel(NewObjekte[i]), TGerade(NewObjekte[i-1]));
    end else
    if NewObjekte[i-1] is TEbene then begin
      if NewObjekte[i] is TPunkt then NewObjekte[i-1] := Schneide(TPunkt(NewObjekte[i]), TEbene(NewObjekte[i-1]));
      if NewObjekte[i] is TStrecke then NewObjekte[i-1] := Schneide(TStrecke(NewObjekte[i]), TEbene(NewObjekte[i-1]));
      if NewObjekte[i] is TGerade then NewObjekte[i-1] := Schneide(TGerade(NewObjekte[i]), TEbene(NewObjekte[i-1]));
      if NewObjekte[i] is TEbene then NewObjekte[i-1] := Schneide(TEbene(NewObjekte[i]), TEbene(NewObjekte[i-1]));
      if NewObjekte[i] is TKreis then NewObjekte[i-1] := Schneide(TKreis(NewObjekte[i]), TEbene(NewObjekte[i-1]));
      if NewObjekte[i] is TKugel then NewObjekte[i-1] := Schneide(TKugel(NewObjekte[i]), TEbene(NewObjekte[i-1]));
    end else
    if NewObjekte[i-1] is TStrecke then begin
      if NewObjekte[i] is TPunkt then NewObjekte[i-1] := Schneide(TPunkt(NewObjekte[i]), TStrecke(NewObjekte[i-1]));
      if NewObjekte[i] is TStrecke then NewObjekte[i-1] := Schneide(TStrecke(NewObjekte[i]), TStrecke(NewObjekte[i-1]));
      if NewObjekte[i] is TGerade then NewObjekte[i-1] := Schneide(TGerade(NewObjekte[i]), TStrecke(NewObjekte[i-1]));
      if NewObjekte[i] is TEbene then NewObjekte[i-1] := Schneide(TEbene(NewObjekte[i]), TStrecke(NewObjekte[i-1]));
      if NewObjekte[i] is TKreis then NewObjekte[i-1] := Schneide(TKreis(NewObjekte[i]), TStrecke(NewObjekte[i-1]));
      if NewObjekte[i] is TKugel then NewObjekte[i-1] := Schneide(TKugel(NewObjekte[i]), TStrecke(NewObjekte[i-1]));
    end else
    if NewObjekte[i-1] is TKreis then begin
      if NewObjekte[i] is TPunkt then NewObjekte[i-1] := Schneide(TPunkt(NewObjekte[i]), TKreis(NewObjekte[i-1]));
      if NewObjekte[i] is TStrecke then NewObjekte[i-1] := Schneide(TStrecke(NewObjekte[i]), TKreis(NewObjekte[i-1]));
      if NewObjekte[i] is TGerade then NewObjekte[i-1] := Schneide(TGerade(NewObjekte[i]), TKreis(NewObjekte[i-1]));
      if NewObjekte[i] is TEbene then NewObjekte[i-1] := Schneide(TEbene(NewObjekte[i]), TKreis(NewObjekte[i-1]));
      if NewObjekte[i] is TKreis then NewObjekte[i-1] := Schneide(TKreis(NewObjekte[i]), TKreis(NewObjekte[i-1]));
      if NewObjekte[i] is TKugel then NewObjekte[i-1] := Schneide(TKugel(NewObjekte[i]), TKreis(NewObjekte[i-1]));
    end else
    if NewObjekte[i-1] is TKugel then begin
      if NewObjekte[i] is TPunkt then NewObjekte[i-1] := Schneide(TPunkt(NewObjekte[i]), TKugel(NewObjekte[i-1]));
      if NewObjekte[i] is TStrecke then NewObjekte[i-1] := Schneide(TStrecke(NewObjekte[i]), TKugel(NewObjekte[i-1]));
      if NewObjekte[i] is TGerade then NewObjekte[i-1] := Schneide(TGerade(NewObjekte[i]), TKugel(NewObjekte[i-1]));
      if NewObjekte[i] is TEbene then NewObjekte[i-1] := Schneide(TEbene(NewObjekte[i]), TKugel(NewObjekte[i-1]));
      if NewObjekte[i] is TKreis then NewObjekte[i-1] := Schneide(TKreis(NewObjekte[i]), TKugel(NewObjekte[i-1]));
      if NewObjekte[i] is TKugel then NewObjekte[i-1] := Schneide(TKugel(NewObjekte[i]), TKugel(NewObjekte[i-1]));
    end else NewObjekte[i-1] := NIL;
    SetLength(Objekte, i);
  end;
  Result := NewObjekte[1];
end;

end.
