SELECT 'A.1.1 Over 5 Years Male' AS 'Age Group',
       IF(client_visits.patient_id IS NULL, 0, SUM(IF(DATE(client_visits.first_visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF(DATE(client_visits.first_visit_date) = DATE(client_visits.visit_date) AND client_visits.patient_gender = 'M', 1, 0),0))) AS 'NEW',
       IF(client_visits.patient_id IS NULL, 0, SUM(IF(DATE(client_visits.first_visit_date) < DATE(client_visits.visit_date),IF(client_visits.patient_gender = 'M', 1, 0),0))) AS 'RE-ATT',
       IF(client_visits.patient_id IS NULL, 0, SUM(IF(client_visits.patient_gender = 'M' , 1, 0))) as 'TOTAL'
FROM
  (SELECT DISTINCT patient.patient_id AS patient_id,
                   observed_age_group.name AS age_group,
                   observed_age_group.id as age_group_id,
                   patient.date_created AS first_visit_date,
                   person.gender AS patient_gender,
                   visit.date_started AS visit_date,
                   observed_age_group.sort_order AS sort_order
   FROM visit
     INNER JOIN patient ON visit.patient_id = patient.patient_id AND DATE(visit.date_started) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND patient.voided = 0 AND visit.voided = 0
     INNER JOIN person ON person.person_id = patient.patient_id AND person.voided = 0
     RIGHT OUTER JOIN reporting_age_group AS observed_age_group ON
                                                                  DATE(visit.date_started) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.min_years YEAR), INTERVAL observed_age_group.min_days DAY))
                                                                  AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.max_years YEAR), INTERVAL observed_age_group.max_days DAY))
   WHERE observed_age_group.id = 3 ) AS client_visits
UNION ALL

SELECT 'A.1.2 Over 5 Years Female' AS 'Age Group',
       IF(client_visits.patient_id IS NULL, 0, SUM(IF(DATE(client_visits.first_visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF(DATE(client_visits.first_visit_date) = DATE(client_visits.visit_date) AND client_visits.patient_gender = 'F', 1, 0),0)))as 'NEW',
       IF(client_visits.patient_id IS NULL, 0, SUM(IF(DATE(client_visits.first_visit_date) < DATE(client_visits.visit_date),IF(client_visits.patient_gender = 'F', 1, 0),0))) AS 'RE-ATT',
       IF(client_visits.patient_id IS NULL, 0, SUM(IF(client_visits.patient_gender = 'F' , 1, 0))) as 'TOTAL'

FROM
  (SELECT DISTINCT patient.patient_id AS patient_id,
                   observed_age_group.name AS age_group,
                   observed_age_group.id as age_group_id,
                   patient.date_created AS first_visit_date,
                   person.gender AS patient_gender,
                   visit.date_started AS visit_date,
                   observed_age_group.sort_order AS sort_order
   FROM visit
     INNER JOIN patient ON visit.patient_id = patient.patient_id AND DATE(visit.date_started) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND patient.voided = 0 AND visit.voided = 0
     INNER JOIN person ON person.person_id = patient.patient_id AND person.voided = 0
     RIGHT OUTER JOIN reporting_age_group AS observed_age_group ON
                                                                  DATE(visit.date_started) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.min_years YEAR), INTERVAL observed_age_group.min_days DAY))
                                                                  AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.max_years YEAR), INTERVAL observed_age_group.max_days DAY))
   WHERE observed_age_group.id = 3 ) AS client_visits

UNION ALL

SELECT 'A.1.3 Children Under 5 Years Male' AS 'Age Group',
       IF(client_visits.patient_id IS NULL, 0, SUM(IF(DATE(client_visits.first_visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF(DATE(client_visits.first_visit_date) = DATE(client_visits.visit_date) AND client_visits.patient_gender = 'M', 1, 0),0))) as 'NEW',
       IF(client_visits.patient_id IS NULL, 0, SUM(IF(DATE(client_visits.first_visit_date) < DATE(client_visits.visit_date),IF(client_visits.patient_gender = 'M', 1, 0),0))) AS 'RE-ATT',
       IF(client_visits.patient_id IS NULL, 0, SUM(IF(client_visits.patient_gender = 'M' , 1, 0))) as 'TOTAL'
FROM
  (SELECT DISTINCT patient.patient_id AS patient_id,
                   observed_age_group.name AS age_group,
                   observed_age_group.id as age_group_id,
                   patient.date_created AS first_visit_date,
                   person.gender AS patient_gender,
                   visit.date_started AS visit_date,
                   observed_age_group.sort_order AS sort_order
   FROM visit
     INNER JOIN patient ON visit.patient_id = patient.patient_id AND DATE(visit.date_started) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND patient.voided = 0 AND visit.voided = 0
     INNER JOIN person ON person.person_id = patient.patient_id AND person.voided = 0
     RIGHT OUTER JOIN reporting_age_group AS observed_age_group ON
                                                                  DATE(visit.date_started) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.min_years YEAR), INTERVAL observed_age_group.min_days DAY))
                                                                  AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.max_years YEAR), INTERVAL observed_age_group.max_days DAY))
   WHERE observed_age_group.id = 2 ) AS client_visits

   UNION ALL

