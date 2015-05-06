unit uBloco0;

interface
  uses Classes, SysUtils, uUtil;


{
O = O registro � sempre obrigat�rio.
OC = O registro � obrigat�rio, se houver informa��o a ser prestada. Ex. Registro C100 � s� dever� ser
apresentado se houver movimenta��o ou opera��es utilizando os documentos de c�digos 01, 1B, 04 ou 55.
O(...) = O registro � obrigat�rio se atendida a condi��o. Ex. Registro C191 � O (Se existir C190) � O registro
� obrigat�rio sempre que houver o registro C190.
N = O registro n�o deve ser informado. Ex. Registro C490 � se for informado o Registro C400.



1) N� = Indica o n�mero do campo em um dado registro
2) Campo = Indica o mnem�nico do campo.
3) Descri��o = Indica a descri��o da informa��o requerida no campo respectivo.
� Deve-se atentar para as observa��es relativas ao preenchimento de cada campo, quando
houver.
4) Tipo = Indica o tipo de caractere com que o campo ser� preenchido, de acordo com as regras gerais j�
descritas.
� N - Num�rico;
� C - Alfanum�rico.
5) Tam Indica a quantidade de caracteres com que cada campo deve ser preenchido.
� A indica��o de um algarismo ap�s um campo (N) representa o seu tamanho m�ximo;
� A indica��o "-" ap�s um campo (N) significa que n�o h� um n�mero m�ximo de caracteres;
� A indica��o de um algarismo ap�s um campo (C) representa o seu tamanho m�ximo, no caso geral;
� A indica��o "-" ap�s um campo (C) representa que seu tamanho m�ximo � 255 caracteres, no caso geral;
� A indica��o "65536" ap�s um campo (C) representa que seu tamanho m�ximo � 65.536 caracteres, excepcionalmente.
� O caractere �F� (fixo) no tamanho de campo indica que o campo dever� ser preenchido exatamente com o n�mero de caracteres informado.
Dec Indica a quantidade de caracteres que devem constar como casas decimais, quando necess�rias.
� A indica��o de um algarismo representa a quantidade m�xima de decimais do campo (N);
� A indica��o "-" ap�s um campo (N) significa que n�o deve haver representa��o de casas decimais.

* indica campos obrigat�rios

}


{REGISTRO 0000: ABERTURA DO ARQUIVO DIGITAL E IDENTIFICA��O DA PESSOA JUR�DICA - Obrigat�rio (1)}

  type TReg0000 = class

  private
    pREG : String; //Valor V�lido |0000| - C(4F)*

    pCOD_VER : String;  //C�digo da vers�o do leiaute conforme a tabela 3.1.1. - N(3F)*
    {Campo 02 - Preenchimento: o c�digo da vers�o do leiaute informado � validado conforme a data referenciada no campo
DT_FIN. Verificar na Tabela Vers�o, item 3.1.1 do Anexo �nico do ADE Cofis n� 34, de 28 de outubro de 2010 e altera��es.
Para a vers�o 1.01 do Programa Validador e Assinador (PVA) da EFD-Contribui��es, deve ser informado o c�digo �002�
Valida��o: V�lido para per�odo informado. A vers�o do leiaute informada no arquivo dever� ser v�lida na data final da
escritura��o (campo DT_FIN do registro 0000)}

    pTIPO_ESCRIT : integer;  //Tipo de Escritura��o 0 - Original; 1 � Retificadora. - N(1F)*
    {Campo 03 - Valores V�lidos: [0, 1]
Preenchimento: Informar o tipo de escritura��o � original ou retificadora. Para a entrega da EFD-Contribui��es dever� ser
utilizado o leiaute vigente � �poca do per�odo de apura��o e, para valida��o e transmiss�o, a vers�o do Programa de Valida��o
e Assinatura - PVA atualizada.}

    pIND_SIT_ESP : integer;  // Indicador de situa��o especial: 0 - Abertura; 1 - Cis�o; 2 - Fus�o; 3 - Incorpora��o; 4 � Encerramento - N(1F)
    {Campo 04 - Preenchimento: Este campo somente deve ser preenchido se a escritura��o fiscal se referir � situa��o especial decorrente
de abertura, cis�o, fus�o, incorpora��o ou encerramento da pessoa jur�dica.

OBSERVA��O:
Com regra, a pessoa jur�dica deve escriturar apenas uma escritura��o em rela��o a cada per�odo de apura��o mensal. Exce��o a
essa regra aplica-se apenas ao caso de cis�o parcial, em que poder� haver mais de um arquivo no mesmo m�s, para o mesmo
contribuinte.
Nos casos de eventos de incorpora��o, cada pessoa jur�dica participante do evento de sucess�o deve entregar a escritura��o, em
rela��o ao per�odo a que as obriga��es e cr�ditos s�o de sua responsabilidade de escritura��o. Assim, a t�tulo exemplificativo,
em que a empresa A incorpora a empresa B, no dia 17.01.2012, ter�amos:
- A EFD da empresa A (CNPJ da incorporadora), contemplando todo o per�odo, de 01 a 31 de janeiro, registrando em F800
eventuais cr�ditos vertidos na sucess�o;
- A EFD da empresa B (CNPJ da incorporada), contemplando apenas o per�odo, de 01 a 17 de janeiro.}

    pNUM_REC_ANTERIOR: string; // N�mero do Recibo da Escritura��o anterior a ser retificada, utilizado quando TIPO_ESCRIT for igual a 1 - C(41F)
    {Campo 05 - Preenchimento: Este campo somente deve ser preenchido quando a escritura��o fiscal se referir a retifica��o de
escritura��o j� transmitida, original ou retificadora. Neste caso, deve a pessoa jur�dica informar neste campo o n�mero do recibo
da escritura��o anterior, a ser retificada.}

    pDT_INI: TDate; //Data inicial das informa��es contidas no arquivo. - D(8F)*
    {Campo 06 - Preenchimento: Informar a data inicial das informa��es referentes ao per�odo da escritura��o, no padr�o �diam�sano�
(ddmmaaaa), excluindo-se quaisquer caracteres de separa��o, tais como: �.�, �/�, �-�.
Valida��o: Verificar se a data informada neste campo pertence ao mesmo m�s/ano da data informada no campo DT_FIN.
O valor informado deve ser o primeiro dia do mesmo m�s de referencia da escritura��o, exceto no caso de abertura, conforme
especificado no campo 04.}

    pDT_FIN: TDate; //Data final das informa��es contidas no arquivo. - D(8F)*
    {Campo 07 - Preenchimento: Informar a data final das informa��es referentes ao per�odo da escritura��o, no padr�o �diam�sano�
(ddmmaaaa), excluindo-se quaisquer caracteres de separa��o, tais como: �.�, �/�, �-�.
Valida��o: Verificar se a data informada neste campo pertence ao mesmo m�s/ano da data informada no campo DT_INI.
O valor informado deve ser o �ltimo dia do m�s a que se refere a escritura��o, exceto nos casos de encerramento de atividades,
fus�o, cis�o e incorpora��o.}

    pNOME: string; //Nome empresarial da pessoa jur�dica - C(100)*
    {Campo 08 - Preenchimento: Informar o nome empresarial da pessoa jur�dica titular da escritura��o.}

    pCNPJ: string; //N�mero de inscri��o do estabelecimento matriz da pessoa jur�dica no CNPJ. - N(14F)*
    {Campo 09 - Preenchimento: Informar o n�mero de inscri��o do contribuinte no cadastro do CNPJ.
Valida��o: ser� conferido o d�gito verificador (DV) do CNPJ informado.}

    pUF: string; //Sigla da Unidade da Federa��o da pessoa jur�dica. - C(2F)*
    {Campo 10 - Preenchimento: Informar a sigla da unidade da federa��o (UF) do estabelecimento sede, respons�vel pela escritura��o
fiscal digital do PIS/Pasep e da Cofins.}

    pCOD_MUN: string; // C�digo do munic�pio do domic�lio fiscal da pessoa jur�dica, conforme a tabela IBGE - N(7F)*
    {Campo 11 � Preenchimento: Informar o c�digo de munic�pio do domic�lio fiscal da pessoa jur�dica, conforme codifica��o
constante da Tabela de Munic�pios do IBGE.
Valida��o: o valor informado no campo deve existir na Tabela de Munic�pios do IBGE, possuindo 7 d�gitos.}

    pSUFRAMA: string; // Inscri��o da pessoa jur�dica na Suframa - C(9F)
    {Campo 12 � Preenchimento: Informar neste campo a inscri��o da pessoa jur�dica titular da escritura��o na SUFRAMA. Caso
a pessoa jur�dica n�o tenha inscri��o na SUFRAMA este campo deve ser informado em branco.
Valida��o: ser� conferido o d�gito verificador (DV) do n�mero de inscri��o na SUFRAMA, se informado.}

    pIND_NAT_PJ: string; // Indicador da natureza da pessoa jur�dica: 00 � Pessoa jur�dica em geral; 01 � Sociedade cooperativa;
                        // 02 � Entidade sujeita ao PIS/Pasep exclusivamente com base na Folha de Sal�rios; N(2F)
{ Indicador da natureza da pessoa jur�dica, a partir do ano-calend�rio de 2014:
00 � Pessoa jur�dica em geral (n�o participante de SCP como s�cia ostensiva)
01 � Sociedade cooperativa (n�o participante de SCP como s�cia ostensiva)
02 � Entidade sujeita ao PIS/Pasep exclusivamente com base na Folha de Sal�rios
03 - Pessoa jur�dica em geral participante de SCP como s�cia ostensiva
04 � Sociedade cooperativa participante de SCP como s�cia ostensiva
05 � Sociedade em Conta de Participa��o - SCP}

