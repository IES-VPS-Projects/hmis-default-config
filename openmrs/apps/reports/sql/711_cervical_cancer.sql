SELECT 'G.  CERVICAL CANCER SCREENING' AS 'Service',
     '' as '<25',
     '' as  '25-29yrs',
     '' AS '50+ys'

  UNION ALL

SELECT
       'No. of clients receiving VIA/VILI//HPV VILI/HPV ' as 'Service',
       IF(cancer_val.encounter_id IS NULL, 0, SUM(IF(DATE(cancer_val.date_time) BETWEEN (DATE_ADD(DATE_ADD(cancer_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(cancer_val.birthdate, INTERVAL 25 YEAR), INTERVAL 12 MONTH)) , 1, 0))) AS '<25',
       IF(cancer_val.encounter_id IS NULL, 0, SUM(IF(DATE(cancer_val.date_time) BETWEEN (DATE_ADD(DATE_ADD(cancer_val.birthdate, INTERVAL 25 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(cancer_val.birthdate, INTERVAL 29 YEAR), INTERVAL 12 MONTH)) , 1, 0))) AS '25-29yrs',
  IF(cancer_val.encounter_id IS NULL, 0, SUM(IF(DATE(cancer_val.date_time) BETWEEN (DATE_ADD(DATE_ADD(cancer_val.birthdate, INTERVAL 50 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(cancer_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 MONTH)) , 1, 0))) AS '50+yrs'

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
            AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 0 YEAR), INTERVAL 6 MONTH )) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 1 YEAR), INTERVAL 11 MONTH))
   GROUP BY encounter_id
  ) AS cancer_val

UNION ALL

SELECT
  '1. No. of screened for Pap smear' as 'Service',
  IF(cancer_val.encounter_id IS NULL, 0, SUM(IF(DATE(cancer_val.date_time) BETWEEN (DATE_ADD(DATE_ADD(cancer_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(cancer_val.birthdate, INTERVAL 25 YEAR), INTERVAL 12 MONTH)) , 1, 0))) AS '<25',
  IF(cancer_val.encounter_id IS NULL, 0, SUM(IF(DATE(cancer_val.date_time) BETWEEN (DATE_ADD(DATE_ADD(cancer_val.birthdate, INTERVAL 25 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(cancer_val.birthdate, INTERVAL 29 YEAR), INTERVAL 12 MONTH)) , 1, 0))) AS '25-29yrs',
  IF(cancer_val.encounter_id IS NULL, 0, SUM(IF(DATE(cancer_val.date_time) BETWEEN (DATE_ADD(DATE_ADD(cancer_val.birthdate, INTERVAL 50 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(cancer_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 MONTH)) , 1, 0))) AS '50+yrs'

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
                          AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 0 YEAR), INTERVAL 6 MONTH )) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 1 YEAR), INTERVAL 11 MONTH))
   GROUP BY encounter_id
  ) AS cancer_val

UNION ALL

SELECT
  '2. No. screened for HPV test' as 'Service',
  IF(cancer_val.encounter_id IS NULL, 0, SUM(IF(DATE(cancer_val.date_time) BETWEEN (DATE_ADD(DATE_ADD(cancer_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(cancer_val.birthdate, INTERVAL 25 YEAR), INTERVAL 12 MONTH)) , 1, 0))) AS '<25',
  IF(cancer_val.encounter_id IS NULL, 0, SUM(IF(DATE(cancer_val.date_time) BETWEEN (DATE_ADD(DATE_ADD(cancer_val.birthdate, INTERVAL 25 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(cancer_val.birthdate, INTERVAL 29 YEAR), INTERVAL 12 MONTH)) , 1, 0))) AS '25-29yrs',
  IF(cancer_val.encounter_id IS NULL, 0, SUM(IF(DATE(cancer_val.date_time) BETWEEN (DATE_ADD(DATE_ADD(cancer_val.birthdate, INTERVAL 50 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(cancer_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 MONTH)) , 1, 0))) AS '50+yrs'

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
                          AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 0 YEAR), INTERVAL 6 MONTH )) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 1 YEAR), INTERVAL 11 MONTH))
   GROUP BY encounter_id
  ) AS cancer_val

UNION ALL

