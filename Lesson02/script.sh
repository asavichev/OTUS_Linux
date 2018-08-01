#!/bin/bash
LOG=/tmp/create_raid.txt

t=`cat /etc/fstab| grep "/dev/md0"`
echo ${#t}
if [ ${#t} -eq 0 ] ; then

echo "Create raid..." >> ${LOG}

mdadm --zero-superblock /dev/sd{b,c,d,e,f,g} >> ${LOG}
mdadm --create /dev/md0 --level 5 -n 6 /dev/sd{b,c,d,e,f,g} >> ${LOG}

for i in {1..5}
do
sgdisk -g -n ${i}::+200M /dev/md0 >> ${LOG}
done

t=`ls /dev/md0p*| awk '{print $0;}'`

for var in $t
do
 n=${var:9:1}
 mkdir /u0${n} 
 mkfs.ext3 $var
 echo "$var /u0${n}   ext3    defaults   0 0" >> /etc/fstab
 sleep 10
 mount /u0${n}
done

fi