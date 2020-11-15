SELECT 'Section A.' AS 'INDICATOR',
     '' as '0-11yrs - M',
     '' as  '0-11yrs - F',
     '' AS '12-17yrs - M',
     '' AS '12-17yrs - F',
     '' AS '18-49yrs - M',
     '' AS '18-49yrs - F',
     '' AS '50+yrs - M',
     '' AS '50+yrs - F',
     '' AS 'TOTAL - M',
     '' AS 'TOTAL - F',
     '' AS 'Grand Total'

  UNION ALL

SELECT 'Number of Rape Survivors' AS 'INDICATOR',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 11 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) as '0-11yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 11 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) as  '0-11yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 12 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 17 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) AS '12-17yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 12 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 17 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) AS '12-17yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 18 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 49 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) AS '18-49yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 18 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 49 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) AS '18-49yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 50 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) AS '50+yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 50 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) AS '50+yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(  sgbv_val.gender = 'M', 1, 0))) AS 'TOTAL - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(  sgbv_val.gender = 'F', 1, 0)))AS 'TOTAL - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(  sgbv_val.encounter_id IS NOT NULL, 1, 0))) AS 'Grand Total'

FROM
  (SELECT DISTINCT
     encounter.encounter_id AS encounter_id,
     o.obs_id         AS obs_id,
     o.voided         AS voided,
     o.obs_datetime   AS obs_datetime,
     v.date_started   AS visit_date,
     p.patient_id     AS patient_id,
     person.birthdate AS birthdate,
     person.gender,
     p.date_created   AS first_visit_date
   FROM encounter
     INNER JOIN visit v ON encounter.visit_id = v.visit_id
     INNER JOIN obs o ON encounter.encounter_id = o.encounter_id
                         AND DATE(o.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
                         AND o.voided = 0
     INNER JOIN concept c ON o.value_coded = c.concept_id
     INNER JOIN concept_view cv ON c.concept_id = cv.concept_id
                                   AND cv.concept_full_name="Rape"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
   GROUP BY encounter_id
  ) AS sgbv_val

  UNION ALL

SELECT 'Number presenting within 72 hours' AS 'INDICATOR',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 11 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) as '0-11yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 11 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) as  '0-11yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 12 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 17 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) AS '12-17yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 12 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 17 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) AS '12-17yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 18 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 49 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) AS '18-49yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 18 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 49 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) AS '18-49yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 50 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) AS '50+yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 50 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) AS '50+yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(  sgbv_val.gender = 'M', 1, 0))) AS 'TOTAL - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(  sgbv_val.gender = 'F', 1, 0)))AS 'TOTAL - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(  sgbv_val.encounter_id IS NOT NULL, 1, 0))) AS 'Grand Total'

FROM
  (SELECT DISTINCT
     encounter.encounter_id AS encounter_id,
     o.obs_id         AS obs_id,
     o.voided         AS voided,
     o.obs_datetime   AS obs_datetime,
     v.date_started   AS visit_date,
     p.patient_id     AS patient_id,
     person.birthdate AS birthdate,
     person.gender,
     p.date_created   AS first_visit_date
   FROM encounter
     INNER JOIN visit v ON encounter.visit_id = v.visit_id
     INNER JOIN obs o ON encounter.encounter_id = o.encounter_id
                         AND DATE(o.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
                         AND o.voided = 0
     INNER JOIN concept c ON o.value_coded = c.concept_id
     INNER JOIN concept_view cv ON c.concept_id = cv.concept_id
                                   AND cv.concept_full_name="Presented within 72 hours"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
   GROUP BY encounter_id
  ) AS sgbv_val

  UNION ALL

SELECT 'Number Initiated PEP' AS 'INDICATOR',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 11 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) as '0-11yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 11 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) as  '0-11yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 12 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 17 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) AS '12-17yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 12 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 17 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) AS '12-17yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 18 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 49 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) AS '18-49yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 18 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 49 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) AS '18-49yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 50 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) AS '50+yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 50 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) AS '50+yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(  sgbv_val.gender = 'M', 1, 0))) AS 'TOTAL - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(  sgbv_val.gender = 'F', 1, 0)))AS 'TOTAL - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(  sgbv_val.encounter_id IS NOT NULL, 1, 0))) AS 'Grand Total'

