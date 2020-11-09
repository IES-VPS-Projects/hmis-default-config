SELECT 'K.  PHYSIOTHERAPY SERVICE' AS 'Service',
     '' as '<25',
     '' as  '25-29yrs',
     '' AS '50+ys'

  UNION ALL

SELECT
       '1.  No. of PWDs identified and receiving physiotherapy    |   OPD' as 'Service',
       IF(physio__val.encounter_id IS NULL, 0, SUM(IF(DATE(physio__val.date_time) BETWEEN (DATE_ADD(DATE_ADD(physio__val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(physio__val.birthdate, INTERVAL 25 YEAR), INTERVAL 12 MONTH)) , 1, 0))) AS '<25',
       IF(physio__val.encounter_id IS NULL, 0, SUM(IF(DATE(physio__val.date_time) BETWEEN (DATE_ADD(DATE_ADD(physio__val.birthdate, INTERVAL 25 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(physio__val.birthdate, INTERVAL 29 YEAR), INTERVAL 12 MONTH)) , 1, 0))) AS '25-29yrs',
       IF(physio__val.encounter_id IS NULL, 0, SUM(IF(DATE(physio__val.date_time) BETWEEN (DATE_ADD(DATE_ADD(physio__val.birthdate, INTERVAL 50 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(physio__val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 MONTH)) , 1, 0))) AS '50+yrs'

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
                AND v.visit_type_id = (select visit_type_id from visit_type where name="OPD")
     INNER JOIN obs o ON encounter.encounter_id = o.encounter_id
                         AND DATE(o.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
                         AND o.voided = 0
     INNER JOIN concept c ON o.concept_id = c.concept_id
     INNER JOIN concept_view cv ON c.concept_id = cv.concept_id
                                   AND cv.concept_full_name IN ("Physiotherapy Template")
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
   GROUP BY p.patient_id
  ) AS physio__val

UNION ALL

SELECT
       '2.  No. of PWDs identified and receiving physiotherapy    |   OPD' as 'Service',
       IF(physio__val.encounter_id IS NULL, 0, SUM(IF(DATE(physio__val.date_time) BETWEEN (DATE_ADD(DATE_ADD(physio__val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(physio__val.birthdate, INTERVAL 25 YEAR), INTERVAL 12 MONTH)) , 1, 0))) AS '<25',
       IF(physio__val.encounter_id IS NULL, 0, SUM(IF(DATE(physio__val.date_time) BETWEEN (DATE_ADD(DATE_ADD(physio__val.birthdate, INTERVAL 25 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(physio__val.birthdate, INTERVAL 29 YEAR), INTERVAL 12 MONTH)) , 1, 0))) AS '25-29yrs',
       IF(physio__val.encounter_id IS NULL, 0, SUM(IF(DATE(physio__val.date_time) BETWEEN (DATE_ADD(DATE_ADD(physio__val.birthdate, INTERVAL 50 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(physio__val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 MONTH)) , 1, 0))) AS '50+yrs'

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
                AND v.visit_type_id = (select visit_type_id from visit_type where name="IPD")
     INNER JOIN obs o ON encounter.encounter_id = o.encounter_id
                         AND DATE(o.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
                         AND o.voided = 0
     INNER JOIN concept c ON o.concept_id = c.concept_id
     INNER JOIN concept_view cv ON c.concept_id = cv.concept_id
                                   AND cv.concept_full_name IN ("Physiotherapy Template")
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
   GROUP BY p.patient_id
  ) AS physio__val

  UNION ALL

SELECT
       '3.  No. of PWDs clients/patients  receiving physiotherapy    |   OPD' as 'Service',
       IF(physio__val.encounter_id IS NULL, 0, SUM(IF(DATE(physio__val.date_time) BETWEEN (DATE_ADD(DATE_ADD(physio__val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(physio__val.birthdate, INTERVAL 25 YEAR), INTERVAL 12 MONTH)) , 1, 0))) AS '<25',
       IF(physio__val.encounter_id IS NULL, 0, SUM(IF(DATE(physio__val.date_time) BETWEEN (DATE_ADD(DATE_ADD(physio__val.birthdate, INTERVAL 25 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(physio__val.birthdate, INTERVAL 29 YEAR), INTERVAL 12 MONTH)) , 1, 0))) AS '25-29yrs',
       IF(physio__val.encounter_id IS NULL, 0, SUM(IF(DATE(physio__val.date_time) BETWEEN (DATE_ADD(DATE_ADD(physio__val.birthdate, INTERVAL 50 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(physio__val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 MONTH)) , 1, 0))) AS '50+yrs'

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
                AND v.visit_type_id = (select visit_type_id from visit_type where name="OPD")
     INNER JOIN obs o ON encounter.encounter_id = o.encounter_id
                         AND DATE(o.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
                         AND o.voided = 0
     INNER JOIN concept c ON o.concept_id = c.concept_id
     INNER JOIN concept_view cv ON c.concept_id = cv.concept_id
                                   AND cv.concept_full_name IN ("Physiotherapy Template")
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
   GROUP BY p.patient_id
  ) AS physio__val

UNION ALL

SELECT
       '4.  No. of clients/patients receiving physiotherapy    |   OPD' as 'Service',
       IF(physio__val.encounter_id IS NULL, 0, SUM(IF(DATE(physio__val.date_time) BETWEEN (DATE_ADD(DATE_ADD(physio__val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(physio__val.birthdate, INTERVAL 25 YEAR), INTERVAL 12 MONTH)) , 1, 0))) AS '<25',
       IF(physio__val.encounter_id IS NULL, 0, SUM(IF(DATE(physio__val.date_time) BETWEEN (DATE_ADD(DATE_ADD(physio__val.birthdate, INTERVAL 25 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(physio__val.birthdate, INTERVAL 29 YEAR), INTERVAL 12 MONTH)) , 1, 0))) AS '25-29yrs',
       IF(physio__val.encounter_id IS NULL, 0, SUM(IF(DATE(physio__val.date_time) BETWEEN (DATE_ADD(DATE_ADD(physio__val.birthdate, INTERVAL 50 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(physio__val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 MONTH)) , 1, 0))) AS '50+yrs'

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
                AND v.visit_type_id = (select visit_type_id from visit_type where name="IPD")
     INNER JOIN obs o ON encounter.encounter_id = o.encounter_id
                         AND DATE(o.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
                         AND o.voided = 0
     INNER JOIN concept c ON o.concept_id = c.concept_id
     INNER JOIN concept_view cv ON c.concept_id = cv.concept_id
                                   AND cv.concept_full_name IN ("Physiotherapy Template")
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
   GROUP BY p.patient_id
  ) AS physio__val

UNION ALL

SELECT
       '5.  Total number of treatments ' as 'Service',
       IF(physio__val.encounter_id IS NULL, 0, SUM(IF(DATE(physio__val.date_time) BETWEEN (DATE_ADD(DATE_ADD(physio__val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(physio__val.birthdate, INTERVAL 25 YEAR), INTERVAL 12 MONTH)) , 1, 0))) AS '<25',
       IF(physio__val.encounter_id IS NULL, 0, SUM(IF(DATE(physio__val.date_time) BETWEEN (DATE_ADD(DATE_ADD(physio__val.birthdate, INTERVAL 25 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(physio__val.birthdate, INTERVAL 29 YEAR), INTERVAL 12 MONTH)) , 1, 0))) AS '25-29yrs',
       IF(physio__val.encounter_id IS NULL, 0, SUM(IF(DATE(physio__val.date_time) BETWEEN (DATE_ADD(DATE_ADD(physio__val.birthdate, INTERVAL 50 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(physio__val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 MONTH)) , 1, 0))) AS '50+yrs'

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
                                   AND cv.concept_full_name IN ("Physiotherapy Template")
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
   GROUP BY p.patient_id
  ) AS physio__val

UNION ALL

SELECT
       '6.  PWDs assessed for registration ' as 'Service',
       IF(physio__val.encounter_id IS NULL, 0, SUM(IF(DATE(physio__val.date_time) BETWEEN (DATE_ADD(DATE_ADD(physio__val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(physio__val.birthdate, INTERVAL 25 YEAR), INTERVAL 12 MONTH)) , 1, 0))) AS '<25',
       IF(physio__val.encounter_id IS NULL, 0, SUM(IF(DATE(physio__val.date_time) BETWEEN (DATE_ADD(DATE_ADD(physio__val.birthdate, INTERVAL 25 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(physio__val.birthdate, INTERVAL 29 YEAR), INTERVAL 12 MONTH)) , 1, 0))) AS '25-29yrs',
       IF(physio__val.encounter_id IS NULL, 0, SUM(IF(DATE(physio__val.date_time) BETWEEN (DATE_ADD(DATE_ADD(physio__val.birthdate, INTERVAL 50 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(physio__val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 MONTH)) , 1, 0))) AS '50+yrs'

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
                                   AND cv.concept_full_name IN ("")
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
   GROUP BY p.patient_id
  ) AS physio__val
