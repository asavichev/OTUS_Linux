spool logs/preimport.log
begin watcher.import.PR_GET_PROD_GRANTS; end;
/
begin watcher.import.pr_save_parameters; end;
/
spool off;
exit;