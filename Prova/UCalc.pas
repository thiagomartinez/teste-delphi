unit UCalc;

interface

uses
  System.SysUtils;

type

    TCalc = class
      private
        FOperacao: String;
        FResultado : Double;
        FUltimoNum : String;
        FHistorico : String;
        FImpostoA  : Double;
        FImpostoB  : Double;
        procedure SetOperacao(const Value: String);
        procedure Somar();
        procedure Subtrair();
        procedure Multiplicar();
        procedure Dividir();
        procedure LimparUltNumero();
      protected

      public
        property Historico : String read FHistorico write FHistorico;
        property Operacao  : String read FOperacao write SetOperacao;
        property Resultado : Double read FResultado write FResultado;
        property UltimoNum : String read FUltimoNum write FUltimoNum;
        property ImpostoA : Double read FImpostoA write FImpostoA;
        property ImpostoB : Double read FImpostoB write FImpostoB;
        procedure LimparCalculadora();
        procedure Calcular();
        procedure CalcularImposto(Tag: Integer);
        Constructor Create;
        procedure LimparHistorico();
      published

    end;

implementation

{ TCalc }

procedure TCalc.SetOperacao(const Value: String);
  var valor : String;
begin
  valor := Value;
  if valor = 'x' then
     valor := '*';
  if (Trim(UltimoNum) <> '') and (Trim(FOperacao) = '') then
  begin
    FHistorico := UltimoNum + valor;
    Resultado := StrToFloat(UltimoNum);
    LimparUltNumero();
    FOperacao := valor;
  end
  else if (Resultado > 0) and (Trim(FOperacao) <> '') and (Trim(UltimoNum) <> '') then
    begin
      FHistorico := FHistorico + UltimoNum + valor;
      Calcular();
      FOperacao := valor;
    end
  else if (Trim(UltimoNum) = '') and (Trim(FOperacao) <> '') then
  begin
    FHistorico := FHistorico + valor;
    FOperacao := valor;
  end;
end;

procedure TCalc.Somar;
begin
  if (Trim(UltimoNum) <> '') then
    Resultado := Resultado + StrToFloat(UltimoNum)
  else
    Resultado := Resultado + Resultado;
end;

procedure TCalc.Subtrair;
begin
  if (Trim(UltimoNum) <> '') then
    Resultado := Resultado - StrToFloat(UltimoNum)
  else
    Resultado := Resultado - Resultado;
end;

procedure TCalc.CalcularImposto(Tag: Integer);
begin
    case Tag of
      0:
      begin
        if (FUltimoNum <> '') then
        begin
          FHistorico := '(' + UltimoNum + '* 0.20) - 500';
          FResultado := (StrToFloat(UltimoNum) * 0.20) - 500;
          FImpostoA := FResultado;
        end;
      end;
      1:
      begin
        FHistorico := FloatToStr(FImpostoA) + ' - 15';
        Resultado := FImpostoA - 15;
        FImpostoB := Resultado;
      end;
      2:
      begin
          FHistorico := FloatToStr(FImpostoA) + '+' + FloatToStr(FImpostoB);
          Resultado := FImpostoA + FImpostoB;
      end;
    end;
end;

constructor TCalc.Create;
begin
  LimparCalculadora();
  FHistorico := '';
end;

procedure TCalc.Dividir;
begin
  if (Trim(UltimoNum) <> '') then
    Resultado := Resultado / StrToFloat(UltimoNum)
  else
    Resultado := Resultado / Resultado;
end;

procedure TCalc.LimparCalculadora();
begin
  LimparUltNumero();
  FOperacao  := '';
  Resultado  := 0;
  FImpostoA  := 0;
  FImpostoB  := 0;
  LimparHistorico;
end;

procedure TCalc.LimparHistorico;
begin
   FHistorico := '';
end;

procedure TCalc.LimparUltNumero;
begin
   FUltimoNum := '';
end;

procedure TCalc.Multiplicar;
begin
    if (Trim(UltimoNum) <> '') then
      Resultado := Resultado * StrToFloat(UltimoNum)
    else
      Resultado := Resultado * Resultado;
end;

procedure TCalc.Calcular();
begin
   if (Resultado > 0) and (Trim(FOperacao) <> '') then
   begin
       if FOperacao.Equals('+') then
         Somar()
       else if FOperacao.Equals('-') then
        Subtrair()
       else if FOperacao.Equals('*') then
        Multiplicar()
       else if FOperacao.Equals('/') then
        Dividir();
       LimparUltNumero();
   end;
end;

end.
