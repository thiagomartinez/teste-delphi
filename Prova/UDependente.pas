unit UDependente;

interface

Type TDependente = class
  private
    FID: Integer;
    FIsCalculaINSS: Integer;
    FNome: String;
    FIsCalculaIR: Integer;
    procedure SetID(const Value: Integer);
    procedure SetIsCalculaINSS(const Value: Integer);
    procedure SetIsCalculaIR(const Value: Integer);
    procedure SetNome(const Value: String);
  protected
  public
    property ID : Integer read FID write SetID;
    property Nome : String read FNome write SetNome;
    property IsCalculaIR : Integer read FIsCalculaIR write SetIsCalculaIR;
    property IsCalculaINSS : Integer read FIsCalculaINSS write SetIsCalculaINSS;
  published
end;

implementation

{ TDependente }

procedure TDependente.SetID(const Value: Integer);
begin
  FID := Value;
end;

procedure TDependente.SetIsCalculaINSS(const Value: Integer);
begin
  FIsCalculaINSS := Value;
end;

procedure TDependente.SetIsCalculaIR(const Value: Integer);
begin
  FIsCalculaIR := Value;
end;

procedure TDependente.SetNome(const Value: String);
begin
  FNome := Value;
end;

end.
