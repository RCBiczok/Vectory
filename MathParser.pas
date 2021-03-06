unit MathParser;

interface

uses
  SysUtils, Types, Dialogs, Controls, Forms, Classes;

type
  TRatio = record
    counter,
    denominator: integer;
  end;

  TVariable = record
    Name: string;
    Value: single;
  end;
  PVariable = ^TVariable;

  TVarsArray = Array of TVariable;

  TTriad = record
    Operand1,
    Op1Type,
    Operand2,
    Op2Type,
    Action: string;
  end;

  TTriadArray = Array of TTriad;

  TPolynom = record
    VarName: string;
    VarArray: array of string;
  end;

function DetermineValue(S: string): string;
function Split(S: string): TStringDynArray;
function FindFirstString(SArray: TStringDynArray; S: String): integer;
function ProcessParenthesis(S: string): string;
function Evaluate(S: string; Vars: TVarsArray): single;
procedure SaveVar(Name: string; Value: single;var Archive: TVarsArray);
function FindVar(Name: string; Archive: TVarsArray): integer;
function ProcessLine(var S: string;var Vars: TVarsArray): single;
function AskForNewVariable(Name: string;var Archive: TVarsArray): boolean;
procedure CreateParamForm(Parent: TComponent; Variable: TVariable);
function MakeNiceNumber(Number: single): string;
function MakeRatio(Number: single): TRatio;

function ParenthesisToTriads(S: string; index: integer): TTriadArray;
function ExtractTriads(S: string): TTriadArray;
function ProcessTriad(var Triads: TTriadArray; index: integer): TPolynom;
function PolynomAdd(P1,P2: TPolynom): TPolynom;
function PolynomMultiply(P1, P2: TPolynom): TPolynom;
function PresentResult(Triads: TTriadArray; index: integer): string;
function ProcessTriadLine(S: string): string;
procedure CleanParentheses(var S: string);

function IsNumber(S: String): Boolean;
function IsProduct(S: string): Boolean;

const
  ReservedWords: Array [0..5] of string =
  ('E', 'INF','NAN','sqrt', 'sin', 'cos');

var
  VarArray: TVarArray;

implementation

uses Math, ParameterTool, Main;

function Split(S: string): TStringDynArray;
var
  Count, index, i, j, k: integer;
  str: string;
  Variable: Boolean;
  Anfang, Ende: integer;
begin
  i:=1; Count:=0;
  while i <= length(S) do begin
    str:='';
    while (s[i] in ['0'..'9', 'E',',']) or ((s[i-1]='E') and (s[i]='-')) do begin
      str:=str+s[i];
      inc(i);
    end;

    If str='' then
      while (s[i] in ['A'..'D','F'..'Z','a'..'z']) do begin
        str:=str+s[i];
        inc(i);
      end;

    If str = '' then
      If s[i]='[' then begin
        Anfang:=0; Ende:=0;
        Repeat
          str:=str+s[i];
          inc(i);
          if s[i-1]='[' then inc(Anfang);
          if s[i-1]=']' then inc(Ende);
        until Anfang<=Ende;
      end;

    If str = '' then
      If s[i]='{' then begin
        Anfang:=0; Ende:=0;
        Repeat
          str:=str+s[i];
          inc(i);
          if s[i-1]='{' then inc(Anfang);
          if s[i-1]='}' then inc(Ende);
        until Anfang<=Ende;
      end;

    If str = '' then
      if not((s[i] in ['0'..'9']) or (s[i] in ['A'..'Z','a'..'z']))then begin
        str:=str+s[i];
        i:=i+1;
      end;

    Variable:=False;
    If (str[1] in ['A'..'Z','a'..'z']) then begin
      Variable:=True;
      for j:=0 to Length(ReservedWords)-1 do
        if str = ReservedWords[j] then
          Variable:=False;
    end;

    If Variable then begin
      Count:=Count+length(str);
      SetLength(Result, Count);
      for k:=0 to Length(str)-1 do
        Result[Count-1+k]:=str[k+1];
    end else begin
      inc(Count);
      SetLength(Result, Count);
      Result[Count-1]:=str;
    end;
  end;
end;

function FindFirstString(SArray: TStringDynArray; S: string): integer;
var
  i: integer;
begin
  i:=0;
  while (i<length(SArray)) and (SArray[i]<>S) do
    i:=i+1;
  If i<length(SArray) then Result:=i else Result:=-1;
end;

function FindString(SArray: TStringDynArray; S: string; number: integer): integer;
var
  i, count: integer;
begin
  Result:=-1;
  i:=0; count:=0;
  for Count:=1 to number do begin
    while (i<length(SArray)) and (SArray[i]<>S) do
      inc(i);
    If i<length(SArray) then Result:=i else Result:=-1;
    inc(i);
  end;
end;

function GetSignCount(Str: TStringDynArray; Sign: string): integer;
var
  i: integer;
begin
  Result:=0;
  for i:=0 to Length(str)-1 do
    if Str[i] = sign then
      inc(Result);
end;

procedure CorrectString(var S: string);
begin
  S:=StringReplace(S, '++', '+', [rfReplaceAll, rfIgnoreCase]);
  S:=StringReplace(S, '--', '+', [rfReplaceAll, rfIgnoreCase]);
  S:=StringReplace(S, '+-', '-', [rfReplaceAll, rfIgnoreCase]);
  S:=StringReplace(S, '-+', '-', [rfReplaceAll, rfIgnoreCase]);
  S:=StringReplace(S, '*+', '*', [rfReplaceAll, rfIgnoreCase]);
  S:=StringReplace(S, '/+', '/', [rfReplaceAll, rfIgnoreCase]);
end;

function ProcessParenthesis(S: string): string;
var
  Str: TStringDynArray;
  i,j, count, MaxCount: integer;
  StringA, StringB, Op1, Op2: string;
  Value1: string;
  OK: Boolean;
begin
  Str:=Split(S);
  StringB:=S;
  If Length(Str)=0 then begin
    Result:='0';
    Exit;
  end;
  If (length(Str)=1) or (((str[0]='-') or(str[0]='+')) and (Length(Str)=2)) then
    If str[0]='+' then
      Result:=Str[1]
    else
      Result:=S
  else begin

// Sinus
    MaxCount:=GetSignCount(Str, 'sin');
    Count:=1;
    while (Count <= MaxCount) and (i > -1) do begin
      i:=FindString(Str, 'sin', count);
      If (Str[i+1]='+') or (Str[i+1]='-') then Op1:=Str[i+1]+Str[i+2]
      else Op1:=Str[i+1];
      StringA:=Str[i]+Op1;

      If (Op1[1] in ['[','{']) or (Op1[1] in ['A'..'Z','a'..'z']) then  // Wenn eine Variable vorliegt
        Value1:='['+StringA+']'
      else begin
        Value1:=FloatToStr(sin(StrToFloat(Op1)/180*pi));
      end;

      StringB:=StringReplace(StringB, stringA, Value1, [rfIgnoreCase]);
      str:=Split(StringB);
      inc(Count);
    end;

// Square Root
    i:=FindFirstString(Str, 'sqrt');
    while i > -1 do begin
      If (Str[i+1]='+')or(Str[i+1]='-') then Op1:=Str[i+1]+Str[i+2]
      else Op1:=Str[i+1];
      StringA:=Str[i]+Op1;

      If (Op1[1] in ['[','{']) or (Op1[1] in ['A'..'Z','a'..'z']) then  // Wenn eine Variable vorliegt
        Value1:='['+stringA+']'
      else begin
        Value1:=FloatToStr(sqrt(StrToFloat(Op1)));
      end;

      StringB:=StringReplace(StringB, stringA, Value1, [rfIgnoreCase]);

      str:=Split(StringB);
      i:=FindFirstString(Str, 'sqrt');
    end;

// Power
    i:=FindFirstString(Str, '^');
    while i > -1 do begin
      If (i-2 > -1) and ((Str[i-2]='+')or(Str[i-2]='-')) then Op1:=Str[i-2]+Str[i-1]
      else Op1:=Str[i-1];
      If (Str[i+1]='+')or(Str[i+1]='-') then Op2:=Str[i+1]+Str[i+2]
      else Op2:=Str[i+1];
      StringA:=Op1+Str[i]+Op2;

      If ((Op1[length(Op1)] in [']','}']) or (Op1[1] in ['A'..'Z','a'..'z'])) or    // Wenn eine Variable vorliegt
         ((Op2[length(Op2)] in [']','}']) or (Op2[1] in ['A'..'Z','a'..'z'])) then
        Value1:='['+stringA+']'
      else begin
        Value1:=FloatToStr(Power(StrToFloat(Op1), StrToFloat(Op2)));
      end;

      If Value1[1]='-' then
        StringB:=StringReplace(StringB, stringA, Value1, [rfIgnoreCase])
      else
        StringB:=StringReplace(StringB, stringA, '+'+Value1, [rfIgnoreCase]);

      str:=Split(StringB);
      i:=FindFirstString(Str, '^');
    end;

