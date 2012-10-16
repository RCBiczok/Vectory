unit Verlauf;

interface

uses
  Graphics, Windows;

procedure VerlaufVertical(Canvas: TCanvas; Color1, Color2: TColor; Width, Height: integer);
procedure VerlaufHorizontal(Canvas: TCanvas; Color1, Color2: TColor; Width, Height: integer);
procedure MidVerlaufHorizontal(Canvas: TCanvas; Color1, Color2: TColor; Width, Height: integer);
procedure MidVerlaufVertical(Canvas: TCanvas; Color1, Color2: TColor; Width, Height: integer);
procedure VerlaufDiagonalUp(Canvas: TCanvas; Color1, Color2: TColor; Width, Height: integer);
procedure VerlaufDiagonalDown(Canvas: TCanvas; Color1, Color2: TColor; Width, Height: integer);

implementation

procedure VerlaufVertical(Canvas: TCanvas; Color1, Color2: TColor; Width, Height: integer);
var
  y: integer;
  Red, Green, Blue: integer;
  RedEnd, GreenEnd, BlueEnd: integer;
  Rate: single;
  MapColor: TColor;
  BMP: Graphics.TBitmap;
begin
  BMP:= Graphics.TBitmap.Create;
  BMP.Width:= Width; BMP.Height:= Height;

  MapColor:= Canvas.Pen.Color;
  Blue:= LoByte(HiWord(Color1));
  Green:= HiByte(LoWord(Color1));
  Red:= LoByte(LoWord(Color1));

  BlueEnd:= LoByte(HiWord(Color2));
  GreenEnd:= HiByte(LoWord(Color2));
  RedEnd:= LoByte(LoWord(Color2));

  for y:=0 to Height-1 do begin
    Rate:= y/Height;
    BMP.Canvas.Pen.Color:= round(Blue*(1-Rate)+BlueEnd*Rate) shl 16 + {blue}
                       round(Green*(1-Rate)+GreenEnd*Rate) shl 8 + {green}
                       round(Red*(1-Rate)+RedEnd*Rate); {red}
    BMP.Canvas.MoveTo(0, Y);
    BMP.Canvas.LineTo(Width, Y);
  end;
  Canvas.Pen.Color:= MapColor;
  Canvas.Draw(0,0, BMP);
  BMP.Destroy;
end;

procedure VerlaufHorizontal(Canvas: TCanvas; Color1, Color2: TColor; Width, Height: integer);
var
  x: integer;
  Red, Green, Blue: integer;
  RedEnd, GreenEnd, BlueEnd: integer;
  Rate: single;
  MapColor: TColor;
  BMP: Graphics.TBitmap;
begin
  BMP:= Graphics.TBitmap.Create;
  BMP.Width:= Width; BMP.Height:= Height;

  MapColor:= Canvas.Pen.Color;
  Blue:= LoByte(HiWord(Color1));
  Green:= HiByte(LoWord(Color1));
  Red:= LoByte(LoWord(Color1));

  BlueEnd:= LoByte(HiWord(Color2));
  GreenEnd:= HiByte(LoWord(Color2));
  RedEnd:= LoByte(LoWord(Color2));

  for x:= 0 to Width-1 do begin
    Rate:= x/Width;
    BMP.Canvas.Pen.Color:= round(Blue*(1-Rate)+BlueEnd*Rate) shl 16 + {blue}
                       round(Green*(1-Rate)+GreenEnd*Rate) shl 8 + {green}
                       round(Red*(1-Rate)+RedEnd*Rate); {red}
    BMP.Canvas.MoveTo(X, 0);
    BMP.Canvas.LineTo(X, Height);
  end;
  Canvas.Pen.Color:= MapColor;
  Canvas.Draw(0,0, BMP);
  BMP.Destroy;
end;

procedure MidVerlaufHorizontal(Canvas: TCanvas; Color1, Color2: TColor; Width, Height: integer);
var
  x: integer;
  Red, Green, Blue: integer;
  RedEnd, GreenEnd, BlueEnd: integer;
  Rate: single;
  MapColor: TColor;
  BMP: Graphics.TBitmap;
begin
  BMP:= Graphics.TBitmap.Create;
  BMP.Width:= Width; BMP.Height:= Height;

  MapColor:= Canvas.Pen.Color;
  Blue:= LoByte(HiWord(Color1));
  Green:= HiByte(LoWord(Color1));
  Red:= LoByte(LoWord(Color1));

  BlueEnd:= LoByte(HiWord(Color2));
  GreenEnd:= HiByte(LoWord(Color2));
  RedEnd:= LoByte(LoWord(Color2));

  for x:= 0 to (Width div 2)-1 do begin
    Rate:= 1-2*x/Width;
    BMP.Canvas.Pen.Color:= round(Blue*(1-Rate)+BlueEnd*Rate) shl 16 + {blue}
                       round(Green*(1-Rate)+GreenEnd*Rate) shl 8 + {green}
                       round(Red*(1-Rate)+RedEnd*Rate); {red}
    BMP.Canvas.MoveTo(X, 0);
    BMP.Canvas.LineTo(X, Height);
  end;
  for x:=Width downto (Width div 2) do begin
    Rate:= 2*x/Width-1;
    BMP.Canvas.Pen.Color:= round(Blue*(1-Rate)+BlueEnd*Rate) shl 16 + {blue}
                       round(Green*(1-Rate)+GreenEnd*Rate) shl 8 + {green}
                       round(Red*(1-Rate)+RedEnd*Rate); {red}
    BMP.Canvas.MoveTo(X, 0);
    BMP.Canvas.LineTo(X, Height);
  end;
  Canvas.Pen.Color:= MapColor;
  Canvas.Draw(0,0, BMP);
  BMP.Destroy;