{Campo 13 - Valores V�lidos: [00, 01, 02, 03, 04, 05]
Preenchimento: informar a natureza da pessoa jur�dica, conforme um dos tr�s tipos abaixo:
00 � Sociedade empres�ria em geral
01 � Sociedade cooperativa
02 � Entidade sujeita ao PIS/Pasep exclusivamente com base na Folha de Sal�rios}


    pIND_ATIV:integer; // Indicador de tipo de atividade preponderante: 0 � Industrial ou equiparado a industrial; 1 � Prestador de servi�os;
                     // 2 - Atividade de com�rcio; 3 � Pessoas jur�dicas referidas nos �� 6�, 8� e 9� do art. 3� da Lei n� 9.718, de 1998;
                     // 4 � Atividade imobili�ria; 9 � Outros. - N(1)* - Obrigat�rio
{Campo 14 - Valores V�lidos: [0, 1, 2, 3, 4, 9]
Preenchimento: informar o indicador da atividade preponderante exercida pela pessoa jur�dica no per�odo da escritura��o,
conforme um dos tipos abaixo:
0 � Industrial ou equiparado a industrial;
1 � Prestador de servi�os;
2 - Atividade de com�rcio;
3 � Pessoas jur�dicas referidas nos �� 6�, 8� e 9� do art. 3� da Lei n� 9.718, de 1998;
4 � Atividade imobili�ria;
9 � Outros

Caso a pessoa jur�dica tenha exercido mais de uma das atividades acima relacionadas, no per�odo da escritura��o, deve o campo
ser preenchido com o c�digo correspondente � atividade preponderante.
}


  protected

    function getREG : String;
    function getCOD_VER : String;
    function getTIPO_ESCRIT : integer;
    function getIND_SIT_ESP : integer;
    function getNUM_REC_ANTERIOR: string;
    function getDT_INI: TDate;
    function getDT_FIN: TDate;
    function getNOME: string;
    function getCNPJ: string;
    function getUF: string;
    function getCOD_MUN: string;
    function getSUFRAMA: string;
    function getIND_NAT_PJ: string;
    function getIND_ATIV:integer;

    procedure setREG(lREG : String);
    procedure setCOD_VER(lCOD_VER : String);
    procedure setTIPO_ESCRIT(lTIPO_ESCRIT : integer);
    procedure setIND_SIT_ESP(lIND_SIT_ESP : integer);
    procedure setNUM_REC_ANTERIOR(lNUM_REC_ANTERIOR: string);
    procedure setDT_INI(lDT_INI: TDate);
    procedure setDT_FIN(lDT_FIN: TDate);
    procedure setNOME(lNOME: string);
    procedure setCNPJ(lCNPJ: string);
    procedure setUF(lUF: string);
    procedure setCOD_MUN(lCOD_MUN: string);
    procedure setSUFRAMA(lSUFRAMA: string);
    procedure setIND_NAT_PJ(lIND_NAT_PJ: string);
    procedure setIND_ATIV(lIND_ATIV:integer);

  public
    Constructor Create;
    Destructor Destroy; override;
    function getLinha: string;


    property REG: String read getREG write setREG;
    property COD_VER : String read getCOD_VER write setCOD_VER;
    property TIPO_ESCRIT : integer read getTIPO_ESCRIT write setTIPO_ESCRIT;
    property IND_SIT_ESP : integer read getIND_SIT_ESP write setIND_SIT_ESP;
    property NUM_REC_ANTERIOR: string read getNUM_REC_ANTERIOR write setNUM_REC_ANTERIOR;
    property DT_INI: TDate read getDT_INI write setDT_INI;
    property DT_FIN: TDate read getDT_FIN write setDT_FIN;
    property NOME: string read getNOME write setNOME;
    property CNPJ: string read getCNPJ write setCNPJ;
    property UF: string read getUF write setUF;
    property COD_MUN: string read getCOD_MUN write setCOD_MUN;
    property SUFRAMA: string read getSUFRAMA write setSUFRAMA;
    property IND_NAT_PJ: string read getIND_NAT_PJ write setIND_NAT_PJ;
    property IND_ATIV: integer read getIND_ATIV write setIND_ATIV;
  end;




{REGISTRO 0001: ABERTURA DO BLOCO 0 - Obrigat�rio (1)

Observa��es: Registro obrigat�rio. Deve ser gerado para abertura do Bloco 0 e indica se h� informa��es previstas para este
bloco.
N�vel hier�rquico - 1
Ocorr�ncia - um (por arquivo)
}

  type TReg0001 = class

  private

    pREG: String; // Texto fixo contendo |0001| - C(4F)*
    {Campo 01 - Valor V�lido: [0001]}

    pIND_MOV: integer; // Indicador de movimento: 0 - Bloco com dados informados; 1 � Bloco sem dados informados.  - N(1)*
    {Campo 02 - Valor V�lido: [0,1]
Considerando que na escritura��o do Bloco �0� deve ser escriturado, no m�nimo, os registros �0110 - Regimes de Apura��o da
Contribui��o Social e de Apropria��o de Cr�dito� e �0140 � Tabela de Cadastro de Estabelecimento�, deve sempre ser
informado, no Campo 02, o indicador �0 � Bloco com dados informados�.}


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



  {REGISTRO 0100: DADOS DO CONTABILISTA}

  {Observa��es:
1. Registro obrigat�rio, utilizado para identifica��o do contabilista respons�vel pela escritura��o fiscal da empresa, mesmo que
o contabilista seja funcion�rio da empresa ou prestador de servi�o.
2. Apesar das contribui��es sociais serem apuradas de forma centralizada pelo estabelecimento matriz, as informa��es dos
Blocos A, C, D e F s�o escrituradas por estabelecimento. Neste sentido, caso a pessoa jur�dica tenha mais de um contabilista
respons�vel pela escritura��o fiscal de suas opera��es, estes devem ser relacionados no registro 0100.
N�vel hier�rquico � 2
Ocorr�ncia - V�rios (por arquivo)}

  type TReg0100 = class

  private

    pREG: String; // Texto fixo contendo |0100| - C(4F)*
    {Campo 01 - Valor V�lido: [0100]}

    pNOME: string; // Nome do contabilista. C(100)*
    {Campo 02 - Preenchimento: informar o nome do contabilista respons�vel.}

    pCPF: string; // N�mero de inscri��o do contabilista no CPF. N(11F)*
    {Campo 03 - Preenchimento: informar o n�mero do CPF do contabilista respons�vel pela escritura��o, cujo numero de inscri��o
no CRC foi informado no campo 04; n�o utilizar os caracteres especiais de formata��o, tais como: ".", "/", "-".
Valida��o: ser� conferido o d�gito verificador (DV) do CPF informado.}

    pCRC: string; // N�mero de inscri��o do contabilista no Conselho Regional de Contabilidade.  C(15)*
    {Campo 04 - Preenchimento: informar o n�mero de inscri��o do contabilista no Conselho Regional de Contabilidade na
UF do estabelecimento sede.}

    pCNPJ: string; // N�mero de inscri��o do escrit�rio de contabilidade no CNPJ, se houver. N(14F)
    {Campo 05 - Preenchimento: informar o n�mero de inscri��o no Cadastro Nacional de Pessoa Jur�dica do escrit�rio de
contabilidade; n�o informar caracteres de formata��o, tais como: ".", "/", "-".
Valida��o: ser� conferido o d�gito verificador (DV) do CNPJ informado.}

    pCEP: string; // C�digo de Endere�amento Postal. N(8F)
    {Campo 06 - Preenchimento: informar o n�mero do C�digo de Endere�amento Postal - CEP, conforme cadastro nos
CORREIOS.}

    pENDERECO: string; //  Logradouro e endere�o do im�vel. C(60)
    {Campo 07 - Preenchimento: informar o endere�o do contabilista/escrit�rio de contabilidade.}

    pNUM: string; //  N�mero do im�vel. C(-)
    pCOMPL: string; // Dados complementares do endere�o. C(60)
    pBAIRRO: string; // Bairro em que o im�vel est� situado. C(60)
    pFONE: string; // N�mero do telefone. C(11)
    pFAX: string; //  N�mero do fax. C(11)

    pEMAIL: string; // Endere�o do correio eletr�nico. C(-)
    {Campo 13 - Preenchimento: informar o endere�o de correio eletr�nico do contabilista/escrit�rio de contabilidade}

    pCOD_MUN: string; // C�digo do munic�pio, conforme tabela IBGE. N(7F)
    {Campo 14 - Preenchimento: informar o c�digo do munic�pio do domic�lio fiscal do contabilista/escrit�rio de
contabilidade.
Valida��o: o valor informado no campo deve existir na Tabela de Munic�pios do IBGE (combina��o do c�digo da UF e o c�digo
de munic�pio), possuindo 7 d�gitos.}

  protected

    function getREG: string;
    function getNOME: string;
    function getCPF: string;
    function getCRC: string;
    function getCNPJ: string;
    function getCEP: string;
    function getENDERECO: string;
    function getNUM: string;
    function getCOMPL: string;
    function getBAIRRO: string;
    function getFONE: string;
    function getFAX: string;
    function getEMAIL: string;
    function getCOD_MUN: string;

    procedure setREG(lREG: string);
    procedure setNOME(lNOME: string);
    procedure setCPF(lCPF: string);
    procedure setCRC(lCRC: string);
    procedure setCNPJ(lCNPJ: string);
    procedure setCEP(lCEP: string);
    procedure setENDERECO(lENDERECO: string);
    procedure setNUM(lNUM: string);
    procedure setCOMPL(lCOMPL: string);
    procedure setBAIRRO(lBAIRRO: string);
    procedure setFONE(lFONE: string);
    procedure setFAX(lFAX: string);
    procedure setEMAIL(lEMAIL: string);
    procedure setCOD_MUN(lCOD_MUN: string);


  public
    Constructor Create;
    Destructor Destroy; override;
    function getLinha: string;


    property REG: String read getREG write setREG;
    property NOME: String read getNOME write setNOME;
    property CPF: String read getCPF write setCPF;
    property CRC: String read getCRC write setCRC;
    property CNPJ: String read getCNPJ write setCNPJ;
    property CEP: String read getCEP write setCEP;
    property ENDERECO: String read getENDERECO write setENDERECO;
    property NUM: String read getNUM write setNUM;
    property COMPL: String read getCOMPL write setCOMPL;
    property BAIRRO: String read getBAIRRO write setBAIRRO;
    property FONE: String read getFONE write setFONE;
    property FAX: String read getFAX write setFAX;
    property EMAIL: string read getEMAIL write setEMAIL;
    property COD_MUN: String read getCOD_MUN write setCOD_MUN;
  end;




  {REGISTRO 0110: REGISTRO 0110: REGIMES DE APURA��O DA CONTRIBUI��O SOCIAL E DE APROPRIA��O DE CR�DITO}
  {Este registro tem por objetivo definir o regime de incid�ncia a que se submete a pessoa jur�dica (n�o-cumulativo, cumulativo
ou ambos os regimes) no per�odo da escritura��o. No caso de sujei��o ao regime n�o-cumulativo, ser� informado tamb�m o
m�todo de apropria��o do cr�dito incidente sobre opera��es comuns a mais de um tipo de receita adotado pela pessoa jur�dica
para o ano-calend�rio.}

