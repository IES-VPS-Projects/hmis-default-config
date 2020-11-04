SELECT 'A  ANC-PMCT ' AS 'Service',
     ' ' as 'TOTAL'

    UNION ALL
SELECT Concat('1    Number of ANC Clients   |       NEW     ', IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) = DATE(services.visit_date),IF(services.voided = 0, 1, 0),0)))) AS 'Services',
     IF(services.patient_id IS NULL, 0, SUM(IF(services.voided = 0 , 1, 0))) as 'TOTAL'
FROM
  (SELECT DISTINCT obs.obs_id AS obs_id,
                   obs.voided AS voided,
                   obs.obs_datetime AS datetime,
                   form_concepts_map.form_name AS form_name,
                   visit.date_started AS visit_date,
                   patient.patient_id AS patient_id,
                   patient.date_created AS first_visit_date
   FROM form_concepts_map
     INNER JOIN obs ON obs.concept_id = form_concepts_map.concept_id
      AND DATE(obs.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
     INNER JOIN encounter ON encounter.encounter_id=obs.encounter_id
     INNER JOIN visit ON visit.visit_id=encounter.visit_id  AND visit.voided = 0
     INNER JOIN patient ON patient.patient_id=visit.patient_id AND patient.voided = 0
WHERE form_concepts_map.map_id =8 ) AS services

UNION ALL

SELECT Concat('2      Number of ANC Clients   |        Re-Visit     ', IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) < DATE(services.visit_date),IF(services.voided = 0, 1, 0),0)))) AS 'Services',
       IF(services.patient_id IS NULL, 0, SUM(IF(services.voided = 0 , 1, 0))) as 'TOTAL'
