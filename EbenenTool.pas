unit EbenenTool;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, AppEvnts, Primitives, Verlauf;

type
  TForm2 = class(TForm)
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    Button1: TButton;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Panel2: TPanel;
    Label10: TLabel;
    Label9: TLabel;
    Label8: TLabel;
    Label5: TLabel;
    Edit5: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Panel3: TPanel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Edit14: TEdit;
    Edit15: TEdit;
    Edit16: TEdit;
    Edit17: TEdit;
    Edit18: TEdit;
    Edit19: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit13: TEdit;
    Button2: TButton;
    ApplicationEvents1: TApplicationEvents;
    ObjectName: TEdit;
    Label19: TLabel;
    ColorBox1: TColorBox;
    Farbe: TLabel;
    PaintBox1: TPaintBox;
    PaintBox2: TPaintBox;
    PaintBox3: TPaintBox;
    PaintBox4: TPaintBox;
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure RadioButton3Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
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
  Form2: TForm2;

implementation

{$R *.dfm}

uses Main, GLTreeView, MathParser;

procedure TForm2.RadioButton1Click(Sender: TObject);
begin
  Panel1.Visible:=False;
  Panel2.Visible:=True;
  Panel3.Visible:=False;
  Edit5.SetFocus;
end;

procedure TForm2.RadioButton2Click(Sender: TObject);
begin
  Panel1.Visible:=True;
  Panel2.Visible:=False;
  Panel3.Visible:=False;
  Edit1.SetFocus;
end;

procedure TForm2.Button1Click(Sender: TObject);
var
  Ebene: TEbene;
  S1, S2, S3, S4, S5, S6, S7, S8, S9: string;
  Name, FullName: string;
  Number: integer;
begin
try
  Name:=ObjectName.Text;
  FullName:=Name;

  Number:=Length(Name);
  while Name[Number] in ['0'..'9'] do begin
    Delete(Name, Number, 1);
    dec(Number);
  end;

  If NameUsed(FullName) then begin
    ShowMessage('Ein Objekt mit diesem Namen existiert bereits!');
    Number:=1; FullName:=Name+IntToStr(Number);
    while NameUsed(FullName) do begin
      Number:=Number+1;
      FullName:=Name+IntToStr(Number);
    end;
    ObjectName.Text:=FullName;
    Exit;
  end;

  If RadioButton2.Checked then begin
    S1:=Edit4.Text;
    S4:=Edit1.Text; S5:=Edit2.Text; S6:=Edit3.Text;
    Form1.NewEbene(ProcessLine(S4, VarsArchive),ProcessLine(S5, VarsArchive),
                   ProcessLine(S6, VarsArchive),ProcessLine(S1, VarsArchive));
    S2:='('+S4+')^2+('+S5+')^2+('+S6+')^2';
    S7:='('+S4+')*('+S1+')/('+S2+')'; S8:='('+S5+')*('+S1+')/('+S2+')'; S9:='('+S6+')*('+S1+')/('+S2+')';
    S1:='-'+S7; S2:='-'+S8; S3:='-'+S9;
    S7:=Edit4.Text;
  end;
  If RadioButton1.Checked then begin
    S1:=Edit5.Text; S2:=Edit6.Text; S3:=Edit7.Text;
    S4:=Edit8.Text; S5:=Edit9.Text; S6:=Edit10.Text;
    S7:=Edit11.Text; S8:=Edit12.Text; S9:=Edit13.Text;
    Form1.NewEbene(ProcessLine(S1, VarsArchive),ProcessLine(S2, VarsArchive),ProcessLine(S3, VarsArchive),
                   ProcessLine(S4, VarsArchive),ProcessLine(S5, VarsArchive),ProcessLine(S6, VarsArchive),
                   ProcessLine(S7, VarsArchive),ProcessLine(S8, VarsArchive),ProcessLine(S9, VarsArchive));
    S1:='('+S5+')*('+S9+')-('+S6+')*('+S8+')';
    S2:='('+S6+')*('+S7+')-('+S4+')*('+S9+')';
    S3:='('+S4+')*('+S8+')-('+S5+')*('+S7+')';
    S4:=S1; S5:=S2; S6:=S3;
    S1:=Edit5.Text; S2:=Edit6.Text; S3:=Edit7.Text;
    S7:='-(('+S1+')*('+S4+')+('+S2+')*('+S5+')+('+S3+')*('+S6+'))';
  end;
  If RadioButton3.Checked then begin
    S1:=Edit14.Text; S2:=Edit15.Text; S3:=Edit16.Text;
    S4:=Edit17.Text; S5:=Edit18.Text; S6:=Edit19.Text;
    S7:='-(('+S1+')*('+S4+')+('+S2+')*('+S5+')+('+S3+')*('+S6+'))';
    Form1.NewEbene(ProcessLine(S1, VarsArchive),ProcessLine(S2, VarsArchive),ProcessLine(S3, VarsArchive),
                   ProcessLine(S4, VarsArchive),ProcessLine(S5, VarsArchive),ProcessLine(S6, VarsArchive));
  end;

  Form1.TreeView1.Selected.Text:=FullName;
  Ebene:=TEbene(TGLNode(Form1.TreeView1.Selected).LinkedObject);
  Ebene.ObjectName:=FullName;
  Ebene.ParamPosX1:=ProcessTriadLine(S1); Ebene.ParamPosX2:=ProcessTriadLine(S2);
  Ebene.ParamPosX3:=ProcessTriadLine(S3); Ebene.ParamDirX1:=ProcessTriadLine(S4);
  Ebene.ParamDirX2:=ProcessTriadLine(S5); Ebene.ParamDirX3:=ProcessTriadLine(S6);
  Ebene.Param_N0:=S7;
  Ebene.Material.FrontProperties.Diffuse.AsWinColor:=ColorBox1.Selected;
  Ebene.Material.BackProperties.Diffuse.AsWinColor:=ColorBox1.Selected;
  Ebene.Material.FrontProperties.Diffuse.Alpha:=0.8;
  Ebene.Material.BackProperties.Diffuse.Alpha:=0.8;

  ZeigeDaten(Ebene, Form1.Memo1);
  Form1.RegisterActions(Ebene, 'Create');

  Hide;
 except
   MessageDlg('Fehlerhafte Eingabe! Überprüfen Sie, ob alle Zahlen korrekt eingegeben wurden.', mtError, [mbOk], 0);
 end;
