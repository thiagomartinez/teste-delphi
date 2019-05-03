program Ex2;

uses
  Vcl.Forms,
  UConexaoFirebird in 'UConexaoFirebird.pas',
  UDependente in 'UDependente.pas',
  UFuncionario in 'UFuncionario.pas',
  UCadFuncionario in 'UCadFuncionario.pas' {FormCadFuncionario},
  UDataModule in 'UDataModule.pas' {DataMod: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDataMod, DataMod);
  Application.CreateForm(TFormCadFuncionario, FormCadFuncionario);
  Application.Run;
end.
