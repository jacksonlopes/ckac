# ckac
Shell script para gerar um relatório simples com informações sobre ganho/perda de ativos da bolsa.

**Formato do arquivo de configuração**

	URL_<ATIVO>="código do ativo da URI"
	<ATIVO>=(
		<NÚMERO AÇÕES>:<PREÇO COMPRA>
		<NÚMERO AÇÕES>:<PREÇO COMPRA>
	)

Para obter o código do ativo:

01 - A url é composta por URI_PRINCIPAL + AÇÃO

02 - Acesse: https://br.financas.yahoo.com/quote/PETR4.SA/?p=PETR4.SA

03 - Procure a ação desejada e copie o código após o "p=", neste caso: PETR4.SA

04 - Adicione os dados no arquivo de configuração. Siga o exemplo abaixo.

**Obs.: O script automaticamente identifica o novo papel e gera as informações necessárias.**

----

**Exemplo: ckac.conf**

----
	URI_PRINCIPAL="https://query1.finance.yahoo.com/v7/finance/quote?lang=en-US&region=BR&corsDomain=finance.yahoo.com&fields=regularMarketPrice&symbols="

	URL_VALE3="VALE3.SA"
	VALE3=(
		2500:15.30
		900:40.70
	)

	URL_PETR4="PETR4.SA"
	PETR4=(
		100:19.70
		800:55
		300:15.40
	)

	URL_SLCE3="SLCE3.SA"
	SLCE3=(
		500:10.10
		800:22.60
	)

----

**Exemplo de output**

![Output:](https://i.pstorage.space/i/wK2PelAe0/original_01.png)

**Cotação simulada**

Para simular o valor de um papel, processa conforme instruções abaixo:

./ckac.sh "AÇÃO" "VALOR"

Ex:

./ckac.sh petr4 12.44