// Multiplication and Division
    MaxCount:=GetSignCount(Str, '*');
    MaxCount:=MaxCount+GetSignCount(Str, '/');
    Count:=1;
    if Str[0][1] in ['*','/'] then Count:=2;
    i:=FindString(Str, '*', Count); j:=FindString(Str, '/', Count);

    while (Count <= MaxCount) and ((i > -1) or (j > -1)) do begin
      i:=FindString(Str, '*', Count); j:=FindString(Str, '/', Count);

      If ((i < j) or (j < 0))and (i > -1) then begin
        If (i-2 > -1) and ((Str[i-2]='+')or(Str[i-2]='-')) then Op1:=Str[i-2]+Str[i-1]
        else Op1:=Str[i-1];
        If (Str[i+1]='+')or(Str[i+1]='-') then Op2:=Str[i+1]+Str[i+2]
        else Op2:=Str[i+1];
        StringA:=Op1+Str[i]+Op2;

        If ((Op1[length(Op1)] in [']','}']) or (Op1[1] in ['A'..'Z','a'..'z'])) or    // Wenn eine Variable vorliegt
           ((Op2[length(Op2)] in [']','}']) or (Op2[1] in ['A'..'Z','a'..'z'])) then begin

          Value1:=stringA;
          If (Op1='1') then
            Value1:=Op2;
          If (Op2='1') then
            Value1:=Op1;
          If (Op1='0') or (Op1[2]='0') or (Op2='0') or (Op2[2]='0') then
            Value1:='0';

        end else begin
          Value1:=FloatToStr(StrToFloat(Op1)*StrToFloat(Op2));
          If Value1[1]<>'-' then
            Value1:='+'+Value1;
          dec(Count);
        end;
      end;
      If ((j < i) or (i < 0)) and (j > -1) then begin
        If (j-2 > -1) and ((Str[j-2]='+')or(Str[j-2]='-')) then Op1:=Str[j-2]+Str[j-1]
        else Op1:=Str[j-1];
        If (Str[j+1]='+')or(Str[j+1]='-') then Op2:=Str[j+1]+Str[j+2]
        else Op2:=Str[j+1];
        StringA:=Op1+Str[j]+Op2;

        If ((Op1[length(Op1)] in [']','}']) or (Op1[1] in ['A'..'Z','a'..'z'])) or    // Wenn eine Variable vorliegt
           ((Op2[length(Op2)] in [']','}']) or (Op2[1] in ['A'..'Z','a'..'z'])) then begin

          Value1:=stringA;
          If (Op2='1') then
            Value1:=Op1;
          If (Op1='0') or (Op1[2]='0') then
            Value1:='0';
          If (Op2='0') or (Op2[2]='0') then
            Value1:='INF';
        end else begin
          Value1:=FloatToStr(StrToFloat(Op1)/StrToFloat(Op2));
          If Value1[1]<>'-' then
            Value1:='+'+Value1;
          dec(Count);
        end;
      end;

      StringB:=StringReplace(StringB, stringA, Value1, [rfIgnoreCase]);

      str:=Split(StringB);
      inc(Count);
    end;

    if pos('[', Value1)>0 then
      StringB:=StringReplace(StringB, Value1, '['+Value1+']', [rfIgnoreCase]);

    CorrectString(StringB);
    StringB:=StringReplace(StringB, '-', '+-', [rfReplaceAll, rfIgnoreCase]);
    Str:=Split(StringB);

// Addition and Subtraction
    MaxCount:=GetSignCount(Str, '+');
    Count:=1;
    if Str[0][1] in ['+'] then Count:=2;
    i:=FindString(Str, '+', Count);

    while (Count <= MaxCount) and (i > -1) do begin
      i:=FindString(Str, '+', Count);

      If (i-2 > -1) and ((Str[i-2]='+')or(Str[i-2]='-')) then Op1:=Str[i-2]+Str[i-1]
      else Op1:=Str[i-1];
      If (Str[i+1]='+')or(Str[i+1]='-') then Op2:=Str[i+1]+Str[i+2]
      else Op2:=Str[i+1];
      StringA:=Op1+Str[i]+Op2;

      If ((Op1[length(Op1)] in [']','}']) or (Op1[1] in ['A'..'Z','a'..'z'])) or    // Wenn eine Variable vorliegt
         ((Op2[length(Op2)] in [']','}']) or (Op2[1] in ['A'..'Z','a'..'z'])) then begin

        If (Op1='0') or (Op1[2]='0') then
          Value1:=Op2
        else
          If (Op2='0') or (Op2[2]='0') then
            Value1:=Op1
          else
            Value1:=stringA;
      end else begin
        Value1:=FloatToStr(StrToFloat(Op1)+StrToFloat(Op2));
        If Value1[1]<>'-' then
          Value1:='+'+Value1;
        dec(Count);
      end;

      StringB:=StringReplace(StringB, stringA, Value1, [rfIgnoreCase]);
      StringB:=StringReplace(StringB, '++', '+', [rfIgnoreCase]);

      str:=Split(StringB);
      MaxCount:=GetSignCount(Str, '+');
      inc(Count);
    end;
//    Result:=ProcessParenthesis(StringB);
    CorrectString(StringB);
    Result:=StringB;
  end;
end;

function DetermineValue(S: string): string;
var
  ActualString, StringA, StringB: string;
  Count, index1, index2, i: integer;
  OK: Boolean;

begin
  Count:=0;
  ActualString:=S;
// Delete all spaces
  while pos(' ', ActualString)<>0 do
    Delete(ActualString, pos(' ', ActualString), 1);

  for i:=0 to Length(ReservedWords)-1 do
    ActualString:=StringReplace(ActualString, ReservedWords[i], '?'+IntToStr(i), [rfReplaceAll, rfIgnoreCase]);

  i:=1;
  while (i<Length(ActualString)) do begin
    if ActualString[i] in ['A'..'Z','a'..'z'] then
      if not ((ActualString[i-1]='[') and (ActualString[i+1]=']'))then begin
        ActualString:=StringReplace(ActualString, ActualString[i], '['+ActualString[i]+']', [rfReplaceAll, rfIgnoreCase]);
        i:=i+2;
      end;
    inc(i);
  end;

  for i:=0 to Length(ReservedWords)-1 do
    ActualString:=StringReplace(ActualString, '?'+IntToStr(i), ReservedWords[i], [rfReplaceAll, rfIgnoreCase]);

  while pos('(', ActualString)<>0 do begin
    index1:=LastDelimiter('(', ActualString);
    If (index1>1) and (ActualString[index1-1] in ['0'..'9']) then begin
      Insert('*', ActualString, index1);
      inc(index1);
    end;
    StringA:=Copy(ActualString, index1+1, length(ActualString)-index1+1);
    index2:=Pos(')', StringA);
    StringA:=Copy(ActualString, index1+1, index2-1);
    StringB:=Copy(ActualString, index1, index2+1);

    StringA:=ProcessParenthesis(StringA);
    If Length(StringA)>3 then
      StringA:='{'+StringA+'}';

    ActualString:=StringReplace(ActualString, StringB, StringA, [rfReplaceAll, rfIgnoreCase]);
  end;

  ActualString:=StringReplace(ActualString, '--', '+', [rfReplaceAll, rfIgnoreCase]);
  Result:=ProcessParenthesis(ActualString);

  // Normalize result string
  Result:=StringReplace(Result, '{', '(', [rfReplaceAll, rfIgnoreCase]);
  Result:=StringReplace(Result, '}', ')', [rfReplaceAll, rfIgnoreCase]);
  Result:=StringReplace(Result, '[', '', [rfReplaceAll, rfIgnoreCase]);
  Result:=StringReplace(Result, ']', '', [rfReplaceAll, rfIgnoreCase]);
  Result:=StringReplace(Result, '++', '+', [rfReplaceAll, rfIgnoreCase]);
  Result:=StringReplace(Result, '+-', '-', [rfReplaceAll, rfIgnoreCase]);
  Result:=StringReplace(Result, '-+', '-', [rfReplaceAll, rfIgnoreCase]);
  Result:=StringReplace(Result, '--', '+', [rfReplaceAll, rfIgnoreCase]);
  If Result[1] = '+' then
    Delete(Result, 1,1);
end;

function Evaluate(S: string; Vars: TVarsArray): single;
var
  ActualString: string;
  i, p: integer;
begin
  ActualString:=S;

  for i:=0 to Length(ReservedWords)-1 do
    ActualString:=StringReplace(ActualString, ReservedWords[i], '?'+IntToStr(i), [rfReplaceAll, rfIgnoreCase]);

  for i:=Length(ActualString) downto 1 do
    If (ActualString[i-1] in ['a'..'z', 'A'..'Z']) and (ActualString[i] in ['a'..'z', 'A'..'Z']) then
      Insert('*', ActualString, i);

  for i:=0 to length(Vars)-1 do begin
    p:=pos(Vars[i].Name, Actualstring);
    while (p>0) do begin
      If ((p-1<1) or not(ActualString[p-1] in ['A'..'Z','a'..'z'])) and
      ((p+1>length(ActualString)) or not(ActualString[p+1] in ['A'..'Z','a'..'z'])) then begin
        ActualString:=StringReplace(ActualString, Vars[i].Name, '('+FloatToStr(Vars[i].Value)+')', [rfIgnoreCase]);
      end;
      p:=pos(Vars[i].Name, Copy(ActualString, p+1, length(Actualstring)-p));
    end;
  end;

  for i:=0 to Length(ReservedWords)-1 do
    ActualString:=StringReplace(ActualString, '?'+IntToStr(i), ReservedWords[i], [rfReplaceAll, rfIgnoreCase]);

  Result:=StrToFloat(ProcessTriadLine(ActualString));
