SELECT 'F. CHILD HEALTH and NUTRITION INFORMATION SYSTEM ' AS 'Service',
     ' ' as 'Age',
     '.' as  '.',
     'F' AS 'F',
     'M' AS 'M',
     'TOTAL' AS 'TOTAL'

UNION ALL

SELECT '' AS 'Service',
     'Weight For Age ' as 'Age',
     '.' as  '.',
     'F' AS 'F',
     'M' AS 'M',
     'TOTAL' AS 'TOTAL'

UNION ALL

SELECT '1. ' AS 'Service',
       '0 - <6 months ' as 'Age',
       'Normal Weight For Age' as  '.',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'F'  , 1, 0))) AS 'F',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'M'  , 1, 0))) AS 'M',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.encounter_id IS NOT NULL , 1, 0))) AS 'TOTAL'

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
                                   AND cv.concept_full_name="Normal Weight"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
            AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 0 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 0 YEAR), INTERVAL 6 MONTH))
   GROUP BY encounter_id
  ) AS chanis_val

UNION ALL

SELECT '1. ' AS 'Service',
       '0 - <6 months ' as 'Age',
       'Underweight' as  '.',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'F'  , 1, 0))) AS 'F',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'M'  , 1, 0))) AS 'M',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.encounter_id IS NOT NULL , 1, 0))) AS 'TOTAL'

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
                                   AND cv.concept_full_name="Underweight"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
            AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 0 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 0 YEAR), INTERVAL 6 MONTH))
   GROUP BY encounter_id
  ) AS chanis_val


UNION ALL

SELECT '1. ' AS 'Service',
       '0 - <6 months ' as 'Age',
       'Severe Underweight' as  '.',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'F'  , 1, 0))) AS 'F',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'M'  , 1, 0))) AS 'M',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.encounter_id IS NOT NULL , 1, 0))) AS 'TOTAL'

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
                                   AND cv.concept_full_name="Severe Underweight"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
            AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 0 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 0 YEAR), INTERVAL 6 MONTH))
   GROUP BY encounter_id
  ) AS chanis_val

UNION ALL

SELECT '1. ' AS 'Service',
       '0 - <6 months ' as 'Age',
       'Overweight' as  '.',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'F'  , 1, 0))) AS 'F',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'M'  , 1, 0))) AS 'M',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.encounter_id IS NOT NULL , 1, 0))) AS 'TOTAL'

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
                                   AND cv.concept_full_name="Overweight"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
            AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 0 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 0 YEAR), INTERVAL 6 MONTH))
   GROUP BY encounter_id
  ) AS chanis_val

UNION ALL

SELECT '1. ' AS 'Service',
       '0 - <6 months ' as 'Age',
       'Obese' as  '.',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'F'  , 1, 0))) AS 'F',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'M'  , 1, 0))) AS 'M',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.encounter_id IS NOT NULL , 1, 0))) AS 'TOTAL'

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
                                   AND cv.concept_full_name="Obese"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
            AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 0 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 0 YEAR), INTERVAL 6 MONTH))
   GROUP BY encounter_id
  ) AS chanis_val

UNION ALL

SELECT '1. ' AS 'Service',
       '0 - <6 months ' as 'Age',
       'Total Weighed' as  '.',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'F'  , 1, 0))) AS 'F',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'M'  , 1, 0))) AS 'M',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.encounter_id IS NOT NULL , 1, 0))) AS 'TOTAL'

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
                                   AND cv.concept_full_name="Child Weight"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
            AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 0 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 0 YEAR), INTERVAL 6 MONTH))
   GROUP BY encounter_id
  ) AS chanis_val

UNION ALL
SELECT '' AS 'Service',
     ' ' as 'Age',
     '.' as  '.',
     '' AS 'F',
     '' AS 'M',
     '' AS 'TOTAL'

UNION ALL

SELECT '2. ' AS 'Service',
       '6 -23 Months ' as 'Age',
       'Normal Weight For Age' as  '.',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'F'  , 1, 0))) AS 'F',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'M'  , 1, 0))) AS 'M',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.encounter_id IS NOT NULL , 1, 0))) AS 'TOTAL'

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
                                   AND cv.concept_full_name="Normal Weight"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
            AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 0 YEAR), INTERVAL 6 MONTH )) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 1 YEAR), INTERVAL 11 MONTH))
   GROUP BY encounter_id
  ) AS chanis_val

