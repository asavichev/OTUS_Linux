#!/bin/bash

COUNT=3000000
# SIGHUP   1 Hang up detected on controlling terminal or death of controlling process
# SIGINT   2 Issued if the user sends an interrupt signal (Ctrl + C).
# SIGQUIT  3 Issued if the user sends a quit signal (Ctrl + D).
# SIGTERM 15 Software termination signal (sent by kill by default).

trap 'echo "Process Exit... "; exit 1;' 1 2 3 15


echo "Генерация ${COUNT} случайных чисел."
dstart=`date`
echo "-- $dstart --"

while [ "${COUNT}" -gt 0 ] ; do

  r=$RANDOM
  let "COUNT -= 1"  
  echo "--$r"
  
done

edate=`date`
echo "start=${dstart}" 
echo "end=${edate}"

