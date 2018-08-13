spool logs/rebuild_statistics.log

begin
  for it in (
    select sh.schema from watcher.all_schema sh  where sh.imp in ('Y','M')
  ) loop
    dbms_stats.unlock_schema_stats(it.schema);
    dbms_stats.gather_schema_stats(ownname =>it.schema,cascade => FALSE);
  end loop;
end;
/                                     
commit
/                    
spool off;
exit;