BEGIN
  SYS.DBMS_SCHEDULER.DROP_SCHEDULE
    (schedule_name  => 'YARD.SCH_LIABILITY_ANSWER');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.CREATE_SCHEDULE
    (
      schedule_name    => 'YARD.SCH_LIABILITY_ANSWER'
     ,start_date       => TO_TIMESTAMP_TZ('2014/12/09 19:00:32.927070 Europe/Moscow','yyyy/mm/dd hh24:mi:ss.ff tzr')
     ,repeat_interval  => 'FREQ=HOURLY'
     ,end_date         => TO_TIMESTAMP_TZ('2015/12/09 19:00:32.927109 Europe/Moscow','yyyy/mm/dd hh24:mi:ss.ff tzr')
     ,comments         => 'Проверка отправленных обязательств, на получение ответа'
    );
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.DROP_SCHEDULE
    (schedule_name  => 'YARD.SCH_ODOPM_PREPARE');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.CREATE_SCHEDULE
    (
      schedule_name    => 'YARD.SCH_ODOPM_PREPARE'
     ,start_date       => TO_TIMESTAMP_TZ('2015/02/13 02:00:00.000000 Europe/Moscow','yyyy/mm/dd hh24:mi:ss.ff tzr')
     ,repeat_interval  => 'FREQ=DAILY'
     ,end_date         => TO_TIMESTAMP_TZ('2016/02/13 17:48:49.249497 Europe/Moscow','yyyy/mm/dd hh24:mi:ss.ff tzr')
     ,comments         => 'Подготовка версий элементов каталога ДТ для передачи'
    );
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.DROP_SCHEDULE
    (schedule_name  => 'YARD.SCH_REFRESH_MV_DAILY');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.CREATE_SCHEDULE
    (
      schedule_name    => 'YARD.SCH_REFRESH_MV_DAILY'
     ,start_date       => TO_TIMESTAMP_TZ('2015/10/16 21:02:41.376077 Europe/Moscow','yyyy/mm/dd hh24:mi:ss.ff tzr')
     ,repeat_interval  => 'FREQ=DAILY; BYHOUR = 1'
     ,end_date         => TO_TIMESTAMP_TZ('2016/10/15 21:02:41.376116 Europe/Moscow','yyyy/mm/dd hh24:mi:ss.ff tzr')
     ,comments         => '_Ў-Rў<_-Ё_ mview'
    );
END;
/









BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'YARD.EGIP_SEND_STATS');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'YARD.EGIP_SEND_STATS'
      ,start_date      => TO_TIMESTAMP_TZ('2017/04/13 21:23:32.000000 +03:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=DAILY;INTERVAL=1;BYHOUR=11;BYMINUTE=0'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'BEGIN
   fdc_mlr_sbn_mailer_pck.add_email_queue (
      p_subject => ''Статистика отправки геометрии ДТ в ЕГИП ''
                               || TO_CHAR (SYSDATE, ''dd.mm.yyyy''),
      p_text => fdc_get_egip_send_stat,
      p_as_html => const.c_true,
      p_system_code => ''YARD'',
      p_subject_area_code => ''SYS_STATS'');
   COMMIT;
EXCEPTION
   WHEN OTHERS
   THEN
      fdc_mlr_sbn_mailer_pck.add_email_queue (
         p_subject => ''Ошибка при формировании статистики по отправке ДТ в ЕГИП'',
         p_text => ''Ошибка в работе задания EGIP_SEND_STATS ''
                                  || TO_CHAR (SYSDATE, ''dd.mm.yyyy hh24:mi:ss'')
                                  || CHR (10)
                                  || get_error_trace,
         p_system_code => ''YARD'',
         p_subject_area_code => ''COMMON_ERR'');
      COMMIT;
      RAISE;
END;'
      ,comments        => 'Статистика работы модуля телеметрического контроля.'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'YARD.EGIP_SEND_STATS'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'YARD.EGIP_SEND_STATS'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'YARD.EGIP_SEND_STATS'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'YARD.EGIP_SEND_STATS'
     ,attribute => 'MAX_RUNS');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'YARD.EGIP_SEND_STATS'
     ,attribute => 'STOP_ON_WINDOW_CLOSE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'YARD.EGIP_SEND_STATS'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'YARD.EGIP_SEND_STATS'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'YARD.EGIP_SEND_STATS'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'YARD.EGIP_SEND_STATS');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'YARD.JOB_ODOPM_PREPARE');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'YARD.JOB_ODOPM_PREPARE'
      ,schedule_name   => 'YARD.SCH_ODOPM_PREPARE'
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'STORED_PROCEDURE'
      ,job_action      => 'fdc_odopm_pck.prepare_for_transfer'
      ,comments        => 'Подготовка версий элементов каталога ДТ для передачи'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'YARD.JOB_ODOPM_PREPARE'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'YARD.JOB_ODOPM_PREPARE'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'YARD.JOB_ODOPM_PREPARE'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'YARD.JOB_ODOPM_PREPARE'
     ,attribute => 'MAX_RUNS');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'YARD.JOB_ODOPM_PREPARE'
     ,attribute => 'STOP_ON_WINDOW_CLOSE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'YARD.JOB_ODOPM_PREPARE'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'YARD.JOB_ODOPM_PREPARE'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'YARD.JOB_ODOPM_PREPARE'
     ,attribute => 'AUTO_DROP'
     ,value     => TRUE);
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'YARD.JOB_REFRESH_MV_DAILY');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'YARD.JOB_REFRESH_MV_DAILY'
      ,start_date      => TO_TIMESTAMP_TZ('2015/10/04 00:00:00.000000 +03:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=DAILY;'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'STORED_PROCEDURE'
      ,job_action      => 'fdc_refresh_mview_daily'
      ,comments        => NULL
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'YARD.JOB_REFRESH_MV_DAILY'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'YARD.JOB_REFRESH_MV_DAILY'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'YARD.JOB_REFRESH_MV_DAILY'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'YARD.JOB_REFRESH_MV_DAILY'
     ,attribute => 'MAX_RUNS');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'YARD.JOB_REFRESH_MV_DAILY'
     ,attribute => 'STOP_ON_WINDOW_CLOSE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'YARD.JOB_REFRESH_MV_DAILY'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'YARD.JOB_REFRESH_MV_DAILY'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'YARD.JOB_REFRESH_MV_DAILY'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'YARD.JOB_REFRESH_MV_DAILY');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'YARD.JOB_REPORTS');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'YARD.JOB_REPORTS'
      ,start_date      => TO_TIMESTAMP_TZ('2014/11/14 00:00:00.000000 +03:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'Freq=DAILY;Interval=1'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'STORED_PROCEDURE'
      ,job_action      => 'fdc_report_fill_pck.seta'
      ,comments        => NULL
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'YARD.JOB_REPORTS'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'YARD.JOB_REPORTS'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'YARD.JOB_REPORTS'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'YARD.JOB_REPORTS'
     ,attribute => 'MAX_RUNS');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'YARD.JOB_REPORTS'
     ,attribute => 'STOP_ON_WINDOW_CLOSE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'YARD.JOB_REPORTS'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'YARD.JOB_REPORTS'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'YARD.JOB_REPORTS'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);
END;
/