end;

function FindVar(Name: string; Archive: TVarsArray): integer;
var
  i: integer;
begin
  Result:=0;
  while (Result<length(Archive)) and (Archive[Result].Name<>Name) do
    Result:=Result+1;
  If Result=length(Archive) then
    Result:=-1;
end;

procedure SaveVar(Name: string; Value: single;var Archive: TVarsArray);
var
  i: integer;
begin
  i:=FindVar(Name, Archive);
  if i=-1 then begin
    i:=length(Archive);
    SetLength(Archive, i+1);
  end;
  Archive[i].Name:=Name;
  Archive[i].Value:=Value;
end;

function ProcessLine(var S: string; var Vars: TVarsArray): single;
var
  ActualString, StoredString: string;
  i, count: integer;
begin
  If S = 'NAN' then begin
    Result:=NAN;
    Exit;
  end;

  If S = 'INF' then begin
    Result:=Infinity;
    Exit;
  end;

  If S = '-INF' then begin
    Result:=NegInfinity;
    Exit;
  end;

  ActualString:=S; StoredString:=S;
  // delete reserved words
  for i:=1 to length(ReservedWords) do
    ActualString:=StringReplace(ActualString, ReservedWords[i-1], '    ', [rfReplaceAll, rfIgnoreCase]);
  // delete all numeric expressions  
  for i:=1 to length(ActualString) do
    if ActualString[i] in ['0'..'9', ',', '+', '-', '*', '/', '^', '(', ')'] then
      ActualString:=StringReplace(ActualString, ActualString[i],' ', [rfIgnoreCase]);
  // delete all known variables
  for i:=1 to length(ActualString) do
    if (ActualString[i]<>' ') and (FindVar(ActualString[i], Vars)>-1) then
      ActualString:=StringReplace(ActualString, ActualString[i],' ', [rfIgnoreCase]);
  // now only new variables or faulty characters remain
  for i:=1 to length(ActualString) do begin
{    if (ActualString[i] in ['A'..'Z','a'..'z']) and (not AskForNewVariable(ActualString[i], Vars)) then begin
      Delete(S, i, 1);
      Insert(' ', S, i);
    end else begin
      //raise EInvalidArgument.Create('Character ' + ActualString[i] + ' is invalid in an expression!');
    end;}

    if ActualString[i] in ['A'..'Z','a'..'z'] then begin
      AskForNewVariable(ActualString[i], Vars);
    end else if ActualString[i] <> ' ' then begin
      raise EInvalidArgument.Create('Das Zeichen ' + ActualString[i] + ' ist nicht einem Ausdruck erlaubt!');
    end;
  end;
  Result:=Evaluate(S, Vars);
end;

function AskForNewVariable(Name: string;var Archive: TVarsArray): boolean;
var
  Count: integer;
begin
  If FindVar(Name, Archive) = -1 then begin
    SaveVar(Name, 1, Archive);
    CreateParamForm(ParamForms, Archive[Length(Archive)-1])
  end ;

  Result:=True;
end;

procedure CreateParamForm(Parent: TComponent; Variable: TVariable);
var
  AForm: TParamTool;
begin
  AForm:=TParamTool.Create(Parent);
  AForm.Visible:=True;
  AForm.Caption:=AForm.Caption + Variable.Name;
  AForm.VarName.Caption:=Variable.Name + AForm.VarName.Caption + FloatToStr(Variable.Value);
  AForm.Variable:=Variable;
  AForm.Name:=Variable.Name;
  AForm.FormActivate(AForm);
end;

function MakeRatio(Number: single): TRatio;
var
  i: integer;
begin
  Result.counter:=0; Result.denominator:=0;
  for i:=1 to 200 do
    If IsZero(Round(Number*i)-Number*i, 0.00001) and not IsZero(Number*i, 0.00001) then begin
      Result.counter:=Round(Number*i);
      Result.denominator:=i;
      Break;
    end;
  If Result.counter > 1000000 then
    Result.denominator:=0;
end;

procedure DivideNumber(Number, power: integer; var Rational, Irrational: integer);
var
  i: integer;
begin
  i:=2;
  Rational:=Sign(Number); Irrational:=Abs(Number);
  while i <= sqrt(Irrational) do begin
    while (Irrational mod round(intpower(i,power))) = 0 do begin
      Irrational:=Irrational div round(intpower(i,power));
      Rational:=Rational*i;
    end;
    i:=i+1;
  end;
end;

function MakeNiceNumber(Number: single): string;
var
  Root, Ratio: string;
  i, j: integer;
  ActualNumber: single;
  RatC, IrrC, RatD, IrrD: integer;

begin
  If abs(Number) < 0.0000001 then begin
    Result:='0';
    Exit;
  end;

  Root:=''; Ratio:='';
  for i:=1 to 2 do begin
    ActualNumber:=Power(Number, i);
{    If IsZero(Round(ActualNumber)-ActualNumber, 0.000001) then begin
      case i of
        2: Root:='sqrt('+FloatToStr(round(ActualNumber))+')';
        3: Root:='('+FloatToStr(round(ActualNumber))+')^(1/3)';
      end;
      Break;
    end;  }
    With MakeRatio(ActualNumber) do begin
      If (denominator<>0) then begin
        case i of
          1: begin
               Root:='';
               If denominator>1 then
                 Ratio:=IntToStr(counter)+'/'+IntToStr(denominator)
               else
                 Ratio:=IntToStr(counter);
             end;
          2: begin
               DivideNumber(counter, 2, RatC, IrrC);
               DivideNumber(denominator, 2, RatD, IrrD);
               If (RatD*IrrD) > 1 then
                 Ratio:=IntToStr(RatC)+'/'+IntToStr(RatD*IrrD)
               else
                 if RatC > 1 then
                   Ratio:=IntToStr(RatC);
               If IrrD > 1 then
                 Root:='sqrt('+IntToStr(IrrC*IrrD)+')'
               else
                 if IrrC > 1 then
                   Root:='sqrt('+IntToStr(IrrC)+')';
             end;
          3: begin
               DivideNumber(counter, 3, RatC, IrrC);
               DivideNumber(denominator, 3, RatD, IrrD);
               If RatD > 1 then
                 Ratio:=IntToStr(RatC)+'/'+IntToStr(RatD)
               else
                 if RatC > 1 then
                   Ratio:=IntToStr(RatC);
               Root:='('+IntToStr(IrrC)+'/'+IntToStr(IrrD)+')^(1/3)';
             end;
        end;
        Break;
      end;
    end;
  end;
  If Number < 0 then
    If (Ratio <> '') and (Ratio[1] <> '-') then  Ratio:='-'+Ratio
    else If (Root <> '') and (Root[1] <> '-') then Root:='-'+Root;
  If Ratio<>'' then Result:=Ratio;
  If Root <>'' then Result:=Root;
  If (Ratio<>'') and (Root<>'') then Result:='('+Ratio+')*'+Root;
  If (Ratio='') and (Root='') then Result:=FloatToStr(Number);
end;



//==============================\\
//=========== Triads ===========\\
//==============================\\

procedure CleanParentheses(var S: string);
var
  i, j, k: integer;
  Count, ParenthesesCount: integer;
begin
  ParenthesesCount:=0;
  for i:=1 to Length(S) do
    if S[i]='(' then inc(ParenthesesCount);

  for i:=ParenthesesCount downto 1 do begin
    j:=0; Count:=0;
    while (j < Length(S)) and (Count < i) do begin
      inc(j);
      if S[j]='(' then
        inc(Count);
    end;

    if (j <=Length(S)) and ((j = 1) or (s[j-1] in ['(', '+'])) then begin

      k:=j; Count:=1;
      while (k < Length(S)) and (Count > 0) do begin
        inc(k);
        if S[k]='(' then
          inc(Count);
        if S[k]=')' then
          dec(Count);
      end;

      if (k <=Length(S)) and ((k = Length(S)) or (s[k+1] in [')', '+', '-'])) then begin
        Delete(S, k, 1);
        Delete(S, j, 1);
        dec(ParenthesesCount);
      end;
    end;

  end;
end;

procedure InsertArray(Source: TTriadArray; var Dest: TTriadArray; index: integer);
var
  i: integer;
begin
  SetLength(Dest, Length(Dest)+Length(Source));
  for i:=0 to Length(Source)-1 do
    Dest[i+index]:=Source[i];
end;

function GetOperandType(Op: string): string;
var
  i: integer;
  ActStr: string;
begin
  If Op = '' then begin
    Result:='error';
    Exit;
  end;

  Result:='error';
  If (Length(Op)>2) and (Op[1]='{') and (Op[Length(Op)]='}') then begin
    Result:='triad';
    ActStr:=Copy(Op, 2, Length(op)-2);
    for i:=1 to Length(ActStr) do
      If not (ActStr[i] in ['0'..'9','E']) then begin
        Result:='error';
        Exit;
      end;
    Exit;
  end;

  If (Length(Op)=3) and (Op[2] in ['a'..'z']) and (Op[1] = '[') and (Op[3] = ']') then begin
    Result:='variable';
    Exit;
  end;

  Result:='number';
  ActStr:=Op;
  for i:=1 to Length(ActStr) do
    If not (ActStr[i] in ['0'..'9',',','-','E']) then begin
      Result:='error';
      Exit;
    end;
