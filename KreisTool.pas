unit KreisTool;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, AppEvnts, StdCtrls, ExtCtrls, Verlauf, Primitives,
  MathParser, GLTreeView;

type
  TKreisForm = class(TForm)
    ApplicationEvents1: TApplicationEvents;
    Panel1: TPanel;
    PaintBox1: TPaintBox;
    Label2: TLabel;
    Label3: TLabel;
    Label1: TLabel;
    Label4: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit7: TEdit;
    Button1: TButton;
    Button2: TButton;
    PaintBox2: TPaintBox;
    Label19: TLabel;
    Farbe: TLabel;
    ObjectName: TEdit;
    ColorBox1: TColorBox;
    Label5: TLabel;
    Label6: TLabel;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Label7: TLabel;
    Label21: TLabel;
    Label8: TLabel;
    Panel2: TPanel;
    PaintBox3: TPaintBox;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Edit8: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    Edit12: TEdit;
    Edit13: TEdit;
    Edit14: TEdit;
    Label12: TLabel;
    Label18: TLabel;
    Edit11: TEdit;
    Edit15: TEdit;
    Edit16: TEdit;
    Label20: TLabel;
    procedure PaintBox4Paint(Sender: TObject);
    procedure PaintBox2Paint(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure RadioButton3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ApplicationEvents1Message(var Msg: tagMSG;
      var Handled: Boolean);
    procedure Button2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  KreisForm: TKreisForm;

implementation

{$R *.dfm}

uses
  Main;

procedure TKreisForm.PaintBox4Paint(Sender: TObject);
begin
  VerlaufDiagonalUp(TPaintBox(Sender).Canvas, clGreen, clMoneyGreen, TPaintBox(Sender).Width, TPaintBox(Sender).Height);
end;

procedure TKreisForm.PaintBox2Paint(Sender: TObject);
begin
  VerlaufDiagonalDown(TPaintBox(Sender).Canvas, clGreen, clMoneyGreen, TPaintBox(Sender).Width, TPaintBox(Sender).Height);
end;

procedure TKreisForm.RadioButton1Click(Sender: TObject);
begin
  Panel1.Visible:= True;
  Panel2.Visible:= False;
  Edit1.SetFocus;
end;

procedure TKreisForm.RadioButton2Click(Sender: TObject);
begin
  Panel1.Visible:= False;
  Panel2.Visible:= True;
  Edit8.SetFocus;
end;

procedure TKreisForm.RadioButton3Click(Sender: TObject);
begin
  Panel1.Visible:= False;
  Panel2.Visible:= False;
end;

procedure TKreisForm.FormCreate(Sender: TObject);
var
  i: integer;
begin
  for i:=1 to high(GermanColors) do
    ColorBox1.Items[i]:=GermanColors[i];
  ColorBox1.Items[0]:='benutzerdefiniert...';  
  ColorBox1.Selected:=clBlack;
end;

procedure TKreisForm.ApplicationEvents1Message(var Msg: tagMSG;
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

procedure TKreisForm.Button2Click(Sender: TObject);
begin
  Hide;
end;

procedure TKreisForm.FormActivate(Sender: TObject);
var
  Name, FullName: string;
  Number: integer;
begin
  ColorBox1.Selected:=Random($F)*$100000+Random($F)*$1000+random($F)*$10;

  Name:='k';
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
    Edit8.SetFocus;

  ApplicationEvents1.OnMessage:= ApplicationEvents1Message;
end;

procedure TKreisForm.Button1Click(Sender: TObject);
var
  Kreis: TKreis;
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

  S1:=Edit1.Text; S2:=Edit2.Text; S3:=Edit3.Text;
  S4:=Edit4.Text; S5:=Edit5.Text; S6:=Edit6.Text;
  S7:=Edit7.Text;
  Form1.NewKreis(ProcessLine(S1, VarsArchive),ProcessLine(S2, VarsArchive),ProcessLine(S3, VarsArchive),
                 ProcessLine(S4, VarsArchive),ProcessLine(S5, VarsArchive),ProcessLine(S6, VarsArchive),
                 ProcessLine(S7, VarsArchive));
  Form1.TreeView1.Selected.Text:=FullName;
  Kreis:=TKreis(TGLNode(Form1.TreeView1.Selected).LinkedObject);
  Kreis.ObjectName:=FullName;
  Kreis.ParamPosX1:=ProcessTriadLine(S1); Kreis.ParamPosX2:=ProcessTriadLine(S2);
  Kreis.ParamPosX3:=ProcessTriadLine(S3); Kreis.ParamDirX1:=ProcessTriadLine(S4);
  Kreis.ParamDirX2:=ProcessTriadLine(S5); Kreis.ParamDirX3:=ProcessTriadLine(S6);
  Kreis.ParamRadius:=S7;
  Kreis.Material.FrontProperties.Diffuse.AsWinColor:=ColorBox1.Selected;
  Kreis.Material.BackProperties.Diffuse.AsWinColor:=ColorBox1.Selected;
  Kreis.Material.FrontProperties.Diffuse.Alpha:=0.8;
  Kreis.Material.BackProperties.Diffuse.Alpha:=0.8;

//  ZeigeDaten(Kreis, Form1.Memo1);
  Form1.RegisterActions(Kreis, 'Create');

  Hide;
 except
   MessageDlg('Fehlerhafte Eingabe! Überprüfen Sie, ob alle Zahlen korrekt eingegeben wurden.', mtError, [mbOk], 0);
 end;
end;

procedure TKreisForm.FormDeactivate(Sender: TObject);
begin
  ApplicationEvents1.OnMessage:= nil;
end;

end.
