unit StreckenTool;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, AppEvnts, Primitives, MathParser, Verlauf;

type
  TForm9 = class(TForm)
    Panel2: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Button1: TButton;
    Button2: TButton;
    ApplicationEvents1: TApplicationEvents;
    Label19: TLabel;
    Farbe: TLabel;
    ObjectName: TEdit;
    ColorBox1: TColorBox;
    PaintBox1: TPaintBox;
    PaintBox2: TPaintBox;
    procedure Button2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
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
  Form9: TForm9;

implementation

uses Main, GLTreeView;

{$R *.dfm}

procedure TForm9.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TForm9.FormActivate(Sender: TObject);
var
  Name, FullName: string;
  Number: integer;
begin
  ColorBox1.Selected:=Random($F)*$100000+Random($F)*$1000+random($F)*$10;

  Name:='s';
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

procedure TForm9.Button1Click(Sender: TObject);
var
  Strecke: TStrecke;
  Name, FullName: string;
  Number: integer;
  P1, P2, P3, P4, P5, P6: string;
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

   P1:=Edit1.Text; P2:=Edit2.Text; P3:=Edit3.Text;
   P4:=Edit4.Text; P5:=Edit5.Text; P6:=Edit6.Text;
   Form1.NewStrecke(ProcessLine(P1, VarsArchive),ProcessLine(P2, VarsArchive),
                    ProcessLine(P3, VarsArchive),ProcessLine(P4, VarsArchive),
                    ProcessLine(P5, VarsArchive),ProcessLine(P6, VarsArchive));

   Form1.TreeView1.Selected.Text:=FullName;
   Strecke:=TStrecke(TGLNode(Form1.TreeView1.Selected).LinkedObject);
   Strecke.ParamP1X1:=ProcessTriadLine(P1);
   Strecke.ParamP1X2:=ProcessTriadLine(P2);
   Strecke.ParamP1X3:=ProcessTriadLine(P3);
   Strecke.ParamP2X1:=ProcessTriadLine(P4);
   Strecke.ParamP2X2:=ProcessTriadLine(P5);
   Strecke.ParamP2X3:=ProcessTriadLine(P6);
   Strecke.ObjectName:=FullName;
   Strecke.Material.FrontProperties.Diffuse.AsWinColor:=ColorBox1.Selected;

   ZeigeDaten(Strecke, Form1.Memo1);
   Form1.RegisterActions(TGLNode(Form1.TreeView1.Selected).LinkedObject, 'Create');
   Form9.Hide;
 except
   MessageDlg('Fehlerhafte Eingabe! Überprüfen Sie, ob alle Zahlen korrekt eingegeben wurden.', mtCustom, [mbOk], 0);
 end;
end;

procedure TForm9.ApplicationEvents1Message(var Msg: tagMSG;
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

procedure TForm9.FormCreate(Sender: TObject);
var
  i: integer;
begin
  for i:=1 to high(GermanColors) do
    ColorBox1.Items[i]:=GermanColors[i];
  ColorBox1.Items[0]:='benutzerdefiniert...';
end;

procedure TForm9.PaintBox1Paint(Sender: TObject);
begin
  VerlaufDiagonalUp(TPaintBox(Sender).Canvas, clGreen, clMoneyGreen, TPaintBox(Sender).Width, TPaintBox(Sender).Height);
end;

procedure TForm9.PaintBox2Paint(Sender: TObject);
begin
  VerlaufDiagonalDown(TPaintBox(Sender).Canvas, clGreen, clMoneyGreen, TPaintBox(Sender).Width, TPaintBox(Sender).Height);
end;

procedure TForm9.FormDeactivate(Sender: TObject);
begin
  ApplicationEvents1.OnMessage:= nil;
end;

end.