UNION ALL

SELECT '2. ' AS 'Service',
       '6 -23 Months' as 'Age',
       'Underweight' as  '.',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'F'  , 1, 0))) AS 'F',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'M'  , 1, 0))) AS 'M',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.encounter_id IS NOT NULL , 1, 0))) AS 'TOTAL'

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
                                   AND cv.concept_full_name="Underweight"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
            AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 0 YEAR), INTERVAL 6 MONTH )) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 1 YEAR), INTERVAL 11 MONTH))
   GROUP BY encounter_id
  ) AS chanis_val


UNION ALL

SELECT '2. ' AS 'Service',
       '6 -23 Months' as 'Age',
       'Severe Underweight' as  '.',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'F'  , 1, 0))) AS 'F',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'M'  , 1, 0))) AS 'M',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.encounter_id IS NOT NULL , 1, 0))) AS 'TOTAL'

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
                                   AND cv.concept_full_name="Severe Underweight"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
            AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 0 YEAR), INTERVAL 6 MONTH )) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 1 YEAR), INTERVAL 11 MONTH))
   GROUP BY encounter_id
  ) AS chanis_val

UNION ALL

SELECT '2. ' AS 'Service',
       '6 -23 Months' as 'Age',
       'Overweight' as  '.',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'F'  , 1, 0))) AS 'F',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'M'  , 1, 0))) AS 'M',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.encounter_id IS NOT NULL , 1, 0))) AS 'TOTAL'

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
                                   AND cv.concept_full_name="Overweight"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
            AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 0 YEAR), INTERVAL 6 MONTH )) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 1 YEAR), INTERVAL 11 MONTH))
   GROUP BY encounter_id
  ) AS chanis_val

UNION ALL

SELECT '2. ' AS 'Service',
       '6 -23 Months' as 'Age',
       'Obese' as  '.',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'F'  , 1, 0))) AS 'F',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'M'  , 1, 0))) AS 'M',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.encounter_id IS NOT NULL , 1, 0))) AS 'TOTAL'

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
                                   AND cv.concept_full_name="Obese"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
            AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 0 YEAR), INTERVAL 6 MONTH )) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 1 YEAR), INTERVAL 11 MONTH))
   GROUP BY encounter_id
  ) AS chanis_val

UNION ALL

SELECT '2. ' AS 'Service',
       '6 -23 Months' as 'Age',
       'Total Weighed' as  '.',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'F'  , 1, 0))) AS 'F',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'M'  , 1, 0))) AS 'M',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.encounter_id IS NOT NULL , 1, 0))) AS 'TOTAL'

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
                                   AND cv.concept_full_name="Child Weight"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
            AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 0 YEAR), INTERVAL 6 MONTH )) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 1 YEAR), INTERVAL 11 MONTH))
   GROUP BY encounter_id
  ) AS chanis_val
 -- 24 - 59 months

UNION ALL
SELECT '' AS 'Service',
     ' ' as 'Age',
     '.' as  '.',
     '' AS 'F',
     '' AS 'M',
     '' AS 'TOTAL'

UNION ALL

SELECT '3. ' AS 'Service',
       '24 - 59 Months ' as 'Age',
       'Normal Weight For Age' as  '.',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'F'  , 1, 0))) AS 'F',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'M'  , 1, 0))) AS 'M',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.encounter_id IS NOT NULL , 1, 0))) AS 'TOTAL'

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
                                   AND cv.concept_full_name="Normal Weight"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
            AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 1 YEAR), INTERVAL 11 MONTH )) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 4 YEAR), INTERVAL 11 MONTH))
   GROUP BY encounter_id
  ) AS chanis_val

UNION ALL

SELECT '3. ' AS 'Service',
       '24 - 59 Months' as 'Age',
       'Underweight' as  '.',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'F'  , 1, 0))) AS 'F',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'M'  , 1, 0))) AS 'M',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.encounter_id IS NOT NULL , 1, 0))) AS 'TOTAL'

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
                                   AND cv.concept_full_name="Underweight"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
            AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 1 YEAR), INTERVAL 11 MONTH )) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 4 YEAR), INTERVAL 11 MONTH))
   GROUP BY encounter_id
  ) AS chanis_val


