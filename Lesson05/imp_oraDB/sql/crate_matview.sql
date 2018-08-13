-- DROP MATERIALIZED VIEW BBD.FDC_ODH_PROCESS_DYN_FACT_MV;
CREATE MATERIALIZED VIEW BBD.FDC_ODH_PROCESS_DYN_FACT_MV (NIGHT,FACT_TIME,CLEAN_DISTANCE)
TABLESPACE FDC_BBD_TAB
PCTUSED    0
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
INITIAL          64K
NEXT             1M
MAXSIZE          UNLIMITED
MINEXTENTS       1
MAXEXTENTS       UNLIMITED
PCTINCREASE      0
BUFFER_POOL      DEFAULT
FLASH_CACHE      DEFAULT
CELL_FLASH_CACHE DEFAULT
)
NOCACHE
LOGGING
NOCOMPRESS
NOPARALLEL
BUILD DEFERRED
REFRESH COMPLETE ON DEMAND
WITH PRIMARY KEY
AS 
/* Formatted on 11.12.2017 10:34:12 (QP5 v5.267.14150.38573) */
SELECT reg.night,mov.tm fact_time,ROUND (SUM (mov.distance) * (1 / 0.85), 2) clean_distance
FROM (
SELECT   
  TRUNC (sm.start_date, 'HH24') + CEIL (TO_CHAR (sm.start_date, 'MI')/(SELECT fdc_odh_car_pck.get_process_dyn_group_int FROM DUAL))
  * (SELECT fdc_odh_car_pck.get_process_dyn_group_int FROM DUAL)/24/60 tm,
  sm.odh_id,
  sm.car_id,
  car.type_id,
  sm.distance
FROM fdc_mtk_sm_car_odh sm, fdc_mtk_car car
WHERE sm.target_date IN ( 
 (SELECT TRUNC ( fdc_odh_car_pck.get_process_dyn_date) - 1 FROM DUAL),
 (SELECT TRUNC ( fdc_odh_car_pck.get_process_dyn_date)    FROM DUAL)
) AND sm.start_date >= (SELECT TRUNC (fdc_odh_car_pck.get_process_dyn_date) FROM DUAL) - 1/24
  AND sm.start_date <  (SELECT TRUNC (fdc_odh_car_pck.get_process_dyn_date) + 1 FROM DUAL) - 1 / 24
  AND sm.car_id = car.id AND car.version_start_date < (SELECT   TRUNC (fdc_odh_car_pck.get_process_dyn_date) + 1 FROM DUAL)
  AND car.version_end_date >= (SELECT TRUNC (fdc_odh_car_pck.get_process_dyn_date) FROM DUAL)
  AND car.project = 1                   -- Утвержденная техника
  AND car.type_id IN ( 1 /*ПМ*/, 8 /*ТУ*/, 9 /*ПУ*/, 14 /*ПУ вакуумные*/ )
  AND ( (car.type_id IN (1) AND max_speed <= 40) -- Ограничение скрости для ПМ
         OR (car.type_id IN (8, 9, 14) AND max_speed <= 20
       ) -- Ограничение скрости для ТУ, ПУ
)
 AND sm.elapsed_time >= 0.05 -- Время нахождения на ОДХ не менее 3 секунд
 AND EXISTS (
  SELECT NULL FROM fdc_odh_contract_area_obj_mv
    WHERE  (SELECT TRUNC ( fdc_odh_car_pck.get_process_dyn_date) FROM DUAL) 
            BETWEEN version_date_from AND version_date_to
        AND (   glonass_no_check IS NULL OR glonass_no_check = 0)
        AND contract_status = 1
        AND object_id = sm.odh_id
    )
 ) mov,
