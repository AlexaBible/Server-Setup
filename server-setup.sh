#!/usr/bin/env bash

echo "$(tput setaf 1)#########################################################################"
echo "$(tput setaf 2)Installing Server$(tput setaf 1)"
echo "#########################################################################$(tput setaf 7)"

#First update the system
yum upgrade -y
yum -y install wget git
yum install epel* -y
yum upgrade -y

source ./helpers/functions.sh

#Enable the firewall
yum install firewalld -y
enableService firewalld
firewall-cmd --reload

ipString=`hostname -I`
ipArray=$(echo $ipString | tr " " "\n")
ip4=""
ip6=""
for ip in $ipArray
do
        if [[ $ip =~ ":" ]]
        then
                ip6=$ip
        else
                ip4=$ip
        fi
done
echo "Server: " `hostname -f` >> ./emailFile.txt
echo
echo "IPv4: " $ip4
echo "IPv6: " $ip6

fileString=`ls server-setup/*.sh`
#echo $fileString
fileArray=$(echo $fileString | tr " " "\n")
for file in $fileArray
do
    source $file
done

#todo email the results from emailFile.txt