UNION ALL

SELECT '3. ' AS 'Service',
       '24 - 59 Months' as 'Age',
       'Severe Underweight' as  '.',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'F'  , 1, 0))) AS 'F',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'M'  , 1, 0))) AS 'M',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.encounter_id IS NOT NULL , 1, 0))) AS 'TOTAL'

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
                                   AND cv.concept_full_name="Severe Underweight"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
            AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 1 YEAR), INTERVAL 11 MONTH )) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 4 YEAR), INTERVAL 11 MONTH))
   GROUP BY encounter_id
  ) AS chanis_val

UNION ALL

SELECT '3. ' AS 'Service',
       '24 - 59 Months' as 'Age',
       'Overweight' as  '.',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'F'  , 1, 0))) AS 'F',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'M'  , 1, 0))) AS 'M',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.encounter_id IS NOT NULL , 1, 0))) AS 'TOTAL'

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
                                   AND cv.concept_full_name="Overweight"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
            AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 1 YEAR), INTERVAL 11 MONTH )) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 4 YEAR), INTERVAL 11 MONTH))
   GROUP BY encounter_id
  ) AS chanis_val

UNION ALL

SELECT '3. ' AS 'Service',
       '24 - 59 Months' as 'Age',
       'Obese' as  '.',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'F'  , 1, 0))) AS 'F',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'M'  , 1, 0))) AS 'M',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.encounter_id IS NOT NULL , 1, 0))) AS 'TOTAL'

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
                                   AND cv.concept_full_name="Obese"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
            AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 1 YEAR), INTERVAL 11 MONTH )) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 4 YEAR), INTERVAL 11 MONTH))
   GROUP BY encounter_id
  ) AS chanis_val

UNION ALL

SELECT '3. ' AS 'Service',
       '24 - 59 Months' as 'Age',
       'Total Weighed' as  '.',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'F'  , 1, 0))) AS 'F',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'M'  , 1, 0))) AS 'M',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.encounter_id IS NOT NULL , 1, 0))) AS 'TOTAL'

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
                                   AND cv.concept_full_name="Child Weight"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
            AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 1 YEAR), INTERVAL 11 MONTH )) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 4 YEAR), INTERVAL 11 MONTH))
   GROUP BY encounter_id
  ) AS chanis_val

-- MUAC 6 - 59 Mpnths


UNION ALL
SELECT '' AS 'Service',
     ' ' as 'Age',
     '.' as  '.',
     '' AS 'F',
     '' AS 'M',
     '' AS 'TOTAL'

UNION ALL

SELECT '4. ' AS 'Service',
       'MUAC 6 - 59 Months ' as 'Age',
       'Normal (Green)' as  '.',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'F'  , 1, 0))) AS 'F',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'M'  , 1, 0))) AS 'M',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.encounter_id IS NOT NULL , 1, 0))) AS 'TOTAL'

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
                                   AND cv.concept_full_name="Normal Weight"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
            AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 0 YEAR), INTERVAL 6 MONTH )) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 4 YEAR), INTERVAL 11 MONTH))
   GROUP BY encounter_id
  ) AS chanis_val

UNION ALL

SELECT '4. ' AS 'Service',
       'MUAC 6 - 59 Months' as 'Age',
       'Moderate (Yellow)' as  '.',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'F'  , 1, 0))) AS 'F',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'M'  , 1, 0))) AS 'M',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.encounter_id IS NOT NULL , 1, 0))) AS 'TOTAL'

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
                                   AND cv.concept_full_name="Underweight"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
            AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 0 YEAR), INTERVAL 6 MONTH )) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 4 YEAR), INTERVAL 11 MONTH))
   GROUP BY encounter_id
  ) AS chanis_val


UNION ALL

SELECT '4. ' AS 'Service',
       'MUAC 6 - 59 Months' as 'Age',
       'Severe (Red)' as  '.',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'F'  , 1, 0))) AS 'F',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'M'  , 1, 0))) AS 'M',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.encounter_id IS NOT NULL , 1, 0))) AS 'TOTAL'

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
                                   AND cv.concept_full_name="Severe Underweight"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
            AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 0 YEAR), INTERVAL 6 MONTH )) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 4 YEAR), INTERVAL 11 MONTH))
   GROUP BY encounter_id
  ) AS chanis_val