end;

procedure TForm2.RadioButton3Click(Sender: TObject);
begin
  Panel1.Visible:=False;
  Panel2.Visible:=False;
  Panel3.Visible:=True;
  Edit14.SetFocus;
end;

procedure TForm2.FormActivate(Sender: TObject);
var
  Name, FullName: string;
  Number: integer;
begin
  ColorBox1.Selected:=Random($F)*$100000+Random($F)*$1000+random($F)*$10;

  Name:='E';
  FullName:=Name;

  Number:=1; FullName:=Name+IntToStr(Number);
  while NameUsed(FullName) do begin
    Number:=Number+1;
    FullName:=Name+IntToStr(Number);
  end;
  ObjectName.Text:=FullName;

  If Panel1.Visible then
    Edit1.SetFocus;
  If Panel2.Visible then
    Edit5.SetFocus;
  If Panel3.Visible then
    Edit14.SetFocus;

  // Message Bearbeitung einschalten
  ApplicationEvents1.OnMessage:= ApplicationEvents1Message;
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  Hide;
end;

procedure TForm2.ApplicationEvents1Message(var Msg: tagMSG;
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

procedure TForm2.FormCreate(Sender: TObject);
var
  i: integer;
begin
  for i:=1 to high(GermanColors) do
    ColorBox1.Items[i]:=GermanColors[i];
  ColorBox1.Items[0]:='benutzerdefiniert...';  
  ColorBox1.Selected:=clBlack;
end;

procedure TForm2.PaintBox1Paint(Sender: TObject);
begin
  VerlaufDiagonalUp(TPaintBox(Sender).Canvas, clGreen, clMoneyGreen, TPaintBox(Sender).Width, TPaintBox(Sender).Height);
end;

procedure TForm2.PaintBox2Paint(Sender: TObject);
begin
  VerlaufDiagonalDown(TPaintBox(Sender).Canvas, clGreen, clMoneyGreen, TPaintBox(Sender).Width, TPaintBox(Sender).Height);
end;

procedure TForm2.FormDeactivate(Sender: TObject);
begin
  ApplicationEvents1.OnMessage:= nil;
end;

end.