end;

procedure MidVerlaufVertical(Canvas: TCanvas; Color1, Color2: TColor; Width, Height: integer);
var
  y: integer;
  Red, Green, Blue: integer;
  RedEnd, GreenEnd, BlueEnd: integer;
  Rate: single;
  MapColor: TColor;
  BMP: Graphics.TBitmap;
begin
  BMP:= Graphics.TBitmap.Create;
  BMP.Width:= Width; BMP.Height:= Height;

  MapColor:= Canvas.Pen.Color;
  Blue:= LoByte(HiWord(Color1));
  Green:= HiByte(LoWord(Color1));
  Red:= LoByte(LoWord(Color1));

  BlueEnd:= LoByte(HiWord(Color2));
  GreenEnd:= HiByte(LoWord(Color2));
  RedEnd:= LoByte(LoWord(Color2));

  for y:= 0 to (Height div 2)-1 do begin
    Rate:= 1-2*y/Height;
    BMP.Canvas.Pen.Color:= round(Blue*(1-Rate)+BlueEnd*Rate) shl 16 + {blue}
                       round(Green*(1-Rate)+GreenEnd*Rate) shl 8 + {green}
                       round(Red*(1-Rate)+RedEnd*Rate); {red}
    BMP.Canvas.MoveTo(0, Y);
    BMP.Canvas.LineTo(Width, Y);
  end;
  for y:= Height downto (Height div 2) do begin
    Rate:= 2*y/Height-1;
    BMP.Canvas.Pen.Color:= round(Blue*(1-Rate)+BlueEnd*Rate) shl 16 + {blue}
                       round(Green*(1-Rate)+GreenEnd*Rate) shl 8 + {green}
                       round(Red*(1-Rate)+RedEnd*Rate); {red}
    BMP.Canvas.MoveTo(0, Y);
    BMP.Canvas.LineTo(Width, Y);
  end;
  Canvas.Pen.Color:= MapColor;
  Canvas.Draw(0,0, BMP);
  BMP.Destroy;
end;

procedure VerlaufDiagonalUp(Canvas: TCanvas; Color1, Color2: TColor; Width, Height: integer);
var
  x, y: integer;
  Red, Green, Blue: integer;
  RedEnd, GreenEnd, BlueEnd: integer;
  RateX, RateY, Rate: single;
  MapColor: TColor;
  BMP: Graphics.TBitmap;
begin
  BMP:= Graphics.TBitmap.Create;
  BMP.Width:= Width; BMP.Height:= Height;

  MapColor:= Canvas.Pen.Color;
  Blue:= LoByte(HiWord(Color1));
  Green:= HiByte(LoWord(Color1));
  Red:= LoByte(LoWord(Color1));

  BlueEnd:= LoByte(HiWord(Color2));
  GreenEnd:= HiByte(LoWord(Color2));
  RedEnd:= LoByte(LoWord(Color2));

  for x:= 0 to Width-1 do begin
    for y:= 0 to Height-1 do begin
      RateX:= x/Width; RateY:= y/Height; Rate:= RateX+RateY;
      If Rate > 1 then Rate:=1;
      BMP.Canvas.Pixels[x,y]:= round(Blue*(1-Rate)+BlueEnd*Rate) shl 16 + {blue}
                           round(Green*(1-Rate)+GreenEnd*Rate) shl 8 + {green}
                           round(Red*(1-Rate)+RedEnd*Rate); {red}
    end;
  end;
  Canvas.Pen.Color:= MapColor;
  Canvas.Draw(0,0, BMP);
  BMP.Destroy;
end;

procedure VerlaufDiagonalDown(Canvas: TCanvas; Color1, Color2: TColor; Width, Height: integer);
var
  x, y: integer;
  Red, Green, Blue: integer;
  RedEnd, GreenEnd, BlueEnd: integer;
  RateX, RateY, Rate: single;
  MapColor: TColor;
  BMP: Graphics.TBitmap;
begin
  BMP:= Graphics.TBitmap.Create;
  BMP.Width:= Width; BMP.Height:= Height;

  MapColor:= Canvas.Pen.Color;
  Blue:= LoByte(HiWord(Color1));
  Green:= HiByte(LoWord(Color1));
  Red:= LoByte(LoWord(Color1));

  BlueEnd:= LoByte(HiWord(Color2));
  GreenEnd:= HiByte(LoWord(Color2));
  RedEnd:= LoByte(LoWord(Color2));

  for x:= 0 to Width-1 do begin
    for y:= 0 to Height-1 do begin
      RateX:= 1-x/Width; RateY:= 1-y/Height; Rate:= RateX+RateY;
      If Rate > 1 then Rate:=1;
      BMP.Canvas.Pixels[x,y]:= round(Blue*(1-Rate)+BlueEnd*Rate) shl 16 + {blue}
                           round(Green*(1-Rate)+GreenEnd*Rate) shl 8 + {green}
                           round(Red*(1-Rate)+RedEnd*Rate); {red}
    end;
  end;
  Canvas.Pen.Color:= MapColor;
  Canvas.Draw(0,0, BMP);
  BMP.Destroy;
end;

end.