(SELECT /*+ no_merge */
 ( SELECT 
      TRUNC (fdc_odh_car_pck.get_process_dyn_date) FROM DUAL) + tm date_begin -- Время начала уборки
     ,(SELECT TRUNC (fdc_odh_car_pck.get_process_dyn_date) FROM DUAL)+ tm+ duration date_end -- Время окончания уборки
     , qty qty -- Количество проходов техники по регламенту
     , night night  -- 0-Ночь, 1-День
     , type_id type_id -- Тип уборочной техники
  FROM (  
   SELECT 
    tm, duration, night, type_id, SUM (qty) qty
   FROM (-- Патрульная мойка: ПМ
     SELECT
      INTERVAL '7' HOUR tm,
      INTERVAL '16' HOUR duration,
      1 qty,
      1 night,
      1 type_id
     FROM DUAL
     UNION ALL
       -- Ночная мойка: ПМ
   SELECT INTERVAL '-1' HOUR tm,
      INTERVAL '8' HOUR duration,
     1 qty,
    0 night,
   1 type_id
     FROM DUAL
     UNION ALL
     -- Полив ОДХ(в летнее время): ПМ
     --select interval '9' hour tm, interval '9' hour duration, 1 qty, 1 night, 1 type_id from dual union all
             -- Подметание лотков: ПУ, ПУвак
         SELECT INTERVAL '7' HOUR tm,
        INTERVAL '16' HOUR duration,
       1 qty,
      1 night,
     9 type_id
       FROM DUAL
       UNION ALL
       SELECT INTERVAL '-1' HOUR tm,
  INTERVAL '8' HOUR duration,
     1 qty,
    0 night,
       9 type_id
     FROM DUAL
         UNION ALL
     SELECT INTERVAL '7' HOUR tm,
    INTERVAL '16' HOUR duration,
   1 qty,
      1 night,
     14 type_id
   FROM DUAL
   UNION ALL
   SELECT INTERVAL '-1' HOUR tm,
  INTERVAL '8' HOUR duration,
     1 qty,
        0 night,
   14 type_id
     FROM DUAL
UNION ALL
-- Прометание осевой: ПУ, ПУвак
SELECT INTERVAL '7' HOUR tm,
INTERVAL '16' HOUR duration,
1 qty,
1 night,
9 type_id
FROM DUAL
UNION ALL
SELECT INTERVAL '-1' HOUR tm,
INTERVAL '8' HOUR duration,
1 qty,
0 night,
9 type_id
FROM DUAL
UNION ALL
SELECT INTERVAL '7' HOUR tm,
INTERVAL '16' HOUR duration,
1 qty,
1 night,
14 type_id
FROM DUAL
UNION ALL
SELECT INTERVAL '-1' HOUR tm,
INTERVAL '8' HOUR duration,
1 qty,
0 night,
14 type_id
FROM DUAL
UNION ALL
-- Ночная мойка: ТУ
SELECT INTERVAL '-1' HOUR tm,
INTERVAL '8' HOUR duration,
1 qty,
0 night,
8 type_id
FROM DUAL
UNION ALL
-- Механизированное подметание (от 20 до 30% площади мехуборки): ТУ
SELECT INTERVAL '-1' HOUR tm,
INTERVAL '8' HOUR duration,
1 qty,
0 night,
8 type_id
FROM DUAL
)
GROUP BY tm, duration, night,  type_id
)
) reg
WHERE mov.tm >= reg.date_begin
AND mov.tm <= reg.date_end
AND mov.type_id = reg.type_id
GROUP BY mov.tm, reg.night;

COMMENT ON MATERIALIZED VIEW BBD.FDC_ODH_PROCESS_DYN_FACT_MV IS 'Фактические показатели для графика "Мониторинг посещения дорог коммунальной техникой по регламенту"';
COMMENT ON COLUMN BBD.FDC_ODH_PROCESS_DYN_FACT_MV.CLEAN_DISTANCE IS 'Фактически пройденная дистанция уборочной техникой по ОДХ';
COMMENT ON COLUMN BBD.FDC_ODH_PROCESS_DYN_FACT_MV.FACT_TIME IS 'Дата и время посещения(уборки) ОДХ';
COMMENT ON COLUMN BBD.FDC_ODH_PROCESS_DYN_FACT_MV.NIGHT IS '0-Ночная смена, 1-Дневная смена';

GRANT SELECT ON BBD.FDC_ODH_PROCESS_DYN_FACT_MV TO BBD_READONLY_ROLE;
GRANT SELECT ON BBD.FDC_ODH_PROCESS_DYN_FACT_MV TO DREUTSKOV;
GRANT SELECT ON BBD.FDC_ODH_PROCESS_DYN_FACT_MV TO MMIGUN;