SELECT 'A.1.4 Children Under 5 Years Female' AS 'Age Group',
       IF(client_visits.patient_id IS NULL, 0, SUM(IF(DATE(client_visits.first_visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF(DATE(client_visits.first_visit_date) = DATE(client_visits.visit_date) AND client_visits.patient_gender = 'F', 1, 0),0))) as 'NEW',
       IF(client_visits.patient_id IS NULL, 0, SUM(IF(DATE(client_visits.first_visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND DATE(client_visits.first_visit_date) < DATE(client_visits.visit_date),IF(client_visits.patient_gender = 'F', 1, 0),0))) AS 'RE-ATT',
       IF(client_visits.patient_id IS NULL, 0, SUM(IF(client_visits.patient_gender = 'F' , 1, 0))) as 'TOTAL'
FROM
  (SELECT DISTINCT patient.patient_id AS patient_id,
                   observed_age_group.name AS age_group,
                   observed_age_group.id as age_group_id,
                   patient.date_created AS first_visit_date,
                   person.gender AS patient_gender,
                   visit.date_started AS visit_date,
                   observed_age_group.sort_order AS sort_order
   FROM visit
     INNER JOIN patient ON visit.patient_id = patient.patient_id AND DATE(visit.date_started) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND patient.voided = 0 AND visit.voided = 0
     INNER JOIN person ON person.person_id = patient.patient_id AND person.voided = 0
     RIGHT OUTER JOIN reporting_age_group AS observed_age_group ON
                                                                  DATE(visit.date_started) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.min_years YEAR), INTERVAL observed_age_group.min_days DAY))
                                                                  AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.max_years YEAR), INTERVAL observed_age_group.max_days DAY))
   WHERE observed_age_group.id = 2 ) AS client_visits
UNION ALL

SELECT 'A.1.5 Total General Outpatient' AS 'Age Group',
       IF(client_visits.patient_id IS NULL, 0, SUM(IF(DATE(client_visits.first_visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF(DATE(client_visits.first_visit_date) = DATE(client_visits.visit_date) AND (client_visits.patient_gender = 'F' OR client_visits.patient_gender = 'M'), 1, 0),0))) as 'NEW',
       IF(client_visits.patient_id IS NULL, 0, SUM(IF(DATE(client_visits.first_visit_date) < DATE(client_visits.visit_date),IF(client_visits.patient_gender = 'F' OR client_visits.patient_gender = 'M', 1, 0),0))) AS 'RE-ATT',
       IF(client_visits.patient_id IS NULL, 0, SUM(IF(client_visits.patient_gender = 'F' OR client_visits.patient_gender = 'M' , 1, 0))) as 'TOTAL'
FROM
  (SELECT DISTINCT patient.patient_id AS patient_id,
                   observed_age_group.name AS age_group,
                   observed_age_group.id as age_group_id,
                   patient.date_created AS first_visit_date,
                   person.gender AS patient_gender,
                   visit.date_started AS visit_date,
                   observed_age_group.sort_order AS sort_order
   FROM visit
     INNER JOIN patient ON visit.patient_id = patient.patient_id AND DATE(visit.date_started) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND patient.voided = 0 AND visit.voided = 0
     INNER JOIN person ON person.person_id = patient.patient_id AND person.voided = 0
     RIGHT OUTER JOIN reporting_age_group AS observed_age_group ON
                                                                  DATE(visit.date_started) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.min_years YEAR), INTERVAL observed_age_group.min_days DAY))
                                                                  AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.max_years YEAR), INTERVAL observed_age_group.max_days DAY))
   WHERE observed_age_group.id = 1) AS client_visits
UNION ALL

SELECT 'A.2  CASUALTY' AS 'Age Group',
     ' ' as 'NEW',
     ' ' as 'RE-ATT',
     ' ' as 'TOTAL'

