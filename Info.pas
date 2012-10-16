unit Info;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, StdCtrls;

type
  TInfoScreen = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Bevel1: TBevel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Button1: TButton;
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  InfoScreen: TInfoScreen;

implementation

{$R *.dfm}

function GetVersion(sFileName:string): string; 
var 
  VerInfoSize: DWORD; 
  VerInfo: Pointer; 
  VerValueSize: DWORD; 
  VerValue: PVSFixedFileInfo; 
  Dummy: DWORD; 
begin 
  VerInfoSize := GetFileVersionInfoSize(PChar(sFileName), Dummy); 
  GetMem(VerInfo, VerInfoSize); 
  GetFileVersionInfo(PChar(sFileName), 0, VerInfoSize, VerInfo); 
  VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize); 
  with VerValue^ do 
  begin 
    Result := IntToStr(dwFileVersionMS shr 16); 
    Result := Result + '.' + IntToStr(dwFileVersionMS and $FFFF); 
    Result := Result + '.' + IntToStr(dwFileVersionLS shr 16); 
    Result := Result + '.' + IntToStr(dwFileVersionLS and $FFFF); 
  end; 
  FreeMem(VerInfo, VerInfoSize); 
end;

procedure TInfoScreen.FormActivate(Sender: TObject);
var
  MemStat: TMemoryStatus;
  l: Integer;
  handle: Cardinal;
  data: Pointer;
begin
  GlobalMemoryStatus(MemStat);
  Label6.Caption:= Format('Physikalischer Speicher:        %0.2fMB',[MemStat.dwTotalPhys/(1024*1024)]);
  Label7.Caption:= Format('Verfügbarer Speicher:            %0.2fMB',[MemStat.dwAvailPhys/(1024*1024)]);
  Label8.Caption:= Format('Verschwendeter Speicher:    %0.2fMB',[(MemStat.dwTotalPhys-MemStat.dwAvailPhys)/(1024*1024)]);

  Label2.Caption:= GetVersion(Application.ExeName);
end;

procedure TInfoScreen.Button1Click(Sender: TObject);
begin
  Hide;
end;

end.
