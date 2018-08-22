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

add_group_record(){
GROUP[$1]=$2
}

add_user_record(){
# echo "--$1-$2"
USERS[$1]=$2
}

init(){

while read line; do
# echo ">$line<"

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

echo "E=$E";
echo "F=$F";

# exit 0;

myPID=$$

# echo "--${myPID}"

cd /proc

PROC=`ls |egrep  "^[0-9]+$" `

if [[ "${E}" == "1" || "${A}" == "1" ]] ; then

 for it in ${PROC[@]} ; do
  if [ -e /proc/$it/status ] ; then
   GUID=`cat /proc/$it/status | grep "Gid:" |awk '{print $2;}'`
   ST=`cat /proc/$it/status | grep "State:" |awk '{print $2;}'`
   if [ "${X}" == "1" ] ; then
    NAME=`cat /proc/$it/cmdline | tr "\0" " "`
   else
    NAME=`cat /proc/$it/status | grep "Name:" |awk '{print $2;}'`
   fi
   TTY=`cat /proc/$it/environ | tr "\0" "\n" |grep TTY | cut -d= -f2 -| sed  's!\/dev\/!\/!g'`
   # GUID=`cat /proc/$it/status | grep "Gid:"`
   echo "${it} ${TTY:-"?"} ${ST} ${GROUP[$GUID]} ${NAME}" | awk '{printf("%s \t%s \t%s \t%s \t%s\n", $1, $2, $3, $4, $5);}'
  fi
 done

else

P=$$
# echo "--${P}"

while [[ "$P" != "1" ]] ; do
  GUID=`cat /proc/${P}/status | grep "Gid:" |awk '{print $2;}'`
  NAME=`cat /proc/${P}/status | grep "Name:" |awk '{print $2;}'`
  TTY=`cat /proc/${P}/environ | tr "\0" "\n" |grep TTY | cut -d= -f2 -| sed  's!\/dev\/!\/!g'`
  PP=`cat /proc/${P}/status | grep "PPid:" |awk '{print $2;}'`
  # echo "-->$PP"
  echo "${P} ${PP} ${TTY:-"-"} ${GROUP[$GUID]} ${NAME}" | awk '{printf("pid=%s \tppid=%s \t%s \t%s \t%s\n", $1, $2, $3, $4, $5);}'
  P=${PP}
done

fi

cd $cpwd