FROM
  (SELECT DISTINCT obs.obs_id AS obs_id,
                   obs.voided AS voided,
                   obs.obs_datetime AS datetime,
                   form_concepts_map.form_name AS form_name,
                   visit.date_started AS visit_date,
                   patient.patient_id AS patient_id,
                   patient.date_created AS first_visit_date
   FROM form_concepts_map
     INNER JOIN obs ON obs.concept_id = form_concepts_map.concept_id
      AND DATE(obs.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
     INNER JOIN encounter ON encounter.encounter_id=obs.encounter_id
     INNER JOIN visit ON visit.visit_id=encounter.visit_id  AND visit.voided = 0
     INNER JOIN patient ON patient.patient_id=visit.patient_id AND patient.voided = 0
WHERE form_concepts_map.map_id =8 ) AS services

UNION ALL

SELECT '3  Number of Clients Given IPT (1st dose)' AS 'Services',
       IF(services.patient_id IS NULL, 0, SUM(IF(services.voided = 0 , 1, 0))) as 'TOTAL'
FROM
  (SELECT DISTINCT obs.obs_id AS obs_id,
                   obs.voided AS voided,
                   obs.obs_datetime AS datetime,
                   form_concepts_map.form_name AS form_name,
                   visit.date_started AS visit_date,
                   patient.patient_id AS patient_id,
                   patient.date_created AS first_visit_date
   FROM form_concepts_map
     INNER JOIN obs ON obs.concept_id = form_concepts_map.concept_id
      AND DATE(obs.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
     INNER JOIN encounter ON encounter.encounter_id=obs.encounter_id
     INNER JOIN visit ON visit.visit_id=encounter.visit_id  AND visit.voided = 0
     INNER JOIN patient ON patient.patient_id=visit.patient_id AND patient.voided = 0
WHERE form_concepts_map.map_id =0 ) AS services

UNION ALL

SELECT '4  Number of Clients Given IPT (2nd dose)' AS 'Services',
       IF(services.patient_id IS NULL, 0, SUM(IF(services.voided = 0 , 1, 0))) as 'TOTAL'
FROM
  (SELECT DISTINCT obs.obs_id AS obs_id,
                   obs.voided AS voided,
                   obs.obs_datetime AS datetime,
                   form_concepts_map.form_name AS form_name,
                   visit.date_started AS visit_date,
                   patient.patient_id AS patient_id,
                   patient.date_created AS first_visit_date
   FROM form_concepts_map
     INNER JOIN obs ON obs.concept_id = form_concepts_map.concept_id
      AND DATE(obs.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
     INNER JOIN encounter ON encounter.encounter_id=obs.encounter_id
     INNER JOIN visit ON visit.visit_id=encounter.visit_id  AND visit.voided = 0
     INNER JOIN patient ON patient.patient_id=visit.patient_id AND patient.voided = 0
WHERE form_concepts_map.map_id =0 ) AS services

UNION ALL

SELECT '5  Number of Clients Given IPT (3rd dose)' AS 'Services',
       IF(services.patient_id IS NULL, 0, SUM(IF(services.voided = 0 , 1, 0))) as 'TOTAL'
FROM
  (SELECT DISTINCT obs.obs_id AS obs_id,
                   obs.voided AS voided,
                   obs.obs_datetime AS datetime,
                   form_concepts_map.form_name AS form_name,
                   visit.date_started AS visit_date,
                   patient.patient_id AS patient_id,
                   patient.date_created AS first_visit_date
   FROM form_concepts_map
     INNER JOIN obs ON obs.concept_id = form_concepts_map.concept_id
      AND DATE(obs.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
     INNER JOIN encounter ON encounter.encounter_id=obs.encounter_id
     INNER JOIN visit ON visit.visit_id=encounter.visit_id  AND visit.voided = 0
     INNER JOIN patient ON patient.patient_id=visit.patient_id AND patient.voided = 0
WHERE form_concepts_map.map_id =0 ) AS services

UNION ALL

SELECT '6  Number of clients with HB < 11g/dl' AS 'Services',
       IF(services.patient_id IS NULL, 0, SUM(IF(services.voided = 0 , 1, 0))) as 'TOTAL'
FROM
  (SELECT DISTINCT o.obs_id AS obs_id,
                   o.voided AS voided,
                   o.obs_datetime AS datetime,
                   v.date_started AS visit_date,
                   p.patient_id AS patient_id,
                   p.date_created AS first_visit_date
   FROM encounter
INNER JOIN visit v on encounter.visit_id = v.visit_id
INNER JOIN obs o on encounter.encounter_id = o.encounter_id
          AND CAST(o.value_text AS SIGNED) < 11
          AND DATE(o.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
INNER JOIN concept c on o.concept_id = c.concept_id
INNER JOIN concept_view cv on c.concept_id = cv.concept_id
    AND cv.concept_full_name IN ("ANC, HB")
INNER JOIN patient p on encounter.patient_id = p.patient_id
) AS services

UNION ALL

SELECT '7  Number of ANC 1st ANC contact at 12 weeks or less weeks ' AS 'Service',
       IF(services.patient_id IS NULL, 0, SUM(IF(services.voided = 0 , 1, 0))) as 'TOTAL'
FROM
  (SELECT DISTINCT obs.obs_id AS obs_id,
                   obs.voided AS voided,
                   obs.obs_datetime AS datetime,
                   form_concepts_map.form_name AS form_name,
                   visit.date_started AS visit_date,
                   patient.patient_id AS patient_id,
                   patient.date_created AS first_visit_date
   FROM form_concepts_map
     INNER JOIN obs ON obs.concept_id = form_concepts_map.concept_id
     INNER JOIN encounter ON encounter.encounter_id=obs.encounter_id
     INNER JOIN visit ON visit.visit_id=encounter.visit_id  AND visit.voided = 0
     INNER JOIN patient ON patient.patient_id=visit.patient_id AND patient.voided = 0
WHERE form_concepts_map.map_id =0 ) AS services

UNION ALL

SELECT '8  Number of clients completed with 4th ANC Contacts ' AS 'Service',
       IF(services.patient_id IS NULL, 0, SUM(IF(services.voided = 0 , 1, 0))) as 'TOTAL'
FROM
  (SELECT DISTINCT obs.obs_id AS obs_id,
                   obs.voided AS voided,
                   obs.obs_datetime AS datetime,
                   form_concepts_map.form_name AS form_name,
                   visit.date_started AS visit_date,
                   patient.patient_id AS patient_id,
                   patient.date_created AS first_visit_date
   FROM form_concepts_map
     INNER JOIN obs ON obs.concept_id = form_concepts_map.concept_id
     INNER JOIN encounter ON encounter.encounter_id=obs.encounter_id
     INNER JOIN visit ON visit.visit_id=encounter.visit_id  AND visit.voided = 0
     INNER JOIN patient ON patient.patient_id=visit.patient_id AND patient.voided = 0
WHERE form_concepts_map.map_id =0 ) AS services

UNION ALL

SELECT '9  Number of clients completed with 8th ANC Contacts ' AS 'Service',
       IF(services.patient_id IS NULL, 0, SUM(IF(services.voided = 0 , 1, 0))) as 'TOTAL'
FROM
  (SELECT DISTINCT obs.obs_id AS obs_id,
                   obs.voided AS voided,
                   obs.obs_datetime AS datetime,
                   form_concepts_map.form_name AS form_name,
                   visit.date_started AS visit_date,
                   patient.patient_id AS patient_id,
                   patient.date_created AS first_visit_date
   FROM form_concepts_map
     INNER JOIN obs ON obs.concept_id = form_concepts_map.concept_id
     INNER JOIN encounter ON encounter.encounter_id=obs.encounter_id
     INNER JOIN visit ON visit.visit_id=encounter.visit_id  AND visit.voided = 0
     INNER JOIN patient ON patient.patient_id=visit.patient_id AND patient.voided = 0
WHERE form_concepts_map.map_id =0 ) AS services

UNION ALL

SELECT '10  Number of LLINs distributed to under 1 year' AS 'Service',
       IF(services.patient_id IS NULL, 0, SUM(IF(services.voided = 0 , 1, 0))) as 'TOTAL'
FROM
  (SELECT DISTINCT o.obs_id AS obs_id,
                   o.voided AS voided,
                   o.obs_datetime AS datetime,
                   v.date_started AS visit_date,
                   p.patient_id AS patient_id,
                   p.date_created AS first_visit_date
   FROM encounter
INNER JOIN visit v on encounter.visit_id = v.visit_id
INNER JOIN obs o on encounter.encounter_id = o.encounter_id
          AND DATE(o.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
INNER JOIN concept c on o.value_coded = c.concept_id
INNER JOIN concept_view cv on c.concept_id = cv.concept_id
    AND cv.concept_full_name IN ("LLIMN")
INNER JOIN patient p on encounter.patient_id = p.patient_id ) AS services

UNION ALL

SELECT '11  Number of LLINs distributed to ANC Clients' AS 'Service',
       IF(services.patient_id IS NULL, 0, SUM(IF(services.voided = 0 , 1, 0))) as 'TOTAL'
FROM
  (SELECT DISTINCT o.obs_id AS obs_id,
                   o.voided AS voided,
                   o.obs_datetime AS datetime,
                   v.date_started AS visit_date,
                   p.patient_id AS patient_id,
                   p.date_created AS first_visit_date
   FROM encounter
INNER JOIN visit v on encounter.visit_id = v.visit_id
INNER JOIN obs o on encounter.encounter_id = o.encounter_id
          AND DATE(o.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
INNER JOIN concept c on o.value_coded = c.concept_id
INNER JOIN concept_view cv on c.concept_id = cv.concept_id
    AND cv.concept_full_name IN ("LLIMN")
INNER JOIN patient p on encounter.patient_id = p.patient_id ) AS services

    UNION ALL
SELECT Concat('12    Number of ANC Clients   |       Tested for Syphilis     ', IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) = DATE(services.visit_date),IF(services.voided = 0, 1, 0),0)))) AS 'Services',
     IF(services.patient_id IS NULL, 0, SUM(IF(services.voided = 0 , 1, 0))) as 'TOTAL'
FROM
  (SELECT DISTINCT o.obs_id AS obs_id,
                   o.voided AS voided,
                   o.obs_datetime AS datetime,
                   v.date_started AS visit_date,
                   p.patient_id AS patient_id,
                   p.date_created AS first_visit_date
   FROM encounter
INNER JOIN visit v on encounter.visit_id = v.visit_id
INNER JOIN obs o on encounter.encounter_id = o.encounter_id
          AND DATE(o.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
INNER JOIN concept c on o.concept_id = c.concept_id
INNER JOIN concept_view cv on c.concept_id = cv.concept_id
    AND cv.concept_full_name IN ("Syphilis")
INNER JOIN patient p on encounter.patient_id = p.patient_id ) AS services

    UNION ALL
SELECT Concat('13    Number of ANC Clients   |       Positive(+ve)     ', IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) = DATE(services.visit_date),IF(services.voided = 0, 1, 0),0)))) AS 'Services',
     IF(services.patient_id IS NULL, 0, SUM(IF(services.voided = 0 , 1, 0))) as 'TOTAL'