{1. Registro obrigat�rio. Informar somente os regimes de apura��o a que se submeteu a pessoa jur�dica no per�odo da
escritura��o.
2. O campo 05 (IND_REC_CUM) n�o dever� constar no arquivo da escritura��o a ser importado pelo PVA,
vers�o 2.00, vers�o essa que acresce em rela��o � vers�o anterior (1.07), os registros da escritura��o da Contribui��o
Previdenci�ria sobre a Receita Bruta (Bloco P). O referido campo 05 s� dever� constar no arquivo da escritura��o a
ser importado pelo PVA na vers�o 2.01A, com previs�o de disponibiliza��o em julho de 2012, que ir� ent�o constar
com os registros da escritura��o do PIS/Pasep e da Cofins, para a pessoa jur�dica tributada com base no lucro
presumido.
Desta forma, no arquivo gerado para ser importado nas vers�es 1.07 e 2.00 do PVA, o registro �0110� dever� ser
informado com apenas 04 (quatro) campos.
N�vel hier�rquico - 2
Ocorr�ncia � um (por arquivo)

OBS: Os registros e campos referentes � escritura��o do PIS/Pasep e da Cofins das pessoas jur�dicas sujeitas ao regime
de tributa��o com base no lucro presumido, aplic�vel para os fatos geradores a ocorrer a partir de 01 de julho de
2012, ser�o disponibilizados pelo Programa Validador e Assinador (PVA) da EFD-Contribui��es, vers�o 2.01A, com
previs�o de disponibiliza��o pela Receita Federal em junho/2012.

Caso a escritura��o seja efetuada mediante a importa��o de arquivo �txt�, na vers�o 2.01A do PVA, com previs�o de
disponibiliza��o em junlo/2012, o registro �0110� dever� ser gerado com 05 (cinco) campos. Na edi��o de dados}

  type TReg0110 = class

  private

    pREG: String; // Texto fixo contendo |0110| - C(4F)*
    {Campo 01 - Valor V�lido: [0110]}

    pCOD_INC_TRIB: integer; // C�digo indicador da incid�ncia tribut�ria no per�odo: - N(1F)*
                            {1 � Escritura��o de opera��es com incid�ncia exclusivamente no regime n�o-cumulativo;
                             2 � Escritura��o de opera��es com incid�ncia exclusivamente no regime cumulativo;
                             3 � Escritura��o de opera��es com incid�ncia nos regimes n�o-cumulativo e cumulativo. }
    {Campo 02 - Valores v�lidos: [1;2;3]
Preenchimento: indicar o c�digo correspondente ao(s) regime(s) de apura��o das contribui��es sociais a que se submete a
pessoa jur�dica no per�odo da escritura��o:
- No caso da pessoa sujeitar-se apenas � incid�ncia n�o cumulativa, deve informar o indicador �1�;
- No caso da pessoa sujeitar-se apenas � incid�ncia cumulativa, deve informar o indicador �2�;
- No caso da pessoa sujeitar-se aos dois regimes (n�o cumulativo e cumulativo), deve informar o indicador �3�.}

    pIND_APRO_CRED: integer; // C�digo indicador de m�todo de apropria��o de cr�ditos comuns, no caso de incid�ncia no regime n�o cumulativo - N(1F)
                            {(COD_INC_TRIB = 1 ou 3):
                             1 � M�todo de Apropria��o Direta;
                             2 � M�todo de Rateio Proporcional (Receita Bruta)}
    {Campo 03 - Valores v�lidos: [1;2]
Preenchimento: Este campo deve ser informado no caso da pessoa jur�dica apurar cr�ditos referentes a opera��es (de
aquisi��es de bens e servi�os, custos, despesas, etc) vinculados a mais de um tipo de receita (n�o-cumulativa e cumulativa).
Este campo deve tamb�m ser preenchido no caso em que mesmo se sujeitando a pessoa jur�dica exclusivamente ao regime n�ocumulativo,
as opera��es geradoras de cr�dito sejam vinculadas a receitas de naturezas diversas, decorrentes de:
- Opera��es tributadas no Mercado Interno;
- Opera��es n�o-tributadas no Mercado Interno (Al�quota zero, suspens�o, isen��o e n�o-incid�ncia);
- Opera��es de Exporta��o.

No caso da pessoa jur�dica adotar o m�todo da Apropria��o Direta, para fins de determina��o do cr�dito, referente a
aquisi��es, custos e despesas vinculados a mais de um tipo de receita, informar neste campo o indicador �1�;

No caso da pessoa jur�dica adotar o m�todo do Rateio Proporcional com base na Receita Bruta, para fins de determina��o do
cr�dito, referente a aquisi��es, custos e despesas vinculados a mais de um tipo de receita, informar neste campo o indicador
�2�. Neste caso, a escritura��o do Registro �0111� � obrigat�ria.}


    pCOD_TIPO_CONT: integer; // C�digo indicador do Tipo de Contribui��o Apurada no Per�odo - N(1F)
                            {1 � Apura��o da Contribui��o Exclusivamente a Al�quota B�sica
                             2 � Apura��o da Contribui��o a Al�quotas Espec�ficas (Diferenciadas e/ou por Unidade de Medida de Produto)}
{Campo 04 - Valores v�lidos: [1;2]
Preenchimento: indicar o c�digo correspondente ao tipo de contribui��o apurada no per�odo, a saber:
- Indicador �1�: No caso de apura��o das contribui��es exclusivamente �s al�quotas b�sicas de 0,65% ou 1,65% (PIS/Pasep) e
de 3% ou 7,6% (Cofins);
- Indicador �2�: No caso de apura��o das contribui��es �s al�quotas espec�ficas, decorrentes de opera��es tributadas
no regime monof�sico (combust�veis; produtos farmac�uticos, de perfumaria e de toucador; ve�culos, autope�as e
pneus; bebidas frias e embalagens para bebidas; etc) e/ou em regimes especiais (pessoa jur�dica industrial estabelecida
na Zona Franca de Manaus ou nas �reas de Livre Com�rcio, por exemplo).

A pessoa jur�dica sujeita � apura��o das contribui��es sociais a al�quotas espec�ficas deve informar o indicador �2�
mesmo que, em rela��o a outras receitas, se submeta � al�quota b�sica.}


    pIND_REG_CUM: integer; // C�digo indicador do crit�rio de escritura��o e apura��o adotado, no caso de incid�ncia exclusivamente no - N(1F)
                           // regime cumulativo (COD_INC_TRIB = 2), pela pessoa jur�dica submetida ao regime de tributa��o com base no lucro presumido:
                            {1 � Regime de Caixa � Escritura��o consolidada (Registro F500);
                             2 � Regime de Compet�ncia - Escritura��o consolidada (Registro F550);
                             9 � Regime de Compet�ncia - Escritura��o detalhada, com base nos registros dos Blocos �A�, �C�, �D� e �F�. }
 {Campo 05 - Valores v�lidos: [1;2;9]
Preenchimento: indicar o c�digo correspondente ao crit�rio de escritura��o das receitas, para fins de apura��o da
Contribui��o para o PIS/Pasep e da Cofins, no caso de pessoa jur�dica submetida ao regime de tributa��o com base no lucro
presumido:
- No caso de apura��o das contribui��es pelo regime de caixa, mediante a escritura��o consolidada das receitas
recebidas no registro �F500�, deve informar o indicador �1�;
- No caso de apura��o das contribui��es pelo regime de compet�ncia, mediante a escritura��o consolidada das receitas
auferidas no registro �F550�, deve informar o indicador �2�; ou
- No caso de apura��o das contribui��es pelo regime de compet�ncia, mediante a escritura��o detalhada das receitas
auferidas nos registros dos Blocos �A�, �C�, �D� e �F�.}

  protected
    function getREG: string;
    function getCOD_INC_TRIB: integer;
    function getIND_APRO_CRED: integer;
    function getCOD_TIPO_CONT: integer;
    function getIND_REG_CUM: integer;

    procedure setREG(lREG: string);
    procedure setCOD_INC_TRIB(lCOD_INC_TRIB: integer);
    procedure setIND_APRO_CRED(lIND_APRO_CRED: integer);
    procedure setCOD_TIPO_CONT(lCOD_TIPO_CONT: integer);
    procedure setIND_REG_CUM(lIND_REG_CUM: integer);

  public
    Constructor Create;
    Destructor Destroy; override;
    function getLinha: string;

    property REG: String read getREG write setREG;
    property COD_INC_TRIB: integer read getCOD_INC_TRIB write setCOD_INC_TRIB;
    property IND_APRO_CRED: integer read getIND_APRO_CRED write setIND_APRO_CRED;
    property COD_TIPO_CONT: integer read getCOD_TIPO_CONT write setCOD_TIPO_CONT;
    property IND_REG_CUM: integer read getIND_REG_CUM write setIND_REG_CUM;
  end;



  {REGISTRO 0140: TABELA DE CADASTRO DE ESTABELECIMENTO}

  {Este registro tem por objetivo relacionar e informar os estabelecimentos da pessoa jur�dica, no Brasil ou no exterior, que
auferiram receitas no per�odo da escritura��o, realizaram opera��es com direito a cr�ditos ou que sofreram reten��es na fonte,
no per�odo da escritura��o.

1. Em rela��o aos estabelecimentos e bases operacionais no exterior, que estejam cadastradas no CNPJ: Preencher o registro
"0140" informando o CNPJ (campo 04) do estabelecimento localizado no exterior e, em rela��o ao campo "UF" (Campo
05) e ao campo "COD_MUN" (Campo 07), informar a UF e c�digo de munic�pio do estabelecimento sede, respons�vel pela
escritura��o, identificado no registro "0000";

2. Em rela��o aos estabelecimentos e bases operacionais no exterior, que n�o estejam cadastradas no CNPJ: N�o preencher
o registro "0140", por inexist�ncia de CNPJ (campo 04), devendo as opera��es objeto da escritura��o deste estabelecimento
localizado no exterior, serem informadas nos Blocos "A", "C", "D" e/ou" F", no conjunto de registros do estabelecimento
sede, informado no registro "0000", campo "09".
Neste caso, e no sentido de diferenciar as informa��es pr�prias do estabelecimento sede, das informa��es pr�prias dos estabelecimentos
localizados no exterior, sem inscri��o no CNPJ, preferencialmente deve a empresa adotar plano de contas cont�beis
que diferenciem e identifiquem as opera��es de cada estabelecimento, as quais devem ser informadas nos respectivos registros
de opera��es nos Blocos "A", "C", "D" e "F".}

  type TReg0140 = class

  private

    pREG: String; // Texto fixo contendo |0140| - C(4F)*
    {Campo 01 - Valor V�lido: [0140]}

    pCOD_EST: String; // C�digo de identifica��o do estabelecimento - C(60)
    {Campo 02 � Preenchimento: informe o identificador do estabelecimento sendo informados. Esta informa��o � de livre
atribui��o da empresa.}

    pNOME: String; // Nome empresarial do estabelecimento - C(100)*
    {Campo 03 � Preenchimento: informe o nome empresarial do estabelecimento, caso este seja distinto do nome empresarial da
pessoa jur�dica.}

    pCNPJ: String; // N�mero de inscri��o do estabelecimento no CNPJ. - N(14F)*
    {Campo 04 - Preenchimento: Informar o n�mero de inscri��o do estabelecimento no cadastro do CNPJ.
Valida��o: ser� conferido o d�gito verificador (DV) do CNPJ informado.}

    pUF: String; // Sigla da unidade da federa��o do estabelecimento. C(2F)*
    {Campo 05 - Preenchimento: Informar a sigla da unidade da federa��o (UF) do estabelecimento.}

    pIE: String; // Inscri��o Estadual do estabelecimento, se contribuinte de ICMS. - C(14)
    {Campo 06 � Preenchimento: Informar neste campo a inscri��o estadual do estabelecimento, caso existente.
Valida��o: valida a Inscri��o Estadual de acordo com a UF informada no campo COD_MUN (dois primeiros d�gitos do c�digo
de munic�pio).
No caso do estabelecimento cadastrado possuir mais de uma inscri��o estadual, este campo n�o deve ser preenchido.}

    pCOD_MUN: String; // C�digo do munic�pio do domic�lio fiscal do estabelecimento, conforme a tabela IBGE - N(7F)*
    {Campo 07 � Preenchimento: Informar o c�digo de munic�pio do domic�lio fiscal da pessoa jur�dica, conforme codifica��o
constante da Tabela de Munic�pios do IBGE.
Valida��o: o valor informado no campo deve existir na Tabela de Munic�pios do IBGE, possuindo 7 d�gitos.}

    pIM: String; // Inscri��o Municipal do estabelecimento, se contribuinte do ISS. - C(-)
    {Campo 08 � Preenchimento: Informar neste campo a inscri��o municipal do estabelecimento, caso existente.}

    pSUFRAMA: String; // Inscri��o do estabelecimento na Suframa - C(9F)
    {Campo 09 � Preenchimento: Informar neste campo a inscri��o da pessoa jur�dica titular da escritura��o na SUFRAMA. Caso
a pessoa jur�dica n�o tenha inscri��o na SUFRAMA este campo deve ser informado em branco.
Valida��o: ser� conferido o d�gito verificador (DV) do n�mero de inscri��o na SUFRAMA, se informado.04 CNPJ}


  protected

    function getREG: string;
    function getCOD_EST: String;
    function getNOME: String;
    function getCNPJ: String;
    function getUF: String;
    function getIE: String;
    function getCOD_MUN: String;
    function getIM: String;
    function getSUFRAMA: String;

    procedure setREG(lREG: string);
    procedure setCOD_EST(lCOD_EST: String);
    procedure setNOME(lNOME: String);
    procedure setCNPJ(lCNPJ: String);
    procedure setUF(lUF: String);
    procedure setIE(lIE: String);
    procedure setCOD_MUN(lCOD_MUN: String);
    procedure setIM(lIM: String);
    procedure setSUFRAMA(lSUFRAMA: String);

  public
    Constructor Create;
    Destructor Destroy; override;
    function getLinha: string;


    property REG: String read getREG write setREG;
    property COD_EST: String read getCOD_EST write setCOD_EST;
    property NOME: String read getNOME write setNOME;
    property CNPJ: String read getCNPJ write setCNPJ;
    property UF: String read getUF write setUF;
    property IE: String read getIE write setIE;
    property COD_MUN: String read getCOD_MUN write setCOD_MUN;
    property IM: String read getIM write setIM;
    property SUFRAMA: string read getSUFRAMA write setSUFRAMA;

  end;

  {REGISTRO 0150: TABELA DE CADASTRO DO PARTICIPANTE}
  {Este registro tem por objetivo relacionar e cadastrar os participantes (fornecedores e clientes pessoa jur�dica ou pessoa f�sica)
que tenham realizado opera��es com a empresa, objeto de registro nos Blocos A, C, D, F ou 1.

Em rela��o �s opera��es documentadas com base em Nota Fiscal Eletr�nica (C�digo 55), no caso da pessoa jur�dica proceder �
escritura��o consolidada de suas vendas (Registro C180) e/ou de suas aquisi��es (Registro C190), n�o � obrigat�rio cadastrar e
relacionar no Registro 0150 o participante cujas opera��es estejam exclusivamente escrituradas nos registros C180 e C190.

Em rela��o �s opera��es documentadas com base em Nota Fiscal Eletr�nica (C�digo 55), no caso da pessoa jur�dica proceder �
escritura��o de forma individualizada por documento fiscal (Registros C100/C170) de suas vendas e/ou de suas aquisi��es, �
obrigat�rio cadastrar e relacionar no Registro 0150 cada participante cujas opera��es estejam escrituradas nos registros C100 e
C170.

Observa��es:
1. Registro utilizado para informa��es cadastrais das pessoas f�sicas ou jur�dicas envolvidas nas transa��es comerciais e de
presta��o/contrata��o de servi�os relacionadas na escritura��o fiscal digital, no per�odo.
2. Todos os participantes informados nos registros dos Blocos A, C, D ou F devem ser relacionados neste Registro 0150, bem
como os participantes relacionados em opera��es extempor�neas de contribui��es e/ou cr�ditos (na impossibilidade de retifica��o
da EFD-Contribui��es), no Bloco 1.
A obrigatoriedade de escritura��o de participante no Registro 0150 n�o se aplica, nas situa��es em que os registros dos Blocos
A, C, D ou F identifiquem o participante pelo CNPJ (no caso de participante pessoa jur�dica) ou CPF (no caso de participante
pessoa f�sica)..
3. No caso de registros representativos de opera��es de vendas a consumidor final (mediante emiss�o de Nota Fiscal de Vendas
a Consumidor Final, ou documento equivalente, inclusive os emitidos por ECF), n�o precisam ser informados os campos
CNPJ e CPF;
4. O Campo CPF n�o precisa ser informado, nas opera��es representativas de vendas de bens e servi�os a pessoas f�sicas estrangeiras.
5. No caso da pessoa jur�dica ter realizado opera��es relativas �s atividades de cons�rcio, constitu�do nos termos do disposto
nos arts. 278 e 279 da Lei n� 6.404, de 1976, pass�veis de escritura��o na EFD-Contribui��es, dever� a pessoa jur�dica consorciada
cadastrar cada cons�rcio em 01 (um) registro 0150 espec�fico.
N�vel hier�rquico - 3
Ocorr�ncia � 1:N }

  type TReg0150 = class

  private

    pREG: String; // Texto fixo contendo |0150| - C(4F)*
    {Campo 01 - Valor V�lido: [0150]}

    pCOD_PART: String; //C�digo de identifica��o do participante no arquivo. - C(60)*
    {Campo 02 - Preenchimento: informar o c�digo de identifica��o do participante no arquivo.
Esta tabela pode conter COD_PART e respectivo registro 0150 com dados do pr�prio contribuinte informante, quando apresentar
documentos emitidos contra si pr�prio, em situa��es espec�ficas.
Valida��o: O c�digo de participante, campo COD_PART, � de livre atribui��o do estabelecimento, observado o disposto no
item 2.4.2.1. do Manual de Orienta��o do Leiaute da EFD-Contribui��es (ADE Cofis n� 34/2010).}

    pNOME: String; // Nome pessoal ou empresarial do participante. - C(100)*

    pCOD_PAIS: String; // C�digo do pa�s do participante, conforme a tabela indicada no item 3.2.1. (www.bcb.gov.br) 01058	BRASIL - N(5)*
    {Campo 04 - Preenchimento: informar o c�digo do pa�s, conforme tabela indicada no item 3.2.1 do Manual de Orienta��o do
Leiaute da EFD-Contribui��es (ADE Cofis n� 34/2010).
O c�digo de pa�s pode ser informado com 05 caracteres ou com 04 caracteres (desprezando o caractere �0� (zero) existente �
esquerda).
Valida��o: o valor informado no campo deve existir na Tabela de Pa�ses. Informar, inclusive, quando o participante for
estabelecido ou residente no Brasil (01058 ou 1058).}

    pCNPJ: String; // CNPJ do participante. - N(14F)
    {Campo 05 - Preenchimento: informar o n�mero do CNPJ do participante; n�o informar caracteres de formata��o, tais
como: ".", "/", "-". Se COD_PAIS diferente de Brasil, o campo n�o deve ser preenchido.
Valida��o: � conferido o d�gito verificador (DV) do CNPJ informado.
Obrigatoriamente um dos campos, CPF ou CNPJ, dever� ser preenchido.}

    pCPF: String; // CPF do participante. - N(11F)
    {Campo 06 - Preenchimento: informar o n�mero do CPF do participante; n�o utilizar os caracteres especiais de
formata��o, tais como: �.�, �/�, �-�. Se COD_PAIS diferente de Brasil, o campo n�o deve ser preenchido.
Valida��o: � conferido o d�gito verificador (DV) do CPF informado.
Obrigatoriamente um dos campos, CPF ou CNPJ, dever� ser preenchido.
Obs.: Os campos 05 e 06 s�o mutuamente excludentes, sendo obrigat�rio o preenchimento de um deles quando o campo 04 estiver
preenchido com �01058� ou �1058� (Brasil).}

    pIE: String; // Inscri��o Estadual do participante. - C(14)
    {Campo 07 - Valida��o: valida a Inscri��o Estadual de acordo com a UF informada no campo COD_MUN (dois primeiros d�gitos
do c�digo de munic�pio).}

    pCOD_MUN: String; // C�digo do munic�pio, conforme a tabela IBGE - N(7F)
    {Campo 08 - Valida��o: o valor informado no campo deve existir na Tabela de Munic�pios do IBGE (combina��o do c�digo
da UF e do c�digo de munic�pio), possuindo 7 d�gitos.
Obrigat�rio se campo COD_PAIS for igual a �01058� ou �1058�(Brasil). Se for exterior, informar campo �vazio� ou
preencher com o c�digo �9999999�.}

    pSUFRAMA: String; // N�mero de inscri��o do participante na Suframa - C(9F)
    {Campo 09 - Preenchimento: informar o n�mero de Inscri��o do participante na SUFRAMA, se houver.
Valida��o: � conferido o d�gito verificador (DV) do n�mero de inscri��o na SUFRAMA, se informado.}

    pENDERECO: String; // Logradouro e endere�o do im�vel - C(60)
    {Campo 10 - Preenchimento: informar o logradouro e endere�o do im�vel. Se o participante for do exterior, preencher inclusive
com a cidade e pa�s}

    pNUM: String; // N�mero do im�vel C(-)
    pCOMPL: String; // Dados complementares do endere�o - C(60)
    pBAIRRO: String; // Bairro em que o im�vel est� situado - C(60)

  protected

    function getREG: string;
    function getCOD_PART: String;
    function getNOME: String;
    function getCOD_PAIS: String;
    function getCNPJ: String;
    function getCPF: String;
    function getIE: String;
    function getCOD_MUN: String;
    function getSUFRAMA: String;
    function getENDERECO: String;
    function getNUM: String;
    function getCOMPL: String;
    function getBAIRRO: String;

    procedure setREG(lREG: string);
    procedure setCOD_PART(lCOD_PART: String);
    procedure setNOME(lNOME: String);
    procedure setCOD_PAIS(lCOD_PAIS: String);
    procedure setCNPJ(lCNPJ: String);
    procedure setCPF(lCPF: String);
    procedure setIE(lIE: String);
    procedure setCOD_MUN(lCOD_MUN: String);
    procedure setSUFRAMA(lSUFRAMA: String);
    procedure setENDERECO(lENDERECO: String);
    procedure setNUM(lNUM: String);
    procedure setCOMPL(lCOMPL: String);
    procedure setBAIRRO(lBAIRRO: String);


  public
    Constructor Create;
    Destructor Destroy; override;
    function getLinha: string;


    property REG: String read getREG write setREG;
    property COD_PART: String read getCOD_PART write setCOD_PART;
    property NOME: String read getNOME write setNOME;
    property COD_PAIS: String read getCOD_PAIS write setCOD_PAIS;
    property CNPJ: String read getCNPJ write setCNPJ;
    property CPF: String read getCPF write setCPF;
    property IE: String read getIE write setIE;
    property COD_MUN: String read getCOD_MUN write setCOD_MUN;
    property SUFRAMA: String read getSUFRAMA write setSUFRAMA;
    property ENDERECO: String read getENDERECO write setENDERECO;
    property NUM: String read getNUM write setNUM;
    property COMPL: String read getCOMPL write setCOMPL;
    property BAIRRO: String read getBAIRRO write setBAIRRO;

  end;


  {REGISTRO 0190: IDENTIFICA��O DAS UNIDADES DE MEDIDA}

  type TReg0190 = class

  private

    pREG: String; // Texto fixo contendo |0190| - C(4F)*
    {Campo 01 - Valor V�lido: [0190]}

    pUNID: String; //  C�digo da unidade de medida C(6)*
    {Campo 02: Informar o c�digo correspondente � unidade de medida utilizada no arquivo digital.}

    pDESCR: String; // Descri��o da unidade de medida C(-)*
    {Campo 03 - Valida��o: n�o poder�o ser informados os campos UNID e DESCR com o mesmo conte�do.}

  protected

    function getREG: string;
    function getUNID: String;
    function getDESCR: String;

    procedure setREG(lREG: string);
    procedure setUNID(lUNID: String);
    procedure setDESCR(lDESCR: String);


  public
    Constructor Create;
    Destructor Destroy; override;
    function getLinha: string;

    property REG: String read getREG write setREG;
    property UNID: String read getUNID write setUNID;
    property DESCR: String read getDESCR write setDESCR;
  end;


  {REGISTRO 0200: TABELA DE IDENTIFICA��O DO ITEM (PRODUTOS E SERVI�OS)}
  {Este registro tem por objetivo informar as mercadorias, servi�os, produtos ou quaisquer outros itens concernentes �s transa��es
representativas de receitas e/ou geradoras de cr�ditos, objeto de escritura��o nos Blocos A, C, D, F ou 1.}

  type TReg0200 = class

  private

    pREG: String; // Texto fixo contendo |0200| - C(4)*
    {Campo 01 - Valor V�lido: [0200]}

    pCOD_ITEM: String; //C�digo do item - C(60)*
    {Campo 02 - Preenchimento: informar com c�digos pr�prios do informante do arquivo os itens das opera��es de entradas de
mercadorias ou aquisi��es de servi�os, bem como das opera��es de sa�das de mercadorias ou presta��es de servi�os. O C�digo
do Item dever� ser preenchido com as informa��es utilizadas na �ltima ocorr�ncia do per�odo.}

    pDESCR_ITEM: String; // Descri��o do item - C(-)*
    {Campo 03 - Preenchimento: s�o vedadas descri��es diferentes para o mesmo item ou descri��es gen�ricas, ressalvadas as
opera��es abaixo, desde que n�o destinada � posterior circula��o ou apropria��o na produ��o:
1- de aquisi��o de "materiais para uso/consumo" que n�o gerem direitos a cr�ditos;
2- que discriminem por g�nero a aquisi��o ou venda de bens incorporados ao ativo imobilizado da empresa;
3- que contenham os registros consolidados relativos aos contribuintes com atividades econ�micas de
fornecimento de energia el�trica, de fornecimento de �gua canalizada, de fornecimento de g�s canalizado e de presta��o de servi�o
de comunica��o e telecomunica��o que poder�o, a crit�rio do Fisco, utilizar registros consolidados por classe de consumo
para representar suas sa�das ou presta��es.}

    pCOD_BARRA: String; // Representa��o alfanum�rico do c�digo de barra do produto, se houver. - C(-)


    pCOD_ANT_ITEM: String; // C�digo anterior do item com rela��o � �ltima informa��o apresentada. - C(60)
    pUNID_INV: String; // Unidade de medida utilizada na quantifica��o de estoques. - C(6)
    {Campo 06 - Valida��o: existindo informa��o neste campo, esta deve existir no registro 0190, campo UNID, respectivo.}

    pTIPO_ITEM: String; // Tipo do item � Atividades Industriais, Comerciais e Servi�os: - N(2F)*
                          {00 � Mercadoria para Revenda;
                          01 � Mat�ria-Prima;
                          02 � Embalagem;
                          03 � Produto em Processo;
                          04 � Produto Acabado;
                          05 � Subproduto;
                          06 � Produto Intermedi�rio;
                          07 � Material de Uso e Consumo;
                          08 � Ativo Imobilizado;
                          09 � Servi�os;
                          10 � Outros insumos;
                          99 � Outras}
    {Campo 07 - Preenchimento: informar o tipo do item aplic�vel. Nas situa��es de um mesmo c�digo de item possuir mais
de um tipo de item (destina��o), deve ser informado o tipo de maior relev�ncia.
Deve ser informada a destina��o inicial do produto, considerando-se os conceitos:
00 - Mercadoria para revenda � produto adquirido comercializa��o;
01 � Mat�ria-prima: a mercadoria que componha, f�sica e/ou quimicamente, um produto em processo ou produto acabado e
que n�o seja oriunda do processo produtivo. A mercadoria recebida para industrializa��o � classificada como Tipo 01, pois n�o
decorre do processo produtivo, mesmo que no processo de produ��o se produza mercadoria similar classificada como Tipo 03;
03 � Produto em processo: o produto que possua as seguintes caracter�sticas, cumulativamente: oriundo do processo produtivo;
e, preponderantemente, consumido no processo produtivo. Dentre os produtos em processo est� inclu�do o produto resultante
caracterizado como retorno de produ��o (vide conceito de retorno de produ��o abaixo);
04 � Produto acabado: o produto que possua as seguintes caracter�sticas, cumulativamente: oriundo do processo produtivo;
produto final resultante do objeto da atividade econ�mica do contribuinte; e pronto para ser comercializado;
05 - Subproduto: o produto que possua as seguintes caracter�sticas, cumulativamente: oriundo do processo produtivo e n�o �
objeto da produ��o principal do estabelecimento; tem aproveitamento econ�mico; n�o se enquadre no conceito de produto em
processo (Tipo 03) ou de produto acabado (Tipo 04);
06 � Produto intermedi�rio: aquele que, embora n�o se integrando ao novo produto, for consumido no processo de industrializa��o.
Valores v�lidos: [00, 01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 99]}

    pCOD_NCM: String; // C�digo da Nomenclatura Comum do Mercosul - C(8)
    {Campo 08 � Preenchimento: � obrigat�rio informar o C�digo NCM conforme a Nomenclatura Comum do MERCOSUL, de
acordo com o Decreto n� 6.006/06 para:
- as empresas industriais e equiparadas a industrial, referente aos itens correspondentes �s suas atividades fins;
- as pessoas jur�dicas, inclusive cooperativas, que produzam mercadorias de origem animal ou vegetal (agroind�stria),
referente aos itens correspondentes �s atividades geradoras de cr�dito presumido;
- as empresas que realizarem opera��es de exporta��o ou importa��o;
- as empresas atacadistas ou industriais, referentes aos itens representativos de vendas no mercado interno com al�quota
zero, suspens�o, isen��o ou n�o incid�ncia, nas situa��es em que a legisla��o tribut�ria atribua o benef�cio a um c�digo
NCM espec�fico.
Nas demais situa��es o Campo 08 (NCM) n�o � de preenchimento obrigat�rio.}

    pEX_IPI: String; // C�digo EX, conforme a TIPI - C(3)
    {Campo 09 - Preenchimento: informar com o C�digo de Exce��o de NCM, de acordo com a Tabela de Incid�ncia do
Imposto sobre Produtos Industrializados (TIPI), quando existir.}

    pCOD_GEN: String; // C�digo do g�nero do item, conforme a Tabela 4.2.1. - N(2F)
    {Campo 10 - Preenchimento: obrigat�rio para todos os contribuintes na aquisi��o de produtos prim�rios. A Tabela
"G�nero do Item de Mercadoria/Servi�o", referenciada no Item 4.2.1 do Manual de Orienta��o do Leiaute da EFD-Contribui��es
(ADE Cofis n� 34/2010), corresponde � tabela de "Cap�tulos da NCM", acrescida do c�digo "00 - Servi�o".
Valida��o: o valor informado no campo deve existir na Tabela �G�nero do Item de Mercadoria/Servi�o�, item 4.2.1 do
Manual de Orienta��o do Leiaute da EFD-Contribui��es (ADE Cofis n� 34/2010).}

    pCOD_LST: String; // C�digo do servi�o conforme lista do Anexo I da Lei Complementar Federal n� 116/03. - N(4)
    {Campo 11 - Preenchimento: informar o c�digo de servi�os, de acordo com a Lei Complementar 116/03. }

    pALIQ_ICMS: Currency; // Al�quota de ICMS aplic�vel ao item nas opera��es internas - N(6,2)
    {Campo 12 - Preenchimento: neste campo deve ser informada a al�quota do ICMS, em opera��es de sa�da interna}

  protected

    function getREG: string;
    function getCOD_ITEM: String;
    function getDESCR_ITEM: String;
    function getCOD_BARRA: String;
    function getCOD_ANT_ITEM: String;
    function getUNID_INV: String;
    function getTIPO_ITEM: String;
    function getCOD_NCM: String;
    function getEX_IPI: String;
    function getCOD_GEN: String;
    function getCOD_LST: String;
    function getALIQ_ICMS: Double;

    procedure setREG(lREG: string);
    procedure setCOD_ITEM(lCOD_ITEM: String);
    procedure setDESCR_ITEM(lDESCR_ITEM: String);
    procedure setCOD_BARRA(lCOD_BARRA: String);
    procedure setCOD_ANT_ITEM(lCOD_ANT_ITEM: String);
    procedure setUNID_INV(lUNID_INV: String);
    procedure setTIPO_ITEM(lTIPO_ITEM: String);
    procedure setCOD_NCM(lCOD_NCM: String);
    procedure setEX_IPI(lEX_IPI: String);
    procedure setCOD_GEN(lCOD_GEN: String);
    procedure setCOD_LST(lCOD_LST: String);
    procedure setALIQ_ICMS(lALIQ_ICMS: Double);


  public
    Constructor Create;
    Destructor Destroy; override;
    function getLinha: string;

    property REG: String read getREG write setREG;
    property COD_ITEM: String read getCOD_ITEM write setCOD_ITEM;
    property DESCR_ITEM: String read getDESCR_ITEM write setDESCR_ITEM;
    property COD_BARRA: String read getCOD_BARRA write setCOD_BARRA;
    property COD_ANT_ITEM: String read getCOD_ANT_ITEM write setCOD_ANT_ITEM;
    property UNID_INV: String read getUNID_INV write setUNID_INV;
    property TIPO_ITEM: String read getTIPO_ITEM write setTIPO_ITEM;
    property COD_NCM: String read getCOD_NCM write setCOD_NCM;
    property EX_IPI: String read getEX_IPI write setEX_IPI;
    property COD_GEN: String read getCOD_GEN write setCOD_GEN;
    property COD_LST: String read getCOD_LST write setCOD_LST;
    property ALIQ_ICMS: Double read getALIQ_ICMS write setALIQ_ICMS;
  end;


  {REGISTRO 0400: TABELA DE NATUREZA DA OPERA��O/PRESTA��O}
  {Este registro tem por objetivo codificar os textos das diferentes naturezas da opera��o/presta��o discriminadas nos documentos
fiscais. Esta codifica��o e suas descri��es s�o livremente criadas e mantidas pelo contribuinte.
Este registro n�o se refere a CFOP. Algumas empresas utilizam outra classifica��o al�m das apresentados nos CFOP. Esta codifica��o
permite informar estes agrupamentos pr�prios.
N�o podem ser informados dois ou mais registros com o mesmo c�digo no campo COD_NAT}


  type TReg0400 = class

  private

    pREG: String; // Texto fixo contendo |0400| - C(4)*
    {Campo 01 - Valor V�lido: [0400]}

    pCOD_NAT: String; //  C�digo da natureza da opera��o/presta��o C(10)*
    {Campo 02 � Preenchimento: informar o c�digo da natureza da opera��o/presta��o}

    pDESCR_NAT: String; // Descri��o da natureza da opera��o/presta��o C(-)*
    {Campo 03 � Preenchimento: informar a descri��o da natureza da opera��o/presta��o}

  protected

    function getREG: string;
    function getCOD_NAT: String;
    function getDESCR_NAT: String;

    procedure setREG(lREG: string);
    procedure setCOD_NAT(lCOD_NAT: String);
    procedure setDESCR_NAT(lDESCR_NAT: String);


  public
    Constructor Create;
    Destructor Destroy; override;
    function getLinha: string;

    property REG: String read getREG write setREG;
    property COD_NAT: String read getCOD_NAT write setCOD_NAT;
    property DESCR_NAT: String read getDESCR_NAT write setDESCR_NAT;
  end;


  {REGISTRO 0450: TABELA DE INFORMA��O COMPLEMENTAR DO DOCUMENTO FISCAL}
  {Este registro tem por objetivo codificar todas as informa��es complementares dos documentos fiscais, exigidas pela legisla��o
fiscal. Estas informa��es constam no campo �Dados Adicionais� dos documentos fiscais.
Esta codifica��o e suas descri��es s�o livremente criadas e mantidas pelo contribuinte e n�o podem ser informados dois ou
mais registros com o mesmo conte�do no campo COD_INF.

Dever�o constar todas as informa��es complementares de interesse da Administra��o Tribut�ria, existentes nos documentos
fiscais.

Exemplo: nos casos de documentos fiscais de entradas, informar as refer�ncias a um outro documento fiscal.

Observa��es:
N�vel hier�rquico - 3
Ocorr�ncia � 1:N}


  type TReg0450 = class

  private

    pREG: String; // Texto fixo contendo |0450| - C(4)*
    {Campo 01 - Valor V�lido: [0450]}

    pCOD_INF: String; //  C�digo da informa��o complementar do documento fiscal. - C(6)*
    {Campo 02 � Preenchimento: informar o c�digo da informa��o complementar, conforme for utilizado nos documentos fiscais
constantes nos demais blocos}

    pTXT: String; // C(-)*
    {Texto livre da informa��o complementar existente no documento fiscal, inclusive esp�cie de normas legais, poder normativo, n�mero,
capitula��o, data e demais refer�ncias pertinentes com indica��o referentes ao tributo.

Campo 03 � Preenchimento: preencher com o texto constante no documento fiscal, como por exemplo: o n�mero e data do
ADE que permite a realiza��o de venda com suspens�o para empresa preponderantemente exportadora e a respectiva indica��o
da base legal
}

  protected

    function getREG: string;
    function getCOD_INF: String;
    function getTXT: String;

    procedure setREG(lREG: string);
    procedure setCOD_INF(lCOD_INF: String);
    procedure setTXT(lTXT: String);


  public
    Constructor Create;
    Destructor Destroy; override;
    function getLinha: string;

    property REG: String read getREG write setREG;
    property COD_INF: String read getCOD_INF write setCOD_INF;
    property TXT: String read getTXT write setTXT;
  end;


  {REGISTRO 0990: ENCERRAMENTO DO BLOCO 0}
  {Observa��es: Registro obrigat�rio.
N�vel hier�rquico - 1
Ocorr�ncia � um por arquivo}
  type TReg0990 = class

  private

    pREG: String; // Texto fixo contendo |0990| - C(4)*
    {Campo 01 - Valor V�lido: [0990]}

    pQTD_LIN_0: Integer; // Quantidade total de linhas do Bloco 0

  protected

    function getREG: string;
    function getQTD_LIN_0: Integer;

    procedure setREG(lREG: string);
    procedure setQTD_LIN_0(lQTD_LIN_0: Integer);


  public
    Constructor Create;
    Destructor Destroy; override;
    function getLinha: string;

    property REG: String read getREG write setREG;
    property QTD_LIN_0: Integer read getQTD_LIN_0 write setQTD_LIN_0;
  end;


  {BLOCO 0 - ABERTURA E IDENTIFICA��O}
  type TBloco0 = class

  public
    reg0000: TReg0000;
    reg0001: TReg0001;
    reg0100: TReg0100;
    reg0110: TReg0110;
    reg0140: TReg0140;
    reg0150: TReg0150;
    reg0190: TReg0190;
    reg0200: TReg0200;
    reg0400: TReg0400;
    reg0450: TReg0450;
    reg0990: TReg0990;
    Constructor Create;
    Destructor Destroy; override;
  end;

