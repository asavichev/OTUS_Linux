spool logs/enable_const.log

BEGIN
   FOR I IN (
        SELECT 'ALTER TABLE '||t.owner||'.'||t.TABLE_NAME ||' ENABLE '||
              case when  t.validated='NOT VALIDATED' then ' NOVALIDATE ' else ' ' end
              ||'CONSTRAINT '||CONSTRAINT_NAME             AS SQL_STR 
--	SELECT 'ALTER TABLE '||t.owner||'.'||t.TABLE_NAME ||' ENABLE CONSTRAINT ' || t.CONSTRAINT_NAME AS SQL_STR
	FROM
	    all_constraints t
	where t.owner in ( 
         'MTK','YARD','BBD'
	) and t.status = 'DISABLED'
    )
    LOOP
	BEGIN
	    EXECUTE IMMEDIATE I.SQL_STR;
	EXCEPTION
	    WHEN OTHERS THEN
--		dbms_output.put_line(i.sql_str);         
		NULL;
	END;
    END LOOP;
END;
/
begin
  for i in (
     select 'alter trigger '||t.owner||'.'||t.trigger_name||' enable' as sql_str
     from all_triggers t
     where t.owner in(
         'MTK','YARD','BBD'
     ) and t.status = 'DISABLED' 
  ) loop
    BEGIN
      EXECUTE IMMEDIATE I.SQL_STR;
    EXCEPTION
       WHEN OTHERS THEN
       null;
--        dbms_output.put_line('Error: '||i.sql_str);         
    END;
  end loop;
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
-- 1 Proxy for UDO_ANONYMOUS 
ALTER USER UDO_ANONYMOUS
GRANT CONNECT THROUGH UDO_PROXY_USER
WITH ROLE UDO_ANONYMOUS_ROLE, UDO_WEB_SERVICE_ROLE;
/
-- create context for ppi
create context FDC_PPI_CTX using ppi.fdc_util_pck;
/
begin
 for it in (
   select username from all_users t where T.USERNAME in (
        'BBD','BBD_OWNER','BB_SYS','CMP','ODS_GATE','GEO','GREEN','GREEN_TL','INSP','MLR','NSI','ODH','OZN','PPI','PPI_WEB_SERVICE_USER','SNOW_DWH','UDO','UDO_ANONYMOUS','UDO_PROXY_USER','UDO_PWP','UDO_SECRM','MTK','YARD'
   ) ) loop
    execute immediate 'alter user '||it.username||' IDENTIFIED BY '||lower(it.username);
 end loop ;
end;
/
begin
 for it in (
   select username from all_users t where T.USERNAME in (
        'SECR','WST'
   ) ) loop
        execute immediate 'alter user '||it.username||' IDENTIFIED BY '||upper(it.username);
   end loop ;
end;
/
declare
 queryId number;
begin
     dbms_session.set_role('UDO_DEPT_ROLE');
     secr.fdc_set_role;
     queryId := geo.fdc_egip_query_pck.add_query('select distinct object_id as id, (decode(mod(object_id, 3), 0, ''GEO.C.NOT_CLEAN_STYLE'', 1, ''GEO.C.PARTIAL_CLEAN_STYLE'', 2, ''GEO.C.CLEAN_STYLE'')) as style, customer_id, cust.name as customer_name, roadway_area from geo.fdc_org_object_v o, udo.fdc_organization cust where o.customer_id=cust.id(+) and sysdate between o.start_date and o.end_date');
     geo.fdc_egip_query_pck.add_results(queryId, 'customer_id', 'LONG', 'Идентификатор заказчика');
     geo.fdc_egip_query_pck.add_results(queryId, 'customer_name', 'STRING', 'Заказчик');
     geo.fdc_egip_query_pck.add_results(queryId, 'roadway_area', 'DOUBLE', 'Площадь проезжей части');
end;
/                         
declare
  queryId number;