FROM
  (SELECT DISTINCT
     encounter.encounter_id AS encounter_id,
     o.obs_id         AS obs_id,
     o.voided         AS voided,
     o.obs_datetime   AS obs_datetime,
     v.date_started   AS visit_date,
     p.patient_id     AS patient_id,
     person.birthdate AS birthdate,
     person.gender,
     p.date_created   AS first_visit_date
   FROM encounter
     INNER JOIN visit v ON encounter.visit_id = v.visit_id
     INNER JOIN obs o ON encounter.encounter_id = o.encounter_id
                         AND DATE(o.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
                         AND o.voided = 0
     INNER JOIN concept c ON o.value_coded = c.concept_id
     INNER JOIN concept_view cv ON c.concept_id = cv.concept_id
                                   AND cv.concept_full_name=""
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
   GROUP BY encounter_id
  ) AS sgbv_val

  UNION ALL

SELECT 'Number given STI treatment' AS 'INDICATOR',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 11 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) as '0-11yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 11 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) as  '0-11yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 12 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 17 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) AS '12-17yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 12 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 17 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) AS '12-17yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 18 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 49 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) AS '18-49yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 18 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 49 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) AS '18-49yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 50 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) AS '50+yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 50 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) AS '50+yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(  sgbv_val.gender = 'M', 1, 0))) AS 'TOTAL - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(  sgbv_val.gender = 'F', 1, 0)))AS 'TOTAL - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(  sgbv_val.encounter_id IS NOT NULL, 1, 0))) AS 'Grand Total'

FROM
  (SELECT DISTINCT
     encounter.encounter_id AS encounter_id,
     o.obs_id         AS obs_id,
     o.voided         AS voided,
     o.obs_datetime   AS obs_datetime,
     v.date_started   AS visit_date,
     p.patient_id     AS patient_id,
     person.birthdate AS birthdate,
     person.gender,
     p.date_created   AS first_visit_date
   FROM encounter
     INNER JOIN visit v ON encounter.visit_id = v.visit_id
     INNER JOIN obs o ON encounter.encounter_id = o.encounter_id
                         AND DATE(o.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
                         AND o.voided = 0
     INNER JOIN concept c ON o.value_coded = c.concept_id
     INNER JOIN concept_view cv ON c.concept_id = cv.concept_id
                                   AND cv.concept_full_name="Rape"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
   GROUP BY encounter_id
  ) AS sgbv_val

  UNION ALL

SELECT 'Number eligible for Emergency Contraceptive Pill' AS 'INDICATOR',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 11 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) as '0-11yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 11 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) as  '0-11yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 12 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 17 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) AS '12-17yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 12 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 17 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) AS '12-17yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 18 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 49 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) AS '18-49yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 18 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 49 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) AS '18-49yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 50 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) AS '50+yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 50 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) AS '50+yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(  sgbv_val.gender = 'M', 1, 0))) AS 'TOTAL - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(  sgbv_val.gender = 'F', 1, 0)))AS 'TOTAL - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(  sgbv_val.encounter_id IS NOT NULL, 1, 0))) AS 'Grand Total'

