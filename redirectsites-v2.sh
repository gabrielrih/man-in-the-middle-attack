#!/bin/bash
#
# redirectsites-v2.sh
#
# Redirect sites to another host/port
#
# Gabriel Richter       <gabrielrih@gmail.com>
# Daniel Tomm           <tomm.daniel@gmail.co>
# Creation Date:        2015-09-22
# Last Modification:    2017-03-17
#

# USAGE
use="USAGE: $0 [option] [destination IP] [destination port] [site or file]

	Parameters:
        [option]            1. Enter a site name; 2. Enter sites file list
	[destination IP]    Destination IP to redirect HTTP and HTTPs requests. Eg: 192.168.0.100
	[destination port]  Destination port to redirect HTTP ad HTTPs requests. Eg: 443
	[site or file]      If option = 1 enter site name to redirect.
                            If option = 2 enter sites file list to redirect.
	
	Example:
        $0 eth0 1 10.1.1.137 443 www.facebook.com
        $0 eth0 2 10.1.1.137 443 sites.txt"

# Check parameters
if [ $# != 4 ]
then
	echo "$use";
	exit 1;
fi

# Variables
option=$1
destinationIP=$2
port=$3
site=$4
fileName=$4

# Check if option is SITE
if [ $option == 1 ]
then
        iptables -t nat -A PREROUTING -p tcp -d $site --dport $port -j DNAT --to-destination $destinationIP:$port

# Check if option is LIST FILE
elif [ $option == 2 ]
then

        # File exists?
        if [ ! -f $fileName ]
        then
            echo "$use";
            echo "";
            echo "ERROR: File $fileName doesn't exist!";
            exit 1
        fi

        for i in `cat $fileName`
        do
        	iptables -t nat -A PREROUTING -p tcp -d $i --dport $port -j DNAT --to-destination $destinationIP:$port
        done

else
	echo "$use";
	echo "";
	echo "ERROR: Invalid parameter: $1";

fi

exit 0