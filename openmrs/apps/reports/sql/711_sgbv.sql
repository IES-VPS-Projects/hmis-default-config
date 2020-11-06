SELECT
  'C.  SEXUAL AND GENDER BASED VIOLENCE (SGBV)' AS 'Service',
  '' AS '0-9',
  '' AS '10-17',
  '' AS '18-49',
  '' AS '50+ years'

UNION ALL

SELECT
  '1. Total SGVB Survivors seen(Rape, Attempted Rape, defilement and assault' AS 'Service',
  IF(sgvb_diagnoosis.obs_id IS NULL, 0, SUM(IF((  DATE(sgvb_diagnoosis.date_time) BETWEEN (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 9 YEAR), INTERVAL 0 DAY))  ), 1,0))) AS '0-9',
  IF(sgvb_diagnoosis.obs_id IS NULL, 0, SUM(IF((  DATE(sgvb_diagnoosis.date_time) BETWEEN (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 10 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 17 YEAR), INTERVAL 0 DAY))  ), 1,0))) AS '10-17',
  IF(sgvb_diagnoosis.obs_id IS NULL, 0, SUM(IF((  DATE(sgvb_diagnoosis.date_time) BETWEEN (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 18 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 49 YEAR), INTERVAL 0 DAY))  ), 1,0))) AS '18-49',
  IF(sgvb_diagnoosis.obs_id IS NULL, 0, SUM(IF((  DATE(sgvb_diagnoosis.date_time) BETWEEN (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 50 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY))  ), 1,0))) AS '50+ years'
FROM
  (SELECT DISTINCT
     o.obs_id         AS obs_id,
     o.voided         AS voided,
     o.obs_datetime   AS date_time,
     v.date_started   AS visit_date,
     p.patient_id     AS patient_id,
     person.birthdate AS birthdate,
     p.date_created   AS first_visit_date
   FROM encounter
     INNER JOIN visit v ON encounter.visit_id = v.visit_id
     INNER JOIN obs o ON encounter.encounter_id = o.encounter_id
                         AND DATE(o.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
                         AND o.voided = 0
     INNER JOIN concept c ON o.value_coded = c.concept_id
     INNER JOIN concept_view cv ON c.concept_id = cv.concept_id
                                   AND cv.concept_full_name IN ("Rape", "Defilement", "Sexual Assault")
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
  ) AS sgvb_diagnoosis

UNION ALL

SELECT
  '2. No of SGVB Survivors presenting within 72 hrs' AS 'Service',
  IF(sgvb_diagnoosis.obs_id IS NULL, 0, SUM(IF((  DATE(sgvb_diagnoosis.date_time) BETWEEN (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 9 YEAR), INTERVAL 0 DAY))  ), 1,0))) AS '0-9',
  IF(sgvb_diagnoosis.obs_id IS NULL, 0, SUM(IF((  DATE(sgvb_diagnoosis.date_time) BETWEEN (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 10 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 17 YEAR), INTERVAL 0 DAY))  ), 1,0))) AS '10-17',
  IF(sgvb_diagnoosis.obs_id IS NULL, 0, SUM(IF((  DATE(sgvb_diagnoosis.date_time) BETWEEN (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 18 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 49 YEAR), INTERVAL 0 DAY))  ), 1,0))) AS '18-49',
  IF(sgvb_diagnoosis.obs_id IS NULL, 0, SUM(IF((  DATE(sgvb_diagnoosis.date_time) BETWEEN (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 50 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY))  ), 1,0))) AS '50+ years'
FROM
  (SELECT DISTINCT
     o.obs_id         AS obs_id,
     o.voided         AS voided,
     o.obs_datetime   AS date_time,
     v.date_started   AS visit_date,
     p.patient_id     AS patient_id,
     person.birthdate AS birthdate,
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
  ) AS sgvb_diagnoosis

UNION ALL

SELECT
  '3. No of eligible survivors initiating PEP' AS 'Service',
  IF(sgvb_diagnoosis.obs_id IS NULL, 0, SUM(IF((  DATE(sgvb_diagnoosis.date_time) BETWEEN (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 9 YEAR), INTERVAL 0 DAY))  ), 1,0))) AS '0-9',
  IF(sgvb_diagnoosis.obs_id IS NULL, 0, SUM(IF((  DATE(sgvb_diagnoosis.date_time) BETWEEN (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 10 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 17 YEAR), INTERVAL 0 DAY))  ), 1,0))) AS '10-17',
  IF(sgvb_diagnoosis.obs_id IS NULL, 0, SUM(IF((  DATE(sgvb_diagnoosis.date_time) BETWEEN (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 18 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 49 YEAR), INTERVAL 0 DAY))  ), 1,0))) AS '18-49',
  IF(sgvb_diagnoosis.obs_id IS NULL, 0, SUM(IF((  DATE(sgvb_diagnoosis.date_time) BETWEEN (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 50 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY))  ), 1,0))) AS '50+ years'
FROM
  (SELECT DISTINCT
     o.obs_id         AS obs_id,
     o.voided         AS voided,
     o.obs_datetime   AS date_time,
     v.date_started   AS visit_date,
     p.patient_id     AS patient_id,
     person.birthdate AS birthdate,
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
  ) AS sgvb_diagnoosis