FROM
  (SELECT DISTINCT
     encounter.encounter_id AS encounter_id,
     o.obs_id         AS obs_id,
     o.voided         AS voided,
     o.obs_datetime   AS obs_datetime,
     v.date_started   AS visit_date,
     p.patient_id     AS patient_id,
     person.birthdate AS birthdate,
     person.gender,
     p.date_created   AS first_visit_date
   FROM encounter
     INNER JOIN visit v ON encounter.visit_id = v.visit_id
     INNER JOIN obs o ON encounter.encounter_id = o.encounter_id
                         AND DATE(o.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
                         AND o.voided = 0
     INNER JOIN concept c ON o.value_coded = c.concept_id
     INNER JOIN concept_view cv ON c.concept_id = cv.concept_id
                                   AND cv.concept_full_name="Rape"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
   GROUP BY encounter_id
  ) AS sgbv_val

  UNION ALL

SELECT 'Number given Emergency Contraceptive Pill' AS 'INDICATOR',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 11 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) as '0-11yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 11 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) as  '0-11yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 12 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 17 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) AS '12-17yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 12 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 17 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) AS '12-17yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 18 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 49 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) AS '18-49yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 18 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 49 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) AS '18-49yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 50 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) AS '50+yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 50 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) AS '50+yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(  sgbv_val.gender = 'M', 1, 0))) AS 'TOTAL - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(  sgbv_val.gender = 'F', 1, 0)))AS 'TOTAL - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(  sgbv_val.encounter_id IS NOT NULL, 1, 0))) AS 'Grand Total'

FROM
  (SELECT DISTINCT
     encounter.encounter_id AS encounter_id,
     o.obs_id         AS obs_id,
     o.voided         AS voided,
     o.obs_datetime   AS obs_datetime,
     v.date_started   AS visit_date,
     p.patient_id     AS patient_id,
     person.birthdate AS birthdate,
     person.gender,
     p.date_created   AS first_visit_date
   FROM encounter
     INNER JOIN visit v ON encounter.visit_id = v.visit_id
     INNER JOIN obs o ON encounter.encounter_id = o.encounter_id
                         AND DATE(o.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
                         AND o.voided = 0
     INNER JOIN concept c ON o.value_coded = c.concept_id
     INNER JOIN concept_view cv ON c.concept_id = cv.concept_id
                                   AND cv.concept_full_name="Rape"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
   GROUP BY encounter_id
  ) AS sgbv_val

  UNION ALL

SELECT 'Number tested for HIV' AS 'INDICATOR',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 11 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) as '0-11yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 11 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) as  '0-11yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 12 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 17 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) AS '12-17yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 12 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 17 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) AS '12-17yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 18 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 49 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) AS '18-49yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 18 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 49 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) AS '18-49yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 50 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) AS '50+yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 50 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) AS '50+yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(  sgbv_val.gender = 'M', 1, 0))) AS 'TOTAL - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(  sgbv_val.gender = 'F', 1, 0)))AS 'TOTAL - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(  sgbv_val.encounter_id IS NOT NULL, 1, 0))) AS 'Grand Total'

FROM
  (SELECT DISTINCT
     encounter.encounter_id AS encounter_id,
     o.obs_id         AS obs_id,
     o.voided         AS voided,
     o.obs_datetime   AS obs_datetime,
     v.date_started   AS visit_date,
     p.patient_id     AS patient_id,
     person.birthdate AS birthdate,
     person.gender,
     p.date_created   AS first_visit_date
   FROM encounter
     INNER JOIN visit v ON encounter.visit_id = v.visit_id
     INNER JOIN obs o ON encounter.encounter_id = o.encounter_id
                         AND DATE(o.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
                         AND o.voided = 0
     INNER JOIN concept c ON o.value_coded = c.concept_id
     INNER JOIN concept_view cv ON c.concept_id = cv.concept_id
                                   AND cv.concept_full_name="Rape"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
   GROUP BY encounter_id
  ) AS sgbv_val

  UNION ALL

SELECT 'Number HIV positive at first Visit' AS 'INDICATOR',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 11 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) as '0-11yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 11 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) as  '0-11yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 12 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 17 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) AS '12-17yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 12 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 17 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) AS '12-17yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 18 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 49 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) AS '18-49yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 18 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 49 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) AS '18-49yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 50 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) AS '50+yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 50 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) AS '50+yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(  sgbv_val.gender = 'M', 1, 0))) AS 'TOTAL - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(  sgbv_val.gender = 'F', 1, 0)))AS 'TOTAL - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(  sgbv_val.encounter_id IS NOT NULL, 1, 0))) AS 'Grand Total'

