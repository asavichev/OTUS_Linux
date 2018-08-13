BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'MTK.CALC_SM_SNOW');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'MTK.CALC_SM_SNOW'
      ,start_date      => TO_TIMESTAMP_TZ('2016/11/16 10:53:48.395859 Europe/Moscow','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=HOURLY;INTERVAL=4;BYHOUR=6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23;BYMINUTE=30'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'BEGIN
   IF (SYSDATE <= TRUNC (SYSDATE) + 11 / 24)
   THEN
      fdc_sm_snow (TRUNC (SYSDATE) - 1);
   ELSE
      fdc_sm_snow;
   END IF;
END;'
      ,comments        => 'Пересчет отчета по вывозу снега.'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.CALC_SM_SNOW'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.CALC_SM_SNOW'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.CALC_SM_SNOW'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.CALC_SM_SNOW'
     ,attribute => 'MAX_RUNS');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.CALC_SM_SNOW'
     ,attribute => 'STOP_ON_WINDOW_CLOSE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.CALC_SM_SNOW'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.CALC_SM_SNOW'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.CALC_SM_SNOW'
     ,attribute => 'AUTO_DROP'
     ,value     => TRUE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'MTK.CALC_SM_SNOW');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'MTK.CHECK_PRESENT_RAW_DATA');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'MTK.CHECK_PRESENT_RAW_DATA'
      ,start_date      => TO_TIMESTAMP_TZ('2017/05/31 21:14:00.000000 +03:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=MINUTELY;INTERVAL=5'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'declare
  l_text clob;
begin
  l_text := fdc_check_present_raw_data;
  if (l_text is not null) then
    fdc_mlr_sbn_mailer_pck.add_email_queue (
      p_subject => ''Отсутствие телеметрических данные в буферной области от ССД ETO ''
                               || TO_CHAR(SYSDATE, ''dd.mm.yyyy hh24:mi:ss''),
      p_text => l_text,
      p_as_html => const.c_true,
      p_system_code => ''MTK'',
      p_subject_area_code => ''SYS_STATS'');
   commit;
  end if;
exception
   when others
   then
      fdc_mlr_sbn_mailer_pck.add_email_queue (
         p_subject => ''Ошибка при проверке отсутствия телеметрических данные в буферной области от ССД ETO'',
         p_text => ''Ошибка в работе задания CHECK_PRESENT_RAW_DATA ''
                                  || TO_CHAR (SYSDATE, ''dd.mm.yyyy hh24:mi:ss'')
                                  || CHR (10)
                                  || get_error_trace,
         p_system_code => ''MTK'',
         p_subject_area_code => ''COMMON_ERR'');
      commit;
      raise;
end;'
      ,comments        => 'Проверяет отсутствие телеметрических данные в буферной области от ССД ETO.'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.CHECK_PRESENT_RAW_DATA'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.CHECK_PRESENT_RAW_DATA'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.CHECK_PRESENT_RAW_DATA'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.CHECK_PRESENT_RAW_DATA'
     ,attribute => 'MAX_RUNS');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.CHECK_PRESENT_RAW_DATA'
     ,attribute => 'STOP_ON_WINDOW_CLOSE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.CHECK_PRESENT_RAW_DATA'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.CHECK_PRESENT_RAW_DATA'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.CHECK_PRESENT_RAW_DATA'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'MTK.CHECK_PRESENT_RAW_DATA');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'MTK.DROP_ACTIVE_CAR');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'MTK.DROP_ACTIVE_CAR'
      ,start_date      => TO_TIMESTAMP_TZ('2017/06/29 22:09:23.339081 Europe/Moscow','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=MINUTELY;INTERVAL=1;BYSECOND=0'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin fdc_load_pck.drop_active_car; end;'
      ,comments        => 'Удаление активной техники'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.DROP_ACTIVE_CAR'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.DROP_ACTIVE_CAR'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.DROP_ACTIVE_CAR'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.DROP_ACTIVE_CAR'
     ,attribute => 'MAX_RUNS');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.DROP_ACTIVE_CAR'
     ,attribute => 'STOP_ON_WINDOW_CLOSE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.DROP_ACTIVE_CAR'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.DROP_ACTIVE_CAR'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.DROP_ACTIVE_CAR'
     ,attribute => 'AUTO_DROP'
     ,value     => TRUE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'MTK.DROP_ACTIVE_CAR');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'MTK.DROP_EXPIRED');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'MTK.DROP_EXPIRED'
      ,start_date      => TO_TIMESTAMP_TZ('2014/11/14 00:00:00.000000 +03:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=DAILY;INTERVAL=1;BYHOUR=1;BYMINUTE=0'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin fdc_load_pck.drop_expired_part(''fdc_telemetry_err''); fdc_load_pck.drop_expired_part(''fdc_sensor_data_err''); end;'
      ,comments        => 'Удаление ошибок из стека, старше одного месяца.'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.DROP_EXPIRED'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.DROP_EXPIRED'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.DROP_EXPIRED'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.DROP_EXPIRED'
     ,attribute => 'MAX_RUNS');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.DROP_EXPIRED'
     ,attribute => 'STOP_ON_WINDOW_CLOSE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.DROP_EXPIRED'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.DROP_EXPIRED'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.DROP_EXPIRED'
     ,attribute => 'AUTO_DROP'
     ,value     => TRUE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'MTK.DROP_EXPIRED');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'MTK.DROP_EXPIRED_CAR_REG');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'MTK.DROP_EXPIRED_CAR_REG'
      ,start_date      => TO_TIMESTAMP_TZ('2016/03/21 15:23:10.626781 Europe/Moscow','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=DAILY;INTERVAL=1;BYHOUR=1;BYMINUTE=0'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => ' begin fdc_map_pck.drop_expired_part; end; '
      ,comments        => 'Удаление предварительно построенных реестров техники(которые используются в карте)'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.DROP_EXPIRED_CAR_REG'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.DROP_EXPIRED_CAR_REG'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.DROP_EXPIRED_CAR_REG'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.DROP_EXPIRED_CAR_REG'
     ,attribute => 'MAX_RUNS');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.DROP_EXPIRED_CAR_REG'
     ,attribute => 'STOP_ON_WINDOW_CLOSE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.DROP_EXPIRED_CAR_REG'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.DROP_EXPIRED_CAR_REG'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.DROP_EXPIRED_CAR_REG'
     ,attribute => 'AUTO_DROP'
     ,value     => TRUE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'MTK.DROP_EXPIRED_CAR_REG');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'MTK.DROP_LOG');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'MTK.DROP_LOG'
      ,start_date      => TO_TIMESTAMP_TZ('2015/08/13 20:23:15.812075 Europe/Moscow','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=DAILY;INTERVAL=1;BYHOUR=1;BYMINUTE=0'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin
                            delete from fdc_event_log e
                            where exists (select 0
                                                 from fdc_event_detail_log t
                                                     ,fdc_event_log        er
                                                where t.event_id = er.event_id
                                                  and er.event_type_code = e.event_type_code)
                                   and not exists (select 0 from fdc_event_detail_log ed where ed.event_id = e.event_id)
                                   and not exists (select 0 from fdc_err_log er where er.event_id = e.event_id);
                            commit;
                          end;'
      ,comments        => 'Очистка логов от пустых операций редактирования'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.DROP_LOG'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.DROP_LOG'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.DROP_LOG'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.DROP_LOG'
     ,attribute => 'MAX_RUNS');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.DROP_LOG'
     ,attribute => 'STOP_ON_WINDOW_CLOSE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.DROP_LOG'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.DROP_LOG'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.DROP_LOG'
     ,attribute => 'AUTO_DROP'
     ,value     => TRUE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'MTK.DROP_LOG');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'MTK.GENERATE_DAILY');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'MTK.GENERATE_DAILY'
      ,start_date      => TO_TIMESTAMP_TZ('2015/05/28 19:00:00.000000 +03:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=HOURLY;INTERVAL=1;BYMINUTE=45'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => '
begin
  fdc_load_rep_pck.generate(p_calc_wst_rep=>0);
end;
'
      ,comments        => 'Формирование ежедневной отчетности.'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.GENERATE_DAILY'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.GENERATE_DAILY'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.GENERATE_DAILY'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.GENERATE_DAILY'
     ,attribute => 'MAX_RUNS');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.GENERATE_DAILY'
     ,attribute => 'STOP_ON_WINDOW_CLOSE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.GENERATE_DAILY'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.GENERATE_DAILY'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.GENERATE_DAILY'
     ,attribute => 'AUTO_DROP'
     ,value     => TRUE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'MTK.GENERATE_DAILY');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'MTK.GENERATE_DAILY_SENSOR');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'MTK.GENERATE_DAILY_SENSOR'
      ,start_date      => TO_TIMESTAMP_TZ('2015/05/28 19:00:00.000000 +03:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=HOURLY;INTERVAL=1;BYMINUTE=45'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => '
begin
  fdc_load_rep_sensor_pck.generate;
end;
'
      ,comments        => 'Формирование ежедневной отчетности.'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.GENERATE_DAILY_SENSOR'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.GENERATE_DAILY_SENSOR'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.GENERATE_DAILY_SENSOR'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.GENERATE_DAILY_SENSOR'
     ,attribute => 'MAX_RUNS');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.GENERATE_DAILY_SENSOR'
     ,attribute => 'STOP_ON_WINDOW_CLOSE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.GENERATE_DAILY_SENSOR'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.GENERATE_DAILY_SENSOR'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.GENERATE_DAILY_SENSOR'
     ,attribute => 'AUTO_DROP'
     ,value     => TRUE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'MTK.GENERATE_DAILY_SENSOR');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'MTK.GENERATE_DAILY_WST');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'MTK.GENERATE_DAILY_WST'
      ,start_date      => TO_TIMESTAMP_TZ('2015/05/28 19:00:00.000000 +03:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=HOURLY;INTERVAL=1;BYMINUTE=00'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => '
begin
  fdc_load_rep_pck.generate_wst;
end;
'
      ,comments        => 'Формирование ежедневной отчетности.'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.GENERATE_DAILY_WST'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.GENERATE_DAILY_WST'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.GENERATE_DAILY_WST'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.GENERATE_DAILY_WST'
     ,attribute => 'MAX_RUNS');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.GENERATE_DAILY_WST'
     ,attribute => 'STOP_ON_WINDOW_CLOSE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.GENERATE_DAILY_WST'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.GENERATE_DAILY_WST'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.GENERATE_DAILY_WST'
     ,attribute => 'AUTO_DROP'
     ,value     => TRUE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'MTK.GENERATE_DAILY_WST');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'MTK.GENERATE_WEEK');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'MTK.GENERATE_WEEK'
      ,start_date      => TO_TIMESTAMP_TZ('2015/06/27 00:00:00.000000 +03:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=DAILY;INTERVAL=1;BYHOUR=0;BYMINUTE=15'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => '
declare
  v_id number;
begin
  for cur in
  (
    select t.*
          ,row_number() over(partition by t.rn_grp order by t.target_date) - 1 rn_h
      from (select trunc(sysdate) - rownum target_date
                  ,mod(rownum, 8) rn_grp
                  ,mod(rownum, 2) rn
              from dual
            connect by level <= 7) t
     order by t.target_date desc
  )
  loop
    dbms_job.submit(job => v_id,what => ''fdc_load_rep_pck.generate(date''''''||to_char(cur.target_date,''yyyy-mm-dd'')||'''''');'',next_date => sysdate + 30*(cur.rn)/1440 + cur.rn_h/24);
  end loop;
  commit;
end;
'
      ,comments        => 'Формирование отчетности за прошедшую неделю.'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.GENERATE_WEEK'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.GENERATE_WEEK'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.GENERATE_WEEK'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.GENERATE_WEEK'
     ,attribute => 'MAX_RUNS');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.GENERATE_WEEK'
     ,attribute => 'STOP_ON_WINDOW_CLOSE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.GENERATE_WEEK'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.GENERATE_WEEK'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.GENERATE_WEEK'
     ,attribute => 'AUTO_DROP'
     ,value     => TRUE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'MTK.GENERATE_WEEK');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'MTK.GENERATE_WEEK_SENSOR');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'MTK.GENERATE_WEEK_SENSOR'
      ,start_date      => TO_TIMESTAMP_TZ('2015/05/29 01:00:00.000000 +03:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=DAILY;INTERVAL=1;BYHOUR=0;BYMINUTE=15'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => '
declare
  v_id number;
begin
  for cur in
  (
    select trunc(sysdate) - rownum target_date
      from dual connect by level <= 7
     order by target_date desc
  )
  loop
    dbms_job.submit(v_id,''fdc_load_rep_sensor_pck.generate(date''''''||to_char(cur.target_date,''yyyy-mm-dd'')||'''''');'');
  end loop;
  commit;
end;
'
      ,comments        => 'Формирование отчетности за прошедшую неделю.'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.GENERATE_WEEK_SENSOR'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.GENERATE_WEEK_SENSOR'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.GENERATE_WEEK_SENSOR'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.GENERATE_WEEK_SENSOR'
     ,attribute => 'MAX_RUNS');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.GENERATE_WEEK_SENSOR'
     ,attribute => 'STOP_ON_WINDOW_CLOSE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.GENERATE_WEEK_SENSOR'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.GENERATE_WEEK_SENSOR'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.GENERATE_WEEK_SENSOR'
     ,attribute => 'AUTO_DROP'
     ,value     => TRUE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'MTK.GENERATE_WEEK_SENSOR');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'MTK.LOAD_SENSOR_BUF');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'MTK.LOAD_SENSOR_BUF'
      ,start_date      => TO_TIMESTAMP_TZ('2014/11/14 00:00:00.000000 +03:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=MINUTELY;INTERVAL=1;BYSECOND=30'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin fdc_load_pck.load_sensor_buf; end;'
      ,comments        => 'Задание для обновления данных о текущем положении техники.'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.LOAD_SENSOR_BUF'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.LOAD_SENSOR_BUF'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.LOAD_SENSOR_BUF'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.LOAD_SENSOR_BUF'
     ,attribute => 'MAX_RUNS');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.LOAD_SENSOR_BUF'
     ,attribute => 'STOP_ON_WINDOW_CLOSE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.LOAD_SENSOR_BUF'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.LOAD_SENSOR_BUF'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.LOAD_SENSOR_BUF'
     ,attribute => 'AUTO_DROP'
     ,value     => TRUE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'MTK.LOAD_SENSOR_BUF');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'MTK.LOAD_SENSOR_RAW');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'MTK.LOAD_SENSOR_RAW'
      ,start_date      => TO_TIMESTAMP_TZ('2014/11/14 00:00:00.000000 +03:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=MINUTELY;INTERVAL=1;BYSECOND=30'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin fdc_load_pck.load_sensor_raw; end;'
      ,comments        => 'Задание для обновления данных о текущем положении техники.'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.LOAD_SENSOR_RAW'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.LOAD_SENSOR_RAW'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.LOAD_SENSOR_RAW'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.LOAD_SENSOR_RAW'
     ,attribute => 'MAX_RUNS');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.LOAD_SENSOR_RAW'
     ,attribute => 'STOP_ON_WINDOW_CLOSE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.LOAD_SENSOR_RAW'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.LOAD_SENSOR_RAW'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.LOAD_SENSOR_RAW'
     ,attribute => 'AUTO_DROP'
     ,value     => TRUE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'MTK.LOAD_SENSOR_RAW');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'MTK.LOAD_TEL_BUF');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'MTK.LOAD_TEL_BUF'
      ,start_date      => TO_TIMESTAMP_TZ('2014/11/14 00:00:00.000000 +03:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=MINUTELY;INTERVAL=1;BYSECOND=30'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin fdc_load_pck.load_tel_buf; end;'
      ,comments        => 'Задание для обновления данных о текущем положении техники.'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.LOAD_TEL_BUF'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.LOAD_TEL_BUF'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.LOAD_TEL_BUF'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.LOAD_TEL_BUF'
     ,attribute => 'MAX_RUNS');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.LOAD_TEL_BUF'
     ,attribute => 'STOP_ON_WINDOW_CLOSE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.LOAD_TEL_BUF'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.LOAD_TEL_BUF'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.LOAD_TEL_BUF'
     ,attribute => 'AUTO_DROP'
     ,value     => TRUE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'MTK.LOAD_TEL_BUF');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'MTK.LOAD_TEL_BUF_2');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'MTK.LOAD_TEL_BUF_2'
      ,start_date      => TO_TIMESTAMP_TZ('2017/07/10 14:06:39.080437 Europe/Moscow','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=MINUTELY;INTERVAL=1;BYSECOND=30'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin fdc_load_pck.load_tel_buf_2; end;'
      ,comments        => 'Задание для обновления данных о текущем положении техники.'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.LOAD_TEL_BUF_2'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.LOAD_TEL_BUF_2'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.LOAD_TEL_BUF_2'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.LOAD_TEL_BUF_2'
     ,attribute => 'MAX_RUNS');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.LOAD_TEL_BUF_2'
     ,attribute => 'STOP_ON_WINDOW_CLOSE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.LOAD_TEL_BUF_2'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.LOAD_TEL_BUF_2'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.LOAD_TEL_BUF_2'
     ,attribute => 'AUTO_DROP'
     ,value     => TRUE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'MTK.LOAD_TEL_BUF_2');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'MTK.LOAD_TEL_RAW');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'MTK.LOAD_TEL_RAW'
      ,start_date      => TO_TIMESTAMP_TZ('2014/11/14 00:00:00.000000 +03:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=MINUTELY;INTERVAL=1;BYSECOND=30'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin fdc_load_pck.load_tel_raw; end;'
      ,comments        => 'Задание для обновления данных о текущем положении техники.'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.LOAD_TEL_RAW'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.LOAD_TEL_RAW'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.LOAD_TEL_RAW'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.LOAD_TEL_RAW'
     ,attribute => 'MAX_RUNS');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.LOAD_TEL_RAW'
     ,attribute => 'STOP_ON_WINDOW_CLOSE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.LOAD_TEL_RAW'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.LOAD_TEL_RAW'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.LOAD_TEL_RAW'
     ,attribute => 'AUTO_DROP'
     ,value     => TRUE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'MTK.LOAD_TEL_RAW');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'MTK.RECALC_SM_SNOW');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'MTK.RECALC_SM_SNOW'
      ,start_date      => TO_TIMESTAMP_TZ('2016/11/11 22:13:30.670418 Europe/Moscow','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=DAILY;INTERVAL=1;BYHOUR=3;BYMINUTE=0'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'BEGIN
                               FOR i
                                  IN (    SELECT TRUNC (SYSDATE) - 3 + LEVEL - 1 AS date$
                                            FROM DUAL
                                      CONNECT BY TRUNC (SYSDATE) - 3 + LEVEL - 1 <= TRUNC (SYSDATE) - 1
                                        ORDER BY 1 DESC)
                               LOOP
                                  fdc_sm_snow (i.date$);
                               END LOOP;
                            END;'
      ,comments        => 'Пересчет отчета по вывозу снега.'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.RECALC_SM_SNOW'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.RECALC_SM_SNOW'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.RECALC_SM_SNOW'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.RECALC_SM_SNOW'
     ,attribute => 'MAX_RUNS');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.RECALC_SM_SNOW'
     ,attribute => 'STOP_ON_WINDOW_CLOSE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.RECALC_SM_SNOW'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.RECALC_SM_SNOW'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.RECALC_SM_SNOW'
     ,attribute => 'AUTO_DROP'
     ,value     => TRUE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'MTK.RECALC_SM_SNOW');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'MTK.REFRESH_MV_DAILY');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'MTK.REFRESH_MV_DAILY'
      ,start_date      => TO_TIMESTAMP_TZ('2015/08/13 00:00:00.000000 +03:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=DAILY;INTERVAL=1;BYHOUR=6;BYMINUTE=0'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'STORED_PROCEDURE'
      ,job_action      => 'FDC_REFRESH_MVIEW_DAILY'
      ,comments        => 'Формирование отчетности за прошедшую неделю.'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.REFRESH_MV_DAILY'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.REFRESH_MV_DAILY'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.REFRESH_MV_DAILY'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.REFRESH_MV_DAILY'
     ,attribute => 'MAX_RUNS');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.REFRESH_MV_DAILY'
     ,attribute => 'STOP_ON_WINDOW_CLOSE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.REFRESH_MV_DAILY'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.REFRESH_MV_DAILY'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.REFRESH_MV_DAILY'
     ,attribute => 'AUTO_DROP'
     ,value     => TRUE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'MTK.REFRESH_MV_DAILY');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'MTK.REFRESH_MV_HOURLY');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'MTK.REFRESH_MV_HOURLY'
      ,start_date      => TO_TIMESTAMP_TZ('2015/08/13 00:00:00.000000 +03:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=HOURLY;INTERVAL=1;BYMINUTE=0'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'STORED_PROCEDURE'
      ,job_action      => 'fdc_load_rep_pck.clean_cache'
      ,comments        => 'Формирование отчетности.'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.REFRESH_MV_HOURLY'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.REFRESH_MV_HOURLY'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.REFRESH_MV_HOURLY'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.REFRESH_MV_HOURLY'
     ,attribute => 'MAX_RUNS');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.REFRESH_MV_HOURLY'
     ,attribute => 'STOP_ON_WINDOW_CLOSE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.REFRESH_MV_HOURLY'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.REFRESH_MV_HOURLY'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.REFRESH_MV_HOURLY'
     ,attribute => 'AUTO_DROP'
     ,value     => TRUE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'MTK.REFRESH_MV_HOURLY');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'MTK.REPORT_REGISTER');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'MTK.REPORT_REGISTER'
      ,start_date      => TO_TIMESTAMP_TZ('2015/08/13 20:23:19.731521 Europe/Moscow','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=DAILY;INTERVAL=1;BYHOUR=11;BYMINUTE=30'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => '
declare
  l_message_wst   varchar2(512 char);
  l_message_udo   varchar2(512 char);
  l_message_yard  varchar2(512 char);
  l_message_route varchar2(512 char);
begin
  select ''Раздел: ОТХОДЫ''||chr(10)||chr(10)
       ||''Зарегистрировано техники: '' ||count(t.car_id)||chr(10)
       ||''Передавали сигнал сегодня: ''||count(case when trunc(a.date_to) = trunc(sysdate) then t.car_id end)||chr(10)
       ||''Передавали сигнал ранее: ''  ||count(case when trunc(a.date_to) < trunc(sysdate) then t.car_id end)||chr(10)
    into l_message_wst
    from (select distinct car_id
            from table( fdc_car_pck.get_car_register_all( p_target_date => trunc(sysdate)
                                                        , p_section     => ''WST''
                                                        )
                      )
         ) t
        , fdc_active_car a
   where a.id(+) = t.car_id;

  select chr(10)||''Раздел: ДОРОГИ''||chr(10)||chr(10)
       ||''Зарегистрировано техники: '' ||count(t.car_id)||chr(10)
       ||''Передавали сигнал сегодня: ''||count(case when trunc(a.date_to) = trunc(sysdate) then t.car_id end)||chr(10)
       ||''Передавали сигнал ранее: ''  ||count(case when trunc(a.date_to) < trunc(sysdate) then t.car_id end)||chr(10)
    into l_message_udo
    from (select distinct car_id
            from table( fdc_car_pck.get_car_register_all( p_target_date => trunc(sysdate)
                                                        , p_section     => ''UDO''
                                                        )
                      )
         ) t
        , fdc_active_car a
   where a.id(+) = t.car_id;

  select chr(10)||''Раздел: ДТ''||chr(10)||chr(10)
       ||''Зарегистрировано техники: '' ||count(t.car_id)||chr(10)
       ||''Передавали сигнал сегодня: ''||count(case when trunc(a.date_to) = trunc(sysdate) then t.car_id end)||chr(10)
       ||''Передавали сигнал ранее: ''  ||count(case when trunc(a.date_to) < trunc(sysdate) then t.car_id end)||chr(10)
    into l_message_yard
    from (select distinct car_id
            from table( fdc_car_pck.get_car_register_all( p_target_date => trunc(sysdate)
                                                        , p_section     => ''YARD''
                                                        )
                      )
         ) t
        , fdc_active_car a
   where a.id(+) = t.car_id;

  select ''Всего маршрутов: ''     ||count(distinct r.id)||chr(10)||''Всего ОДХ в машрутах: ''||count(distinct p.object_id)||chr(10)
    into l_message_route
    from fdc_route r, fdc_route_point p
   where r.id = p.route_id(+);

  fdc_mlr_sbn_mailer_pck.add_email_queue
    ( p_subject           => ''Сведения об уборочной технике на ''||to_char(sysdate,''dd.mm.yyyy hh24:mi'')
    , p_text              => l_message_wst||l_message_udo||l_message_route||l_message_yard
    , p_system_code       => ''MTK''
    , p_subject_area_code => ''WEEKLY_REPORT''
    );
end;
'
      ,comments        => 'Еженедельные запросы для внутреннего использования.'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.REPORT_REGISTER'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.REPORT_REGISTER'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.REPORT_REGISTER'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.REPORT_REGISTER'
     ,attribute => 'MAX_RUNS');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.REPORT_REGISTER'
     ,attribute => 'STOP_ON_WINDOW_CLOSE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.REPORT_REGISTER'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.REPORT_REGISTER'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.REPORT_REGISTER'
     ,attribute => 'AUTO_DROP'
     ,value     => TRUE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'MTK.REPORT_REGISTER');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'MTK.REPORT_SENSOR');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'MTK.REPORT_SENSOR'
      ,start_date      => TO_TIMESTAMP_TZ('2014/11/14 00:00:00.000000 +03:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=DAILY;INTERVAL=1;BYHOUR=11;BYMINUTE=30'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => '
declare
  l_reg_level_qty number;
  l_reg_rate_qty  number;
  l_total_qty     number;
  l_equipped_qty  number;
  l_daily_qty     number;
  l_early_qty     number;
begin
  fdc_fuel_sensor_stat
    ( p_reg_level_qty => l_reg_level_qty
    , p_reg_rate_qty  => l_reg_rate_qty
    , p_total_qty     => l_total_qty
    , p_equipped_qty  => l_equipped_qty
    , p_daily_qty     => l_daily_qty
    , p_early_qty     => l_early_qty
    );

  fdc_mlr_sbn_mailer_pck.add_email_queue
    ( p_subject           => ''Сведения о датчиках топлива по состоянию на ''||to_char(sysdate,''dd.mm.yyyy hh24:mi'')
    , p_text              =>   ''<br>Зарегистрировано датчиков уровня топлива: ''                                 ||to_char(l_reg_level_qty)
                             ||''<br>Зарегистрировано датчиков расхода топлива: ''                                ||to_char(l_reg_rate_qty)
                             ||''<br>Общее кол-во техники: ''                                                     ||to_char(l_total_qty)
                             ||''<br>Кол-во техники, оборудованной датчиками топлива: ''                          ||to_char(l_equipped_qty)
                             ||''<br>Кол-во техники, передававшей за последние сутки данные с датчиков топлива: ''||to_char(l_daily_qty)
                             ||''<br>Кол-во техники, передававшей данные с датчиков топлива ранее: ''             ||to_char(l_early_qty)
    , p_system_code       => ''MTK''
    , p_subject_area_code => ''DAILY_REPORT_SENSOR''
    , p_as_html           => 1
    );
end;
'
      ,comments        => 'Ежедневная статистика по датчикам топлива.'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.REPORT_SENSOR'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.REPORT_SENSOR'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.REPORT_SENSOR'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.REPORT_SENSOR'
     ,attribute => 'MAX_RUNS');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.REPORT_SENSOR'
     ,attribute => 'STOP_ON_WINDOW_CLOSE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.REPORT_SENSOR'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.REPORT_SENSOR'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.REPORT_SENSOR'
     ,attribute => 'AUTO_DROP'
     ,value     => TRUE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'MTK.REPORT_SENSOR');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'MTK.REQUEST_OPER');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'MTK.REQUEST_OPER'
      ,start_date      => TO_TIMESTAMP_TZ('2015/08/13 00:00:00.000000 +03:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=DAILY;INTERVAL=1;BYHOUR=0;BYMINUTE=5'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => '
begin
 fdc_request_pck.generate(p_target_date => trunc(sysdate));
 commit;
 fdc_refresh_mview_daily;
end;
'
      ,comments        => 'Смена статусов операций на администрирование реестра техники'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.REQUEST_OPER'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.REQUEST_OPER'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.REQUEST_OPER'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.REQUEST_OPER'
     ,attribute => 'MAX_RUNS');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.REQUEST_OPER'
     ,attribute => 'STOP_ON_WINDOW_CLOSE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.REQUEST_OPER'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.REQUEST_OPER'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.REQUEST_OPER'
     ,attribute => 'AUTO_DROP'
     ,value     => TRUE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'MTK.REQUEST_OPER');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'MTK.SYSTEM_STATS');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'MTK.SYSTEM_STATS'
      ,start_date      => TO_TIMESTAMP_TZ('2014/11/14 00:00:00.000000 +03:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=DAILY;INTERVAL=1;BYHOUR=6;BYMINUTE=0'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => '
begin
  fdc_mlr_sbn_mailer_pck.add_email_queue
    ( p_subject           => ''Статистика работы модуля телеметрического контроля за ''||to_char(sysdate,''dd.mm.yyyy'')
    , p_text              => fdc_get_system_stat(sysdate-1)
    , p_as_html           => const.c_true
    , p_system_code       => ''MTK''
    , p_subject_area_code => ''SYS_STATS''
    );
  commit;
exception
  when others then
    fdc_mlr_sbn_mailer_pck.add_email_queue
      ( p_subject           => ''Ошибка в работе модуля телеметрического контроля''
      , p_text              => ''Ошибка в работе задания SYSTEM_STATS ''
                               ||to_char(sysdate,''dd.mm.yyyy hh24:mi:ss'')||chr(10)||get_error_trace
      , p_system_code       => ''MTK''
      , p_subject_area_code => ''COMMON_ERR''
      );
    commit;
    raise;
end;
'
      ,comments        => 'Статистика работы модуля телеметрического контроля.'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.SYSTEM_STATS'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.SYSTEM_STATS'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.SYSTEM_STATS'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.SYSTEM_STATS'
     ,attribute => 'MAX_RUNS');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.SYSTEM_STATS'
     ,attribute => 'STOP_ON_WINDOW_CLOSE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.SYSTEM_STATS'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.SYSTEM_STATS'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.SYSTEM_STATS'
     ,attribute => 'AUTO_DROP'
     ,value     => TRUE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'MTK.SYSTEM_STATS');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'MTK.VIOLATION');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'MTK.VIOLATION'
      ,start_date      => TO_TIMESTAMP_TZ('2015/06/03 00:00:00.000000 +03:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=DAILY;INTERVAL=1;BYHOUR=10;BYMINUTE=0'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => '
declare
  l_date_from date;
  l_date_to date := trunc(sysdate-1);
begin
  execute immediate
    ''alter session set nls_territory = ''''russia'''''';

  l_date_from :=
    trunc( l_date_to
         , case
             when to_char(sysdate, ''dd'') = 1 then ''mm''
             when to_char(sysdate, ''d'')  = 1 then ''iw''
                                             else ''dd''
           end
         );

  for c in
  (
    select l_date_from + rownum - 1 target_date
      from dual connect by level <= l_date_to - l_date_from + 1
     order by target_date desc
  )
  loop
    dbms_application_info.set_action
      ( ''VIOLATION(''||to_char(c.target_date, ''yyyymmdd'')||'')''
      );
    fdc_violation_pck.generate(c.target_date);
  end loop;

end;
'
      ,comments        => 'Формирование нарушений по данным телеметрии.'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.VIOLATION'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.VIOLATION'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.VIOLATION'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.VIOLATION'
     ,attribute => 'MAX_RUNS');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.VIOLATION'
     ,attribute => 'STOP_ON_WINDOW_CLOSE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.VIOLATION'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.VIOLATION'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.VIOLATION'
     ,attribute => 'AUTO_DROP'
     ,value     => TRUE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'MTK.VIOLATION');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'MTK.WST_DUMP');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'MTK.WST_DUMP'
      ,start_date      => TO_TIMESTAMP_TZ('2014/11/14 00:00:00.000000 +03:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=Weekly;INTERVAL=1;ByDay=Mon;BYHOUR=6;BYMINUTE=0'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => '
begin
  fdc_load_rep_pck.generate_dump(trunc(sysdate));
end;
'
      ,comments        => 'Формирование ежедневной отчетности.'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.WST_DUMP'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.WST_DUMP'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.WST_DUMP'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.WST_DUMP'
     ,attribute => 'MAX_RUNS');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.WST_DUMP'
     ,attribute => 'STOP_ON_WINDOW_CLOSE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.WST_DUMP'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.WST_DUMP'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.WST_DUMP'
     ,attribute => 'AUTO_DROP'
     ,value     => TRUE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'MTK.WST_DUMP');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'MTK.WST_VIOLATION');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'MTK.WST_VIOLATION'
      ,start_date      => TO_TIMESTAMP_TZ('2015/06/04 00:00:00.000000 +03:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=DAILY;INTERVAL=1;BYHOUR=10;BYMINUTE=0'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => '
begin
  execute immediate
    ''alter session set nls_territory = ''''russia'''''';

  fdc_wst_violation_pck.generate;
end;
'
      ,comments        => 'Формирование нарушений по данным телеметрии.'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.WST_VIOLATION'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.WST_VIOLATION'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.WST_VIOLATION'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.WST_VIOLATION'
     ,attribute => 'MAX_RUNS');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.WST_VIOLATION'
     ,attribute => 'STOP_ON_WINDOW_CLOSE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.WST_VIOLATION'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'MTK.WST_VIOLATION'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'MTK.WST_VIOLATION'
     ,attribute => 'AUTO_DROP'
     ,value     => TRUE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'MTK.WST_VIOLATION');
END;
/
