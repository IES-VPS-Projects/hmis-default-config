SELECT 'MATERNAL COMPLICATIONS ' AS 'Service',
      '' AS 'ALIVE',
      '' AS 'DEAD',
     ' ' as 'TOTAL'

UNION ALL

SELECT '27   A.P.H (Ante Partum Haemorrhage)' AS 'Services',
      '' AS 'ALIVE',
      '' AS 'DEAD',
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
INNER JOIN concept c on o.value_coded = c.concept_id
INNER JOIN concept_view cv on c.concept_id = cv.concept_id
    AND cv.concept_full_name IN ("Ante Partum Haemorrhage")
INNER JOIN patient p on encounter.patient_id = p.patient_id
INNER JOIN person on p.patient_id=person.person_id
) AS services

UNION ALL

SELECT '28   P.P.H (Post Partum Haemorrhage)' AS 'Services',
      '' AS 'ALIVE',
      '' AS 'DEAD',
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
INNER JOIN concept c on o.value_coded = c.concept_id
INNER JOIN concept_view cv on c.concept_id = cv.concept_id
    AND cv.concept_full_name IN ("Post Partum Haemorrhage")
INNER JOIN patient p on encounter.patient_id = p.patient_id
INNER JOIN person on p.patient_id=person.person_id
) AS services

UNION ALL

SELECT '29   Eclampsia' AS 'Services',
      '' AS 'ALIVE',
      '' AS 'DEAD',
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
INNER JOIN concept c on o.value_coded = c.concept_id
INNER JOIN concept_view cv on c.concept_id = cv.concept_id
    AND cv.concept_full_name IN ("Ante Partum Haemorrhage")
INNER JOIN patient p on encounter.patient_id = p.patient_id
INNER JOIN person on p.patient_id=person.person_id
) AS services

UNION ALL

SELECT '30   Raptured Uterus' AS 'Services',
      '' AS 'ALIVE',
      '' AS 'DEAD',
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
INNER JOIN concept c on o.value_coded = c.concept_id
INNER JOIN concept_view cv on c.concept_id = cv.concept_id
    AND cv.concept_full_name IN ("Raptured Uterus")
INNER JOIN patient p on encounter.patient_id = p.patient_id
INNER JOIN person on p.patient_id=person.person_id
) AS services

UNION ALL

SELECT '31   Obstructed labour' AS 'Services',
      '' AS 'ALIVE',
      '' AS 'DEAD',
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
INNER JOIN concept c on o.value_coded = c.concept_id
INNER JOIN concept_view cv on c.concept_id = cv.concept_id
    AND cv.concept_full_name IN ("Obstructed labor")
INNER JOIN patient p on encounter.patient_id = p.patient_id
INNER JOIN person on p.patient_id=person.person_id
) AS services

UNION ALL

SELECT '32   Sepsis' AS 'Services',
      '' AS 'ALIVE',
      '' AS 'DEAD',
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
INNER JOIN concept c on o.value_coded = c.concept_id
INNER JOIN concept_view cv on c.concept_id = cv.concept_id
    AND cv.concept_full_name IN ("Sepsis")
INNER JOIN patient p on encounter.patient_id = p.patient_id
INNER JOIN person on p.patient_id=person.person_id
) AS services

UNION ALL

SELECT '33   Number of mothers with Delivery complications associated with FGM' AS 'Services',
      '' AS 'ALIVE',
      '' AS 'DEAD',
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
    AND cv.concept_full_name IN ("FGM dDelivery Complications")
INNER JOIN patient p on encounter.patient_id = p.patient_id
INNER JOIN person on p.patient_id=person.person_id
) AS services

UNION ALL

SELECT '' AS 'Service',
      '' AS 'ALIVE',
      '' AS 'DEAD',
     ' ' as 'TOTAL'

UNION ALL

SELECT 'Neonatal Care and Outcome ' AS 'Service',
      '' AS 'ALIVE',
      '' AS 'DEAD',
     ' ' as 'TOTAL'

UNION ALL

SELECT '34   Causes of neonatal deaths' AS 'Services',
      'Neonatal Deaths Due to Sepsis' AS 'ALIVE',
      '' AS 'DEAD',
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
INNER JOIN concept c on o.value_coded = c.concept_id
INNER JOIN concept_view cv on c.concept_id = cv.concept_id
    AND cv.concept_full_name IN ("Sepsis, neonatal")
INNER JOIN patient p on encounter.patient_id = p.patient_id
INNER JOIN person on p.patient_id=person.person_id
) AS services

UNION ALL

SELECT '35   Causes of neonatal deaths' AS 'Services',
      'Neonatal Deaths Due to Prematurity' AS 'ALIVE',
      '' AS 'DEAD',
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
INNER JOIN concept c on o.value_coded = c.concept_id
INNER JOIN concept_view cv on c.concept_id = cv.concept_id
    AND cv.concept_full_name IN ("Prematurity")
INNER JOIN patient p on encounter.patient_id = p.patient_id
INNER JOIN person on p.patient_id=person.person_id
) AS services

UNION ALL

SELECT '36   Causes of neonatal deaths' AS 'Services',
      'Neonatal Deaths Due to Asphyxia' AS 'ALIVE',
      '' AS 'DEAD',
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
INNER JOIN concept c on o.value_coded = c.concept_id
INNER JOIN concept_view cv on c.concept_id = cv.concept_id
    AND cv.concept_full_name IN ("Birth asphyxia, unspec.")
INNER JOIN patient p on encounter.patient_id = p.patient_id
INNER JOIN person on p.patient_id=person.person_id
) AS services

UNION ALL

SELECT '37   Number of neonates initiated in Kangaroo Mother Care' AS 'Services',
      '' AS 'ALIVE',
      '' AS 'DEAD',
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
    AND cv.concept_full_name IN ("Kangaroo Care")
INNER JOIN patient p on encounter.patient_id = p.patient_id
INNER JOIN person on p.patient_id=person.person_id
) AS services

UNION ALL

SELECT '38   Number of referrals from community' AS 'Services',
      '' AS 'ALIVE',
      '' AS 'DEAD',
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
    AND cv.concept_full_name IN ("Comunity referrals")
INNER JOIN patient p on encounter.patient_id = p.patient_id
INNER JOIN person on p.patient_id=person.person_id
) AS services