FROM
  (SELECT DISTINCT
     encounter.encounter_id AS encounter_id,
     o.obs_id         AS obs_id,
     o.voided         AS voided,
     o.obs_datetime   AS obs_datetime,
     v.date_started   AS visit_date,
     p.patient_id     AS patient_id,
     person.birthdate AS birthdate,
     person.gender,
     p.date_created   AS first_visit_date
   FROM encounter
     INNER JOIN visit v ON encounter.visit_id = v.visit_id
     INNER JOIN obs o ON encounter.encounter_id = o.encounter_id
                         AND DATE(o.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
                         AND o.voided = 0
     INNER JOIN concept c ON o.value_coded = c.concept_id
     INNER JOIN concept_view cv ON c.concept_id = cv.concept_id
                                   AND cv.concept_full_name="Rape"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
   GROUP BY encounter_id
  ) AS sgbv_val

  UNION ALL

SELECT 'Total Survivors with disability' AS 'INDICATOR',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 11 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) as '0-11yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 11 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) as  '0-11yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 12 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 17 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) AS '12-17yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 12 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 17 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) AS '12-17yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 18 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 49 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) AS '18-49yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 18 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 49 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) AS '18-49yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 50 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) AS '50+yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 50 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) AS '50+yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(  sgbv_val.gender = 'M', 1, 0))) AS 'TOTAL - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(  sgbv_val.gender = 'F', 1, 0)))AS 'TOTAL - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(  sgbv_val.encounter_id IS NOT NULL, 1, 0))) AS 'Grand Total'

FROM
  (SELECT DISTINCT
     encounter.encounter_id AS encounter_id,
     o.obs_id         AS obs_id,
     o.voided         AS voided,
     o.obs_datetime   AS obs_datetime,
     v.date_started   AS visit_date,
     p.patient_id     AS patient_id,
     person.birthdate AS birthdate,
     person.gender,
     p.date_created   AS first_visit_date
   FROM encounter
     INNER JOIN visit v ON encounter.visit_id = v.visit_id
     INNER JOIN obs o ON encounter.encounter_id = o.encounter_id
                         AND DATE(o.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
                         AND o.voided = 0
     INNER JOIN concept c ON o.value_coded = c.concept_id
     INNER JOIN concept_view cv ON c.concept_id = cv.concept_id
                                   AND cv.concept_full_name="Rape"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
   GROUP BY encounter_id
  ) AS sgbv_val

  UNION ALL

SELECT 'Number of perpetrators' AS 'INDICATOR',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 11 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) as '0-11yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 11 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) as  '0-11yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 12 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 17 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) AS '12-17yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 12 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 17 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) AS '12-17yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 18 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 49 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) AS '18-49yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 18 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 49 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) AS '18-49yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 50 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) AS '50+yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 50 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) AS '50+yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(  sgbv_val.gender = 'M', 1, 0))) AS 'TOTAL - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(  sgbv_val.gender = 'F', 1, 0)))AS 'TOTAL - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(  sgbv_val.encounter_id IS NOT NULL, 1, 0))) AS 'Grand Total'

FROM
  (SELECT DISTINCT
     encounter.encounter_id AS encounter_id,
     o.obs_id         AS obs_id,
     o.voided         AS voided,
     o.obs_datetime   AS obs_datetime,
     v.date_started   AS visit_date,
     p.patient_id     AS patient_id,
     person.birthdate AS birthdate,
     person.gender,
     p.date_created   AS first_visit_date
   FROM encounter
     INNER JOIN visit v ON encounter.visit_id = v.visit_id
     INNER JOIN obs o ON encounter.encounter_id = o.encounter_id
                         AND DATE(o.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
                         AND o.voided = 0
     INNER JOIN concept c ON o.value_coded = c.concept_id
     INNER JOIN concept_view cv ON c.concept_id = cv.concept_id
                                   AND cv.concept_full_name="Rape"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
   GROUP BY encounter_id
  ) AS sgbv_val

  UNION ALL

SELECT 'Total Survivors Seen' AS 'INDICATOR',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 11 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) as '0-11yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 11 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) as  '0-11yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 12 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 17 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) AS '12-17yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 12 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 17 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) AS '12-17yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 18 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 49 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) AS '18-49yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 18 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 49 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) AS '18-49yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 50 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) AS '50+yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 50 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) AS '50+yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(  sgbv_val.gender = 'M', 1, 0))) AS 'TOTAL - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(  sgbv_val.gender = 'F', 1, 0)))AS 'TOTAL - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(  sgbv_val.encounter_id IS NOT NULL, 1, 0))) AS 'Grand Total'

