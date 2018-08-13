BEGIN
  SYS.DBMS_SCHEDULER.DROP_SCHEDULE
    (schedule_name  => 'BBD.SCH_REFRESH_MVIEW_HOURLY');
END;
/

BEGIN
  SYS.DBMS_SCHEDULER.CREATE_SCHEDULE
    (
      schedule_name    => 'BBD.SCH_REFRESH_MVIEW_HOURLY'
     ,start_date       => TO_TIMESTAMP_TZ('2013/06/17 20:33:27.234798 Europe/Moscow','yyyy/mm/dd hh24:mi:ss.ff tzr')
     ,repeat_interval  => 'FREQ=HOURLY; INTERVAL=1; BYMINUTE=30'
     ,end_date         => TO_TIMESTAMP_TZ('2014/06/17 20:33:27.234842 Europe/Moscow','yyyy/mm/dd hh24:mi:ss.ff tzr')
     ,comments         => 'Ежечасное обновление представлений.'
    );
END;
/




BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'BBD.DROP_EXPIRED_CAR_REG');
END;
/

BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'BBD.DROP_EXPIRED_CAR_REG'
      ,start_date      => TO_TIMESTAMP_TZ('2017/02/22 07:10:48.558728 Europe/Moscow','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=DAILY;INTERVAL=1;BYHOUR=2;BYMINUTE=15'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin execute immediate ''lock table FDC_CAR_REG_TMP in exclusive mode wait 500''; execute immediate ''truncate table FDC_CAR_REG_TMP''; execute immediate ''lock table FDC_CAR_STAT_HIST in exclusive mode wait 100''; execute immediate ''truncate table FDC_CAR_STAT_HIST''; end;'
      ,comments        => 'Удаление предварительно построенных реестров техники(которые используются в карте)'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.DROP_EXPIRED_CAR_REG'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.DROP_EXPIRED_CAR_REG'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BBD.DROP_EXPIRED_CAR_REG'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BBD.DROP_EXPIRED_CAR_REG'
     ,attribute => 'MAX_RUNS');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.DROP_EXPIRED_CAR_REG'
     ,attribute => 'STOP_ON_WINDOW_CLOSE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.DROP_EXPIRED_CAR_REG'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BBD.DROP_EXPIRED_CAR_REG'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.DROP_EXPIRED_CAR_REG'
     ,attribute => 'AUTO_DROP'
     ,value     => TRUE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'BBD.DROP_EXPIRED_CAR_REG');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'BBD.LOAD_DELETE_OT_COMMAND');
END;
/

BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'BBD.LOAD_DELETE_OT_COMMAND'
      ,start_date      => TO_TIMESTAMP_TZ('2017/07/05 00:02:00.000000 +03:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'Freq=daily;Interval=1;ByHour=01;ByMinute=30'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'BEGIN FDC_STAT_CAFAP_PCK.DELETE_OLD_BLOCKS; END;'
      ,comments        => 'Выполняет подготовка команд удаления для таблицы FDC_OT_DATABLOCK'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.LOAD_DELETE_OT_COMMAND'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.LOAD_DELETE_OT_COMMAND'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BBD.LOAD_DELETE_OT_COMMAND'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BBD.LOAD_DELETE_OT_COMMAND'
     ,attribute => 'MAX_RUNS');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.LOAD_DELETE_OT_COMMAND'
     ,attribute => 'STOP_ON_WINDOW_CLOSE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.LOAD_DELETE_OT_COMMAND'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BBD.LOAD_DELETE_OT_COMMAND'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.LOAD_DELETE_OT_COMMAND'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'BBD.LOAD_DELETE_OT_COMMAND');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'BBD.RECALC_OLD_DATA');
END;
/

BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'BBD.RECALC_OLD_DATA'
      ,start_date      => TO_TIMESTAMP_TZ('2016/10/31 00:03:00.000000 +03:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'freq=daily;interval=1;BYHOUR=03;byminute=00'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'BEGIN
				   FOR i
				      IN (    SELECT TRUNC (SYSDATE) - 2 + LEVEL - 1 AS date$
			                FROM DUAL
				          CONNECT BY TRUNC (SYSDATE) - 2 + LEVEL - 1 <= TRUNC (SYSDATE) - 1
			            ORDER BY 1 DESC)
				   LOOP
					fdc_mn_refresh(p_date => i.date$);
				   END LOOP;
			    END;'
      ,comments        => 'Выполняет пересчет данных для страницы сводной информации за два предыдущих дня'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.RECALC_OLD_DATA'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.RECALC_OLD_DATA'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BBD.RECALC_OLD_DATA'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BBD.RECALC_OLD_DATA'
     ,attribute => 'MAX_RUNS');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.RECALC_OLD_DATA'
     ,attribute => 'STOP_ON_WINDOW_CLOSE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.RECALC_OLD_DATA'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BBD.RECALC_OLD_DATA'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.RECALC_OLD_DATA'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'BBD.RECALC_OLD_DATA');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'BBD.REFRESH_ACTIVE_CAR');
