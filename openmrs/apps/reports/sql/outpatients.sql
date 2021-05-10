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
     INNER JOIN visit_type ON visit_type.visit_type_id = visit.visit_type_id
                AND visit_type.name IN ("OPD")
     INNER JOIN person ON person.person_id = patient.patient_id AND person.voided = 0
     RIGHT OUTER JOIN reporting_age_group AS observed_age_group ON
                                                                  DATE(visit.date_started) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.min_years YEAR), INTERVAL observed_age_group.min_days DAY))
                                                                  AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.max_years YEAR), INTERVAL observed_age_group.max_days DAY))
   WHERE observed_age_group.id = 3 
   ) AS client_visits
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
     INNER JOIN visit_type ON visit_type.visit_type_id = visit.visit_type_id
                              AND visit_type.name IN ("OPD")
     INNER JOIN patient ON visit.patient_id = patient.patient_id AND DATE(visit.date_started) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND patient.voided = 0 AND visit.voided = 0
     INNER JOIN person ON person.person_id = patient.patient_id AND person.voided = 0
     RIGHT OUTER JOIN reporting_age_group AS observed_age_group ON
                                                                  DATE(visit.date_started) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.min_years YEAR), INTERVAL observed_age_group.min_days DAY))
                                                                  AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.max_years YEAR), INTERVAL observed_age_group.max_days DAY))
   WHERE observed_age_group.id = 3 
   ) AS client_visits

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
     INNER JOIN visit_type ON visit_type.visit_type_id = visit.visit_type_id
                              AND visit_type.name IN ("OPD")
     INNER JOIN patient ON visit.patient_id = patient.patient_id AND DATE(visit.date_started) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND patient.voided = 0 AND visit.voided = 0
     INNER JOIN person ON person.person_id = patient.patient_id AND person.voided = 0
     RIGHT OUTER JOIN reporting_age_group AS observed_age_group ON
                                                                  DATE(visit.date_started) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.min_years YEAR), INTERVAL observed_age_group.min_days DAY))
                                                                  AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.max_years YEAR), INTERVAL observed_age_group.max_days DAY))
   WHERE observed_age_group.id = 2 
   ) AS client_visits

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
     INNER JOIN visit_type ON visit_type.visit_type_id = visit.visit_type_id
                              AND visit_type.name IN ("OPD")
     INNER JOIN patient ON visit.patient_id = patient.patient_id AND DATE(visit.date_started) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND patient.voided = 0 AND visit.voided = 0
     INNER JOIN person ON person.person_id = patient.patient_id AND person.voided = 0
     RIGHT OUTER JOIN reporting_age_group AS observed_age_group ON
                                                                  DATE(visit.date_started) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.min_years YEAR), INTERVAL observed_age_group.min_days DAY))
                                                                  AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.max_years YEAR), INTERVAL observed_age_group.max_days DAY))
   WHERE observed_age_group.id = 2 
   ) AS client_visits
UNION ALL

SELECT 'A.1.5 Over 60 Years' AS 'Age Group',
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
     INNER JOIN visit_type ON visit_type.visit_type_id = visit.visit_type_id
                              AND visit_type.name IN ("OPD")
     INNER JOIN patient ON visit.patient_id = patient.patient_id AND DATE(visit.date_started) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND patient.voided = 0 AND visit.voided = 0
     INNER JOIN person ON person.person_id = patient.patient_id AND person.voided = 0
     RIGHT OUTER JOIN reporting_age_group AS observed_age_group ON
                                                                  DATE(visit.date_started) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 60 YEAR), INTERVAL 1 DAY))
                                                                  AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY))
   WHERE observed_age_group.id = 1
   ) AS client_visits
UNION ALL

SELECT 'A.1.5 Total General Outpatient' AS 'Age Group',
       IF(client_visits.patient_id IS NULL, 0, SUM(IF(DATE(client_visits.first_visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF(DATE(client_visits.first_visit_date) = DATE(client_visits.visit_date)  AND (client_visits.age < 60) AND (client_visits.patient_gender = 'F' OR client_visits.patient_gender = 'M'), 1, 0),0))) as 'NEW',
       IF(client_visits.patient_id IS NULL, 0, SUM(IF(DATE(client_visits.first_visit_date) < DATE(client_visits.visit_date) AND (client_visits.age < 60),IF(client_visits.patient_gender = 'F' OR client_visits.patient_gender = 'M', 1, 0),0))) AS 'RE-ATT',
       IF(client_visits.patient_id IS NULL, 0, SUM(IF(client_visits.age < 60 , 1, 0))) as 'TOTAL'
FROM
  (SELECT DISTINCT patient.patient_id AS patient_id,
                   observed_age_group.name AS age_group,
                   observed_age_group.id as age_group_id,
                   patient.date_created AS first_visit_date,
                   person.gender AS patient_gender,
                   person.birthdate,
                   TIMESTAMPDIFF(YEAR, person.birthdate, CURDATE()) AS age,
                   visit.date_started AS visit_date,
                   observed_age_group.sort_order AS sort_order
   FROM visit
     INNER JOIN visit_type ON visit_type.visit_type_id = visit.visit_type_id
                              AND visit_type.name IN ("OPD")
     INNER JOIN patient ON visit.patient_id = patient.patient_id AND DATE(visit.date_started) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND patient.voided = 0 AND visit.voided = 0
     INNER JOIN person ON person.person_id = patient.patient_id AND person.voided = 0
     RIGHT OUTER JOIN reporting_age_group AS observed_age_group ON
                                                                  DATE(visit.date_started) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.min_years YEAR), INTERVAL observed_age_group.min_days DAY))
                                                                  AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.max_years YEAR), INTERVAL observed_age_group.max_days DAY))
   WHERE observed_age_group.id = 1
   ) AS client_visits
UNION ALL