UNION ALL

SELECT '' AS 'Service',
     'Height For Age ' as 'Age',
     '.' as  '.',
     'F' AS 'F',
     'M' AS 'M',
     'TOTAL' AS 'TOTAL'

UNION ALL


SELECT '5. ' AS 'Service',
       '0 - <6 months ' as 'Age',
       'Normal Height For Age' as  '.',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'F'  , 1, 0))) AS 'F',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'M'  , 1, 0))) AS 'M',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.encounter_id IS NOT NULL , 1, 0))) AS 'TOTAL'

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
                                   AND cv.concept_full_name="Normal Height"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
            AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 0 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 0 YEAR), INTERVAL 6 MONTH))
   GROUP BY encounter_id
  ) AS chanis_val

UNION ALL

SELECT '5. ' AS 'Service',
       '0 - <6 months ' as 'Age',
       'Stunted' as  '.',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'F'  , 1, 0))) AS 'F',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'M'  , 1, 0))) AS 'M',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.encounter_id IS NOT NULL , 1, 0))) AS 'TOTAL'

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
                                   AND cv.concept_full_name="Stunted"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
            AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 0 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 0 YEAR), INTERVAL 6 MONTH))
   GROUP BY encounter_id
  ) AS chanis_val


UNION ALL

SELECT '5. ' AS 'Service',
       '0 - <6 months ' as 'Age',
       'Severely Stunted' as  '.',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'F'  , 1, 0))) AS 'F',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'M'  , 1, 0))) AS 'M',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.encounter_id IS NOT NULL , 1, 0))) AS 'TOTAL'

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
                                   AND cv.concept_full_name="Severely Stunted"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
            AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 0 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 0 YEAR), INTERVAL 6 MONTH))
   GROUP BY encounter_id
  ) AS chanis_val

  UNION ALL

SELECT '5. ' AS 'Service',
       '0 - <6 months ' as 'Age',
       'Total Measured' as  '.',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'F'  , 1, 0))) AS 'F',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'M'  , 1, 0))) AS 'M',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.encounter_id IS NOT NULL , 1, 0))) AS 'TOTAL'

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
                                   AND cv.concept_full_name="Child Height"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
            AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 0 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 0 YEAR), INTERVAL 6 MONTH))
   GROUP BY encounter_id
  ) AS chanis_val

UNION ALL

SELECT '' AS 'Service',
     ' ' as 'Age',
     '.' as  '.',
     'F' AS 'F',
     'M' AS 'M',
     'TOTAL' AS 'TOTAL'

UNION ALL


SELECT '6. ' AS 'Service',
       '6 - 23  months ' as 'Age',
       'Normal Height For Age' as  '.',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'F'  , 1, 0))) AS 'F',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'M'  , 1, 0))) AS 'M',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.encounter_id IS NOT NULL , 1, 0))) AS 'TOTAL'

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
                                   AND cv.concept_full_name="Normal Height"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
            AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 0 YEAR), INTERVAL 6 MONTH )) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 1 YEAR), INTERVAL 11 MONTH))
   GROUP BY encounter_id
  ) AS chanis_val

UNION ALL

SELECT '6. ' AS 'Service',
       '6 - 23  months ' as 'Age',
       'Stunted' as  '.',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'F'  , 1, 0))) AS 'F',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'M'  , 1, 0))) AS 'M',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.encounter_id IS NOT NULL , 1, 0))) AS 'TOTAL'

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
                                   AND cv.concept_full_name="Stunted"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
            AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 0 YEAR), INTERVAL 6 MONTH )) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 1 YEAR), INTERVAL 11 MONTH))
   GROUP BY encounter_id
  ) AS chanis_val


UNION ALL

SELECT '6. ' AS 'Service',
       '6 - 23  Months' as 'Age',
       'Severely Stunted' as  '.',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'F'  , 1, 0))) AS 'F',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'M'  , 1, 0))) AS 'M',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.encounter_id IS NOT NULL , 1, 0))) AS 'TOTAL'

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
                                   AND cv.concept_full_name="Severely Stunted"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
            AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 0 YEAR), INTERVAL 6 MONTH )) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 1 YEAR), INTERVAL 11 MONTH))
   GROUP BY encounter_id
  ) AS chanis_val

  UNION ALL

