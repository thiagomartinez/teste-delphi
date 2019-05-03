unit UDependente;

interface

uses UDataModule, Datasnap.DBClient, Data.DB, Vcl.Dialogs, System.SysUtils, IBX.IBQuery, Datasnap.Provider;

Type TDependente = class
  private
    FID: Integer;
    FIDFuncionario: Integer;
    FNome: String;
    FIsCalculaIR: Integer;
    FIsCalculaINSS: Integer;
    FClient: TClientDataSet;
    FQuery: TIBQuery;
    FProv : TProvider;
    FDataSource: TDataSource;
  protected
  public
    property ID : Integer read FID write FID;
    property IDFuncionario : Integer read FIDFuncionario write FIDFuncionario;
    property Nome : String read FNome write FNome;
    property IsCalculaIR : Integer read FIsCalculaIR write FIsCalculaIR;
    property IsCalculaINSS : Integer read FIsCalculaINSS write FIsCalculaINSS;
    property MemDependentes : TClientDataSet read FClient write FClient;
    property dsMemDependentes : TDataSource read FDataSource write FDataSource;
    constructor Create;
    destructor  Destroy; override;
    function Incluir(IDFuncionario: Integer) : Boolean;
    function Alterar : Boolean;
    function Exluir  : Boolean;
    function Consultar(IDFuncionario: Integer) : Boolean;
    function TotalDepCalculaIR(IDFuncionario: Integer) : Integer;
    function TotalDepCalculaINSS(IDFuncionario: Integer) : Integer;
  published
end;

implementation

{ TDependente }

function TDependente.Alterar: Boolean;
begin
  DataMod.Query.Close;
  DataMod.Query.SQL.Clear;
  DataMod.Query.SQL.Add('UPDATE DEPENDENTE SET ');
  DataMod.Query.SQL.Add('NOME = :NOME, ');
  DataMod.Query.SQL.Add('ISCALCULAIR = :ISCALCULAIR, ');
  DataMod.Query.SQL.Add('ISCALCULAINSS = :ISCALCULAINSS ');
  DataMod.Query.SQL.Add('WHERE ID = :ID');
  DataMod.Query.ParamByName('ID').AsInteger := FID;
  DataMod.Query.ParamByName('NOME').AsString := FNome;
  DataMod.Query.ParamByName('ISCALCULAIR').AsInteger := FIsCalculaIR;
  DataMod.Query.ParamByName('ISCALCULAINSS').AsInteger := FIsCalculaINSS;
  try
    DataMod.Query.ExecSQL();
    DataMod.Transaction.Commit;
    Result := True;
  Except
    Result := False;
  end;
end;

function TDependente.Consultar(IDFuncionario: Integer): Boolean;
begin
  FClient.Close;
  FClient.SetProvider(FProv);
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add('SELECT ID, IDFUNCIONARIO, NOME, iif(ISCALCULAIR = 1, ''Sim'', ''Não'') as ISCALCULAIR, iif(ISCALCULAINSS = 1, ''Sim'', ''Não'') as ISCALCULAINSS');
  FQuery.SQL.Add('FROM DEPENDENTE ');
  FQuery.SQL.Add('WHERE IDFUNCIONARIO = :IDFUNCIONARIO ');
  FQuery.ParamByName('IDFUNCIONARIO').AsInteger := IDFuncionario;
  FQuery.Open;
  if not FQuery.IsEmpty then
  begin
    FClient.CreateDataSet;
    FQuery.First;
    while not (FQuery.Eof) do
    begin
      FClient.Append;
      FClient.FieldByName('ID').AsInteger            := FQuery.FieldByName('ID').AsInteger;
      FClient.FieldByName('IDFUNCIONARIO').AsInteger := FQuery.FieldByName('IDFUNCIONARIO').AsInteger;
      FClient.FieldByName('NOME').AsString           := FQuery.FieldByName('NOME').AsString;
      FClient.FieldByName('ISCALCULAIR').AsString    := FQuery.FieldByName('ISCALCULAIR').AsString;
      FClient.FieldByName('ISCALCULAINSS').AsString  := FQuery.FieldByName('ISCALCULAINSS').AsString;
      FClient.Post;
      FQuery.Next;
    end;
    FClient.ApplyUpdates(0);
    Result   := True;
  end
  else
    Result := False;
end;

function TDependente.Exluir: Boolean;
begin
  DataMod.Query.Close;
  DataMod.Query.SQL.Clear;
  DataMod.Query.SQL.Add('DELETE FROM DEPENDENTE ');
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