var
  bloco0: TBloco0;

implementation


{ TReg0000 }
{REGISTRO 0000: ABERTURA DO ARQUIVO DIGITAL E IDENTIFICA��O DA PESSOA JUR�DICA - Obrigat�rio (1)}

constructor TReg0000.Create;
var FmtStngs: TFormatSettings;
begin
  inherited create;

  {Inicializa valores padr�o}
  pREG := '0000';
  pCOD_VER := '003'; //ADE Cofis n� 20/2012
  pTIPO_ESCRIT := 0;
  pIND_SIT_ESP := -1;
  pNUM_REC_ANTERIOR := '';
  pDT_INI := strtoDate('01'+FormatDateTime('/mm/yyyy',now()));
  pDT_FIN := strtoDate(TUtil.UltimoDiaDoMes(FormatDateTime('mmyyyy',now()))+FormatDateTime('/mm/yyyy',now()));
  pNOME := '';
  pCNPJ := '';
  pUF := '';
  pCOD_MUN := '';
  pSUFRAMA := '';
  pIND_NAT_PJ := '00';
  pIND_ATIV := 1;
end;

destructor TReg0000.Destroy;
begin
 {}
 inherited;
end;


function TReg0000.getLinha: string;
begin
  Result := '|';
  Result := Result + pREG + '|';
  Result := Result + TUtil.FormataStringNumeralFixo(pCOD_VER,3,True) + '|';
  Result := Result + TUtil.FormataIntegerNumeralFixo(pTIPO_ESCRIT,1,True) + '|';
  Result := Result + TUtil.FormataIntegerNumeralFixo(pIND_SIT_ESP,1,False) + '|';
  Result := Result + TUtil.FormataStringNumeralFixo(pNUM_REC_ANTERIOR,41,False) + '|';
  Result := Result + TUtil.FormataDataFixo(pDT_INI,True) + '|';
  Result := Result + TUtil.FormataDataFixo(pDT_FIN,True) + '|';
  Result := Result + pNOME + '|';
  Result := Result + TUtil.FormataStringNumeralFixo(pCNPJ,14,True) + '|';
  Result := Result + pUF + '|';
  Result := Result + TUtil.FormataStringNumeralFixo(pCOD_MUN,7,True) + '|';
  Result := Result + pSUFRAMA + '|';
  Result := Result + TUtil.FormataStringNumeralFixo(pIND_NAT_PJ,2,False) + '|';
  Result := Result + TUtil.FormataIntegerNumeralFixo(pIND_ATIV,1,True) + '|';
  bloco0.reg0990.pQTD_LIN_0 := bloco0.reg0990.pQTD_LIN_0 + 1;
