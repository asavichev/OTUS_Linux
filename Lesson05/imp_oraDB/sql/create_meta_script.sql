set heading off
set newpage 0
set space 0
set pagesize 0
set echo off
set linesize 1024

SET FEEDBACK OFF
SET TRIMSPOOL ON
SET TAB OFF

spool par/meta.par
select 'schemas='||watcher.import.get_meta_schemas from dual;
select 'content=METADATA_ONLY' from dual;
select 'parallel=4' from dual;
select 'directory=expdp_tmp_dir' from dual;
select 'logfile=meta.log' from dual;
select 'network_link=system_prod' from dual;
spool off
exit;