FROM
  (SELECT DISTINCT
     encounter.encounter_id AS encounter_id,
     o.obs_id         AS obs_id,
     o.voided         AS voided,
     o.obs_datetime   AS obs_datetime,
     v.date_started   AS visit_date,
     p.patient_id     AS patient_id,
     person.birthdate AS birthdate,
     person.gender,
     p.date_created   AS first_visit_date
   FROM encounter
     INNER JOIN visit v ON encounter.visit_id = v.visit_id
     INNER JOIN obs o ON encounter.encounter_id = o.encounter_id
                         AND DATE(o.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
                         AND o.voided = 0
     INNER JOIN concept c ON o.value_coded = c.concept_id
     INNER JOIN concept_view cv ON c.concept_id = cv.concept_id
                                   AND cv.concept_full_name="Rape"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
   GROUP BY encounter_id
  ) AS sgbv_val

UNION ALL

SELECT '' AS 'INDICATOR',
     '' as '0-11yrs - M',
     '' as  '0-11yrs - F',
     '' AS '12-17yrs - M',
     '' AS '12-17yrs - F',
     '' AS '18-49yrs - M',
     '' AS '18-49yrs - F',
     '' AS '50+yrs - M',
     '' AS '50+yrs - F',
     '' AS 'TOTAL - M',
     '' AS 'TOTAL - F',
     '' AS 'Grand Total'
UNION ALL

SELECT 'Section B.' AS 'INDICATOR',
     '' as '0-11yrs - M',
     '' as  '0-11yrs - F',
     '' AS '12-17yrs - M',
     '' AS '12-17yrs - F',
     '' AS '18-49yrs - M',
     '' AS '18-49yrs - F',
     '' AS '50+yrs - M',
     '' AS '50+yrs - F',
     '' AS 'TOTAL - M',
     '' AS 'TOTAL - F',
     '' AS 'Grand Total'
  UNION ALL

SELECT '1st Visit' AS 'INDICATOR',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 11 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) as '0-11yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 11 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) as  '0-11yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 12 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 17 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) AS '12-17yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 12 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 17 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) AS '12-17yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 18 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 49 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) AS '18-49yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 18 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 49 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) AS '18-49yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 50 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) AS '50+yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 50 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) AS '50+yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(  sgbv_val.gender = 'M', 1, 0))) AS 'TOTAL - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(  sgbv_val.gender = 'F', 1, 0)))AS 'TOTAL - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(  sgbv_val.encounter_id IS NOT NULL, 1, 0))) AS 'Grand Total'

FROM
  (SELECT DISTINCT
     encounter.encounter_id AS encounter_id,
     o.obs_id         AS obs_id,
     o.voided         AS voided,
     o.obs_datetime   AS obs_datetime,
     v.date_started   AS visit_date,
     p.patient_id     AS patient_id,
     person.birthdate AS birthdate,
     person.gender,
     p.date_created   AS first_visit_date
   FROM encounter
     INNER JOIN visit v ON encounter.visit_id = v.visit_id
     INNER JOIN obs o ON encounter.encounter_id = o.encounter_id
                         AND DATE(o.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
                         AND o.voided = 0
     INNER JOIN concept c ON o.value_coded = c.concept_id
     INNER JOIN concept_view cv ON c.concept_id = cv.concept_id
                                   AND cv.concept_full_name=""
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
   GROUP BY encounter_id
  ) AS sgbv_val

  UNION ALL

SELECT '2nd Visit' AS 'INDICATOR',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 11 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) as '0-11yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 11 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) as  '0-11yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 12 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 17 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) AS '12-17yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 12 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 17 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) AS '12-17yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 18 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 49 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) AS '18-49yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 18 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 49 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) AS '18-49yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 50 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) AS '50+yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 50 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) AS '50+yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(  sgbv_val.gender = 'M', 1, 0))) AS 'TOTAL - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(  sgbv_val.gender = 'F', 1, 0)))AS 'TOTAL - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(  sgbv_val.encounter_id IS NOT NULL, 1, 0))) AS 'Grand Total'