SELECT 'A.2  CASUALTY' AS 'Age Group',
     ' ' as 'NEW',
     ' ' as 'RE-ATT',
     ' ' as 'TOTAL'

UNION ALL

SELECT 'A.3  Special Clinics(if recorded separately from General Clinics) ' AS 'Age Group',
     ' ' as 'NEW',
     ' ' as 'RE-ATT',
     ' ' as 'TOTAL'

    UNION ALL

SELECT 'A.3.1   E.N.T Clinic' AS 'Age Group',
  IF(client_visits.patient_id IS NULL, 0, SUM(IF(DATE(client_visits.first_visit_date) = DATE(client_visits.visit_date) , 1, 0))) as 'NEW',
  IF(client_visits.patient_id IS NULL, 0, SUM(IF(DATE(client_visits.first_visit_date) < DATE(client_visits.visit_date) , 1, 0))) AS 'RE-ATT',
  IF(client_visits.patient_id IS NULL, 0, SUM(IF(client_visits.patient_gender = 'F' OR client_visits.patient_gender = 'M' , 1, 0))) as 'TOTAL'
FROM
  (SELECT DISTINCT patient.patient_id AS patient_id,
                   patient.date_created AS first_visit_date,
                   person.gender AS patient_gender,
                   visit.date_started AS visit_date,
                   obs.obs_datetime

   FROM form_concepts_map
     INNER JOIN obs ON obs.concept_id = form_concepts_map.concept_id
     INNER JOIN encounter ON encounter.encounter_id=obs.encounter_id
     INNER JOIN visit ON visit.visit_id = encounter.visit_id
     INNER JOIN patient ON obs.person_id = patient.patient_id AND DATE(obs.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND patient.voided = 0 AND obs.voided = 0
     INNER JOIN person ON person.person_id = patient.patient_id AND person.voided = 0

   WHERE  form_concepts_map.map_id =1
   GROUP BY patient.patient_id) AS client_visits

   UNION ALL

SELECT 'A.3.2    Eye Clinic' AS 'Services',
  IF(client_visits.patient_id IS NULL, 0, SUM(IF(DATE(client_visits.first_visit_date) = DATE(client_visits.visit_date) , 1, 0))) as 'NEW',
  IF(client_visits.patient_id IS NULL, 0, SUM(IF(DATE(client_visits.first_visit_date) < DATE(client_visits.visit_date) , 1, 0))) AS 'RE-ATT',
  IF(client_visits.patient_id IS NULL, 0, SUM(IF(client_visits.patient_gender = 'F' OR client_visits.patient_gender = 'M' , 1, 0))) as 'TOTAL'
FROM
  (SELECT DISTINCT patient.patient_id AS patient_id,
                   patient.date_created AS first_visit_date,
                   person.gender AS patient_gender,
                   visit.date_started AS visit_date,
     obs.obs_datetime

   FROM form_concepts_map
     INNER JOIN obs ON obs.concept_id = form_concepts_map.concept_id
     INNER JOIN encounter ON encounter.encounter_id=obs.encounter_id
     INNER JOIN visit ON visit.visit_id = encounter.visit_id
     INNER JOIN patient ON obs.person_id = patient.patient_id AND DATE(obs.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND patient.voided = 0 AND obs.voided = 0
     INNER JOIN person ON person.person_id = patient.patient_id AND person.voided = 0

   WHERE  form_concepts_map.map_id =2
   GROUP BY patient.patient_id) AS client_visits

UNION ALL

SELECT 'A.3.3    TB and Leprosy' AS 'Services',
  IF(client_visits.patient_id IS NULL, 0, SUM(IF(DATE(client_visits.first_visit_date) = DATE(client_visits.visit_date) , 1, 0))) as 'NEW',
  IF(client_visits.patient_id IS NULL, 0, SUM(IF(DATE(client_visits.first_visit_date) < DATE(client_visits.visit_date) , 1, 0))) AS 'RE-ATT',
  IF(client_visits.patient_id IS NULL, 0, SUM(IF(client_visits.patient_gender = 'F' OR client_visits.patient_gender = 'M' , 1, 0))) as 'TOTAL'
FROM
  (SELECT DISTINCT patient.patient_id AS patient_id,
                   patient.date_created AS first_visit_date,
                   person.gender AS patient_gender,
                   visit.date_started AS visit_date,
     obs.obs_datetime

   FROM form_concepts_map
     INNER JOIN obs ON obs.concept_id = form_concepts_map.concept_id
     INNER JOIN encounter ON encounter.encounter_id=obs.encounter_id
     INNER JOIN visit ON visit.visit_id = encounter.visit_id
     INNER JOIN patient ON obs.person_id = patient.patient_id AND DATE(obs.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND patient.voided = 0 AND obs.voided = 0
     INNER JOIN person ON person.person_id = patient.patient_id AND person.voided = 0

   WHERE  form_concepts_map.map_id =3
   GROUP BY patient.patient_id) AS client_visits
   UNION ALL

SELECT 'A.3.4    Comprehensive Care Clinic (CCC)' AS 'Services',
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
     INNER JOIN visit_type ON visit_type.visit_type_id = visit.visit_type_id
                              AND visit_type.name IN ("CCC")
     INNER JOIN patient ON visit.patient_id = patient.patient_id AND DATE(visit.date_started) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND patient.voided = 0 AND visit.voided = 0
     INNER JOIN person ON person.person_id = patient.patient_id AND person.voided = 0
     RIGHT OUTER JOIN reporting_age_group AS observed_age_group ON
                                                                  DATE(visit.date_started) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.min_years YEAR), INTERVAL observed_age_group.min_days DAY))
                                                                  AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.max_years YEAR), INTERVAL observed_age_group.max_days DAY))
   WHERE observed_age_group.id = 1) AS client_visits
   UNION ALL