end;


function TReg0000.getREG : String;
begin
  Result := pREG;
end;

function TReg0000.getCOD_VER : String;
begin
  Result := pCOD_VER;
end;

function TReg0000.getTIPO_ESCRIT : integer;
begin
  Result := pTIPO_ESCRIT;
end;

function TReg0000.getIND_SIT_ESP : integer;
begin
  Result := pIND_SIT_ESP;
end;

function TReg0000.getNUM_REC_ANTERIOR: string;
begin
  Result := pNUM_REC_ANTERIOR;
end;

function TReg0000.getDT_INI: TDate;
begin
  Result := pDT_INI;
end;

function TReg0000.getDT_FIN: TDate;
begin
  Result := pDT_FIN;
end;

function TReg0000.getNOME: string;
begin
  Result := pNOME;
end;

function TReg0000.getCNPJ: string;
begin
  Result := pCNPJ;
end;

function TReg0000.getUF: string;
begin
  Result := pUF;
end;

function TReg0000.getCOD_MUN: string;
begin
  Result := pCOD_MUN;
end;

function TReg0000.getSUFRAMA: string;
begin
  Result := pSUFRAMA;
end;

function TReg0000.getIND_NAT_PJ: string;
begin
  Result := pIND_NAT_PJ;
end;

function TReg0000.getIND_ATIV:integer;
begin
  Result := pIND_ATIV;