SELECT
  '3. No. of clients with positive VIA/VILI result' as 'Service',
  IF(cancer_val.encounter_id IS NULL, 0, SUM(IF(DATE(cancer_val.date_time) BETWEEN (DATE_ADD(DATE_ADD(cancer_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(cancer_val.birthdate, INTERVAL 25 YEAR), INTERVAL 12 MONTH)) , 1, 0))) AS '<25',
  IF(cancer_val.encounter_id IS NULL, 0, SUM(IF(DATE(cancer_val.date_time) BETWEEN (DATE_ADD(DATE_ADD(cancer_val.birthdate, INTERVAL 25 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(cancer_val.birthdate, INTERVAL 29 YEAR), INTERVAL 12 MONTH)) , 1, 0))) AS '25-29yrs',
  IF(cancer_val.encounter_id IS NULL, 0, SUM(IF(DATE(cancer_val.date_time) BETWEEN (DATE_ADD(DATE_ADD(cancer_val.birthdate, INTERVAL 50 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(cancer_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 MONTH)) , 1, 0))) AS '50+yrs'

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
                          AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 0 YEAR), INTERVAL 6 MONTH )) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 1 YEAR), INTERVAL 11 MONTH))
   GROUP BY encounter_id
  ) AS cancer_val

UNION ALL

SELECT
  '4  No. of clients with positive Cytology result ' as 'Service',
  IF(cancer_val.encounter_id IS NULL, 0, SUM(IF(DATE(cancer_val.date_time) BETWEEN (DATE_ADD(DATE_ADD(cancer_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(cancer_val.birthdate, INTERVAL 25 YEAR), INTERVAL 12 MONTH)) , 1, 0))) AS '<25',
  IF(cancer_val.encounter_id IS NULL, 0, SUM(IF(DATE(cancer_val.date_time) BETWEEN (DATE_ADD(DATE_ADD(cancer_val.birthdate, INTERVAL 25 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(cancer_val.birthdate, INTERVAL 29 YEAR), INTERVAL 12 MONTH)) , 1, 0))) AS '25-29yrs',
  IF(cancer_val.encounter_id IS NULL, 0, SUM(IF(DATE(cancer_val.date_time) BETWEEN (DATE_ADD(DATE_ADD(cancer_val.birthdate, INTERVAL 50 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(cancer_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 MONTH)) , 1, 0))) AS '50+yrs'

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
                          AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 0 YEAR), INTERVAL 6 MONTH )) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 1 YEAR), INTERVAL 11 MONTH))
   GROUP BY encounter_id
  ) AS cancer_val

UNION ALL

SELECT
  '5. No. of clients with positive HPV results' as 'Service',
  IF(cancer_val.encounter_id IS NULL, 0, SUM(IF(DATE(cancer_val.date_time) BETWEEN (DATE_ADD(DATE_ADD(cancer_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(cancer_val.birthdate, INTERVAL 25 YEAR), INTERVAL 12 MONTH)) , 1, 0))) AS '<25',
  IF(cancer_val.encounter_id IS NULL, 0, SUM(IF(DATE(cancer_val.date_time) BETWEEN (DATE_ADD(DATE_ADD(cancer_val.birthdate, INTERVAL 25 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(cancer_val.birthdate, INTERVAL 29 YEAR), INTERVAL 12 MONTH)) , 1, 0))) AS '25-29yrs',
  IF(cancer_val.encounter_id IS NULL, 0, SUM(IF(DATE(cancer_val.date_time) BETWEEN (DATE_ADD(DATE_ADD(cancer_val.birthdate, INTERVAL 50 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(cancer_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 MONTH)) , 1, 0))) AS '50+yrs'

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
                          AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 0 YEAR), INTERVAL 6 MONTH )) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 1 YEAR), INTERVAL 11 MONTH))
   GROUP BY encounter_id
  ) AS cancer_val

UNION ALL

SELECT
  '6. No. of clients with suspicious cancer lesions ' as 'Service',
  IF(cancer_val.encounter_id IS NULL, 0, SUM(IF(DATE(cancer_val.date_time) BETWEEN (DATE_ADD(DATE_ADD(cancer_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(cancer_val.birthdate, INTERVAL 25 YEAR), INTERVAL 12 MONTH)) , 1, 0))) AS '<25',
  IF(cancer_val.encounter_id IS NULL, 0, SUM(IF(DATE(cancer_val.date_time) BETWEEN (DATE_ADD(DATE_ADD(cancer_val.birthdate, INTERVAL 25 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(cancer_val.birthdate, INTERVAL 29 YEAR), INTERVAL 12 MONTH)) , 1, 0))) AS '25-29yrs',
  IF(cancer_val.encounter_id IS NULL, 0, SUM(IF(DATE(cancer_val.date_time) BETWEEN (DATE_ADD(DATE_ADD(cancer_val.birthdate, INTERVAL 50 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(cancer_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 MONTH)) , 1, 0))) AS '50+yrs'

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
                          AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 0 YEAR), INTERVAL 6 MONTH )) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 1 YEAR), INTERVAL 11 MONTH))
   GROUP BY encounter_id
  ) AS cancer_val

