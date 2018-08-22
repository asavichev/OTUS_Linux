#!/bin/bash
cpwd=`pwd`

# SIGHUP   1 Hang up detected on controlling terminal or death of controlling process
# SIGINT   2 Issued if the user sends an interrupt signal (Ctrl + C).
# SIGQUIT  3 Issued if the user sends a quit signal (Ctrl + D).
# SIGTERM 15 Software termination signal (sent by kill by default).

trap 'echo "Process Exit... "; exit 1;' 1 2 3 15






A="0";
E="0";
F="0";
X="0";


declare -a GROUP;
declare -a USERS;

declare -a dim_tmp;

add_group_record(){
GROUP[$1]=$2
}

add_user_record(){
# echo "--$1-$2"
USERS[$1]=$2
}


init(){

while read line; do

ID=`echo "$line"  | cut -d: -f3 -`
NAME=`echo "$line" | cut -d: -f1 -`
add_group_record $ID $NAME
done < /etc/group

while read line; do
# echo ">$line<"
ID=`echo "$line"  | cut -d: -f3 -`
NAME=`echo "$line" | cut -d: -f1 -`
# echo "${ID}-${NAME}"
add_user_record $ID $NAME
done < /etc/passwd

}

init

# exit 0 ;
# Обработка параметров/ключей
for it in $* ; do
 # echo ">> $it";
 for (( i=0 ; i < ${#it} ; i++ )) ; do
   case "${it:$i:1}" in
     "a" ) A="1";
     ;;
     "f" ) F="1"
     ;;
     "e" ) E="1";
     ;;
     "x" ) X="1"
     ;;
   esac
   # echo "--> ${it:$i:1}";
 done
done


myPID=$$

# echo "--${myPID}"

cd /proc

PROC=`ls |egrep  "^[0-9]+$" `

_FORMAT_="%-20s %8s %8s\n"

echo "COMMAND PID USER FD TYPE DEVICE SIZE/OFF NODE NAME" | awk '{ printf( "%-20s %8s %8s %3s %4s %6s %8s %10s %-20s\n" , $1, $2, $3, $4, $5, $6, $7, $8, $9);}'


for it in ${PROC[@]} ; do

  if [ -e /proc/$it/status ] ; then
 
   NAME=`cat /proc/$it/status | grep "Name:" |awk '{print $2;}'`
   Uid=`cat /proc/$it/status | grep "Uid:" |awk '{print $2;}' `
   while read -a dim_tmp ; do

     if [[ ${#dim_tmp[*]} -eq 6 ]] ; then
#       echo ">${#dim_tmp[*]}<"
       Fd="-"
       Type="-"
       Dev=${dim_tmp[3]}
       SizeOff="-"
       Node=${dim_tmp[4]}
       Name=${dim_tmp[5]}
       echo "${NAME} ${it} ${USERS[$Uid]} ${Fd} ${Type} ${Dev} ${SizeOff} ${Node} ${Name}" | awk '{printf("%-20s %8s %8s %3s %4s %6s %8s %10s %20s\n", $1, $2, $3, $4, $5, $6, $7 , $8, $9);}'
     fi
   done < /proc/$it/maps

  fi
done

cd $cpwd
