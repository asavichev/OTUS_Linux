spool logs/post_load_meta.log

begin
 for it in (
   select schema from watcher.all_schema t where T.DEL='Y' and T.IMP='M'
 ) loop
    execute immediate 'alter user '||it.schema||' IDENTIFIED BY '||lower(it.schema);
 end loop ;
end;
/
begin
 for it in ( select * from watcher.aaa_dba_tab_privs t )
 loop
 begin
  if it.grantable = 'YES' then
    execute immediate 'grant '||it.privilege||' on '||it.owner||'.'||it.table_name||' to '||it.grantee|| ' WITH GRANT OPTION;';
  else
    execute immediate 'grant '||it.privilege||' on '||it.owner||'.'||it.table_name||' to '||it.grantee;
  end if;
 exception
   when others then
     null;
 end;
 end loop;
end;
/
begin
 for it in ( select * from watcher.all_role_tab_privs t )
 loop 
 begin
  if it.grantable = 'YES' then
    execute immediate 'grant '||it.privilege||' on '||it.owner||'.'||it.table_name||' to '||it.role|| ' WITH GRANT OPTION';
  else
    execute immediate 'grant '||it.privilege||' on '||it.owner||'.'||it.table_name||' to '||it.role;
  end if;
  exception
   when others then
    null;
 end; 
 end loop;
end;
/
begin
 for it in ( select * from watcher.all_schema t where t.imp in ('Y','M') )
 loop
   dbms_utility.compile_schema(it.schema, false);
 end loop;
end;
/
spool off;
exit;