end;

function ParenthesisToTriads(S: string; index: integer): TTriadArray;
var
  i,j, MaxCount: integer;
  Str: TStringDynArray;
  Op1, Op2,Act, StringA, StringB: string;
  Count: integer;
  Dummy: TTriadArray;
begin
  Count:=0;
  StringB:=S;
  // delete all spaces
  StringB:=StringReplace(StringB, ' ', '',[rfReplaceAll, rfIgnoreCase]);

  Str:=Split(StringB);
  //deal with the unary triad thingie
  If (Str[0]='-') then begin
   If (Length(Str) < 3) or not (Str[2]='^') then
    If not ((Str[1]='sin') or (Str[1]='cos') or (Str[1]='sqrt')) then begin
      inc(Count);
      SetLength(Result, Count);
      With Result[0] do begin
        Operand1:= '0';
        Op1Type:= 'number';
        Operand2:= Str[1];
        Op2Type:=GetOperandType(Operand2);
        Action:='-';
      end;
      StringB:=StringReplace(StringB, Str[0]+Str[1], '{'+IntToStr(Count+index)+'}', [rfIgnoreCase]);
      Str:=Split(StringB);
    end else begin
      inc(Count);
      SetLength(Result, Count);
      With Result[Count-1] do begin
        Operand1:= '';
        Op1Type:= '';
        Operand2:= Str[2];
        Op2Type:=GetOperandType(Operand2);
        Action:=str[1];
      end;
      inc(Count);
      SetLength(Result, Count);
      With Result[Count-1] do begin
        Operand1:= '0';
        Op1Type:= 'number';
        Operand2:= '{'+IntToStr(Count)+'}';
        Op2Type:=GetOperandType(Operand2);
        Action:='-';
      end;
      StringB:=StringReplace(StringB, Str[0]+Str[1]+Str[2], '{'+IntToStr(Count+index)+'}', [rfIgnoreCase]);
      Str:=Split(StringB);
    end;
  end else begin
    SetLength(Result, 1);
    With Result[0] do begin
      Operand1:= '0';
      Op1Type:= 'number';
      Operand2:= StringB;
      Op2Type:=GetOperandType(Operand2);
      Action:='+';
    end;
  end;

// cosinus
  i:=FindFirstString(Str, 'cos');

  while i > -1 do begin
    If (Str[i+1]='-') then Op1:=Str[i+1]+Str[i+2]
    else Op2:=Str[i+1];

    Act:='cos';
    StringA:=Str[i]+Op2;

    SetLength(Result, Count+1);
    with Result[Count] do begin
      Operand1:='';
      Op1Type:=GetOperandType(Operand1);
      Operand2:=Op2;
      Op2Type:=GetOperandType(Operand2);
      Action:=Act;
    end;

    StringB:=StringReplace(StringB, StringA, '{'+IntToStr(Count+index+1)+'}',[rfReplaceAll, rfIgnoreCase]);
    Str:=Split(StringB);
    i:=FindFirstString(Str, 'cos');
    inc(Count);
  end;

// sinus
  i:=FindFirstString(Str, 'sin');

  while i > -1 do begin
    If (Str[i+1]='-') then Op1:=Str[i+1]+Str[i+2]
    else Op2:=Str[i+1];

    Act:='sin';
    StringA:=Str[i]+Op2;

    SetLength(Result, Count+1);
    with Result[Count] do begin
      Operand1:='';
      Op1Type:=GetOperandType(Operand1);
      Operand2:=Op2;
      Op2Type:=GetOperandType(Operand2);
      Action:=Act;
    end;

    StringB:=StringReplace(StringB, StringA, '{'+IntToStr(Count+index+1)+'}',[rfReplaceAll, rfIgnoreCase]);
    Str:=Split(StringB);
    i:=FindFirstString(Str, 'sin');
    inc(Count);
  end;

// square root
  i:=FindFirstString(Str, 'sqrt');

  while i > -1 do begin
    If (Str[i+1]='-') then Op2:=Str[i+1]+Str[i+2]
    else Op2:=Str[i+1];

    Act:='sqrt';
    StringA:=Str[i]+Op2;

    SetLength(Result, Count+1);
    with Result[Count] do begin
      Operand1:='';
      Op1Type:=GetOperandType(Operand1);
      Operand2:=Op2;
      Op2Type:=GetOperandType(Operand2);
      Action:=Act;
    end;

    StringB:=StringReplace(StringB, StringA, '{'+IntToStr(Count+index+1)+'}',[rfReplaceAll, rfIgnoreCase]);
    Str:=Split(StringB);
    i:=FindFirstString(Str, 'sqrt');
    inc(Count);
  end;

// Power
  i:=FindFirstString(Str, '^');

  while i > 0 do begin
 {   If (i > 1) and (Str[i-2]='-') and ((i<3) or (Str[i-3]= '(')) then Op1:=Str[i-2]+Str[i-1]
    else }Op1:=Str[i-1];
    If (Str[i+1]='+')or(Str[i+1]='-') then Op2:=Str[i+1]+Str[i+2]
    else Op2:=Str[i+1];
    Act:='^';
    StringA:=Op1+Str[i]+Op2;

    SetLength(Result, Count+1);
    with Result[Count] do begin
      Operand1:=Op1;
      Op1Type:=GetOperandType(Operand1);
      Operand2:=Op2;
      Op2Type:=GetOperandType(Operand2);
      Action:=Act;
    end;

    StringB:=StringReplace(StringB, StringA, '{'+IntToStr(Count+index+1)+'}',[rfReplaceAll, rfIgnoreCase]);
    Str:=Split(StringB);
    i:=FindFirstString(Str, '^');
    inc(Count);
  end;

// multiplication and division
  i:=FindFirstString(Str, '*'); j:=FindFirstString(Str, '/');

  while (i > 0) or (j > 0) do begin
    If ((i < j) or (j < 0)) and (i > 0) then begin  //Case *
      If ((i > 1) and (Str[i-2]='-')) and ((i<3) or (Str[i-3]= '(')) then Op1:=Str[i-2]+Str[i-1]
      else Op1:=Str[i-1];
      If (Str[i+1]='+')or(Str[i+1]='-') then Op2:=Str[i+1]+Str[i+2]
      else Op2:=Str[i+1];
      Act:='*';
      StringA:=Op1+Str[i]+Op2;
    end;

    If ((j < i) or (i < 0)) and (j > 0) then begin  //Case /
      If ((j > 1) and (Str[j-2]='-')) and ((j<3) or (Str[j-3]= '(')) then Op1:=Str[j-2]+Str[j-1]
      else Op1:=Str[j-1];
      If (Str[j+1]='+')or(Str[j+1]='-') then Op2:=Str[j+1]+Str[j+2]
      else Op2:=Str[j+1];
      Act:='/';
      StringA:=Op1+Str[j]+Op2;
    end;

    SetLength(Result, Count+1);
    with Result[Count] do begin
      Operand1:=Op1;
      Op1Type:=GetOperandType(Operand1);
      Operand2:=Op2;
      Op2Type:=GetOperandType(Operand2);
      Action:=Act;
    end;

    StringB:=StringReplace(StringB, StringA, '{'+IntToStr(Count+index+1)+'}',[rfIgnoreCase]);
    Str:=Split(StringB);
    i:=FindFirstString(Str, '*'); j:=FindFirstString(Str, '/');
    inc(Count);
  end;

// addition and subtraction
  if Str[0][1] = '+' then
    i:=FindString(Str, '+', 2)
  else
    i:=FindFirstString(Str, '+');
  if Str[0][1] = '-' then
    j:=FindString(Str, '-', 2)
  else
    j:=FindFirstString(Str, '-');

  while (i > 0) or (j > 0) do begin
    If ((i < j) or (j < 0)) and (i > 0) then begin  //Case +
      If (i > 1) and ((Str[i-2]='+')or(Str[i-2]='-')) then Op1:=Str[i-2]+Str[i-1]
      else Op1:=Str[i-1];
      If (Str[i+1]='+')or(Str[i+1]='-') then Op2:=Str[i+1]+Str[i+2]
      else Op2:=Str[i+1];
      Act:='+';
      StringA:=Op1+Str[i]+Op2;
    end;

    If ((j < i) or (i < 0)) and (j > 0) and (Str[j-1][Length(Str[j-1])] <> 'E') then begin  //Case -
      If (j > 1) and ((Str[j-2]='+')or(Str[j-2]='-')) then Op1:=Str[j-2]+Str[j-1]
      else Op1:=Str[j-1];
      If (Str[j+1]='+')or(Str[j+1]='-') then Op2:=Str[j+1]+Str[j+2]
      else Op2:=Str[j+1];
      Act:='-';
      StringA:=Op1+Str[j]+Op2;
    end;

    SetLength(Result, Count+1);
    with Result[Count] do begin
      Operand1:=Op1;
      Op1Type:=GetOperandType(Operand1);
      Operand2:=Op2;
      Op2Type:=GetOperandType(Operand2);
      Action:=Act;
    end;

    StringB:=StringReplace(StringB, StringA, '{'+IntToStr(Count+index+1)+'}',[rfIgnoreCase]);
    Str:=Split(StringB);

    if Str[0][1] = '+' then
      i:=FindString(Str, '+', 2)
    else
      i:=FindFirstString(Str, '+');
    if Str[0][1] = '-' then
      j:=FindString(Str, '-', 2)
    else
      j:=FindFirstString(Str, '-');

    inc(Count);
  end;

  If Length(Str) > 1 then begin
    SetLength(Result, Count+1);
    SetLength(Dummy, 1);
    Dummy:=ParenthesisToTriads(StringB, 0);
    With Result[Count]do begin
      Operand1:= Dummy[0].Operand1;
      Op1Type:= Dummy[0].Op1Type;
      Operand2:= Dummy[0].Operand2;
      Op2Type:= Dummy[0].Op2Type;
      Action:= Dummy[0].Action;
    end;
  end;
