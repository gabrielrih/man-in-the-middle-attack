#!/bin/bash
#
# Share internet. It's used with man in the middle
#
# Gabriel Richter <gabrielrih@gmail.com>
# Last Modification: 2017-03-17
#

interface=wlan0

modprobe ip_tables
modprobe iptable_nat

iptables -F INPUT
iptables -F OUTPUT
iptables -F POSTROUTING -t nat
iptables -F PREROUTING -t nat

echo 1 > /proc/sys/net/ipv4/ip_forward

iptables -P FORWARD ACCEPT
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -A POSTROUTING -t nat -o $interface -j MASQUERADE
#iptables -A FORWARD -p tcp --tcp-flags SYN,RST SYN -m tcpmss --mss 1400:1536 -j TCPMSS --clamp-mss-to-pmtu

echo "nameserver 8.8.8.8" >> /etc/resolv.conf
echo "nameserver 8.8.4.4" >> /etc/resolv.conf