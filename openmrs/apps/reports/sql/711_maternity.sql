SELECT 'B  MATERNITY AND NEWBORN ' AS 'Service',
     ' ' as 'TOTAL'

    UNION ALL

SELECT '1   Normal Deliveries' AS 'Services',
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
    AND cv.concept_full_name IN ("Spontaneous Vaginal Delivery")
INNER JOIN patient p on encounter.patient_id = p.patient_id
INNER JOIN person on p.patient_id=person.person_id
) AS services

    UNION ALL

SELECT '2   Cesarean Sections' AS 'Services',
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
    AND cv.concept_full_name IN ("Caesarean Section")
INNER JOIN patient p on encounter.patient_id = p.patient_id
INNER JOIN person on p.patient_id=person.person_id
) AS services

UNION ALL

SELECT '3   Breech Delivery' AS 'Services',
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
    AND cv.concept_full_name IN ("Breech Presentation")
INNER JOIN patient p on encounter.patient_id = p.patient_id
INNER JOIN person on p.patient_id=person.person_id
) AS services

UNION ALL

SELECT '3   Assisted Vaginal Delivery(Vacuum Extraction)' AS 'Services',
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
    AND cv.concept_full_name IN ("Forceps or Vaccum Extractor Delivery")
INNER JOIN patient p on encounter.patient_id = p.patient_id
INNER JOIN person on p.patient_id=person.person_id
) AS services

UNION ALL


SELECT 'TOTAL DELIVERIES' AS 'Services',
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
    AND cv.concept_full_name IN ("Delivery note")
INNER JOIN patient p on encounter.patient_id = p.patient_id
INNER JOIN person on p.patient_id=person.person_id
) AS services

UNION ALL


SELECT '5 Number of mothers given uterotonics within 1 minute  |  Oxytocin   ' AS 'Services',
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
          AND o.value_coded = (select concept_id from concept_view where concept_full_name = "Oxytocin")
INNER JOIN concept c on o.concept_id = c.concept_id
INNER JOIN concept_view cv on c.concept_id = cv.concept_id
    AND cv.concept_full_name IN ("Uterotonics Given")
INNER JOIN patient p on encounter.patient_id = p.patient_id
INNER JOIN person on p.patient_id=person.person_id
) AS services

UNION ALL


SELECT '5 Number of mothers given uterotonics within 1 minute  |  Carbatosin   ' AS 'Services',
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
          AND o.value_coded = (select concept_id from concept_view where concept_full_name = "Carbatosin")
INNER JOIN concept c on o.concept_id = c.concept_id
INNER JOIN concept_view cv on c.concept_id = cv.concept_id
    AND cv.concept_full_name IN ("Uterotonics Given")
INNER JOIN patient p on encounter.patient_id = p.patient_id
INNER JOIN person on p.patient_id=person.person_id
) AS services

UNION ALL

SELECT '6   Live births' AS 'Services',
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
    AND cv.concept_full_name IN ("Delivery Note, Liveborn infant details")
INNER JOIN patient p on encounter.patient_id = p.patient_id
INNER JOIN person on p.patient_id=person.person_id
) AS services

UNION ALL
SELECT '7   Number of Low birth weight babies(below 2500 grams)' AS 'Services',
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
          AND o.value_numeric < 2500
INNER JOIN concept c on o.concept_id = c.concept_id
INNER JOIN concept_view cv on c.concept_id = cv.concept_id
    AND cv.concept_full_name IN ("Delivery Note, Liveborn weight")
INNER JOIN patient p on encounter.patient_id = p.patient_id
INNER JOIN person on p.patient_id=person.person_id
) AS services

UNION ALL
SELECT '8   Number with low AGPPA score(<6 at 5 mins)' AS 'Services',
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
          AND o.value_numeric < 6
INNER JOIN concept c on o.concept_id = c.concept_id
INNER JOIN concept_view cv on c.concept_id = cv.concept_id
    AND cv.concept_full_name IN ("Delivery Note, Liverborn APGAR score at 5 minutes")
INNER JOIN patient p on encounter.patient_id = p.patient_id
INNER JOIN person on p.patient_id=person.person_id
) AS services

UNION ALL

SELECT '9   Number of births with deformities' AS 'Services',
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
          AND o.value_coded = (select concept_id from concept_view where concept_full_name = "True")
INNER JOIN concept c on o.concept_id = c.concept_id
INNER JOIN concept_view cv on c.concept_id = cv.concept_id
    AND cv.concept_full_name IN ("Delivery Note, Liveborn defects present")
INNER JOIN patient p on encounter.patient_id = p.patient_id
INNER JOIN person on p.patient_id=person.person_id
) AS services

UNION ALL

SELECT '10   Number of babies applied Chlorhexidine for cord care' AS 'Services',
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
          AND o.value_coded = (select concept_id from concept_view where concept_full_name = "True")
INNER JOIN concept c on o.concept_id = c.concept_id
INNER JOIN concept_view cv on c.concept_id = cv.concept_id
    AND cv.concept_full_name IN ("Delivery Note, Chlorhexidine applied on cord")
INNER JOIN patient p on encounter.patient_id = p.patient_id
INNER JOIN person on p.patient_id=person.person_id
) AS services

UNION ALL

SELECT '11   Number of neonates  given Vit K' AS 'Services',
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
    AND cv.concept_full_name IN ("Vitamin K")
INNER JOIN patient p on encounter.patient_id = p.patient_id
INNER JOIN person on p.patient_id=person.person_id
) AS services

UNION ALL

SELECT '12   Number of neonates  given tetracyline at birth' AS 'Services',
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
    AND cv.concept_full_name IN ("Tetracyline")
