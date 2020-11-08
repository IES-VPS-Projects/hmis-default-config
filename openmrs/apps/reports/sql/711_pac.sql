SELECT 'E. Post Abortal Care (PAC) Services ' AS 'Service',
     ' ' as 'TOTAL'

UNION ALL

SELECT '1. No. of adolescents (10-19) receiving PAC services  ' AS 'Service',
       IF(pac_val.encounter_id IS NULL, 0, SUM(IF(pac_val.encounter_id IS NOT NULL  , 1, 0))) AS 'TOTAL'

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
                                   AND cv.concept_full_name="POst Abortal Care"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
            AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 10 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 19 YEAR), INTERVAL 0 DAY))
   GROUP BY encounter_id
  ) AS pac_val

  UNION ALL

SELECT '1. No. of youth (20-24) receiving PAC services  ' AS 'Service',
       IF(pac_val.encounter_id IS NULL, 0, SUM(IF(pac_val.encounter_id IS NOT NULL  , 1, 0))) AS 'TOTAL'

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
                                   AND cv.concept_full_name="POst Abortal Care"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
            AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 20 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 24 YEAR), INTERVAL 0 DAY))
   GROUP BY encounter_id
  ) AS pac_val

  UNION ALL

SELECT '3. No. receiving PAC services (25+ Years)   ' AS 'Service',
       IF(pac_val.encounter_id IS NULL, 0, SUM(IF(pac_val.encounter_id IS NOT NULL  , 1, 0))) AS 'TOTAL'

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
                                   AND cv.concept_full_name="POst Abortal Care"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
            AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 25 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY))
   GROUP BY encounter_id
  ) AS pac_val
