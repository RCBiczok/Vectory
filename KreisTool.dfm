object KreisForm: TKreisForm
  Left = 295
  Top = 216
  BorderStyle = bsDialog
  Caption = 'Kreis-Werkzeug'
  ClientHeight = 161
  ClientWidth = 517
  Color = clMoneyGreen
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDeactivate = FormDeactivate
  PixelsPerInch = 96
  TextHeight = 13
  object PaintBox2: TPaintBox
    Left = 256
    Top = 87
    Width = 261
    Height = 73
    OnPaint = PaintBox2Paint
  end
  object Label19: TLabel
    Left = 284
    Top = 106
    Width = 73
    Height = 15
    Caption = 'Bezeichnung'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
    Transparent = True
  end
  object Farbe: TLabel
    Left = 284
    Top = 131
    Width = 33
    Height = 15
    Caption = 'Farbe'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
    Transparent = True
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 465
    Height = 97
    BevelOuter = bvNone
    Color = clMoneyGreen
    TabOrder = 0
    object PaintBox1: TPaintBox
      Left = 0
      Top = 0
      Width = 465
      Height = 97
      Align = alClient
      OnPaint = PaintBox4Paint
    end
    object Label2: TLabel
      Left = 91
      Top = 8
      Width = 22
      Height = 75
      Caption = '('
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -67
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label3: TLabel
      Left = 152
      Top = 8
      Width = 22
      Height = 75
      Caption = ')'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -67
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label1: TLabel
      Left = 8
      Top = 24
      Width = 67
      Height = 57
      Caption = 'M='
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -48
      Font.Name = 'Monotype Corsiva'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      Transparent = True
    end
    object Label4: TLabel
      Left = 357
      Top = 20
      Width = 53
      Height = 57
      Caption = 'r ='
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -48
      Font.Name = 'Monotype Corsiva'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      Transparent = True
    end
    object Label5: TLabel
      Left = 198
      Top = 20
      Width = 61
      Height = 57
      Caption = 'n ='
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -48
      Font.Name = 'Monotype Corsiva'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      Transparent = True
    end
    object Label6: TLabel
      Left = 264
      Top = 7
      Width = 22
      Height = 75
      Caption = '('
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -67
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label7: TLabel
      Left = 325
      Top = 7
      Width = 22
      Height = 75
      Caption = ')'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -67
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label21: TLabel
      Left = 176
      Top = 27
      Width = 10
      Height = 39
      Caption = ';'
      Font.Charset = SYMBOL_CHARSET
      Font.Color = clWindowText
      Font.Height = -32
      Font.Name = 'Symbol'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label8: TLabel
      Left = 347
      Top = 27
      Width = 10
      Height = 39
      Caption = ';'
      Font.Charset = SYMBOL_CHARSET
      Font.Color = clWindowText
      Font.Height = -32
      Font.Name = 'Symbol'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Edit1: TEdit
      Left = 112
      Top = 16
      Width = 40
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object Edit2: TEdit
      Left = 112
      Top = 40
      Width = 40
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
    object Edit3: TEdit
      Left = 112
      Top = 64
      Width = 40
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
    end
    object Edit7: TEdit
      Left = 420
      Top = 40
      Width = 40
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
    end
    object Edit4: TEdit
      Left = 285
      Top = 15
      Width = 40
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
    end
    object Edit5: TEdit
      Left = 285
      Top = 39
      Width = 40
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
    end
    object Edit6: TEdit
      Left = 285
      Top = 63
      Width = 40
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
    end
  end
  object Button1: TButton
    Left = 8
    Top = 104
    Width = 129
    Height = 25
    Caption = 'Zeichnen'
    Default = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 128
    Width = 129
    Height = 25
    Caption = '&Abbrechen'
    Default = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
    TabOrder = 2
    OnClick = Button2Click
  end
  object ObjectName: TEdit
    Left = 368
    Top = 103
    Width = 145
    Height = 22
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
  end
  object ColorBox1: TColorBox
    Left = 368
    Top = 127
    Width = 145
    Height = 22
    Style = [cbStandardColors, cbExtendedColors, cbCustomColor]
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ItemHeight = 16
    ParentFont = False
    TabOrder = 4
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 465
    Height = 97
    BevelOuter = bvNone
    Color = clMoneyGreen
    TabOrder = 5
    Visible = False
    object PaintBox3: TPaintBox
      Left = 0
      Top = 0
      Width = 465
      Height = 97
      Align = alClient
      OnPaint = PaintBox4Paint
    end
    object Label9: TLabel
      Left = 67
      Top = 8
      Width = 22
      Height = 75
      Caption = '('
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -67
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label10: TLabel
      Left = 128
      Top = 8
      Width = 22
      Height = 75
      Caption = ')'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -67
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label11: TLabel
      Left = 0
      Top = 24
      Width = 67
      Height = 57
      Caption = 'M='
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -48
      Font.Name = 'Monotype Corsiva'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      Transparent = True
    end
    object Label13: TLabel
      Left = 151
      Top = 22
      Width = 75
      Height = 57
      Caption = 'P1='
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -48
      Font.Name = 'Monotype Corsiva'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      Transparent = True
    end
    object Label14: TLabel
      Left = 224
      Top = 7
      Width = 22
      Height = 75
      Caption = '('
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -67
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label15: TLabel
      Left = 285
      Top = 7
      Width = 22
      Height = 75
      Caption = ')'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -67
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label16: TLabel
      Left = 145
      Top = 27
      Width = 10
      Height = 39
      Caption = ';'
      Font.Charset = SYMBOL_CHARSET
      Font.Color = clWindowText
      Font.Height = -32
      Font.Name = 'Symbol'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label17: TLabel
      Left = 303
      Top = 27
      Width = 10
      Height = 39
      Caption = ';'
      Font.Charset = SYMBOL_CHARSET
      Font.Color = clWindowText
      Font.Height = -32
      Font.Name = 'Symbol'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label12: TLabel
      Left = 311
      Top = 22
      Width = 75
      Height = 57
      Caption = 'P2='
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -48
      Font.Name = 'Monotype Corsiva'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      Transparent = True
    end
    object Label18: TLabel
      Left = 384
      Top = 7
      Width = 22
      Height = 75
      Caption = '('
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -67
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label20: TLabel
      Left = 445
      Top = 7
      Width = 22
      Height = 75
      Caption = ')'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -67
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Edit8: TEdit
      Left = 88
      Top = 16
      Width = 40
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object Edit9: TEdit
      Left = 88
      Top = 40
      Width = 40
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
    object Edit10: TEdit
      Left = 88
      Top = 64
      Width = 40
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
    end
    object Edit12: TEdit
      Left = 245
      Top = 39
      Width = 40
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
    end
    object Edit13: TEdit
      Left = 245
      Top = 63
      Width = 40
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
    end
    object Edit14: TEdit
      Left = 405
      Top = 15
      Width = 40
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
    end
    object Edit11: TEdit
      Left = 245
      Top = 15
      Width = 40
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
    end
    object Edit15: TEdit
      Left = 405
      Top = 39
      Width = 40
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 7
    end
    object Edit16: TEdit
      Left = 405
      Top = 63
      Width = 40
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 8
    end
  end
  object ApplicationEvents1: TApplicationEvents
    Left = 208
    Top = 104
  end
end