function TDependente.Incluir(IDFuncionario: Integer): Boolean;
begin
  DataMod.Query.Close;
  DataMod.Query.SQL.Clear;
  DataMod.Query.SQL.Add('INSERT INTO DEPENDENTE ');
  DataMod.Query.SQL.Add('(IDFUNCIONARIO, NOME, ISCALCULAIR, ISCALCULAINSS) ');
  DataMod.Query.SQL.Add('VALUES (:IDFUNCIONARIO, :NOME, :ISCALCULAIR, :ISCALCULAINSS) ');
  DataMod.Query.ParamByName('IDFUNCIONARIO').AsInteger := IDFuncionario;
  DataMod.Query.ParamByName('NOME').AsString := FNome;
  DataMod.Query.ParamByName('ISCALCULAIR').AsInteger := FIsCalculaIR;
  DataMod.Query.ParamByName('ISCALCULAINSS').AsInteger := FIsCalculaINSS;
  try
    DataMod.Query.ExecSQL();
    DataMod.Transaction.Commit;
    Result := True;
  Except
    Result := False;
  end;
end;

function TDependente.TotalDepCalculaINSS(IDFuncionario: Integer): Integer;
begin
  FClient.Close;
  FClient.SetProvider(FProv);
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add('SELECT COUNT(1) AS TOTAL');
  FQuery.SQL.Add('FROM DEPENDENTE ');
  FQuery.SQL.Add('WHERE IDFUNCIONARIO = :IDFUNCIONARIO ');
  FQuery.SQL.Add('  AND ISCALCULAINSS = 1 ');
  FQuery.ParamByName('IDFUNCIONARIO').AsInteger := IDFuncionario;
  FQuery.Open;
  if not FQuery.IsEmpty then
  begin
    Result   := FQuery.FieldByName('TOTAL').AsInteger;
  end
  else
    Result := 0;
end;

function TDependente.TotalDepCalculaIR(IDFuncionario: Integer): Integer;
begin
  FClient.Close;
  FClient.SetProvider(FProv);
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add('SELECT COUNT(1) AS TOTAL');
  FQuery.SQL.Add('FROM DEPENDENTE ');
  FQuery.SQL.Add('WHERE IDFUNCIONARIO = :IDFUNCIONARIO ');
  FQuery.SQL.Add('  AND ISCALCULAIR = 1 ');
  FQuery.ParamByName('IDFUNCIONARIO').AsInteger := IDFuncionario;
  FQuery.Open;
  if not FQuery.IsEmpty then
  begin
    Result   := FQuery.FieldByName('TOTAL').AsInteger;
  end
  else
    Result := 0;
end;

constructor TDependente.Create;
var Field : TField;
begin
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

    Field := TIntegerField.Create(nil);
    TIntegerField(Field).FieldName := 'ID';
    TIntegerField(Field).DisplayLabel := 'Código';
    TIntegerField(Field).DisplayWidth := 5;
    TIntegerField(Field).Required := False;
    TIntegerField(Field).DataSet := FClient;

    Field := TIntegerField.Create(nil);
    TIntegerField(Field).FieldName := 'IDFUNCIONARIO';
    TIntegerField(Field).DisplayLabel := 'IDFUNCIONARIO';
    TIntegerField(Field).DisplayWidth := 5;
    TIntegerField(Field).Required := False;
    TIntegerField(Field).Visible := False;
    TIntegerField(Field).DataSet := FClient;

    Field := TStringField.Create(nil);
    TStringField(Field).FieldName := 'NOME';
    TStringField(Field).DisplayLabel := 'Nome';
    TStringField(Field).Size := 250;
    TStringField(Field).DisplayWidth := 50;
    TStringField(Field).Required := False;
    TStringField(Field).DataSet := FClient;

    Field := TStringField.Create(nil);
    TStringField(Field).FieldName := 'ISCALCULAIR';
    TStringField(Field).DisplayLabel := 'Calcula IR';
    TStringField(Field).Size := 250;
    TStringField(Field).DisplayWidth := 5;
    TStringField(Field).Required := False;
    TStringField(Field).DataSet := FClient;

    Field := TStringField.Create(nil);
    TStringField(Field).FieldName := 'ISCALCULAINSS';
    TStringField(Field).DisplayLabel := 'Calcula INSS';
    TStringField(Field).Size := 250;
    TStringField(Field).DisplayWidth := 5;
    TStringField(Field).Required := False;
    TStringField(Field).DataSet := FClient;
  end;
end;

destructor TDependente.Destroy;
begin
  FreeAndNil(FQuery);
  FreeAndNil(FClient);
  FreeAndNil(FProv);
  FreeAndNil(FDataSource);
  inherited;
end;

end.