SELECT 'A.3.5    Psychiatry' AS 'Services',
  IF(client_visits.patient_id IS NULL, 0, SUM(IF(DATE(client_visits.first_visit_date) = DATE(client_visits.visit_date) , 1, 0))) as 'NEW',
  IF(client_visits.patient_id IS NULL, 0, SUM(IF(DATE(client_visits.first_visit_date) < DATE(client_visits.visit_date) , 1, 0))) AS 'RE-ATT',
  IF(client_visits.patient_id IS NULL, 0, SUM(IF(client_visits.patient_gender = 'F' OR client_visits.patient_gender = 'M' , 1, 0))) as 'TOTAL'
FROM
  (SELECT DISTINCT patient.patient_id AS patient_id,
                   patient.date_created AS first_visit_date,
                   person.gender AS patient_gender,
                   visit.date_started AS visit_date,
     obs.obs_datetime

   FROM form_concepts_map
     INNER JOIN obs ON obs.concept_id = form_concepts_map.concept_id
     INNER JOIN encounter ON encounter.encounter_id=obs.encounter_id
     INNER JOIN visit ON visit.visit_id = encounter.visit_id
     INNER JOIN patient ON obs.person_id = patient.patient_id AND DATE(obs.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND patient.voided = 0 AND obs.voided = 0
     INNER JOIN person ON person.person_id = patient.patient_id AND person.voided = 0

   WHERE  form_concepts_map.map_id =5
   GROUP BY patient.patient_id) AS client_visits
   UNION ALL

SELECT 'A.3.6    Orthopedic Clinic' AS 'Services',
  IF(client_visits.patient_id IS NULL, 0, SUM(IF(DATE(client_visits.first_visit_date) = DATE(client_visits.visit_date) , 1, 0))) as 'NEW',
  IF(client_visits.patient_id IS NULL, 0, SUM(IF(DATE(client_visits.first_visit_date) < DATE(client_visits.visit_date) , 1, 0))) AS 'RE-ATT',
  IF(client_visits.patient_id IS NULL, 0, SUM(IF(client_visits.patient_gender = 'F' OR client_visits.patient_gender = 'M' , 1, 0))) as 'TOTAL'
FROM
  (SELECT DISTINCT patient.patient_id AS patient_id,
                   patient.date_created AS first_visit_date,
                   person.gender AS patient_gender,
                   visit.date_started AS visit_date,
     obs.obs_datetime

   FROM form_concepts_map
     INNER JOIN obs ON obs.concept_id = form_concepts_map.concept_id
     INNER JOIN encounter ON encounter.encounter_id=obs.encounter_id
     INNER JOIN visit ON visit.visit_id = encounter.visit_id
     INNER JOIN patient ON obs.person_id = patient.patient_id AND DATE(obs.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND patient.voided = 0 AND obs.voided = 0
     INNER JOIN person ON person.person_id = patient.patient_id AND person.voided = 0

   WHERE  form_concepts_map.map_id =6
   GROUP BY patient.patient_id) AS client_visits
   UNION ALL

SELECT 'A.3.7    Occupational Therapy Clinic' AS 'Services',
  IF(client_visits.patient_id IS NULL, 0, SUM(IF(DATE(client_visits.first_visit_date) = DATE(client_visits.visit_date) , 1, 0))) as 'NEW',
  IF(client_visits.patient_id IS NULL, 0, SUM(IF(DATE(client_visits.first_visit_date) < DATE(client_visits.visit_date) , 1, 0))) AS 'RE-ATT',
  IF(client_visits.patient_id IS NULL, 0, SUM(IF(client_visits.patient_gender = 'F' OR client_visits.patient_gender = 'M' , 1, 0))) as 'TOTAL'
FROM
  (SELECT DISTINCT patient.patient_id AS patient_id,
                   patient.date_created AS first_visit_date,
                   person.gender AS patient_gender,
                   visit.date_started AS visit_date,
     obs.obs_datetime

   FROM  obs
     INNER JOIN concept_view cv ON cv.concept_id = obs.concept_id
            AND cv.concept_full_name="Occupational Therapy Template"
            AND obs.voided = 0
     INNER JOIN encounter ON encounter.encounter_id=obs.encounter_id
     INNER JOIN visit ON visit.visit_id = encounter.visit_id
     INNER JOIN patient ON obs.person_id = patient.patient_id AND DATE(obs.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND patient.voided = 0 AND obs.voided = 0
     INNER JOIN person ON person.person_id = patient.patient_id AND person.voided = 0
   GROUP BY patient.patient_id
   ) AS client_visits
UNION ALL

SELECT 'A.3.8    Physiotherapy Clinic' AS 'Services',
  IF(client_visits.patient_id IS NULL, 0, SUM(IF(DATE(client_visits.first_visit_date) = DATE(client_visits.visit_date) , 1, 0))) as 'NEW',
  IF(client_visits.patient_id IS NULL, 0, SUM(IF(DATE(client_visits.first_visit_date) < DATE(client_visits.visit_date) , 1, 0))) AS 'RE-ATT',
  IF(client_visits.patient_id IS NULL, 0, SUM(IF(client_visits.patient_gender = 'F' OR client_visits.patient_gender = 'M' , 1, 0))) as 'TOTAL'
FROM
  (SELECT DISTINCT patient.patient_id AS patient_id,
                   patient.date_created AS first_visit_date,
                   person.gender AS patient_gender,
                   visit.date_started AS visit_date,
     obs.obs_datetime

   FROM  obs
     INNER JOIN concept_view cv ON cv.concept_id = obs.concept_id
                                   AND cv.concept_full_name IN ("Physiotherapy Template")
                                   AND obs.voided = 0
     INNER JOIN encounter ON encounter.encounter_id=obs.encounter_id
     INNER JOIN visit ON visit.visit_id = encounter.visit_id
     INNER JOIN patient ON obs.person_id = patient.patient_id AND DATE(obs.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND patient.voided = 0 AND obs.voided = 0
     INNER JOIN person ON person.person_id = patient.patient_id AND person.voided = 0
   GROUP BY patient.patient_id
  ) AS client_visits
UNION ALL


SELECT 'A.3.9    Medical Clinics' AS 'Services',
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
     INNER JOIN visit_type ON visit_type.visit_type_id = visit.visit_type_id
                              AND visit_type.name IN ("Medical")
     INNER JOIN patient ON visit.patient_id = patient.patient_id AND DATE(visit.date_started) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND patient.voided = 0 AND visit.voided = 0
     INNER JOIN person ON person.person_id = patient.patient_id AND person.voided = 0
     RIGHT OUTER JOIN reporting_age_group AS observed_age_group ON
                                                                  DATE(visit.date_started) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.min_years YEAR), INTERVAL observed_age_group.min_days DAY))
                                                                  AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.max_years YEAR), INTERVAL observed_age_group.max_days DAY))
   WHERE observed_age_group.id = 1) AS client_visits
