#!/bin/bash

COUNT=3000000

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