END;
/

BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'BBD.REFRESH_ACTIVE_CAR'
      ,start_date      => TO_TIMESTAMP_TZ('2016/12/20 21:01:14.000000 +03:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'freq=secondly;interval=40;BYHOUR=00,03,04,05,06,07,08,09,10,11,12,13,14,15,16,17,18,19,20,21,22,23;'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin fdc_map_pck.refresh_active_car_job; end;'
      ,comments        => 'Выполняет кэширование количества активной техники для отображения на клиенте'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.REFRESH_ACTIVE_CAR'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.REFRESH_ACTIVE_CAR'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.REFRESH_ACTIVE_CAR'
     ,attribute => 'MAX_FAILURES'
     ,value     => 10);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BBD.REFRESH_ACTIVE_CAR'
     ,attribute => 'MAX_RUNS');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.REFRESH_ACTIVE_CAR'
     ,attribute => 'STOP_ON_WINDOW_CLOSE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.REFRESH_ACTIVE_CAR'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BBD.REFRESH_ACTIVE_CAR'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.REFRESH_ACTIVE_CAR'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'BBD.REFRESH_ACTIVE_CAR');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'BBD.REFRESH_AGGR_TILES');
END;
/

BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'BBD.REFRESH_AGGR_TILES'
      ,start_date      => TO_TIMESTAMP_TZ('2016/10/14 16:02:00.000000 +03:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'freq=minutely;interval=15;BYHOUR=00,02,03,04,05,06,07,08,09,10,11,12,13,14,15,16,17,18,19,20,21,22,23;'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin fdc_refresh_aggr_tiles; end;'
      ,comments        => 'Выполняет обновление данных тайлов агрегатора'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.REFRESH_AGGR_TILES'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.REFRESH_AGGR_TILES'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BBD.REFRESH_AGGR_TILES'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BBD.REFRESH_AGGR_TILES'
     ,attribute => 'MAX_RUNS');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.REFRESH_AGGR_TILES'
     ,attribute => 'STOP_ON_WINDOW_CLOSE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.REFRESH_AGGR_TILES'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BBD.REFRESH_AGGR_TILES'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.REFRESH_AGGR_TILES'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'BBD.REFRESH_CAFAP_AGGDATA');
END;
/

BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'BBD.REFRESH_CAFAP_AGGDATA'
      ,start_date      => TO_TIMESTAMP_TZ('2017/09/01 00:02:00.000000 +03:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'Freq=daily;Interval=1;ByHour=01;ByMinute=00'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'BEGIN fdc_stat_cafap_pck; END;'
      ,comments        => 'Выполняется подготовка агрегированных данных за день для ЦАФАП'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.REFRESH_CAFAP_AGGDATA'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.REFRESH_CAFAP_AGGDATA'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BBD.REFRESH_CAFAP_AGGDATA'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BBD.REFRESH_CAFAP_AGGDATA'
     ,attribute => 'MAX_RUNS');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.REFRESH_CAFAP_AGGDATA'
     ,attribute => 'STOP_ON_WINDOW_CLOSE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.REFRESH_CAFAP_AGGDATA'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BBD.REFRESH_CAFAP_AGGDATA'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.REFRESH_CAFAP_AGGDATA'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'BBD.REFRESH_CAFAP_AGGDATA');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'BBD.REFRESH_CAR_TILES');
END;
/

BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'BBD.REFRESH_CAR_TILES'
      ,start_date      => TO_TIMESTAMP_TZ('2016/10/14 16:02:00.000000 +03:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'freq=minutely;interval=15;BYHOUR=00,03,04,05,06,07,08,09,10,11,12,13,14,15,16,17,18,19,20,21,22,23;'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin fdc_refresh_car_tiles; end;'
      ,comments        => 'Выполняет обновление данных тайлов техники'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.REFRESH_CAR_TILES'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.REFRESH_CAR_TILES'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BBD.REFRESH_CAR_TILES'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BBD.REFRESH_CAR_TILES'
     ,attribute => 'MAX_RUNS');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.REFRESH_CAR_TILES'
     ,attribute => 'STOP_ON_WINDOW_CLOSE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.REFRESH_CAR_TILES'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BBD.REFRESH_CAR_TILES'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.REFRESH_CAR_TILES'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'BBD.REFRESH_CAR_TILES');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'BBD.REFRESH_CONTROL');