FROM
  (SELECT DISTINCT
     encounter.encounter_id AS encounter_id,
     o.obs_id         AS obs_id,
     o.voided         AS voided,
     o.obs_datetime   AS obs_datetime,
     v.date_started   AS visit_date,
     p.patient_id     AS patient_id,
     person.birthdate AS birthdate,
     person.gender,
     p.date_created   AS first_visit_date
   FROM encounter
     INNER JOIN visit v ON encounter.visit_id = v.visit_id
     INNER JOIN obs o ON encounter.encounter_id = o.encounter_id
                         AND DATE(o.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
                         AND o.voided = 0
     INNER JOIN concept c ON o.value_coded = c.concept_id
     INNER JOIN concept_view cv ON c.concept_id = cv.concept_id
                                   AND cv.concept_full_name=""
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
   GROUP BY encounter_id
  ) AS sgbv_val

  UNION ALL

SELECT '3rd Visit' AS 'INDICATOR',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 11 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) as '0-11yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 11 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) as  '0-11yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 12 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 17 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) AS '12-17yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 12 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 17 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) AS '12-17yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 18 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 49 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) AS '18-49yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 18 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 49 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) AS '18-49yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 50 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) AS '50+yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 50 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) AS '50+yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(  sgbv_val.gender = 'M', 1, 0))) AS 'TOTAL - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(  sgbv_val.gender = 'F', 1, 0)))AS 'TOTAL - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(  sgbv_val.encounter_id IS NOT NULL, 1, 0))) AS 'Grand Total'

FROM
  (SELECT DISTINCT
     encounter.encounter_id AS encounter_id,
     o.obs_id         AS obs_id,
     o.voided         AS voided,
     o.obs_datetime   AS obs_datetime,
     v.date_started   AS visit_date,
     p.patient_id     AS patient_id,
     person.birthdate AS birthdate,
     person.gender,
     p.date_created   AS first_visit_date
   FROM encounter
     INNER JOIN visit v ON encounter.visit_id = v.visit_id
     INNER JOIN obs o ON encounter.encounter_id = o.encounter_id
                         AND DATE(o.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
                         AND o.voided = 0
     INNER JOIN concept c ON o.value_coded = c.concept_id
     INNER JOIN concept_view cv ON c.concept_id = cv.concept_id
                                   AND cv.concept_full_name=""
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
   GROUP BY encounter_id
  ) AS sgbv_val

  UNION ALL

SELECT '4th Visit' AS 'INDICATOR',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 11 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) as '0-11yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 11 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) as  '0-11yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 12 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 17 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) AS '12-17yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 12 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 17 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) AS '12-17yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 18 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 49 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) AS '18-49yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 18 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 49 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) AS '18-49yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 50 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) AS '50+yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 50 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) AS '50+yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(  sgbv_val.gender = 'M', 1, 0))) AS 'TOTAL - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(  sgbv_val.gender = 'F', 1, 0)))AS 'TOTAL - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(  sgbv_val.encounter_id IS NOT NULL, 1, 0))) AS 'Grand Total'