end;




procedure TReg0000.setREG(lREG : String);
begin
  pREG := lREG;
end;

procedure TReg0000.setCOD_VER(lCOD_VER : String);
begin
  pCOD_VER := lCOD_VER;
end;

procedure TReg0000.setTIPO_ESCRIT(lTIPO_ESCRIT : integer);
begin
  pTIPO_ESCRIT := lTIPO_ESCRIT;
end;

procedure TReg0000.setIND_SIT_ESP(lIND_SIT_ESP : integer);
begin
  pIND_SIT_ESP := lIND_SIT_ESP;
end;

procedure TReg0000.setNUM_REC_ANTERIOR(lNUM_REC_ANTERIOR: string);
begin
  pNUM_REC_ANTERIOR := lNUM_REC_ANTERIOR;
end;

procedure TReg0000.setDT_INI(lDT_INI: TDate);
begin
  pDT_INI := lDT_INI;
end;

procedure TReg0000.setDT_FIN(lDT_FIN: TDate);
begin
  pDT_FIN := lDT_FIN;
end;

procedure TReg0000.setNOME(lNOME: string);
begin
  pNOME := lNOME;
end;

procedure TReg0000.setCNPJ(lCNPJ: string);
begin
  pCNPJ := lCNPJ;
end;

procedure TReg0000.setUF(lUF: string);
begin
  pUF := lUF;
end;

procedure TReg0000.setCOD_MUN(lCOD_MUN: string);
begin
  pCOD_MUN := lCOD_MUN;
end;

procedure TReg0000.setSUFRAMA(lSUFRAMA: string);
begin
  pSUFRAMA := lSUFRAMA;
end;

procedure TReg0000.setIND_NAT_PJ(lIND_NAT_PJ: string);
begin
  pIND_NAT_PJ := lIND_NAT_PJ;
end;

procedure TReg0000.setIND_ATIV(lIND_ATIV: integer);
begin
  pIND_ATIV := lIND_ATIV;
end;






{ TReg0001 }
{REGISTRO 0001: ABERTURA DO BLOCO 0 - Obrigat�rio (1)}

constructor TReg0001.Create;
begin
  inherited create;
  {Inicializa valores padr�o}
  pREG := '0001';
  pIND_MOV := 0;
end;

destructor TReg0001.Destroy;
begin
 {}
 inherited;
end;

function TReg0001.getLinha: string;
begin
  Result := '|';
  Result := Result + pREG + '|';
  Result := Result + TUtil.FormataIntegerNumeralFixo(pIND_MOV,1,True) + '|';
  bloco0.reg0990.pQTD_LIN_0 := bloco0.reg0990.pQTD_LIN_0 + 1;
end;

function TReg0001.getREG : String;
begin
  Result := pREG;
end;

function TReg0001.getIND_MOV : integer;
begin
  Result := pIND_MOV;
end;


procedure TReg0001.setREG(lREG : String);
begin
  pREG := lREG;
end;

procedure TReg0001.setIND_MOV(lIND_MOV : integer);
begin
  pIND_MOV := lIND_MOV;
end;




{ TReg0100 }
{REGISTRO 0100: DADOS DO CONTABILISTA}

constructor TReg0100.Create;
begin
  inherited create;
  {Inicializa valores padr�o}
  pREG := '0100';
  pNOME := '';
  pCPF := '';
  pCRC := '';
  pCNPJ := '';
  pCEP := '';
  pENDERECO := '';
  pNUM := '';
  pCOMPL := '';
  pBAIRRO := '';
  pFONE := '';
  pFAX := '';
  pEMAIL := '';
  pCOD_MUN := '';
end;

destructor TReg0100.Destroy;
begin
 {}
 inherited;
end;

function TReg0100.getLinha: string;
begin
  Result := '|';
  Result := Result + pREG + '|';
  Result := Result + pNOME + '|';
  Result := Result + TUtil.FormataStringNumeralFixo(pCPF,11,True) + '|';
  Result := Result + pCRC + '|';
  Result := Result + TUtil.FormataStringNumeralFixo(pCNPJ,14,True) + '|';
  Result := Result + TUtil.FormataStringNumeralFixo(pCEP,8,False) + '|';
  Result := Result + pENDERECO + '|';
  Result := Result + pNUM + '|';
  Result := Result + pCOMPL + '|';
  Result := Result + pBAIRRO + '|';
  Result := Result + pFONE + '|';
  Result := Result + pFAX + '|';
  Result := Result + pEMAIL + '|';
  Result := Result + TUtil.FormataStringNumeralFixo(pCOD_MUN,7,True) + '|';
  bloco0.reg0990.pQTD_LIN_0 := bloco0.reg0990.pQTD_LIN_0 + 1;
end;

function TReg0100.getREG : String;
begin
  Result := pREG;
end;

