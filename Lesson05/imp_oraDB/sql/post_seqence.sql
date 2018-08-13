spool logs/post_sequence.log

begin 
  watcher.pr_seq_getAll; 
end;
/
declare 
 num number;
begin
 num :=0;

for rs in (
  select * from watcher.all_sequence t, watcher.all_schema s where t.sequence_owner = s.schema and s.imp in ('Y','M')
) loop
  
  if rs.last_number > 1 then
  begin
    execute immediate 'begin select '||rs.sequence_owner||'.'||rs.sequence_name||'.nextval into :1 from dual; end;' using in out num;
    
    if num < rs.last_number then
      execute immediate 'alter sequence '||rs.sequence_owner||'.'||rs.sequence_name||' increment by '||to_char(rs.last_number-num+1)||' nocache';
      execute immediate 'declare l_id number; begin select '||rs.sequence_owner||'.'||rs.sequence_name||' .nextval into l_id from dual; end;';
      execute immediate 'alter sequence '||rs.sequence_owner||'.'||rs.sequence_name||'  increment by 1 cache 20';
    end if;
    
  exception 
    when others then
      null;
  end;
  end if;

end loop;

end;
/
spool off;
exit;