UNION ALL

SELECT
  '7. No. of clients treated using Cyrotherapy ' as 'Service',
  IF(cancer_val.encounter_id IS NULL, 0, SUM(IF(DATE(cancer_val.date_time) BETWEEN (DATE_ADD(DATE_ADD(cancer_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(cancer_val.birthdate, INTERVAL 25 YEAR), INTERVAL 12 MONTH)) , 1, 0))) AS '<25',
  IF(cancer_val.encounter_id IS NULL, 0, SUM(IF(DATE(cancer_val.date_time) BETWEEN (DATE_ADD(DATE_ADD(cancer_val.birthdate, INTERVAL 25 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(cancer_val.birthdate, INTERVAL 29 YEAR), INTERVAL 12 MONTH)) , 1, 0))) AS '25-29yrs',
  IF(cancer_val.encounter_id IS NULL, 0, SUM(IF(DATE(cancer_val.date_time) BETWEEN (DATE_ADD(DATE_ADD(cancer_val.birthdate, INTERVAL 50 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(cancer_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 MONTH)) , 1, 0))) AS '50+yrs'

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
                          AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 0 YEAR), INTERVAL 6 MONTH )) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 1 YEAR), INTERVAL 11 MONTH))
   GROUP BY encounter_id
  ) AS cancer_val

UNION ALL

SELECT
  '8. No. of clients treated using LEEP ' as 'Service',
  IF(cancer_val.encounter_id IS NULL, 0, SUM(IF(DATE(cancer_val.date_time) BETWEEN (DATE_ADD(DATE_ADD(cancer_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(cancer_val.birthdate, INTERVAL 25 YEAR), INTERVAL 12 MONTH)) , 1, 0))) AS '<25',
  IF(cancer_val.encounter_id IS NULL, 0, SUM(IF(DATE(cancer_val.date_time) BETWEEN (DATE_ADD(DATE_ADD(cancer_val.birthdate, INTERVAL 25 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(cancer_val.birthdate, INTERVAL 29 YEAR), INTERVAL 12 MONTH)) , 1, 0))) AS '25-29yrs',
  IF(cancer_val.encounter_id IS NULL, 0, SUM(IF(DATE(cancer_val.date_time) BETWEEN (DATE_ADD(DATE_ADD(cancer_val.birthdate, INTERVAL 50 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(cancer_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 MONTH)) , 1, 0))) AS '50+yrs'

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
                          AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 0 YEAR), INTERVAL 6 MONTH )) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 1 YEAR), INTERVAL 11 MONTH))
   GROUP BY encounter_id
  ) AS cancer_val

UNION ALL

SELECT
  '9. No. of HIV Positve clients screened' as 'Service',
  IF(cancer_val.encounter_id IS NULL, 0, SUM(IF(DATE(cancer_val.date_time) BETWEEN (DATE_ADD(DATE_ADD(cancer_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(cancer_val.birthdate, INTERVAL 25 YEAR), INTERVAL 12 MONTH)) , 1, 0))) AS '<25',
  IF(cancer_val.encounter_id IS NULL, 0, SUM(IF(DATE(cancer_val.date_time) BETWEEN (DATE_ADD(DATE_ADD(cancer_val.birthdate, INTERVAL 25 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(cancer_val.birthdate, INTERVAL 29 YEAR), INTERVAL 12 MONTH)) , 1, 0))) AS '25-29yrs',
  IF(cancer_val.encounter_id IS NULL, 0, SUM(IF(DATE(cancer_val.date_time) BETWEEN (DATE_ADD(DATE_ADD(cancer_val.birthdate, INTERVAL 50 YEAR), INTERVAL 0 MONTH )) AND (DATE_ADD(DATE_ADD(cancer_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 MONTH)) , 1, 0))) AS '50+yrs'

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
                          AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 0 YEAR), INTERVAL 6 MONTH )) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 1 YEAR), INTERVAL 11 MONTH))
   GROUP BY encounter_id
  ) AS cancer_val
