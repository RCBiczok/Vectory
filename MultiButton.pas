unit MultiButton;

interface

uses
  Windows, SysUtils, Classes, Controls, ExtCtrls, Buttons, Messages, Graphics,
  ComCtrls, ToolWin;

const
  ANIMSPEED = 15;
  TIMER_TIME = 10;
  TIMER_DELAY = 500;

type
  TAnimStatus = (Inactive, ScrollDown, ScrollUp);

  TMultiButton = class(TToolBar)
  private
    FButtons: TList;

    FFirstButtonCanvas: TControlCanvas;

    FDefaultButton: cardinal;

    FAnimStatus: TAnimStatus;
    FMouseIn: Boolean;
    FPrevMouseIn: Boolean;

    FClickList: TList;
    FTimer: TTimer;
    FTriangleTimer: TTimer;

    procedure CMMouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;

    procedure TimerProc(Sender: TObject);
    procedure TriangleTimerProc(Sender: TObject);
  protected
    procedure Loaded; override;
    procedure DoClick(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
  published
    property DefaultButton: cardinal read FDefaultButton write FDefaultButton;
  end;

procedure Register;

implementation

//==================================\\
//========== TMultiButton ==========\\
//==================================\\

constructor TMultiButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  EdgeInner:= esNone;
  EdgeOuter:= esNone;
  Align:= alNone;
  Flat:= True;

  FClickList:= TList.Create;
  FTimer:= TTimer.Create(Self);
  if(csDesigning in ComponentState) then
    FTimer.Enabled:= False
  else
    FTimer.Enabled:= True;

  FTimer.OnTimer:= TimerProc;

  FTriangleTimer:= TTimer.Create(Self);
  FTriangleTimer.Interval:= 10;
  if(csDesigning in ComponentState) then
    FTriangleTimer.Enabled:= False
  else
    FTriangleTimer.Enabled:= True;
  FTriangleTimer.OnTimer:= TriangleTimerProc;
end;

procedure TMultiButton.CMMouseEnter(var Msg: TMessage);
begin
//  Height:= FButtonHeight * FButtonCount;
//  FAnimStatus:= ScrollDown;
//  SetTimer(Handle, 1, TIMER_DELAY, @FTimerProc);
//  FTimer.Interval:= TIMER_DELAY;
//  FTimer.Enabled:= True;
end;

procedure TMultiButton.CMMouseLeave(var Msg: TMessage);
begin
//  Height:= FButtonHeight;
//  FAnimStatus:= ScrollUp;
//  SetTimer(Handle, 1, TIMER_TIME, @FTimerProc);
//  FTimer.Interval:= TIMER_TIME;
//  FTimer.Enabled:= True;
end;

procedure TMultiButton.TriangleTimerProc(Sender: TObject);
var
  i: integer;
begin
  // Draw the small triangle on the first Button
  If Assigned(FFirstButtonCanvas) then
    With FFirstButtonCanvas do begin
      Pen.Color:= clBlue;
      for i:=0 to 7 do begin
        MoveTo(ButtonWidth - 16 + i div 2, ButtonHeight - 10 + i);
        LineTo(ButtonWidth - 8 - i div 2, ButtonHeight - 10 + i);
      end;
    end;
end;

procedure TMultiButton.TimerProc(Sender: TObject);
var
  p: TPoint;
begin
//  KillTimer(Handle, idEvent);
//  FTimer.Enabled:= False;

  begin
    GetCursorPos(p);
    p:= ScreenToClient(p);
    If (p.X < 0) or (p.X > Width) or
       (p.Y < 0) or (p.Y > Height) then
      FMouseIn:= False
    else
      FMouseIn:= True;

    If not FMouseIn and (FAnimStatus = ScrollDown) and
      (Height = ButtonHeight) then begin
      FAnimStatus:= InActive;
      Exit;
    end;
    If FMouseIn and (Height < ButtonHeight * ButtonCount) and
       (FAnimStatus <> ScrollDown) then begin
      FAnimStatus:= ScrollDown;
      FTimer.Enabled:= True;
      If Height = ButtonHeight then
        FTimer.Interval:= TIMER_DELAY
      else
        FTimer.Interval:= TIMER_TIME;  
      Exit;
    end;
    If not FMouseIn and (Height > ButtonHeight) and
      (FAnimStatus <> ScrollUp) then begin
      FAnimStatus:= ScrollUp;
      FTimer.Enabled:= True;
      FTimer.Interval:= TIMER_TIME;
      Exit;
    end;

    FPrevMouseIn:= FMouseIn;

  end;

  case FAnimStatus of
    ScrollDown: If Height < (ButtonHeight * ButtonCount - ANIMSPEED) then begin
                    Height:= Height + ANIMSPEED;
//                    SetTimer(Handle, 1, TIMER_TIME, @FTimerProc);
                    FTimer.Interval:= TIMER_TIME;
                    FTimer.Enabled:= True;
                end else begin
                  FAnimStatus:= Inactive;
                  Height:= ButtonHeight * ButtonCount;
                end;
    ScrollUp:   If Height > (ButtonHeight + ANIMSPEED) then begin
                    Height:= Height - ANIMSPEED;
//                    SetTimer(Handle, 1, TIMER_TIME, @FTimerProc);
                    FTimer.Interval:= TIMER_TIME;
                    FTimer.Enabled:= True;
                end else begin
                  FAnimStatus:= Inactive;
                  Height:= ButtonHeight;
                end;
  end;
end;

procedure TMultiButton.Loaded;
var
  i: integer;
  FirstButton: TToolButton;
begin
  inherited;

  FirstButton:= Buttons[0];

  if not (csDesigning in ComponentState) then begin
    FClickList.Clear;
    FClickList.Add(nil);
    for i:= 1 to ButtonCount - 1 do begin
      FClickList.Add(@Buttons[i].OnClick);
      Buttons[i].OnClick:= DoClick;
    end;

    Height:= ButtonHeight;
    Width:= ButtonWidth;

    @FirstButton.OnClick:= FClickList.Items[DefaultButton];
    FirstButton.ImageIndex:= Buttons[DefaultButton].ImageIndex;
    FirstButton.OnMouseMove:= Buttons[DefaultButton].OnMouseMove;
    FirstButton.Hint:= Buttons[DefaultButton].Hint;
  end;

  FFirstButtonCanvas:= TControlCanvas.Create;
  FFirstButtonCanvas.Control:= FirstButton; 

//  FFirstButtonCanvas.OnChange:= TriangleTimerProc;
end;

procedure TMultiButton.DoClick(Sender: TObject);
var
  FirstButton,
  ThisButton: TToolButton;
begin
  ThisButton:= TToolButton(Sender);
  If ThisButton.Index > 0 then begin
    FirstButton:= Buttons[0];
    @FirstButton.OnClick:= FClickList.Items[ThisButton.Index];
    FirstButton.ImageIndex:= ThisButton.ImageIndex;
    FirstButton.OnMouseMove:= ThisButton.OnMouseMove;
    FirstButton.Hint:= ThisButton.Hint;

    If Assigned(FirstButton.OnClick) then
      FirstButton.OnClick(Sender);
  end;
end;

procedure Register;
begin
  RegisterComponents('Standard', [TMultiButton]);
end;

end.
