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

02 - Adicione os dados no arquivo de configuração. Siga o exemplo abaixo.

**Obs.: O script automaticamente identifica o novo papel e gera as informações pertinentes.**

----

**Exemplo: ckac.conf**

----
	URI_PRINCIPAL="https://br.advfn.com/bolsa-de-valores/bovespa/@/cotacao"

	URL_VALE3="vale-on-VALE3"
	VALE3=(
		2500:15.30
		900:40.70
	)

	URL_PETR4="petrobras-pn-PETR4"
	PETR4=(
		100:19.70
		800:55
		300:15.40
	)

	URL_SLCE3="slc-agricola-on-SLCE3"
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
