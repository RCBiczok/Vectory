program Vectory;

{%ToDo 'Vectory.todo'}
{%TogetherDiagram 'ModelSupport_Vectory\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_Vectory\Rueckblende\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_Vectory\KugelTool\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_Vectory\ParameterTool\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_Vectory\Primitives\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_Vectory\GeradenTool\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_Vectory\MathParser\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_Vectory\StreckenTool\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_Vectory\OrtsLinienTool\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_Vectory\OrtsLinie\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_Vectory\KreisTool\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_Vectory\Einstellung\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_Vectory\Vectory\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_Vectory\EbenenTool\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_Vectory\Main\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_Vectory\DoppelKlickTool\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_Vectory\PunkteTool\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_Vectory\ActionTest\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_Vectory\AbstandWinkel\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_Vectory\Profiles\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_Vectory\Splash\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_Vectory\Constructions\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_Vectory\ActionList\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_Vectory\GLTreeView\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_Vectory\GrafikOptions\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_Vectory\Info\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_Vectory\SaveFileSettings\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_Vectory\Konstruktionen\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_Vectory\default.txvpck'}
{%TogetherDiagram 'ModelSupport_Vectory\Main\default.txvpck'}
{%TogetherDiagram 'ModelSupport_Vectory\MathParser\default.txvpck'}
{%TogetherDiagram 'ModelSupport_Vectory\Constructions\default.txvpck'}
{%TogetherDiagram 'ModelSupport_Vectory\KreisTool\default.txvpck'}
{%TogetherDiagram 'ModelSupport_Vectory\Profiles\default.txvpck'}
{%TogetherDiagram 'ModelSupport_Vectory\SaveFileSettings\default.txvpck'}
{%TogetherDiagram 'ModelSupport_Vectory\KugelTool\default.txvpck'}
{%TogetherDiagram 'ModelSupport_Vectory\OrtsLinienTool\default.txvpck'}
{%TogetherDiagram 'ModelSupport_Vectory\PunkteTool\default.txvpck'}
{%TogetherDiagram 'ModelSupport_Vectory\GrafikOptions\default.txvpck'}
{%TogetherDiagram 'ModelSupport_Vectory\GLTreeView\default.txvpck'}
{%TogetherDiagram 'ModelSupport_Vectory\EbenenTool\default.txvpck'}
{%TogetherDiagram 'ModelSupport_Vectory\Konstruktionen\default.txvpck'}
{%TogetherDiagram 'ModelSupport_Vectory\DoppelKlickTool\default.txvpck'}
{%TogetherDiagram 'ModelSupport_Vectory\AbstandWinkel\default.txvpck'}
{%TogetherDiagram 'ModelSupport_Vectory\Einstellung\default.txvpck'}
{%TogetherDiagram 'ModelSupport_Vectory\OrtsLinie\default.txvpck'}
{%TogetherDiagram 'ModelSupport_Vectory\Rueckblende\default.txvpck'}
{%TogetherDiagram 'ModelSupport_Vectory\ParameterTool\default.txvpck'}
{%TogetherDiagram 'ModelSupport_Vectory\Primitives\default.txvpck'}
{%TogetherDiagram 'ModelSupport_Vectory\StreckenTool\default.txvpck'}
{%TogetherDiagram 'ModelSupport_Vectory\ActionTest\default.txvpck'}
{%TogetherDiagram 'ModelSupport_Vectory\Info\default.txvpck'}
{%TogetherDiagram 'ModelSupport_Vectory\ActionList\default.txvpck'}
{%TogetherDiagram 'ModelSupport_Vectory\Vectory\default.txvpck'}
{%TogetherDiagram 'ModelSupport_Vectory\Splash\default.txvpck'}
{%TogetherDiagram 'ModelSupport_Vectory\GeradenTool\default.txvpck'}