FROM
  (SELECT DISTINCT
     encounter.encounter_id AS encounter_id,
     o.obs_id         AS obs_id,
     o.voided         AS voided,
     o.obs_datetime   AS obs_datetime,
     v.date_started   AS visit_date,
     p.patient_id     AS patient_id,
     person.birthdate AS birthdate,
     person.gender,
     p.date_created   AS first_visit_date
   FROM encounter
     INNER JOIN visit v ON encounter.visit_id = v.visit_id
     INNER JOIN obs o ON encounter.encounter_id = o.encounter_id
                         AND DATE(o.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
                         AND o.voided = 0
     INNER JOIN concept c ON o.value_coded = c.concept_id
     INNER JOIN concept_view cv ON c.concept_id = cv.concept_id
                                   AND cv.concept_full_name=""
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
   GROUP BY encounter_id
  ) AS sgbv_val

  UNION ALL

SELECT '5th Visit' AS 'INDICATOR',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 11 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) as '0-11yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 11 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) as  '0-11yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 12 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 17 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) AS '12-17yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 12 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 17 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) AS '12-17yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 18 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 49 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) AS '18-49yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 18 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 49 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) AS '18-49yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 50 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) AS '50+yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 50 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) AS '50+yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(  sgbv_val.gender = 'M', 1, 0))) AS 'TOTAL - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(  sgbv_val.gender = 'F', 1, 0)))AS 'TOTAL - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(  sgbv_val.encounter_id IS NOT NULL, 1, 0))) AS 'Grand Total'

FROM
  (SELECT DISTINCT
     encounter.encounter_id AS encounter_id,
     o.obs_id         AS obs_id,
     o.voided         AS voided,
     o.obs_datetime   AS obs_datetime,
     v.date_started   AS visit_date,
     p.patient_id     AS patient_id,
     person.birthdate AS birthdate,
     person.gender,
     p.date_created   AS first_visit_date
   FROM encounter
     INNER JOIN visit v ON encounter.visit_id = v.visit_id
     INNER JOIN obs o ON encounter.encounter_id = o.encounter_id
                         AND DATE(o.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
                         AND o.voided = 0
     INNER JOIN concept c ON o.value_coded = c.concept_id
     INNER JOIN concept_view cv ON c.concept_id = cv.concept_id
                                   AND cv.concept_full_name=""
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
   GROUP BY encounter_id
  ) AS sgbv_val

  UNION ALL

SELECT 'Number Completed PEP' AS 'INDICATOR',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 11 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) as '0-11yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 11 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) as  '0-11yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 12 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 17 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) AS '12-17yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 12 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 17 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) AS '12-17yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 18 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 49 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) AS '18-49yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 18 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 49 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) AS '18-49yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 50 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) AS '50+yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 50 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) AS '50+yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(  sgbv_val.gender = 'M', 1, 0))) AS 'TOTAL - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(  sgbv_val.gender = 'F', 1, 0)))AS 'TOTAL - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(  sgbv_val.encounter_id IS NOT NULL, 1, 0))) AS 'Grand Total'

FROM
  (SELECT DISTINCT
     encounter.encounter_id AS encounter_id,
     o.obs_id         AS obs_id,
     o.voided         AS voided,
     o.obs_datetime   AS obs_datetime,
     v.date_started   AS visit_date,
     p.patient_id     AS patient_id,
     person.birthdate AS birthdate,
     person.gender,
     p.date_created   AS first_visit_date
   FROM encounter
     INNER JOIN visit v ON encounter.visit_id = v.visit_id
     INNER JOIN obs o ON encounter.encounter_id = o.encounter_id
                         AND DATE(o.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
                         AND o.voided = 0
     INNER JOIN concept c ON o.value_coded = c.concept_id
     INNER JOIN concept_view cv ON c.concept_id = cv.concept_id
                                   AND cv.concept_full_name=""
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
   GROUP BY encounter_id
  ) AS sgbv_val

  UNION ALL

SELECT 'Number seroconverted' AS 'INDICATOR',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 11 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) as '0-11yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 11 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) as  '0-11yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 12 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 17 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) AS '12-17yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 12 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 17 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) AS '12-17yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 18 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 49 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) AS '18-49yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 18 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 49 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) AS '18-49yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 50 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) AS '50+yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 50 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) AS '50+yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(  sgbv_val.gender = 'M', 1, 0))) AS 'TOTAL - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(  sgbv_val.gender = 'F', 1, 0)))AS 'TOTAL - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(  sgbv_val.encounter_id IS NOT NULL, 1, 0))) AS 'Grand Total'