UNION ALL

SELECT
  '4. No of eligible survivors completed PEP' AS 'Service',
  IF(sgvb_diagnoosis.obs_id IS NULL, 0, SUM(IF((  DATE(sgvb_diagnoosis.date_time) BETWEEN (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 9 YEAR), INTERVAL 0 DAY))  ), 1,0))) AS '0-9',
  IF(sgvb_diagnoosis.obs_id IS NULL, 0, SUM(IF((  DATE(sgvb_diagnoosis.date_time) BETWEEN (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 10 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 17 YEAR), INTERVAL 0 DAY))  ), 1,0))) AS '10-17',
  IF(sgvb_diagnoosis.obs_id IS NULL, 0, SUM(IF((  DATE(sgvb_diagnoosis.date_time) BETWEEN (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 18 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 49 YEAR), INTERVAL 0 DAY))  ), 1,0))) AS '18-49',
  IF(sgvb_diagnoosis.obs_id IS NULL, 0, SUM(IF((  DATE(sgvb_diagnoosis.date_time) BETWEEN (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 50 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY))  ), 1,0))) AS '50+ years'
FROM
  (SELECT DISTINCT
     o.obs_id         AS obs_id,
     o.voided         AS voided,
     o.obs_datetime   AS date_time,
     v.date_started   AS visit_date,
     p.patient_id     AS patient_id,
     person.birthdate AS birthdate,
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
  ) AS sgvb_diagnoosis

UNION ALL

SELECT
  '5. No of SGBV survivors seroconverting 3 months after exposure' AS 'Service',
  IF(sgvb_diagnoosis.obs_id IS NULL, 0, SUM(IF((  DATE(sgvb_diagnoosis.date_time) BETWEEN (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 9 YEAR), INTERVAL 0 DAY))  ), 1,0))) AS '0-9',
  IF(sgvb_diagnoosis.obs_id IS NULL, 0, SUM(IF((  DATE(sgvb_diagnoosis.date_time) BETWEEN (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 10 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 17 YEAR), INTERVAL 0 DAY))  ), 1,0))) AS '10-17',
  IF(sgvb_diagnoosis.obs_id IS NULL, 0, SUM(IF((  DATE(sgvb_diagnoosis.date_time) BETWEEN (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 18 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 49 YEAR), INTERVAL 0 DAY))  ), 1,0))) AS '18-49',
  IF(sgvb_diagnoosis.obs_id IS NULL, 0, SUM(IF((  DATE(sgvb_diagnoosis.date_time) BETWEEN (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 50 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY))  ), 1,0))) AS '50+ years'
FROM
  (SELECT DISTINCT
     o.obs_id         AS obs_id,
     o.voided         AS voided,
     o.obs_datetime   AS date_time,
     v.date_started   AS visit_date,
     p.patient_id     AS patient_id,
     person.birthdate AS birthdate,
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
  ) AS sgvb_diagnoosis

UNION ALL

SELECT
  '6. No of SGBV survivors eligible for ECP' AS 'Service',
  IF(sgvb_diagnoosis.obs_id IS NULL, 0, SUM(IF((  DATE(sgvb_diagnoosis.date_time) BETWEEN (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 9 YEAR), INTERVAL 0 DAY))  ), 1,0))) AS '0-9',
  IF(sgvb_diagnoosis.obs_id IS NULL, 0, SUM(IF((  DATE(sgvb_diagnoosis.date_time) BETWEEN (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 10 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 17 YEAR), INTERVAL 0 DAY))  ), 1,0))) AS '10-17',
  IF(sgvb_diagnoosis.obs_id IS NULL, 0, SUM(IF((  DATE(sgvb_diagnoosis.date_time) BETWEEN (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 18 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 49 YEAR), INTERVAL 0 DAY))  ), 1,0))) AS '18-49',
  IF(sgvb_diagnoosis.obs_id IS NULL, 0, SUM(IF((  DATE(sgvb_diagnoosis.date_time) BETWEEN (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 50 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY))  ), 1,0))) AS '50+ years'
FROM
  (SELECT DISTINCT
     o.obs_id         AS obs_id,
     o.voided         AS voided,
     o.obs_datetime   AS date_time,
     v.date_started   AS visit_date,
     p.patient_id     AS patient_id,
     person.birthdate AS birthdate,
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
  ) AS sgvb_diagnoosis

UNION ALL

SELECT
  '7. No of eligible SGBV survivors who received ECP' AS 'Service',
  IF(sgvb_diagnoosis.obs_id IS NULL, 0, SUM(IF((  DATE(sgvb_diagnoosis.date_time) BETWEEN (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 9 YEAR), INTERVAL 0 DAY))  ), 1,0))) AS '0-9',
  IF(sgvb_diagnoosis.obs_id IS NULL, 0, SUM(IF((  DATE(sgvb_diagnoosis.date_time) BETWEEN (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 10 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 17 YEAR), INTERVAL 0 DAY))  ), 1,0))) AS '10-17',
  IF(sgvb_diagnoosis.obs_id IS NULL, 0, SUM(IF((  DATE(sgvb_diagnoosis.date_time) BETWEEN (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 18 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 49 YEAR), INTERVAL 0 DAY))  ), 1,0))) AS '18-49',
  IF(sgvb_diagnoosis.obs_id IS NULL, 0, SUM(IF((  DATE(sgvb_diagnoosis.date_time) BETWEEN (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 50 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY))  ), 1,0))) AS '50+ years'