uses
  Forms,
  SysUtils,
  Registry,
  Windows,
  Dialogs,
  Controls,
  Main in 'Main.pas' {Form1},
  EbenenTool in 'EbenenTool.pas' {Form2},
  GeradenTool in 'GeradenTool.pas' {Form3},
  PunkteTool in 'PunkteTool.pas' {Form4},
  KugelTool in 'KugelTool.pas' {Form5},
  DoppelKlickTool in 'DoppelKlickTool.pas' {Form6},
  GLTreeView in 'GLTreeView.pas',
  GrafikOptions in 'GrafikOptions.pas' {Form7},
  ActionList in 'ActionList.pas',
  Rueckblende in 'Rueckblende.pas' {Form8},
  StreckenTool in 'StreckenTool.pas' {Form9},
  Profiles in 'Profiles.pas',
  MathParser in 'MathParser.pas',
  ParameterTool in 'ParameterTool.pas' {ParamTool},
  AbstandWinkel in 'AbstandWinkel.pas',
  Primitives in 'Primitives.pas',
  SaveFileSettings in 'SaveFileSettings.pas',
  Einstellung in 'Einstellung.pas',
  Konstruktionen in 'Konstruktionen.pas',
  ActionTest in 'ActionTest.pas' {ActTest},
  Splash in 'Splash.pas' {SplashScreen},
  Info in 'Info.pas' {InfoScreen},
  KreisTool in 'KreisTool.pas' {KreisForm},
  OrtsLinie in 'OrtsLinie.pas',
  OrtsLinienTool in 'OrtsLinienTool.pas' {OrtsLinieTool},
  Constructions in 'Constructions.pas';

{$E exe}


{$R *.res}
var
  Reg: TRegistry;

begin
  Application.Initialize;
  SplashScreen:=TSplashScreen.Create(Application);
  SplashScreen.Show;
  SplashScreen.Update;
  Application.Title := 'Vectory';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TInfoScreen, InfoScreen);
  Application.CreateForm(TKreisForm, KreisForm);
  Application.CreateForm(TOrtsLinieTool, OrtsLinieTool);
  Splashscreen.ProgressBar1.Position:=10;
  Application.CreateForm(TForm2, Form2);
  Splashscreen.ProgressBar1.Position:=10;
  Application.CreateForm(TForm3, Form3);
  Splashscreen.ProgressBar1.Position:=20;
  Application.CreateForm(TForm4, Form4);
  Splashscreen.ProgressBar1.Position:=30;
  Application.CreateForm(TForm5, Form5);
  Splashscreen.ProgressBar1.Position:=40;
  Application.CreateForm(TForm6, Form6);
  Splashscreen.ProgressBar1.Position:=50;
  Application.CreateForm(TForm7, Form7);
  Splashscreen.ProgressBar1.Position:=60;
  Application.CreateForm(TForm8, Form8);
  Splashscreen.ProgressBar1.Position:=70;
  Application.CreateForm(TForm9, Form9);
  Splashscreen.ProgressBar1.Position:=80;
  Application.CreateForm(TParamTool, ParamTool);
  Splashscreen.ProgressBar1.Position:=90;
  If Form1.Tag = 1 then
    Application.CreateForm(TActTest, ActTest);
  Splashscreen.ProgressBar1.Position:=100;
  sleep(1000);
  SplashScreen.Free;
//== Test if the program is assosiated with thze extensions .vec and .vsc
  try
    Reg:= TRegistry.Create(KEY_ALL_ACCESS);
    Reg.RootKey:= HKEY_CLASSES_ROOT;
    If not Reg.KeyExists('.vec') and
       (MessageDlg('Wollen Sie in Zukunft .vec Dateien mit Vectory öffnen', mtConfirmation,
       [mbYes, mbNo], 0) = mrYes) then begin
      Reg.OpenKey('.vec', True);
      Reg.WriteString('', 'Vectory - Datei');
      Reg.CloseKey;
      Reg.OpenKey('Vectory - Datei', True);
      Reg.OpenKey('DefaultIcon', True);
      Reg.WriteString('', Application.ExeName + ',0');
      Reg.CloseKey;
      Reg.OpenKey('Shell', True);
      Reg.OpenKey('Open', True);
      Reg.OpenKey('Command', True);
      Reg.WriteString('', '"' + Application.ExeName + '" "%1"');
      Reg.CloseKey;
    end;
    If not Reg.KeyExists('.vsc') and
       (MessageDlg('Wollen Sie in Zukunft .vsc Dateien mit Vectory öffnen', mtConfirmation,
       [mbYes, mbNo], 0) = mrYes) then begin
      Reg.OpenKey('.vsc', True);
      Reg.WriteString('', 'Vectory Script - Datei');
      Reg.CloseKey;
      Reg.OpenKey('Vectory Script - Datei', True);
      Reg.OpenKey('DefaultIcon', True);
      Reg.WriteString('', Application.ExeName + ',0');
      Reg.CloseKey;
      Reg.OpenKey('Vectory Script - Datei', True);
      Reg.OpenKey('Shell', True);
      Reg.OpenKey('Open', True);
      Reg.OpenKey('Command', True);
      Reg.WriteString('', '"' + Application.ExeName + '" "%1"');
    end;
  except
  end;
  Application.Run;
end.