INNER JOIN patient p on encounter.patient_id = p.patient_id
INNER JOIN person on p.patient_id=person.person_id
) AS services

UNION ALL

SELECT '12   Number of pre-term babies' AS 'Services',
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
          AND o.value_numeric < 37
INNER JOIN concept c on o.concept_id = c.concept_id
INNER JOIN concept_view cv on c.concept_id = cv.concept_id
    AND cv.concept_full_name IN ("Delivery Note, Gestation period")
INNER JOIN patient p on encounter.patient_id = p.patient_id
INNER JOIN person on p.patient_id=person.person_id
) AS services

UNION ALL

SELECT '14   Number of babies discharged alive' AS 'Services',
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
    AND cv.concept_full_name IN ("Discharged Baby Alive")
INNER JOIN patient p on encounter.patient_id = p.patient_id
INNER JOIN person on p.patient_id=person.person_id
) AS services

UNION ALL

SELECT '15   Number of infants initiated on breastfeeding within 1 hour of birth' AS 'Services',
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
    AND cv.concept_full_name IN ("Breastfed at birth")
INNER JOIN patient p on encounter.patient_id = p.patient_id
INNER JOIN person on p.patient_id=person.person_id
) AS services

UNION ALL


SELECT '16   Total Deliveries from HIV+ women' AS 'Services',
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
          AND o.value_coded = (select concept_id from concept_view where concept_full_name = "Positive")
INNER JOIN concept c on o.concept_id = c.concept_id
INNER JOIN concept_view cv on c.concept_id = cv.concept_id
    AND cv.concept_full_name IN ("Mother HIV Status")
INNER JOIN patient p on encounter.patient_id = p.patient_id
INNER JOIN person on p.patient_id=person.person_id
) AS services


UNION ALL


SELECT '17   Perinatal Deaths     | Fresh Still birth ' AS 'Services',
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
          AND o.value_coded = (select concept_id from concept_view where concept_full_name = "Fresh stillbirth")
INNER JOIN concept c on o.concept_id = c.concept_id
INNER JOIN concept_view cv on c.concept_id = cv.concept_id
    AND cv.concept_full_name IN ("Delivery Note, Stillbirth type")
INNER JOIN patient p on encounter.patient_id = p.patient_id
INNER JOIN person on p.patient_id=person.person_id
) AS services

UNION ALL


SELECT '18   Perinatal Deaths     | Macerated Still birth ' AS 'Services',
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
          AND o.value_coded = (select concept_id from concept_view where concept_full_name = "Macerated stillbirth")
INNER JOIN concept c on o.concept_id = c.concept_id
INNER JOIN concept_view cv on c.concept_id = cv.concept_id
    AND cv.concept_full_name IN ("Delivery Note, Stillbirth type")
INNER JOIN patient p on encounter.patient_id = p.patient_id
INNER JOIN person on p.patient_id=person.person_id
) AS services

UNION ALL


SELECT '19   Perinatal Deaths     | Death 0-7 days ' AS 'Services',
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
          AND o.value_coded = (select concept_id from concept_view where concept_full_name = "0-7 Days")
INNER JOIN concept c on o.concept_id = c.concept_id
INNER JOIN concept_view cv on c.concept_id = cv.concept_id
    AND cv.concept_full_name IN ("Delivery Note, Stillbirth type")
INNER JOIN patient p on encounter.patient_id = p.patient_id
INNER JOIN person on p.patient_id=person.person_id
) AS services

UNION ALL


SELECT '20   Neonatal Deaths 0-28 Days' AS 'Services',
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
          AND o.value_coded = (select concept_id from concept_view where concept_full_name = "0-7 Days")
INNER JOIN concept c on o.concept_id = c.concept_id
INNER JOIN concept_view cv on c.concept_id = cv.concept_id
    AND cv.concept_full_name IN ("Neonatal Death")
INNER JOIN patient p on encounter.patient_id = p.patient_id
INNER JOIN person on p.patient_id=person.person_id
) AS services

UNION ALL


SELECT '21   Maternal Deaths 10-14 Years' AS 'Services',
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
    AND cv.concept_full_name IN ("Maternal Death")
INNER JOIN patient p on encounter.patient_id = p.patient_id
INNER JOIN person on p.patient_id=person.person_id
) AS services

UNION ALL


SELECT '22   Maternal Deaths 15-19 Years' AS 'Services',
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
    AND cv.concept_full_name IN ("Maternal Death")
INNER JOIN patient p on encounter.patient_id = p.patient_id
INNER JOIN person on p.patient_id=person.person_id
) AS services

UNION ALL


SELECT '23   Maternal Deaths 20-24 Years' AS 'Services',
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
    AND cv.concept_full_name IN ("Maternal Death")
INNER JOIN patient p on encounter.patient_id = p.patient_id
INNER JOIN person on p.patient_id=person.person_id
) AS services

UNION ALL


SELECT '24   Maternal Deaths 25+ Years' AS 'Services',
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
    AND cv.concept_full_name IN ("Maternal Death")
INNER JOIN patient p on encounter.patient_id = p.patient_id
INNER JOIN person on p.patient_id=person.person_id
) AS services

UNION ALL


SELECT '25   Maternal Deaths audited within 7 days' AS 'Services',
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
    AND cv.concept_full_name IN ("Maternal Death audited")
INNER JOIN patient p on encounter.patient_id = p.patient_id
INNER JOIN person on p.patient_id=person.person_id
) AS services

UNION ALL


SELECT '25   Number of Neonatal Deaths audited within 7 days' AS 'Services',
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
    AND cv.concept_full_name IN ("Neoonatal Death Audited")
INNER JOIN patient p on encounter.patient_id = p.patient_id
INNER JOIN person on p.patient_id=person.person_id
) AS services