UNION ALL

SELECT 'A.3.10    Surgical Clinics' AS 'Services',
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
     INNER JOIN visit_type ON visit_type.visit_type_id = visit.visit_type_id
                              AND visit_type.name IN ("Surgical")
     INNER JOIN patient ON visit.patient_id = patient.patient_id AND DATE(visit.date_started) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND patient.voided = 0 AND visit.voided = 0
     INNER JOIN person ON person.person_id = patient.patient_id AND person.voided = 0
     RIGHT OUTER JOIN reporting_age_group AS observed_age_group ON
                                                                  DATE(visit.date_started) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.min_years YEAR), INTERVAL observed_age_group.min_days DAY))
                                                                  AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.max_years YEAR), INTERVAL observed_age_group.max_days DAY))
   WHERE observed_age_group.id = 1) AS client_visits
UNION ALL

SELECT 'A.3.11    Pediatrics' AS 'Services',
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
     INNER JOIN visit_type ON visit_type.visit_type_id = visit.visit_type_id
                              AND visit_type.name IN ("Pediatric")
     INNER JOIN patient ON visit.patient_id = patient.patient_id AND DATE(visit.date_started) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND patient.voided = 0 AND visit.voided = 0
     INNER JOIN person ON person.person_id = patient.patient_id AND person.voided = 0
     RIGHT OUTER JOIN reporting_age_group AS observed_age_group ON
                                                                  DATE(visit.date_started) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.min_years YEAR), INTERVAL observed_age_group.min_days DAY))
                                                                  AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.max_years YEAR), INTERVAL observed_age_group.max_days DAY))
   WHERE observed_age_group.id = 1) AS client_visits
UNION ALL


SELECT 'A.3.12    Obsterics/Gynaecoology' AS 'Services',
  IF(client_visits.patient_id IS NULL, 0, SUM(IF(DATE(client_visits.first_visit_date) = DATE(client_visits.visit_date) , 1, 0))) as 'NEW',
  IF(client_visits.patient_id IS NULL, 0, SUM(IF(DATE(client_visits.first_visit_date) < DATE(client_visits.visit_date) , 1, 0))) AS 'RE-ATT',
  IF(client_visits.patient_id IS NULL, 0, SUM(IF(client_visits.patient_gender = 'F' OR client_visits.patient_gender = 'M' , 1, 0))) as 'TOTAL'
FROM
  (SELECT DISTINCT patient.patient_id AS patient_id,
                   patient.date_created AS first_visit_date,
                   person.gender AS patient_gender,
                   visit.date_started AS visit_date,
     obs.obs_datetime

   FROM  obs
     INNER JOIN concept_view cv ON cv.concept_id = obs.concept_id
                                   AND cv.concept_full_name IN ("Obstetrics", "Gynaecology")
                                   AND obs.voided = 0
     INNER JOIN encounter ON encounter.encounter_id=obs.encounter_id
     INNER JOIN visit ON visit.visit_id = encounter.visit_id
     INNER JOIN patient ON obs.person_id = patient.patient_id AND DATE(obs.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND patient.voided = 0 AND obs.voided = 0
     INNER JOIN person ON person.person_id = patient.patient_id AND person.voided = 0
  GROUP BY patient.patient_id
  ) AS client_visits
UNION ALL

SELECT 'A.3.13    Nutrition Clinic' AS 'Services',
  IF(client_visits.patient_id IS NULL, 0, SUM(IF(DATE(client_visits.first_visit_date) = DATE(client_visits.visit_date) , 1, 0))) as 'NEW',
  IF(client_visits.patient_id IS NULL, 0, SUM(IF(DATE(client_visits.first_visit_date) < DATE(client_visits.visit_date) , 1, 0))) AS 'RE-ATT',
  IF(client_visits.patient_id IS NULL, 0, SUM(IF(client_visits.patient_gender = 'F' OR client_visits.patient_gender = 'M' , 1, 0))) as 'TOTAL'
FROM
  (SELECT DISTINCT patient.patient_id AS patient_id,
                   patient.date_created AS first_visit_date,
                   person.gender AS patient_gender,
                   visit.date_started AS visit_date,
     obs.obs_datetime

   FROM  obs
     INNER JOIN concept_view cv ON cv.concept_id = obs.concept_id
                                   AND cv.concept_full_name IN ("Nutrition")
                                   AND obs.voided = 0
     INNER JOIN encounter ON encounter.encounter_id=obs.encounter_id
     INNER JOIN visit ON visit.visit_id = encounter.visit_id
     INNER JOIN patient ON obs.person_id = patient.patient_id AND DATE(obs.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND patient.voided = 0 AND obs.voided = 0
     INNER JOIN person ON person.person_id = patient.patient_id AND person.voided = 0
   GROUP BY patient.patient_id
  ) AS client_visits
UNION ALL

SELECT 'A.3.14    Oncology Clinic' AS 'Services',
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
     INNER JOIN visit_type ON visit_type.visit_type_id = visit.visit_type_id
                              AND visit_type.name IN ("Oncology")
     INNER JOIN patient ON visit.patient_id = patient.patient_id AND DATE(visit.date_started) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND patient.voided = 0 AND visit.voided = 0
     INNER JOIN person ON person.person_id = patient.patient_id AND person.voided = 0
     RIGHT OUTER JOIN reporting_age_group AS observed_age_group ON
                                                                  DATE(visit.date_started) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.min_years YEAR), INTERVAL observed_age_group.min_days DAY))
                                                                  AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.max_years YEAR), INTERVAL observed_age_group.max_days DAY))
   WHERE observed_age_group.id = 1) AS client_visits
