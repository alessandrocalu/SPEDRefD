unit uUtil;

interface
uses SysUtils;

type TUtil = class

public
  class function UltimoDiaDoMes( MesAno: string ): string;
  class Function ApenasNumerosStr(nStr:String): String;
  class function Replicate(S: String; qt: Integer): String;
  class Function FormataStringNumeralFixo(S: String; tam: Integer; Obrigatorio: Boolean): String;
  class Function FormataIntegerNumeralFixo(Numero: Integer; tam: Integer; Obrigatorio: Boolean): String;
  class Function FormataDataFixo(D: TDate; Obrigatorio: Boolean): String;
  class Function FormataInteger(Numero: Integer; Obrigatorio: Boolean): String;
  class Function FormataCurrency(Valor: Currency; Obrigatorio: Boolean): String;
  class Function PontoToVirgula(nStr:String): String;
end;

implementation

class function TUtil.UltimoDiaDoMes( MesAno: string ): string;
  var
  sMes: string;
  sAno: string;
begin
  sMes := Copy( MesAno, 1, 2 );
  sAno := Copy( MesAno, 4, 2 );
  if Pos( sMes, '01 03 05 07 08 10 12' ) > 0 then
    UltimoDiaDoMes := '31'
  else if sMes <> '02' then
    UltimoDiaDoMes := '30'
  else if ( StrToInt( sAno ) mod 4 ) = 0 then
    UltimoDiaDoMes := '29'
  else
    UltimoDiaDoMes := '28';
end;


class Function TUtil.ApenasNumerosStr(nStr:String): String;
Var
   I: Integer;
begin
     Result := '';
     for I := 1 to Length(nStr) do
         if nStr[I] in ['0'..'9'] then
            Result := Result + nStr[I];
end;

class Function TUtil.PontoToVirgula(nStr:String): String;
Var
   I: Integer;
begin
  Result := '';
  for I := 1 to Length(nStr) do
  begin
    if nStr[I] in ['0'..'9'] then
      Result := Result + nStr[I];
    if nStr[I] = '.' then
      Result := Result + ',';
  end;
end;

class Function TUtil.Replicate(S: String; qt: Integer): String;
  var n: integer;
begin
  Result := '';
  For n := 1 To Qt Do
  Result := Result + S;
end;

class Function TUtil.FormataStringNumeralFixo(S: String; tam: Integer; Obrigatorio: Boolean): String;
  var tamS: integer;
begin
  Result := '';
  S := ApenasNumerosStr(S);
  tamS := Length(S);
  if ((tamS > 0) or Obrigatorio) then
  begin
    if (tamS > tam) then
    begin
      Result := copy(S,(tamS-tam),tam);
    end
    else
    begin
      Result := Replicate('0',(tam-tamS))+S;
    end;
  end;
end;

class Function TUtil.FormataIntegerNumeralFixo(Numero: Integer; tam: Integer; Obrigatorio: Boolean): String;
  var tamS: integer;
      S :string;
begin
  Result := '';
  if ((Numero = -1) and Obrigatorio)  then
  begin
    Numero := 0;
  end;

  if (Numero <> -1) then
  begin
    Result := FormataStringNumeralFixo(IntToStr(Numero),tam, True);
  end;
end;


class Function TUtil.FormataInteger(Numero: Integer; Obrigatorio: Boolean): String;
begin
  Result := '';
  if ((Numero = -1) and Obrigatorio)  then
  begin
    Numero := 0;
  end;

  if (Numero <> -1) then
  begin
    Result := IntToStr(Numero);
  end;
end;

class Function TUtil.FormataCurrency(Valor: Currency; Obrigatorio: Boolean): String;
begin
  Result := '';
  if ((Valor = -1) and Obrigatorio)  then
  begin
    Valor := 0;
  end;

  if (Valor <> -1) then
  begin
    // Display with a new decimal point character
    Result := FormatFloat('0.##', Valor); //PontoToVirgula(FormatFloat('#.00', Valor));
  end;
end;

class Function TUtil.FormataDataFixo(D: TDate; Obrigatorio: Boolean): String;
Begin
  Result := '';
  if ((D = 0) and Obrigatorio) then
  Begin
    D := Date();
  End;

  if (D > 0) then
  begin
    Result := FormatDateTime('ddmmyyyy',D);
  end;
End;

end.
