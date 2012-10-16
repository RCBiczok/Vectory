program ParserTestProject;

uses
  Forms,
  ParserTest in 'ParserTest.pas' {ParserTestForm},
  MathParser in 'MathParser.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TParserTestForm, ParserTestForm);
  Application.Run;
end.
