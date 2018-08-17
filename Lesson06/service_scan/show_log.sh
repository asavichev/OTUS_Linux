#!/bin/bash
LOG_IN_FILE=/var/log/messages
LOG_OUT_FILE=/tmp/logout.log

echo ">>>$OPTIONS<<<"

if [ "${OPTIONS}-" = "-" ] ; then
  echo "-- `date` Not declare \${OPTIONS}" >> ${LOG_OUT_FILE}
else
  echo "-- `date`" >> ${LOG_OUT_FILE}
  cat ${LOG_IN_FILE}| grep "${OPTIONS}" | grep -v grep >> ${LOG_OUT_FILE}
fi

