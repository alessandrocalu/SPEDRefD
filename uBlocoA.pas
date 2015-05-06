unit uBlocoA;

interface

uses Classes, SysUtils, uUtil;

{ BLOCO A: DOCUMENTOS FISCAIS - SERVI�OS (N�O SUJEITOS AO ICMS)

  As opera��es a serem escrituradas nos registros do Bloco A correspondem �s opera��es de presta��o de servi�os (Receitas)
  e/ou de contrata��o de servi�os (custos e/ou despesas geradoras de cr�ditos) que n�o est�o escrituradas nos registros constantes
  nos Blocos C, D e F. As opera��es de servi�os escrituradas nos Blocos C, D e F n�o devem ser informadas no Bloco A.

  Na hip�tese de dispensa da emiss�o de notas fiscais de servi�os, em decorr�ncia de legisla��o ou ato municipal, documentos
  equivalentes ser�o aceitos na escritura��o, devendo ser informados no Bloco F (registro F100), independente da Lei impor ou
  n�o forma especial a esses documentos equivalentes. Para a adequada validade dos mesmos, esses documentos devem ser de
  idoneidade indiscut�vel e conter os elementos definidores da opera��o. }

{ REGISTRO A001: ABERTURA DO BLOCO A

  Observa��es: Registro de escritura��o obrigat�ria.
  N�vel hier�rquico - 1
  Ocorr�ncia � um por arquivo
}

type
  TRegA001 = class

  private

    pREG: String; // Texto fixo contendo |A001| - C(4F)*
    { Campo 01 - Valor v�lido: [A001] }

    pIND_MOV: integer; // Indicador de movimento: 0 - Bloco com dados informados; 1 � Bloco sem dados informados.  - N(1)*
    { Campo 02 - Valores v�lidos: [0, 1]
      Valida��o: se o valor deste campo for igual a �1� (um), somente podem ser informados os registros de abertura e encerramento
      do bloco. Se o valor neste campo for igual a �0� (zero), deve ser informado pelo menos um registro al�m dos registros de
      abertura e encerramento do bloco. }

  protected

    function getREG: String;
    function getIND_MOV: integer;

    procedure setREG(lREG: String);
    procedure setIND_MOV(lIND_MOV: integer);

  public
    Constructor Create;
    Destructor Destroy; override;
    function getLinha: string;

    property REG: String read getREG write setREG;
    property IND_MOV: integer read getIND_MOV write setIND_MOV;
  end;

  { REGISTRO A010: IDENTIFICA��O DO ESTABELECIMENTO }

  { Este registro tem o objetivo de identificar o estabelecimento da pessoa jur�dica a que se referem as opera��es e documentos
    fiscais informados neste bloco. S� devem ser escriturados no Registro A010 os estabelecimentos que efetivamente tenham
    realizado opera��es de presta��o ou de contrata��o de servi�os, mediante emiss�o de documento fiscal, que devam ser
    escrituradas no Bloco A.

    O estabelecimento que n�o realizou opera��es pass�veis de registro nesse bloco, no per�odo da escritura��o, n�o deve ser
    identificado no Registro A010.

    Para cada estabelecimento cadastrado em �A010�, deve ser informado nos registros de n�vel inferior (Registros Filho) as
    opera��es pr�prias de presta��o ou de contrata��o de servi�os, mediante emiss�o de documento fiscal, no mercado interno ou
    externo. }

