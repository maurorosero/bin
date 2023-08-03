#!/usr/bin/env bash
#title           : routehex.sh
#description     : Get hexadecimal route value
#author		     : MRP/mrp - Mauro Rosero P.
#personal email  : mauro.rosero@gmail.com
#notes           :
#==============================================================================
#
#==============================================================================
check_ip(){
  local n=0 val=1
  for i in ${1//./ }; do
    [ $i -lt 0 -o $i -gt 255 ] && val=0
    n=$[n+1]
  done
  [ $n -ne 4 ] && val=0
  if [ $val -ne 1 ] ; then
    echo "Invalid IP: $1" >&2
    exit 1
  fi
}

to_bin(){
  local BIN=({0..1}{0..1}{0..1}{0..1}{0..1}{0..1}{0..1}{0..1})
  for i in ${1//./ }; do
   echo -n ${BIN[$i]}
  done
}

while [ $# -gt 0 ] ; do
  nw=${1%/*}; nm=${1#*/}; gw=$2
  check_ip $nw; check_ip $gw
  if [ ${#nm} -gt 2 ] ; then
    check_ip $nm
    nmbin=$(to_bin $nm)
    if echo $nmbin | grep -q "01" ; then
      echo "Invalid netmask: $nm" >&2
      exit 1
    else
      nmbin=${nmbin//0/}
    fi
    nm=${#nmbin}
    echo $nm
  fi
  gwhex=$(printf "%02x:%02x:%02x:%02x" ${2//./ })
  nwhex=$(printf "%02x:%02x:%02x:%02x" ${nw//./ })
  nmhex=$(printf "%02x" ${nm//./ })
  [ $nm -le 24 ] && nwhex=${nwhex%:*}
  [ $nm -le 16 ] && nwhex=${nwhex%:*}
  [ $nm -le 8 ]  && nwhex=${nwhex%:*}
  echo -n $nmhex:$nwhex:$gwhex
  shift 2
  [ $# -gt 0 ] && echo -n ":"
done
echo
