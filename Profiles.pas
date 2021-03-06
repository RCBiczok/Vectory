unit Profiles;

interface

uses
  SysUtils, Forms, GLContext;

type
   TDeskTop = record

   end;

  TGrafikOptions = record
    AntiAliasing: Boolean;
  end;

  TProfile = record
    DeskTop: TDeskTop;
    Grafik: TGrafikOptions;
  end;

procedure SaveProfile(FileName: TFileName);

implementation

uses
  Main;

procedure SaveProfile(FileName: TFileName);
var
  Settings: TextFile;
begin
//File-Header
  AssignFile(Settings, ExtractFilePath(Application.Exename)+'config.ini');
  Rewrite(Settings);
  Writeln(Settings, 'Settings - AnaGeo V.'+FILE_VERSION);
  Writeln(Settings);

//=== Desktop
  Writeln(Settings, 'Desktop');
//=== Grafik
  Writeln(Settings, 'Grafik');
// AntiAliasing
  If Form1.GLSceneViewer1.Buffer.AntiAliasing = aa4xHQ then
    WriteLn(Settings, 'Anti_Aliasing On')
  else
    Writeln(Settings, 'Anti_Aliasing Off');

  CloseFile(Settings);
end;

end.