end;

function ExtractTriads(S: string): TTriadArray;
var
  ActualString, StringA, StringB: string;
  i, Count, index1, index2: integer;
  TriadArray, DummyArray: TTriadArray;
begin
  ActualString:=S;
  LowerCase(ActualString);
  Count:=0;

  ActualString:=StringReplace(ActualString, '--', '+', [rfReplaceAll]);
  ActualString:=StringReplace(ActualString, '-+', '-', [rfReplaceAll]);
  ActualString:=StringReplace(ActualString, '+-', '-', [rfReplaceAll]);
  ActualString:=StringReplace(ActualString, '++', '+', [rfReplaceAll]);

  for i:=0 to Length(ReservedWords)-1 do
    ActualString:=StringReplace(ActualString, ReservedWords[i], '?'+IntToStr(i), [rfReplaceAll, rfIgnoreCase]);

  i:=1;
  while (i<=Length(ActualString)) do begin
    if ActualString[i] in ['A'..'Z','a'..'z'] then
      if not ((ActualString[i-1]='[') and (ActualString[i+1]=']'))then begin
        ActualString:=StringReplace(ActualString, ActualString[i], '['+ActualString[i]+']', [rfReplaceAll, rfIgnoreCase]);
        i:=i+2;
      end;
    inc(i);
  end;

// Insert "*" between variables and parenthesis
  ActualString:= StringReplace(ActualString, '][', ']*[', [rfReplaceAll, rfIgnoreCase]);
  ActualString:= StringReplace(ActualString, ')[', ')*[', [rfReplaceAll, rfIgnoreCase]);
  ActualString:= StringReplace(ActualString, ')(', ')*(', [rfReplaceAll, rfIgnoreCase]);
  ActualString:= StringReplace(ActualString, '](', ']*(', [rfReplaceAll, rfIgnoreCase]);

  i:= Pos('*-[', ActualString);
  while (i > 0) do begin
    Insert('(0', ActualString, i+1);
    Delete(ActualString, i+3, 1);
    Insert(')', ActualString, i+6);
    i:= Pos('*-[', ActualString);
  end;
  ActualString:=StringReplace(ActualString, '(0[', '(0-[', [rfReplaceAll]);

  for i:=0 to Length(ReservedWords)-1 do
    ActualString:=StringReplace(ActualString, '?'+IntToStr(i), ReservedWords[i], [rfReplaceAll, rfIgnoreCase]);

  // insert "*" between number and variable
  StringA:=ActualString;
  for i:= Length(ActualString)-3 downto 1 do
    if (ActualString[i] in ['0'..'9']) and (ActualString[i+1]='[') then
      Insert('*', StringA, i+1);
  ActualString:=StringA;
  for i:= Length(ActualString)-3 downto 1 do
    if (ActualString[i]=']') and (ActualString[i+1]in ['0'..'9']) then
      Insert('*', StringA, i+1);
  ActualString:=StringA;

  while pos('(', ActualString)<>0 do begin
    index1:=LastDelimiter('(', ActualString);
    If (index1>1) and (ActualString[index1-1] in ['0'..'9',')']) then begin
      Insert('*', ActualString, index1);
      inc(index1);
    end;
    StringA:=Copy(ActualString, index1+1, length(ActualString)-index1+1);
    index2:=Pos(')', StringA);
    If (index1+index2 < Length(ActualString)) and (ActualString[index1+index2+1] in ['0'..'9','(']) then begin
      Insert('*', ActualString, index1+index2+1);
    end;
    StringA:=Copy(ActualString, index1+1, index2-1);
    StringB:=Copy(ActualString, index1, index2+1);

    If StringA[1]='+' then
      Delete(StringA, 1,1);
    If StringA[1]='-' then
      StringA:='0'+StringA;

    DummyArray:=ParenthesisToTriads(StringA, Count);
    InsertArray(DummyArray, TriadArray, Count);
    Count:=Count+Length(DummyArray);
    StringA:='{'+IntToStr(Count)+'}';
//    ActualString:=StringReplace(ActualString, StringB, StringA, [rfIgnoreCase]);
    Delete(ActualString, index1, index2+1);
    Insert(StringA, ActualString ,index1);
  end;

  If ActualString[1]='+' then
    Delete(ActualString, 1,1);
  If ActualString[1]='-' then
    ActualString:='0'+ActualString;
  DummyArray:=ParenthesisToTriads(ActualString, Count);
  InsertArray(DummyArray, TriadArray, Count);

  Result:=TriadArray;
end;

// Both numbers
function ProcessNN(Op1, Op2, Act: string): TPolynom;
begin
  With Result do begin
    VarName:='';
    VarArray:= nil;
  end;
  if act = 'cos' then
    With Result do begin
      SetLength(VarArray, 1);
      VarArray[0]:=FloatToStr(cos(StrToFloat(op2)/180*pi));
    end;
  if act = 'sin' then
    With Result do begin
      SetLength(VarArray, 1);
      VarArray[0]:=FloatToStr(sin(StrToFloat(op2)/180*pi));
    end;
  if act = 'sqrt' then
    With Result do begin
      SetLength(VarArray, 1);
      VarArray[0]:=FloatToStr(sqrt(StrToFloat(op2)));
    end;
  if act = '^' then
    With Result do begin
      SetLength(VarArray, 1);
      VarArray[0]:=FloatToStr(Power(StrToFloat(op1),StrToFloat(op2)));
    end;
  if act = '*' then
    With Result do begin
      SetLength(VarArray, 1);
      VarArray[0]:=FloatToStr(StrToFloat(op1)*StrToFloat(op2));
    end;
  if act = '/' then
    With Result do begin
      SetLength(VarArray, 1);
      VarArray[0]:=FloatToStr(StrToFloat(op1)/StrToFloat(op2));
    end;
  if act = '+' then
    With Result do begin
      SetLength(VarArray, 1);
      VarArray[0]:=FloatToStr(StrToFloat(op1)+StrToFloat(op2));
    end;
  if act = '-' then
    With Result do begin
      SetLength(VarArray, 1);
      VarArray[0]:=FloatToStr(StrToFloat(op1)-StrToFloat(op2));
    end;
  if act = '' then begin
    With Result do begin
      SetLength(VarArray, 1);
      VarArray[0]:=op2;
    end;
  end;
end;

// Variable and Number
function ProcessVN(op1, op2, act: string): TPolynom;
var
  i: integer;
begin
  With Result do begin
    VarName:=op1[2];
    SetLength(VarArray, 2);
    VarArray[0]:= '0';
    VarArray[1]:= '1';
  end;

  If act = '+' then
    Result.VarArray[0]:=op2;

  If act = '-' then
    Result.VarArray[0]:= '-'+op2;

  If act = '*' then
    Result.VarArray[1]:= op2;

  If act = '/' then
    Result.VarArray[1]:= FloatToStr(1/StrToFloat(op2));

  If act = '^' then begin
    SetLength(Result.VarArray, StrToInt(op2)+1);
    If Length(Result.VarArray) > 1 then
      Result.VarArray[1]:= '0';
    for i:=0 to Length(Result.VarArray) do
      If Result.VarArray[i]='' then
        Result.VarArray[i]:='0';
    Result.VarArray[StrToInt(op2)]:= '1';
  end;
end;

// Number and Variable
function ProcessNV(op1, op2, act: string): TPolynom;
begin
  If act = '/' then
    Exit;
  If act = '-' then
    With Result do begin
      VarName:=op2[2];
      SetLength(VarArray, 2);
      VarArray[1]:= '-1';
      VarArray[0]:= op1;
    end
  else
    Result:=ProcessVN(op2, op1, act);
end;

// Both variables
function ProcessVV(op1, op2, act: string): TPolynom;
begin
// both variables are the same
  If not (act[1] in ['+', '-', '*', '/']) then begin
    Result.VarArray:=NIL;
    Exit;
  end;

  if (op1='') or (op1[2] = op2[2]) then begin
    With Result do begin
      VarName:=op2[2];
      SetLength(VarArray, 2);
      VarArray[1]:= '1';
      VarArray[0]:= '0';
    end;

    if act = '' then
      Result.VarArray[1]:= '1';

    If act = '+' then
      Result.VarArray[1]:='2';

    If act = '-' then begin
      SetLength(Result.VarArray, 1);
      Result.VarArray[1]:= '0';
    end;

    If act = '*' then begin
      SetLength(Result.VarArray, 3);
      Result.VarArray[1]:= '0';
      Result.VarArray[2]:= '1';
    end;

    If act = '/' then begin
      SetLength(Result.VarArray, 1);
      Result.VarArray[0]:= '1';
    end;
  end else begin
    With Result do begin
      VarName:=op2[2];
      SetLength(VarArray, 2);
      VarArray[1]:= '1';
      VarArray[0]:= '0';
    end;

    If act = '+' then
      Result.VarArray[0]:=Op1[2];

    If act = '-' then begin
      Result.VarArray[0]:= '-'+Op1[2];
    end;

    If act = '*' then begin
      Result.VarArray[1]:= Op1[2];
    end;
  end;