FROM
  (SELECT DISTINCT o.obs_id AS obs_id,
                   o.voided AS voided,
                   o.obs_datetime AS datetime,
                   v.date_started AS visit_date,
                   p.patient_id AS patient_id,
                   p.date_created AS first_visit_date
   FROM encounter
INNER JOIN visit v on encounter.visit_id = v.visit_id
INNER JOIN obs o on encounter.encounter_id = o.encounter_id
          AND DATE(o.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
INNER JOIN concept c on o.concept_id = c.concept_id
INNER JOIN concept_view cv on c.concept_id = cv.concept_id
    AND cv.concept_full_name IN ("Syphilis")
INNER JOIN patient p on encounter.patient_id = p.patient_id ) AS services

    UNION ALL
SELECT '14   Total women done breast examination ' AS 'Services',
     IF(services.patient_id IS NULL, 0, SUM(IF(services.voided = 0 , 1, 0))) as 'TOTAL'
FROM
  (SELECT DISTINCT o.obs_id AS obs_id,
                   o.voided AS voided,
                   o.obs_datetime AS datetime,
                   v.date_started AS visit_date,
                   p.patient_id AS patient_id,
                   p.date_created AS first_visit_date
   FROM encounter
INNER JOIN visit v on encounter.visit_id = v.visit_id
INNER JOIN obs o on encounter.encounter_id = o.encounter_id
          AND DATE(o.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
INNER JOIN concept c on o.concept_id = c.concept_id
INNER JOIN concept_view cv on c.concept_id = cv.concept_id
    AND cv.concept_full_name IN ("ANC, Breast and Pelvic Exam")
INNER JOIN patient p on encounter.patient_id = p.patient_id ) AS services

    UNION ALL

SELECT '15   Number of adolescents((10-14 years) presenting at 1st ANC Contact ' AS 'Services',
     IF(services.patient_id IS NULL, 0, SUM(IF(services.voided = 0 , 1, 0))) as 'TOTAL'
FROM
  (SELECT DISTINCT o.obs_id AS obs_id,
                   o.voided AS voided,
                   o.obs_datetime AS datetime,
                   v.date_started AS visit_date,
                   p.patient_id AS patient_id,
                   person.birthdate as birthdate,
                   p.date_created AS first_visit_date
   FROM encounter
INNER JOIN visit v on encounter.visit_id = v.visit_id
INNER JOIN obs o on encounter.encounter_id = o.encounter_id
          AND DATE(o.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
INNER JOIN concept c on o.concept_id = c.concept_id
INNER JOIN concept_view cv on c.concept_id = cv.concept_id
    AND cv.concept_full_name IN ("ANC, Current Pregnancy")
INNER JOIN patient p on encounter.patient_id = p.patient_id
INNER JOIN person on p.patient_id=person.person_id
      AND DATE(v.date_started) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 10 YEAR), INTERVAL 0 DAY))
      AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 14 YEAR), INTERVAL 0 DAY))
) AS services

    UNION ALL

