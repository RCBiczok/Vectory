unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Registry, Grids, ValEdit;

type
  TForm1 = class(TForm)
    ValueListEditor1: TValueListEditor;
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;
  Reg: TRegistry;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var
  Strings: TStringList;
  KInfo: TRegKeyInfo;
begin
  Reg:= TRegistry.Create(KEY_ALL_ACCESS);
  Reg.RootKey:= HKEY_CLASSES_ROOT;
//  If not Reg.KeyExists('.vsc') then begin
    Reg.OpenKey('.vsc', True);
    Reg.WriteString('', 'Vectory Script');
    Reg.CloseKey;
    Reg.OpenKey('Vectory Script', True);
    Reg.OpenKey('shell', True);
    Reg.OpenKey('open', True);
    Reg.OpenKey('command', True);
    Reg.WriteString('', '"c:\Test\Plane\vectory.exe" "%1"');
//  end;
end;

end.
 