UNION ALL

SELECT 'A.3.15    Renal Clinic' AS 'Services',
  IF(client_visits.patient_id IS NULL, 0, SUM(IF(DATE(client_visits.first_visit_date) = DATE(client_visits.visit_date) , 1, 0))) as 'NEW',
  IF(client_visits.patient_id IS NULL, 0, SUM(IF(DATE(client_visits.first_visit_date) < DATE(client_visits.visit_date) , 1, 0))) AS 'RE-ATT',
  IF(client_visits.patient_id IS NULL, 0, SUM(IF(client_visits.patient_gender = 'F' OR client_visits.patient_gender = 'M' , 1, 0))) as 'TOTAL'
FROM
  (SELECT DISTINCT patient.patient_id AS patient_id,
                   patient.date_created AS first_visit_date,
                   person.gender AS patient_gender,
                   visit.date_started AS visit_date,
     obs.obs_datetime

   FROM  obs
     INNER JOIN concept_view cv ON cv.concept_id = obs.concept_id
                                   AND cv.concept_full_name IN ("Chronic Kidney Disease, Intake", "Chronic Kidney Disease, Progress")
                                   AND obs.voided = 0
     INNER JOIN encounter ON encounter.encounter_id=obs.encounter_id
     INNER JOIN visit ON visit.visit_id = encounter.visit_id
     INNER JOIN patient ON obs.person_id = patient.patient_id AND DATE(obs.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND patient.voided = 0 AND obs.voided = 0
     INNER JOIN person ON person.person_id = patient.patient_id AND person.voided = 0
   GROUP BY patient.patient_id
  ) AS client_visits
UNION ALL

SELECT 'A.3.16    All Other Special Clinics' AS 'Services',
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
     INNER JOIN visit_type ON visit_type.visit_type_id = visit.visit_type_id
                              AND visit_type.name IN ("Special OPD")
     INNER JOIN patient ON visit.patient_id = patient.patient_id AND DATE(visit.date_started) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND patient.voided = 0 AND visit.voided = 0
     INNER JOIN person ON person.person_id = patient.patient_id AND person.voided = 0
     RIGHT OUTER JOIN reporting_age_group AS observed_age_group ON
                                                                  DATE(visit.date_started) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.min_years YEAR), INTERVAL observed_age_group.min_days DAY))
                                                                  AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.max_years YEAR), INTERVAL observed_age_group.max_days DAY))
   WHERE observed_age_group.id = 1) AS client_visits
UNION ALL

SELECT 'A.3.8    Total Special Clinics' AS 'Services',
  IF(client_visits.patient_id IS NULL, 0, SUM(IF(DATE(client_visits.first_visit_date) = DATE(client_visits.visit_date) , 1, 0))) as 'NEW',
  IF(client_visits.patient_id IS NULL, 0, SUM(IF(DATE(client_visits.first_visit_date) < DATE(client_visits.visit_date) , 1, 0))) AS 'RE-ATT',
  IF(client_visits.patient_id IS NULL, 0, SUM(IF(client_visits.patient_gender = 'F' OR client_visits.patient_gender = 'M' , 1, 0))) as 'TOTAL'
