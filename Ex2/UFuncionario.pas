unit UFuncionario;

interface

uses Classes, UDependente, UDataModule, Datasnap.DBClient, Data.DB, Vcl.Dialogs, System.SysUtils, IBX.IBQuery, Datasnap.Provider;

Type
    TFuncionario = class
      private
        FCPF: String;
        FSalario: Double;
        FID: Integer;
        FNome: String;
        FClient: TClientDataSet;
        FListaDependentes : TList;
        FQuery: TIBQuery;
        FProv : TProvider;
        FDataSource: TDataSource;
        Dep  : TDependente;
      protected
      public
        property ID : Integer read FID write FID;
        property Nome : String read FNome write FNome;
        property CPF : String read FCPF write FCPF;
        property Salario : Double read FSalario write FSalario;
        property MemFuncionarios : TClientDataSet read FClient write FClient;
        property dsMemFuncionarios : TDataSource read FDataSource write FDataSource;
        constructor Create;
        destructor  Destroy; override;
        procedure AdicionarDependente(pDependente: TDependente);
        procedure RemoverDependente(ID: Integer);
        function Incluir : Boolean;
        function Alterar : Boolean;
        function Exluir  : Boolean;
        function Consultar() : Boolean;
        function CalculaINSS : Double;
        function CalculaIR : Double;
      published
    end;

implementation

{ TFuncionario }

procedure TFuncionario.AdicionarDependente(pDependente: TDependente);
begin
  FListaDependentes.Add(pDependente);
end;

function TFuncionario.Alterar: Boolean;
begin
  DataMod.Query.Close;
  DataMod.Query.SQL.Clear;
  DataMod.Query.SQL.Add('UPDATE FUNCIONARIO SET ');
  DataMod.Query.SQL.Add('NOME = :NOME, ');
  DataMod.Query.SQL.Add('CPF = :CPF, ');
  DataMod.Query.SQL.Add('SALARIO = :SALARIO ');
  DataMod.Query.SQL.Add('WHERE ID = :ID');
  DataMod.Query.ParamByName('ID').AsInteger := FID;
  DataMod.Query.ParamByName('NOME').AsString := FNome;
  DataMod.Query.ParamByName('CPF').AsString := FCPF;
  DataMod.Query.ParamByName('SALARIO').AsFloat := FSalario;
  try
    DataMod.Query.ExecSQL();
    DataMod.Transaction.Commit;
    Result := True;
  Except
    Result := False;
  end;
end;

function TFuncionario.CalculaINSS: Double;
var Valor: Double;
begin
   if Dep.TotalDepCalculaINSS(FID) > 0 then
     Valor := (FSalario * 0.08);
   Result := Valor;
end;

function TFuncionario.CalculaIR: Double;
var Valor: Double;
    TotalDep : Integer;
begin
  TotalDep := Dep.TotalDepCalculaIR(FID);
  if TotalDep > 0 then
  begin
     Valor := (FSalario - (TotalDep * 100));
     Valor := (Valor * 0.15);
  end;
   Result := Valor;
end;

function TFuncionario.Consultar(): Boolean;
begin
  FClient.Close;
  FClient.SetProvider(FProv);
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add('SELECT ID, NOME, CPF, SALARIO ');
  FQuery.SQL.Add('FROM FUNCIONARIO ');
  FQuery.Open;
  if not FQuery.IsEmpty then
  begin
    FClient.CreateDataSet;
    FQuery.First;
    while not (FQuery.Eof) do
    begin
      FClient.Append;
      FClient.FieldByName('ID').AsInteger    := FQuery.FieldByName('ID').AsInteger;
      FClient.FieldByName('NOME').AsString   := FQuery.FieldByName('NOME').AsString;
      FClient.FieldByName('CPF').AsString    := FQuery.FieldByName('CPF').AsString;
      FClient.FieldByName('SALARIO').AsFloat := FQuery.FieldByName('SALARIO').AsFloat;
      FClient.Post;
      FQuery.Next;
    end;
    FClient.ApplyUpdates(0);
    Result   := True;
  end
  else
    Result := False;
end;

