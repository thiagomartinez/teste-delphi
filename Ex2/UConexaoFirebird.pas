unit UConexaoFirebird;

interface

uses SqlExpr, inifiles, SysUtils, IBX.IBDatabase, Forms, IBX.IBQuery;

type

  TConexaoFirebird = class
    private
      FConexao: TIBDataBase;
      //FConexao: TSQLConnection;
      //FSqqGeral : TSQLQuery;
      FQuery: TIBQuery;
    public
      constructor Create;
      destructor Destroy; override;
      function GetConexao: TIBDataBase;
      property ConexaoBanco : TIBDataBase read GetConexao;
      //property SqqGeral : TSQLQuery read FSqqGeral write FSqqGeral;
      property Query: TIBQuery read FQuery write FQuery;
  end;

implementation

{ TConexaoFirebird }

constructor TConexaoFirebird.Create;
var Servidor, Caminho: String;
begin
  Servidor := 'localhost';
  Caminho  := 'D:\Git\teste-delphi\Ex2\IMPOSTO.FDB';

  try
    FConexao := TIBDatabase.Create(nil);
    FConexao.SQLDialect := 3;
    FConexao.LoginPrompt    := False;
    FConexao.DatabaseName := Servidor + ':' + Caminho;
    FConexao.Params.Values['User_Name']  := 'SYSDBA';
    FConexao.Params.Values['Password']   := 'masterkey';
    FConexao.Connected := True;
    //FQuery := Query.Create(nil);
    //FQuery.Database := FConexao;
    {FConexao := TSQLConnection.Create(Application);
    FConexao.ConnectionName := 'FBConnection';
    FConexao.DriverName     := 'Firebird';
    FConexao.LibraryName    := 'dbxfb.dll';
    FConexao.VendorLib      := 'fbclient.dll';
    FConexao.GetDriverFunc  := 'getSQLDriverINTERBASE';
    FConexao.LoginPrompt    := False;
    FConexao.Connected  := False;
    FConexao.Params.Values['DataBase']   := Servidor + ':' + Caminho;
    FConexao.Params.Values['User_Name']  := 'SYSDBA';
    FConexao.Params.Values['Password']   := 'masterkey';
    FConexao.Connected  := True;

    FSqqGeral := TSQLQuery.Create(Application);
    FSqqGeral.SQLConnection := FConexao;}
  except
    raise Exception.Create('Erro ao conectar ao banco de dados');
  end;
end;

destructor TConexaoFirebird.Destroy;
begin
  FConexao.Free;
  inherited;
end;

function TConexaoFirebird.GetConexao: TIBDataBase;
begin
   Result := FConexao;
end;

end.