type
  TRegA010 = class

  private

    pREG: String; // Texto fixo contendo |0100| - C(4F)*
    { Campo 01 - Valor V�lido: [A010]; }

    pCNPJ: string; // N�mero de inscri��o do estabelecimento no CNPJ. N(14F)*
    { Campo 02 - Preenchimento: informar o n�mero do CNPJ do estabelecimento da pessoa jur�dica a que se referem as opera��es
      pass�veis de escritura��o neste bloco.
      Valida��o: � conferido o d�gito verificador (DV) do CNPJ informado. O estabelecimento informado neste registro deve est�
      cadastrado no Registro 0140. }

  protected

    function getREG: string;
    function getCNPJ: string;

    procedure setREG(lREG: string);
    procedure setCNPJ(lCNPJ: string);

  public
    Constructor Create;
    Destructor Destroy; override;
    function getLinha: string;

    property REG: String read getREG write setREG;
    property CNPJ: String read getCNPJ write setCNPJ;
  end;

  { REGISTRO A100: DOCUMENTO - NOTA FISCAL DE SERVI�O }

  { Deve ser gerado um Registro A100 para cada documento fiscal a ser relacionado na escritura��o, referente � presta��o ou �
    contrata��o de servi�os, que envolvam a emiss�o de documentos fiscais estabelecidos pelos Munic�pios, eletr�nicos ou em papel.
    Para cada registro A100, obrigatoriamente deve ser apresentado, pelo menos, um registro A170.

    Para documento fiscal de servi�o cancelado (c�digo da situa��o = 02), somente podem ser preenchidos os campos de c�digo
    da situa��o, indicador de opera��o, emitente, n�mero do documento, s�rie, subs�rie e c�digo do participante. Os campos s�rie
    e subs�rie n�o s�o obrigat�rios e o campo c�digo do participante � obrigat�rio nas opera��es de contrata��o de servi�os.
    N�o podem ser informados, para um mesmo documento fiscal, dois ou mais registros com a mesma combina��o de valores dos
    campos formadores da chave do registro. A chave deste registro �:
    � para documentos com campo IND_EMIT igual a �1� (um) � emiss�o por terceiros: campo IND_OPER, campo IND_EMIT,
    campo COD_PART, campo COD_SIT, campo SER e campo NUM_DOC;
    � para documentos com campo (IND_EMIT igual �0� (zero) � emiss�o pr�pria: campo IND_OPER, campo IND_EMIT, campo
    COD_SIT, campo SER e campo NUM_DOC. }

  { Observa��es:
    1. Devem ser informadas no Registro A100 as opera��es de servi�os, prestados ou contratados, cujo documento fiscal n�o seja
    objeto de escritura��o nos Blocos C, D e F.
    2. O detalhamento das informa��es dos itens da Nota Fiscal de Servi�o que repercute na apura��o das contribui��es sociais
    (servi�os prestados) e dos cr�ditos (servi�os contratados) deve ser informado, em rela��o a cada item relacionado no
    documento, no registro Filho �A170�.
    3. Caso a pessoa jur�dica tenha contratado servi�os � pessoa f�sica ou jur�dica domiciliada no exterior, com direito a cr�dito nas
    formas previstas na Lei n� 10.865, de 2004, deve preencher o Registro �A120� para validar a apura��o do cr�dito.
    4. Caso a pessoa jur�dica tenha realizado opera��es de presta��o de servi�o ou de contrata��o de servi�os com direito a cr�dito,
    sem a emiss�o de Nota Fiscal de Servi�o especifica ou documento internacional equivalente (no caso de servi�os contratados
    com pessoa f�sica ou jur�dica domiciliada no exterior), deve proceder � escritura��o das referidas opera��es no Registro
    �F100�, detalhando os campos necess�rios para a valida��o das contribui��es sociais ou dos cr�ditos.
    N�vel hier�rquico - 3
    Ocorr�ncia � 1:N }

type
  TRegA100 = class

  private

    pREG: String; // Texto fixo contendo |A100| - C(4F)*
    { Campo 01 - Valor V�lido: [A100] }

    pIND_OPER: String; // Indicador do tipo de opera��o: 0 - Servi�o Contratado pelo Estabelecimento; 1 - Servi�o Prestado pelo Estabelecimento. - C(1F)*
    { Campo 02 - Valores v�lidos: [0, 1]
      Preenchimento: indicar o tipo da opera��o, conforme os c�digos de preenchimento do campo. No caso de servi�o contratado
      informar o valor �0� e no caso de presta��o de servi�os informar o valor �1�. }

    pIND_EMIT: String; // Indicador do emitente do documento fiscal: 0 - Emiss�o Pr�pria; 1 - Emiss�o de Terceiros - C(1F)*
    { Campo 03 - Valores v�lidos: [0, 1]
      Preenchimento: consideram-se de emiss�o pr�pria somente os documentos fiscais emitidos pelo estabelecimento informado
      em A010. Documentos emitidos por outros estabelecimentos, ainda que da mesma empresa, devem ser considerados como documentos
      emitidos por terceiros. }

    pCOD_PART: String; // C�digo do participante (campo 02 do Registro 0150): - C(60)
    { - do emitente do documento, no caso de emiss�o de terceiros;
      - do adquirente, no caso de servi�os prestados. }
    { Campo 04 - Valida��o: o valor informado deve existir no campo COD_PART do registro 0150. Campo obrigat�rio na escritura��o
      das opera��es de contrata��o de servi�os (opera��es geradoras de cr�dito). Caso o servi�o seja prestado para consumi -
      dor final, n�o h� obrigatoriedade de informa��o do c�digo do participante. }

    pCOD_SIT: String; // C�digo da situa��o do documento fiscal: 00 � Documento regular; 02 � Documento cancelado - N(2F)*
    { Campo 05 - Valores v�lidos: [00, 02] }

    pSER: String; // S�rie do documento fiscal - C(20)
    { Campo 06 - Preenchimento: informar a s�rie do documento fiscal a que se refere o item. }

    pSUB: String; // Subs�rie do documento fiscal - C(20)
    { Campo 07 - Preenchimento: informar a subs�rie do documento fiscal a que se refere o item, caso conste no documento. }

    pNUM_DOC: String; // N�mero do documento fiscal ou documento internacional - C(60)*
    { Campo 08 � Valida��o: Informar o n�mero da nota fiscal ou documento internacional equivalente. Na impossibilidade de
      informar o n�mero espec�fico de documento fiscal, o campo deve ser preenchido com o conte�do �SN�. }

    pCHV_NFSE: String; // Chave/C�digo de Verifica��o da nota fiscal de servi�o eletr�nica - C(60)
    { Campo 09 - Preenchimento: Neste campo deve ser informado a chave ou c�digo de verifica��o, no caso de nota fiscal de servi�o
      eletr�nica. }

    pDT_DOC: TDate; // Data da emiss�o do documento fiscal - N(8F)*
    { Campo 10 - Preenchimento: informar a data de emiss�o do documento fiscal, no formato �ddmmaaaa�, excluindo-se quaisquer
      caracteres de separa��o, tais como: �.�, �/�, �-�.

      Valida��o: a data informada neste campo ou a data de execu��o/conclus�o do servi�o (campo 11) deve estar compreendida no
      per�odo da escritura��o (campos 06 e 07 do registro 0000). Regra aplic�vel na valida��o/edi��o de registros da escritura��o, a
      ser gerada com a vers�o 1.0.2 do Programa Validador e Assinador da EFD-Contribui��es. }

    pDT_EXE_SERV: TDate; // Data de Execu��o / Conclus�o do Servi�o - N(8F)
    { Campo 11 - Preenchimento: informar a data de execu��o ou da conclus�o do servi�o. No caso de n�o constar no documento
      fiscal a data da execu��o/conclus�o do servi�o contratado, ou esta n�o ser conhecida pela pessoa jur�dica, informar a data de
      emiss�o do documento fiscal ou do �ltimo dia da escritura��o, conforme o caso.
      No caso de servi�os contratados cuja execu��o total/conclus�o venha a ocorrer em per�odo posterior ao da escritura��o, como
      nos contratos de longo prazo, pode ser informado neste campo a data correspondente � data de laudo t�cnico que certifique a
      porcentagem executada em fun��o do progresso f�sico da empreitada ou produ��o.
      Valida��o: a data informada neste campo ou a data de emiss�o do documento fiscal (campo 10) deve estar compreendida no
      per�odo da escritura��o (campos 06 e 07 do registro 0000). Regra aplic�vel na valida��o/edi��o de registros da escritura��o, a
      ser gerada com a vers�o 1.0.2 do Programa Validador e Assinador da EFD-Contribui��es. }

    pVL_DOC: Currency; // Valor total do documento - N(-,2)*
    { Campo 12 � Preenchimento: informar o valor total do documento fiscal. }

    pIND_PGTO: String; // Indicador do tipo de pagamento: 0- � vista; 1- A prazo; 9- Sem pagamento. - C(1F)*
    { Campo 13 � Preenchimento: informar o tipo de pagamento pactuado, independente do pagamento ocorrer em per�odo anterior,
      no pr�prio per�odo ou em per�odo posterior ao de refer�ncia da escritura��o.
      Valores v�lidos: [0, 1, 9] }

    pVL_DESC: Currency; // Valor total do desconto - N(-,2)
    { Campo 14 - Preenchimento: informar neste campo o valor do desconto discriminado no documento fiscal. }

    pVL_BC_PIS: Currency; // Valor da base de c�lculo do PIS/PASEP - N(-,2)*
    { Campo 15 - Preenchimento: informar neste campo o valor da base de c�lculo do PIS/Pasep referente ao documento fiscal. }

    pVL_PIS: Currency; // Valor total do PIS - N(-,2)*
    { Campo 16 � Preenchimento: informar o valor total do PIS/Pasep (d�bito ou cr�dito) referente ao documento fiscal.
      Valida��o: a soma dos valores do campo VL_PIS dos registros filhos A170 deve ser igual ao valor informado neste campo. }

    pVL_BC_COFINS: Currency; // Valor da base de c�lculo da COFINS - N(-,2)*
    { Campo 17 - Preenchimento: informar neste campo o valor da base de c�lculo da Cofins referente ao documento fiscal. }

    pVL_COFINS: Currency; // Valor total da COFINS - N(-,2)*
    { Campo 18 � Preenchimento: informar o valor total da Cofins (d�bito ou cr�dito) referente ao documento fiscal.
      Valida��o: a soma dos valores do campo VL_COFINS dos registros filhos A170 deve ser igual ao valor informado neste campo. }

    pVL_PIS_RET: Currency; // Valor total do PIS retido na fonte - N(-,2)
    { Campo 19 - Preenchimento: informar o valor do PIS/Pasep retido na fonte correspondente aos servi�os constantes no documento
      fiscal. A informa��o constante do documento n�o ser� utilizada na apura��o das contribui��es (vide registro F600), sendo
      de natureza meramente informativa. }

    pVL_COFINS_RET: Currency; // Valor total da COFINS retido na fonte. - N(-,2)
    { Campo 20 - Preenchimento: informar o valor da Cofins retida na fonte correspondente aos servi�os constantes no documento
      fiscal. A informa��o constante do documento n�o ser� utilizada na apura��o das contribui��es (vide registro F600), sendo de
      natureza meramente informativa. }

    pVL_ISS: Currency; // Valor do ISS - N(-,2)
    { Campo 21 - Preenchimento: informar o valor do ISS referente aos servi�os constantes no documento fiscal. }

  protected

    function getREG: string;
    function getIND_OPER: String;
    function getIND_EMIT: String;
    function getCOD_PART: String;
    function getCOD_SIT: String;
    function getSER: String;
    function getSUB: String;
    function getNUM_DOC: String;
    function getCHV_NFSE: String;
    function getDT_DOC: TDate;
    function getDT_EXE_SERV: TDate;
    function getVL_DOC: Currency;
    function getIND_PGTO: String;
    function getVL_DESC: Currency;
    function getVL_BC_PIS: Currency;
    function getVL_PIS: Currency;
    function getVL_BC_COFINS: Currency;
    function getVL_COFINS: Currency;
    function getVL_PIS_RET: Currency;
    function getVL_COFINS_RET: Currency;
    function getVL_ISS: Currency;

    procedure setREG(lREG: string);
    procedure setIND_OPER(lIND_OPER: String);
    procedure setIND_EMIT(lIND_EMIT: String);
    procedure setCOD_PART(lCOD_PART: String);
    procedure setCOD_SIT(lCOD_SIT: String);
    procedure setSER(lSER: String);
    procedure setSUB(lSUB: String);
    procedure setNUM_DOC(lNUM_DOC: String);
    procedure setCHV_NFSE(lCHV_NFSE: String);
    procedure setDT_DOC(lDT_DOC: TDate);
    procedure setDT_EXE_SERV(lDT_EXE_SERV: TDate);
    procedure setVL_DOC(lVL_DOC: Currency);
    procedure setIND_PGTO(lIND_PGTO: String);
    procedure setVL_DESC(lVL_DESC: Currency);
    procedure setVL_BC_PIS(lVL_BC_PIS: Currency);
    procedure setVL_PIS(lVL_PIS: Currency);
    procedure setVL_BC_COFINS(lVL_BC_COFINS: Currency);
    procedure setVL_COFINS(lVL_COFINS: Currency);
    procedure setVL_PIS_RET(lVL_PIS_RET: Currency);
    procedure setVL_COFINS_RET(lVL_COFINS_RET: Currency);
    procedure setVL_ISS(lVL_ISS: Currency);

  public
    Constructor Create;
    Destructor Destroy; override;
    function getLinha: string;

    property REG: String read getREG write setREG;
    property IND_OPER: String read getIND_OPER write setIND_OPER;
    property IND_EMIT: String read getIND_EMIT write setIND_EMIT;
    property COD_PART: String read getCOD_PART write setCOD_PART;
    property COD_SIT: String read getCOD_SIT write setCOD_SIT;
    property SER: String read getSER write setSER;
    property SUB: String read getSUB write setSUB;
    property NUM_DOC: String read getNUM_DOC write setNUM_DOC;
    property CHV_NFSE: String read getCHV_NFSE write setCHV_NFSE;
    property DT_DOC: TDate read getDT_DOC write setDT_DOC;
    property DT_EXE_SERV: TDate read getDT_EXE_SERV write setDT_EXE_SERV;
    property VL_DOC: Currency read getVL_DOC write setVL_DOC;
    property IND_PGTO: String read getIND_PGTO write setIND_PGTO;
    property VL_DESC: Currency read getVL_DESC write setVL_DESC;
    property VL_BC_PIS: Currency read getVL_BC_PIS write setVL_BC_PIS;
    property VL_PIS: Currency read getVL_PIS write setVL_PIS;
    property VL_BC_COFINS: Currency read getVL_BC_COFINS write setVL_BC_COFINS;
    property VL_COFINS: Currency read getVL_COFINS write setVL_COFINS;
    property VL_PIS_RET: Currency read getVL_PIS_RET write setVL_PIS_RET;
    property VL_COFINS_RET
      : Currency read getVL_COFINS_RET write setVL_COFINS_RET;
    property VL_ISS: Currency read getVL_ISS write setVL_ISS;

  end;

  { REGISTRO A110: COMPLEMENTO DO DOCUMENTO - INFORMA��O COMPLEMENTAR DA NF }
  { Este registro tem por objetivo identificar os dados contidos no campo Informa��es Complementares da Nota Fiscal, que sejam
    de interesse do Fisco ou conforme disponha a legisla��o, e que estejam explicitamente citadas no documento Fiscal, tais como:
    forma de pagamento, local da presta��o/execu��o do servi�o, opera��o realizada com suspens�o das contribui��es sociais, etc.
    N�o podem ser informados para um mesmo documento fiscal, dois ou mais registros com o mesmo conte�do no campo
    COD_INF.

    Observa��es:
    N�vel hier�rquico - 4
    Ocorr�ncia � 1:N
    }

type
  TRegA110 = class

  private

    pREG: String; // Texto fixo contendo |A110| - C(4)*
    { Campo 01 - Valor V�lido: [A110] }

    pCOD_INF: String; // C�digo da informa��o complementar do documento fiscal (Campo 02 do Registro 0450) - C(6)*
    { Campo 02 - Valida��o: o valor informado no campo deve existir no registro 0450 - Tabela de informa��o complementar. }

    pTXT_COMPL: String; // Informa��o Complementar do Documento Fiscal - C(-)

  protected

    function getREG: string;
    function getCOD_INF: String;
    function getTXT_COMPL: String;

    procedure setREG(lREG: string);
    procedure setCOD_INF(lCOD_INF: String);
    procedure setTXT_COMPL(lTXT_COMPL: String);

  public
    Constructor Create;
    Destructor Destroy; override;
    function getLinha: string;

    property REG: String read getREG write setREG;
    property COD_INF: String read getCOD_INF write setCOD_INF;
    property TXT_COMPL: String read getTXT_COMPL write setTXT_COMPL;
  end;

  { REGISTRO A170: COMPLEMENTO DO DOCUMENTO - ITENS DO DOCUMENTO }

  { Registro obrigat�rio para discriminar os itens da nota fiscal de servi�o emitida pela pessoa jur�dica ou por terceiros.
    N�o podem ser informados para um mesmo documento fiscal, dois ou mais registros com o mesmo conte�do no campo
    NUM_ITEM. }

  { Observa��es:
    1. No Registro A170 ser�o informados os itens constantes nas Notas Fiscais de Servi�os ou documento internacional
    equivalente (no caso de importa��es), especificando o tratamento tribut�vel (CST) aplic�vel a item.
    2. Em rela��o aos itens com CST representativos de receitas, os valores dos Campos de bases de c�lculo, VL_BC_PIS (Campo
    10) e VL_BC_COFINS (Campo 14) ser�o recuperados no Bloco M, para a demonstra��o das bases de c�lculo do PIS/Pasep
    (M210) e da Cofins (M610), no Campo �VL_BC_CONT�.
    3. Em rela��o aos itens com CST representativos de opera��es geradoras de cr�ditos, os valores dos Campos de bases de
    c�lculo, VL_BC_PIS (Campo 10) e VL_BC_COFINS (Campo 14) ser�o recuperados no Bloco M, para a demonstra��o das
    bases de c�lculo do cr�dito de PIS/Pasep (M105), no campo �VL_BC_PIS_TOT� e do cr�dito da Cofins (M505), no Campo
    �VL_BC_COFINS_TOT�.
    N�vel hier�rquico - 4
    }

type
  TRegA170 = class

  private

    pREG: String; // Texto fixo contendo |A170| - C(4)*
    { Campo 01 - Valor V�lido: [A170] }

    pNUM_ITEM: integer; // N�mero seq�encial do item no documento fiscal - N(4)*
    { Campo 02 - Valida��o: deve ser maior que �0� (zero) e sequencial. }

    pCOD_ITEM: String; // C�digo do item (campo 02 do Registro 0200) - C(60)*
    { Campo 03 - Preenchimento: o valor informado neste campo deve existir no registro 0200, ressaltando-se que os c�digos
      informados devem ser os definidos pela pessoa jur�dica titular da escritura��o. }

    pDESCR_COMPL: String; // Descri��o complementar do item como adotado no documento fiscal - C(-)
    { Campo 04 - Preenchimento: Neste campo pode ser informada a descri��o complementar do item, conforme adotado no documento
      fiscal. }

    pVL_ITEM: Currency; // Valor total do item (mercadorias ou servi�os) - N(-,2)*
    { Campo 05 - Preenchimento: informar o valor total do item (servi�os ou mercadorias) a que se refere o registro. }

    pVL_DESC: Currency; // Valor do desconto do item / Exclus�o - N(-,2)
    { Campo 06 - Preenchimento: informar o valor do desconto comercial ou dos valores a excluir da base de c�lculo da contribui��o
      ou do cr�dito, conforme o caso. }

    pNAT_BC_CRED: String; // C�digo da Base de C�lculo do Cr�dito, conforme a Tabela indicada no item 4.3.7, - C(2F)
    { caso seja informado c�digo representativo de cr�dito no Campo 09 (CST_PIS) ou no Campo 13 (CST_COFINS). }
    { 4.3.7 � Tabela C�digo de Base de C�lculo do Cr�dito: A ser utilizada na codifica��o da base de c�lculo dos cr�ditos apurado
      no per�odo, no caso de ser preenchido registro de documentos e opera��es geradoras de cr�dito, nos Blocos A, C, D, F e 1
      (Cr�ditos extempor�neos).
      C�digo Descri��o
      01 Aquisi��o de bens para revenda
      02 Aquisi��o de bens utilizados como insumo
      03 Aquisi��o de servi�os utilizados como insumo
      04 Energia el�trica e t�rmica, inclusive sob a forma de vapor
      05 Alugu�is de pr�dios
      06 Alugu�is de m�quinas e equipamentos
      07 Armazenagem de mercadoria e frete na opera��o de venda
      08 Contrapresta��es de arrendamento mercantil
      09 M�quinas, equipamentos e outros bens incorporados ao ativo imobilizado (cr�dito sobre encargos de
      deprecia��o).
      10 M�quinas, equipamentos e outros bens incorporados ao ativo imobilizado (cr�dito com base no valor de
      aquisi��o).
      11 Amortiza��o e Deprecia��o de edifica��es e benfeitorias em im�veis
      12 Devolu��o de Vendas Sujeitas � Incid�ncia N�o-Cumulativa
      13 Outras Opera��es com Direito a Cr�dito
      14 Atividade de Transporte de Cargas � Subcontrata��o
      15 Atividade Imobili�ria � Custo Incorrido de Unidade Imobili�ria
      16 Atividade Imobili�ria � Custo Or�ado de unidade n�o conclu�da
      17 Atividade de Presta��o de Servi�os de Limpeza, Conserva��o e Manuten��o � vale-transporte, vale-refei��o ou
      vale-alimenta��o, fardamento ou uniforme.
      18 Estoque de abertura de bens }
    { Campo 07 - Preenchimento: Caso seja informado c�digo representativo de cr�dito no Campo 09 (CST_PIS) ou no Campo 13
      (CST_COFINS) do Registro A170, informar neste campo o c�digo da base de c�lculo do cr�dito, conforme a Tabela �4.3.7 �
      Base de C�lculo do Cr�dito� referenciada no Manual do Leiaute da EFD-Contribui��es e disponibilizada no Portal do SPED
      no s�tio da RFB na Internet, no endere�o <http://www.receita.fazenda.gov.br/sped. }

    pIND_ORIG_CRED: String; // Indicador da origem do cr�dito: 0 � Opera��o no Mercado Interno; 1 � Opera��o de Importa��o - C(1F)
    { Campo 08 - Valores v�lidos: [0, 1]
      Preenchimento: informar neste campo o c�digo indicador da origem do cr�dito, se referente � opera��o no mercado interno
      (c�digo �0�) ou se referente a opera��o de importa��o (c�digo �1�). No caso de se referir � opera��o de importa��o, deve ser
      escriturado o registro A120. }

    pCST_PIS: String; // C�digo da Situa��o Tribut�ria referente ao PIS/PASEP � Tabela 4.3.3. - N(2F)*
    { 4.3.3 - Tabela C�digo da Situa��o Tribut�ria Referente ao PIS/Pasep � CST-PIS: Tabela externa publicada pela
      RFB e disponibilizada no Portal do SPED no s�tio da RFB na Internet, no endere�o <http://www.receita.fazenda.gov.br/sped>; }
    { Campo 09 - Preenchimento: Informar neste campo o C�digo de Situa��o Tribut�ria referente ao PIS/PASEP (CST), conforme
      a Tabela II constante no Anexo �nico da Instru��o Normativa RFB n� 1.009, de 2010, referenciada no Manual do Leiaute
      da EFD-Contribui��es. }

    pVL_BC_PIS: Currency; // Valor da base de c�lculo do PIS/PASEP. - N(-,2)
    { Campo 10 - Preenchimento: informar neste campo o valor da base de c�lculo do PIS/Pasep referente ao item do documento
      fiscal, para fins de apura��o da contribui��o social ou de apura��o do cr�dito, conforme o caso.

      O valor deste campo ser� recuperado no Bloco M, para a demonstra��o das bases de c�lculo do PIS/Pasep (M210, Campo
      �VL_BC_CONT�) no caso de item correspondente a fato gerador da contribui��o social, ou para a demonstra��o das bases de
      c�lculo do cr�dito de PIS/Pasep (M105, campo �VL_BC_PIS_TOT�) no caso de item correspondente a fato gerador de cr�dito. }

    pALIQ_PIS: Double; // Al�quota do PIS/PASEP (em percentual) - N(-,2)
    { Campo 11 - Preenchimento: informar neste campo o valor da al�quota aplic�vel para fins de apura��o da contribui��o social
      ou do cr�dito, conforme o caso. }

    pVL_PIS: Currency; // Valor do PIS/PASEP - N(-,2)
    { Campo 12 � Preenchimento: informar o valor do PIS/Pasep (contribui��o ou cr�dito) referente ao item do documento fiscal.
      Valida��o: o valor do campo �VL_PIS� deve corresponder ao valor da base de c�lculo (VL_BC_PIS) multiplicado pela
      al�quota aplic�vel ao item (ALIQ_PIS). No caso de aplica��o da al�quota do campo 07, o resultado dever� ser dividido pelo
      valor �100�.
      Exemplo: Sendo o Campo �VL_BC_PIS� = 1.000.000,00 e o Campo �ALIQ_PIS� = 1,65 , ent�o o Campo �VL_PIS� ser�
      igual a: 1.000.000,00 x 1,65 / 100 = 16.500,00. }

    pCST_COFINS: String; // C�digo da Situa��o Tribut�ria referente ao COFINS � Tabela 4.3.4 - N(2F)*
    { Campo 13 - Preenchimento: Informar neste campo o C�digo de Situa��o Tribut�ria referente a Cofins (CST), conforme a Tabela
      III constante no Anexo �nico da Instru��o Normativa RFB n� 1.009, de 2010, referenciada no Manual do Leiaute da
      EFD-Contribui��es. }

    pVL_BC_COFINS: Currency; // Valor da base de c�lculo da COFINS - N(-,2)
    { Campo 14 - Preenchimento: informar neste campo o valor da base de c�lculo da Cofins referente ao item do documento fiscal,
      para fins de apura��o da contribui��o social ou de apura��o do cr�dito, conforme o caso.
      O valor deste campo ser� recuperado no Bloco M, para a demonstra��o das bases de c�lculo da Cofins (M610, Campo
      �VL_BC_CONT�) no caso de item correspondente a fato gerador da contribui��o social, ou para a demonstra��o das bases de
      c�lculo do cr�dito de Cofins (M505, campo �VL_BC_COFINS_TOT�) no caso de item correspondente a fato gerador de cr�dito. }

    pALIQ_COFINS: Double; // Al�quota do COFINS (em percentual) - N(6,2)
    { Campo 15 - Preenchimento: informar neste campo o valor da al�quota aplic�vel para fins de apura��o da contribui��o social
      ou do cr�dito, conforme o caso. }

    pVL_COFINS: Currency; // Valor da COFINS - N(-,2)
    { Campo 16 � Preenchimento: informar o valor da Cofins (contribui��o ou cr�dito) referente ao item do documento fiscal.
      Valida��o: o valor do campo �VL_COFINS� deve corresponder ao valor da base de c�lculo (VL_BC_COFINS) multiplicado
      pela al�quota aplic�vel ao item (ALIQ_COFINS). No caso de aplica��o da al�quota do campo 07, o resultado dever� ser dividido
      pelo valor �100�.

      Exemplo: Sendo o Campo �VL_BC_COFINS� = 1.000.000,00 e o Campo �ALIQ_COFINS� = 7,60 , ent�o o Campo
      �VL_COFINS� ser� igual a: 1.000.000,00 x 7,6 / 100 = 76.000,00.
      }

    pCOD_CTA: String; // C�digo da conta anal�tica cont�bil debitada/creditada - C(60)
    { Campo 17 - Preenchimento: informar o C�digo da Conta Anal�tica. Exemplos: custo de servi�os prestados por pessoa jur�dica,
      receita da presta��o de servi�os, receitas da atividade, servi�os contratados, etc. Deve ser a conta credora ou devedora principal,
      podendo ser informada a conta sint�tica (n�vel acima da conta anal�tica). }

    pCOD_CCUS: String; // C�digo do centro de custos - C(60)
    { Campo 18 - Preenchimento: Nos registros correspondentes a opera��es com direito a cr�dito, informar neste campo o C�digo
      do Centro de Custo relacionado � opera��o, se existir. }

  protected

    function getREG: string;
    function getNUM_ITEM: integer;
    function getCOD_ITEM: String;
    function getDESCR_COMPL: String;
    function getVL_ITEM: Currency;
    function getVL_DESC: Currency;
    function getNAT_BC_CRED: String;
    function getIND_ORIG_CRED: String;
    function getCST_PIS: String;
    function getVL_BC_PIS: Currency;
    function getALIQ_PIS: Double;
    function getVL_PIS: Currency;
    function getCST_COFINS: String;
    function getVL_BC_COFINS: Currency;
    function getALIQ_COFINS: Double;
    function getVL_COFINS: Currency;
    function getCOD_CTA: String;
    function getCOD_CCUS: String;

    procedure setREG(lREG: string);
    procedure setNUM_ITEM(lNUM_ITEM: integer);
    procedure setCOD_ITEM(lCOD_ITEM: String);
    procedure setDESCR_COMPL(lDESCR_COMPL: String);
    procedure setVL_ITEM(lVL_ITEM: Currency);
    procedure setVL_DESC(lVL_DESC: Currency);
    procedure setNAT_BC_CRED(lNAT_BC_CRED: String);
    procedure setIND_ORIG_CRED(lIND_ORIG_CRED: String);
    procedure setCST_PIS(lCST_PIS: String);
    procedure setVL_BC_PIS(lVL_BC_PIS: Currency);
    procedure setALIQ_PIS(lALIQ_PIS: Double);
    procedure setVL_PIS(lVL_PIS: Currency);
    procedure setCST_COFINS(lCST_COFINS: String);
    procedure setVL_BC_COFINS(lVL_BC_COFINS: Currency);
    procedure setALIQ_COFINS(lALIQ_COFINS: Double);
    procedure setVL_COFINS(lVL_COFINS: Currency);
    procedure setCOD_CTA(lCOD_CTA: String);
    procedure setCOD_CCUS(lCOD_CCUS: String);

  public
    Constructor Create;
    Destructor Destroy; override;
    function getLinha: string;

    property REG: String read getREG write setREG;
    property NUM_ITEM: integer read getNUM_ITEM write setNUM_ITEM;
    property COD_ITEM: String read getCOD_ITEM write setCOD_ITEM;
    property DESCR_COMPL: String read getDESCR_COMPL write setDESCR_COMPL;
    property VL_ITEM: Currency read getVL_ITEM write setVL_ITEM;
    property VL_DESC: Currency read getVL_DESC write setVL_DESC;
    property NAT_BC_CRED: String read getNAT_BC_CRED write setNAT_BC_CRED;
    property IND_ORIG_CRED: String read getIND_ORIG_CRED write setIND_ORIG_CRED;
    property CST_PIS: String read getCST_PIS write setCST_PIS;
    property VL_BC_PIS: Currency read getVL_BC_PIS write setVL_BC_PIS;
    property ALIQ_PIS: Double read getALIQ_PIS write setALIQ_PIS;
    property VL_PIS: Currency read getVL_PIS write setVL_PIS;
    property CST_COFINS: String read getCST_COFINS write setCST_COFINS;
    property VL_BC_COFINS: Currency read getVL_BC_COFINS write setVL_BC_COFINS;
    property ALIQ_COFINS: Double read getALIQ_COFINS write setALIQ_COFINS;
    property VL_COFINS: Currency read getVL_COFINS write setVL_COFINS;
    property COD_CTA: String read getCOD_CTA write setCOD_CTA;
    property COD_CCUS: String read getCOD_CCUS write setCOD_CCUS;
  end;

  { REGISTRO A990: ENCERRAMENTO DO BLOCO A }
  { Este registro destina-se a identificar o encerramento do bloco A e informar a quantidade de linhas (registros)
    existentes no bloco. }

  { Observa��es: Registro obrigat�rio, no caso do arquivo conter o Registro A001
    N�vel hier�rquico - 1
    Ocorr�ncia � um por arquivo
    Valida��o do Registro: registro �nico e obrigat�rio para todos os informantes da EFD-Contribui��es. }

type
  TRegA990 = class

  private

    pREG: String; // Texto fixo contendo |A990| - C(4)*
    { Campo 01 - Valor V�lido: [A990] }

    pQTD_LIN_A: integer; // Quantidade total de linhas do Bloco A
    { Campo 02 - Preenchimento: a quantidade de linhas a ser informada deve considerar tamb�m os pr�prios registros de
      abertura e encerramento do bloco.
      Valida��o: o n�mero de linhas (registros) existentes no bloco A � igual ao valor informado no campo QTD_LIN_A
      (registro C990). }

  protected

    function getREG: string;
    function getQTD_LIN_A: integer;

    procedure setREG(lREG: string);
    procedure setQTD_LIN_A(lQTD_LIN_A: integer);

  public
    Constructor Create;
    Destructor Destroy; override;
    function getLinha: string;

    property REG: String read getREG write setREG;
    property QTD_LIN_A: integer read getQTD_LIN_A write setQTD_LIN_A;
  end;

  { BLOCO 0 - ABERTURA E IDENTIFICA��O }
type
  TBlocoA = class

  public
    regA001: TRegA001;
    regA010: TRegA010;
    regA100: TRegA100;
    regA110: TRegA110;
    regA170: TRegA170;
    regA990: TRegA990;
    Constructor Create;
    Destructor Destroy; override;
  end;

var
  blocoA: TBlocoA;

implementation

{ TRegA001 }
{ REGISTRO A001: ABERTURA DO BLOCO A }

constructor TRegA001.Create;
begin
  inherited Create;
  { Inicializa valores padr�o }
  pREG := 'A001';
  pIND_MOV := 0;
end;

destructor TRegA001.Destroy;
begin
  { }
  inherited;
end;

function TRegA001.getLinha: string;
begin
  Result := '|';
  Result := Result + pREG + '|';
  Result := Result + TUtil.FormataIntegerNumeralFixo(pIND_MOV, 1, True) + '|';
  blocoA.regA990.pQTD_LIN_A := blocoA.regA990.pQTD_LIN_A + 1;
end;

function TRegA001.getREG: String;
begin
  Result := pREG;
end;

function TRegA001.getIND_MOV: integer;
begin
  Result := pIND_MOV;
end;

procedure TRegA001.setREG(lREG: String);
begin
  pREG := lREG;
end;

procedure TRegA001.setIND_MOV(lIND_MOV: integer);
begin
  pIND_MOV := lIND_MOV;
end;

{ TRegA010 }
{ REGISTRO A010: IDENTIFICA��O DO ESTABELECIMENTO }

constructor TRegA010.Create;
begin
  inherited Create;
  { Inicializa valores padr�o }
  pREG := 'A010';
  pCNPJ := '';
end;

destructor TRegA010.Destroy;
begin
  { }
  inherited;
end;

function TRegA010.getLinha: string;
begin
  Result := '|';
  Result := Result + pREG + '|';
  Result := Result + TUtil.FormataStringNumeralFixo(pCNPJ, 14, True) + '|';
  blocoA.regA990.pQTD_LIN_A := blocoA.regA990.pQTD_LIN_A + 1;
end;

function TRegA010.getREG: String;
begin
  Result := pREG;
end;

function TRegA010.getCNPJ: string;
begin
  Result := pCNPJ;
end;

procedure TRegA010.setREG(lREG: String);
begin
  pREG := lREG;
end;

procedure TRegA010.setCNPJ(lCNPJ: string);
begin
  pCNPJ := lCNPJ;
end;

{ TRegA100 }
{ REGISTRO A100: DOCUMENTO - NOTA FISCAL DE SERVI�O }

constructor TRegA100.Create;
begin
  inherited Create;

  { Inicializa valores padr�o }
  pREG := 'A100';
  pIND_OPER := '1';
  pIND_EMIT := '0';
  pCOD_PART := '';
  pCOD_SIT := '00';
  pSER := '';
  pSUB := '';
  pNUM_DOC := 'SN';
  pCHV_NFSE := '';
  pDT_DOC := now();
  pDT_EXE_SERV := now();
  pVL_DOC := 0;
  pIND_PGTO := '0';
  pVL_DESC := -1;
  pVL_BC_PIS := 0;
  pVL_PIS := 0;
  pVL_BC_COFINS := 0;
  pVL_COFINS := 0;
  pVL_PIS_RET := -1;
  pVL_COFINS_RET := -1;
  pVL_ISS := -1;

end;

destructor TRegA100.Destroy;
begin
  { }
  inherited;
end;

function TRegA100.getLinha: string;
begin
  Result := '|';
  Result := Result + pREG + '|';
  Result := Result + TUtil.FormataStringNumeralFixo(pIND_OPER, 1, True) + '|';
  Result := Result + TUtil.FormataStringNumeralFixo(pIND_EMIT, 1, True) + '|';
  Result := Result + pCOD_PART + '|';
  Result := Result + TUtil.FormataStringNumeralFixo(pCOD_SIT, 2, True) + '|';
  Result := Result + pSER + '|';
  Result := Result + pSUB + '|';
  Result := Result + pNUM_DOC + '|';
  Result := Result + pCHV_NFSE + '|';
  Result := Result + TUtil.FormataDataFixo(pDT_DOC, True) + '|';
  Result := Result + TUtil.FormataDataFixo(pDT_EXE_SERV, False) + '|';
  Result := Result + TUtil.FormataCurrency(pVL_DOC, True) + '|';
  Result := Result + TUtil.FormataStringNumeralFixo(pIND_PGTO, 1, True) + '|';
  Result := Result + TUtil.FormataCurrency(pVL_DESC, False) + '|';
  Result := Result + TUtil.FormataCurrency(pVL_BC_PIS, True) + '|';
  Result := Result + TUtil.FormataCurrency(pVL_PIS, True) + '|';
  Result := Result + TUtil.FormataCurrency(pVL_BC_COFINS, True) + '|';
  Result := Result + TUtil.FormataCurrency(pVL_COFINS, True) + '|';
  Result := Result + TUtil.FormataCurrency(pVL_PIS_RET, False) + '|';
  Result := Result + TUtil.FormataCurrency(pVL_COFINS_RET, False) + '|';
  Result := Result + TUtil.FormataCurrency(pVL_ISS, False) + '|';
  blocoA.regA990.pQTD_LIN_A := blocoA.regA990.pQTD_LIN_A + 1;
end;

function TRegA100.getREG: string;
begin
  Result := pREG;
end;

function TRegA100.getIND_OPER: String;
begin
  Result := pIND_OPER;
end;

function TRegA100.getIND_EMIT: String;
begin
  Result := pIND_EMIT;
end;

function TRegA100.getCOD_PART: String;
begin
  Result := pCOD_PART;
end;

function TRegA100.getCOD_SIT: String;
begin
  Result := pCOD_SIT;
end;

function TRegA100.getSER: String;
begin
  Result := pSER;
end;

function TRegA100.getSUB: String;
begin
  Result := pSUB;
end;

function TRegA100.getNUM_DOC: String;
begin
  Result := pNUM_DOC;
end;

function TRegA100.getCHV_NFSE: String;
begin
  Result := pCHV_NFSE;
end;

function TRegA100.getDT_DOC: TDate;
begin
  Result := pDT_DOC;
end;

function TRegA100.getDT_EXE_SERV: TDate;
begin
  Result := pDT_EXE_SERV;
end;

function TRegA100.getVL_DOC: Currency;
begin
  Result := pVL_DOC;
end;

function TRegA100.getIND_PGTO: String;
begin
  Result := pIND_PGTO;
end;

function TRegA100.getVL_DESC: Currency;
begin
  Result := pVL_DESC;
end;

function TRegA100.getVL_BC_PIS: Currency;
begin
  Result := pVL_BC_PIS;
end;

function TRegA100.getVL_PIS: Currency;
begin
  Result := pVL_PIS;
end;

function TRegA100.getVL_BC_COFINS: Currency;
begin
  Result := pVL_BC_COFINS;
end;

function TRegA100.getVL_COFINS: Currency;
begin
  Result := pVL_COFINS;
end;

function TRegA100.getVL_PIS_RET: Currency;
begin
  Result := pVL_PIS_RET;
end;

function TRegA100.getVL_COFINS_RET: Currency;
begin
  Result := pVL_COFINS_RET;
end;

function TRegA100.getVL_ISS: Currency;
begin
  Result := pVL_ISS;
end;

procedure TRegA100.setREG(lREG: string);
begin
  pREG := lREG;
end;

procedure TRegA100.setIND_OPER(lIND_OPER: String);
begin
  pIND_OPER := lIND_OPER;
end;

procedure TRegA100.setIND_EMIT(lIND_EMIT: String);
begin
  pIND_EMIT := lIND_EMIT;
end;

procedure TRegA100.setCOD_PART(lCOD_PART: String);
begin
  pCOD_PART := lCOD_PART;
end;

procedure TRegA100.setCOD_SIT(lCOD_SIT: String);
begin
  pCOD_SIT := lCOD_SIT;
end;

procedure TRegA100.setSER(lSER: String);
begin
  pSER := lSER;
end;

procedure TRegA100.setSUB(lSUB: String);
begin
  pSUB := lSUB;
end;

procedure TRegA100.setNUM_DOC(lNUM_DOC: String);
begin
  pNUM_DOC := lNUM_DOC;
end;

procedure TRegA100.setCHV_NFSE(lCHV_NFSE: String);
begin
  pCHV_NFSE := lCHV_NFSE;
end;

procedure TRegA100.setDT_DOC(lDT_DOC: TDate);
begin
  pDT_DOC := lDT_DOC;
end;

procedure TRegA100.setDT_EXE_SERV(lDT_EXE_SERV: TDate);
begin
  pDT_EXE_SERV := lDT_EXE_SERV;
end;

procedure TRegA100.setVL_DOC(lVL_DOC: Currency);
begin
  pVL_DOC := lVL_DOC;
end;

procedure TRegA100.setIND_PGTO(lIND_PGTO: String);
begin
  pIND_PGTO := lIND_PGTO;
end;

procedure TRegA100.setVL_DESC(lVL_DESC: Currency);
begin
  pVL_DESC := lVL_DESC;
end;

procedure TRegA100.setVL_BC_PIS(lVL_BC_PIS: Currency);
begin
  pVL_BC_PIS := lVL_BC_PIS;
end;

procedure TRegA100.setVL_PIS(lVL_PIS: Currency);
begin
  pVL_PIS := lVL_PIS;
end;

procedure TRegA100.setVL_BC_COFINS(lVL_BC_COFINS: Currency);
begin
  pVL_BC_COFINS := lVL_BC_COFINS;
end;

procedure TRegA100.setVL_COFINS(lVL_COFINS: Currency);
begin
  pVL_COFINS := lVL_COFINS;
end;

procedure TRegA100.setVL_PIS_RET(lVL_PIS_RET: Currency);
begin
  pVL_PIS_RET := lVL_PIS_RET;
end;

procedure TRegA100.setVL_COFINS_RET(lVL_COFINS_RET: Currency);
begin
  pVL_COFINS_RET := lVL_COFINS_RET;
end;

procedure TRegA100.setVL_ISS(lVL_ISS: Currency);
begin
  pVL_ISS := lVL_ISS;
end;

{ TRegA110 }
{ REGISTRO A110: COMPLEMENTO DO DOCUMENTO - INFORMA��O COMPLEMENTAR DA NF }
constructor TRegA110.Create;
begin
  inherited Create;
  { Inicializa valores padr�o }
  pREG := 'A110';
  pCOD_INF := '1';
  pTXT_COMPL := '';
end;

destructor TRegA110.Destroy;
begin
  { }
  inherited;
end;

function TRegA110.getLinha: string;
begin
  Result := '|';
  Result := Result + pREG + '|';
  Result := Result + pCOD_INF + '|';
  Result := Result + pTXT_COMPL + '|';
  blocoA.regA990.pQTD_LIN_A := blocoA.regA990.pQTD_LIN_A + 1;
end;

function TRegA110.getREG: string;
begin
  Result := pREG;
end;

function TRegA110.getCOD_INF: String;
begin
  Result := pCOD_INF;
end;

function TRegA110.getTXT_COMPL: String;
begin
  Result := pTXT_COMPL;
end;

procedure TRegA110.setREG(lREG: string);
begin
  pREG := lREG;
end;

procedure TRegA110.setCOD_INF(lCOD_INF: String);
begin
  pCOD_INF := lCOD_INF;
end;

procedure TRegA110.setTXT_COMPL(lTXT_COMPL: String);
begin
  pTXT_COMPL := lTXT_COMPL;
end;

{ TRegA170 }
{ REGISTRO A170: COMPLEMENTO DO DOCUMENTO - ITENS DO DOCUMENTO }
constructor TRegA170.Create;
begin
  inherited Create;
  { Inicializa valores padr�o }
  pREG := 'A170';
  pNUM_ITEM := 1;
  pCOD_ITEM := '';
  pDESCR_COMPL := '';
  pVL_ITEM := 0;
  pVL_DESC := -1;
  pNAT_BC_CRED := '';
  pIND_ORIG_CRED := '';
  pCST_PIS := '';
  pVL_BC_PIS := -1;
  pALIQ_PIS := -1;
  pVL_PIS := -1;
  pCST_COFINS := '';
  pVL_BC_COFINS := -1;
  pALIQ_COFINS := -1;
  pVL_COFINS := -1;
  pCOD_CTA := '';
  pCOD_CCUS := '';
end;

destructor TRegA170.Destroy;
begin
  { }
  inherited;
end;

function TRegA170.getREG: string;
begin
  Result := pREG;
end;

function TRegA170.getLinha: string;
begin
  Result := '|';
  Result := Result + pREG + '|';
  Result := Result + TUtil.FormataInteger(pNUM_ITEM, True) + '|';
  Result := Result + pCOD_ITEM + '|';
  Result := Result + pDESCR_COMPL + '|';
  Result := Result + TUtil.FormataCurrency(pVL_ITEM, True) + '|';
  Result := Result + TUtil.FormataCurrency(pVL_DESC, False) + '|';
  Result := Result + TUtil.FormataStringNumeralFixo(pNAT_BC_CRED, 2, False)
    + '|';
  Result := Result + TUtil.FormataStringNumeralFixo(pIND_ORIG_CRED, 1, False)
    + '|';
  Result := Result + TUtil.FormataStringNumeralFixo(pCST_PIS, 2, True) + '|';
  Result := Result + TUtil.FormataCurrency(pVL_BC_PIS, False) + '|';
  Result := Result + TUtil.FormataCurrency(pALIQ_PIS, False) + '|';
  Result := Result + TUtil.FormataCurrency(pVL_PIS, False) + '|';
  Result := Result + TUtil.FormataStringNumeralFixo(pCST_COFINS, 2, True) + '|';
  Result := Result + TUtil.FormataCurrency(pVL_BC_COFINS, False) + '|';
  Result := Result + TUtil.FormataCurrency(pALIQ_COFINS, False) + '|';
  Result := Result + TUtil.FormataCurrency(pVL_COFINS, False) + '|';
  Result := Result + pCOD_CTA + '|';
  Result := Result + pCOD_CCUS + '|';
  blocoA.regA990.pQTD_LIN_A := blocoA.regA990.pQTD_LIN_A + 1;
end;

function TRegA170.getNUM_ITEM: integer;
begin
  Result := pNUM_ITEM;
end;

function TRegA170.getCOD_ITEM: String;
begin
  Result := pCOD_ITEM;
end;

function TRegA170.getDESCR_COMPL: String;
begin
  Result := pDESCR_COMPL;
end;

function TRegA170.getVL_ITEM: Currency;
begin
  Result := pVL_ITEM;
end;

function TRegA170.getVL_DESC: Currency;
begin
  Result := pVL_DESC;
end;

function TRegA170.getNAT_BC_CRED: String;
begin
  Result := pNAT_BC_CRED;
end;

function TRegA170.getIND_ORIG_CRED: String;
begin
  Result := pIND_ORIG_CRED;
end;

function TRegA170.getCST_PIS: String;
begin
  Result := pCST_PIS;
end;

function TRegA170.getVL_BC_PIS: Currency;
begin
  Result := pVL_BC_PIS;
end;

function TRegA170.getALIQ_PIS: Double;
begin
  Result := pALIQ_PIS;
end;

function TRegA170.getVL_PIS: Currency;
begin
  Result := pVL_PIS;
end;

function TRegA170.getCST_COFINS: String;
begin
  Result := pCST_COFINS;
end;

function TRegA170.getVL_BC_COFINS: Currency;
begin
  Result := pVL_BC_COFINS;
end;

function TRegA170.getALIQ_COFINS: Double;
begin
  Result := pALIQ_COFINS;
end;

function TRegA170.getVL_COFINS: Currency;
begin
  Result := pVL_COFINS;
end;

function TRegA170.getCOD_CTA: String;
begin
  Result := pCOD_CTA;
end;

function TRegA170.getCOD_CCUS: String;
begin
  Result := pCOD_CCUS;
end;

procedure TRegA170.setREG(lREG: string);
begin
  pREG := lREG;
end;

procedure TRegA170.setNUM_ITEM(lNUM_ITEM: integer);
begin
  pNUM_ITEM := lNUM_ITEM;
end;

procedure TRegA170.setCOD_ITEM(lCOD_ITEM: String);
begin
  pCOD_ITEM := lCOD_ITEM;
end;

procedure TRegA170.setDESCR_COMPL(lDESCR_COMPL: String);
begin
  pDESCR_COMPL := lDESCR_COMPL;
end;

procedure TRegA170.setVL_ITEM(lVL_ITEM: Currency);
begin
  pVL_ITEM := lVL_ITEM;
end;

procedure TRegA170.setVL_DESC(lVL_DESC: Currency);
begin
  pVL_DESC := lVL_DESC;
end;

procedure TRegA170.setNAT_BC_CRED(lNAT_BC_CRED: String);
begin
  pNAT_BC_CRED := lNAT_BC_CRED;
end;

procedure TRegA170.setIND_ORIG_CRED(lIND_ORIG_CRED: String);
begin
  pIND_ORIG_CRED := lIND_ORIG_CRED;
end;

procedure TRegA170.setCST_PIS(lCST_PIS: String);
begin
  pCST_PIS := lCST_PIS;
end;

procedure TRegA170.setVL_BC_PIS(lVL_BC_PIS: Currency);
begin
  pVL_BC_PIS := lVL_BC_PIS;
end;

procedure TRegA170.setALIQ_PIS(lALIQ_PIS: Double);
begin
  pALIQ_PIS := lALIQ_PIS;
end;

procedure TRegA170.setVL_PIS(lVL_PIS: Currency);
begin
  pVL_PIS := lVL_PIS;
end;

procedure TRegA170.setCST_COFINS(lCST_COFINS: String);
begin
  pCST_COFINS := lCST_COFINS;
end;

procedure TRegA170.setVL_BC_COFINS(lVL_BC_COFINS: Currency);
begin
  pVL_BC_COFINS := lVL_BC_COFINS;
end;

procedure TRegA170.setALIQ_COFINS(lALIQ_COFINS: Double);
begin
  pALIQ_COFINS := lALIQ_COFINS;
end;

procedure TRegA170.setVL_COFINS(lVL_COFINS: Currency);
begin
  pVL_COFINS := lVL_COFINS;
end;

procedure TRegA170.setCOD_CTA(lCOD_CTA: String);
begin
  pCOD_CTA := lCOD_CTA;
end;

procedure TRegA170.setCOD_CCUS(lCOD_CCUS: String);
begin
  pCOD_CCUS := lCOD_CCUS;
end;

{ TRegA990 }
{ REGISTRO A990: ENCERRAMENTO DO BLOCO 0 }
constructor TRegA990.Create;
begin
  inherited Create;
  { Inicializa valores padr�o }
  pREG := 'A990';
  pQTD_LIN_A := 0;
end;

destructor TRegA990.Destroy;
begin
  { }
  inherited;
end;

function TRegA990.getLinha: string;
begin
  blocoA.regA990.pQTD_LIN_A := blocoA.regA990.pQTD_LIN_A + 1;
  Result := '|';
  Result := Result + pREG + '|';
  Result := Result + TUtil.FormataInteger(pQTD_LIN_A, True) + '|';
end;

function TRegA990.getREG: string;
begin
  Result := pREG;
end;

function TRegA990.getQTD_LIN_A: integer;
begin
  Result := pQTD_LIN_A;
end;

procedure TRegA990.setREG(lREG: string);
begin
  pREG := lREG;
end;

procedure TRegA990.setQTD_LIN_A(lQTD_LIN_A: integer);
begin
  pQTD_LIN_A := lQTD_LIN_A;
end;

{ BLOCO 0 - ABERTURA E IDENTIFICA��O }
constructor TBlocoA.Create;
begin
  inherited Create;
  { Inicializa valores padr�o }
  regA001 := TRegA001.Create;
  regA010 := TRegA010.Create;
  regA100 := TRegA100.Create;
  regA110 := TRegA110.Create;
  regA170 := TRegA170.Create;
  regA990 := TRegA990.Create;
end;

destructor TBlocoA.Destroy;
begin
  { Destroi registros }
  regA001.Destroy;
  regA010.Destroy;
  regA100.Destroy;
  regA110.Destroy;
  regA170.Destroy;
  regA990.Destroy;
  inherited;
end;

end.