end;

// Triad and number
function ProcessTN(var Triads: TTriadArray; op1, op2, act: string): TPolynom;
var
  ActPoly: TPolynom;
  i: integer;
  OK: Boolean;
begin
  ActPoly:= ProcessTriad(Triads, StrToInt(Copy(op1, 2, Length(op1)-2))-1);
  If Assigned(ActPoly.VarArray) then
    With Result do begin
      VarName:=ActPoly.VarName;
      VarArray:=ActPoly.VarArray;

      If act = '+' then begin
        SetLength(VarArray, Length(ActPoly.VarArray));
        If IsNumber(ActPoly.VarArray[0]) then
          VarArray[0]:=FloatToStr(StrToFloat(ActPoly.VarArray[0])+StrToFloat(op2))
        else
          VarArray[0]:=ProcessTriadLine('('+ActPoly.VarArray[0]+')+'+op2);
      end;

      If act = '-' then begin
        SetLength(VarArray, Length(ActPoly.VarArray));
        If IsNumber(ActPoly.VarArray[0]) then
          VarArray[0]:=FloatToStr(StrToFloat(ActPoly.VarArray[0])-StrToFloat(op2))
        else
          VarArray[0]:=ProcessTriadLine('('+ActPoly.VarArray[0]+')-'+op2);
      end;

      If act = '*' then begin
        SetLength(VarArray, Length(ActPoly.VarArray));
        for i:=0 to Length(ActPoly.VarArray)-1 do
          If IsNumber(ActPoly.VarArray[i]) then
            VarArray[i]:=FloatToStr(StrToFloat(ActPoly.VarArray[i])*StrToFloat(op2))
          else
            VarArray[i]:=ProcessTriadLine('('+ActPoly.VarArray[i]+')*'+op2);
      end;
      If act = '/' then begin
{        OK:=True;
        for i:=1 to Length(ActPoly.VarArray)-1 do
          if ActPoly.VarArray[i]<>0 then OK:=False;
        If OK then begin
          SetLength(VarArray, 1);
          VarArray[0]:=ActPoly.VarArray[0]/StrToFloat(op2);}
        SetLength(VarArray, Length(ActPoly.VarArray));
        for i:=0 to Length(ActPoly.VarArray)-1 do
          If IsNumber(ActPoly.VarArray[i]) then
          VarArray[0]:=FloatToStr(StrToFloat(ActPoly.VarArray[i])/StrToFloat(op2))
          else
            VarArray[i]:=ProcessTriadLine('('+ActPoly.VarArray[i]+')/'+op2);
      end;
      If act = '^' then begin
        OK:=True;
        for i:=1 to Length(Result.VarArray)-1 do
          If Result.VarArray[i] <> '0' then OK:=False;

        If OK then
          Result.VarArray[0]:=FloatToStr(Power(StrToFloat(Result.VarArray[0]), StrToFloat(Op2)))
        else
        If StrToFloat(Op2) > 0 then
          for i:=2 to StrToInt(Op2) do
            Result:=PolynomMultiply(Result, ActPoly)
        else begin
          Result.VarName:='';
          Result.VarArray:=NIL;
        end;
      end;
    end;
end;

// Number and triad
function ProcessNT(var Triads: TTriadArray; op1, op2, act: string): TPolynom;
var
  ActPoly: TPolynom;
  i: integer;
  OK: Boolean;
begin
{  If act = '/' then begin
    Result.VarArray:=nil;
    Exit;
  end;   }
  ActPoly:= ProcessTriad(Triads, StrToInt(Copy(op2, 2, Length(op2)-2))-1);

  If Assigned(ActPoly.VarArray) then begin

  If act = 'sqrt' then begin
    OK:=True;
    for i:=1 to Length(ActPoly.VarArray)-1 do
      if ActPoly.VarArray[i]<>'0' then OK:=False;
    If OK then begin
      SetLength(Result.VarArray, 1);
      If IsNumber(ActPoly.VarArray[0]) then
        Result.VarArray[0]:= FloatToStr(sqrt(StrToFloat(ActPoly.VarArray[0])))
      else
        Result.VarArray[0]:=ProcessTriadLine('sqrt('+ActPoly.VarArray[0]+')');
    end;
    Exit;
  end;
  If act = '^' then begin
    OK:=True;
    for i:=1 to Length(ActPoly.VarArray)-1 do
      if ActPoly.VarArray[i]<>'0' then OK:=False;
    If OK then begin
      SetLength(Result.VarArray, 1);
      If IsNumber(ActPoly.VarArray[0]) then
        Result.VarArray[0]:= FloatToStr(Power(StrToFloat(op1), StrToFloat(ActPoly.VarArray[0])))
      else
        Result.VarArray[0]:=ProcessTriadLine(op1+'^('+ActPoly.VarArray[0]+')');
    end;
    Exit;
  end;
  If act = '/' then begin
    OK:=True;
    for i:=1 to Length(ActPoly.VarArray)-1 do
      if ActPoly.VarArray[i]<>'0' then OK:=False;
    If OK then begin
      SetLength(Result.VarArray, 1);
      If IsNumber(ActPoly.VarArray[0]) then
        Result.VarArray[0]:= FloatToStr(StrToFloat(op1)/ StrToFloat(ActPoly.VarArray[0]))
      else
        Result.VarArray[0]:=ProcessTriadLine(op1+'/('+ActPoly.VarArray[0]+')');
    end;
    Exit;
  end;
  If act = '-' then
   With Result do begin
    VarName:=ActPoly.VarName;
    SetLength(VarArray, Length(ActPoly.VarArray));
    VarArray:=ActPoly.VarArray;
    for i:=0 to Length(VarArray)-1 do
      If IsNumber(ActPoly.VarArray[i]) then
        Result.VarArray[i]:= FloatToStr(- StrToFloat(ActPoly.VarArray[i]))
      else
        Result.VarArray[i]:=ProcessTriadLine('-('+ActPoly.VarArray[i]+')');
    If IsNumber(ActPoly.VarArray[0]) then
      Result.VarArray[0]:= FloatToStr(StrToFloat(op1) + StrToFloat(ActPoly.VarArray[0]))
    else
      Result.VarArray[0]:=ProcessTriadLine('('+ActPoly.VarArray[0]+')+'+op1);
   end
  else
    Result:=ProcessTN(Triads, op2, op1, act);

  end; {If Assigned(Actpoly.VarArray)}

end;

// Triad and variable
function ProcessTV(var Triads: TTriadArray; op1, op2, act: string): TPolynom;
var
  ActPoly: TPolynom;
  i: integer;
  PolyLength: integer;
begin
  ActPoly:= ProcessTriad(Triads, StrToInt(Copy(op1, 2, Length(op1)-2))-1);
  PolyLength:=Length(ActPoly.VarArray);

  If Assigned(ActPoly.VarArray) and ((ActPoly.VarName = op2[2]) or (ActPoly.VarName = '')) then
    With Result do begin
      VarName:=op2[2];
      VarArray:=ActPoly.VarArray;

      If act = '+' then begin
        if PolyLength > 2 then
          SetLength(VarArray, PolyLength)
        else begin
          SetLength(VarArray, 2);
          SetLength(ActPoly.VarArray, 2);
        end;  
        If PolyLength > 1 then
          VarArray[1]:=ProcessTriadLine(ActPoly.VarArray[1]+'+1')
        else
          VarArray[1]:='1';
      end;

      If act = '-' then begin
        if PolyLength > 2 then
          SetLength(VarArray, PolyLength)
        else begin
          SetLength(VarArray, 2);
          SetLength(ActPoly.VarArray, 2);
        end;
        VarArray[1]:=ProcessTriadLine(ActPoly.VarArray[1]+'-1');
      end;

      If act = '*' then begin
        SetLength(VarArray, PolyLength+1);
        VarArray[0]:='0';
        for i:=1 to Length(ActPoly.VarArray) do
          VarArray[i]:=ActPoly.VarArray[i-1];
      end;
    end

  else

    With Result do begin
      VarName:=ActPoly.VarName;
      VarArray:=ActPoly.VarArray;

      If act = '+' then begin
        VarArray[0]:=ProcessTriadLine(ActPoly.VarArray[0]+'+'+Op2[2]);
      end;

      If act = '-' then begin
        VarArray[0]:=ProcessTriadLine(ActPoly.VarArray[0]+'-'+Op2[2]);
      end;

      If act = '*' then begin
        for i:=0 to Length(ActPoly.VarArray)-1 do
          VarArray[i]:=ProcessTriadLine(ActPoly.VarArray[i]+'*'+Op2[2]);
      end;
    end
end;

// Variable and triad
function ProcessVT(var Triads: TTriadArray; op1, op2, act: string): TPolynom;
var
  ActPoly: TPolynom;
  i: integer;
