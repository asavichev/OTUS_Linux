#!/bin/bash
export NLS_LANG=AMERICAN_CIS.AL32UTF8
export dir_path=/u02/app/oracle/temp
export cur_path=`pwd`

echo "+++ $cur_path +++"
echo "start `date '+%d-%m-%Y_%H:%M'`" >> time.txt
echo "перед запуском скрипта нужно на проде запустить sys.aaa_role_tab_privs"
echo "sqlplus sys/oracle as sysdba @preimport.sql"
sqlplus sys/sys as sysdba @sql/preimport.sql
echo "sqlplus watcher/watcher @sql/create_full_script.sql"
sqlplus watcher/watcher @sql/create_full_script.sql
echo "sqlplus watcher/watcher @sql/create_meta_script.sql"
sqlplus watcher/watcher @sql/create_meta_script.sql

echo "sqlplus sys/oracle as sysdba @drop_users.sql"
sqlplus sys/oracle as sysdba @sql/drop_users.sql
echo "DROP USERS `date '+%d-%m-%Y_%H:%M'`" >> time.txt


$ORACLE_HOME/bin/impdp system/oracle parfile=par/full.par
echo "IMPORT FULL `date '+%d-%m-%Y_%H:%M'`" >> time.txt

sqlplus sys/oracle as sysdba @sql/post_load_full.sql

echo "sqlplus ods_gate/ods_gate @sql/ods_gate_dblink.sql"
sqlplus ods_gate/ods_gate @sql/ods_gate_dblink.sql
echo "Chenged ODS_GATE DBLINK `date '+%d-%m-%Y_%H:%M'`" >> time.txt


$ORACLE_HOME/bin/impdp system/oracle  parfile=par/meta.par
echo "Import MetoData shems `date '+%d-%m-%Y_%H:%M'`" >> time.txt

# create scripts from constraints
sh/cr_const.sh

sqlplus sys/oracle as sysdba @sql/post_load_meta.sql

echo "sqlplus sys/oracle as sysdba @disable_const.sql"
sqlplus sys/oracle as sysdba @sql/disable_const.sql
echo "DISABLE CONSTRAINTS `date '+%d-%m-%Y_%H:%M'`" >> time.txt

for aa in `cat def/meta.def | awk -F\, '{for(i=1;i<=NF;i++){print $i}}'`
do
  $ORACLE_HOME/bin/impdp system/oracle parfile=par/$aa.par
  echo "`date '+%d-%m-%Y_%H:%M'`  impdp system/oracle parfile=par/$aa.par"
done

sqlplus system/oracle @sql/post_load_tables.sql  


sqlplus sys/oracle as sysdba @sql/enable_const.sql
echo "ENABLE CONSTRAINTS `date '+%d-%m-%Y_%H:%M'`" >> time.txt

# sequence changing
sqlplus system/oracle @sql/post_seqence.sql
echo "SEQUENCE TRAP `date '+%d-%m-%Y_%H:%M'`" >> time.txt

# reload SDO objects
sqlplus watcher/watcher @sql/reload_sdo.sql

# rebuild statistics (not validate)
sqlplus sys/oracle @sql/rebuild_statistics.sql

echo "STOP `date '+%d-%m-%Y_%H:%M'`" >> time.txt
echo "task complite..."
cd $cur_path

