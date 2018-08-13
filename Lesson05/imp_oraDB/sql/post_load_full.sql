spool logs/post_load_full.log

begin
 for it in (
   select schema from watcher.all_schema t where T.DEL='Y' and T.IMP='Y'
 ) loop
   if it.schema in ('SECR','WST') then
      execute immediate 'alter user '||it.schema||' IDENTIFIED BY '||upper(it.schema);
   else
      execute immediate 'alter user '||it.schema||' IDENTIFIED BY '||lower(it.schema);
   end if;
 end loop ;
end;
/
GRANT SELECT ON SYS.DBA_ROLE_PRIVS TO UDO_SECRM WITH GRANT OPTION;
/
GRANT EXECUTE ON SYS.DBMS_RLS TO UDO_SECRM;
/        
GRANT READ, WRITE ON DIRECTORY SYS.DATA_PUMP_DIR TO UDO;
/
GRANT SELECT ON SYS.DBA_ROLE_PRIVS TO UDO;
/
GRANT EXECUTE ON SYS.DBMS_CRYPTO TO UDO;
/
GRANT EXECUTE ON SYS.DBMS_LOCK TO UDO;
/
GRANT READ, WRITE ON DIRECTORY SYS.EXPDP_TMP_DIR TO UDO;
/
GRANT EXECUTE, READ, WRITE ON DIRECTORY SYS.FDC_BTI_DIR TO UDO WITH GRANT OPTION;
/
GRANT SELECT ON SYS.DBA_CONS_COLUMNS TO SECR WITH GRANT OPTION;
/
GRANT SELECT ON SYS.DBA_CONSTRAINTS TO SECR WITH GRANT OPTION;
/
GRANT SELECT ON SYS.DBA_ROLE_PRIVS TO SECR WITH GRANT OPTION;
/
GRANT SELECT ON SYS.DBA_USERS TO SECR WITH GRANT OPTION;
/
GRANT EXECUTE ON SYS.DBMS_CRYPTO TO SECR;
/
GRANT EXECUTE ON SYS.DBMS_LOCK TO SECR;
/
GRANT EXECUTE ON SYS.DBMS_RLS TO SECR;
/
GRANT SELECT ON SYS.USER$ TO SECR WITH GRANT OPTION;
/
GRANT SELECT ON SYS.V_$PARAMETER TO SECR WITH GRANT OPTION;
/
GRANT SELECT ON SYS.DBA_CONS_COLUMNS TO SECR_OATI WITH GRANT OPTION;
/
GRANT SELECT ON SYS.DBA_CONSTRAINTS TO SECR_OATI WITH GRANT OPTION;
/
GRANT SELECT ON SYS.DBA_ROLE_PRIVS TO SECR_OATI WITH GRANT OPTION;
/
GRANT SELECT ON SYS.DBA_USERS TO SECR_OATI WITH GRANT OPTION;
/
GRANT EXECUTE ON SYS.DBMS_CRYPTO TO SECR_OATI;
/
GRANT EXECUTE ON SYS.DBMS_LOCK TO SECR_OATI;
/
GRANT EXECUTE ON SYS.DBMS_RLS TO SECR_OATI;
/
GRANT SELECT ON SYS.USER$ TO SECR_OATI WITH GRANT OPTION;
/
GRANT SELECT ON SYS.V_$PARAMETER TO SECR_OATI WITH GRANT OPTION;
/
GRANT EXECUTE ON SYS.DBMS_LOCK TO PPI;
/
GRANT EXECUTE ON SYS.DBMS_LOCK TO OZN;
/
GRANT EXECUTE ON SYS.DBMS_CRYPTO TO ODSP;
/
GRANT EXECUTE ON SYS.DBMS_LOCK TO ODSP;
/
GRANT SELECT ON SYS.DBA_CONS_COLUMNS TO NSI;
/
GRANT SELECT ON SYS.DBA_CONSTRAINTS TO NSI;
/
GRANT SELECT ON SYS.DBA_OBJECTS TO NSI;
/
GRANT SELECT ON SYS.DBA_TAB_COLUMNS TO NSI;
/
GRANT SELECT ON SYS.DBA_TAB_PRIVS TO NSI;
/
GRANT EXECUTE ON SYS.DBMS_LOCK TO NSI;
/
GRANT EXECUTE, READ, WRITE ON DIRECTORY SYS.FDC_BTI_DIR TO NSI WITH GRANT OPTION;
/
GRANT EXECUTE ON SYS.DBMS_LOCK TO MTK;
/
GRANT EXECUTE ON SYS.DBMS_REDEFINITION TO MTK;
/
GRANT EXECUTE ON SYS.DBMS_LOCK TO DIGG;
/
GRANT EXECUTE ON SYS.DBMS_LOCK TO ODH;
/
GRANT EXECUTE ON SYS.DBMS_SCHEDULER TO ODH;
/
GRANT READ, WRITE ON DIRECTORY SYS.EXPDP_TMP_DIR TO ODH;
/
GRANT SELECT ON SYS.DBA_ROLE_PRIVS TO YARD;
/
GRANT SELECT ON SYS.DBA_VIEWS TO YARD;
/
GRANT EXECUTE ON SYS.DBMS_LOCK TO YARD;
/
GRANT EXECUTE ON SYS.DBMS_RLS TO YARD;
/
GRANT EXECUTE ON SYS.DBMS_XPLAN_TYPE TO YARD;
/
GRANT EXECUTE ON SYS.DBMS_XPLAN_TYPE_TABLE TO YARD;
/
GRANT READ, WRITE ON DIRECTORY SYS.EXPDP_TMP_DIR TO YARD;
/
GRANT SELECT ON SYS.V_$ACTIVE_INSTANCES TO YARD;
/
GRANT SELECT ON SYS.V_$DATABASE TO YARD;
/
GRANT SELECT ON SYS.V_$INSTANCE TO YARD;
/                                        
GRANT EXECUTE ON SYS.DBMS_LOCK TO WST;
/
GRANT CREATE SESSION TO UDO_ANONYMOUS;
/
GRANT EXECUTE ON SYS.DBMS_CRYPTO TO ODS_GATE;
/
exec dbms_utility.compile_schema('UDO_SECRM', false);
spool off;
exit;