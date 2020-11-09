SELECT 'M.  TB SCREENING' AS 'Service',
     '' as '0-14yrs',
     '' as  '15+yrs',
     '' AS 'TOTAL'

  UNION ALL

SELECT
       '1.  Total Number oof people screened' as 'Service',
       IF(tb_val.encounter_id IS NULL, 0, SUM(IF(DATE(tb_val.date_time) BETWEEN (DATE_ADD(DATE_ADD(tb_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(tb_val.birthdate, INTERVAL 14 YEAR), INTERVAL 11 MONTH)) , 1, 0))) AS '0-14yrs',
       IF(tb_val.encounter_id IS NULL, 0, SUM(IF(DATE(tb_val.date_time) BETWEEN (DATE_ADD(DATE_ADD(tb_val.birthdate, INTERVAL 15 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(tb_val.birthdate, INTERVAL 200 YEAR), INTERVAL 12 MONTH)) , 1, 0))) AS '15+yrs',
       IF(tb_val.patient_id IS NULL, 0, SUM(IF( tb_val.patient_id IS NOT NULL, 1, 0))) AS 'TOTAL'

FROM
  (SELECT DISTINCT
     encounter.encounter_id AS encounter_id,
     o.obs_id         AS obs_id,
     o.voided         AS voided,
     o.obs_datetime   AS date_time,
     v.date_started   AS visit_date,
     p.patient_id     AS patient_id,
     person.birthdate AS birthdate,
     person.gender AS gender,
     p.date_created   AS first_visit_date
   FROM encounter
     INNER JOIN visit v ON encounter.visit_id = v.visit_id
     INNER JOIN obs o ON encounter.encounter_id = o.encounter_id
                         AND DATE(o.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
                         AND o.voided = 0
     INNER JOIN concept c ON o.concept_id = c.concept_id
     INNER JOIN concept_view cv ON c.concept_id = cv.concept_id
                                   AND cv.concept_full_name IN ("Tuberculosis Intake Template")
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
   GROUP BY p.patient_id
  ) AS tb_val

UNION ALL

SELECT
       '2.  Total Number of presumptive TB cases' as 'Service',
       IF(tb_val.encounter_id IS NULL, 0, SUM(IF(DATE(tb_val.date_time) BETWEEN (DATE_ADD(DATE_ADD(tb_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(tb_val.birthdate, INTERVAL 14 YEAR), INTERVAL 11 MONTH)) , 1, 0))) AS '0-14yrs',
       IF(tb_val.encounter_id IS NULL, 0, SUM(IF(DATE(tb_val.date_time) BETWEEN (DATE_ADD(DATE_ADD(tb_val.birthdate, INTERVAL 15 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(tb_val.birthdate, INTERVAL 200 YEAR), INTERVAL 12 MONTH)) , 1, 0))) AS '15+yrs',
       IF(tb_val.patient_id IS NULL, 0, SUM(IF( tb_val.patient_id IS NOT NULL, 1, 0))) AS 'TOTAL'

FROM
  (SELECT DISTINCT
     encounter.encounter_id AS encounter_id,
     o.obs_id         AS obs_id,
     o.voided         AS voided,
     o.obs_datetime   AS date_time,
     v.date_started   AS visit_date,
     p.patient_id     AS patient_id,
     person.birthdate AS birthdate,
     person.gender AS gender,
     p.date_created   AS first_visit_date
   FROM encounter
     INNER JOIN visit v ON encounter.visit_id = v.visit_id
     INNER JOIN obs o ON encounter.encounter_id = o.encounter_id
                         AND DATE(o.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
                         AND o.voided = 0
     INNER JOIN concept c ON o.value_coded = c.concept_id
     INNER JOIN concept_view cv ON c.concept_id = cv.concept_id
                                   AND cv.concept_full_name IN ("Tuberculosis, pulmonary, NOS")
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
   GROUP BY p.patient_id
  ) AS tb_val

UNION ALL

SELECT
  '3.  Total Number already on TB Treatment' as 'Service',
  IF(tb_val.encounter_id IS NULL, 0, SUM(IF(DATE(tb_val.date_time) BETWEEN (DATE_ADD(DATE_ADD(tb_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(tb_val.birthdate, INTERVAL 14 YEAR), INTERVAL 11 MONTH)) , 1, 0))) AS '0-14yrs',
  IF(tb_val.encounter_id IS NULL, 0, SUM(IF(DATE(tb_val.date_time) BETWEEN (DATE_ADD(DATE_ADD(tb_val.birthdate, INTERVAL 15 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(tb_val.birthdate, INTERVAL 200 YEAR), INTERVAL 12 MONTH)) , 1, 0))) AS '15+yrs',
  IF(tb_val.patient_id IS NULL, 0, SUM(IF( tb_val.patient_id IS NOT NULL, 1, 0))) AS 'TOTAL'

FROM
  (SELECT DISTINCT
     encounter.encounter_id AS encounter_id,
     o.obs_id         AS obs_id,
     o.voided         AS voided,
     o.obs_datetime   AS date_time,
     v.date_started   AS visit_date,
     p.patient_id     AS patient_id,
     person.birthdate AS birthdate,
     person.gender AS gender,
     p.date_created   AS first_visit_date
   FROM encounter
     INNER JOIN visit v ON encounter.visit_id = v.visit_id
     INNER JOIN obs o ON encounter.encounter_id = o.encounter_id
                         AND DATE(o.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
                         AND o.voided = 0
     INNER JOIN concept c ON o.value_coded = c.concept_id
     INNER JOIN concept_view cv ON c.concept_id = cv.concept_id
                                   AND cv.concept_full_name IN ("")
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
   GROUP BY p.patient_id
  ) AS tb_val

UNION ALL

SELECT
  '4.  Total Number of people not screened' as 'Service',
  IF(tb_val.encounter_id IS NULL, 0, SUM(IF(DATE(tb_val.date_time) BETWEEN (DATE_ADD(DATE_ADD(tb_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(tb_val.birthdate, INTERVAL 14 YEAR), INTERVAL 11 MONTH)) , 1, 0))) AS '0-14yrs',
  IF(tb_val.encounter_id IS NULL, 0, SUM(IF(DATE(tb_val.date_time) BETWEEN (DATE_ADD(DATE_ADD(tb_val.birthdate, INTERVAL 15 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(tb_val.birthdate, INTERVAL 200 YEAR), INTERVAL 12 MONTH)) , 1, 0))) AS '15+yrs',
  IF(tb_val.patient_id IS NULL, 0, SUM(IF( tb_val.patient_id IS NOT NULL, 1, 0))) AS 'TOTAL'

FROM
  (SELECT DISTINCT
     encounter.encounter_id AS encounter_id,
     o.obs_id         AS obs_id,
     o.voided         AS voided,
     o.obs_datetime   AS date_time,
     v.date_started   AS visit_date,
     p.patient_id     AS patient_id,
     person.birthdate AS birthdate,
     person.gender AS gender,
     p.date_created   AS first_visit_date
   FROM encounter
     INNER JOIN visit v ON encounter.visit_id = v.visit_id
     INNER JOIN obs o ON encounter.encounter_id = o.encounter_id
                         AND DATE(o.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
                         AND o.voided = 0
     INNER JOIN concept c ON o.value_coded = c.concept_id
     INNER JOIN concept_view cv ON c.concept_id = cv.concept_id
                                   AND cv.concept_full_name IN ("")
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
   GROUP BY p.patient_id
  ) AS tb_val
