unit KugelTool;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, AppEvnts, ExtCtrls, Primitives, Verlauf, MathParser;

type
  TForm5 = class(TForm)
    Label2: TLabel;
    Label3: TLabel;
    Label1: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Button1: TButton;
    Edit4: TEdit;
    Label4: TLabel;
    Button2: TButton;
    ApplicationEvents1: TApplicationEvents;
    Label19: TLabel;
    Farbe: TLabel;
    ObjectName: TEdit;
    ColorBox1: TColorBox;
    PaintBox1: TPaintBox;
    PaintBox2: TPaintBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
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
  Form5: TForm5;

implementation

{$R *.dfm}

uses Main, GLTreeView;

procedure TForm5.Button1Click(Sender: TObject);
var
  Kugel: TKugel;
  Name, FullName: string;
  Number: integer;
  S1, S2, S3, S4: string;
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

  S1:=Edit1.Text; S2:=Edit2.Text; S3:=Edit3.Text; S4:=Edit4.Text;

  If ProcessLine(S4, VarsArchive) < 0 then begin
    ShowMessage('Der Radius darf nicht negativ sein!');
    Edit4.Undo;
    Exit;
  end;

  Form1.NewKugel(ProcessLine(S1, VarsArchive),ProcessLine(S2, VarsArchive),
                 ProcessLine(S3, VarsArchive), ProcessLine(S4, VarsArchive));
  Form1.TreeView1.Selected.Text:=FullName;
  Kugel:=TKugel(TGLNode(Form1.TreeView1.Selected).LinkedObject);
  Kugel.ObjectName:=FullName;
  Kugel.ParamPosX1:=ProcessTriadLine(S1);
  Kugel.ParamPosX2:=ProcessTriadLine(S2);
  Kugel.ParamPosX3:=ProcessTriadLine(S3);
  Kugel.ParamRadius:=ProcessTriadLine(S4);
  Kugel.Material.FrontProperties.Diffuse.AsWinColor:=ColorBox1.Selected;
  Kugel.Material.FrontProperties.Diffuse.Alpha:= 0.8;
  Form1.RegisterActions(Kugel, 'Create');

  ZeigeDaten(Kugel, Form1.Memo1);
  Form5.Hide;
 except
   MessageDlg('Fehlerhafte Eingabe! Überprüfen Sie, ob alle Zahlen korrekt eingegeben wurden.', mtError, [mbOk], 0);
 end;
end;

procedure TForm5.Button2Click(Sender: TObject);
begin
  Hide;
end;

procedure TForm5.FormActivate(Sender: TObject);
var
  Name, FullName: string;
  Number: integer;
begin
  ColorBox1.Selected:=Random($F)*$100000+Random($F)*$1000+random($F)*$10;

  Name:='K';
  FullName:=Name;

  Number:=1; FullName:=Name+IntToStr(Number);
  while NameUsed(FullName) do begin
    Number:=Number+1;
    FullName:=Name+IntToStr(Number);
  end;
  ObjectName.Text:=FullName;

  Edit1.SetFocus;

  ApplicationEvents1.OnMessage:= ApplicationEvents1Message;
end;

procedure TForm5.ApplicationEvents1Message(var Msg: tagMSG;
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

procedure TForm5.FormCreate(Sender: TObject);
var
  i: integer;
begin
  for i:=1 to high(GermanColors) do
    ColorBox1.Items[i]:=GermanColors[i];
  ColorBox1.Items[0]:='benutzerdefiniert...';
end;

procedure TForm5.PaintBox1Paint(Sender: TObject);
begin
  VerlaufDiagonalUp(TPaintBox(Sender).Canvas, clGreen, clMoneyGreen, TPaintBox(Sender).Width, TPaintBox(Sender).Height);
end;

procedure TForm5.PaintBox2Paint(Sender: TObject);
begin
  VerlaufDiagonalDown(TPaintBox(Sender).Canvas, clGreen, clMoneyGreen, TPaintBox(Sender).Width, TPaintBox(Sender).Height);
end;

procedure TForm5.FormDeactivate(Sender: TObject);
begin
  ApplicationEvents1.OnMessage:= nil;
end;

end.