FROM
  (SELECT DISTINCT
     encounter.encounter_id AS encounter_id,
     o.obs_id         AS obs_id,
     o.voided         AS voided,
     o.obs_datetime   AS obs_datetime,
     v.date_started   AS visit_date,
     p.patient_id     AS patient_id,
     person.birthdate AS birthdate,
     person.gender,
     p.date_created   AS first_visit_date
   FROM encounter
     INNER JOIN visit v ON encounter.visit_id = v.visit_id
     INNER JOIN obs o ON encounter.encounter_id = o.encounter_id
                         AND DATE(o.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
                         AND o.voided = 0
     INNER JOIN concept c ON o.value_coded = c.concept_id
     INNER JOIN concept_view cv ON c.concept_id = cv.concept_id
                                   AND cv.concept_full_name=""
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
   GROUP BY encounter_id
  ) AS sgbv_val

  UNION ALL

SELECT 'Number pregnant' AS 'INDICATOR',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 11 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) as '0-11yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 11 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) as  '0-11yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 12 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 17 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) AS '12-17yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 12 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 17 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) AS '12-17yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 18 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 49 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) AS '18-49yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 18 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 49 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) AS '18-49yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 50 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) AS '50+yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 50 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) AS '50+yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(  sgbv_val.gender = 'M', 1, 0))) AS 'TOTAL - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(  sgbv_val.gender = 'F', 1, 0)))AS 'TOTAL - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(  sgbv_val.encounter_id IS NOT NULL, 1, 0))) AS 'Grand Total'

FROM
  (SELECT DISTINCT
     encounter.encounter_id AS encounter_id,
     o.obs_id         AS obs_id,
     o.voided         AS voided,
     o.obs_datetime   AS obs_datetime,
     v.date_started   AS visit_date,
     p.patient_id     AS patient_id,
     person.birthdate AS birthdate,
     person.gender,
     p.date_created   AS first_visit_date
   FROM encounter
     INNER JOIN visit v ON encounter.visit_id = v.visit_id
     INNER JOIN obs o ON encounter.encounter_id = o.encounter_id
                         AND DATE(o.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
                         AND o.voided = 0
     INNER JOIN concept c ON o.value_coded = c.concept_id
     INNER JOIN concept_view cv ON c.concept_id = cv.concept_id
                                   AND cv.concept_full_name=""
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
   GROUP BY encounter_id
  ) AS sgbv_val

  UNION ALL

SELECT 'Number Completed Trauma Counselling' AS 'INDICATOR',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 11 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) as '0-11yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 11 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) as  '0-11yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 12 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 17 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) AS '12-17yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 12 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 17 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) AS '12-17yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 18 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 49 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) AS '18-49yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 18 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 49 YEAR), INTERVAL 364 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) AS '18-49yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 50 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY)) AND  sgbv_val.gender = 'M', 1, 0))) AS '50+yrs - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(DATE(sgbv_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 50 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(sgbv_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY)) AND  sgbv_val.gender = 'F', 1, 0))) AS '50+yrs - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(  sgbv_val.gender = 'M', 1, 0))) AS 'TOTAL - M',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(  sgbv_val.gender = 'F', 1, 0)))AS 'TOTAL - F',
     IF(sgbv_val.encounter_id IS NULL, 0, SUM(IF(  sgbv_val.encounter_id IS NOT NULL, 1, 0))) AS 'Grand Total'

FROM
  (SELECT DISTINCT
     encounter.encounter_id AS encounter_id,
     o.obs_id         AS obs_id,
     o.voided         AS voided,
     o.obs_datetime   AS obs_datetime,
     v.date_started   AS visit_date,
     p.patient_id     AS patient_id,
     person.birthdate AS birthdate,
     person.gender,
     p.date_created   AS first_visit_date
   FROM encounter
     INNER JOIN visit v ON encounter.visit_id = v.visit_id
     INNER JOIN obs o ON encounter.encounter_id = o.encounter_id
                         AND DATE(o.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
                         AND o.voided = 0
     INNER JOIN concept c ON o.value_coded = c.concept_id
     INNER JOIN concept_view cv ON c.concept_id = cv.concept_id
                                   AND cv.concept_full_name=""
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
   GROUP BY encounter_id
  ) AS sgbv_val
