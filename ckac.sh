#!/bin/bash
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# Author: Jackson Lopes <jacksonlopes@gmail.com>
# URL: https://stdsrc.net

# Dependências:
# binutils, curl, bc, jq
dep=(curl bc jq)
simulacao_acao=""
simulacao_valor=0

function verificar_parametros() {
    [ "$1" != "" -a "$2" = "" ] && {
        echo "Erro: Para a simulação da cotação é necessário informar <AÇÃO> <VALOR>."
        echo "ex.: $0 petr4 10.55"
        exit 1
    }
    simulacao_acao=`echo $1 | tr '[a-z]' '[A-Z]'`
    simulacao_valor=$2
}

function validar_ambiente()
{
   [ ! -f ckac.conf ] && {
     echo "Erro: Arquivo 'ckac.conf' não encontrado."
     exit 1
   }

   for d in ${dep[*]}; do
      which $d 1>/dev/null
      [ $? != 0 ] && {
        echo "Erro: $d não encontrado..."
        exit 1
      }
   done
}

source ckac.conf
retorno=""

function obter_cotacao()
{
  local cotacao=""
  local header="'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36'"

  cotacao=`curl -H $header -s $1 | jq ".quoteResponse.result[0].regularMarketPrice"`
  echo $cotacao | tr ',' '.'
}

function calcular_valores()
{

    local total_somatorio_compra=0
    local total_somatorio_atual=0
    local total_acoes=0

    qtde=`echo $4 | cut -d':' -f1`
    vl_compra=`echo $4 | cut -d':' -f2`
    total_compra=$(bc <<< "$qtde * $vl_compra")
    total_atual=$(bc <<< "$qtde * $cotacao")

    total_somatorio_compra=$(bc <<< "$1 + $total_compra")
    total_somatorio_atual=$(bc <<< "$2 + $total_atual")
    total_acoes=$(bc <<< "$3 + $qtde")

    somatorio=$(bc <<< "$total_atual - $total_compra")

    echo $somatorio | grep "-" 1>/dev/null
    if [ $? != 0  ]; then
       imp_str="GANHO DE $somatorio"
    else
       somatorio=$(bc <<< "$somatorio * -1")
       imp_str="==> PERDA DE $somatorio"
    fi

    # ( valor_inicial - valor_final ) / valor_inicial * 100
    perc=`echo "scale=2; ($total_compra - $total_atual) / $total_compra * 100" | bc`
    echo $perc | grep "-" 1>/dev/null
    [ $? = 0 ] && {
       perc=$(bc <<< "$perc * -1")
    }

    printf "QTDE: %-5s | VL_COMPRA: %-5s == %-9s | COTAÇÃO: %-5s == %-9s | %-20s | %% %s\n" "$qtde" "$vl_compra" "$total_compra" "$cotacao" "$total_atual" "$imp_str" "$perc"
    perc=0
    retorno="$total_somatorio_compra;$total_somatorio_atual;$total_acoes"
}

function imprimir_final()
{
  diferenca=$(bc <<< "$2 - $1")
  echo "================="
  echo "NÚM. AÇÕES: $3"
  printf "TOTAL INVESTIDO: %9s\n" "$1"
  printf "TOTAL ATUAL: %13s\n" "$2"
  printf "DIFERENÇA: %15s\n" "$diferenca"
}

function calcular_apresentar_acoes()
{
  local cotacao=""
  #https://www.gnu.org/savannah-checkouts/gnu/bash/manual/bash.html#Shell-Parameter-Expansion
  url="URL_"$1
  [ "${!url}" == "" ] && {
     echo "* Papel '$1' não existente no arquivo 'ckac.conf'"
     return
  }

  url_buscar=${!url}
  v=$(eval echo "\${${1}[*]}")
  local url="${URI_PRINCIPAL}${url_buscar}"

  if [ "$1" = "$simulacao_acao" ]; then
      echo -e "\e[1m+----------------------------------\e[0m"
      echo -e "\e[1m| Valor simulado: $simulacao_valor\e[0m"
      echo -e "\e[1m+----------------------------------\e[0m"
      cotacao=$simulacao_valor
  else
      cotacao=`obter_cotacao $url`
  fi

  local total_somatorio_compra=0
  local total_somatorio_atual=0
  local total_acoes=0

  echo "****************************************** $1 ******************************************"

  for A in ${v[*]}; do
     calcular_valores $total_somatorio_compra $total_somatorio_atual $total_acoes $A
     total_somatorio_compra=`echo $retorno | cut -d';' -f1`
     total_somatorio_atual=`echo $retorno | cut -d';' -f2`
     total_acoes=`echo $retorno | cut -d';' -f3`
  done

  imprimir_final $total_somatorio_compra $total_somatorio_atual $total_acoes
  echo ""
}

main()
{
  verificar_parametros $*
  validar_ambiente
  for V in `grep "URL_" ckac.conf | grep "=" | cut -d'_' -f2 | cut -d'=' -f1`; do
     calcular_apresentar_acoes "$V"
  done
}

main $*