function TReg0100.getNOME : String;
begin
  Result := pNOME;
end;

function TReg0100.getCPF : string;
begin
  Result := pCPF;
end;

function TReg0100.getCRC : string;
begin
  Result := pCRC;
end;

function TReg0100.getCNPJ: string;
begin
  Result := pCNPJ;
end;

function TReg0100.getCEP: string;
begin
  Result := pCEP;
end;

function TReg0100.getENDERECO: string;
begin
  Result := pENDERECO;
end;

function TReg0100.getNUM: string;
begin
  Result := pNUM;
end;

function TReg0100.getCOMPL: string;
begin
  Result := pCOMPL;
end;

function TReg0100.getBAIRRO: string;
begin
  Result := pBAIRRO;
end;

function TReg0100.getFONE : string;
begin
  Result := pFONE;
end;

function TReg0100.getFAX:string;
begin
  Result := pFAX;
end;

function TReg0100.getEMAIL:string;
begin
  Result := pEMAIL;
end;

function TReg0100.getCOD_MUN:string;
begin
  Result := pCOD_MUN;
end;



procedure TReg0100.setREG(lREG : String);
begin
  pREG := lREG;
end;

procedure TReg0100.setNOME(lNOME : String);
begin
  pNOME := lNOME;
end;

procedure TReg0100.setCPF(lCPF: string);
begin
  pCPF:= lCPF;
end;

procedure TReg0100.setCRC(lCRC : string);
begin
  pCRC := lCRC;
end;

procedure TReg0100.setCNPJ(lCNPJ: string);
begin
  pCNPJ := lCNPJ;
end;

procedure TReg0100.setCEP(lCEP: string);
begin
  pCEP := lCEP;
end;

procedure TReg0100.setENDERECO(lENDERECO: string);
begin
  pENDERECO := lENDERECO;
end;

procedure TReg0100.setNUM(lNUM: string);
begin
  pNUM := lNUM;
end;

procedure TReg0100.setCOMPL(lCOMPL: string);
begin
  pCOMPL := lCOMPL;
end;

procedure TReg0100.setBAIRRO(lBAIRRO: string);
begin
  pBAIRRO := lBAIRRO;
end;

procedure TReg0100.setFONE(lFONE : string);
begin
  pFONE := lFONE;
end;

procedure TReg0100.setFAX(lFAX:string);
begin
  pFAX := lFAX;
end;

procedure TReg0100.setEMAIL(lEMAIL:string);
begin
  pEMAIL := lEMAIL;
end;

procedure TReg0100.setCOD_MUN(lCOD_MUN:string);
begin
  pCOD_MUN := lCOD_MUN;
end;


{ TReg0110 }
{REGISTRO 0110: REGISTRO 0110: REGIMES DE APURA��O DA CONTRIBUI��O SOCIAL E DE APROPRIA��O DE CR�DITO}

constructor TReg0110.Create;
begin
  inherited create;
  {Inicializa valores padr�o}
  pREG := '0110';
  pCOD_INC_TRIB := -1;
  pIND_APRO_CRED := -1;
  pCOD_TIPO_CONT := -1;
  pIND_REG_CUM := -1;
end;

destructor TReg0110.Destroy;
begin
 {}
 inherited;
end;

function TReg0110.getLinha: string;
begin
  Result := '|';
  Result := Result + pREG + '|';
  Result := Result + TUtil.FormataIntegerNumeralFixo(pCOD_INC_TRIB,1,True) + '|';
  Result := Result + TUtil.FormataIntegerNumeralFixo(pIND_APRO_CRED,1,False) + '|';
  Result := Result + TUtil.FormataIntegerNumeralFixo(pCOD_TIPO_CONT,1,False) + '|';
  Result := Result + TUtil.FormataIntegerNumeralFixo(pIND_REG_CUM,1,False) + '|';
  bloco0.reg0990.pQTD_LIN_0 := bloco0.reg0990.pQTD_LIN_0 + 1;
end;


function TReg0110.getREG: string;
begin
  Result := pREG;
end;

function TReg0110.getCOD_INC_TRIB: integer;
begin
  Result := pCOD_INC_TRIB;
end;

function TReg0110.getIND_APRO_CRED: integer;
begin
  Result := pIND_APRO_CRED;
end;

function TReg0110.getCOD_TIPO_CONT: integer;
begin
  Result := pCOD_TIPO_CONT;
end;

function TReg0110.getIND_REG_CUM: integer;
begin
  Result := pIND_REG_CUM;
end;


procedure TReg0110.setREG(lREG: string);
begin
  pREG := lREG;
end;

procedure TReg0110.setCOD_INC_TRIB(lCOD_INC_TRIB: integer);
begin
  pCOD_INC_TRIB := lCOD_INC_TRIB;
end;

procedure TReg0110.setIND_APRO_CRED(lIND_APRO_CRED: integer);
begin
  pIND_APRO_CRED := lIND_APRO_CRED;
end;

procedure TReg0110.setCOD_TIPO_CONT(lCOD_TIPO_CONT: integer);
begin
  pCOD_TIPO_CONT := lCOD_TIPO_CONT;
end;

procedure TReg0110.setIND_REG_CUM(lIND_REG_CUM: integer);
begin
  pIND_REG_CUM := lIND_REG_CUM;
end;



{ TReg0140 }
{REGISTRO 0140: TABELA DE CADASTRO DE ESTABELECIMENTO}
constructor TReg0140.Create;
begin
  inherited create;
  {Inicializa valores padr�o}
  pREG := '0140';
  pCOD_EST := '';
  pNOME := '';
  pCNPJ := '';
  pUF := '';
  pIE := '';
  pCOD_MUN := '';
  pIM := '';
  pSUFRAMA := '';
end;

destructor TReg0140.Destroy;
begin
 {}
 inherited;
end;


function TReg0140.getLinha: string;
begin
  Result := '|';
  Result := Result + pREG + '|';
  Result := Result + pCOD_EST + '|';
  Result := Result + pNOME + '|';
  Result := Result + TUtil.FormataStringNumeralFixo(pCNPJ,14,True) + '|';
  Result := Result + pUF + '|';
  Result := Result + pIE + '|';
  Result := Result + TUtil.FormataStringNumeralFixo(pCOD_MUN,7,True) + '|';
  Result := Result + pIM + '|';
  Result := Result + pSUFRAMA + '|';
  bloco0.reg0990.pQTD_LIN_0 := bloco0.reg0990.pQTD_LIN_0 + 1;
end;

function TReg0140.getREG: string;
begin
  Result := pREG;
end;

function TReg0140.getCOD_EST: String;
begin
  Result := pCOD_EST;
end;

function TReg0140.getNOME: String;
begin
  Result := pNOME;
end;

function TReg0140.getCNPJ: String;
begin
  Result := pCNPJ;
end;

function TReg0140.getUF: String;
begin
  Result := pUF;
end;

function TReg0140.getIE: String;
begin
  Result := pIE;
end;

function TReg0140.getCOD_MUN: String;
begin
  Result := pCOD_MUN
end;

function TReg0140.getIM: String;
begin
  Result := pIM;
end;

function TReg0140.getSUFRAMA: String;
begin
  Result := pSUFRAMA;
end;

procedure TReg0140.setREG(lREG: string);
begin
  pREG:= lREG;
end;

procedure TReg0140.setCOD_EST(lCOD_EST: String);
begin
  pCOD_EST := lCOD_EST;
end;

procedure TReg0140.setNOME(lNOME: String);
begin
  pNOME := lNOME;
end;

procedure TReg0140.setCNPJ(lCNPJ: String);
begin
  pCNPJ := lCNPJ;
end;

procedure TReg0140.setUF(lUF: String);
begin
  pUF := lUF;
end;

procedure TReg0140.setIE(lIE: String);
begin
  pIE := lIE;
end;

procedure TReg0140.setCOD_MUN(lCOD_MUN: String);
begin
  pCOD_MUN := lCOD_MUN;
end;

procedure TReg0140.setIM(lIM: String);
begin
  pIM := lIM;
end;

procedure TReg0140.setSUFRAMA(lSUFRAMA: String);
begin
  pSUFRAMA := lSUFRAMA;
end;






{ TReg0150 }
{REGISTRO 0150: TABELA DE CADASTRO DO PARTICIPANTE}
constructor TReg0150.Create;
begin
  inherited create;
  {Inicializa valores padr�o}
  pREG := '0150';
  pCOD_PART := '';
  pNOME := '';
  pCOD_PAIS := '01058'; //	BRASIL - N(5)*
  pCNPJ := '';
  pCPF := '';
  pIE := '';
  pCOD_MUN := '';
  pSUFRAMA := '';
  pENDERECO := '';
  pNUM := '';
  pCOMPL := '';
  pBAIRRO := '';
end;

destructor TReg0150.Destroy;
begin
 {}
 inherited;
end;


function TReg0150.getLinha: string;
begin
  Result := '|';
  Result := Result + pREG + '|';
  Result := Result + pCOD_PART + '|';
  Result := Result + pNOME + '|';
  Result := Result + TUtil.FormataStringNumeralFixo(pCOD_PAIS,5,True) + '|';
  Result := Result + TUtil.FormataStringNumeralFixo(pCNPJ,14,False) + '|';
  Result := Result + TUtil.FormataStringNumeralFixo(pCPF,11,False) + '|';
  Result := Result + pIE + '|';
  Result := Result + TUtil.FormataStringNumeralFixo(pCOD_MUN,7,True) + '|';
  Result := Result + pSUFRAMA + '|';
  Result := Result + pENDERECO + '|';
  Result := Result + pNUM + '|';
  Result := Result + pCOMPL + '|';
  Result := Result + pBAIRRO + '|';
  bloco0.reg0990.pQTD_LIN_0 := bloco0.reg0990.pQTD_LIN_0 + 1;
end;

function TReg0150.getREG: string;
begin
  Result := pREG;
end;

function TReg0150.getCOD_PART: String;
begin
  Result := pCOD_PART;
end;

function TReg0150.getNOME: String;
begin
  Result := pNOME;
end;

function TReg0150.getCOD_PAIS: String;
begin
  Result := pCOD_PAIS;
end;

function TReg0150.getCNPJ: String;
begin
  Result := pCNPJ;
end;

function TReg0150.getCPF: String;
begin
  Result := pCPF;
end;

function TReg0150.getIE: String;
begin
  Result := pIE;
end;

function TReg0150.getCOD_MUN: String;
begin
  Result := pCOD_MUN;
end;

function TReg0150.getSUFRAMA: String;
begin
  Result := pSUFRAMA;
end;

function TReg0150.getENDERECO: String;
begin
  Result := pENDERECO;
end;

function TReg0150.getNUM: String;
begin
  Result := pNUM;
end;

function TReg0150.getCOMPL: String;
begin
  Result := pCOMPL;
end;

function TReg0150.getBAIRRO: String;
begin
  Result := pBAIRRO;
end;


procedure TReg0150.setREG(lREG: string);
begin
  pREG:= lREG;
end;

procedure TReg0150.setCOD_PART(lCOD_PART: String);
begin
  pCOD_PART:= lCOD_PART;
end;

procedure TReg0150.setNOME(lNOME: String);
begin
  pNOME:= lNOME;
end;

procedure TReg0150.setCOD_PAIS(lCOD_PAIS: String);
begin
  pCOD_PAIS:= lCOD_PAIS;
end;

procedure TReg0150.setCNPJ(lCNPJ: String);
begin
  pCNPJ:= lCNPJ;
end;

procedure TReg0150.setCPF(lCPF: String);
begin
  pCPF:= lCPF;