UNION ALL

SELECT 'A.3  Special Clinics ' AS 'Age Group',
     ' ' as 'NEW',
     ' ' as 'RE-ATT',
     ' ' as 'TOTAL'

    UNION ALL

SELECT 'A.3.1   E.N.T Clinic' AS 'Age Group',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) = DATE(services.visit_date),IF(services.voided = 0, 1, 0),0))) AS 'NEW',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) < DATE(services.visit_date),IF(services.voided = 0, 1, 0),0))) AS 'RE-ATT1',
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
     INNER JOIN visit ON visit.visit_id=encounter.visit_id AND DATE(visit.date_started) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)  AND visit.voided = 0
     INNER JOIN patient ON patient.patient_id=visit.patient_id AND patient.voided = 0
WHERE form_concepts_map.map_id =1 ) AS services

   UNION ALL

SELECT 'A.3.2    Eye Clinic' AS 'Services',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) = DATE(services.visit_date),IF(services.voided = 0, 1, 0),0))) AS 'NEW',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) < DATE(services.visit_date),IF(services.voided = 0, 1, 0),0))) AS 'RE-ATT1',
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
     INNER JOIN visit ON visit.visit_id=encounter.visit_id AND DATE(visit.date_started) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND visit.voided = 0
     INNER JOIN patient ON patient.patient_id=visit.patient_id AND patient.voided = 0
WHERE form_concepts_map.map_id =2 ) AS services
   UNION ALL

SELECT 'A.3.3    TB and Leprosy' AS 'Services',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) = DATE(services.visit_date),IF(services.voided = 0, 1, 0),0))) AS 'NEW',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) < DATE(services.visit_date),IF(services.voided = 0, 1, 0),0))) AS 'RE-ATT1',
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
     INNER JOIN visit ON visit.visit_id=encounter.visit_id AND DATE(visit.date_started) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND visit.voided = 0
     INNER JOIN patient ON patient.patient_id=visit.patient_id AND patient.voided = 0
WHERE form_concepts_map.map_id =3 ) AS services
   UNION ALL

SELECT 'A.3.4    Sexually Transmitted Infections' AS 'Services',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) = DATE(services.visit_date),IF(services.voided = 0, 1, 0),0))) AS 'NEW',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) < DATE(services.visit_date),IF(services.voided = 0, 1, 0),0))) AS 'RE-ATT1',
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
     INNER JOIN visit ON visit.visit_id=encounter.visit_id AND DATE(visit.date_started) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND visit.voided = 0
     INNER JOIN patient ON patient.patient_id=visit.patient_id AND patient.voided = 0
WHERE form_concepts_map.map_id =4 ) AS services
   UNION ALL

SELECT 'A.3.5    Psychiatry' AS 'Services',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) = DATE(services.visit_date),IF(services.voided = 0, 1, 0),0))) AS 'NEW',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) < DATE(services.visit_date),IF(services.voided = 0, 1, 0),0))) AS 'RE-ATT1',
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
     INNER JOIN visit ON visit.visit_id=encounter.visit_id AND DATE(visit.date_started) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND visit.voided = 0
     INNER JOIN patient ON patient.patient_id=visit.patient_id AND patient.voided = 0
WHERE form_concepts_map.map_id =5 ) AS services
   UNION ALL

SELECT 'A.3.6    Orthopedic Clinic' AS 'Services',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) = DATE(services.visit_date),IF(services.voided = 0, 1, 0),0))) AS 'NEW',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) < DATE(services.visit_date),IF(services.voided = 0, 1, 0),0))) AS 'RE-ATT1',
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
     INNER JOIN visit ON visit.visit_id=encounter.visit_id AND DATE(visit.date_started) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND visit.voided = 0
     INNER JOIN patient ON patient.patient_id=visit.patient_id AND patient.voided = 0
WHERE form_concepts_map.map_id =6 ) AS services
   UNION ALL

SELECT 'A.3.7    All Other Special Clinics' AS 'Services',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) = DATE(services.visit_date),IF(services.voided = 0, 1, 0),0))) AS 'NEW',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) < DATE(services.visit_date),IF(services.voided = 0, 1, 0),0))) AS 'RE-ATT1',
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
     INNER JOIN visit ON visit.visit_id=encounter.visit_id AND DATE(visit.date_started) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND visit.voided = 0
     INNER JOIN patient ON patient.patient_id=visit.patient_id AND patient.voided = 0
