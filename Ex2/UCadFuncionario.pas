unit UCadFuncionario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, UFuncionario,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Datasnap.DBClient, UDataModule, UDependente;

type
  TFormCadFuncionario = class(TForm)
    BtnNovo: TButton;
    BtnAlterar: TButton;
    BtnApagar: TButton;
    btnSair: TButton;
    GbFuncionario: TGroupBox;
    PDados: TPanel;
    Lid: TLabel;
    LNome: TLabel;
    LCpf: TLabel;
    LSalario: TLabel;
    edtID: TEdit;
    EdtNome: TEdit;
    edtCpf: TEdit;
    EdtSalario: TEdit;
    btnSalvar: TButton;
    BtnCancelar: TButton;
    GridFuncionario: TDBGrid;
    GbDependente: TGroupBox;
    PDadosDep: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    EdtIDDep: TEdit;
    EdtNomeDep: TEdit;
    btnSalvarDep: TButton;
    BtnCancelarDep: TButton;
    ChkCalculaIR: TCheckBox;
    ChkCalculaINSS: TCheckBox;
    GridDependente: TDBGrid;
    BtnApagarDep: TButton;
    BtnAlterarDep: TButton;
    BtnNovoDep: TButton;
    btnCalculaImpostos: TButton;
    procedure btnSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtnNovoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure BtnAlterarClick(Sender: TObject);
    procedure BtnApagarClick(Sender: TObject);
    procedure DataChangeFunc(Sender: TObject; Field: TField);
    procedure DataChangeDep(Sender: TObject; Field: TField);
    procedure BtnNovoDepClick(Sender: TObject);
    procedure BtnAlterarDepClick(Sender: TObject);
    procedure BtnApagarDepClick(Sender: TObject);
    procedure btnSalvarDepClick(Sender: TObject);
    procedure BtnCancelarDepClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure btnCalculaImpostosClick(Sender: TObject);
  private
    { Private declarations }
    Func : TFuncionario;
    Dep  : TDependente;
    AcaoFunc : Char;
    AcaoDep  : Char;
    procedure LimparCamposFunc;
    procedure LimparCamposDep;
    procedure HabilitaBotoesFunc(Hab: Boolean);
    procedure HabilitaBotoesDep(Hab: Boolean);
    procedure PreencherDadosFunc;
    procedure PreencherDadosDep;
    procedure RecuperaDadosFunc;
    procedure RecuperaDadosDep;
    procedure AtualizarDep(IdFuncionario:Integer);
  public
    { Public declarations }
  end;

var
  FormCadFuncionario: TFormCadFuncionario;

implementation

{$R *.dfm}

procedure TFormCadFuncionario.AtualizarDep(IdFuncionario: Integer);
begin
   dep.consultar(IdFuncionario);
end;

procedure TFormCadFuncionario.BtnAlterarClick(Sender: TObject);
begin
   if (GridFuncionario.DataSource.DataSet.FieldByName('ID').AsInteger > 0) then
   begin
     LimparCamposFunc;
     HabilitaBotoesFunc(True);
     AcaoFunc := 'A';
     RecuperaDadosFunc;
   end;
end;

procedure TFormCadFuncionario.BtnAlterarDepClick(Sender: TObject);
begin
   if (GridDependente.DataSource.DataSet.FieldByName('ID').AsInteger > 0) then
   begin
     LimparCamposDep;
     HabilitaBotoesDep(True);
     AcaoDep := 'A';
     RecuperaDadosDep;
   end;
end;

procedure TFormCadFuncionario.BtnApagarClick(Sender: TObject);
begin
   if MessageDlg('Confirma a exclusão do Funcionário ' + EdtNome.Text, mtConfirmation, [mbYes,mbNo],0) = mrYes then
   begin
     AcaoFunc := 'E';
     btnSalvarClick(Self);
   end;
end;

procedure TFormCadFuncionario.BtnApagarDepClick(Sender: TObject);
begin
   if MessageDlg('Confirma a exclusão do Dependente ' + EdtNomeDep.Text, mtConfirmation, [mbYes,mbNo],0) = mrYes then
   begin
     AcaoDep := 'E';
     btnSalvarDepClick(Self);
   end;
end;

procedure TFormCadFuncionario.btnCalculaImpostosClick(Sender: TObject);
var mensagem : String;
begin
  PreencherDadosFunc;
  mensagem := EmptyStr;
  mensagem := 'O valor calculado de INSS é ' + FormatFloat(',0.00',Func.CalculaINSS(Func.ID)) + ', e ' + FormatFloat(',0.00',Func.CalculaIR(Func.ID)) + ' de IR';
  ShowMessage(mensagem);
end;

procedure TFormCadFuncionario.BtnCancelarClick(Sender: TObject);
begin
  if AcaoFunc = 'A' then
  begin
    RecuperaDadosFunc;
    LimparCamposDep;
    if (GridFuncionario.DataSource.DataSet.FieldByName('ID').AsInteger > 0) then
      Dep.consultar(StrToInt(GridFuncionario.Columns[0].Field.Value));
  end;
  AcaoFunc := 'C';
  HabilitaBotoesFunc(False);
end;

procedure TFormCadFuncionario.BtnCancelarDepClick(Sender: TObject);
begin
  if AcaoDep = 'A' then
    RecuperaDadosDep;
  AcaoDep := 'C';
  HabilitaBotoesDep(False);
end;

procedure TFormCadFuncionario.BtnNovoClick(Sender: TObject);
begin
   LimparCamposFunc;
   HabilitaBotoesFunc(True);
   AcaoFunc := 'I';
   EdtNome.SetFocus;
end;