SELECT '6. ' AS 'Service',
       '6 - 23 Months ' as 'Age',
       'Total Measured' as  '.',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'F'  , 1, 0))) AS 'F',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'M'  , 1, 0))) AS 'M',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.encounter_id IS NOT NULL , 1, 0))) AS 'TOTAL'

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
                                   AND cv.concept_full_name="Child Height"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
            AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 0 YEAR), INTERVAL 6 MONTH )) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 1 YEAR), INTERVAL 11 MONTH))
   GROUP BY encounter_id
  ) AS chanis_val

UNION ALL
SELECT '' AS 'Service',
     ' ' as 'Age',
     '.' as  '.',
     '' AS 'F',
     '' AS 'M',
     '' AS 'TOTAL'

UNION ALL

SELECT '7. ' AS 'Service',
       '24 - 59 Months ' as 'Age',
       'Normal Height For Age' as  '.',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'F'  , 1, 0))) AS 'F',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'M'  , 1, 0))) AS 'M',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.encounter_id IS NOT NULL , 1, 0))) AS 'TOTAL'

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
                                   AND cv.concept_full_name="Normal Height"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
            AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 1 YEAR), INTERVAL 11 MONTH )) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 4 YEAR), INTERVAL 11 MONTH))
   GROUP BY encounter_id
  ) AS chanis_val

UNION ALL

SELECT '7. ' AS 'Service',
       '24 - 59 Months' as 'Age',
       'Stunted' as  '.',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'F'  , 1, 0))) AS 'F',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'M'  , 1, 0))) AS 'M',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.encounter_id IS NOT NULL , 1, 0))) AS 'TOTAL'

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
                                   AND cv.concept_full_name="Stunted"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
            AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 1 YEAR), INTERVAL 11 MONTH )) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 4 YEAR), INTERVAL 11 MONTH))
   GROUP BY encounter_id
  ) AS chanis_val


UNION ALL

SELECT '7. ' AS 'Service',
       '24 - 59 Months' as 'Age',
       'Severely Stunted' as  '.',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'F'  , 1, 0))) AS 'F',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'M'  , 1, 0))) AS 'M',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.encounter_id IS NOT NULL , 1, 0))) AS 'TOTAL'

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
                                   AND cv.concept_full_name="Severely Stunted"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
            AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 1 YEAR), INTERVAL 11 MONTH )) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 4 YEAR), INTERVAL 11 MONTH))
   GROUP BY encounter_id
  ) AS chanis_val

UNION ALL

SELECT '7. ' AS 'Service',
       '24 - 59 Months' as 'Age',
       'Total Measured' as  '.',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'F'  , 1, 0))) AS 'F',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'M'  , 1, 0))) AS 'M',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.encounter_id IS NOT NULL , 1, 0))) AS 'TOTAL'

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
                                   AND cv.concept_full_name="Child Height"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
            AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 1 YEAR), INTERVAL 11 MONTH )) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 4 YEAR), INTERVAL 11 MONTH))
   GROUP BY encounter_id
  ) AS chanis_val

UNION ALL
SELECT '' AS 'Service',
     ' ' as 'Age',
     '.' as  '.',
     '' AS 'F',
     '' AS 'M',
     '' AS 'TOTAL'

UNION ALL

SELECT '' AS 'Service',
     'Others ' as 'Age',
     '.' as  '.',
     '' AS 'F',
     '' AS 'M',
     '' AS 'TOTAL'

UNION ALL

SELECT '8. ' AS 'Service',
       '0 - 59 Months ' as 'Age',
       'New Visits' as  '.',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'F'  , 1, 0))) AS 'F',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'M'  , 1, 0))) AS 'M',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.encounter_id IS NOT NULL , 1, 0))) AS 'TOTAL'

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
                                   AND cv.concept_full_name="Normal Height"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
            AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 1 YEAR), INTERVAL 11 MONTH )) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 4 YEAR), INTERVAL 11 MONTH))
   GROUP BY encounter_id
  ) AS chanis_val

