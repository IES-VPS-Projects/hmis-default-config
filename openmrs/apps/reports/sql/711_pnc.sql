SELECT 'E. Post Abortal Care (PAC) Services ' AS 'Service',
     ' ' as 'TOTAL'

UNION ALL

SELECT '1. No. of PNC Clients     |     New  ' AS 'Service',
       IF(pnc_val.encounter_id IS NULL, 0, SUM(IF(pnc_val.encounter_id IS NOT NULL  , 1, 0))) AS 'TOTAL'

FROM
  (SELECT DISTINCT
     encounter.encounter_id AS encounter_id,
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
     INNER JOIN concept c ON o.concept_id = c.concept_id
     INNER JOIN concept_view cv ON c.concept_id = cv.concept_id
                                   AND cv.concept_full_name="PNC"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
            AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 10 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 19 YEAR), INTERVAL 0 DAY))
   GROUP BY encounter_id
  ) AS pnc_val

  UNION ALL

SELECT '2. No. of PNC Clients     |     Revisit  ' AS 'Service',
       IF(pnc_val.encounter_id IS NULL, 0, SUM(IF(pnc_val.encounter_id IS NOT NULL  , 1, 0))) AS 'TOTAL'

FROM
  (SELECT DISTINCT
     encounter.encounter_id AS encounter_id,
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
     INNER JOIN concept c ON o.concept_id = c.concept_id
     INNER JOIN concept_view cv ON c.concept_id = cv.concept_id
                                   AND cv.concept_full_name="PNC"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
                          AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 10 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 19 YEAR), INTERVAL 0 DAY))
   GROUP BY encounter_id
  ) AS pnc_val

UNION ALL

SELECT '3. No. of women counselled on Post Partum FP' AS 'Service',
       IF(pnc_val.encounter_id IS NULL, 0, SUM(IF(pnc_val.encounter_id IS NOT NULL  , 1, 0))) AS 'TOTAL'

FROM
  (SELECT DISTINCT
     encounter.encounter_id AS encounter_id,
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
                         AND o.concept_id = (select concept_id from concept_view where concept_full_name="Counselled on Post Partum FP")
     INNER JOIN concept c ON o.value_coded = c.concept_id
     INNER JOIN concept_view cv ON c.concept_id = cv.concept_id
                                   AND cv.concept_full_name="True"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
                          AND person.gender = 'F'
   GROUP BY encounter_id
  ) AS pnc_val

UNION ALL

SELECT '4. No. of who received clients Post Partum FP' AS 'Service',
       IF(pnc_val.encounter_id IS NULL, 0, SUM(IF(pnc_val.encounter_id IS NOT NULL  , 1, 0))) AS 'TOTAL'

FROM
  (SELECT DISTINCT
     encounter.encounter_id AS encounter_id,
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
     INNER JOIN concept c ON o.concept_id = c.concept_id
     INNER JOIN concept_view cv ON c.concept_id = cv.concept_id
                                   AND cv.concept_full_name="Post Partum FP"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
   GROUP BY encounter_id
  ) AS pnc_val

UNION ALL

SELECT '5. No. of mothers received Post Partum Care   |   Within 48 Hours' AS 'Service',
       IF(pnc_val.encounter_id IS NULL, 0, SUM(IF(pnc_val.encounter_id IS NOT NULL  , 1, 0))) AS 'TOTAL'

FROM
  (SELECT DISTINCT
     encounter.encounter_id AS encounter_id,
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
     INNER JOIN concept c ON o.concept_id = c.concept_id
     INNER JOIN concept_view cv ON c.concept_id = cv.concept_id
                                   AND cv.concept_full_name=""
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
                          AND person.gender = 'F'
   GROUP BY encounter_id
  ) AS pnc_val

UNION ALL

SELECT '5. No. of mothers received Post Partum Care   |   Between 3 days - 6 Weeks' AS 'Service',
       IF(pnc_val.encounter_id IS NULL, 0, SUM(IF(pnc_val.encounter_id IS NOT NULL  , 1, 0))) AS 'TOTAL'

