set heading off
set newpage 0
set space 0
set pagesize 0
set echo off
set linesize 1024

SET FEEDBACK OFF
SET TRIMSPOOL ON
SET TAB OFF

spool def/meta.def
select watcher.import.get_meta_schemas from dual;
spool off
exit;