begin
  If act = '-' then
   With Result do begin
    ActPoly:= ProcessTriad(Triads, StrToInt(Copy(op2, 2, Length(op2)-2))-1);
        if Length(ActPoly.VarArray) > 2 then
          SetLength(VarArray, Length(ActPoly.VarArray))
        else
          SetLength(VarArray, 2);
    VarArray:=ActPoly.VarArray;
    for i:=0 to Length(VarArray)-1 do
      VarArray[i]:=ProcessTriadLine('-('+VarArray[i]+')');
    VarArray[1]:=ProcessTriadLine(ActPoly.VarArray[1]+'+1');
   end
  else
    Result:=ProcessTV(Triads, op2, op1, act);
end;

// Add two polynoms
function PolynomAdd(P1,P2: TPolynom): TPolynom;
var
  Big, Small: TPolynom;
  i: integer;
  S1, S2: string;
begin
  If Assigned(P1.VarArray) and Assigned(P2.VarArray) and
     ((P1.VarName = P2.VarName) or (P1.VarName = '') or (P2.VarName = '')) then begin

    If P1.VarName <> '' then Result.VarName:=P1.VarName;
    If P2.VarName <> '' then Result.VarName:=P2.VarName;
    If Length(P1.VarArray)>Length(P2.VarArray) then begin
      Big:=P1;
      Small:=P2;
    end else begin
      Big:=P2;
      Small:=P1;
    end;
    SetLength(Result.VarArray, Length(Big.VarArray));
    for i:=0 to Length(Big.VarArray)-1 do
      Result.VarArray[i]:=Big.VarArray[i];
    for i:=0 to Length(Small.VarArray)-1 do begin
      If IsNumber(Result.VarArray[i]) or
         (Length(Result.VarArray[i]) < 3) then
        S1:=Result.VarArray[i]
      else
        S1:='('+Result.VarArray[i]+')';

      If IsNumber(Small.VarArray[i]) or
         (Length(Small.VarArray[i]) < 3) then
        S2:=Small.VarArray[i]
      else
        S2:='('+Small.VarArray[i]+')';

      If IsNumber(S1) and IsNumber(S2) then
        Result.VarArray[i]:=FloatToStr(StrToFloat(S1)+StrToFloat(S2))
      else
      If S1='0' then
        Result.VarArray[i]:=S2
      else
      If S2='0' then
        Result.VarArray[i]:=S1
      else
      If (IsNumber(S1) and (Length(S2)=1) and (S2[1] in ['a'..'z','A'..'Z'])) or
         (IsNumber(S2) and (Length(S1)=1) and (S1[1] in ['a'..'z','A'..'Z'])) then
        Result.VarArray[i]:=S1+'+'+S2
      else
        Result.VarArray[i]:=ProcessTriadLine(S1+'+'+S2);
    end;
  end else
    If Assigned(P1.VarArray) and Assigned(P2.VarArray) and (P1.VarName <> P2.VarName) then begin
      Result.VarName:=P2.VarName;
      Result.VarArray:= P2.VarArray;
      S1:='';
      for i:=0 to Length(P1.VarArray)-1 do
        S1:=S1+'+'+P1.VarArray[i]+'*'+P1.VarName+'^'+IntToStr(i);
      Result.VarArray[0]:=ProcessTriadLine(Result.VarArray[0]+S1);
    end;
end;

// Multiply two polynoms
function PolynomMultiply(P1, P2: TPolynom): TPolynom;
var
  i, j: integer;
  Dummy: TPolynom;
  S1, S2: string;
  DifferentVars: Boolean;
begin
  If P1.VarName <> '' then Result.VarName:=P1.VarName;
  If P2.VarName <> '' then Result.VarName:=P2.VarName;

  If Assigned(P1.VarArray) and Assigned(P2.VarArray){ and
     ((P1.VarName = P2.VarName) or (P1.VarName = '') or (P2.VarName = ''))} then
    If not ((P1.VarName = P2.VarName) or (P1.VarName = '') or (P2.VarName = '')) then DifferentVars:= True
    else DifferentVars:= False;

    With Result do begin
      VarArray:=nil;
      Dummy.VarName:=VarName;

      for i:=0 to Length(P2.VarArray)-1 do
        If (P2.VarArray[i]<>'0') or (i = 0) then begin
          Dummy.VarArray:=nil;
          SetLength(Dummy.VarArray, Length(P1.VarArray)+i);
          for j:=0 to Length(P1.VarArray)-1 do begin
            If (IsNumber(P1.VarArray[j]) or
               (Length(P1.VarArray[j]) < 3)) and
               not DifferentVars or (j=0) then begin
              S1:=P1.VarArray[j]
            end else
              If DifferentVars and (j>0) then
                S1:='(('+P1.VarArray[j]+')*'+P1.VarName+'^'+IntToStr(j)+')'
              else
                S1:='('+P1.VarArray[j]+')';

            If IsNumber(P2.VarArray[i]) or
               (Length(P2.VarArray[i]) < 3) then
              S2:=P2.VarArray[i]
            else
              S2:='('+P2.VarArray[i]+')';

            If DifferentVars then
              Dummy.VarArray[i]:=ProcessTriadLine(Dummy.VarArray[i]+'+'+S1+'*'+S2)
            else
              If IsNumber(S1) and IsNumber(S2) then
                Dummy.VarArray[j+i]:=FloatToStr(StrToFloat(S1)*StrToFloat(S2))
              else
                Dummy.VarArray[j+i]:=ProcessTriadLine(S1+'*'+S2);
          end;
          SetLength(VarArray, Length(Dummy.VarArray));
          for j:=0 to Length(Dummy.VarArray)-1 do begin
            if Dummy.VarArray[j]='' then
              Dummy.VarArray[j]:='0';
            if VarArray[j]='' then
              VarArray[j]:='0';
          end;
          Result:=PolynomAdd(Result, Dummy);
        end;
    end;
end;

// Triad and triad
function ProcessTT(var Triads: TTriadArray; op1, op2, act: string): TPolynom;
var
  Big, Small, ActPoly1, ActPoly2: TPolynom;
  i: integer;
  OK: Boolean;

begin
  If op1<>'' then
    ActPoly1:= ProcessTriad(Triads, StrToInt(Copy(op1, 2, Length(op1)-2))-1);
  ActPoly2:= ProcessTriad(Triads, StrToInt(Copy(op2, 2, Length(op2)-2))-1);
  If ((op1 = '') or (Assigned(ActPoly1.VarArray))) and Assigned(ActPoly2.VarArray) {and
     ((ActPoly1.VarName = ActPoly2.VarName) or (ActPoly1.VarName = '') or (ActPoly2.VarName = ''))} then
    With Result do begin
      If ActPoly1.VarName <> '' then
        VarName:=ActPoly1.VarName
      else
        VarName:=ActPoly2.VarName;
      VarArray:=nil;

      SetLength(VarArray, Length(Big.VarArray));

      If act = '+' then
        Result:=PolynomAdd(ActPoly1, ActPoly2);

      If act = '-' then begin
        for i:=0 to Length(ActPoly2.VarArray)-1 do
          If IsNumber(ActPoly2.VarArray[i]) or
             (Length(ActPoly2.VarArray[i]) < 3) then
            ActPoly2.VarArray[i]:=ProcessTriadLine('-'+ActPoly2.VarArray[i])
          else
            ActPoly2.VarArray[i]:=ProcessTriadLine('-('+ActPoly2.VarArray[i]+')');
        Result:=PolynomAdd(ActPoly1, ActPoly2);
      end;

      If act = '*' then begin
        Result:=PolynomMultiply(ActPoly1, ActPoly2);
      end;

      If act = '/' then begin
        OK:=true;
        for i:=1 to Length(ActPoly2.VarArray)-1 do
          if ActPoly2.VarArray[i]<>'0' then OK:=false;
        for i:=1 to Length(ActPoly1.VarArray)-1 do
          if ActPoly1.VarArray[i]<>'0' then OK:=false;

        If OK then begin
          SetLength(VarArray, 1);
          If IsNumber(ActPoly1.VarArray[0]) and IsNumber(ActPoly2.VarArray[0]) then
            VarArray[0]:=FloatToStr(StrToFloat(ActPoly1.VarArray[0])/StrToFloat(ActPoly2.VarArray[0]))
          else
            VarArray[0]:=ProcessTriadLine('('+ActPoly1.VarArray[0]+')/('+ActPoly2.VarArray[0]+')');
        end;
      end;

      If act = '^' then begin
        OK:=true;
        for i:=1 to Length(ActPoly2.VarArray)-1 do
          if ActPoly2.VarArray[i]<>'0' then OK:=false;
        for i:=1 to Length(ActPoly1.VarArray)-1 do
          if ActPoly1.VarArray[i]<>'0' then OK:=false;

        If OK then begin
          SetLength(VarArray, 1);
          If IsNumber(ActPoly1.VarArray[0]) and IsNumber(ActPoly2.VarArray[0]) then
            VarArray[0]:=FloatToStr(Power(StrToFloat(ActPoly1.VarArray[0]),StrToFloat(ActPoly2.VarArray[0])))
          else
            VarArray[0]:=ProcessTriadLine('('+ActPoly1.VarArray[0]+')^('+ActPoly2.VarArray[0]+')');
        end;
      end;

      If act = 'sqrt' then begin
        OK:=true;
        for i:=1 to Length(ActPoly2.VarArray)-1 do
          if ActPoly2.VarArray[i]<>'0' then OK:=false;

        If OK then begin
          SetLength(VarArray, 1);

          If IsNumber(ActPoly2.VarArray[0]) then
            VarArray[0]:=FloatToStr(Sqrt(StrToFloat(ActPoly2.VarArray[0])))
          else
            VarArray[0]:=ProcessTriadLine('sqrt('+ActPoly2.VarArray[0]+')');
        end;
      end;

      If act = 'sin' then begin
        OK:=true;
        for i:=1 to Length(ActPoly2.VarArray)-1 do
          if ActPoly2.VarArray[i]<>'0' then OK:=false;

        If OK then begin
          SetLength(VarArray, 1);
          If IsNumber(ActPoly2.VarArray[0]) then
            VarArray[0]:=FloatToStr(sin(StrToFloat(ActPoly2.VarArray[0])/180*Pi))
          else
            VarArray[0]:=ProcessTriadLine('sin('+ActPoly2.VarArray[0]+'/180*'+FloatToStr(Pi)+')');
        end;
      end;

      If act = 'cos' then begin
        OK:=true;
        for i:=1 to Length(ActPoly2.VarArray)-1 do
          if ActPoly2.VarArray[i]<>'0' then OK:=false;

        If OK then begin
          SetLength(VarArray, 1);
          If IsNumber(ActPoly2.VarArray[0]) then
            VarArray[0]:=FloatToStr(cos(StrToFloat(ActPoly2.VarArray[0])/180*Pi))
          else
            VarArray[0]:=ProcessTriadLine('cos('+ActPoly2.VarArray[0]+'/180*'+FloatToStr(Pi)+')');
        end;
      end;
    end;
