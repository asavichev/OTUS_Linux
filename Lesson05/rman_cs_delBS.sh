#!/bin/bash
NTS=$1

# echo "$#"

if [ $# -eq 0 ]
then
echo "##########################################################"
echo "#   Created script fro delete backupset-s by number TS"
echo "#   example:  ${0} 30 < file_rman_list_backupsets"
echo "#   deleted inv_call30,inv_call_d30,inv_call_IDX30"
echo "##########################################################"
exit 0;
fi

echo "# ###### TS=$NTS ####### #"
ca="List of Backup Sets"

while read tmp
do
 if [ "$tmp" == "$ca" ]
 then  
   break
 fi
done
  
read tmp
read tmp

while read tmp
do
read tmp
read -a tArray
BSKey=${tArray[0]}

if [ "${tArray[4]}" == "DISK" ] || [ "${tArray[3]}" == "DISK" ]
then
BSType=${tArray[1]}
 if [ "${tArray[4]}" == "DISK" ]
 then
   BSLevel=${tArray[2]}
   BSCTime="${tArray[6]} ${tArray[5]}"
 else
   BSLevel="NONE"
   BSCTime="${tArray[5]} ${tArray[4]}"
 fi
else

 BSLevel=NONE
 BSType=FILE
 BSCTime="${tArray[4]} ${tArray[3]}"
 
fi
# echo "# BSKey=$BSKey Type=$BSType Level=$BSLevel time=\"${BSCTime}\""
read tmp
read tmp

read -a tArray

if [ ${#tArray[*]} -eq 0 ]
then
  while read tmp
  do
    if [ "$tmp" == "" ]
    then
      break;
    fi
    read tmp
  done
else
#  echo "# ${tArray[*]}"
 if [ ! ${tArray[0]} == "SPFILE" ]
 then
   read tmp
   read tmp
   read -a tArray
   t="echo \"${tArray[5]}\" | awk '/inv_cal(l|l_d|l_IDX)${NTS}./ {print(\$0);}'"
   if [ ! `eval $t` == "" ]
   then
      echo "# BSKey=$BSKey Type=$BSType Level=$BSLevel time=\"${BSCTime}\""
      echo "# delete backupset from file ${tArray[5]}" 
      echo "delete noprompt  backupset ${BSKey};"
   fi
 fi
 read tmp
fi

done 
  
exit
