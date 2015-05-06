unit uBloco0;

interface
  uses Classes, SysUtils, uUtil;


{
O = O registro é sempre obrigatório.
OC = O registro é obrigatório, se houver informação a ser prestada. Ex. Registro C100 – só deverá ser
apresentado se houver movimentação ou operações utilizando os documentos de códigos 01, 1B, 04 ou 55.
O(...) = O registro é obrigatório se atendida a condição. Ex. Registro C191 – O (Se existir C190) – O registro
é obrigatório sempre que houver o registro C190.
N = O registro não deve ser informado. Ex. Registro C490 – se for informado o Registro C400.



1) Nº = Indica o número do campo em um dado registro
2) Campo = Indica o mnemônico do campo.
3) Descrição = Indica a descrição da informação requerida no campo respectivo.
§ Deve-se atentar para as observações relativas ao preenchimento de cada campo, quando
houver.
4) Tipo = Indica o tipo de caractere com que o campo será preenchido, de acordo com as regras gerais já
descritas.
§ N - Numérico;
§ C - Alfanumérico.
5) Tam Indica a quantidade de caracteres com que cada campo deve ser preenchido.
§ A indicação de um algarismo após um campo (N) representa o seu tamanho máximo;
§ A indicação "-" após um campo (N) significa que não há um número máximo de caracteres;
§ A indicação de um algarismo após um campo (C) representa o seu tamanho máximo, no caso geral;
§ A indicação "-" após um campo (C) representa que seu tamanho máximo é 255 caracteres, no caso geral;
§ A indicação "65536" após um campo (C) representa que seu tamanho máximo é 65.536 caracteres, excepcionalmente.
§ O caractere “F” (fixo) no tamanho de campo indica que o campo deverá ser preenchido exatamente com o número de caracteres informado.
Dec Indica a quantidade de caracteres que devem constar como casas decimais, quando necessárias.
§ A indicação de um algarismo representa a quantidade máxima de decimais do campo (N);
§ A indicação "-" após um campo (N) significa que não deve haver representação de casas decimais.

* indica campos obrigatórios

}


{REGISTRO 0000: ABERTURA DO ARQUIVO DIGITAL E IDENTIFICAÇÃO DA PESSOA JURÍDICA - Obrigatório (1)}

  type TReg0000 = class

  private
    pREG : String; //Valor Válido |0000| - C(4F)*

    pCOD_VER : String;  //Código da versão do leiaute conforme a tabela 3.1.1. - N(3F)*
    {Campo 02 - Preenchimento: o código da versão do leiaute informado é validado conforme a data referenciada no campo
DT_FIN. Verificar na Tabela Versão, item 3.1.1 do Anexo Único do ADE Cofis nº 34, de 28 de outubro de 2010 e alterações.
Para a versão 1.01 do Programa Validador e Assinador (PVA) da EFD-Contribuições, deve ser informado o código “002”
Validação: Válido para período informado. A versão do leiaute informada no arquivo deverá ser válida na data final da
escrituração (campo DT_FIN do registro 0000)}

    pTIPO_ESCRIT : integer;  //Tipo de Escrituração 0 - Original; 1 – Retificadora. - N(1F)*
    {Campo 03 - Valores Válidos: [0, 1]
Preenchimento: Informar o tipo de escrituração – original ou retificadora. Para a entrega da EFD-Contribuições deverá ser
utilizado o leiaute vigente à época do período de apuração e, para validação e transmissão, a versão do Programa de Validação
e Assinatura - PVA atualizada.}

    pIND_SIT_ESP : integer;  // Indicador de situação especial: 0 - Abertura; 1 - Cisão; 2 - Fusão; 3 - Incorporação; 4 – Encerramento - N(1F)
    {Campo 04 - Preenchimento: Este campo somente deve ser preenchido se a escrituração fiscal se referir à situação especial decorrente
de abertura, cisão, fusão, incorporação ou encerramento da pessoa jurídica.

OBSERVAÇÃO:
Com regra, a pessoa jurídica deve escriturar apenas uma escrituração em relação a cada período de apuração mensal. Exceção a
essa regra aplica-se apenas ao caso de cisão parcial, em que poderá haver mais de um arquivo no mesmo mês, para o mesmo
contribuinte.
Nos casos de eventos de incorporação, cada pessoa jurídica participante do evento de sucessão deve entregar a escrituração, em
relação ao período a que as obrigações e créditos são de sua responsabilidade de escrituração. Assim, a título exemplificativo,
em que a empresa A incorpora a empresa B, no dia 17.01.2012, teríamos:
- A EFD da empresa A (CNPJ da incorporadora), contemplando todo o período, de 01 a 31 de janeiro, registrando em F800
eventuais créditos vertidos na sucessão;
- A EFD da empresa B (CNPJ da incorporada), contemplando apenas o período, de 01 a 17 de janeiro.}

    pNUM_REC_ANTERIOR: string; // Número do Recibo da Escrituração anterior a ser retificada, utilizado quando TIPO_ESCRIT for igual a 1 - C(41F)
    {Campo 05 - Preenchimento: Este campo somente deve ser preenchido quando a escrituração fiscal se referir a retificação de
escrituração já transmitida, original ou retificadora. Neste caso, deve a pessoa jurídica informar neste campo o número do recibo
da escrituração anterior, a ser retificada.}

    pDT_INI: TDate; //Data inicial das informações contidas no arquivo. - D(8F)*
    {Campo 06 - Preenchimento: Informar a data inicial das informações referentes ao período da escrituração, no padrão “diamêsano”
(ddmmaaaa), excluindo-se quaisquer caracteres de separação, tais como: “.”, “/”, “-”.
Validação: Verificar se a data informada neste campo pertence ao mesmo mês/ano da data informada no campo DT_FIN.
O valor informado deve ser o primeiro dia do mesmo mês de referencia da escrituração, exceto no caso de abertura, conforme
especificado no campo 04.}

    pDT_FIN: TDate; //Data final das informações contidas no arquivo. - D(8F)*
    {Campo 07 - Preenchimento: Informar a data final das informações referentes ao período da escrituração, no padrão “diamêsano”
(ddmmaaaa), excluindo-se quaisquer caracteres de separação, tais como: “.”, “/”, “-”.
Validação: Verificar se a data informada neste campo pertence ao mesmo mês/ano da data informada no campo DT_INI.
O valor informado deve ser o último dia do mês a que se refere a escrituração, exceto nos casos de encerramento de atividades,
fusão, cisão e incorporação.}

    pNOME: string; //Nome empresarial da pessoa jurídica - C(100)*
    {Campo 08 - Preenchimento: Informar o nome empresarial da pessoa jurídica titular da escrituração.}

    pCNPJ: string; //Número de inscrição do estabelecimento matriz da pessoa jurídica no CNPJ. - N(14F)*
    {Campo 09 - Preenchimento: Informar o número de inscrição do contribuinte no cadastro do CNPJ.
Validação: será conferido o dígito verificador (DV) do CNPJ informado.}

    pUF: string; //Sigla da Unidade da Federação da pessoa jurídica. - C(2F)*
    {Campo 10 - Preenchimento: Informar a sigla da unidade da federação (UF) do estabelecimento sede, responsável pela escrituração
fiscal digital do PIS/Pasep e da Cofins.}

    pCOD_MUN: string; // Código do município do domicílio fiscal da pessoa jurídica, conforme a tabela IBGE - N(7F)*
    {Campo 11 – Preenchimento: Informar o código de município do domicílio fiscal da pessoa jurídica, conforme codificação
constante da Tabela de Municípios do IBGE.
Validação: o valor informado no campo deve existir na Tabela de Municípios do IBGE, possuindo 7 dígitos.}

    pSUFRAMA: string; // Inscrição da pessoa jurídica na Suframa - C(9F)
    {Campo 12 – Preenchimento: Informar neste campo a inscrição da pessoa jurídica titular da escrituração na SUFRAMA. Caso
a pessoa jurídica não tenha inscrição na SUFRAMA este campo deve ser informado em branco.
Validação: será conferido o dígito verificador (DV) do número de inscrição na SUFRAMA, se informado.}

    pIND_NAT_PJ: string; // Indicador da natureza da pessoa jurídica: 00 – Pessoa jurídica em geral; 01 – Sociedade cooperativa;
                        // 02 – Entidade sujeita ao PIS/Pasep exclusivamente com base na Folha de Salários; N(2F)
{ Indicador da natureza da pessoa jurídica, a partir do ano-calendário de 2014:
00 – Pessoa jurídica em geral (não participante de SCP como sócia ostensiva)
01 – Sociedade cooperativa (não participante de SCP como sócia ostensiva)
02 – Entidade sujeita ao PIS/Pasep exclusivamente com base na Folha de Salários
03 - Pessoa jurídica em geral participante de SCP como sócia ostensiva
04 – Sociedade cooperativa participante de SCP como sócia ostensiva
05 – Sociedade em Conta de Participação - SCP}