constructor TFuncionario.Create;
var Field : TField;
begin
  //FListaDependentes := TList.Create;
  Dep := TDependente.Create;
  FQuery := TIBQuery.Create(nil);
  FClient:= TClientDataSet.Create(nil);
  FProv  := TProvider.Create(nil);
  FDataSource := TDataSource.Create(nil);
  FQuery.Database := DataMod.DataBase;
  FQuery.Transaction := DataMod.Transaction;
  FProv.DataSet:=FQuery;
  FProv.Name:='MY_PROVIDER';
  FProv.Options:=[poAllowCommandText];
  FClient.SetProvider(FProv);
  FDataSource.DataSet := FClient;
  if FClient.FieldCount = 0 then
  begin
    FClient.FieldDefs.Clear;
    //FClient.FieldDefs.Add('ID', ftInteger);
    //FClient.FieldDefs.Add('NOME', ftString, 50, false);
    //FClient.FieldDefs.Add('CPF', ftString,20, false);
    //FClient.FieldDefs.Add('SALARIO', ftFloat);

    Field := TIntegerField.Create(nil);
    TIntegerField(Field).FieldName := 'ID';
    TIntegerField(Field).DisplayLabel := 'ID';
    TIntegerField(Field).DisplayWidth := 5;
    TIntegerField(Field).Required := False;
    TIntegerField(Field).DataSet := FClient;

    Field := TStringField.Create(nil);
    TStringField(Field).FieldName := 'NOME';
    TStringField(Field).DisplayLabel := 'Nome';
    TStringField(Field).Size := 250;
    TStringField(Field).DisplayWidth := 60;
    TStringField(Field).Required := False;
    TStringField(Field).DataSet := FClient;

    Field := TStringField.Create(nil);
    TStringField(Field).FieldName := 'CPF';
    TStringField(Field).DisplayLabel := 'Cpf';
    TStringField(Field).Size := 250;
    TStringField(Field).DisplayWidth := 20;
    TStringField(Field).Required := False;
    TStringField(Field).DataSet := FClient;

    Field := TFloatField.Create(nil);
    TFloatField(Field).FieldName := 'SALARIO';
    TFloatField(Field).DisplayLabel := 'Salário';
    TIntegerField(Field).DisplayFormat := 'R$ ###,###,##0.00';
    TFloatField(Field).DisplayWidth := 15;
    TFloatField(Field).Required := False;
    TFloatField(Field).Visible := False;
    TFloatField(Field).DataSet := FClient;
  end;
end;

destructor TFuncionario.Destroy;
begin
  FreeAndNil(FQuery);
  FreeAndNil(FClient);
  FreeAndNil(FProv);
  FreeAndNil(FDataSource);
  inherited;
end;

function TFuncionario.Exluir: Boolean;
begin
  DataMod.Query.Close;
  DataMod.Query.SQL.Clear;
  DataMod.Query.SQL.Add('DELETE FROM FUNCIONARIO ');
  DataMod.Query.SQL.Add('WHERE ID = :ID');
  DataMod.Query.ParamByName('ID').AsInteger := FID;
  try
    DataMod.Query.ExecSQL();
    DataMod.Transaction.Commit;
    Result := True;
  Except
    Result := False;
  end;
end;

function TFuncionario.Incluir: Boolean;
begin
  DataMod.Query.Close;
  DataMod.Query.SQL.Clear;
  DataMod.Query.SQL.Add('INSERT INTO FUNCIONARIO ');
  DataMod.Query.SQL.Add('(NOME, CPF, SALARIO) ');
  DataMod.Query.SQL.Add('VALUES (:NOME, :CPF, :SALARIO) ');
  DataMod.Query.ParamByName('NOME').AsString := FNome;
  DataMod.Query.ParamByName('CPF').AsString := FCPF;
  DataMod.Query.ParamByName('SALARIO').AsFloat := FSalario;
  try
    DataMod.Query.ExecSQL();
    DataMod.Transaction.Commit;
    Result := True;
  Except
    Result := False;
  end;
end;

procedure TFuncionario.RemoverDependente(ID: Integer);
begin
  FListaDependentes.Delete(ID);
end;

end.
