object FormCalculadora: TFormCalculadora
  Left = 0
  Top = 0
  Caption = 'Calculadora'
  ClientHeight = 277
  ClientWidth = 311
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
  object LHistorico: TLabel
    Left = 16
    Top = 8
    Width = 287
    Height = 25
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object edtResultado: TEdit
    Left = 16
    Top = 36
    Width = 283
    Height = 33
    Alignment = taRightJustify
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    Text = '0'
  end
  object btnsoma: TButton
    Left = 259
    Top = 148
    Width = 40
    Height = 25
    Caption = '+'
    TabOrder = 1
    OnClick = OperacaoClick
  end
  object btnsubtrair: TButton
    Left = 259
    Top = 118
    Width = 40
    Height = 25
    Caption = '-'
    TabOrder = 2
    OnClick = OperacaoClick
  end
  object btndividir: TButton
    Left = 259
    Top = 210
    Width = 40
    Height = 25
    Caption = '/'
    TabOrder = 3
    OnClick = OperacaoClick
  end
  object btnMultiplicar: TButton
    Left = 259
    Top = 179
    Width = 40
    Height = 25
    Caption = 'x'
    TabOrder = 4
    OnClick = OperacaoClick
  end
  object btnigual: TButton
    Left = 16
    Top = 241
    Width = 283
    Height = 24
    Caption = '='
    TabOrder = 5
    OnClick = btnigualClick
  end
  object btn1: TButton
    Left = 16
    Top = 179
    Width = 75
    Height = 25
    Caption = '1'
    TabOrder = 6
    OnClick = NumeroClick
  end
  object btn0: TButton
    Left = 97
    Top = 210
    Width = 75
    Height = 25
    Caption = '0'
    TabOrder = 7
    OnClick = NumeroClick
  end
  object btn2: TButton
    Left = 97
    Top = 179
    Width = 75
    Height = 25
    Caption = '2'
    TabOrder = 8
    OnClick = NumeroClick
  end
  object btnLimpar: TButton
    Left = 16
    Top = 210
    Width = 75
    Height = 25
    Caption = 'Limpar'
    TabOrder = 9
    OnClick = btnLimparClick
  end
  object btn3: TButton
    Left = 178
    Top = 179
    Width = 75
    Height = 25
    Caption = '3'
    TabOrder = 10
    OnClick = NumeroClick
  end
  object btn4: TButton
    Left = 16
    Top = 148
    Width = 75
    Height = 25
    Caption = '4'
    TabOrder = 11
    OnClick = NumeroClick
  end
  object btn5: TButton
    Left = 97
    Top = 148
    Width = 75
    Height = 25
    Caption = '5'
    TabOrder = 12
    OnClick = NumeroClick
  end
  object btn6: TButton
    Left = 178
    Top = 148
    Width = 75
    Height = 25
    Caption = '6'
    TabOrder = 13
    OnClick = NumeroClick
  end
  object btn7: TButton
    Left = 16
    Top = 117
    Width = 75
    Height = 25
    Caption = '7'
    TabOrder = 14
    OnClick = NumeroClick
  end
  object btn8: TButton
    Left = 97
    Top = 117
    Width = 75
    Height = 25
    Caption = '8'
    TabOrder = 15
    OnClick = NumeroClick
  end
  object btn9: TButton
    Left = 178
    Top = 117
    Width = 75
    Height = 25
    Caption = '9'
    TabOrder = 16
    OnClick = NumeroClick
  end
  object btnVirgula: TButton
    Left = 178
    Top = 210
    Width = 75
    Height = 25
    Caption = ','
    TabOrder = 17
    OnClick = NumeroClick
  end
  object btnImpostoA: TButton
    Left = 16
    Top = 86
    Width = 75
    Height = 25
    Caption = 'Imposto A'
    TabOrder = 18
    OnClick = ImpostoClick
  end
  object btnImpostoB: TButton
    Tag = 1
    Left = 97
    Top = 86
    Width = 75
    Height = 25
    Caption = 'Imposto B'
    TabOrder = 19
    OnClick = ImpostoClick
  end
  object btnImpostoC: TButton
    Tag = 2
    Left = 178
    Top = 86
    Width = 75
    Height = 25
    Caption = 'Imposto C'
    TabOrder = 20
    OnClick = ImpostoClick
  end
end