FROM
  (SELECT DISTINCT
     o.obs_id         AS obs_id,
     o.voided         AS voided,
     o.obs_datetime   AS date_time,
     v.date_started   AS visit_date,
     p.patient_id     AS patient_id,
     person.birthdate AS birthdate,
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
  ) AS sgvb_diagnoosis

UNION ALL

SELECT
  '8. No of rape/defilement Survivors ' AS 'Service',
  IF(sgvb_diagnoosis.obs_id IS NULL, 0, SUM(IF((  DATE(sgvb_diagnoosis.date_time) BETWEEN (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 9 YEAR), INTERVAL 0 DAY))  ), 1,0))) AS '0-9',
  IF(sgvb_diagnoosis.obs_id IS NULL, 0, SUM(IF((  DATE(sgvb_diagnoosis.date_time) BETWEEN (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 10 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 17 YEAR), INTERVAL 0 DAY))  ), 1,0))) AS '10-17',
  IF(sgvb_diagnoosis.obs_id IS NULL, 0, SUM(IF((  DATE(sgvb_diagnoosis.date_time) BETWEEN (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 18 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 49 YEAR), INTERVAL 0 DAY))  ), 1,0))) AS '18-49',
  IF(sgvb_diagnoosis.obs_id IS NULL, 0, SUM(IF((  DATE(sgvb_diagnoosis.date_time) BETWEEN (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 50 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY))  ), 1,0))) AS '50+ years'
FROM
  (SELECT DISTINCT
     o.obs_id         AS obs_id,
     o.voided         AS voided,
     o.obs_datetime   AS date_time,
     v.date_started   AS visit_date,
     p.patient_id     AS patient_id,
     person.birthdate AS birthdate,
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
  ) AS sgvb_diagnoosis

UNION ALL

SELECT
  '9. No of RC/IPV clients seen' AS 'Service',
  IF(sgvb_diagnoosis.obs_id IS NULL, 0, SUM(IF((  DATE(sgvb_diagnoosis.date_time) BETWEEN (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 9 YEAR), INTERVAL 0 DAY))  ), 1,0))) AS '0-9',
  IF(sgvb_diagnoosis.obs_id IS NULL, 0, SUM(IF((  DATE(sgvb_diagnoosis.date_time) BETWEEN (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 10 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 17 YEAR), INTERVAL 0 DAY))  ), 1,0))) AS '10-17',
  IF(sgvb_diagnoosis.obs_id IS NULL, 0, SUM(IF((  DATE(sgvb_diagnoosis.date_time) BETWEEN (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 18 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 49 YEAR), INTERVAL 0 DAY))  ), 1,0))) AS '18-49',
  IF(sgvb_diagnoosis.obs_id IS NULL, 0, SUM(IF((  DATE(sgvb_diagnoosis.date_time) BETWEEN (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 50 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY))  ), 1,0))) AS '50+ years'
FROM
  (SELECT DISTINCT
     o.obs_id         AS obs_id,
     o.voided         AS voided,
     o.obs_datetime   AS date_time,
     v.date_started   AS visit_date,
     p.patient_id     AS patient_id,
     person.birthdate AS birthdate,
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
  ) AS sgvb_diagnoosis

UNION ALL

SELECT
  '10. No of survivors with disability' AS 'Service',
  IF(sgvb_diagnoosis.obs_id IS NULL, 0, SUM(IF((  DATE(sgvb_diagnoosis.date_time) BETWEEN (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 9 YEAR), INTERVAL 0 DAY))  ), 1,0))) AS '0-9',
  IF(sgvb_diagnoosis.obs_id IS NULL, 0, SUM(IF((  DATE(sgvb_diagnoosis.date_time) BETWEEN (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 10 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 17 YEAR), INTERVAL 0 DAY))  ), 1,0))) AS '10-17',
  IF(sgvb_diagnoosis.obs_id IS NULL, 0, SUM(IF((  DATE(sgvb_diagnoosis.date_time) BETWEEN (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 18 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 49 YEAR), INTERVAL 0 DAY))  ), 1,0))) AS '18-49',
  IF(sgvb_diagnoosis.obs_id IS NULL, 0, SUM(IF((  DATE(sgvb_diagnoosis.date_time) BETWEEN (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 50 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgvb_diagnoosis.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY))  ), 1,0))) AS '50+ years'
FROM
  (SELECT DISTINCT
     o.obs_id         AS obs_id,
     o.voided         AS voided,
     o.obs_datetime   AS date_time,
     v.date_started   AS visit_date,
     p.patient_id     AS patient_id,
     person.birthdate AS birthdate,
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
  ) AS sgvb_diagnoosis
