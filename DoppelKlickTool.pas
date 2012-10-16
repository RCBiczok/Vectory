unit DoppelKlickTool;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Main, AppEvnts, MathParser, Verlauf, GLScene;

type
  TForm6 = class(TForm)
    PointOptions: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label1: TLabel;
    Label2: TLabel;
    PosX1P: TEdit;
    PosX2P: TEdit;
    PosX3P: TEdit;
    Label3: TLabel;
    ColorOptions: TPanel;
    Gamma1: TPaintBox;
    Label4: TLabel;
    Label5: TLabel;
    ColorPreview1: TPanel;
    FastColorPick1: TPanel;
    FastColorPick2: TPanel;
    FastColorPick3: TPanel;
    FastColorPick4: TPanel;
    FastColorPick5: TPanel;
    Panel1: TPanel;
    ActualColor: TPanel;
    SetBackButton: TButton;
    LineOptions: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    PosX1G: TEdit;
    PosX2G: TEdit;
    PosX3G: TEdit;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    DirX1G: TEdit;
    DirX2G: TEdit;
    DirX3G: TEdit;
    Label12: TLabel;
    ColorButton: TColorBox;
    PlaneOptions: TPanel;
    n1: TEdit;
    Label19: TLabel;
    n2: TEdit;
    Label20: TLabel;
    n3: TEdit;
    Label21: TLabel;
    n0: TEdit;
    Label22: TLabel;
    ApplicationEvents1: TApplicationEvents;
    StreckenOptions: TPanel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    P1X1S: TEdit;
    P1X2S: TEdit;
    P1X3S: TEdit;
    P2X1S: TEdit;
    P2X2S: TEdit;
    P2X3S: TEdit;
    SphereOptions: TPanel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    m1: TEdit;
    m2: TEdit;
    m3: TEdit;
    r: TEdit;
    PaintBox1: TPaintBox;
    PaintBox2: TPaintBox;
    CircleOptions: TPanel;
    Label6: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    km1: TEdit;
    km2: TEdit;
    km3: TEdit;
    kr: TEdit;
    Label30: TLabel;
    Label31: TLabel;
    kn1: TEdit;
    kn2: TEdit;
    kn3: TEdit;
    Label32: TLabel;
    procedure Gamma1Paint(Sender: TObject);
    procedure Gamma1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Gamma1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FastColorPick1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure SetBackButtonClick(Sender: TObject);
    procedure ColorButtonChange(Sender: TObject);
    procedure ApplicationEvents1Message(var Msg: tagMSG;
      var Handled: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
    procedure PaintBox2Paint(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form6: TForm6;
  PickedColor: TColor = clBlack;
  OldColor: TColor;
  Punkt: TPunkt;
  Gerade: TGerade;
  Ebene: TEbene;
  Kreis: TKreis;
  Kugel: TKugel;
  Strecke: TStrecke;
  OK: Boolean;

implementation

uses VectorGeometry, GLTreeView;

{$R *.dfm}

procedure TForm6.Gamma1Paint(Sender: TObject);
var
  i, j: integer;
begin
  for i:=0 to 127 do
    for j:=0 to 127 do begin
      TPaintBox(Sender).Canvas.Pixels[i,j]:=round(sqrt(((128-i)*(128-i)+(128-j)*(128-j))))*$10000+(i+128)*$100+(j+128)
    end;
end;

procedure TForm6.Gamma1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  If (ssLeft in Shift) or (ssRight in Shift) then begin
    ColorPreview1.Color:=TPaintBox(Sender).Canvas.Pixels[X,Y];
    PickedColor:=Gamma1.Canvas.Pixels[X,Y];
  end;
end;

procedure TForm6.Gamma1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  If (ssLeft in Shift) or (ssRight in Shift) then begin
    ColorPreview1.Color:=Gamma1.Canvas.Pixels[X,Y];
    PickedColor:=Gamma1.Canvas.Pixels[X,Y];
  end;
end;

procedure TForm6.FastColorPick1Click(Sender: TObject);
begin
  ColorPreview1.Color:=TPanel(Sender).Color;
  PickedColor:=TPanel(Sender).Color;
end;

procedure TForm6.Button2Click(Sender: TObject);
begin
  Hide;
end;

procedure TForm6.Button1Click(Sender: TObject);
begin
  try
    Button3Click(Sender);
    If OK then Hide;
  except
  end;
end;

procedure TForm6.Button3Click(Sender: TObject);
var
  n: TAffineVector;
  Alpha: single;
  P1, P2, P3, P4, P5, P6, P7: string;
  OldPunkt: TPunkt;
  OldGerade: TGerade;
  OldEbene: TEbene;
  OldStrecke: TStrecke;
  OldKreis: TKreis;
  OldKugel: TKugel;
begin
 try
  Caption:='>8o)';
  If PointOptions.Visible then begin
    OldPunkt:=TPunkt.Create(Form6);
    OldPunkt.ParamPosX1:=Punkt.ParamPosX1;
    OldPunkt.ParamPosX2:=Punkt.ParamPosX2;
    OldPunkt.ParamPosX3:=Punkt.ParamPosX3;
    OldPunkt.Material:=Punkt.Material;
    If Punkt.Material.FrontProperties.Diffuse.AsWinColor<>PickedColor then begin
      Punkt.Material.FrontProperties.Diffuse.AsWinColor:=PickedColor;
      Punkt.Bezeichnung.Material.FrontProperties.Diffuse.AsWinColor:=PickedColor;
    end;
    P1:=PosX1P.Text; P2:=PosX2P.Text; P3:=PosX3P.Text;
    Form1.SetKugel(TKugel(Punkt), AffineVectorMake(ProcessLine(P2, VarsArchive),
                                                   ProcessLine(P3, VarsArchive),
                                                   ProcessLine(P1, VarsArchive)), 0.05);
    Punkt.ParamPosX1:=P1;
    Punkt.ParamPosX2:=P2;
    Punkt.ParamPosX3:=P3;

    ChangeChildren(Punkt);

    Form1.RegisterActions(Punkt, OldPunkt, 'ChangeObject');
    OldPunkt.Free;

    ZeigeDaten(Punkt, Form1.Memo1);
  end;
  If StreckenOptions.Visible then begin
    OldStrecke:=TStrecke.Create(Form6);
    OldStrecke.ParamP1X1:=Strecke.ParamP1X1;
    OldStrecke.ParamP1X2:=Strecke.ParamP1X2;
    OldStrecke.ParamP1X3:=Strecke.ParamP1X3;
    OldStrecke.ParamP2X1:=Strecke.ParamP2X1;
    OldStrecke.ParamP2X2:=Strecke.ParamP2X2;
    OldStrecke.ParamP2X3:=Strecke.ParamP2X3;
    OldStrecke.Material:=Strecke.Material;
    If Strecke.Material.FrontProperties.Diffuse.AsWinColor<>PickedColor then begin
      Strecke.Material.FrontProperties.Diffuse.AsWinColor:=PickedColor;
    end;
    P1:=P1X1S.Text; P2:=P1X2S.Text; P3:=P1X3S.Text;
    P4:=P2X1S.Text; P5:=P2X2S.Text; P6:=P2X3S.Text;
    Form1.SetStrecke(Strecke, AffineVectorMake(ProcessLine(P2, VarsArchive),
                                               ProcessLine(P3, VarsArchive),
                                               ProcessLine(P1, VarsArchive)),
                              AffineVectorMake(ProcessLine(P5, VarsArchive),
                                               ProcessLine(P6, VarsArchive),
                                               ProcessLine(P4, VarsArchive)));
    Strecke.ParamP1X1:=P1;
    Strecke.ParamP1X2:=P2;
    Strecke.ParamP1X3:=P3;
    Strecke.ParamP2X1:=P4;
    Strecke.ParamP2X2:=P5;
    Strecke.ParamP2X3:=P6;
    Strecke.Material.FrontProperties.Emission.Color:=VectorMake(0,0,0,1);

    ChangeChildren(Strecke);

    Form1.RegisterActions(Strecke, OldStrecke, 'ChangeObject');
    OldStrecke.Free;

    ZeigeDaten(Strecke, Form1.Memo1);
  end;
  If LineOptions.Visible then begin
    OldGerade:=TGerade.Create(Form6);
    OldGerade.ParamPosX1:=Gerade.ParamPosX1;
    OldGerade.ParamPosX2:=Gerade.ParamPosX2;
    OldGerade.ParamPosX3:=Gerade.ParamPosX3;
    OldGerade.ParamDirX1:=Gerade.ParamDirX1;
    OldGerade.ParamDirX2:=Gerade.ParamDirX2;
    OldGerade.ParamDirX3:=Gerade.ParamDirX3;
    OldGerade.Material:=Gerade.Material;

    If Gerade.Material.FrontProperties.Diffuse.AsWinColor<>PickedColor then begin
      Gerade.Material.FrontProperties.Diffuse.AsWinColor:=PickedColor;
    end;

    P1:=PosX1G.Text; P2:=PosX2G.Text; P3:=PosX3G.Text;
    P4:=DirX1G.Text; P5:=DirX2G.Text; P6:=DirX3G.Text;
    Form1.SetGerade(Gerade, AffineVectorMake(ProcessLine(P2, VarsArchive),
                                               ProcessLine(P3, VarsArchive),
                                               ProcessLine(P1, VarsArchive)),
                              AffineVectorMake(ProcessLine(P5, VarsArchive),
                                               ProcessLine(P6, VarsArchive),
                                               ProcessLine(P4, VarsArchive)));
    Gerade.ParamPosX1:=P1;
    Gerade.ParamPosX2:=P2;
    Gerade.ParamPosX3:=P3;
    Gerade.ParamDirX1:=P4;
    Gerade.ParamDirX2:=P5;
    Gerade.ParamDirX3:=P6;
    Gerade.Material.FrontProperties.Emission.Color:=VectorMake(0,0,0,1);

    ChangeChildren(Gerade);

    Form1.RegisterActions(Gerade, OldGerade, 'ChangeObject');
    OldGerade.Free;

    ZeigeDaten(Gerade, Form1.Memo1);
  end;

  If PlaneOptions.Visible then begin

    OldEbene:=TEbene.Create(Form6);
    OldEbene.ParamPosX1:=Ebene.ParamPosX1;
    OldEbene.ParamPosX2:=Ebene.ParamPosX2;
    OldEbene.ParamPosX3:=Ebene.ParamPosX3;
    OldEbene.ParamDirX1:=Ebene.ParamDirX1;
    OldEbene.ParamDirX2:=Ebene.ParamDirX2;
    OldEbene.ParamDirX3:=Ebene.ParamDirX3;
    OldEbene.Param_N0:=Ebene.Param_N0;
    OldEbene.Material:=Ebene.Material;

    If Ebene.Material.FrontProperties.Diffuse.AsWinColor<>PickedColor then begin
      Alpha:=Ebene.Material.FrontProperties.Diffuse.Alpha;
      Ebene.Material.FrontProperties.Diffuse.AsWinColor:=PickedColor;
      Ebene.Material.BackProperties.Diffuse.AsWinColor:=PickedColor;
      Ebene.Material.FrontProperties.Diffuse.Alpha:=Alpha;
      Ebene.Material.BackProperties.Diffuse.Alpha:=Alpha;
    end;

    P1:= n1.Text; P2:= n2.Text; P3:= n3.Text; P4:= n0.Text;
    SetAffineVector(n, ProcessLine(P2, VarsArchive),
                       ProcessLine(P3, VarsArchive),
                       ProcessLine(P1, VarsArchive));
    Form1.SetEbene(Ebene, VectorScale(n, -ProcessLine(P4, VarsArchive)/(VectorDotProduct(n,n))), n);
    Form1.OptimiereEbene(Ebene);

    Ebene.ParamDirX1:=P1;
    Ebene.ParamDirX2:=P2;
    Ebene.ParamDirX3:=P3;
    Ebene.ParamPosX1:=ProcessTriadLine('-('+P1+')*('+P4+')/(('+P1+')^2+('+P2+')^2+('+P3+')^2'+')');
    Ebene.ParamPosX2:=ProcessTriadLine('-('+P2+')*('+P4+')/(('+P1+')^2+('+P2+')^2+('+P3+')^2'+')');
    Ebene.ParamPosX3:=ProcessTriadLine('-('+P3+')*('+P4+')/(('+P1+')^2+('+P2+')^2+('+P3+')^2'+')');
    Ebene.Param_N0:= P4;

    Ebene.Material.FrontProperties.Emission.Color:=VectorMake(0,0,0,1);

    ChangeChildren(Ebene);

    Form1.RegisterActions(Ebene, OldEbene, 'ChangeObject');
    OldEbene.Free;

    ZeigeDaten(Ebene, Form1.Memo1);
  end;

  If CircleOptions.Visible then begin

    OldKreis:=TKreis.Create(Form6);
    OldKreis.ParamPosX1:=Kreis.ParamPosX1;
    OldKreis.ParamPosX2:=Kreis.ParamPosX2;
    OldKreis.ParamPosX3:=Kreis.ParamPosX3;
    OldKreis.ParamDirX1:=Kreis.ParamDirX1;
    OldKreis.ParamDirX2:=Kreis.ParamDirX2;
    OldKreis.ParamDirX3:=Kreis.ParamDirX3;
    OldKreis.ParamRadius:=Kreis.ParamRadius;
    OldKreis.Material:=Kreis.Material;

    If Kreis.Material.FrontProperties.Diffuse.AsWinColor<>PickedColor then begin
      Alpha:=Kreis.Material.FrontProperties.Diffuse.Alpha;
      Kreis.Material.FrontProperties.Diffuse.AsWinColor:=PickedColor;
      Kreis.Material.FrontProperties.Diffuse.Alpha:= Alpha;
    end;
    P1:=kM1.Text; P2:=kM2.Text; P3:=kM3.Text;
    P4:=kn1.Text; P5:=kn2.Text; P6:=kn3.Text;
    P7:=kr.Text;

    If ProcessLine(P7, VarsArchive) < 0 then begin
      ShowMessage('Der Radius darf nicht negativ sein!');
      kr.Undo;
      Exit;
    end;

    Form1.SetKreis(Kreis, AffineVectorMake(ProcessLine(P2, VarsArchive),
                                           ProcessLine(P3, VarsArchive),
                                           ProcessLine(P1, VarsArchive)),
                          AffineVectorMake(ProcessLine(P5, VarsArchive),
                                           ProcessLine(P6, VarsArchive),
                                           ProcessLine(P4, VarsArchive)),
                                           ProcessLine(P7, VarsArchive));
    Kreis.ParamPosX1:=P1;
    Kreis.ParamPosX2:=P2;
    Kreis.ParamPosX3:=P3;
    Kreis.ParamDirX1:=P4;
    Kreis.ParamDirX2:=P5;
    Kreis.ParamDirX3:=P6;
    Kreis.ParamRadius:=P7;

    ChangeChildren(Kreis);

    Form1.RegisterActions(Kreis, OldKreis, 'ChangeObject');
    OldKreis.Free;

    ZeigeDaten(Kreis, Form1.Memo1);
  end;

  If SphereOptions.Visible then begin

    OldKugel:=TKugel.Create(Form6);
    OldKugel.ParamPosX1:=Kugel.ParamPosX1;
    OldKugel.ParamPosX2:=Kugel.ParamPosX2;
    OldKugel.ParamPosX3:=Kugel.ParamPosX3;
    OldKugel.ParamRadius:=Kugel.ParamRadius;
    OldKugel.Material:=Kugel.Material;

    If Kugel.Material.FrontProperties.Diffuse.AsWinColor<>PickedColor then begin
      Alpha:=Kugel.Material.FrontProperties.Diffuse.Alpha;
      Kugel.Material.FrontProperties.Diffuse.AsWinColor:=PickedColor;
      Kugel.Material.FrontProperties.Diffuse.Alpha:= Alpha;
    end;
    P1:=M1.Text; P2:=M2.Text; P3:=M3.Text; P4:=r.Text;

    If ProcessLine(P4, VarsArchive) < 0 then begin
      ShowMessage('Der Radius darf nicht negativ sein!');
      r.Undo;
      Exit;
    end;

    Form1.SetKugel(Kugel, AffineVectorMake(ProcessLine(P2, VarsArchive),
                                           ProcessLine(P3, VarsArchive),
                                           ProcessLine(P1, VarsArchive)),
                                           ProcessLine(P4, VarsArchive));
    Kugel.ParamPosX1:=P1;
    Kugel.ParamPosX2:=P2;
    Kugel.ParamPosX3:=P3;
    Kugel.ParamRadius:=P4;

    ChangeChildren(Kugel);

    Form1.RegisterActions(Kugel, OldKugel, 'ChangeObject');
    OldKugel.Free;

    ZeigeDaten(Kugel, Form1.Memo1);
  end;
  OK:=True;
 except
   MessageDlg('Fehlerhafte Eingabe! Überprüfen Sie, ob alle Zahlen korrekt eingegeben wurden.', mtError, [mbOk], 0);
   OK:=False;
 end;
end;

procedure TForm6.FormActivate(Sender: TObject);
begin
  If Form1.TreeView1.Selected.Parent.Text='Punkte' then begin
    Caption:='Punkt-Eigenschaften';
    PointOptions.Visible:=True;
    LineOptions.Visible:=False;
    PlaneOptions.Visible:=False;
    StreckenOptions.Visible:=False;
    CircleOptions.Visible:= False;
    SphereOptions.Visible:=False;

    Punkt:=TPunkt(TGLNode(Form1.TreeView1.Selected).LinkedObject);
    PosX1P.Text:=Punkt.ParamPosX1;
    PosX2P.Text:=Punkt.ParamPosX2;
    PosX3P.Text:=Punkt.ParamPosX3;
    OldColor:=Punkt.Material.FrontProperties.Diffuse.AsWinColor;
    PickedColor:=OldColor;
  end;
  If Form1.TreeView1.Selected.Parent.Text='Strecken' then begin
    Caption:='Strecke-Eigenschaften';
    PointOptions.Visible:=False;
    LineOptions.Visible:=False;
    PlaneOptions.Visible:=False;
    StreckenOptions.Visible:=True;
    CircleOptions.Visible:= False;
    SphereOptions.Visible:=False;

    Strecke:=TStrecke(TGLNode(Form1.TreeView1.Selected).LinkedObject);
    P1X1S.Text:=Strecke.ParamP1X1;
    P1X2S.Text:=Strecke.ParamP1X2;
    P1X3S.Text:=Strecke.ParamP1X3;
    P2X1S.Text:=Strecke.ParamP2X1;
    P2X2S.Text:=Strecke.ParamP2X2;
    P2X3S.Text:=Strecke.ParamP2X3;
    OldColor:=Strecke.Material.FrontProperties.Diffuse.AsWinColor;
    PickedColor:=OldColor;
  end;
  If Form1.TreeView1.Selected.Parent.Text='Geraden' then begin
    Caption:='Gerade-Eigenschaften';
    PointOptions.Visible:=False;
    LineOptions.Visible:=True;
    PlaneOptions.Visible:=False;
    StreckenOptions.Visible:=False;
    CircleOptions.Visible:= False;
    SphereOptions.Visible:=False;

    Gerade:=TGerade(TGLNode(Form1.TreeView1.Selected).LinkedObject);
    PosX1G.Text:=Gerade.ParamPosX1;
    PosX2G.Text:=Gerade.ParamPosX2;
    PosX3G.Text:=Gerade.ParamPosX3;
    DirX1G.Text:=Gerade.ParamDirX1;
    DirX2G.Text:=Gerade.ParamDirX2;
    DirX3G.Text:=Gerade.ParamDirX3;
    OldColor:=Gerade.Material.FrontProperties.Diffuse.AsWinColor;
    PickedColor:=OldColor;
  end;
  If Form1.TreeView1.Selected.Parent.Text='Ebenen' then begin
    Caption:='Ebene-Eigenschaften';
    PointOptions.Visible:=False;
    LineOptions.Visible:=False;
    PlaneOptions.Visible:=True;
    StreckenOptions.Visible:=False;
    CircleOptions.Visible:= False;
    SphereOptions.Visible:=False;

    Ebene:=TEbene(TGLNode(Form1.TreeView1.Selected).LinkedObject);
    n1.Text:=ProcessTriadLine(Ebene.ParamDirX1);
    n2.Text:=ProcessTriadLine(Ebene.ParamDirX2);
    n3.Text:=ProcessTriadLine(Ebene.ParamDirX3);
    n0.Text:=ProcessTriadLine(Ebene.Param_N0);
    OldColor:=Ebene.Material.FrontProperties.Diffuse.AsWinColor;
    PickedColor:=OldColor;
  end;
  If Form1.TreeView1.Selected.Parent.Text='Kreise' then begin
    Caption:='Kreis-Eigenschaften';
    PointOptions.Visible:=False;
    LineOptions.Visible:=False;
    PlaneOptions.Visible:=False;
    StreckenOptions.Visible:=False;
    CircleOptions.Visible:= True;
    SphereOptions.Visible:=False;

    Kreis:=TKreis(TGLNode(Form1.TreeView1.Selected).LinkedObject);
    km1.Text:=ProcessTriadLine(Kreis.ParamPosX1);
    km2.Text:=ProcessTriadLine(Kreis.ParamPosX2);
    km3.Text:=ProcessTriadLine(Kreis.ParamPosX3);
    kn1.Text:=ProcessTriadLine(Kreis.ParamDirX1);
    kn2.Text:=ProcessTriadLine(Kreis.ParamDirX2);
    kn3.Text:=ProcessTriadLine(Kreis.ParamDirX3);
    kr.Text:=ProcessTriadLine(Kreis.ParamRadius);
    OldColor:=Kreis.Material.FrontProperties.Diffuse.AsWinColor;
    PickedColor:=OldColor;
  end;
  If Form1.TreeView1.Selected.Parent.Text='Kugeln' then begin
    Caption:='Kugel-Eigenschaften';
    PointOptions.Visible:=False;
    LineOptions.Visible:=False;
    PlaneOptions.Visible:=False;
    StreckenOptions.Visible:=False;
    CircleOptions.Visible:= False;
    SphereOptions.Visible:=True;

    Kugel:=TKugel(TGLNode(Form1.TreeView1.Selected).LinkedObject);
    m1.Text:=ProcessTriadLine(Kugel.ParamPosX1);
    m2.Text:=ProcessTriadLine(Kugel.ParamPosX2);
    m3.Text:=ProcessTriadLine(Kugel.ParamPosX3);
    r.Text:=ProcessTriadLine(Kugel.ParamRadius);
    OldColor:=Kugel.Material.FrontProperties.Diffuse.AsWinColor;
    PickedColor:=OldColor;
  end;
  ActualColor.Color:=PickedColor;
  ColorButton.Selected:=PickedColor;
  ColorPreview1.Color:=clBlack;

  ApplicationEvents1.OnMessage:= ApplicationEvents1Message;
end;

procedure TForm6.SetBackButtonClick(Sender: TObject);
begin
  PickedColor:=OldColor;
  ColorPreview1.Color:=PickedColor;
end;

procedure TForm6.ColorButtonChange(Sender: TObject);
begin
  PickedColor:=ColorButton.Selected;
  ColorPreview1.Color:=PickedColor;
end;

procedure TForm6.ApplicationEvents1Message(var Msg: tagMSG;
  var Handled: Boolean);
var
  Control: TWinControl;
  TabOrder: integer;
  i, count: integer;
  OK: Boolean;
begin
 if (Msg.Message = WM_KEYDOWN) then
   case Msg.wParam of
     VK_ESCAPE: begin
       Handled:=True;
       Close;
     end;
     VK_DOWN: begin
       Control:= ActiveControl;
       If not Assigned(Control) then Exit;
       Count:= 0;
       for i:=0 to Control.Parent.ControlCount - 1 do
         If TwinControl(Control.Parent.Controls[i]).TabOrder > -1 then
           inc(Count);

       TabOrder:= Control.TabOrder;
       i:=0; OK:= False;
       while (i < Control.Parent.ControlCount) and not OK do begin
         if TWinControl(Control.Parent.Controls[i]).TabOrder = (TabOrder + 1) mod Count then begin
           Self.FocusControl(TWinControl(Control.Parent.Controls[i]));
           OK:= True;
         end;
         inc(i);
       end;
     end;
     VK_UP: begin
       Control:= ActiveControl;
       If not Assigned(Control) then Exit;
       Count:= 0;
       for i:=0 to Control.Parent.ControlCount - 1 do
         If TwinControl(Control.Parent.Controls[i]).TabOrder > -1 then
           inc(Count);

       TabOrder:= Control.TabOrder;
       i:=0; OK:= False;
       while (i < Control.Parent.ControlCount) and not OK do begin
         if TWinControl(Control.Parent.Controls[i]).TabOrder = (Count + TabOrder - 1) mod Count then begin
           Self.FocusControl(TWinControl(Control.Parent.Controls[i]));
           OK:= True;
         end;
         inc(i);
       end;
     end;
   end;
end;

procedure TForm6.FormCreate(Sender: TObject);
var
  i: integer;
begin
// SetBackButton should be MultiLine
  SetWindowLong(SetBackButton.Handle, GWL_STYLE, GetWindowLong(SetBackButton.Handle, GWL_STYLE) or BS_MULTILINE);

// German color names
  for i:=1 to High(GermanColors) do
    ColorButton.Items[i]:=GermanColors[i];
  ColorButton.Items[0]:='benutzerdefiniert...'  
end;

procedure TForm6.PaintBox1Paint(Sender: TObject);
begin
  VerlaufHorizontal(TPaintBox(Sender).Canvas, clGreen, clMoneygreen, TPaintBox(Sender).Width, TPaintBox(Sender).Height);
end;

procedure TForm6.PaintBox2Paint(Sender: TObject);
begin
  VerlaufVertical(TPaintBox(Sender).Canvas, clGreen, clMoneygreen, TPaintBox(Sender).Width, TPaintBox(Sender).Height);
end;

procedure TForm6.FormDeactivate(Sender: TObject);
begin
  ApplicationEvents1.OnMessage:= nil;
end;

end.
