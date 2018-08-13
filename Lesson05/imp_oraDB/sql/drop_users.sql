spool logs/drop_users.log

PURGE DBA_RECYCLEBIN;
/
ALTER SYSTEM SET recyclebin = OFF DEFERRED;
/

begin
  for it in ( select schema from watcher.all_schema t where t.del = 'Y')
  loop
    for ses in ( select sid,serial# from v$session s where s.username = it.schema )
    loop
    begin
       -- dbms_output.put_line('alter system kill session '''||ses.sid||','||ses.serial#||''' immediate;');
       execute immediate 'alter system kill session '''||ses.sid||','||ses.serial#||''' immediate';
    exception
      when others then 
        dbms_output.put_line('error kill session '''||ses.sid||','||ses.serial#||''' immediate;');
    end;
    end loop;
    --  dbms_output.put_line('drop user '||it.schema ||' cascade;');
    begin
    execute immediate 'drop user '||it.schema ||' cascade';
    exception
      when others then 
        dbms_output.put_line('error: drop user '''||it.schema||'''.');
    end;
   end loop;
end;
/
                                      
ALTER SYSTEM SET recyclebin = ON DEFERRED;
/

--drop user bbd cascade;
--/
--drop user bbd_owner cascade;
--/
--drop user bb_sys cascade;
--/
--drop user cmp cascade;
--/
--drop user digg cascade;
--/
--drop user digg_anonymous cascade;
--/
--drop user digg_emc_owner cascade;
--/
--drop user digg_test cascade;
--/
--drop user geo cascade;
--/
--drop user green cascade;
--/
--drop user green_tl cascade;
--/
--drop user insp cascade;
--/
--drop user insp_oati cascade;
--/
--drop user insp_oati_web_service cascade;
--/
--drop user mlr cascade;
--/
--drop user mtk cascade;
--/
--drop user nsi cascade;
--/
-- drop user nsi_oati cascade;
--/
-- drop user oati cascade;
--/
--drop user odh cascade;
--/
--drop user odsp cascade;
--/
-- drop user odsp_anonymous cascade;
--/
--drop user ozn cascade;
--/
--drop user ppi cascade;
--/
--drop user ppi_web_service_user cascade;
--/
--drop user secr cascade;
--/
--drop user secr_oati cascade;
--/
--drop user snow_dwh cascade;
--/
--drop user udo cascade;
--/
--drop user udo_anonymous cascade;
--/
--drop user udo_proxy_user cascade;
--/
--drop user udo_pwp cascade;
--/
--drop user udo_secrm cascade;
--/
--drop user wst cascade;
--/
--drop user yard cascade;
--/
spool off
exit
