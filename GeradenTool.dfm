object Form3: TForm3
  Left = 260
  Top = 178
  BorderStyle = bsDialog
  Caption = 'Geraden - Werkzeug'
  ClientHeight = 167
  ClientWidth = 444
  Color = clMoneyGreen
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDeactivate = FormDeactivate
  PixelsPerInch = 96
  TextHeight = 13
  object PaintBox3: TPaintBox
    Left = 120
    Top = 72
    Width = 329
    Height = 97
    OnPaint = PaintBox3Paint
  end
  object Label19: TLabel
    Left = 192
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
    Left = 192
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
    Width = 329
    Height = 97
    BevelOuter = bvNone
    TabOrder = 3
    object PaintBox1: TPaintBox
      Left = 0
      Top = 0
      Width = 329
      Height = 97
      Align = alClient
      OnPaint = PaintBox2Paint
    end
    object Label1: TLabel
      Left = 8
      Top = 16
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
    object Label2: TLabel
      Left = 67
      Top = 0
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
      Left = 128
      Top = 0
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
    object Label4: TLabel
      Left = 216
      Top = 0
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
      Left = 280
      Top = 0
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
    object Label6: TLabel
      Left = 156
      Top = 12
      Width = 68
      Height = 59
      Caption = '+l '
      Font.Charset = SYMBOL_CHARSET
      Font.Color = clWindowText
      Font.Height = -48
      Font.Name = 'Symbol'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Edit1: TEdit
      Left = 88
      Top = 8
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
      Left = 88
      Top = 32
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
      Left = 88
      Top = 56
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
      Left = 240
      Top = 8
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
      Left = 240
      Top = 32
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
      Left = 240
      Top = 56
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
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 329
    Height = 97
    BevelOuter = bvNone
    TabOrder = 4
    Visible = False
    object PaintBox2: TPaintBox
      Left = 0
      Top = 0
      Width = 329
      Height = 97
      Align = alClient
      OnPaint = PaintBox2Paint
    end
    object Label7: TLabel
      Left = 0
      Top = 16
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
    object Label8: TLabel
      Left = 75
      Top = 0
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
    object Label9: TLabel
      Left = 136
      Top = 0
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
    object Label10: TLabel
      Left = 240
      Top = 0
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
      Left = 304
      Top = 0
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
      Top = 16
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
    object Edit7: TEdit
      Left = 96
      Top = 8
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
    object Edit8: TEdit
      Left = 96
      Top = 32
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
    object Edit9: TEdit
      Left = 96
      Top = 56
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
    object Edit10: TEdit
      Left = 264
      Top = 8
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
    object Edit11: TEdit
      Left = 264
      Top = 32
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
    object Edit12: TEdit
      Left = 264
      Top = 56
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
    Left = 16
    Top = 112
    Width = 129
    Height = 25
    Caption = '&Zeichnen'
    Default = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
    TabOrder = 0
    OnClick = Button1Click
  end
  object RadioButton1: TRadioButton
    Left = 328
    Top = 16
    Width = 113
    Height = 17
    Caption = 'Punkt-Vektor'
    Checked = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    TabStop = True
    OnClick = RadioButton1Click
  end
  object RadioButton2: TRadioButton
    Left = 328
    Top = 40
    Width = 113
    Height = 17
    Caption = 'Punkt-Punkt'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = RadioButton2Click
  end
  object Button2: TButton
    Left = 16
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
    TabOrder = 6
    OnClick = Button2Click
  end
  object ObjectName: TEdit
    Left = 283
    Top = 112
    Width = 145
    Height = 22
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
  end
  object ColorBox1: TColorBox
    Left = 283
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
    TabOrder = 7
  end
  object ApplicationEvents1: TApplicationEvents
    Left = 400
    Top = 72
  end
end