end;

procedure TReg0150.setIE(lIE: String);
begin
  pIE:= lIE;
end;

procedure TReg0150.setCOD_MUN(lCOD_MUN: String);
begin
  pCOD_MUN:= lCOD_MUN;
end;

procedure TReg0150.setSUFRAMA(lSUFRAMA: String);
begin
  pSUFRAMA:= lSUFRAMA;
end;

procedure TReg0150.setENDERECO(lENDERECO: String);
begin
  pENDERECO:= lENDERECO;
end;

procedure TReg0150.setNUM(lNUM: String);
begin
  pNUM:= lNUM;
end;

procedure TReg0150.setCOMPL(lCOMPL: String);
begin
  pCOMPL:= lCOMPL;
end;

procedure TReg0150.setBAIRRO(lBAIRRO: String);
begin
  pBAIRRO:= lBAIRRO;
end;



{ TReg0190 }
{REGISTRO 0190: IDENTIFICA��O DAS UNIDADES DE MEDIDA}
constructor TReg0190.Create;
begin
  inherited create;
  {Inicializa valores padr�o}
  pREG := '0190';
  pUNID := 'UND';
  pDESCR := 'Unidade';
end;

destructor TReg0190.Destroy;
begin
 {}
 inherited;
end;

function TReg0190.getLinha: string;
begin
  Result := '|';
  Result := Result + pREG + '|';
  Result := Result + pUNID + '|';
  Result := Result + pDESCR + '|';
  bloco0.reg0990.pQTD_LIN_0 := bloco0.reg0990.pQTD_LIN_0 + 1;
end;

function TReg0190.getREG: string;
begin
  Result := pREG;
end;

function TReg0190.getUNID: String;
begin
  Result := pUNID;
end;

function TReg0190.getDESCR: String;
begin
  Result := pDESCR;
end;

procedure TReg0190.setREG(lREG: string);
begin
  pREG:= lREG;
end;

procedure TReg0190.setUNID(lUNID: String);
begin
  pUNID:= lUNID;
end;

procedure TReg0190.setDESCR(lDESCR: String);
begin
  pDESCR:= lDESCR;
end;





{ TReg0200 }
{REGISTRO 0200: TABELA DE IDENTIFICA��O DO ITEM (PRODUTOS E SERVI�OS)}
constructor TReg0200.Create;
begin
  inherited create;
  {Inicializa valores padr�o}
  pREG := '0200';
  pCOD_ITEM := '1';
  pDESCR_ITEM := '';
  pCOD_BARRA := '';
  pCOD_ANT_ITEM := '';
  pUNID_INV := 'UND';
  pTIPO_ITEM := '04';
  pCOD_NCM := '';
  pEX_IPI := '';
  pCOD_GEN := '';
  pCOD_LST := '';
  pALIQ_ICMS := -1;
end;

destructor TReg0200.Destroy;
begin
 {}
 inherited;
end;

function TReg0200.getLinha: string;
begin
  Result := '|';
  Result := Result + pREG + '|';
  Result := Result + pCOD_ITEM + '|';
  Result := Result + pDESCR_ITEM + '|';
  Result := Result + pCOD_BARRA + '|';
  Result := Result + pCOD_ANT_ITEM + '|';
  Result := Result + pUNID_INV + '|';
  Result := Result + TUtil.FormataStringNumeralFixo(pTIPO_ITEM,2,True) + '|';
  Result := Result + pCOD_NCM + '|';
  Result := Result + pEX_IPI + '|';
  Result := Result + TUtil.FormataStringNumeralFixo(pCOD_GEN,2,False) + '|';
  Result := Result + pCOD_LST + '|';
  Result := Result + TUtil.FormataCurrency(pALIQ_ICMS, False) + '|';
  bloco0.reg0990.pQTD_LIN_0 := bloco0.reg0990.pQTD_LIN_0 + 1;
end;


function TReg0200.getREG: string;
begin
  Result := pREG;
end;

function TReg0200.getCOD_ITEM: String;
begin
  Result := pCOD_ITEM;
end;

function TReg0200.getDESCR_ITEM: String;
begin
  Result := pDESCR_ITEM;
end;

function TReg0200.getCOD_BARRA: String;
begin
  Result := pCOD_BARRA;
end;

function TReg0200.getCOD_ANT_ITEM: String;
begin
  Result := pCOD_ANT_ITEM;
end;

function TReg0200.getUNID_INV: String;
begin
  Result := pUNID_INV;
end;

function TReg0200.getTIPO_ITEM: String;
begin
  Result := pTIPO_ITEM;
end;

function TReg0200.getCOD_NCM: String;
begin
  Result := pCOD_NCM;
end;

function TReg0200.getEX_IPI: String;
begin
  Result := pEX_IPI;
end;

function TReg0200.getCOD_GEN: String;
begin
  Result := pCOD_GEN;
end;

function TReg0200.getCOD_LST: String;
begin
  Result := pCOD_LST;
end;

function TReg0200.getALIQ_ICMS: Double;
begin
  Result := pALIQ_ICMS;
end;


procedure TReg0200.setREG(lREG: string);
begin
  pREG:= lREG;
end;

procedure TReg0200.setCOD_ITEM(lCOD_ITEM: String);
begin
  pCOD_ITEM:= lCOD_ITEM;
end;

procedure TReg0200.setDESCR_ITEM(lDESCR_ITEM: String);
begin
  pDESCR_ITEM:= lDESCR_ITEM;
end;

procedure TReg0200.setCOD_BARRA(lCOD_BARRA: String);
begin
  pCOD_BARRA:= lCOD_BARRA;
end;

procedure TReg0200.setCOD_ANT_ITEM(lCOD_ANT_ITEM: String);
begin
  pCOD_ANT_ITEM:= lCOD_ANT_ITEM;
end;

procedure TReg0200.setUNID_INV(lUNID_INV: String);
begin
  pUNID_INV:= lUNID_INV;
end;

procedure TReg0200.setTIPO_ITEM(lTIPO_ITEM: String);
begin
  pTIPO_ITEM:= lTIPO_ITEM;
end;

procedure TReg0200.setCOD_NCM(lCOD_NCM: String);
begin
  pCOD_NCM:= lCOD_NCM;
end;

procedure TReg0200.setEX_IPI(lEX_IPI: String);
begin
  pEX_IPI:= lEX_IPI;
end;

procedure TReg0200.setCOD_GEN(lCOD_GEN: String);
begin
  pCOD_GEN:= lCOD_GEN;
end;

procedure TReg0200.setCOD_LST(lCOD_LST: String);
begin
  pCOD_LST:= lCOD_LST;
end;

procedure TReg0200.setALIQ_ICMS(lALIQ_ICMS: Double);
begin
  pALIQ_ICMS:= lALIQ_ICMS;
end;




{ TReg0400 }
{REGISTRO 0400: TABELA DE NATUREZA DA OPERA��O/PRESTA��O}
constructor TReg0400.Create;
begin
  inherited create;
  {Inicializa valores padr�o}
  pREG := '0400';
  pCOD_NAT := '';
  pDESCR_NAT := '';
end;

destructor TReg0400.Destroy;
begin
 {}
 inherited;
end;

function TReg0400.getLinha: string;
begin
  Result := '|';
  Result := Result + pREG + '|';
  Result := Result + pCOD_NAT + '|';
  Result := Result + pDESCR_NAT + '|';
  bloco0.reg0990.pQTD_LIN_0 := bloco0.reg0990.pQTD_LIN_0 + 1;
end;

function TReg0400.getREG: string;
begin
  Result := pREG;
end;

function TReg0400.getCOD_NAT: String;
begin
  Result := pCOD_NAT;
end;

function TReg0400.getDESCR_NAT: String;
begin
  Result := pDESCR_NAT;
end;

procedure TReg0400.setREG(lREG: string);
begin
  pREG:= lREG;
end;

procedure TReg0400.setCOD_NAT(lCOD_NAT: String);
begin
  pCOD_NAT:= lCOD_NAT;
end;

procedure TReg0400.setDESCR_NAT(lDESCR_NAT: String);
begin
  pDESCR_NAT:= lDESCR_NAT;
end;





 { TReg0450 }
{REGISTRO 0450: TABELA DE INFORMA��O COMPLEMENTAR DO DOCUMENTO FISCAL}
constructor TReg0450.Create;
begin
  inherited create;
  {Inicializa valores padr�o}
  pREG := '0450';
  pCOD_INF := '1';
  pTXT := '';
end;

destructor TReg0450.Destroy;
begin
 {}
 inherited;
end;

function TReg0450.getLinha: string;
begin
  Result := '|';
  Result := Result + pREG + '|';
  Result := Result + pCOD_INF + '|';
  Result := Result + pTXT + '|';
  bloco0.reg0990.pQTD_LIN_0 := bloco0.reg0990.pQTD_LIN_0 + 1;
end;

function TReg0450.getREG: string;
begin
  Result := pREG;
end;

function TReg0450.getCOD_INF: String;
begin
  Result := pCOD_INF;
end;

function TReg0450.getTXT: String;
begin
  Result := pTXT;
end;

procedure TReg0450.setREG(lREG: string);
begin
  pREG:= lREG;
end;

procedure TReg0450.setCOD_INF(lCOD_INF: String);
begin
  pCOD_INF:= lCOD_INF;
end;

procedure TReg0450.setTXT(lTXT: String);
begin
  pTXT:= lTXT;
end;





{ TReg0990 }
{REGISTRO 0990: ENCERRAMENTO DO BLOCO 0}
constructor TReg0990.Create;
begin
  inherited create;
  {Inicializa valores padr�o}
  pREG := '0990';
  pQTD_LIN_0 := 0;
end;

destructor TReg0990.Destroy;
begin
 {}
 inherited;
end;

function TReg0990.getLinha: string;
begin
  bloco0.reg0990.pQTD_LIN_0 := bloco0.reg0990.pQTD_LIN_0 + 1;
  Result := '|';
  Result := Result + pREG + '|';
  Result := Result + TUtil.FormataInteger(pQTD_LIN_0, True) + '|';
end;

function TReg0990.getREG: string;
begin
  Result := pREG;
end;

function TReg0990.getQTD_LIN_0: Integer;
begin
  Result := pQTD_LIN_0;
end;

procedure TReg0990.setREG(lREG: string);
begin
  pREG:= lREG;
end;

procedure TReg0990.setQTD_LIN_0(lQTD_LIN_0: Integer);
begin
  pQTD_LIN_0:= lQTD_LIN_0;
end;





{BLOCO 0 - ABERTURA E IDENTIFICA��O}
constructor TBloco0.Create;
begin
  inherited create;
  {Inicializa valores padr�o}
  reg0000 := TReg0000.Create;
  reg0001 := TReg0001.Create;
  reg0100 := TReg0100.Create;
  reg0110 := TReg0110.Create;
  reg0140 := TReg0140.Create;
  reg0150 := TReg0150.Create;
  reg0190 := TReg0190.Create;
  reg0200 := TReg0200.Create;
  reg0400 := TReg0400.Create;
  reg0450 := TReg0450.Create;
  reg0990 := TReg0990.Create;
end;

destructor TBloco0.Destroy;
begin
 {Destroi registros}
  reg0000.Destroy;
  reg0001.Destroy;
  reg0100.Destroy;
  reg0110.Destroy;
  reg0140.Destroy;
  reg0150.Destroy;
  reg0190.Destroy;
  reg0200.Destroy;
  reg0400.Destroy;
  reg0450.Destroy;
  reg0990.Destroy;
 inherited;
end;



end.
