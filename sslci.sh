#!/usr/bin/bash

usage() {
  echo "usage : "
  echo "  sslci.sh <CIDR-BLOCK> <OUTPUT-FILE>   - for CIDR block  x.x.x.x/xx "
  echo "  sslci.sh <IP-ADDRESS> <OUTPUT-FILE>   - for single ip address x.x.x.x "
  echo
  echo "eg : "
  echo "  sslci.sh 192.168.1.0/24 target.txt"
  echo "  sslci.sh 192.168.1.3 target.txt"
  echo

}

cleanup() {
  echo
  echo " KeyboardInterrupt !"
  kill 0
  exit 1

}

inspect_ssl_cert() {
    #check if it's a CIDR block
    if [[ $1 =~ '/' ]] ;
    then
        #parse CIDR block
        IPs=(`prips $1 | grep -v '\.0$'`)
        #loop through each ip address and inspect its ssl cert data
        for ip in ${IPs[@]} ;
        do
            nc -nvzw 1.5 $ip 443 2> /dev/null && echo -n "[inspecting ssl_cert from : $ip:443 ][ " && echo "" | timeout 1 openssl s_client -connect $ip:443 -showcerts 2> /dev/null | grep -o "CN=[^/]*\.[^/]*\.[^/*]*" | cut -d "=" -f 2 | xargs echo -n | sed 's/ / , /g' && echo " ]"
        done
    #check if its a single ip address
    elif [[ ! $1 =~ '/' ]] ;
    then
        ip=$1
        #inspect its ssl cert data
        nc -nvzw 1.5 $ip 443 2> /dev/null && echo -n "[inspecting ssl_cert from : $ip:443 ][ " && echo "" | timeout 1 openssl s_client -connect $ip:443 -showcerts 2> /dev/null | grep -o "CN=[^/]*\.[^/]*\.[^/*]*" | cut -d "=" -f 2 | xargs echo -n | sed 's/ / , /g' && echo " ]"

    fi

}




#trap the SIGINT (ctr+c) and call the cleanup function
trap cleanup SIGINT


if [[ $# == 2 ]];
then
outputfile=$2
inspect_ssl_cert $1 | tee $outputfile

else
usage
exit 3

fi