end;

function ProcessTriad(var Triads: TTriadArray; index: integer): TPolynom;
var
  op1, op2, op1T, Op2T, act, dummy: string;
  i: integer;
begin
  Result.VarName:='';
  Result.VarArray:=nil;
  With Triads[index] do begin
    op1:= Operand1;
    op1T:=Op1Type;
    op2:= Operand2;
    op2T:=Op2Type;
    act:= Action;
  end;

// first case: operand2 is a number and operand1 is empty or a number as well
  if (op2T='number') and ((op1T='number') or (op1 = '')) then
    Result:=ProcessNN(op1, op2, Act);

// second case: one operand is a number the other is a variable
  if (op2T = 'variable') and (op1T = 'number') then
    Result:=ProcessNV(op1, op2, act);
  if (op1T = 'variable') and (op2T = 'number') then
    Result:=ProcessVN(op1, op2, act);

// third case: both variables or operand2 variable
  if (op2T='variable') and ((op1T='variable') or (op1 = '')) then
    Result:=ProcessVV(op1, op2, Act);

// fourth case: triad and number
  if (op2T = 'triad') and (op1T = 'number') then
    Result:=ProcessNT(Triads, op1, op2, act);
  if (op1T = 'triad') and (op2T = 'number') then
    Result:=ProcessTN(Triads, op1, op2, act);

// fifth case: triad and variable
  if (op2T = 'triad') and (op1T = 'variable') then
    Result:=ProcessVT(Triads, op1, op2, act);
  if (op1T = 'triad') and (op2T = 'variable') then
    Result:=ProcessTV(Triads, op1, op2, act);

// sixth case: both triads or operand2 is triad
  if (op2T='triad') and ((op1T='triad') or (op1 = '')) then
    Result:=ProcessTT(Triads, op1, op2, Act);

end;

function IsNumber(S: String): Boolean;
var
  i: integer;
begin
  Result:= True;
  for i:=1 to Length(S) do begin
    If not (S[i] in ['0'..'9', ',', 'E','e','-']) then
      Result:= False;
  end;
end;

function IsProduct(S: string): Boolean;
var
  i: integer;
begin
  Result:= True;
  for i:=1 to Length(S) do
    If not (S[i] in ['0'..'9', ',', 'a'..'z', 'A'..'Z']) then
      Result:= False;
end;

function PresentResult(Triads: TTriadArray; index: integer): string;
var
  ActPoly: TPolynom;
  ActVar, ResStr: string;
  i: integer;
begin
  Result:='';
  ActPoly:= ProcessTriad(Triads, index);
  ActVar:= ActPoly.VarName;
  If Assigned(ActPoly.VarArray) then begin
    for i:= Length(ActPoly.VarArray)-1 downto 1 do
      if ActPoly.VarArray[i]<>'0' then begin

        if not IsNumber(ActPoly.VarArray[i]) or (StrToFloat(ActPoly.VarArray[i]) > 0) then
          if ActPoly.VarArray[i] = '1' then
            Result:= Result + '+' + ActVar + '^'+IntToStr(i)
          else
            If (Length(ActPoly.VarArray[i]) < 3) or
               IsNumber(Copy(ActPoly.VarArray[i], 2, Length(ActPoly.VarArray[i])-1)) then

              Result:= Result + '+' +ActPoly.VarArray[i]+ ActVar + '^'+IntToStr(i)
            else
              If ActPoly.VarArray[i][1] = '-' then
                If IsProduct(Copy(ActPoly.VarArray[i], 2, Length(ActPoly.VarArray[i])-1)) then
                  Result:= Result + '-' +Copy(ActPoly.VarArray[i], 2, Length(ActPoly.VarArray[i])-1)+ ActVar + '^'+IntToStr(i)
                else
                  Result:= Result + '-(' +Copy(ActPoly.VarArray[i], 2, Length(ActPoly.VarArray[i])-1)+')'+ ActVar + '^'+IntToStr(i)
              else
                Result:= Result + '+(' +ActPoly.VarArray[i]+')'+ ActVar + '^'+IntToStr(i);

        if IsNumber(ActPoly.VarArray[i]) and (StrToFloat(ActPoly.VarArray[i]) < 0) then
          if ActPoly.VarArray[i] = '-1' then
            Result:= Result + '-' + ActVar + '^'+IntToStr(i)
          else
            If (Length(ActPoly.VarArray[i]) < 3) or
               IsNumber(Copy(ActPoly.VarArray[i], 2, Length(ActPoly.VarArray[i])-1)) then
              Result:= Result + ActPoly.VarArray[i]+ ActVar + '^'+IntToStr(i)
            else
              Result:= Result + '-('+Copy(ActPoly.VarArray[i], 2, Length(ActPoly.VarArray[i])-1)+')'+
                       ActVar + '^'+IntToStr(i);

      end;
    If not IsNumber(ActPoly.VarArray[0]) or (StrToFloat(ActPoly.VarArray[0]) > 0) then
      Result:= Result + '+' + ActPoly.VarArray[0];
    If IsNumber(ActPoly.VarArray[0]) and (StrToFloat(ActPoly.VarArray[0]) < 0) then
      Result:= Result + ActPoly.VarArray[0];
    If Result= '' then Result:='0';  
    If Length(ActPoly.VarArray) = 1 then
      Result:=ActPoly.VarArray[0]
    else if Result[1] = '+' then
      Delete(Result, 1, 1);
    Result:=StringReplace(Result, ActVar+'^1', ActVar, [rfIgnoreCase]);
  end else begin
    If (Triads[index].Op1Type = 'triad') and (Triads[index].Op2Type = 'triad')then

      Result:='('+PresentResult(Triads, StrToInt(Copy(Triads[index].Operand1, 2, Length(Triads[index].Operand1)-2))-1)+')'+
              Triads[index].Action+
              '('+PresentResult(Triads, StrToInt(Copy(Triads[index].Operand2, 2, Length(Triads[index].Operand2)-2))-1)+')'

    else begin
      If (Triads[index].Op1Type = 'triad') then

        Result:='('+PresentResult(Triads, StrToInt(Copy(Triads[index].Operand1, 2, Length(Triads[index].Operand1)-2))-1)+')'+
                Triads[index].Action+Triads[index].Operand2;

      If (Triads[index].Op2Type = 'triad') then

        Result:=Triads[index].Operand1+Triads[index].Action+
                '('+PresentResult(Triads, StrToInt(Copy(Triads[index].Operand2, 2, Length(Triads[index].Operand2)-2))-1)+')';

      If not ((Triads[index].Op1Type = 'triad') or (Triads[index].Op2Type = 'triad')) then

        Result:=Triads[index].Operand1+Triads[index].Action+Triads[index].Operand2;

    end;
  end;

  // delete obsolete parentheses
  CleanParentheses(Result);
  // clean "[" and "]"
  Result:=StringReplace(Result, '[', '', [rfReplaceAll]);
  Result:=StringReplace(Result, ']', '', [rfReplaceAll]);
  // clean "+-"
  Result:=StringReplace(Result, '+-', '-', [rfReplaceAll]); 
end;

function ProcessTriadLine(S: string): string;
var
  Triads: TTriadArray;
  OldResult: string;
begin
  If S = '' then begin
    Result:= '';
    Exit;
  end;

  try
    Result:=S;
    If IsNumber(S) then begin
      Exit;
    end;

    Triads:=ExtractTriads(Result);
    Result:=PresentResult(Triads, Length(Triads)-1);

    If not IsNumber(Result) then begin
      Triads:=ExtractTriads(Result);
      Result:=PresentResult(Triads, Length(Triads)-1);
    end;

    If Pos('INF', Result) > 0 then
      Result:='INF';
    If Pos('NAN', Result) > 0 then
      Result:='NAN';
  except
    Result:='INF';
  end;
end;

end.