FROM
  (SELECT DISTINCT patient.patient_id AS patient_id,
                   patient.date_created AS first_visit_date,
                   person.gender AS patient_gender,
                   visit.date_started AS visit_date,
     obs.obs_datetime

   FROM  obs
     INNER JOIN concept_view cv ON cv.concept_id = obs.concept_id
           AND cv.concept_full_name IN ("Chronic Kidney Disease, Intake", "Chronic Kidney Disease, Progress", "Nutrition","Obstetrics", "Gynaecology",
                                        "Physiotherapy Template", "Occupational Therapy Template" , "ENT Clinic", "Eye Clinic", "Leprosy, Template", "Orthopedic Examination")
           AND obs.voided = 0
     INNER JOIN encounter ON encounter.encounter_id=obs.encounter_id
     INNER JOIN visit ON visit.visit_id = encounter.visit_id
     INNER JOIN patient ON obs.person_id = patient.patient_id AND DATE(obs.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND patient.voided = 0 AND obs.voided = 0
     INNER JOIN person ON person.person_id = patient.patient_id AND person.voided = 0
   GROUP BY patient.patient_id
  ) AS client_visits

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
       IF(client_visits.patient_id IS NULL, 0, SUM(IF(DATE(client_visits.first_visit_date) = DATE(client_visits.visit_date),IF(client_visits.patient_gender = 'F' OR client_visits.patient_gender = 'M', 1, 0),0))) as 'NEW',
       IF(client_visits.patient_id IS NULL, 0, SUM(IF(DATE(client_visits.first_visit_date) < DATE(client_visits.visit_date),IF(client_visits.patient_gender = 'F' OR client_visits.patient_gender = 'M', 1, 0),0))) AS 'RE-ATT',
       IF(client_visits.patient_id IS NULL, 0, SUM(IF(client_visits.patient_gender = 'F' OR client_visits.patient_gender = 'M' , 1, 0))) as 'TOTAL'
FROM
  (SELECT DISTINCT  o.order_id,
                ot.name,
                e.voided AS voided,
                pt.patient_id,
                pt.date_created AS first_visit_date,
                v.date_created AS visit_date,
                p.gender AS patient_gender
  FROM orders o
      INNER JOIN order_type ot ON o.order_type_id = ot.order_type_id
          AND ot.name = "Dental Order"
      INNER JOIN patient pt ON o.patient_id=pt.patient_id
          AND pt.voided=0
      INNER JOIN person p ON p.person_id=pt.patient_id
          AND p.voided=0
      INNER JOIN encounter e ON e.encounter_id=o.encounter_id
          AND e.voided = 0
      INNER JOIN visit v ON v.visit_id=e.visit_id 
          AND v.voided=0
      INNER JOIN visit_type ON visit_type.visit_type_id = v.visit_type_id
          AND visit_type.name IN ("OPD")
      INNER JOIN concept_view cv ON cv.concept_id=o.concept_id
          AND cv.concept_full_name IN('Dental, Temporary Filling','Dental, Amalgam Filling','Dental, Composite filling')
      WHERE  DATE(o.date_created) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
        GROUP BY pt.patient_id) AS client_visits
UNION ALL
SELECT 'A.4.5.3    Extractions' AS 'Services',
       IF(client_visits.patient_id IS NULL, 0, SUM(IF(DATE(client_visits.first_visit_date) = DATE(client_visits.visit_date),IF(client_visits.patient_gender = 'F' OR client_visits.patient_gender = 'M', 1, 0),0))) as 'NEW',
       IF(client_visits.patient_id IS NULL, 0, SUM(IF(DATE(client_visits.first_visit_date) < DATE(client_visits.visit_date),IF(client_visits.patient_gender = 'F' OR client_visits.patient_gender = 'M', 1, 0),0))) AS 'RE-ATT',
       IF(client_visits.patient_id IS NULL, 0, SUM(IF(client_visits.patient_gender = 'F' OR client_visits.patient_gender = 'M' , 1, 0))) as 'TOTAL'
FROM
  (SELECT DISTINCT  o.order_id,
                ot.name,
                e.voided AS voided,
                pt.patient_id,
                pt.date_created AS first_visit_date,
                v.date_created AS visit_date,
                p.gender AS patient_gender
  FROM orders o
      INNER JOIN order_type ot ON o.order_type_id = ot.order_type_id
          AND ot.name = "Dental Order"
      INNER JOIN patient pt ON o.patient_id=pt.patient_id
          AND pt.voided=0
      INNER JOIN person p ON p.person_id=pt.patient_id
          AND p.voided=0
      INNER JOIN encounter e ON e.encounter_id=o.encounter_id
          AND e.voided = 0
      INNER JOIN visit v ON v.visit_id=e.visit_id 
          AND v.voided=0
      INNER JOIN visit_type ON visit_type.visit_type_id = v.visit_type_id
          AND visit_type.name IN ("OPD")
      INNER JOIN concept_view cv ON cv.concept_id=o.concept_id
          AND cv.concept_full_name IN('Dental, Difficult Extraction', 'Simple Extraction')
      WHERE  DATE(o.date_created) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
        GROUP BY pt.patient_id) AS client_visits

UNION ALL

SELECT  'A.5.4    TOTAL DENTAL SERVICES' AS 'Services',
  SUM(client_visits2.NEW) AS 'NEW',
  SUM(client_visits2.`RE-ATT`) AS 'RE-ATT',
  SUM(client_visits2.TOTAL) AS 'TOTAL'
FROM (
SELECT 
       IF(client_visits.patient_id IS NULL, 0, SUM(IF(DATE(client_visits.first_visit_date) = DATE(client_visits.visit_date) , 1, 0))) as 'NEW',
  IF(client_visits.patient_id IS NULL, 0, SUM(IF(DATE(client_visits.first_visit_date) < DATE(client_visits.visit_date) , 1, 0))) AS 'RE-ATT',
  IF(client_visits.patient_id IS NULL, 0, SUM(IF(client_visits.patient_gender = 'F' OR client_visits.patient_gender = 'M' , 1, 0))) as 'TOTAL'
FROM
  (SELECT DISTINCT patient.patient_id AS patient_id,
                   patient.date_created AS first_visit_date,
                   person.gender AS patient_gender,
                   visit.date_started AS visit_date,
     obs.obs_datetime

   FROM  obs
     INNER JOIN concept_view cv ON cv.concept_id = obs.concept_id
                                   AND cv.concept_full_name IN ("Dental Form Template")
                                   AND obs.voided = 0
     INNER JOIN encounter ON encounter.encounter_id=obs.encounter_id
     INNER JOIN visit ON visit.visit_id = encounter.visit_id
     INNER JOIN patient ON obs.person_id = patient.patient_id AND DATE(obs.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND patient.voided = 0 AND obs.voided = 0
     INNER JOIN person ON person.person_id = patient.patient_id AND person.voided = 0
  GROUP BY patient.patient_id
  ) AS client_visits

  UNION ALL

  SELECT 
       IF(client_visits.patient_id IS NULL, 0, SUM(IF(DATE(client_visits.first_visit_date) = DATE(client_visits.visit_date),IF(client_visits.patient_gender = 'F' OR client_visits.patient_gender = 'M', 1, 0),0))) as 'NEW',
       IF(client_visits.patient_id IS NULL, 0, SUM(IF(DATE(client_visits.first_visit_date) < DATE(client_visits.visit_date),IF(client_visits.patient_gender = 'F' OR client_visits.patient_gender = 'M', 1, 0),0))) AS 'RE-ATT',
       IF(client_visits.patient_id IS NULL, 0, SUM(IF(client_visits.patient_gender = 'F' OR client_visits.patient_gender = 'M' , 1, 0))) as 'TOTAL'
  FROM(
  SELECT DISTINCT  o.order_id,
                  ot.name,
                  e.voided AS voided,
                  pt.patient_id,
                  pt.date_created AS first_visit_date,
                  v.date_created AS visit_date,
                  p.gender AS patient_gender
    FROM orders o
        INNER JOIN order_type ot ON o.order_type_id = ot.order_type_id
            AND ot.name = "Dental Order"
        INNER JOIN patient pt ON o.patient_id=pt.patient_id
            AND pt.voided=0
        INNER JOIN person p ON p.person_id=pt.patient_id
            AND p.voided=0
        INNER JOIN encounter e ON e.encounter_id=o.encounter_id
            AND e.voided = 0
        INNER JOIN visit v ON v.visit_id=e.visit_id 
            AND v.voided=0
        INNER JOIN visit_type ON visit_type.visit_type_id = v.visit_type_id
            AND visit_type.name IN ("OPD")
        WHERE  DATE(o.date_created) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
              AND ((SELECT e.encounter_id 
                      FROM encounter e
                      INNER JOIN obs o ON o.encounter_id=e.encounter_id
                          AND o.concept_id = (select concept_id from concept_view where concept_full_name='Dental Form Template')
                      WHERE e.visit_id=v.visit_id ) IS NULL)
          GROUP BY pt.patient_id) AS client_visits

)AS client_visits2

UNION ALL

SELECT 'A.6     Total Outpatient Services' AS 'Age Group',
       SUM(client_visits2.NEW) AS 'NEW',
       SUM(client_visits2.`RE-ATT`) AS 'RE-ATT',
       SUM(client_visits2.TOTAL) as 'TOTAL'
FROM
  (
    SELECT 'A.1.5 Total General Outpatient' AS 'Age Group',
       IF(client_visits.patient_id IS NULL, 0, SUM(IF(DATE(client_visits.first_visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF(DATE(client_visits.first_visit_date) = DATE(client_visits.visit_date)  AND (client_visits.age < 60) AND (client_visits.patient_gender = 'F' OR client_visits.patient_gender = 'M'), 1, 0),0))) as 'NEW',
       IF(client_visits.patient_id IS NULL, 0, SUM(IF(DATE(client_visits.first_visit_date) < DATE(client_visits.visit_date) AND (client_visits.age < 60),IF(client_visits.patient_gender = 'F' OR client_visits.patient_gender = 'M', 1, 0),0))) AS 'RE-ATT',
       IF(client_visits.patient_id IS NULL, 0, SUM(IF(client_visits.age < 60 , 1, 0))) as 'TOTAL'
      FROM
        (SELECT DISTINCT patient.patient_id AS patient_id,
                        observed_age_group.name AS age_group,
                        observed_age_group.id as age_group_id,
                        patient.date_created AS first_visit_date,
                        person.gender AS patient_gender,
                        person.birthdate,
                        TIMESTAMPDIFF(YEAR, person.birthdate, CURDATE()) AS age,
                        visit.date_started AS visit_date,
                        observed_age_group.sort_order AS sort_order
        FROM visit
          INNER JOIN visit_type ON visit_type.visit_type_id = visit.visit_type_id
                                    AND visit_type.name IN ("OPD")
          INNER JOIN patient ON visit.patient_id = patient.patient_id AND DATE(visit.date_started) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND patient.voided = 0 AND visit.voided = 0
          INNER JOIN person ON person.person_id = patient.patient_id AND person.voided = 0
          RIGHT OUTER JOIN reporting_age_group AS observed_age_group ON
                                                                        DATE(visit.date_started) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.min_years YEAR), INTERVAL observed_age_group.min_days DAY))
                                                                        AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.max_years YEAR), INTERVAL observed_age_group.max_days DAY))
        WHERE observed_age_group.id = 1
        ) AS client_visits

        UNION ALL 

        SELECT 'A.2  CASUALTY' AS 'Age Group',
        ' ' as 'NEW',
        ' ' as 'RE-ATT',
        ' ' as 'TOTAL'

      UNION ALL

      SELECT 'A.3.8    Physiotherapy Clinic' AS 'Services',
        IF(client_visits.patient_id IS NULL, 0, SUM(IF(DATE(client_visits.first_visit_date) = DATE(client_visits.visit_date) , 1, 0))) as 'NEW',
        IF(client_visits.patient_id IS NULL, 0, SUM(IF(DATE(client_visits.first_visit_date) < DATE(client_visits.visit_date) , 1, 0))) AS 'RE-ATT',
        IF(client_visits.patient_id IS NULL, 0, SUM(IF(client_visits.patient_gender = 'F' OR client_visits.patient_gender = 'M' , 1, 0))) as 'TOTAL'
      FROM
        (SELECT DISTINCT patient.patient_id AS patient_id,
                        patient.date_created AS first_visit_date,
                        person.gender AS patient_gender,
                        visit.date_started AS visit_date,
          obs.obs_datetime

        FROM  obs
          INNER JOIN concept_view cv ON cv.concept_id = obs.concept_id
                                        AND cv.concept_full_name IN ("Physiotherapy Template")
                                        AND obs.voided = 0
          INNER JOIN encounter ON encounter.encounter_id=obs.encounter_id
          INNER JOIN visit ON visit.visit_id = encounter.visit_id
          INNER JOIN patient ON obs.person_id = patient.patient_id AND DATE(obs.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND patient.voided = 0 AND obs.voided = 0
          INNER JOIN person ON person.person_id = patient.patient_id AND person.voided = 0
        GROUP BY patient.patient_id
        ) AS client_visits

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

      SELECT 'A.5.4    TOTAL DENTAL SERVICES' AS 'Services',
       IF(client_visits.patient_id IS NULL, 0, SUM(IF(DATE(client_visits.first_visit_date) = DATE(client_visits.visit_date),IF(client_visits.patient_gender = 'F' OR client_visits.patient_gender = 'M', 1, 0),0))) as 'NEW',
       IF(client_visits.patient_id IS NULL, 0, SUM(IF(DATE(client_visits.first_visit_date) < DATE(client_visits.visit_date),IF(client_visits.patient_gender = 'F' OR client_visits.patient_gender = 'M', 1, 0),0))) AS 'RE-ATT',
       IF(client_visits.patient_id IS NULL, 0, SUM(IF(client_visits.patient_gender = 'F' OR client_visits.patient_gender = 'M' , 1, 0))) as 'TOTAL'
      FROM
        (SELECT DISTINCT  o.order_id,
                      ot.name,
                      e.voided AS voided,
                      pt.patient_id,
                      pt.date_created AS first_visit_date,
                      v.date_created AS visit_date,
                      p.gender AS patient_gender
        FROM orders o
            INNER JOIN order_type ot ON o.order_type_id = ot.order_type_id
                AND ot.name = "Dental Order"
            INNER JOIN patient pt ON o.patient_id=pt.patient_id
                AND pt.voided=0
            INNER JOIN person p ON p.person_id=pt.patient_id
                AND p.voided=0
            INNER JOIN encounter e ON e.encounter_id=o.encounter_id
                AND e.voided = 0
            INNER JOIN visit v ON v.visit_id=e.visit_id 
                AND v.voided=0
            INNER JOIN visit_type ON visit_type.visit_type_id = v.visit_type_id
                AND visit_type.name IN ("OPD")
            WHERE  DATE(o.date_created) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
              GROUP BY pt.patient_id) AS client_visits

  )client_visits2

   UNION ALL
