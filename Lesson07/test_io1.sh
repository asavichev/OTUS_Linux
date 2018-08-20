#!/bin/bash

COUNT=1000

echo "Генерация ${COUNT} файлов."
dstart=`date`
echo "-- $dstart --"

while [ "${COUNT}" -gt 0 ] ; do
  fname="fn1${COUNT}.txt"
  dd if=/dev/zero of=./${fname} bs=1024 count=10240
  echo "--${COUNT}-${fname}--"
  let "COUNT -= 1"
  rm -f ./$fname
done

edate=`date`
echo "start=${dstart}" 
echo "end=${edate}"

