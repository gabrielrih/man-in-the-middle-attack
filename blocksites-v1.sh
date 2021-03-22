#!/bin/bash
#
# blocksites-v1.sh
#
# Using arpspoofing, you can execute this to block HTTP and HTTPS access to some sites
#
# Gabriel Richter       <gabrielrih@gmail.com>
# Creation Date:        2017-03-17
# Last Modification:    2017-03-17
#

# USE
use="USAGE: $0 [option] [site or file] [port]

	Parameters:
	[option]	1. Enter a site name; 2. Enter sites file list
	[site or file]
			If option = 1 enter site name.
			If option = 2 enter sites file list.
        [port]          Enter port to block.
	
	Examples:
	$0 1 www.facebook.com 443
	$0 2 arquivo.host 80"

# Check parameters
if [ $# != 3 ]
then
	echo "$use";
	exit 1;
fi

# Variables
option=$1
site=$2
fileList=$2
port=$3

# Check if option is SITE
if [ $option == 1 ]
then
	iptables -A FORWARD -p udp --dport $port -d $site -j DROP
	iptables -A FORWARD -p tcp --dport $port -d $site -j DROP

# Check if option is LIST FILE
elif [ $option == 2 ]
then

        # File exists?
        if [ ! -f $fileList ]
        then
            echo "$use";
            echo "";
            echo "ERROR: File $fileList doesn't exist!";
            exit 1
        fi

	for i in `cat $fileList`
	do
		iptables -A FORWARD -p udp --dport $port -d $i -j DROP
		iptables -A FORWARD -p tcp --dport $port -d $i -j DROP
	done

else
	echo "$use";
	echo "";
	echo "ERROR: Invalid parameter: $1";

fi

exit 0