procedure TFormCadFuncionario.BtnNovoDepClick(Sender: TObject);
begin
   LimparCamposDep;
   HabilitaBotoesDep(True);
   AcaoDep := 'I';
   EdtNomeDep.SetFocus;
end;

procedure TFormCadFuncionario.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFormCadFuncionario.btnSalvarClick(Sender: TObject);
begin
  PreencherDadosFunc;
  case AcaoFunc of
    'I': Func.Incluir;
    'A': Func.Alterar;
    'E': Func.Exluir;
  end;
  AcaoFunc := 'C';
  HabilitaBotoesFunc(False);
  Func.consultar;
end;

procedure TFormCadFuncionario.btnSalvarDepClick(Sender: TObject);
begin
  PreencherDadosDep;
  case AcaoDep of
    'I': Dep.Incluir(StrToInt(edtID.Text));
    'A': Dep.Alterar;
    'E': Dep.Exluir;
  end;
  AcaoDep := 'C';
  HabilitaBotoesDep(False);
  Dep.consultar(StrToInt(edtID.Text));
end;

procedure TFormCadFuncionario.FormCreate(Sender: TObject);
begin
  Func := TFuncionario.Create;
  GridFuncionario.DataSource := Func.dsMemFuncionarios;
  Func.consultar;
  Dep := TDependente.Create;
  GridDependente.DataSource := Dep.dsMemDependentes;
  Func.dsMemFuncionarios.OnDataChange := DataChangeFunc;
  if not Func.MemFuncionarios.IsEmpty then
    Func.dsMemFuncionarios.DataSet.First;
  if (GridFuncionario.DataSource.DataSet.FieldByName('ID').AsInteger > 0) then
    Dep.consultar(StrToInt(GridFuncionario.Columns[0].Field.Value));
  Dep.dsMemDependentes.OnDataChange := DataChangeDep;
  if not Dep.MemDependentes.IsEmpty then
    Dep.dsMemDependentes.DataSet.First;
end;

procedure TFormCadFuncionario.FormDestroy(Sender: TObject);
begin
  Func.Free;
end;

procedure TFormCadFuncionario.HabilitaBotoesDep(Hab: Boolean);
begin
   PDadosDep.Enabled      := Hab;
   BtnNovoDep.Enabled     := not Hab;
   BtnAlterarDep.Enabled  := not Hab;
   BtnApagarDep.Enabled   := not Hab;
   btnSalvarDep.Enabled   := Hab;
   BtnCancelarDep.Enabled := Hab;
end;

procedure TFormCadFuncionario.HabilitaBotoesFunc(Hab: Boolean);
begin
   PDados.Enabled      := Hab;
   BtnNovo.Enabled     := not Hab;
   BtnAlterar.Enabled  := not Hab;
   BtnApagar.Enabled   := not Hab;
   btnSalvar.Enabled   := Hab;
   BtnCancelar.Enabled := Hab;
end;

procedure TFormCadFuncionario.LimparCamposDep;
begin
   EdtIDDep.Text          := EmptyStr;
   EdtNomeDep.Text        := EmptyStr;
   ChkCalculaIR.Checked   := False;
   ChkCalculaINSS.Checked := False;
end;

procedure TFormCadFuncionario.LimparCamposFunc;
begin
   edtID.Text      := EmptyStr;
   EdtNome.Text    := EmptyStr;
   edtCpf.Text     := EmptyStr;
   EdtSalario.Text := EmptyStr;
end;

procedure TFormCadFuncionario.PreencherDadosFunc;
begin
  if edtID.Text <> EmptyStr then
    Func.ID := StrToInt(edtID.Text);
  Func.Nome := EdtNome.Text;
  Func.CPF := edtCpf.Text;
  Func.Salario := StrToFloat(EdtSalario.Text);
end;

procedure TFormCadFuncionario.PreencherDadosDep;
begin
  if EdtIDDep.Text <> EmptyStr then
    Dep.ID := StrToInt(EdtIDDep.Text);
  Dep.Nome := EdtNomeDep.Text;
  if ChkCalculaIR.Checked then
    Dep.IsCalculaIR := 1
  else
    Dep.IsCalculaIR := 0;
  if ChkCalculaINSS.Checked then
    Dep.IsCalculaINSS := 1
  else
    Dep.IsCalculaINSS := 0;
end;

procedure TFormCadFuncionario.RecuperaDadosDep;
begin
  LimparCamposDep;
  if not Func.MemFuncionarios.IsEmpty then
  begin
    EdtIDDep.Text := GridDependente.Columns[0].Field.Text;
    EdtNomeDep.Text := GridDependente.Columns[1].Field.Text;
    ChkCalculaIR.Checked := GridDependente.Columns[2].Field.Value = 'Sim';
    ChkCalculaINSS.Checked := GridDependente.Columns[3].Field.Value = 'Sim';
  end;
end;

procedure TFormCadFuncionario.RecuperaDadosFunc;
begin
  LimparCamposFunc;
  if not Func.MemFuncionarios.IsEmpty then
  begin
    edtID.Text := GridFuncionario.Columns[0].Field.Text;
    EdtNome.Text := GridFuncionario.Columns[1].Field.Text;
    edtCpf.Text := GridFuncionario.Columns[2].Field.Text;
    EdtSalario.Text := GridFuncionario.Columns[3].Field.Text;
  end;
end;

procedure TFormCadFuncionario.DataChangeFunc(Sender: TObject; Field: TField);
begin
  RecuperaDadosFunc;
  LimparCamposDep;
  if (GridFuncionario.DataSource.DataSet.FieldByName('ID').AsInteger > 0) then
    Dep.consultar(StrToInt(GridFuncionario.Columns[0].Field.Value));
end;

procedure TFormCadFuncionario.DataChangeDep(Sender: TObject; Field: TField);
begin
  RecuperaDadosDep;
end;

end.
