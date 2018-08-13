spool desable_const.log

BEGIN
   FOR I IN (
	SELECT 'ALTER TABLE '||t.owner||'.'||t.TABLE_NAME ||' DISABLE CONSTRAINT ' ||
	    t.CONSTRAINT_NAME AS SQL_STR
	FROM --USER_CONSTRAINTS 
	    all_constraints t
	where t.owner in ( 
	'MTK','YARD'
	) and t.status = 'ENABLED' and t.CONSTRAINT_TYPE in ('R', 'C', 'U')
	ORDER BY DECODE ( CONSTRAINT_TYPE, 'R', 0, 'C', 1, 'U', 2, 'P', 3)
    )
    LOOP
	BEGIN
	    EXECUTE IMMEDIATE I.SQL_STR;
	EXCEPTION
	    WHEN OTHERS THEN
		NULL;
	END;
    END LOOP;
END;
/
begin
  for i in (
     select 'alter trigger '||t.owner||'.'||t.trigger_name||' disable' as sql_str
     from all_triggers t
     where t.owner in(
	'MTK','YARD'
     ) and t.status = 'ENABLED' 
  ) loop
    BEGIN
      EXECUTE IMMEDIATE I.SQL_STR;
    EXCEPTION
       WHEN OTHERS THEN
        NULL;
    END;
  end loop;
end;
/
spool off
exit
