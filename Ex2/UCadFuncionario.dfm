object FormCadFuncionario: TFormCadFuncionario
  Left = 0
  Top = 0
  Caption = 'Cadastro de Funcion'#225'rios'
  ClientHeight = 437
  ClientWidth = 702
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object BtnNovo: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Novo'
    TabOrder = 0
    OnClick = BtnNovoClick
  end
  object BtnAlterar: TButton
    Left = 89
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Alterar'
    TabOrder = 1
    OnClick = BtnAlterarClick
  end
  object BtnApagar: TButton
    Left = 170
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Apagar'
    TabOrder = 2
    OnClick = BtnApagarClick
  end
  object btnSair: TButton
    Left = 606
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Sair'
    TabOrder = 3
    OnClick = btnSairClick
  end
  object GbFuncionario: TGroupBox
    Left = 8
    Top = 39
    Width = 689
    Height = 394
    Caption = 'Funcion'#225'rio'
    TabOrder = 4
    object PDados: TPanel
      Left = 8
      Top = 17
      Width = 673
      Height = 50
      Enabled = False
      TabOrder = 0
      object Lid: TLabel
        Left = 8
        Top = 4
        Width = 10
        Height = 13
        Caption = 'Id'
      end
      object LNome: TLabel
        Left = 77
        Top = 4
        Width = 27
        Height = 13
        Caption = 'Nome'
      end
      object LCpf: TLabel
        Left = 297
        Top = 4
        Width = 19
        Height = 13
        Caption = 'CPF'
      end
      object LSalario: TLabel
        Left = 403
        Top = 4
        Width = 32
        Height = 13
        Caption = 'Sal'#225'rio'
      end
      object edtID: TEdit
        Left = 8
        Top = 23
        Width = 59
        Height = 21
        Enabled = False
        TabOrder = 0
      end
      object EdtNome: TEdit
        Left = 77
        Top = 23
        Width = 208
        Height = 21
        TabOrder = 1
      end
      object edtCpf: TEdit
        Left = 297
        Top = 23
        Width = 95
        Height = 21
        TabOrder = 2
      end
      object EdtSalario: TEdit
        Left = 403
        Top = 23
        Width = 95
        Height = 21
        TabOrder = 3
      end
      object btnSalvar: TButton
        Left = 507
        Top = 19
        Width = 75
        Height = 25
        Caption = 'Salvar'
        Enabled = False
        TabOrder = 4
        OnClick = btnSalvarClick
      end
      object BtnCancelar: TButton
        Left = 588
        Top = 19
        Width = 75
        Height = 25
        Caption = 'Cancelar'
        Enabled = False
        TabOrder = 5
        OnClick = BtnCancelarClick
      end
    end
    object GridFuncionario: TDBGrid
      Left = 8
      Top = 66
      Width = 673
      Height = 120
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'ID'
          Title.Caption = 'C'#243'digo'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NOME'
          Title.Caption = 'Nome'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CPF'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SALARIO'
          Title.Caption = 'Sal'#225'rio'
          Visible = True
        end>
    end
    object GbDependente: TGroupBox
      Left = 8
      Top = 190
      Width = 672
      Height = 195
      Caption = 'Dependente'
      TabOrder = 2
      object PDadosDep: TPanel
        Left = 3
        Top = 48
        Width = 558
        Height = 50
        Enabled = False
        TabOrder = 0
        object Label2: TLabel
          Left = 77
          Top = 4
          Width = 27
          Height = 13
          Caption = 'Nome'
        end
        object Label1: TLabel
          Left = 8
          Top = 4
          Width = 10
          Height = 13
          Caption = 'Id'
        end
        object EdtIDDep: TEdit
          Left = 8
          Top = 23
          Width = 59
          Height = 21
          Enabled = False
          TabOrder = 0
        end
        object EdtNomeDep: TEdit
          Left = 77
          Top = 23
          Width = 208
          Height = 21
          TabOrder = 1
        end
        object btnSalvarDep: TButton
          Left = 395
          Top = 19
          Width = 75
          Height = 25
          Caption = 'Salvar'
          Enabled = False
          TabOrder = 2
          OnClick = btnSalvarDepClick
        end
        object BtnCancelarDep: TButton
          Left = 476
          Top = 19
          Width = 75
          Height = 25
          Caption = 'Cancelar'
          Enabled = False
          TabOrder = 3
          OnClick = BtnCancelarDepClick
        end
        object ChkCalculaIR: TCheckBox
          Left = 296
          Top = 12
          Width = 73
          Height = 17
          Caption = 'Calcular IR'
          TabOrder = 4
        end
        object ChkCalculaINSS: TCheckBox
          Left = 296
          Top = 28
          Width = 82
          Height = 17
          Caption = 'Calcular INSS'
          TabOrder = 5
        end
      end
      object GridDependente: TDBGrid
        Left = 3
        Top = 105
        Width = 558
        Height = 83
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
      object BtnApagarDep: TButton
        Left = 165
        Top = 16
        Width = 75
        Height = 25
        Caption = 'Apagar'
        TabOrder = 2
        OnClick = BtnApagarDepClick
      end
      object BtnAlterarDep: TButton
        Left = 84
        Top = 16
        Width = 75
        Height = 25
        Caption = 'Alterar'
        TabOrder = 3
        OnClick = BtnAlterarDepClick
      end
      object BtnNovoDep: TButton
        Left = 3
        Top = 16
        Width = 75
        Height = 25
        Caption = 'Novo'
        TabOrder = 4
        OnClick = BtnNovoDepClick
      end
    end
  end
  object btnCalculaImpostos: TButton
    Left = 274
    Top = 8
    Width = 103
    Height = 25
    Caption = 'Calcular Impostos'
    TabOrder = 5
    OnClick = btnCalculaImpostosClick
  end
end