begin
      dbms_session.set_role('UDO_DEPT_ROLE');
      secr.fdc_set_role;
      queryId := geo.fdc_egip_query_pck.add_query('select t.id, ''MTK.M.CAR_FUNC_TYPE_''||f.id as style
, f.id as type_id
, f.short_name as type_name
, c.gov_number
, c.contractor_id
, o.brief_name as contractor_name
, sdo_geometry.GET_WKT(sdo_geometry ( 2001, 262152, sdo_point_type( t.coord_x, t.coord_y, null), null, null)) as geometry
from mtk.FDC_ACTIVE_CAR t
, mtk.fdc_car c
, mtk.fdc_car_func_type f
, mtk.fdc_nsi_organization_v o
where t.id = c.id
   and c.type_id = f.id
   and c.contractor_id = o.id
   and rownum <= 5000');
     geo.fdc_egip_query_pck.add_results(queryId, 'type_id',  'LONG', 'Идентификатор заказчика');
     geo.fdc_egip_query_pck.add_results(queryId, 'type_name',  'STRING', 'Заказчик');
     geo.fdc_egip_query_pck.add_results(queryId, 'contractor_id', 'LONG', 'Идентификатор подрядчика');
     geo.fdc_egip_query_pck.add_results(queryId, 'contractor_name', 'STRING', 'Подрядчик');
end;
/
declare 
i integer ;
s varchar2(1000);
str varchar2(1000);
begin
    for item in (
      
--        select distinct sysname from (
--    	    select t.SYSNAME as sysname from secr.fdc_user_md t, all_users u where t.SYSNAME = u.USERNAME 
--            union
--            select t.user_name as sysname from udo_secrm.fdc_user t ,all_users u where t.user_name=u.USERNAME
--        )
select distinct sysname from (

select 'FORS_DEPT' as sysname from dual
union all
select 'VAO_PREF' from dual
union all
select 'UVAO_PREF' from dual
union all
select 'CAO_PREF' from dual
union all
select 'TINAO' from dual
union all
select 'VAO' from dual
union all
select 'J_GOLYANOVO' from dual
union all
select 'UVAO' from dual
union all
select 'CAO' from dual
union all
select 'AVD_CAO' from dual
union all
select 'AVD' from dual
union all
select 'SHAPOV_TEST' from dual
union all
select 'VNUK_TEST' from dual
union all
select 'FORS_OATI' from dual
union all
select 'INSP_VAO' from dual
union all
select 'INSP_TINAO' from dual

union all
select 'BITESTER' from dual

union all
select 'DEMO' from dual

union all
select 'YARD_DEPT' from dual
union all
select 'YARD_CUST' from dual
union all
select 'YARD_TEST' from dual

union all
select 'UVAO_GREEN_TEST1' from dual
union all
select 'UVAO_GREEN_TEST2' from dual
union all
select 'CAO_GREEN_TEST' from dual
union all
select 'MOS_GREEN_TEST' from dual
union all
select 'PR_UVAO_GREEN_TEST' from dual
union all
select 'PR_CAO_GREEN_TEST' from dual
union all
select 'DEP_GREEN_TEST' from dual

union all
select 'VAO' from dual
union all
select 'FORS_DEPT' from dual
union all
select 'FORASOL' from dual
union all
select 'GUIS_BOGORODSKOE' from dual
union all
select 'DOROGA' from dual
union all
select 'STROY' from dual
union all
select 'SVGOLICIN' from dual
union all
select 'ALRABOCHIY' from dual

union all
select 'BLAGER' sysname from dual
union all
select 'OSHEGAL' sysname from dual
union all
select 'AVTEBEKIN' sysname from dual
union all
select 'WST_ADMIN' sysname from dual
union all

select 'PPI_DEPT' sysname from dual
union all
select 'PPI_OKRUG' sysname from dual
union all
select 'PPI_OWNER' sysname from dual
union all
select 'PPI_TEST' sysname from dual
union all
select 'MTK_WEB_SERVICE' sysname from dual
union all
select 'BBD_OWNER' sysname from dual
union all
select 'EGIP_INTEGRATION' sysname from dual
) 

    )
    loop
        str := '';
        select count(*) into i from all_users u where u.username = item.sysname;
        if i=0 then
          execute immediate 'CREATE USER '||item.sysname||' IDENTIFIED BY '||lower(item.sysname)|| ' PROFILE DEFAULT ACCOUNT UNLOCK';
          execute immediate 'GRANT CREATE SESSION TO '||item.sysname;
        end if;
        select count(*) into i  from dba_users u where u.username =  item.sysname and u.account_status='LOCKED';
        if i>0 then
          execute immediate 'ALTER USER '||item.sysname||' ACCOUNT UNLOCK';
      end if;
      i:=0;
      for it in (
      select distinct ROLE_SYSNAME from (
    select t.ROLE_SYSNAME from secr.FDC_USER_MD_V t where t.SYSNAME = item.SYSNAME
    union 
    select  t.ORA_ROLE role_sysname from udo_secrm.fdc_user_role t where t.user_name = item.SYSNAME
  )
    )
    loop
  s := 'GRANT '||it.ROLE_SYSNAME||' TO '||item.SYSNAME;
        execute immediate s;
        if length(str) > 0 then
          str := str || ',';
      end if;
      str := str||it.ROLE_SYSNAME;
      i:= i+1;
    end loop;
    if i > 0 then
  s := 'ALTER USER '||item.SYSNAME||' DEFAULT ROLE ALL EXCEPT '||str;
  execute immediate s;
  str :='ALTER USER '||item.SYSNAME||' GRANT CONNECT THROUGH UDO_PROXY_USER WITH ROLE '||str;
  execute immediate str;
    end if;
end loop;
end;
/
begin
for item in (
select * from all_tables t where t.OWNER='MTK'
)
loop
execute immediate 'ALTER TABLE MTK.'||item.table_name||' DROP UNUSED COLUMNS';
end loop;
end;
/
spool off
/
exit
