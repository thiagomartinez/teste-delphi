unit UDataModule;

interface

uses
  System.SysUtils, System.Classes, Data.DB, IBX.IBDatabase, IBX.IBCustomDataSet,
  IBX.IBQuery, Datasnap.DBClient, Datasnap.Provider;

type
  TDataMod = class(TDataModule)
    DataBase: TIBDatabase;
    Query: TIBQuery;
    Transaction: TIBTransaction;
    cdsMem: TClientDataSet;
    dsQuery: TDataSource;
    Provider: TDataSetProvider;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataMod: TDataMod;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDataMod.DataModuleCreate(Sender: TObject);
begin
   if not DataBase.Connected then
   begin
      DataBase.Connected := True;
      Transaction.Active := True;
   end;

end;

procedure TDataMod.DataModuleDestroy(Sender: TObject);
begin
   if DataBase.Connected then
   begin
    DataBase.Connected := False;
    Transaction.Active := False;
   end;
end;

end.
