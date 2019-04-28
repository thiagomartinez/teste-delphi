program Calculadora;

uses
  Vcl.Forms,
  UCalculadora in 'UCalculadora.pas' {Form1},
  UCalc in 'UCalc.pas',
  UFuncionario in 'UFuncionario.pas',
  UDependente in 'UDependente.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormCalculadora, FormCalculadora);
  Application.Run;
end.