FROM
  (SELECT DISTINCT
     encounter.encounter_id AS encounter_id,
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
     INNER JOIN concept c ON o.concept_id = c.concept_id
     INNER JOIN concept_view cv ON c.concept_id = cv.concept_id
                                   AND cv.concept_full_name=""
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
                          AND person.gender = 'F'
   GROUP BY encounter_id
  ) AS pnc_val

UNION ALL

SELECT '5. No. of mothers received Post Partum Care   |   After 6 Weeks' AS 'Service',
       IF(pnc_val.encounter_id IS NULL, 0, SUM(IF(pnc_val.encounter_id IS NOT NULL  , 1, 0))) AS 'TOTAL'

FROM
  (SELECT DISTINCT
     encounter.encounter_id AS encounter_id,
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
     INNER JOIN concept c ON o.concept_id = c.concept_id
     INNER JOIN concept_view cv ON c.concept_id = cv.concept_id
                                   AND cv.concept_full_name=""
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
                          AND person.gender = 'F'
   GROUP BY encounter_id
  ) AS pnc_val

UNION ALL

SELECT '' AS 'Service',
       ' ' as 'TOTAL'

UNION ALL

SELECT '6. No. of Babies received Post Partum Care   |   Within 48 Hours' AS 'Service',
       IF(pnc_val.encounter_id IS NULL, 0, SUM(IF(pnc_val.encounter_id IS NOT NULL  , 1, 0))) AS 'TOTAL'

FROM
  (SELECT DISTINCT
     encounter.encounter_id AS encounter_id,
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
     INNER JOIN concept c ON o.concept_id = c.concept_id
     INNER JOIN concept_view cv ON c.concept_id = cv.concept_id
                                   AND cv.concept_full_name=""
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
                          AND person.gender = 'F'
   GROUP BY encounter_id
  ) AS pnc_val

UNION ALL

SELECT '6. No. of Babies received Post Partum Care   |   Between 3 days - 6 Weeks' AS 'Service',
       IF(pnc_val.encounter_id IS NULL, 0, SUM(IF(pnc_val.encounter_id IS NOT NULL  , 1, 0))) AS 'TOTAL'

FROM
  (SELECT DISTINCT
     encounter.encounter_id AS encounter_id,
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
     INNER JOIN concept c ON o.concept_id = c.concept_id
     INNER JOIN concept_view cv ON c.concept_id = cv.concept_id
                                   AND cv.concept_full_name=""
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
                          AND person.gender = 'F'
   GROUP BY encounter_id
  ) AS pnc_val

UNION ALL

SELECT '6. No. of Babies received Post Partum Care   |   After 6 Weeks' AS 'Service',
       IF(pnc_val.encounter_id IS NULL, 0, SUM(IF(pnc_val.encounter_id IS NOT NULL  , 1, 0))) AS 'TOTAL'

FROM
  (SELECT DISTINCT
     encounter.encounter_id AS encounter_id,
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
     INNER JOIN concept c ON o.concept_id = c.concept_id
     INNER JOIN concept_view cv ON c.concept_id = cv.concept_id
                                   AND cv.concept_full_name=""
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
                          AND person.gender = 'F'
   GROUP BY encounter_id
  ) AS pnc_val

UNION ALL

SELECT ' ' AS 'Service',
       ' ' as 'TOTAL'

UNION ALL

SELECT '7. No. of cases of fistula' AS 'Service',
       IF(pnc_val.encounter_id IS NULL, 0, SUM(IF(pnc_val.encounter_id IS NOT NULL  , 1, 0))) AS 'TOTAL'

FROM
  (SELECT DISTINCT
     encounter.encounter_id AS encounter_id,
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
                                   AND cv.concept_full_name="Anal fissure and fistula"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
   GROUP BY encounter_id
  ) AS pnc_val


UNION ALL

SELECT '8. No referred from the community to PNC' AS 'Service',
       IF(pnc_val.encounter_id IS NULL, 0, SUM(IF(pnc_val.encounter_id IS NOT NULL  , 1, 0))) AS 'TOTAL'

FROM
  (SELECT DISTINCT
     encounter.encounter_id AS encounter_id,
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
                                   AND cv.concept_full_name="Reffered from community"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
   GROUP BY encounter_id
  ) AS pnc_val
