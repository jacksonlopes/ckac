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

![Output:](https://i.pstorage.space/i/wK2PelAe0/original_01.png)