SELECT 'A.7    Medical Examinations(Except p3) ' AS 'Services',
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
     INNER JOIN visit_type ON visit_type.visit_type_id = visit.visit_type_id
                              AND visit_type.name IN ("Medical Examinations")
     INNER JOIN patient ON visit.patient_id = patient.patient_id AND DATE(visit.date_started) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND patient.voided = 0 AND visit.voided = 0
     INNER JOIN person ON person.person_id = patient.patient_id AND person.voided = 0
     RIGHT OUTER JOIN reporting_age_group AS observed_age_group ON
                                                                  DATE(visit.date_started) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.min_years YEAR), INTERVAL observed_age_group.min_days DAY))
                                                                  AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.max_years YEAR), INTERVAL observed_age_group.max_days DAY))
   WHERE observed_age_group.id = 1) AS client_visits

UNION ALL

SELECT 'A.8    Medical Reports(Incl, P3,Compensation, Insurance, etc) ' AS 'Services',
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

UNION ALL

SELECT 'A.9    Dressing ' AS 'Services',
       '' as 'NEW',
       '' AS 'RE-ATT',
  IF(services.order_id IS NULL, 0, SUM(IF(services.voided = 0, 1, 0)))  AS 'TOTAL'
FROM
  (SELECT DISTINCT o.order_id AS order_id,
                   o.voided AS voided,
                   o.date_created AS datetime
   FROM concept_view cv
     INNER JOIN orders o on cv.concept_id = o.concept_id
                            AND o.concept_id IN (select concept_id from concept_view where concept_full_name IN ('Major Dressing', 'Minor Dressing'))
     INNER JOIN encounter e on o.encounter_id = e.encounter_id
     INNER JOIN visit v on e.visit_id = v.visit_id
   WHERE  DATE(o.date_created) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) ) AS services