WHERE form_concepts_map.map_id =7) AS services

   UNION ALL

SELECT 'A.3.8    Total Special Clinics' AS 'Services',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) = DATE(services.visit_date),IF(services.voided = 0, 1, 0),0))) AS 'NEW',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) < DATE(services.visit_date),IF(services.voided = 0, 1, 0),0))) AS 'RE-ATT1',
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
     INNER JOIN visit ON visit.visit_id=encounter.visit_id AND DATE(visit.date_started) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND visit.voided = 0
     INNER JOIN patient ON patient.patient_id=visit.patient_id AND patient.voided = 0
WHERE form_concepts_map.map_id <=6 ) AS services



UNION ALL

SELECT 'A.4  MCH/FP CLIENTS ' AS 'Age Group',
     ' ' as 'NEW',
     ' ' AS 'RE-ATT',
     ' ' as 'TOTAL'

    UNION ALL
SELECT 'A.4.1    CWC Attendance' AS 'Services',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) = DATE(services.visit_date),IF(services.voided = 0, 1, 0),0))) AS 'NEW',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) < DATE(services.visit_date),IF(services.voided = 0, 1, 0),0))) AS 'RE-ATT1',
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
     INNER JOIN visit ON visit.visit_id=encounter.visit_id AND DATE(visit.date_started) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND visit.voided = 0
     INNER JOIN patient ON patient.patient_id=visit.patient_id AND patient.voided = 0
WHERE form_concepts_map.map_id =8 ) AS services

UNION ALL
SELECT 'A.4.2    ANC Attendance' AS 'Services',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) = DATE(services.visit_date),IF(services.voided = 0, 1, 0),0))) AS 'NEW',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) < DATE(services.visit_date),IF(services.voided = 0, 1, 0),0))) AS 'RE-ATT1',
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
     INNER JOIN visit ON visit.visit_id=encounter.visit_id AND DATE(visit.date_started) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND visit.voided = 0
     INNER JOIN patient ON patient.patient_id=visit.patient_id AND patient.voided = 0
WHERE form_concepts_map.map_id =8 ) AS services

UNION ALL
SELECT 'A.4.3    PNC Attendance' AS 'Services',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) = DATE(services.visit_date),IF(services.voided = 0, 1, 0),0))) AS 'NEW',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) < DATE(services.visit_date),IF(services.voided = 0, 1, 0),0))) AS 'RE-ATT1',
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
     INNER JOIN visit ON visit.visit_id=encounter.visit_id AND DATE(visit.date_started) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND visit.voided = 0
     INNER JOIN patient ON patient.patient_id=visit.patient_id AND patient.voided = 0
WHERE form_concepts_map.map_id =9 ) AS services

UNION ALL
SELECT 'A.4.4    FP Attendance' AS 'Services',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) = DATE(services.visit_date) AND DATE(services.visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF(services.voided = 0, 1, 0),0))) AS 'NEW',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) < DATE(services.visit_date) AND DATE(services.visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF(services.voided = 0, 1, 0),0))) AS 'RE-ATT1',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND services.voided = 0 , 1, 0))) as 'TOTAL'
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
     INNER JOIN visit ON visit.visit_id=encounter.visit_id AND DATE(visit.date_started) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND visit.voided = 0
     INNER JOIN patient ON patient.patient_id=visit.patient_id AND patient.voided = 0
WHERE form_concepts_map.map_id =10 ) AS services

UNION ALL
SELECT 'A.4.5    TOTAL MCH/FP' AS 'Services',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) = DATE(services.visit_date) AND DATE(services.visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF(services.voided = 0, 1, 0),0))) AS 'NEW',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) < DATE(services.visit_date) AND DATE(services.visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF(services.voided = 0, 1, 0),0))) AS 'RE-ATT1',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND services.voided = 0 , 1, 0))) as 'TOTAL'
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
     INNER JOIN visit ON visit.visit_id=encounter.visit_id AND DATE(visit.date_started) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND visit.voided = 0
     INNER JOIN patient ON patient.patient_id=visit.patient_id AND patient.voided = 0
WHERE form_concepts_map.map_id >7 AND form_concepts_map.map_id <12  ) AS services

UNION ALL

SELECT 'A.5    DENTAL CLINIC' AS 'Age Group',
     ' ' as 'NEW',
     ' ' AS 'RE-ATT',
     ' ' as 'TOTAL'