END;
/

BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'BBD.REFRESH_CONTROL'
      ,start_date      => TO_TIMESTAMP_TZ('2017/04/14 18:09:22.000000 +03:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'freq=minutely;interval=5;BYHOUR=00,03,04,05,06,07,08,09,10,11,12,13,14,15,16,17,18,19,20,21,22,23;'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'DECLARE
   l_db_name   VARCHAR2 (30 CHAR)
                  := UPPER (SYS_CONTEXT (''USERENV'', ''DB_UNIQUE_NAME''));
BEGIN
   FOR i
      IN (SELECT last_start_date,job_name
            FROM user_scheduler_jobs
           WHERE     job_name in ( ''REFRESH_ODH_TILES'',''REFRESH_CAR_TILES'',''REFRESH_YARD_TILES'')
                 AND SYSTIMESTAMP - last_start_date > INTERVAL ''25'' MINUTE
                 AND not(sysdate between trunc(sysdate) + 1/24 AND trunc(sysdate) + 5/24 + 30/24/60)
         )
   LOOP
      fdc_mlr_sbn_mailer_pck.add_email_queue (
         p_subject             =>    ''Задержка в работе панэли мэра (''
                                  || l_db_name
                                  || '')'',
         p_text                =>    ''Задание  ''||i.job_name||'' в последний раз запускалось в ''
                                  || TO_CHAR (i.last_start_date,
                                              ''dd.mm.yyyy hh24:mi:ss'')
                                  || CHR (10)
                                  || ''Время формирования сообщения: ''
                                  || TO_CHAR (SYSDATE, ''dd.mm.yyyy hh24:mi:ss''),
         p_system_code         => ''BBD'',
         p_subject_area_code   => ''COMMON_ERR'');
   END LOOP;
END;'
      ,comments        => 'Статистика работы модуля телеметрического контроля.'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.REFRESH_CONTROL'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.REFRESH_CONTROL'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BBD.REFRESH_CONTROL'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BBD.REFRESH_CONTROL'
     ,attribute => 'MAX_RUNS');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.REFRESH_CONTROL'
     ,attribute => 'STOP_ON_WINDOW_CLOSE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.REFRESH_CONTROL'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BBD.REFRESH_CONTROL'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.REFRESH_CONTROL'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'BBD.REFRESH_CONTROL');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'BBD.REFRESH_ODH_TILES');
END;
/

BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'BBD.REFRESH_ODH_TILES'
      ,start_date      => TO_TIMESTAMP_TZ('2016/10/14 16:02:00.000000 +03:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'freq=minutely;interval=15;BYHOUR=00,03,04,05,06,07,08,09,10,11,12,13,14,15,16,17,18,19,20,21,22,23;'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin fdc_refresh_odh_tiles; end;'
      ,comments        => 'Выполняет обновление данных тайлов по посещению/ТО на ОДХ'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.REFRESH_ODH_TILES'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.REFRESH_ODH_TILES'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BBD.REFRESH_ODH_TILES'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BBD.REFRESH_ODH_TILES'
     ,attribute => 'MAX_RUNS');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.REFRESH_ODH_TILES'
     ,attribute => 'STOP_ON_WINDOW_CLOSE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.REFRESH_ODH_TILES'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BBD.REFRESH_ODH_TILES'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.REFRESH_ODH_TILES'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'BBD.REFRESH_ODH_TILES');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'BBD.REFRESH_WST_PROCESS_DYN');
END;
/

BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'BBD.REFRESH_WST_PROCESS_DYN'
      ,start_date      => TO_TIMESTAMP_TZ('2015/03/23 00:00:00.000000 +03:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'freq=minutely;interval=5;'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin fdc_wst_clean_pck.refresh_process_dyn; end;'
      ,comments        => 'Выполняет обновление fdc_wst_process_dyn_mv'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.REFRESH_WST_PROCESS_DYN'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.REFRESH_WST_PROCESS_DYN'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BBD.REFRESH_WST_PROCESS_DYN'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BBD.REFRESH_WST_PROCESS_DYN'
     ,attribute => 'MAX_RUNS');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.REFRESH_WST_PROCESS_DYN'
     ,attribute => 'STOP_ON_WINDOW_CLOSE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.REFRESH_WST_PROCESS_DYN'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BBD.REFRESH_WST_PROCESS_DYN'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.REFRESH_WST_PROCESS_DYN'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'BBD.REFRESH_WST_PROCESS_DYN');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'BBD.REFRESH_WST_PROCESS_DYN_N');
