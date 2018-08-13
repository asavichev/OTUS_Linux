#!/bin/bash
# Ñêğèïò ìîíèòîğèíãà Îğàêëà ÄÁ äëÿ Zabbix
#
export NLS_LANG=AMERICAN_CIS.Al32UTF8
temp=`lsnrctl status`
# echo "`set | grep ORACLE`"
declare -a atest
if [ -z `echo "$temp" | grep "^STATUS " | awk '{print $1}'` ] ; then
echo "oracle.listener.status=0"
echo "oracle.listener.alias="
echo "oracle.listener.version="
echo "oracle.listener.start="
echo "oracle.listener.service="
echo "oracle.listener.instance="
else
LSNR_ALIAS=`echo "$temp" | grep "^Alias" | awk '{print $2}'`
LSNR_VERSION=`echo "$temp" | grep "^Version " | awk -F: '{print $2}' | awk '{print $2}'`
LSNR_START=`echo "$temp" | grep "^Start Date " | awk  '{print $3 " " $4}'`
LSNR_SERVICE=""
LSNR_INSTANCE=""
for val in `echo "$temp" | grep "^Service " | awk '{print $2}'`
do
if [ -z $LSNR_SERVICE ] ; then
LSNR_SERVICE="$val"
else
LSNR_SERVICE="${LSNR_SERVICE},${val}"
fi
done
unset atest
for val in `echo "$temp" | grep "Instance " | awk '{print $2}' | awk -F, '{print $1}'`
do
#    echo ">>>val=$val"
tt=
for i in ${atest[@]} ; do
if [ $i = $val ] ;  then
tt=$val
break
fi
done
if [ -z $tt  ] ; then
atest[${#atest[@]}]=$val
fi
done
for val in ${atest[@]}
do
if [ -z $LSNR_INSTANCE ] ; then
LSNR_INSTANCE="$val"
else
LSNR_INSTANCE="${LSNR_INSTANCE},${val}"
fi
done
# echo ">>>>>>>>${atest[@]}<<<<<<<"
echo "oracle.listener.status=1"
echo "oracle.listener.alias=${LSNR_ALIAS}"
echo "oracle.listener.version=${LSNR_VERSION}"
echo "oracle.listener.start=${LSNR_START}"
echo "oracle.listener.service=${LSNR_SERVICE}"
echo "oracle.listener.instance=${LSNR_INSTANCE}"
# echo "oracle.listener.instance=\"ods\""
for val in ${atest[@]}
do
export ORACLE_SID=${val}
sqlplus -s sys/oracle@${val} as sysdba @oracle.sql
done
# sqlplus -s sys/oracle@test as sysdba @oracle.sql
fi
