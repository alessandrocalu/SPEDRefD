unit uBloco9;

interface
  uses Classes, SysUtils, uUtil;


{BLOCO 9: CONTROLE E ENCERRAMENTO DO ARQUIVO DIGITAL


Este bloco representa os totais de registros e serve como forma de controle para batimentos e verificações.}


{REGISTRO 9001: ABERTURA DO BLOCO 9}

{Este registro deve sempre ser gerado e representa a abertura do Bloco 9.

Observações: Registro obrigatório
Nível hierárquico - 1
Ocorrência - um (por arquivo)
}

  type TReg9001 = class

  private

    pREG: String; // Texto fixo contendo |9001| - C(4F)*
    {Campo 01 - Valor Válido: [9001]}

    pIND_MOV: integer; // Indicador de movimento: 0 - Bloco com dados informados; 1 – Bloco sem dados informados.  - N(1)*
    {Campo 02 - Valores válidos: [0, 1]
Validação: se o valor deste campo for igual a “1” (um), somente podem ser informados os registros de abertura e
encerramento do bloco. Se o valor neste campo for igual a “0” (zero), deve ser informado pelo menos um registro além dos
registros de abertura e encerramento do bloco.}


  protected

    function getREG : String;
    function getIND_MOV : integer;

    procedure setREG(lREG : String);
    procedure setIND_MOV(lIND_MOV : integer);


  public
    Constructor Create;
    Destructor Destroy; override;
    function getLinha: string;


    property REG: String read getREG write setREG;
    property IND_MOV : integer read getIND_MOV write setIND_MOV;
  end;



{REGISTRO 9900: REGISTROS DO ARQUIVO}
{Todos os registros referenciados neste arquivo, inclusive os posteriores a este registro, devem ter uma linha totalizadora do seu
número de ocorrências.
Observações: Registro obrigatório
Nível hierárquico - 2
Ocorrência - vários (por arquivo)
}

  type TReg9900 = class

  private

    pREG: String; // Texto fixo contendo |9900| - C(4F)*
    {Campo 01 - Valor Válido: [9900]}

    pREG_BLC: String; // Registro que será totalizado no próximo campo - C(4)*
    {Campo 02 - Preenchimento: informar cada um dos códigos de registros válidos deste arquivo, que será totalizado no próximo
campo QTD_REG_BLC.}

    pQTD_REG_BLC: Integer; // Total de registros do tipo informado no campo anterior. - N(-)*
    {Campo 03 - Validação: verifica se o número de linhas no arquivo do tipo informado no campo REG_BLC do registro 9900 é
igual ao valor informado neste campo.}



  protected

    function getREG: string;
    function getREG_BLC: string;
    function getQTD_REG_BLC: Integer;

    procedure setREG(lREG: string);
    procedure setREG_BLC(lREG_BLC: string);
    procedure setQTD_REG_BLC(lQTD_REG_BLC: Integer);


  public
    Constructor Create;
    Destructor Destroy; override;
    function getLinha: string;

    property REG: String read getREG write setREG;
    property REG_BLC: String read getREG_BLC write setREG_BLC;
    property QTD_REG_BLC: Integer read getQTD_REG_BLC write setQTD_REG_BLC;
  end;



  {REGISTRO 9990: ENCERRAMENTO DO BLOCO 9}
  {Este registro destina-se a identificar o encerramento do Bloco 9 e a informar a quantidade de linhas (registros) existentes no
bloco.
Observações: Registro obrigatório
Nível hierárquico - 1
Ocorrência - um (por arquivo)}

  type TReg9990 = class

  private

    pREG: String; // Texto fixo contendo |9990| - C(4)*
    {Campo 01 - Valor Válido: [9990]}

    pQTD_LIN_9: Integer; // Quantidade total de linhas do Bloco 9

    {Campo 02 - Preenchimento: a quantidade de linhas a ser informada deve considerar também os próprios registros de
abertura e encerramento do bloco. Para este cálculo, o registro 9999, apesar de não pertencer ao Bloco 9, também deve ser
contabilizado nesta soma.
Validação: o número de linhas (registros) existentes no bloco 9 é igual ao valor informado no campo QTD_LIN_9.}


  protected

    function getREG: string;
    function getQTD_LIN_9: Integer;

    procedure setREG(lREG: string);
    procedure setQTD_LIN_9(lQTD_LIN_9: Integer);


  public
    Constructor Create;
    Destructor Destroy; override;
    function getLinha: string;

    property REG: String read getREG write setREG;
    property QTD_LIN_9: Integer read getQTD_LIN_9 write setQTD_LIN_9;
  end;



  {REGISTRO 9999: ENCERRAMENTO DO ARQUIVO DIGITAL}
  {Este registro destina-se a identificar o encerramento do arquivo digital da escrituração do PIS/Pasep, da Cofins e da
Contribuição Previdenciária sobre a receita bruta, conforme o caso, bem como a informar a quantidade de linhas (registros)
existentes no arquivo.}

  type TReg9999 = class

  private

    pREG: String; // Texto fixo contendo |9999| - C(4)*
    {Campo 01 - Valor Válido: [9999]}

    pQTD_LIN: Integer; // Quantidade total de linhas do arquivo digital.
    {Campo 02 - Preenchimento: a quantidade de linhas a ser informada deve considerar também a linha correspondente ao
próprio registro 9999.
Validação: o número de linhas (registros) existentes no arquivo inteiro é igual ao valor informado no campo QTD_LIN.}

  protected

    function getREG: string;
    function getQTD_LIN: Integer;

    procedure setREG(lREG: string);
    procedure setQTD_LIN(lQTD_LIN: Integer);


  public
    Constructor Create;
    Destructor Destroy; override;
    function getLinha: string;

    property REG: String read getREG write setREG;
    property QTD_LIN: Integer read getQTD_LIN write setQTD_LIN;
  end;



  {BLOCO 9: CONTROLE E ENCERRAMENTO DO ARQUIVO DIGITAL}
  type TBloco9 = class

  public
    reg9001: TReg9001;
    reg9900: TReg9900;
    reg9990: TReg9990;
    reg9999: TReg9999;
    Constructor Create;
    Destructor Destroy; override;
  end;

