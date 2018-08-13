spool logs/post_load_tables.log

insert into  yard.fdc_lob_storage 
  select 
     t.id
     , empty_blob() LOB_CONTENT
     , t.file_name
     , t.file_size
     , t.table_name
     , t.object_id 
  from yard.fdc_lob_storage@SYSTEM_PROD t
/
commit
/                    
spool off;
exit;