{Campo 13 - Valores Válidos: [00, 01, 02, 03, 04, 05]
Preenchimento: informar a natureza da pessoa jurídica, conforme um dos três tipos abaixo:
00 – Sociedade empresária em geral
01 – Sociedade cooperativa
02 – Entidade sujeita ao PIS/Pasep exclusivamente com base na Folha de Salários}


    pIND_ATIV:integer; // Indicador de tipo de atividade preponderante: 0 – Industrial ou equiparado a industrial; 1 – Prestador de serviços;
                     // 2 - Atividade de comércio; 3 – Pessoas jurídicas referidas nos §§ 6º, 8º e 9º do art. 3º da Lei nº 9.718, de 1998;
                     // 4 – Atividade imobiliária; 9 – Outros. - N(1)* - Obrigatório
{Campo 14 - Valores Válidos: [0, 1, 2, 3, 4, 9]
Preenchimento: informar o indicador da atividade preponderante exercida pela pessoa jurídica no período da escrituração,
conforme um dos tipos abaixo:
0 – Industrial ou equiparado a industrial;
1 – Prestador de serviços;
2 - Atividade de comércio;
3 – Pessoas jurídicas referidas nos §§ 6º, 8º e 9º do art. 3º da Lei nº 9.718, de 1998;
4 – Atividade imobiliária;
9 – Outros

Caso a pessoa jurídica tenha exercido mais de uma das atividades acima relacionadas, no período da escrituração, deve o campo
ser preenchido com o código correspondente à atividade preponderante.
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




{REGISTRO 0001: ABERTURA DO BLOCO 0 - Obrigatório (1)

Observações: Registro obrigatório. Deve ser gerado para abertura do Bloco 0 e indica se há informações previstas para este
bloco.
Nível hierárquico - 1
Ocorrência - um (por arquivo)
}

  type TReg0001 = class

  private

    pREG: String; // Texto fixo contendo |0001| - C(4F)*
    {Campo 01 - Valor Válido: [0001]}

    pIND_MOV: integer; // Indicador de movimento: 0 - Bloco com dados informados; 1 – Bloco sem dados informados.  - N(1)*
    {Campo 02 - Valor Válido: [0,1]
Considerando que na escrituração do Bloco “0” deve ser escriturado, no mínimo, os registros “0110 - Regimes de Apuração da
Contribuição Social e de Apropriação de Crédito” e “0140 – Tabela de Cadastro de Estabelecimento”, deve sempre ser
informado, no Campo 02, o indicador “0 – Bloco com dados informados”.}


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

  {Observações:
1. Registro obrigatório, utilizado para identificação do contabilista responsável pela escrituração fiscal da empresa, mesmo que
o contabilista seja funcionário da empresa ou prestador de serviço.
2. Apesar das contribuições sociais serem apuradas de forma centralizada pelo estabelecimento matriz, as informações dos
Blocos A, C, D e F são escrituradas por estabelecimento. Neste sentido, caso a pessoa jurídica tenha mais de um contabilista
responsável pela escrituração fiscal de suas operações, estes devem ser relacionados no registro 0100.
Nível hierárquico – 2
Ocorrência - Vários (por arquivo)}

  type TReg0100 = class

  private

    pREG: String; // Texto fixo contendo |0100| - C(4F)*
    {Campo 01 - Valor Válido: [0100]}

    pNOME: string; // Nome do contabilista. C(100)*
    {Campo 02 - Preenchimento: informar o nome do contabilista responsável.}

    pCPF: string; // Número de inscrição do contabilista no CPF. N(11F)*
    {Campo 03 - Preenchimento: informar o número do CPF do contabilista responsável pela escrituração, cujo numero de inscrição
no CRC foi informado no campo 04; não utilizar os caracteres especiais de formatação, tais como: ".", "/", "-".
Validação: será conferido o dígito verificador (DV) do CPF informado.}

    pCRC: string; // Número de inscrição do contabilista no Conselho Regional de Contabilidade.  C(15)*
    {Campo 04 - Preenchimento: informar o número de inscrição do contabilista no Conselho Regional de Contabilidade na
UF do estabelecimento sede.}

    pCNPJ: string; // Número de inscrição do escritório de contabilidade no CNPJ, se houver. N(14F)
    {Campo 05 - Preenchimento: informar o número de inscrição no Cadastro Nacional de Pessoa Jurídica do escritório de
contabilidade; não informar caracteres de formatação, tais como: ".", "/", "-".
Validação: será conferido o dígito verificador (DV) do CNPJ informado.}

    pCEP: string; // Código de Endereçamento Postal. N(8F)
    {Campo 06 - Preenchimento: informar o número do Código de Endereçamento Postal - CEP, conforme cadastro nos
CORREIOS.}

    pENDERECO: string; //  Logradouro e endereço do imóvel. C(60)
    {Campo 07 - Preenchimento: informar o endereço do contabilista/escritório de contabilidade.}

    pNUM: string; //  Número do imóvel. C(-)
    pCOMPL: string; // Dados complementares do endereço. C(60)
    pBAIRRO: string; // Bairro em que o imóvel está situado. C(60)
    pFONE: string; // Número do telefone. C(11)
    pFAX: string; //  Número do fax. C(11)

    pEMAIL: string; // Endereço do correio eletrônico. C(-)
    {Campo 13 - Preenchimento: informar o endereço de correio eletrônico do contabilista/escritório de contabilidade}

    pCOD_MUN: string; // Código do município, conforme tabela IBGE. N(7F)
    {Campo 14 - Preenchimento: informar o código do município do domicílio fiscal do contabilista/escritório de
contabilidade.
Validação: o valor informado no campo deve existir na Tabela de Municípios do IBGE (combinação do código da UF e o código
de município), possuindo 7 dígitos.}

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




  {REGISTRO 0110: REGISTRO 0110: REGIMES DE APURAÇÃO DA CONTRIBUIÇÃO SOCIAL E DE APROPRIAÇÃO DE CRÉDITO}
  {Este registro tem por objetivo definir o regime de incidência a que se submete a pessoa jurídica (não-cumulativo, cumulativo
ou ambos os regimes) no período da escrituração. No caso de sujeição ao regime não-cumulativo, será informado também o
método de apropriação do crédito incidente sobre operações comuns a mais de um tipo de receita adotado pela pessoa jurídica
para o ano-calendário.}

{1. Registro obrigatório. Informar somente os regimes de apuração a que se submeteu a pessoa jurídica no período da
escrituração.
2. O campo 05 (IND_REC_CUM) não deverá constar no arquivo da escrituração a ser importado pelo PVA,
versão 2.00, versão essa que acresce em relação à versão anterior (1.07), os registros da escrituração da Contribuição
Previdenciária sobre a Receita Bruta (Bloco P). O referido campo 05 só deverá constar no arquivo da escrituração a
ser importado pelo PVA na versão 2.01A, com previsão de disponibilização em julho de 2012, que irá então constar
com os registros da escrituração do PIS/Pasep e da Cofins, para a pessoa jurídica tributada com base no lucro
presumido.
Desta forma, no arquivo gerado para ser importado nas versões 1.07 e 2.00 do PVA, o registro “0110” deverá ser
informado com apenas 04 (quatro) campos.
Nível hierárquico - 2
Ocorrência – um (por arquivo)

OBS: Os registros e campos referentes à escrituração do PIS/Pasep e da Cofins das pessoas jurídicas sujeitas ao regime
de tributação com base no lucro presumido, aplicável para os fatos geradores a ocorrer a partir de 01 de julho de
2012, serão disponibilizados pelo Programa Validador e Assinador (PVA) da EFD-Contribuições, versão 2.01A, com
previsão de disponibilização pela Receita Federal em junho/2012.

Caso a escrituração seja efetuada mediante a importação de arquivo “txt”, na versão 2.01A do PVA, com previsão de
disponibilização em junlo/2012, o registro “0110” deverá ser gerado com 05 (cinco) campos. Na edição de dados}

  type TReg0110 = class

  private

    pREG: String; // Texto fixo contendo |0110| - C(4F)*
    {Campo 01 - Valor Válido: [0110]}

    pCOD_INC_TRIB: integer; // Código indicador da incidência tributária no período: - N(1F)*
                            {1 – Escrituração de operações com incidência exclusivamente no regime não-cumulativo;
                             2 – Escrituração de operações com incidência exclusivamente no regime cumulativo;
                             3 – Escrituração de operações com incidência nos regimes não-cumulativo e cumulativo. }
    {Campo 02 - Valores válidos: [1;2;3]
Preenchimento: indicar o código correspondente ao(s) regime(s) de apuração das contribuições sociais a que se submete a
pessoa jurídica no período da escrituração:
- No caso da pessoa sujeitar-se apenas à incidência não cumulativa, deve informar o indicador “1”;
- No caso da pessoa sujeitar-se apenas à incidência cumulativa, deve informar o indicador “2”;
- No caso da pessoa sujeitar-se aos dois regimes (não cumulativo e cumulativo), deve informar o indicador “3”.}

    pIND_APRO_CRED: integer; // Código indicador de método de apropriação de créditos comuns, no caso de incidência no regime não cumulativo - N(1F)
                            {(COD_INC_TRIB = 1 ou 3):
                             1 – Método de Apropriação Direta;
                             2 – Método de Rateio Proporcional (Receita Bruta)}
    {Campo 03 - Valores válidos: [1;2]
Preenchimento: Este campo deve ser informado no caso da pessoa jurídica apurar créditos referentes a operações (de
aquisições de bens e serviços, custos, despesas, etc) vinculados a mais de um tipo de receita (não-cumulativa e cumulativa).
Este campo deve também ser preenchido no caso em que mesmo se sujeitando a pessoa jurídica exclusivamente ao regime nãocumulativo,
as operações geradoras de crédito sejam vinculadas a receitas de naturezas diversas, decorrentes de:
- Operações tributadas no Mercado Interno;
- Operações não-tributadas no Mercado Interno (Alíquota zero, suspensão, isenção e não-incidência);
- Operações de Exportação.

No caso da pessoa jurídica adotar o método da Apropriação Direta, para fins de determinação do crédito, referente a
aquisições, custos e despesas vinculados a mais de um tipo de receita, informar neste campo o indicador “1”;

No caso da pessoa jurídica adotar o método do Rateio Proporcional com base na Receita Bruta, para fins de determinação do
crédito, referente a aquisições, custos e despesas vinculados a mais de um tipo de receita, informar neste campo o indicador
“2”. Neste caso, a escrituração do Registro “0111” é obrigatória.}


    pCOD_TIPO_CONT: integer; // Código indicador do Tipo de Contribuição Apurada no Período - N(1F)
                            {1 – Apuração da Contribuição Exclusivamente a Alíquota Básica
                             2 – Apuração da Contribuição a Alíquotas Específicas (Diferenciadas e/ou por Unidade de Medida de Produto)}
{Campo 04 - Valores válidos: [1;2]
Preenchimento: indicar o código correspondente ao tipo de contribuição apurada no período, a saber:
- Indicador “1”: No caso de apuração das contribuições exclusivamente às alíquotas básicas de 0,65% ou 1,65% (PIS/Pasep) e
de 3% ou 7,6% (Cofins);
- Indicador “2”: No caso de apuração das contribuições às alíquotas específicas, decorrentes de operações tributadas
no regime monofásico (combustíveis; produtos farmacêuticos, de perfumaria e de toucador; veículos, autopeças e
pneus; bebidas frias e embalagens para bebidas; etc) e/ou em regimes especiais (pessoa jurídica industrial estabelecida
na Zona Franca de Manaus ou nas Áreas de Livre Comércio, por exemplo).

A pessoa jurídica sujeita à apuração das contribuições sociais a alíquotas específicas deve informar o indicador “2”
mesmo que, em relação a outras receitas, se submeta à alíquota básica.}


    pIND_REG_CUM: integer; // Código indicador do critério de escrituração e apuração adotado, no caso de incidência exclusivamente no - N(1F)
                           // regime cumulativo (COD_INC_TRIB = 2), pela pessoa jurídica submetida ao regime de tributação com base no lucro presumido:
                            {1 – Regime de Caixa – Escrituração consolidada (Registro F500);
                             2 – Regime de Competência - Escrituração consolidada (Registro F550);
                             9 – Regime de Competência - Escrituração detalhada, com base nos registros dos Blocos “A”, “C”, “D” e “F”. }
 {Campo 05 - Valores válidos: [1;2;9]
Preenchimento: indicar o código correspondente ao critério de escrituração das receitas, para fins de apuração da
Contribuição para o PIS/Pasep e da Cofins, no caso de pessoa jurídica submetida ao regime de tributação com base no lucro
presumido:
- No caso de apuração das contribuições pelo regime de caixa, mediante a escrituração consolidada das receitas
recebidas no registro “F500”, deve informar o indicador “1”;
- No caso de apuração das contribuições pelo regime de competência, mediante a escrituração consolidada das receitas
auferidas no registro “F550”, deve informar o indicador “2”; ou
- No caso de apuração das contribuições pelo regime de competência, mediante a escrituração detalhada das receitas
auferidas nos registros dos Blocos “A”, “C”, “D” e “F”.}

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

  {Este registro tem por objetivo relacionar e informar os estabelecimentos da pessoa jurídica, no Brasil ou no exterior, que
auferiram receitas no período da escrituração, realizaram operações com direito a créditos ou que sofreram retenções na fonte,
no período da escrituração.

1. Em relação aos estabelecimentos e bases operacionais no exterior, que estejam cadastradas no CNPJ: Preencher o registro
"0140" informando o CNPJ (campo 04) do estabelecimento localizado no exterior e, em relação ao campo "UF" (Campo
05) e ao campo "COD_MUN" (Campo 07), informar a UF e código de município do estabelecimento sede, responsável pela
escrituração, identificado no registro "0000";

2. Em relação aos estabelecimentos e bases operacionais no exterior, que não estejam cadastradas no CNPJ: Não preencher
o registro "0140", por inexistência de CNPJ (campo 04), devendo as operações objeto da escrituração deste estabelecimento
localizado no exterior, serem informadas nos Blocos "A", "C", "D" e/ou" F", no conjunto de registros do estabelecimento
sede, informado no registro "0000", campo "09".
Neste caso, e no sentido de diferenciar as informações próprias do estabelecimento sede, das informações próprias dos estabelecimentos
localizados no exterior, sem inscrição no CNPJ, preferencialmente deve a empresa adotar plano de contas contábeis
que diferenciem e identifiquem as operações de cada estabelecimento, as quais devem ser informadas nos respectivos registros
de operações nos Blocos "A", "C", "D" e "F".}

  type TReg0140 = class

  private

    pREG: String; // Texto fixo contendo |0140| - C(4F)*
    {Campo 01 - Valor Válido: [0140]}

    pCOD_EST: String; // Código de identificação do estabelecimento - C(60)
    {Campo 02 – Preenchimento: informe o identificador do estabelecimento sendo informados. Esta informação é de livre
atribuição da empresa.}

    pNOME: String; // Nome empresarial do estabelecimento - C(100)*
    {Campo 03 – Preenchimento: informe o nome empresarial do estabelecimento, caso este seja distinto do nome empresarial da
pessoa jurídica.}

    pCNPJ: String; // Número de inscrição do estabelecimento no CNPJ. - N(14F)*
    {Campo 04 - Preenchimento: Informar o número de inscrição do estabelecimento no cadastro do CNPJ.
Validação: será conferido o dígito verificador (DV) do CNPJ informado.}

    pUF: String; // Sigla da unidade da federação do estabelecimento. C(2F)*
    {Campo 05 - Preenchimento: Informar a sigla da unidade da federação (UF) do estabelecimento.}

    pIE: String; // Inscrição Estadual do estabelecimento, se contribuinte de ICMS. - C(14)
    {Campo 06 – Preenchimento: Informar neste campo a inscrição estadual do estabelecimento, caso existente.
Validação: valida a Inscrição Estadual de acordo com a UF informada no campo COD_MUN (dois primeiros dígitos do código
de município).
No caso do estabelecimento cadastrado possuir mais de uma inscrição estadual, este campo não deve ser preenchido.}

    pCOD_MUN: String; // Código do município do domicílio fiscal do estabelecimento, conforme a tabela IBGE - N(7F)*
    {Campo 07 – Preenchimento: Informar o código de município do domicílio fiscal da pessoa jurídica, conforme codificação
constante da Tabela de Municípios do IBGE.
Validação: o valor informado no campo deve existir na Tabela de Municípios do IBGE, possuindo 7 dígitos.}

    pIM: String; // Inscrição Municipal do estabelecimento, se contribuinte do ISS. - C(-)
    {Campo 08 – Preenchimento: Informar neste campo a inscrição municipal do estabelecimento, caso existente.}

    pSUFRAMA: String; // Inscrição do estabelecimento na Suframa - C(9F)
    {Campo 09 – Preenchimento: Informar neste campo a inscrição da pessoa jurídica titular da escrituração na SUFRAMA. Caso
a pessoa jurídica não tenha inscrição na SUFRAMA este campo deve ser informado em branco.
Validação: será conferido o dígito verificador (DV) do número de inscrição na SUFRAMA, se informado.04 CNPJ}


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
  {Este registro tem por objetivo relacionar e cadastrar os participantes (fornecedores e clientes pessoa jurídica ou pessoa física)
que tenham realizado operações com a empresa, objeto de registro nos Blocos A, C, D, F ou 1.

Em relação às operações documentadas com base em Nota Fiscal Eletrônica (Código 55), no caso da pessoa jurídica proceder à
escrituração consolidada de suas vendas (Registro C180) e/ou de suas aquisições (Registro C190), não é obrigatório cadastrar e
relacionar no Registro 0150 o participante cujas operações estejam exclusivamente escrituradas nos registros C180 e C190.

Em relação às operações documentadas com base em Nota Fiscal Eletrônica (Código 55), no caso da pessoa jurídica proceder à
escrituração de forma individualizada por documento fiscal (Registros C100/C170) de suas vendas e/ou de suas aquisições, é
obrigatório cadastrar e relacionar no Registro 0150 cada participante cujas operações estejam escrituradas nos registros C100 e
C170.

Observações:
1. Registro utilizado para informações cadastrais das pessoas físicas ou jurídicas envolvidas nas transações comerciais e de
prestação/contratação de serviços relacionadas na escrituração fiscal digital, no período.
2. Todos os participantes informados nos registros dos Blocos A, C, D ou F devem ser relacionados neste Registro 0150, bem
como os participantes relacionados em operações extemporâneas de contribuições e/ou créditos (na impossibilidade de retificação
da EFD-Contribuições), no Bloco 1.
A obrigatoriedade de escrituração de participante no Registro 0150 não se aplica, nas situações em que os registros dos Blocos
A, C, D ou F identifiquem o participante pelo CNPJ (no caso de participante pessoa jurídica) ou CPF (no caso de participante
pessoa física)..
3. No caso de registros representativos de operações de vendas a consumidor final (mediante emissão de Nota Fiscal de Vendas
a Consumidor Final, ou documento equivalente, inclusive os emitidos por ECF), não precisam ser informados os campos
CNPJ e CPF;
4. O Campo CPF não precisa ser informado, nas operações representativas de vendas de bens e serviços a pessoas físicas estrangeiras.
5. No caso da pessoa jurídica ter realizado operações relativas às atividades de consórcio, constituído nos termos do disposto
nos arts. 278 e 279 da Lei nº 6.404, de 1976, passíveis de escrituração na EFD-Contribuições, deverá a pessoa jurídica consorciada
cadastrar cada consórcio em 01 (um) registro 0150 específico.
Nível hierárquico - 3
Ocorrência – 1:N }

  type TReg0150 = class

  private

    pREG: String; // Texto fixo contendo |0150| - C(4F)*
    {Campo 01 - Valor Válido: [0150]}

    pCOD_PART: String; //Código de identificação do participante no arquivo. - C(60)*
    {Campo 02 - Preenchimento: informar o código de identificação do participante no arquivo.
Esta tabela pode conter COD_PART e respectivo registro 0150 com dados do próprio contribuinte informante, quando apresentar
documentos emitidos contra si próprio, em situações específicas.
Validação: O código de participante, campo COD_PART, é de livre atribuição do estabelecimento, observado o disposto no
item 2.4.2.1. do Manual de Orientação do Leiaute da EFD-Contribuições (ADE Cofis nº 34/2010).}

    pNOME: String; // Nome pessoal ou empresarial do participante. - C(100)*

    pCOD_PAIS: String; // Código do país do participante, conforme a tabela indicada no item 3.2.1. (www.bcb.gov.br) 01058	BRASIL - N(5)*
    {Campo 04 - Preenchimento: informar o código do país, conforme tabela indicada no item 3.2.1 do Manual de Orientação do
Leiaute da EFD-Contribuições (ADE Cofis nº 34/2010).
O código de país pode ser informado com 05 caracteres ou com 04 caracteres (desprezando o caractere “0” (zero) existente à
esquerda).
Validação: o valor informado no campo deve existir na Tabela de Países. Informar, inclusive, quando o participante for
estabelecido ou residente no Brasil (01058 ou 1058).}

    pCNPJ: String; // CNPJ do participante. - N(14F)
    {Campo 05 - Preenchimento: informar o número do CNPJ do participante; não informar caracteres de formatação, tais
como: ".", "/", "-". Se COD_PAIS diferente de Brasil, o campo não deve ser preenchido.
Validação: é conferido o dígito verificador (DV) do CNPJ informado.
Obrigatoriamente um dos campos, CPF ou CNPJ, deverá ser preenchido.}

    pCPF: String; // CPF do participante. - N(11F)
    {Campo 06 - Preenchimento: informar o número do CPF do participante; não utilizar os caracteres especiais de
formatação, tais como: “.”, “/”, “-”. Se COD_PAIS diferente de Brasil, o campo não deve ser preenchido.
Validação: é conferido o dígito verificador (DV) do CPF informado.
Obrigatoriamente um dos campos, CPF ou CNPJ, deverá ser preenchido.
Obs.: Os campos 05 e 06 são mutuamente excludentes, sendo obrigatório o preenchimento de um deles quando o campo 04 estiver
preenchido com “01058” ou “1058” (Brasil).}

    pIE: String; // Inscrição Estadual do participante. - C(14)
    {Campo 07 - Validação: valida a Inscrição Estadual de acordo com a UF informada no campo COD_MUN (dois primeiros dígitos
do código de município).}

    pCOD_MUN: String; // Código do município, conforme a tabela IBGE - N(7F)
    {Campo 08 - Validação: o valor informado no campo deve existir na Tabela de Municípios do IBGE (combinação do código
da UF e do código de município), possuindo 7 dígitos.
Obrigatório se campo COD_PAIS for igual a “01058” ou “1058”(Brasil). Se for exterior, informar campo “vazio” ou
preencher com o código “9999999”.}

    pSUFRAMA: String; // Número de inscrição do participante na Suframa - C(9F)
    {Campo 09 - Preenchimento: informar o número de Inscrição do participante na SUFRAMA, se houver.
Validação: é conferido o dígito verificador (DV) do número de inscrição na SUFRAMA, se informado.}

    pENDERECO: String; // Logradouro e endereço do imóvel - C(60)
    {Campo 10 - Preenchimento: informar o logradouro e endereço do imóvel. Se o participante for do exterior, preencher inclusive
com a cidade e país}

    pNUM: String; // Número do imóvel C(-)
    pCOMPL: String; // Dados complementares do endereço - C(60)
    pBAIRRO: String; // Bairro em que o imóvel está situado - C(60)

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


  {REGISTRO 0190: IDENTIFICAÇÃO DAS UNIDADES DE MEDIDA}

  type TReg0190 = class

  private

    pREG: String; // Texto fixo contendo |0190| - C(4F)*
    {Campo 01 - Valor Válido: [0190]}

    pUNID: String; //  Código da unidade de medida C(6)*
    {Campo 02: Informar o código correspondente à unidade de medida utilizada no arquivo digital.}

    pDESCR: String; // Descrição da unidade de medida C(-)*
    {Campo 03 - Validação: não poderão ser informados os campos UNID e DESCR com o mesmo conteúdo.}

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


  {REGISTRO 0200: TABELA DE IDENTIFICAÇÃO DO ITEM (PRODUTOS E SERVIÇOS)}
  {Este registro tem por objetivo informar as mercadorias, serviços, produtos ou quaisquer outros itens concernentes às transações
representativas de receitas e/ou geradoras de créditos, objeto de escrituração nos Blocos A, C, D, F ou 1.}

  type TReg0200 = class

  private

    pREG: String; // Texto fixo contendo |0200| - C(4)*
    {Campo 01 - Valor Válido: [0200]}

    pCOD_ITEM: String; //Código do item - C(60)*
    {Campo 02 - Preenchimento: informar com códigos próprios do informante do arquivo os itens das operações de entradas de
mercadorias ou aquisições de serviços, bem como das operações de saídas de mercadorias ou prestações de serviços. O Código
do Item deverá ser preenchido com as informações utilizadas na última ocorrência do período.}

    pDESCR_ITEM: String; // Descrição do item - C(-)*
    {Campo 03 - Preenchimento: são vedadas descrições diferentes para o mesmo item ou descrições genéricas, ressalvadas as
operações abaixo, desde que não destinada à posterior circulação ou apropriação na produção:
1- de aquisição de "materiais para uso/consumo" que não gerem direitos a créditos;
2- que discriminem por gênero a aquisição ou venda de bens incorporados ao ativo imobilizado da empresa;
3- que contenham os registros consolidados relativos aos contribuintes com atividades econômicas de
fornecimento de energia elétrica, de fornecimento de água canalizada, de fornecimento de gás canalizado e de prestação de serviço
de comunicação e telecomunicação que poderão, a critério do Fisco, utilizar registros consolidados por classe de consumo
para representar suas saídas ou prestações.}

    pCOD_BARRA: String; // Representação alfanumérico do código de barra do produto, se houver. - C(-)


    pCOD_ANT_ITEM: String; // Código anterior do item com relação à última informação apresentada. - C(60)
    pUNID_INV: String; // Unidade de medida utilizada na quantificação de estoques. - C(6)
    {Campo 06 - Validação: existindo informação neste campo, esta deve existir no registro 0190, campo UNID, respectivo.}

    pTIPO_ITEM: String; // Tipo do item – Atividades Industriais, Comerciais e Serviços: - N(2F)*
                          {00 – Mercadoria para Revenda;
                          01 – Matéria-Prima;
                          02 – Embalagem;
                          03 – Produto em Processo;
                          04 – Produto Acabado;
                          05 – Subproduto;
                          06 – Produto Intermediário;
                          07 – Material de Uso e Consumo;
                          08 – Ativo Imobilizado;
                          09 – Serviços;
                          10 – Outros insumos;
                          99 – Outras}
    {Campo 07 - Preenchimento: informar o tipo do item aplicável. Nas situações de um mesmo código de item possuir mais
de um tipo de item (destinação), deve ser informado o tipo de maior relevância.
Deve ser informada a destinação inicial do produto, considerando-se os conceitos:
00 - Mercadoria para revenda – produto adquirido comercialização;
01 – Matéria-prima: a mercadoria que componha, física e/ou quimicamente, um produto em processo ou produto acabado e
que não seja oriunda do processo produtivo. A mercadoria recebida para industrialização é classificada como Tipo 01, pois não
decorre do processo produtivo, mesmo que no processo de produção se produza mercadoria similar classificada como Tipo 03;
03 – Produto em processo: o produto que possua as seguintes características, cumulativamente: oriundo do processo produtivo;
e, preponderantemente, consumido no processo produtivo. Dentre os produtos em processo está incluído o produto resultante
caracterizado como retorno de produção (vide conceito de retorno de produção abaixo);
04 – Produto acabado: o produto que possua as seguintes características, cumulativamente: oriundo do processo produtivo;
produto final resultante do objeto da atividade econômica do contribuinte; e pronto para ser comercializado;
05 - Subproduto: o produto que possua as seguintes características, cumulativamente: oriundo do processo produtivo e não é
objeto da produção principal do estabelecimento; tem aproveitamento econômico; não se enquadre no conceito de produto em
processo (Tipo 03) ou de produto acabado (Tipo 04);
06 – Produto intermediário: aquele que, embora não se integrando ao novo produto, for consumido no processo de industrialização.
Valores válidos: [00, 01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 99]}

    pCOD_NCM: String; // Código da Nomenclatura Comum do Mercosul - C(8)
    {Campo 08 – Preenchimento: É obrigatório informar o Código NCM conforme a Nomenclatura Comum do MERCOSUL, de
acordo com o Decreto nº 6.006/06 para:
- as empresas industriais e equiparadas a industrial, referente aos itens correspondentes às suas atividades fins;
- as pessoas jurídicas, inclusive cooperativas, que produzam mercadorias de origem animal ou vegetal (agroindústria),
referente aos itens correspondentes às atividades geradoras de crédito presumido;
- as empresas que realizarem operações de exportação ou importação;
- as empresas atacadistas ou industriais, referentes aos itens representativos de vendas no mercado interno com alíquota
zero, suspensão, isenção ou não incidência, nas situações em que a legislação tributária atribua o benefício a um código
NCM específico.
Nas demais situações o Campo 08 (NCM) não é de preenchimento obrigatório.}

    pEX_IPI: String; // Código EX, conforme a TIPI - C(3)
    {Campo 09 - Preenchimento: informar com o Código de Exceção de NCM, de acordo com a Tabela de Incidência do
Imposto sobre Produtos Industrializados (TIPI), quando existir.}

    pCOD_GEN: String; // Código do gênero do item, conforme a Tabela 4.2.1. - N(2F)
    {Campo 10 - Preenchimento: obrigatório para todos os contribuintes na aquisição de produtos primários. A Tabela
"Gênero do Item de Mercadoria/Serviço", referenciada no Item 4.2.1 do Manual de Orientação do Leiaute da EFD-Contribuições
(ADE Cofis nº 34/2010), corresponde à tabela de "Capítulos da NCM", acrescida do código "00 - Serviço".
Validação: o valor informado no campo deve existir na Tabela “Gênero do Item de Mercadoria/Serviço”, item 4.2.1 do
Manual de Orientação do Leiaute da EFD-Contribuições (ADE Cofis nº 34/2010).}

    pCOD_LST: String; // Código do serviço conforme lista do Anexo I da Lei Complementar Federal nº 116/03. - N(4)
    {Campo 11 - Preenchimento: informar o código de serviços, de acordo com a Lei Complementar 116/03. }

    pALIQ_ICMS: Currency; // Alíquota de ICMS aplicável ao item nas operações internas - N(6,2)
    {Campo 12 - Preenchimento: neste campo deve ser informada a alíquota do ICMS, em operações de saída interna}

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


  {REGISTRO 0400: TABELA DE NATUREZA DA OPERAÇÃO/PRESTAÇÃO}
  {Este registro tem por objetivo codificar os textos das diferentes naturezas da operação/prestação discriminadas nos documentos
fiscais. Esta codificação e suas descrições são livremente criadas e mantidas pelo contribuinte.
Este registro não se refere a CFOP. Algumas empresas utilizam outra classificação além das apresentados nos CFOP. Esta codificação
permite informar estes agrupamentos próprios.
Não podem ser informados dois ou mais registros com o mesmo código no campo COD_NAT}


  type TReg0400 = class

  private

    pREG: String; // Texto fixo contendo |0400| - C(4)*
    {Campo 01 - Valor Válido: [0400]}

    pCOD_NAT: String; //  Código da natureza da operação/prestação C(10)*
    {Campo 02 – Preenchimento: informar o código da natureza da operação/prestação}

    pDESCR_NAT: String; // Descrição da natureza da operação/prestação C(-)*
    {Campo 03 – Preenchimento: informar a descrição da natureza da operação/prestação}

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


  {REGISTRO 0450: TABELA DE INFORMAÇÃO COMPLEMENTAR DO DOCUMENTO FISCAL}
  {Este registro tem por objetivo codificar todas as informações complementares dos documentos fiscais, exigidas pela legislação
fiscal. Estas informações constam no campo “Dados Adicionais” dos documentos fiscais.
Esta codificação e suas descrições são livremente criadas e mantidas pelo contribuinte e não podem ser informados dois ou
mais registros com o mesmo conteúdo no campo COD_INF.

Deverão constar todas as informações complementares de interesse da Administração Tributária, existentes nos documentos
fiscais.

Exemplo: nos casos de documentos fiscais de entradas, informar as referências a um outro documento fiscal.

Observações:
Nível hierárquico - 3
Ocorrência – 1:N}


  type TReg0450 = class

  private

    pREG: String; // Texto fixo contendo |0450| - C(4)*
    {Campo 01 - Valor Válido: [0450]}

    pCOD_INF: String; //  Código da informação complementar do documento fiscal. - C(6)*
    {Campo 02 – Preenchimento: informar o código da informação complementar, conforme for utilizado nos documentos fiscais
constantes nos demais blocos}

    pTXT: String; // C(-)*
    {Texto livre da informação complementar existente no documento fiscal, inclusive espécie de normas legais, poder normativo, número,
capitulação, data e demais referências pertinentes com indicação referentes ao tributo.

Campo 03 – Preenchimento: preencher com o texto constante no documento fiscal, como por exemplo: o número e data do
ADE que permite a realização de venda com suspensão para empresa preponderantemente exportadora e a respectiva indicação
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
  {Observações: Registro obrigatório.
Nível hierárquico - 1
Ocorrência – um por arquivo}
  type TReg0990 = class

  private

    pREG: String; // Texto fixo contendo |0990| - C(4)*
    {Campo 01 - Valor Válido: [0990]}

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


  {BLOCO 0 - ABERTURA E IDENTIFICAÇÂO}
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
{REGISTRO 0000: ABERTURA DO ARQUIVO DIGITAL E IDENTIFICAÇÃO DA PESSOA JURÍDICA - Obrigatório (1)}

constructor TReg0000.Create;
var FmtStngs: TFormatSettings;
begin
  inherited create;

  {Inicializa valores padrão}
  pREG := '0000';
  pCOD_VER := '003'; //ADE Cofis nº 20/2012
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
{REGISTRO 0001: ABERTURA DO BLOCO 0 - Obrigatório (1)}

constructor TReg0001.Create;
begin
  inherited create;
  {Inicializa valores padrão}
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
  {Inicializa valores padrão}
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
{REGISTRO 0110: REGISTRO 0110: REGIMES DE APURAÇÃO DA CONTRIBUIÇÃO SOCIAL E DE APROPRIAÇÃO DE CRÉDITO}

constructor TReg0110.Create;
begin
  inherited create;
  {Inicializa valores padrão}
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
  {Inicializa valores padrão}
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
  {Inicializa valores padrão}
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
{REGISTRO 0190: IDENTIFICAÇÃO DAS UNIDADES DE MEDIDA}
constructor TReg0190.Create;
begin
  inherited create;
  {Inicializa valores padrão}
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
{REGISTRO 0200: TABELA DE IDENTIFICAÇÃO DO ITEM (PRODUTOS E SERVIÇOS)}
constructor TReg0200.Create;
begin
  inherited create;
  {Inicializa valores padrão}
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
{REGISTRO 0400: TABELA DE NATUREZA DA OPERAÇÃO/PRESTAÇÃO}
constructor TReg0400.Create;
begin
  inherited create;
  {Inicializa valores padrão}
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
{REGISTRO 0450: TABELA DE INFORMAÇÃO COMPLEMENTAR DO DOCUMENTO FISCAL}
constructor TReg0450.Create;
begin
  inherited create;
  {Inicializa valores padrão}
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
  {Inicializa valores padrão}
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





{BLOCO 0 - ABERTURA E IDENTIFICAÇÂO}
constructor TBloco0.Create;
begin
  inherited create;
  {Inicializa valores padrão}
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