UNION ALL

SELECT 'A.10    Removal of Stitches ' AS 'Services',
       '' as 'NEW',
       '' AS 'RE-ATT',
  IF(services.order_id IS NULL, 0, SUM(IF(services.voided = 0, 1, 0)))  AS 'TOTAL'
FROM
  (SELECT DISTINCT o.order_id AS order_id,
                   o.voided AS voided,
                   o.date_created AS datetime
   FROM concept_view cv
     INNER JOIN orders o on cv.concept_id = o.concept_id
                            AND o.concept_id IN (select concept_id from concept_view where concept_full_name IN ('Removal of Stiches'))
     INNER JOIN encounter e on o.encounter_id = e.encounter_id
     INNER JOIN visit v on e.visit_id = v.visit_id
   WHERE  DATE(o.date_created) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) ) AS services
UNION ALL

SELECT 'A.11    Injections ' AS 'Services',
       '' as 'NEW',
       '' AS 'RE-ATT',
       IF(services.order_id IS NULL, 0, SUM(IF(services.voided = 0, 1, 0)))  AS 'TOTAL'
FROM
  (SELECT DISTINCT o.order_id AS order_id,
                   o.voided AS voided,
                   o.date_created AS datetime
   FROM concept_view cv
     INNER JOIN orders o on cv.concept_id = o.concept_id
                            AND o.concept_id IN (select concept_id from concept_view where concept_full_name IN ('Injection Procedure'))
     INNER JOIN encounter e on o.encounter_id = e.encounter_id
     INNER JOIN visit v on e.visit_id = v.visit_id
   WHERE  DATE(o.date_created) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) ) AS services

UNION ALL

SELECT 'A.12    Stitching ' AS 'Services',
       '' as 'NEW',
       '' AS 'RE-ATT',
       IF(services.order_id IS NULL, 0, SUM(IF(services.voided = 0, 1, 0)))  AS 'TOTAL'
FROM
  (SELECT DISTINCT o.order_id AS order_id,
                   o.voided AS voided,
                   o.date_created AS datetime
   FROM concept_view cv
     INNER JOIN orders o on cv.concept_id = o.concept_id
                            AND o.concept_id IN (select concept_id from concept_view where concept_full_name IN ('Major Stitching Procedure', 'Minor Stitching Procedure'))
     INNER JOIN encounter e on o.encounter_id = e.encounter_id
     INNER JOIN visit v on e.visit_id = v.visit_id
   WHERE  DATE(o.date_created) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) ) AS services