SELECT '16   Number of adolescents((15-19 years) presenting at 1st ANC Contact ' AS 'Services',
     IF(services.patient_id IS NULL, 0, SUM(IF(services.voided = 0 , 1, 0))) as 'TOTAL'
FROM
  (SELECT DISTINCT o.obs_id AS obs_id,
                   o.voided AS voided,
                   o.obs_datetime AS datetime,
                   v.date_started AS visit_date,
                   p.patient_id AS patient_id,
                   person.birthdate as birthdate,
                   p.date_created AS first_visit_date
   FROM encounter
INNER JOIN visit v on encounter.visit_id = v.visit_id
INNER JOIN obs o on encounter.encounter_id = o.encounter_id
          AND DATE(o.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
INNER JOIN concept c on o.concept_id = c.concept_id
INNER JOIN concept_view cv on c.concept_id = cv.concept_id
    AND cv.concept_full_name IN ("ANC, Current Pregnancy")
INNER JOIN patient p on encounter.patient_id = p.patient_id
INNER JOIN person on p.patient_id=person.person_id
      AND DATE(v.date_started) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 15 YEAR), INTERVAL 0 DAY))
      AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 19 YEAR), INTERVAL 0 DAY))
) AS services

    UNION ALL

SELECT '17   Number of youth((20-24 years) presenting at 1st ANC Contact ' AS 'Services',
     IF(services.patient_id IS NULL, 0, SUM(IF(services.voided = 0 , 1, 0))) as 'TOTAL'