UNION ALL

SELECT '8. ' AS 'Service',
       '0 - 59 Months' as 'Age',
       'Kwashiokor' as  '.',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'F'  , 1, 0))) AS 'F',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'M'  , 1, 0))) AS 'M',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.encounter_id IS NOT NULL , 1, 0))) AS 'TOTAL'

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
                                   AND cv.concept_full_name="Kwashiokor"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
            AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 0 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 4 YEAR), INTERVAL 11 MONTH))
   GROUP BY encounter_id
  ) AS chanis_val


UNION ALL

SELECT '8. ' AS 'Service',
       '0 - 59 Months' as 'Age',
       'Marasmus' as  '.',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'F'  , 1, 0))) AS 'F',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'M'  , 1, 0))) AS 'M',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.encounter_id IS NOT NULL , 1, 0))) AS 'TOTAL'

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
                                   AND cv.concept_full_name="Marasmus"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
            AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 0 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 4 YEAR), INTERVAL 11 MONTH))
   GROUP BY encounter_id
  ) AS chanis_val

UNION ALL

SELECT '8. ' AS 'Service',
       '0 - 59 Months' as 'Age',
       'Faltering Growth' as  '.',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'F'  , 1, 0))) AS 'F',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'M'  , 1, 0))) AS 'M',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.encounter_id IS NOT NULL , 1, 0))) AS 'TOTAL'

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
                                   AND cv.concept_full_name="Faltering Growth"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
            AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 0 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 4 YEAR), INTERVAL 11 MONTH))
   GROUP BY encounter_id
  ) AS chanis_val

UNION ALL

SELECT '' AS 'Service',
     'e ' as 'Age',
     '.' as  '.',
     'F' AS 'F',
     'M' AS 'M',
     'TOTAL' AS 'TOTAL'

UNION ALL

SELECT '9. ' AS 'Service',
       '0 - <6 months ' as 'Age',
       'Exclusive brest feeding' as  '.',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'F'  , 1, 0))) AS 'F',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'M'  , 1, 0))) AS 'M',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.encounter_id IS NOT NULL , 1, 0))) AS 'TOTAL'

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
                                   AND cv.concept_full_name="Exclusibe breast feeding"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
            AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 0 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 0 YEAR), INTERVAL 6 MONTH))
   GROUP BY encounter_id
  ) AS chanis_val

UNION ALL

SELECT '10. ' AS 'Service',
       '12 - 59 months ' as 'Age',
       'Dewormed' as  '.',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'F'  , 1, 0))) AS 'F',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'M'  , 1, 0))) AS 'M',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.encounter_id IS NOT NULL , 1, 0))) AS 'TOTAL'

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
                                   AND cv.concept_full_name="Dewormed"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
            AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 1 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 4 YEAR), INTERVAL 11 MONTH))
   GROUP BY encounter_id
  ) AS chanis_val

UNION ALL

SELECT '11. ' AS 'Service',
       '6 -23 Months ' as 'Age',
       'MNPs Supplementation' as  '.',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'F'  , 1, 0))) AS 'F',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'M'  , 1, 0))) AS 'M',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.encounter_id IS NOT NULL , 1, 0))) AS 'TOTAL'

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
                                   AND cv.concept_full_name="MNPs Supplementation"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
            AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 0 YEAR), INTERVAL 6 MONTH )) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 1 YEAR), INTERVAL 11 MONTH))
   GROUP BY encounter_id
  ) AS chanis_val


UNION ALL

SELECT '' AS 'Service',
     ' ' as 'Age',
     '.' as  '.',
     '' AS 'F',
     '' AS 'M',
     '' AS 'TOTAL'

  UNION ALL

SELECT '12. ' AS 'Service',
       'No. of children who diarrhea with severe dehydration  ' as 'Age',
       '' as  '.',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'F'  , 1, 0))) AS 'F',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'M'  , 1, 0))) AS 'M',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.encounter_id IS NOT NULL , 1, 0))) AS 'TOTAL'

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
                                   AND cv.concept_full_name="Diarrhea with severe dehydration"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
            AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 0 YEAR), INTERVAL 6 MONTH )) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 1 YEAR), INTERVAL 11 MONTH))
   GROUP BY encounter_id
  ) AS chanis_val

    UNION ALL

