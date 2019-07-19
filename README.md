# ckac
Shell script para gerar um relatório simples com informações sobre ganho/perda de ativos da bolsa.

**Formato do arquivo de configuração**

	URL_<ATIVO>="código do ativo da URI" 
	<ATIVO>=(
		<NÚMERO AÇÕES>:<PREÇO COMPRA>
		<NÚMERO AÇÕES>:<PREÇO COMPRA>
	)

Para obter o código do ativo:

01 - Acesse o link da URI_PRINCIPAL

02 - Escolha um papel

03 - Recorte o trecho na url que corresponda após a string 'stockdetails' e anterior ao '?'

04 - Adicione os dados no arquivo de configuração no formato apresentado acima.

**Obs.: O script automaticamente identifica o novo papel e gera as informações pertinentes.**

----

**Exemplo: ckac.conf**

----
	URI_PRINCIPAL="https://www.msn.com/pt-br/dinheiro/stockdetails/"

	URL_VALE3="bsp-vale3/fi-apnjsm" 
	VALE3=(
		2500:15.30
		900:40.70
	)

	URL_PETR4="bsp-petr4/fi-apn4gh"
	PETR4=(
		100:19.70
		800:55
		300:15.40
	)

	URL_SLCE3="bsp-slce3/fi-apncjc"
	SLCE3=(
		500:10.10
		800:22.60
	)

----

**Exemplo de output**

---
jsl]$ ./ckac.sh 

****************************************** VALE3 ******************************************

QTDE: 2500  | VL_COMPRA: 15.30 == 38250.00  | COTAÇÃO: 52.72 == 131800.00 | GANHO DE 93550.00    | % 244.00

QTDE: 900   | VL_COMPRA: 40.70 == 36630.00  | COTAÇÃO: 52.72 == 47448.00  | GANHO DE 10818.00    | % 29.00


NÚM. AÇÕES: 3400

TOTAL INVESTIDO:  74880.00

TOTAL ATUAL:     179248.00

DIFERENÇA:       104368.00


****************************************** PETR4 ******************************************

QTDE: 100   | VL_COMPRA: 19.70 == 1970.00   | COTAÇÃO: 27.44 == 2744.00   | GANHO DE 774.00      | % 39.00

QTDE: 800   | VL_COMPRA: 55    == 44000     | COTAÇÃO: 27.44 == 21952.00  | ==> PERDA DE 22048.00 | % 50.00

QTDE: 300   | VL_COMPRA: 15.40 == 4620.00   | COTAÇÃO: 27.44 == 8232.00   | GANHO DE 3612.00     | % 78.00

NÚM. AÇÕES: 1200

TOTAL INVESTIDO:  50590.00

TOTAL ATUAL:      32928.00

DIFERENÇA:       -17662.00


****************************************** SLCE3 ******************************************

QTDE: 500   | VL_COMPRA: 10.10 == 5050.00   | COTAÇÃO: 17.25 == 8625.00   | GANHO DE 3575.00     | % 70.00

QTDE: 800   | VL_COMPRA: 22.60 == 18080.00  | COTAÇÃO: 17.25 == 13800.00  | ==> PERDA DE 4280.00 | % 23.00

NÚM. AÇÕES: 1300

TOTAL INVESTIDO:  23130.00

TOTAL ATUAL:      22425.00

DIFERENÇA:         -705.00


