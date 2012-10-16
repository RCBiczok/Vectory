object Form1: TForm1
  Left = 192
  Top = 107
  Width = 783
  Height = 540
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object GLSceneViewer1: TGLSceneViewer
    Left = 88
    Top = 48
    Width = 609
    Height = 425
    Camera = Cam
    OnMouseDown = GLSceneViewer1MouseDown
    OnMouseMove = GLSceneViewer1MouseMove
  end
  object GLScene1: TGLScene
    Left = 24
    Top = 48
    object Punkt: TSphere
      Material.FrontProperties.Diffuse.Color = {0000803F000000000000803F0000803F}
      Radius = 0.100000001490116
    end
    object Target: TDummyCube
      CubeSize = 1
    end
    object Lines1: TLines
      LineColor.Color = {000000000000803F000000000000803F}
      Nodes = <
        item
          X = -5
        end
        item
          X = 5
        end>
      NodesAspect = lnaInvisible
      Options = []
    end
    object Lines2: TLines
      LineColor.Color = {0000803F00000000000000000000803F}
      Nodes = <
        item
          Y = -5
        end
        item
          Y = 5
        end>
      NodeColor.Color = {0000803F00000000000000000000803F}
      NodesAspect = lnaInvisible
      Options = []
    end
    object Lines3: TLines
      LineColor.Color = {00000000000000000000803F0000803F}
      Nodes = <
        item
          Z = -5
        end
        item
          Z = 5
        end>
      NodeColor.Color = {000000000000803F000000000000803F}
      NodesAspect = lnaInvisible
      Options = []
    end
    object Cam: TGLCamera
      DepthOfView = 100
      FocalLength = 50
      TargetObject = Target
      Position.Coordinates = {00000000000000000000A0400000803F}
      object GLLightSource1: TGLLightSource
        ConstAttenuation = 1
        SpotCutOff = 180
      end
    end
  end
end
