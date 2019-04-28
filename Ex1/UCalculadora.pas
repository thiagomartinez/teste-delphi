unit UCalculadora;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, UCalc;

type
  TFormCalculadora = class(TForm)
    edtResultado: TEdit;
    btnsoma: TButton;
    btnsubtrair: TButton;
    btndividir: TButton;
    btnMultiplicar: TButton;
    btnigual: TButton;
    btn1: TButton;
    btn0: TButton;
    btn2: TButton;
    btnLimpar: TButton;
    btn3: TButton;
    btn4: TButton;
    btn5: TButton;
    btn6: TButton;
    btn7: TButton;
    btn8: TButton;
    btn9: TButton;
    btnVirgula: TButton;
    LHistorico: TLabel;
    btnImpostoA: TButton;
    btnImpostoB: TButton;
    btnImpostoC: TButton;
    procedure NumeroClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure OperacaoClick(Sender: TObject);
    procedure btnigualClick(Sender: TObject);
    procedure ImpostoClick(Sender: TObject);
  private
    { Private declarations }
    Operacoes : TCalc;
    procedure AtualizaResultado();
  public
    { Public declarations }
  end;

var
  FormCalculadora: TFormCalculadora;

implementation

{$R *.dfm}

procedure TFormCalculadora.AtualizaResultado;
begin
   edtResultado.Text := FloatToStr(Operacoes.Resultado);
   LHistorico.Caption := Operacoes.Historico;
end;

procedure TFormCalculadora.btnigualClick(Sender: TObject);
begin
   Operacoes.Calcular();
   Operacoes.LimparHistorico();
   AtualizaResultado();
end;

procedure TFormCalculadora.btnLimparClick(Sender: TObject);
begin
   Operacoes.LimparCalculadora();
   edtResultado.Text := FloatToStr(Operacoes.Resultado);
   edtResultado.Text := Operacoes.Historico;
end;

procedure TFormCalculadora.OperacaoClick(Sender: TObject);
begin
  Operacoes.Operacao := (TButton(Sender).Caption);
  AtualizaResultado();
end;

procedure TFormCalculadora.FormCreate(Sender: TObject);
begin
  Operacoes := TCalc.Create;
end;

procedure TFormCalculadora.FormDestroy(Sender: TObject);
begin
  Operacoes.Free;
end;

procedure TFormCalculadora.ImpostoClick(Sender: TObject);
begin
   Operacoes.CalcularImposto(TButton(Sender).Tag);
   AtualizaResultado();
end;

procedure TFormCalculadora.NumeroClick(Sender: TObject);
begin
  if (Trim(edtResultado.Text) = '0') and (Operacoes.UltimoNum = '') then
    Operacoes.UltimoNum := TButton(Sender).Caption
  else
    Operacoes.UltimoNum := Operacoes.UltimoNum + TButton(Sender).Caption;
  edtResultado.Text := Operacoes.UltimoNum;
end;

end.
