#!/bin/bash
#
# disableDNSforward-v2.sh
#
# Using arpspoofing, you can execute this to disable DNS calls to some sites
#
# Gabriel Richter       <gabrielrih@gmail.com>
# Creation Date:        2016-08-25
# Last Modification:    2017-03-17
#

# USE
use="USAGE: $0 [option] [site or file]

	Onde:
	[option]	1. Enter a site name; 2. Enter sites file list
	[site or file]
			If option = 1 enter site name.
			If option = 2 enter sites file list.
	
	Examples:
	$0 1 www.facebook.com
	$0 2 arquivo.host"

# Check parameters
if [ $# != 2 ]
then
	echo "$use";
	exit 1;
fi

# Variables
option=$1
site=$2
fileList=$2

# Check if option is SITE
if [ $option == 1 ]
then
	iptables -A FORWARD -p udp --dport 53 -d $site -j DROP
	iptables -A FORWARD -p tcp --dport 53 -d $site -j DROP

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
		iptables -A FORWARD -p udp --dport 53 -d $i -j DROP
		iptables -A FORWARD -p tcp --dport 53 -d $i -j DROP
	done

else
	echo "$use";
	echo "";
	echo "ERROR: Invalid parameter: $1";

fi

exit 0