UNION ALL
SELECT 'A.4.5.1    Attendance (Excluding fillings and Extractions)' AS 'Services',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) = DATE(services.visit_date) AND DATE(services.visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF(services.voided = 0, 1, 0),0))) AS 'NEW',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) < DATE(services.visit_date) AND DATE(services.visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF(services.voided = 0, 1, 0),0))) AS 'RE-ATT1',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND services.voided = 0 , 1, 0))) as 'TOTAL'
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
WHERE form_concepts_map.map_id =12 ) AS services

UNION ALL
SELECT 'A.4.5.2    Fillings' AS 'Services',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) = DATE(services.visit_date) AND DATE(services.visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF(services.voided = 0, 1, 0),0))) AS 'NEW',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) < DATE(services.visit_date) AND DATE(services.visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF(services.voided = 0, 1, 0),0))) AS 'RE-ATT1',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND services.voided = 0 , 1, 0))) as 'TOTAL'
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
WHERE form_concepts_map.map_id =12 ) AS services
UNION ALL
SELECT 'A.4.5.3    Extractions' AS 'Services',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) = DATE(services.visit_date) AND DATE(services.visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF(services.voided = 0, 1, 0),0))) AS 'NEW',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) < DATE(services.visit_date) AND DATE(services.visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF(services.voided = 0, 1, 0),0))) AS 'RE-ATT1',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND services.voided = 0 , 1, 0))) as 'TOTAL'
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
WHERE form_concepts_map.map_id =12 ) AS services

UNION ALL
SELECT 'A.4.5.4    TOTAL DENTAL SERVICES' AS 'Services',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) = DATE(services.visit_date) AND DATE(services.visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF(services.voided = 0, 1, 0),0))) AS 'NEW',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) < DATE(services.visit_date) AND DATE(services.visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF(services.voided = 0, 1, 0),0))) AS 'RE-ATT1',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND services.voided = 0 , 1, 0))) as 'TOTAL'
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
WHERE form_concepts_map.map_id =12 ) AS services

UNION ALL

SELECT 'A.6     Total Outpatient Services' AS 'Age Group',
       IF(client_visits.patient_id IS NULL, 0, SUM(IF(DATE(client_visits.first_visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF(DATE(client_visits.first_visit_date) = DATE(client_visits.visit_date) AND client_visits.patient_gender = 'F', 1, 1),0))) as 'NEW',
       IF(client_visits.patient_id IS NULL, 0, SUM(IF(DATE(client_visits.first_visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND DATE(client_visits.first_visit_date) < DATE(client_visits.visit_date),IF(client_visits.patient_gender = 'F', 1, 1),0))) AS 'RE-ATT',
       IF(client_visits.patient_id IS NULL, 0, SUM(IF(DATE(client_visits.first_visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF(client_visits.patient_gender = 'F', 1, 1),0))) as 'TOTAL'
FROM
  (SELECT DISTINCT patient.patient_id AS patient_id,
                   observed_age_group.name AS age_group,
                   observed_age_group.id as age_group_id,
                   visit.voided AS voided,
                   patient.date_created AS first_visit_date,
                   visit.date_started AS visit_date,
                   person.gender AS patient_gender,
                   observed_age_group.sort_order AS sort_order
   FROM visit
     INNER JOIN patient ON visit.patient_id = patient.patient_id AND DATE(visit.date_started) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND patient.voided = 0 AND visit.voided = 0
     INNER JOIN person ON person.person_id = patient.patient_id AND person.voided = 0
     RIGHT OUTER JOIN reporting_age_group AS observed_age_group ON
                                                                  DATE(visit.date_started) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.min_years YEAR), INTERVAL observed_age_group.min_days DAY))
                                                                  AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.max_years YEAR), INTERVAL observed_age_group.max_days DAY))
   WHERE observed_age_group.id = 2 OR observed_age_group.id = 3 ) AS client_visits

   UNION ALL
SELECT 'A.7    Medical Examinations(Except p3) ' AS 'Services',
       IF(services.obs_id IS NULL, 0, SUM(IF(services.voided = 0, 1, 0))) as 'NEW',
       0 AS 'RE-ATT',
       0 AS 'TOTAL'
FROM
  (SELECT DISTINCT obs.obs_id AS obs_id,
                   obs.voided AS voided,
                   obs.obs_datetime AS datetime,
                   form_concepts_map.form_name AS form_name
   FROM form_concepts_map
     LEFT OUTER JOIN obs ON obs.concept_id = form_concepts_map.concept_id
WHERE form_concepts_map.map_id =12 ) AS services