SELECT '13. ' AS 'Service',
       'No. of children who diarrhea with some dehydration  ' as 'Age',
       '' as  '.',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'F'  , 1, 0))) AS 'F',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'M'  , 1, 0))) AS 'M',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.encounter_id IS NOT NULL , 1, 0))) AS 'TOTAL'

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
                                   AND cv.concept_full_name="Diarrhea with some dehydration"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
            AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 0 YEAR), INTERVAL 6 MONTH )) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 1 YEAR), INTERVAL 11 MONTH))
   GROUP BY encounter_id
  ) AS chanis_val

    UNION ALL

SELECT '14. ' AS 'Service',
       'No. of children who diarrhea with no dehydration  ' as 'Age',
       '' as  '.',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'F'  , 1, 0))) AS 'F',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'M'  , 1, 0))) AS 'M',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.encounter_id IS NOT NULL , 1, 0))) AS 'TOTAL'

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
                                   AND cv.concept_full_name="Diarrhea with no dehydration"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
            AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 0 YEAR), INTERVAL 6 MONTH )) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 1 YEAR), INTERVAL 11 MONTH))
   GROUP BY encounter_id
  ) AS chanis_val

      UNION ALL

SELECT '15. ' AS 'Service',
       'No. of children with diarrhea treated with ORS and Zinc  ' as 'Age',
       '' as  '.',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'F'  , 1, 0))) AS 'F',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'M'  , 1, 0))) AS 'M',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.encounter_id IS NOT NULL , 1, 0))) AS 'TOTAL'

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
                                   AND cv.concept_full_name=""
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
            AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 0 YEAR), INTERVAL 6 MONTH )) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 1 YEAR), INTERVAL 11 MONTH))
   GROUP BY encounter_id
  ) AS chanis_val

        UNION ALL

SELECT '16. ' AS 'Service',
       'No. of children with pneumonia treated with antibiotics  ' as 'Age',
       '' as  '.',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'F'  , 1, 0))) AS 'F',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'M'  , 1, 0))) AS 'M',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.encounter_id IS NOT NULL , 1, 0))) AS 'TOTAL'

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
                                   AND cv.concept_full_name=""
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
            AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 0 YEAR), INTERVAL 6 MONTH )) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 1 YEAR), INTERVAL 11 MONTH))
   GROUP BY encounter_id
  ) AS chanis_val

        UNION ALL

SELECT '17. ' AS 'Service',
       'Under  Deaths  ' as 'Age',
       '' as  '.',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'F'  , 1, 0))) AS 'F',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'M'  , 1, 0))) AS 'M',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.encounter_id IS NOT NULL , 1, 0))) AS 'TOTAL'

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
                                   AND cv.concept_full_name=""
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
            AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 0 YEAR), INTERVAL 6 MONTH )) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 1 YEAR), INTERVAL 11 MONTH))
   GROUP BY encounter_id
  ) AS chanis_val

        UNION ALL

SELECT '18. ' AS 'Service',
       'Any Disability ' as 'Age',
       '' as  '.',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'F'  , 1, 0))) AS 'F',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'M'  , 1, 0))) AS 'M',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.encounter_id IS NOT NULL , 1, 0))) AS 'TOTAL'

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
                                   AND cv.concept_full_name=""
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
            AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 0 YEAR), INTERVAL 6 MONTH )) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 1 YEAR), INTERVAL 11 MONTH))
   GROUP BY encounter_id
  ) AS chanis_val

        UNION ALL

SELECT '19. ' AS 'Service',
       'No. of children with delayed milestones  ' as 'Age',
       '' as  '.',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'F'  , 1, 0))) AS 'F',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.gender = 'M'  , 1, 0))) AS 'M',
       IF(chanis_val.encounter_id IS NULL, 0, SUM(IF(chanis_val.encounter_id IS NOT NULL , 1, 0))) AS 'TOTAL'

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
                                   AND cv.concept_full_name=""
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
            AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 0 YEAR), INTERVAL 6 MONTH )) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 1 YEAR), INTERVAL 11 MONTH))
   GROUP BY encounter_id
  ) AS chanis_val