FROM
  (SELECT DISTINCT o.obs_id AS obs_id,
                   o.voided AS voided,
                   o.obs_datetime AS datetime,
                   v.date_started AS visit_date,
                   p.patient_id AS patient_id,
                   person.birthdate as birthdate,
                   p.date_created AS first_visit_date
   FROM encounter
INNER JOIN visit v on encounter.visit_id = v.visit_id
INNER JOIN obs o on encounter.encounter_id = o.encounter_id
          AND DATE(o.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
INNER JOIN concept c on o.concept_id = c.concept_id
INNER JOIN concept_view cv on c.concept_id = cv.concept_id
    AND cv.concept_full_name IN ("ANC, Current Pregnancy")
INNER JOIN patient p on encounter.patient_id = p.patient_id
INNER JOIN person on p.patient_id=person.person_id
      AND DATE(v.date_started) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 20 YEAR), INTERVAL 0 DAY))
      AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 24 YEAR), INTERVAL 0 DAY))
) AS services

UNION ALL

SELECT '18  Number of clients issued with iron' AS 'Service',
       IF(services.patient_id IS NULL, 0, SUM(IF(services.voided = 0 , 1, 0))) as 'TOTAL'
FROM
  (SELECT DISTINCT o.order_id AS order_id,
                   o.voided AS voided,
                   p.patient_id AS patient_id,
                   o.date_created AS datetime
   FROM concept_view cv
     INNER JOIN orders o on cv.concept_id = o.concept_id
                            AND o.concept_id IN (select concept_id from concept_view where concept_full_name IN ('Iron Sucrose'))
     INNER JOIN encounter e on o.encounter_id = e.encounter_id
     INNER JOIN visit v on e.visit_id = v.visit_id
     INNER JOIN patient p on e.patient_id = p.patient_id
   WHERE  DATE(o.date_created) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
   GROUP BY p.patient_id) AS services

UNION ALL

SELECT '19  Number of clients issued with folic' AS 'Service',
       IF(services.patient_id IS NULL, 0, SUM(IF(services.voided = 0 , 1, 0))) as 'TOTAL'
FROM
  (SELECT DISTINCT o.order_id AS order_id,
                   o.voided AS voided,
                   p.patient_id AS patient_id,
                   o.date_created AS datetime
   FROM concept_view cv
     INNER JOIN orders o on cv.concept_id = o.concept_id
                            AND o.concept_id IN (select concept_id from concept_view where concept_full_name IN ('Folic', 'Folic Acid'))
     INNER JOIN encounter e on o.encounter_id = e.encounter_id
     INNER JOIN visit v on e.visit_id = v.visit_id
     INNER JOIN patient p on e.patient_id = p.patient_id
   WHERE  DATE(o.date_created) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
   GROUP BY p.patient_id) AS services

UNION ALL

SELECT '20  Number of clients issued with combined Ferrous Folate' AS 'Service',
       IF(services.patient_id IS NULL, 0, SUM(IF(services.voided = 0 , 1, 0))) as 'TOTAL'
FROM
  (SELECT DISTINCT o.order_id AS order_id,
                   o.voided AS voided,
                   p.patient_id AS patient_id,
                   o.date_created AS datetime
   FROM concept_view cv
     INNER JOIN orders o on cv.concept_id = o.concept_id
                            AND o.concept_id IN (select concept_id from concept_view where concept_full_name IN ('Ferrous Sulphate', 'Ferrous Fumarate & Folic Acid'))
     INNER JOIN encounter e on o.encounter_id = e.encounter_id
     INNER JOIN visit v on e.visit_id = v.visit_id
     INNER JOIN patient p on e.patient_id = p.patient_id
   WHERE  DATE(o.date_created) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
   GROUP BY p.patient_id) AS services

    UNION ALL

SELECT '21   Number of pregnant women presenting in ANC with complications associated with FGM' AS 'Services',
     IF(services.patient_id IS NULL, 0, SUM(IF(services.voided = 0 , 1, 0))) as 'TOTAL'
FROM
  (SELECT DISTINCT o.obs_id AS obs_id,
                   o.voided AS voided,
                   o.obs_datetime AS datetime,
                   v.date_started AS visit_date,
                   p.patient_id AS patient_id,
                   person.birthdate as birthdate,
                   p.date_created AS first_visit_date
   FROM encounter
INNER JOIN visit v on encounter.visit_id = v.visit_id
INNER JOIN obs o on encounter.encounter_id = o.encounter_id
          AND DATE(o.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
INNER JOIN concept c on o.concept_id = c.concept_id
INNER JOIN concept_view cv on c.concept_id = cv.concept_id
    AND cv.concept_full_name IN ("FGM")
INNER JOIN patient p on encounter.patient_id = p.patient_id
INNER JOIN person on p.patient_id=person.person_id
      AND DATE(v.date_started) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 20 YEAR), INTERVAL 0 DAY))
      AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 24 YEAR), INTERVAL 0 DAY))
) AS services



