unit UFuncionario;

interface

uses Classes, UDependente;

Type
    TFuncionario = class
      private
        FCPF: String;
        FSalario: Double;
        FID: Integer;
        FNome: String;
        FListaDependentes : TList;
        procedure SetCPF(const Value: String);
        procedure SetID(const Value: Integer);
        procedure SetNome(const Value: String);
        procedure SetSalario(const Value: Double);
      protected
      public
        property ID : Integer read FID write SetID;
        property Nome : String read FNome write SetNome;
        property CPF : String read FCPF write SetCPF;
        property Salario : Double read FSalario write SetSalario;
        constructor Create;
        procedure AdicionarDependente(pDependente: TDependente);
        procedure RemoverDependente(ID: Integer);
      published
    end;

implementation

{ TFuncionario }

procedure TFuncionario.AdicionarDependente(pDependente: TDependente);
begin
  FListaDependentes.Add(pDependente);
end;

constructor TFuncionario.Create;
begin
  FListaDependentes := TList.Create;
end;

procedure TFuncionario.RemoverDependente(ID: Integer);
begin
  FListaDependentes.Delete(ID);
end;

procedure TFuncionario.SetCPF(const Value: String);
begin
  FCPF := Value;
end;

procedure TFuncionario.SetID(const Value: Integer);
begin
  FID := Value;
end;

procedure TFuncionario.SetNome(const Value: String);
begin
  FNome := Value;
end;

procedure TFuncionario.SetSalario(const Value: Double);
begin
  FSalario := Value;
end;

end.
