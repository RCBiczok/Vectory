object Form2: TForm2
  Left = 257
  Top = 237
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Ebenen - Werkzeug'
  ClientHeight = 167
  ClientWidth = 558
  Color = clMoneyGreen
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Arial'
  Font.Style = [fsBold, fsItalic]
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDeactivate = FormDeactivate
  PixelsPerInch = 96
  TextHeight = 17
  object PaintBox2: TPaintBox
    Left = 248
    Top = 96
    Width = 310
    Height = 71
    OnPaint = PaintBox2Paint
  end
  object Label19: TLabel
    Left = 272
    Top = 115
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
    Left = 272
    Top = 140
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
    Width = 409
    Height = 105
    BevelOuter = bvNone
    Color = clMoneyGreen
    TabOrder = 0
    object PaintBox1: TPaintBox
      Left = 0
      Top = 0
      Width = 409
      Height = 105
      Align = alClient
      OnPaint = PaintBox1Paint
    end
    object Label1: TLabel
      Left = 64
      Top = 37
      Width = 63
      Height = 39
      Caption = 'x1 + '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -32
      Font.Name = 'Monotype Corsiva'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      Transparent = True
    end
    object Label2: TLabel
      Left = 160
      Top = 37
      Width = 55
      Height = 39
      Caption = 'x2 +'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -32
      Font.Name = 'Monotype Corsiva'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      Transparent = True
    end
    object Label3: TLabel
      Left = 259
      Top = 37
      Width = 55
      Height = 39
      Caption = 'x3 +'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -32
      Font.Name = 'Monotype Corsiva'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      Transparent = True
    end
    object Label4: TLabel
      Left = 360
      Top = 37
      Width = 41
      Height = 39
      Caption = '=0 '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -32
      Font.Name = 'Monotype Corsiva'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      Transparent = True
    end
    object Edit1: TEdit
      Left = 24
      Top = 48
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
      Left = 120
      Top = 48
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
      Left = 216
      Top = 48
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
    object Edit4: TEdit
      Left = 320
      Top = 48
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
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 409
    Height = 105
    BevelOuter = bvNone
    Color = clMoneyGreen
    TabOrder = 1
    Visible = False
    object PaintBox4: TPaintBox
      Left = 0
      Top = 0
      Width = 409
      Height = 105
      Align = alClient
      OnPaint = PaintBox1Paint
    end
    object Label10: TLabel
      Left = 24
      Top = 19
      Width = 54
      Height = 57
      Caption = 'X='
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -48
      Font.Name = 'Monotype Corsiva'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      Transparent = True
    end
    object Label9: TLabel
      Left = 144
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
    object Label8: TLabel
      Left = 83
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
    object Label5: TLabel
      Left = 203
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
    object Label6: TLabel
      Left = 264
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
    object Label7: TLabel
      Left = 323
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
    object Label11: TLabel
      Left = 384
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
    object Label12: TLabel
      Left = 168
      Top = 27
      Width = 38
      Height = 39
      Caption = '+l'
      Font.Charset = SYMBOL_CHARSET
      Font.Color = clWindowText
      Font.Height = -32
      Font.Name = 'Symbol'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label13: TLabel
      Left = 288
      Top = 27
      Width = 39
      Height = 39
      Caption = '+m'
      Font.Charset = SYMBOL_CHARSET
      Font.Color = clWindowText
      Font.Height = -32
      Font.Name = 'Symbol'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Edit5: TEdit
      Left = 104
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
    object Edit6: TEdit
      Left = 104
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
    object Edit7: TEdit
      Left = 104
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
    object Edit8: TEdit
      Left = 224
      Top = 16
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
    object Edit9: TEdit
      Left = 224
      Top = 40
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
    object Edit10: TEdit
      Left = 224
      Top = 64
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
    object Edit11: TEdit
      Left = 344
      Top = 16
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
    object Edit12: TEdit
      Left = 344
      Top = 40
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
    object Edit13: TEdit
      Left = 344
      Top = 64
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
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 409
    Height = 105
    BevelOuter = bvNone
    Color = clMoneyGreen
    TabOrder = 2
    Visible = False
    object PaintBox3: TPaintBox
      Left = 0
      Top = 0
      Width = 409
      Height = 105
      Align = alClient
      OnPaint = PaintBox1Paint
    end
    object Label14: TLabel
      Left = 48
      Top = 19
      Width = 65
      Height = 57
      Caption = 'P ='
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -48
      Font.Name = 'Monotype Corsiva'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      Transparent = True
    end
    object Label15: TLabel
      Left = 176
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
    object Label16: TLabel
      Left = 115
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
    object Label17: TLabel
      Left = 307
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
    object Label18: TLabel
      Left = 368
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
    object Label21: TLabel
      Left = 200
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
    object Label22: TLabel
      Left = 240
      Top = 19
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
    object Edit14: TEdit
      Left = 136
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
    object Edit15: TEdit
      Left = 136
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
    object Edit16: TEdit
      Left = 136
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
    object Edit17: TEdit
      Left = 328
      Top = 16
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
    object Edit18: TEdit
      Left = 328
      Top = 40
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
    object Edit19: TEdit
      Left = 328
      Top = 64
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
  object RadioButton1: TRadioButton
    Left = 416
    Top = 24
    Width = 139
    Height = 17
    Caption = 'Parameterform'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = RadioButton1Click
  end
  object RadioButton2: TRadioButton
    Left = 416
    Top = 48
    Width = 139
    Height = 17
    Caption = 'Koordinatengleichung'
    Checked = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    TabStop = True
    OnClick = RadioButton2Click
  end
  object RadioButton3: TRadioButton
    Left = 416
    Top = 72
    Width = 139
    Height = 17
    Caption = 'Punkt-Normale'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    OnClick = RadioButton3Click
  end
  object Button1: TButton
    Left = 32
    Top = 112
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
    TabOrder = 7
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 32
    Top = 136
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
    TabOrder = 8
    OnClick = Button2Click
  end
  object ObjectName: TEdit
    Left = 376
    Top = 112
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
    Left = 376
    Top = 136
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
    TabOrder = 9
  end
  object ApplicationEvents1: TApplicationEvents
    Left = 528
    Top = 104
  end
end