END;
/

BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'BBD.REFRESH_WST_PROCESS_DYN_N'
      ,start_date      => TO_TIMESTAMP_TZ('2015/10/27 17:00:00.000000 +03:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'freq=minutely;interval=5;'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin fdc_wst_clean_pck.refresh_process_dyn_n; end;'
      ,comments        => 'Выполняет обновление fdc_wst_process_dyn_n_mv'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.REFRESH_WST_PROCESS_DYN_N'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.REFRESH_WST_PROCESS_DYN_N'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BBD.REFRESH_WST_PROCESS_DYN_N'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BBD.REFRESH_WST_PROCESS_DYN_N'
     ,attribute => 'MAX_RUNS');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.REFRESH_WST_PROCESS_DYN_N'
     ,attribute => 'STOP_ON_WINDOW_CLOSE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.REFRESH_WST_PROCESS_DYN_N'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BBD.REFRESH_WST_PROCESS_DYN_N'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.REFRESH_WST_PROCESS_DYN_N'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'BBD.REFRESH_WST_PROCESS_DYN_N');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'BBD.REFRESH_YARD_AREA');
END;
/

BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'BBD.REFRESH_YARD_AREA'
      ,start_date      => TO_TIMESTAMP_TZ('2015/02/18 20:00:00.000000 +03:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'freq=hourly;interval=4;'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin fdc_yard_clean_pck.refresh_yard_area; end;'
      ,comments        => 'Выполняет обновление refresh_yard_area'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.REFRESH_YARD_AREA'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.REFRESH_YARD_AREA'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BBD.REFRESH_YARD_AREA'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BBD.REFRESH_YARD_AREA'
     ,attribute => 'MAX_RUNS');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.REFRESH_YARD_AREA'
     ,attribute => 'STOP_ON_WINDOW_CLOSE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.REFRESH_YARD_AREA'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BBD.REFRESH_YARD_AREA'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.REFRESH_YARD_AREA'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'BBD.REFRESH_YARD_AREA');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'BBD.REFRESH_YARD_CHARACTERISTIC');
END;
/

BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'BBD.REFRESH_YARD_CHARACTERISTIC'
      ,start_date      => TO_TIMESTAMP_TZ('2015/02/18 20:00:00.000000 +03:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'freq=hourly;interval=4;'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin fdc_yard_title_pck.refresh_yard_characteristic; end;'
      ,comments        => 'Выполняет обновление fdc_yard_characteristic_mv'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.REFRESH_YARD_CHARACTERISTIC'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.REFRESH_YARD_CHARACTERISTIC'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BBD.REFRESH_YARD_CHARACTERISTIC'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BBD.REFRESH_YARD_CHARACTERISTIC'
     ,attribute => 'MAX_RUNS');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.REFRESH_YARD_CHARACTERISTIC'
     ,attribute => 'STOP_ON_WINDOW_CLOSE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.REFRESH_YARD_CHARACTERISTIC'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BBD.REFRESH_YARD_CHARACTERISTIC'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.REFRESH_YARD_CHARACTERISTIC'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'BBD.REFRESH_YARD_CHARACTERISTIC');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'BBD.REFRESH_YARD_TILES');
END;
/

BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'BBD.REFRESH_YARD_TILES'
      ,start_date      => TO_TIMESTAMP_TZ('2016/10/14 16:02:00.000000 +03:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'freq=minutely;interval=15;BYHOUR=00,03,04,05,06,07,08,09,10,11,12,13,14,15,16,17,18,19,20,21,22,23;'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin fdc_refresh_yard_tiles; end;'
      ,comments        => 'Выполняет обновление данных тайлов по посещению/ТО на ДТ'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.REFRESH_YARD_TILES'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.REFRESH_YARD_TILES'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BBD.REFRESH_YARD_TILES'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BBD.REFRESH_YARD_TILES'
     ,attribute => 'MAX_RUNS');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.REFRESH_YARD_TILES'
     ,attribute => 'STOP_ON_WINDOW_CLOSE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.REFRESH_YARD_TILES'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BBD.REFRESH_YARD_TILES'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BBD.REFRESH_YARD_TILES'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'BBD.REFRESH_YARD_TILES');
END;
/