var
  bloco9: TBloco9;

implementation


{ TReg9001 }
{REGISTRO 9001: ABERTURA DO BLOCO 9}

constructor TReg9001.Create;
begin
  inherited create;
  {Inicializa valores padrão}
  pREG := '9001';
  pIND_MOV := 0;
end;

destructor TReg9001.Destroy;
begin
 {}
 inherited;
end;

function TReg9001.getLinha: string;
begin
  Result := '|';
  Result := Result + pREG + '|';
  Result := Result + TUtil.FormataIntegerNumeralFixo(pIND_MOV,1,True) + '|';
  bloco9.reg9990.pQTD_LIN_9 := bloco9.reg9990.pQTD_LIN_9 + 1;
end;

function TReg9001.getREG : String;
begin
  Result := pREG;
end;

function TReg9001.getIND_MOV : integer;
begin
  Result := pIND_MOV;
end;


procedure TReg9001.setREG(lREG : String);
begin
  pREG := lREG;
end;

procedure TReg9001.setIND_MOV(lIND_MOV : integer);
begin
  pIND_MOV := lIND_MOV;
end;



{ TReg9900 }
{REGISTRO 9900: REGISTROS DO ARQUIVO}

constructor TReg9900.Create;
begin
  inherited create;
  {Inicializa valores padrão}
  pREG := '9900';
  pREG_BLC := '';
  pQTD_REG_BLC := 0;
end;

destructor TReg9900.Destroy;
begin
 {}
 inherited;
end;

function TReg9900.getLinha: string;
begin
  Result := '|';
  Result := Result + pREG + '|';
  Result := Result + pREG_BLC + '|';
  Result := Result + TUtil.FormataInteger(pQTD_REG_BLC, True) + '|';
  bloco9.reg9990.pQTD_LIN_9 := bloco9.reg9990.pQTD_LIN_9 + 1;
end;

function TReg9900.getREG : String;
begin
  Result := pREG;
end;

function TReg9900.getREG_BLC : String;
begin
  Result := pREG_BLC;
end;

function TReg9900.getQTD_REG_BLC : integer;
begin
  Result := pQTD_REG_BLC;
end;


procedure TReg9900.setREG(lREG : String);
begin
  pREG := lREG;
end;

procedure TReg9900.setREG_BLC(lREG_BLC : string);
begin
  pREG_BLC := lREG_BLC;
end;

procedure TReg9900.setQTD_REG_BLC(lQTD_REG_BLC : integer);
begin
  pQTD_REG_BLC := lQTD_REG_BLC;
end;




{ TReg9990 }
{REGISTRO 9990: ENCERRAMENTO DO BLOCO 9}
constructor TReg9990.Create;
begin
  inherited create;
  {Inicializa valores padrão}
  pREG := '9990';
  pQTD_LIN_9 := 0;
end;

destructor TReg9990.Destroy;
begin
 {}
 inherited;
end;

function TReg9990.getLinha: string;
begin
  bloco9.reg9990.pQTD_LIN_9 := bloco9.reg9990.pQTD_LIN_9 + 1;
  Result := '|';
  Result := Result + pREG + '|';
  Result := Result + TUtil.FormataInteger(pQTD_LIN_9, True) + '|';
end;

function TReg9990.getREG: string;
begin
  Result := pREG;
end;

function TReg9990.getQTD_LIN_9: Integer;
begin
  Result := pQTD_LIN_9;
end;

procedure TReg9990.setREG(lREG: string);
begin
  pREG:= lREG;
end;

procedure TReg9990.setQTD_LIN_9(lQTD_LIN_9: Integer);
begin
  pQTD_LIN_9:= lQTD_LIN_9;
end;




{ TReg9999 }
{REGISTRO 9999: ENCERRAMENTO DO ARQUIVO DIGITAL}
constructor TReg9999.Create;
begin
  inherited create;
  {Inicializa valores padrão}
  pREG := '9999';
  pQTD_LIN := 0;
end;

destructor TReg9999.Destroy;
begin
 {}
 inherited;
end;

function TReg9999.getLinha: string;
begin
  Result := '|';
  Result := Result + pREG + '|';
  Result := Result + TUtil.FormataInteger(pQTD_LIN, True) + '|';
end;

function TReg9999.getREG: string;
begin
  Result := pREG;
end;

function TReg9999.getQTD_LIN: Integer;
begin
  Result := pQTD_LIN;
end;

procedure TReg9999.setREG(lREG: string);
begin
  pREG:= lREG;
end;

procedure TReg9999.setQTD_LIN(lQTD_LIN: Integer);
begin
  pQTD_LIN:= lQTD_LIN;
end;



{REGISTRO 9990: ENCERRAMENTO DO BLOCO 9}
constructor TBloco9.Create;
begin
  inherited create;
  {Inicializa valores padrão}
  reg9001 := TReg9001.Create;
  reg9900 := TReg9900.Create;
  reg9990 := TReg9990.Create;
  reg9999 := TReg9999.Create;
end;

destructor TBloco9.Destroy;
begin
 {Destroi registros}
  reg9001.Destroy;
  reg9900.Destroy;
  reg9990.Destroy;
  reg9999.Destroy;
 inherited;
end;



end.
