SELECT 'B.1.1 Discharges' AS 'Service',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(TIMESTAMPDIFF(YEAR,client_visits.birth_date, CURDATE()) > 5,IF(client_visits.value_reference = 'Discharged', 1, 1),0))) AS 'General Adults',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(TIMESTAMPDIFF(YEAR,client_visits.birth_date, CURDATE()) > 5 AND TIMESTAMPDIFF(YEAR,client_visits.birth_date, CURDATE()) <= 21 , 1, 0))) as 'Pediatrics',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(client_visits.patient_gender = 'F' , 1, 0))) as 'Maternity Mothers Only',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(client_visits.patient_gender = 'F' , 1, 0))) as 'Amenity',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(client_visits.patient_gender = 'M' , 1, 1))) as 'TOTAL'


FROM
  (SELECT DISTINCT 
                   visit_attribute.visit_attribute_id as visit_attribute_id,
                   visit_attribute.value_reference as value_reference,
                   patient.patient_id AS patient_id,
                   patient.date_created AS first_visit_date,
                   person.gender AS patient_gender,
                   person.birthdate AS birth_date,
                   visit.date_started AS visit_date
   FROM visit_attribute
     INNER JOIN visit ON visit_attribute.visit_id = visit.visit_id
     INNER JOIN patient ON visit.patient_id = patient.patient_id AND DATE(visit.date_stopped) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND patient.voided = 0 AND visit.voided = 0
     INNER JOIN person ON person.person_id = patient.patient_id AND person.voided = 0
   WHERE visit_attribute.voided = 0 ) AS client_visits
UNION ALL
SELECT 'B.1.2 Deaths' AS 'Service',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(TIMESTAMPDIFF(YEAR,client_visits.birth_date, CURDATE()) > 5,IF(client_visits.value_reference = 'Discharged', 1, 0),0))) AS 'General Adults',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(TIMESTAMPDIFF(YEAR,client_visits.birth_date, CURDATE()) > 5 AND TIMESTAMPDIFF(YEAR,client_visits.birth_date, CURDATE()) <= 21 , 1, 0))) as 'Pediatrics',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(client_visits.patient_gender = 'F' , 1, 0))) as 'Maternity Mothers Only',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(client_visits.patient_gender = 'F' , 1, 0))) as 'Amenity',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(client_visits.patient_gender = 'M' , 1, 1))) as 'TOTAL'


FROM
  (SELECT DISTINCT 
                   visit_attribute.visit_attribute_id as visit_attribute_id,
                   visit_attribute.value_reference as value_reference,
                   patient.patient_id AS patient_id,
                   observed_age_group.name AS age_group,
                   observed_age_group.id as age_group_id,
                   patient.date_created AS first_visit_date,
                   person.gender AS patient_gender,
                   person.birthdate AS birth_date,
                   visit.date_started AS visit_date,
                   observed_age_group.sort_order AS sort_order
   FROM visit_attribute
     INNER JOIN visit ON visit_attribute.visit_id = visit.visit_id
     INNER JOIN patient ON visit.patient_id = patient.patient_id AND DATE(visit.date_stopped) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND patient.voided = 0 AND visit.voided = 0
     INNER JOIN person ON person.person_id = patient.patient_id AND person.voided = 0
     RIGHT OUTER JOIN reporting_age_group AS observed_age_group ON
                                                                  DATE(visit.date_stopped) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.min_years YEAR), INTERVAL observed_age_group.min_days DAY))
                                                                  AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.max_years YEAR), INTERVAL observed_age_group.max_days DAY))
   WHERE observed_age_group.id = 3 ) AS client_visits
UNION ALL
SELECT 'B.1.3 Absoconders' AS 'Service',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(TIMESTAMPDIFF(YEAR,client_visits.birth_date, CURDATE()) > 5,IF(client_visits.value_reference = 'Discharged', 1, 0),0))) AS 'General Adults',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(TIMESTAMPDIFF(YEAR,client_visits.birth_date, CURDATE()) > 5 AND TIMESTAMPDIFF(YEAR,client_visits.birth_date, CURDATE()) <= 21 , 1, 0))) as 'Pediatrics',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(client_visits.patient_gender = 'F' , 1, 0))) as 'Maternity Mothers Only',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(client_visits.patient_gender = 'F' , 1, 0))) as 'Amenity',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(client_visits.patient_gender = 'M' , 1, 1))) as 'TOTAL'


FROM
  (SELECT DISTINCT 
                   visit_attribute.visit_attribute_id as visit_attribute_id,
                   visit_attribute.value_reference as value_reference,
                   patient.patient_id AS patient_id,
                   observed_age_group.name AS age_group,
                   observed_age_group.id as age_group_id,
                   patient.date_created AS first_visit_date,
                   person.gender AS patient_gender,
                   person.birthdate AS birth_date,
                   visit.date_started AS visit_date,
                   observed_age_group.sort_order AS sort_order
   FROM visit_attribute
     INNER JOIN visit ON visit_attribute.visit_id = visit.visit_id
     INNER JOIN patient ON visit.patient_id = patient.patient_id AND DATE(visit.date_stopped) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND patient.voided = 0 AND visit.voided = 0
     INNER JOIN person ON person.person_id = patient.patient_id AND person.voided = 0
     RIGHT OUTER JOIN reporting_age_group AS observed_age_group ON
                                                                  DATE(visit.date_stopped) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.min_years YEAR), INTERVAL observed_age_group.min_days DAY))
                                                                  AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.max_years YEAR), INTERVAL observed_age_group.max_days DAY))
   WHERE observed_age_group.id = 3 ) AS client_visits
UNION ALL
SELECT 'B.1.4 TOTAL DISCHARGES, DEATHS etc' AS 'Service',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(TIMESTAMPDIFF(YEAR,client_visits.birth_date, CURDATE()) > 5,IF(client_visits.value_reference = 'Discharged', 1, 0),0))) AS 'General Adults',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(TIMESTAMPDIFF(YEAR,client_visits.birth_date, CURDATE()) > 5 AND TIMESTAMPDIFF(YEAR,client_visits.birth_date, CURDATE()) <= 21 , 1, 0))) as 'Pediatrics',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(client_visits.patient_gender = 'F' , 1, 0))) as 'Maternity Mothers Only',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(client_visits.patient_gender = 'F' , 1, 0))) as 'Amenity',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(client_visits.patient_gender = 'M' , 1, 1))) as 'TOTAL'


FROM
  (SELECT DISTINCT 
                   visit_attribute.visit_attribute_id as visit_attribute_id,
                   visit_attribute.value_reference as value_reference,
                   patient.patient_id AS patient_id,
                   observed_age_group.name AS age_group,
                   observed_age_group.id as age_group_id,
                   patient.date_created AS first_visit_date,
                   person.gender AS patient_gender,
                   person.birthdate AS birth_date,
                   visit.date_started AS visit_date,
                   observed_age_group.sort_order AS sort_order
   FROM visit_attribute
     INNER JOIN visit ON visit_attribute.visit_id = visit.visit_id
     INNER JOIN patient ON visit.patient_id = patient.patient_id AND DATE(visit.date_stopped) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND patient.voided = 0 AND visit.voided = 0
     INNER JOIN person ON person.person_id = patient.patient_id AND person.voided = 0
     RIGHT OUTER JOIN reporting_age_group AS observed_age_group ON
                                                                  DATE(visit.date_stopped) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.min_years YEAR), INTERVAL observed_age_group.min_days DAY))
                                                                  AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.max_years YEAR), INTERVAL observed_age_group.max_days DAY))
   WHERE observed_age_group.id = 3 ) AS client_visits
UNION ALL
SELECT 'B.1.9 Admissions' AS 'Service',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(TIMESTAMPDIFF(YEAR,client_visits.birth_date, CURDATE()) > 5,IF(client_visits.value_reference = 'Discharged', 1, 0),0))) AS 'General Adults',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(TIMESTAMPDIFF(YEAR,client_visits.birth_date, CURDATE()) > 5 AND TIMESTAMPDIFF(YEAR,client_visits.birth_date, CURDATE()) <= 21 , 1, 0))) as 'Pediatrics',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(client_visits.patient_gender = 'F' , 1, 0))) as 'Maternity Mothers Only',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(client_visits.patient_gender = 'F' , 1, 0))) as 'Amenity',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(client_visits.patient_gender = 'M' , 1, 1))) as 'TOTAL'


FROM
  (SELECT DISTINCT 
                   visit_attribute.visit_attribute_id as visit_attribute_id,
                   visit_attribute.value_reference as value_reference,
                   patient.patient_id AS patient_id,
                   observed_age_group.name AS age_group,
                   observed_age_group.id as age_group_id,
                   patient.date_created AS first_visit_date,
                   person.gender AS patient_gender,
                   person.birthdate AS birth_date,
                   visit.date_started AS visit_date,
                   observed_age_group.sort_order AS sort_order
   FROM visit_attribute
     INNER JOIN visit ON visit_attribute.visit_id = visit.visit_id
     INNER JOIN patient ON visit.patient_id = patient.patient_id AND DATE(visit.date_stopped) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND patient.voided = 0 AND visit.voided = 0
     INNER JOIN person ON person.person_id = patient.patient_id AND person.voided = 0
     RIGHT OUTER JOIN reporting_age_group AS observed_age_group ON
                                                                  DATE(visit.date_stopped) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.min_years YEAR), INTERVAL observed_age_group.min_days DAY))
                                                                  AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.max_years YEAR), INTERVAL observed_age_group.max_days DAY))
   WHERE observed_age_group.id = 3 ) AS client_visits
UNION ALL
SELECT 'B.1.10 Paroles' AS 'Service',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(TIMESTAMPDIFF(YEAR,client_visits.birth_date, CURDATE()) > 5,IF(client_visits.value_reference = 'Discharged', 1, 0),0))) AS 'General Adults',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(TIMESTAMPDIFF(YEAR,client_visits.birth_date, CURDATE()) > 5 AND TIMESTAMPDIFF(YEAR,client_visits.birth_date, CURDATE()) <= 21 , 1, 0))) as 'Pediatrics',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(client_visits.patient_gender = 'F' , 1, 0))) as 'Maternity Mothers Only',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(client_visits.patient_gender = 'F' , 1, 0))) as 'Amenity',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(client_visits.patient_gender = 'M' , 1, 1))) as 'TOTAL'


FROM
  (SELECT DISTINCT 
                   visit_attribute.visit_attribute_id as visit_attribute_id,
                   visit_attribute.value_reference as value_reference,
                   patient.patient_id AS patient_id,
                   observed_age_group.name AS age_group,
                   observed_age_group.id as age_group_id,
                   patient.date_created AS first_visit_date,
                   person.gender AS patient_gender,
                   person.birthdate AS birth_date,
                   visit.date_started AS visit_date,
                   observed_age_group.sort_order AS sort_order
   FROM visit_attribute
     INNER JOIN visit ON visit_attribute.visit_id = visit.visit_id
     INNER JOIN patient ON visit.patient_id = patient.patient_id AND DATE(visit.date_stopped) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND patient.voided = 0 AND visit.voided = 0
     INNER JOIN person ON person.person_id = patient.patient_id AND person.voided = 0
     RIGHT OUTER JOIN reporting_age_group AS observed_age_group ON
                                                                  DATE(visit.date_stopped) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.min_years YEAR), INTERVAL observed_age_group.min_days DAY))
                                                                  AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.max_years YEAR), INTERVAL observed_age_group.max_days DAY))
   WHERE observed_age_group.id = 3 ) AS client_visits
UNION ALL
SELECT 'B.1.11a Occupied Bed Days- NHIF Members' AS 'Service',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(TIMESTAMPDIFF(YEAR,client_visits.birth_date, CURDATE()) > 5,IF(client_visits.value_reference = 'Discharged', 1, 0),0))) AS 'General Adults',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(TIMESTAMPDIFF(YEAR,client_visits.birth_date, CURDATE()) > 5 AND TIMESTAMPDIFF(YEAR,client_visits.birth_date, CURDATE()) <= 21 , 1, 0))) as 'Pediatrics',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(client_visits.patient_gender = 'F' , 1, 0))) as 'Maternity Mothers Only',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(client_visits.patient_gender = 'F' , 1, 0))) as 'Amenity',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(client_visits.patient_gender = 'M' , 1, 1))) as 'TOTAL'


FROM
  (SELECT DISTINCT 
                   visit_attribute.visit_attribute_id as visit_attribute_id,
                   visit_attribute.value_reference as value_reference,
                   patient.patient_id AS patient_id,
                   observed_age_group.name AS age_group,
                   observed_age_group.id as age_group_id,
                   patient.date_created AS first_visit_date,
                   person.gender AS patient_gender,
                   person.birthdate AS birth_date,
                   visit.date_started AS visit_date,
                   observed_age_group.sort_order AS sort_order
   FROM visit_attribute
     INNER JOIN visit ON visit_attribute.visit_id = visit.visit_id
     INNER JOIN patient ON visit.patient_id = patient.patient_id AND DATE(visit.date_stopped) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND patient.voided = 0 AND visit.voided = 0
     INNER JOIN person ON person.person_id = patient.patient_id AND person.voided = 0
     RIGHT OUTER JOIN reporting_age_group AS observed_age_group ON
                                                                  DATE(visit.date_stopped) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.min_years YEAR), INTERVAL observed_age_group.min_days DAY))
                                                                  AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.max_years YEAR), INTERVAL observed_age_group.max_days DAY))
   WHERE observed_age_group.id = 3 ) AS client_visits
UNION ALL
SELECT 'B.1.11b Occupied Bed Days- Non-NHIF Members' AS 'Service',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(TIMESTAMPDIFF(YEAR,client_visits.birth_date, CURDATE()) > 5,IF(client_visits.value_reference = 'Discharged', 1, 0),0))) AS 'General Adults',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(TIMESTAMPDIFF(YEAR,client_visits.birth_date, CURDATE()) > 5 AND TIMESTAMPDIFF(YEAR,client_visits.birth_date, CURDATE()) <= 21 , 1, 0))) as 'Pediatrics',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(client_visits.patient_gender = 'F' , 1, 0))) as 'Maternity Mothers Only',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(client_visits.patient_gender = 'F' , 1, 0))) as 'Amenity',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(client_visits.patient_gender = 'M' , 1, 1))) as 'TOTAL'


FROM
  (SELECT DISTINCT 
                   visit_attribute.visit_attribute_id as visit_attribute_id,
                   visit_attribute.value_reference as value_reference,
                   patient.patient_id AS patient_id,
                   observed_age_group.name AS age_group,
                   observed_age_group.id as age_group_id,
                   patient.date_created AS first_visit_date,
                   person.gender AS patient_gender,
                   person.birthdate AS birth_date,
                   visit.date_started AS visit_date,
                   observed_age_group.sort_order AS sort_order
   FROM visit_attribute
     INNER JOIN visit ON visit_attribute.visit_id = visit.visit_id
     INNER JOIN patient ON visit.patient_id = patient.patient_id AND DATE(visit.date_stopped) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND patient.voided = 0 AND visit.voided = 0
     INNER JOIN person ON person.person_id = patient.patient_id AND person.voided = 0
     RIGHT OUTER JOIN reporting_age_group AS observed_age_group ON
                                                                  DATE(visit.date_stopped) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.min_years YEAR), INTERVAL observed_age_group.min_days DAY))
                                                                  AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.max_years YEAR), INTERVAL observed_age_group.max_days DAY))
   WHERE observed_age_group.id = 3 ) AS client_visits
UNION ALL
SELECT 'B.1.12  Well Persons Days' AS 'Service',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(TIMESTAMPDIFF(YEAR,client_visits.birth_date, CURDATE()) > 5,IF(client_visits.value_reference = 'Discharged', 1, 0),0))) AS 'General Adults',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(TIMESTAMPDIFF(YEAR,client_visits.birth_date, CURDATE()) > 5 AND TIMESTAMPDIFF(YEAR,client_visits.birth_date, CURDATE()) <= 21 , 1, 0))) as 'Pediatrics',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(client_visits.patient_gender = 'F' , 1, 0))) as 'Maternity Mothers Only',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(client_visits.patient_gender = 'F' , 1, 0))) as 'Amenity',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(client_visits.patient_gender = 'M' , 1, 1))) as 'TOTAL'


FROM
  (SELECT DISTINCT 
                   visit_attribute.visit_attribute_id as visit_attribute_id,
                   visit_attribute.value_reference as value_reference,
                   patient.patient_id AS patient_id,
                   observed_age_group.name AS age_group,
                   observed_age_group.id as age_group_id,
                   patient.date_created AS first_visit_date,
                   person.gender AS patient_gender,
                   person.birthdate AS birth_date,
                   visit.date_started AS visit_date,
                   observed_age_group.sort_order AS sort_order
   FROM visit_attribute
     INNER JOIN visit ON visit_attribute.visit_id = visit.visit_id
     INNER JOIN patient ON visit.patient_id = patient.patient_id AND DATE(visit.date_stopped) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND patient.voided = 0 AND visit.voided = 0
     INNER JOIN person ON person.person_id = patient.patient_id AND person.voided = 0
     RIGHT OUTER JOIN reporting_age_group AS observed_age_group ON
                                                                  DATE(visit.date_stopped) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.min_years YEAR), INTERVAL observed_age_group.min_days DAY))
                                                                  AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.max_years YEAR), INTERVAL observed_age_group.max_days DAY))
   WHERE observed_age_group.id = 3 ) AS client_visits
UNION ALL
SELECT 'B.1.15 Beds Authorizeds' AS 'Service',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(TIMESTAMPDIFF(YEAR,client_visits.birth_date, CURDATE()) > 5,IF(client_visits.value_reference = 'Discharged', 1, 0),0))) AS 'General Adults',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(TIMESTAMPDIFF(YEAR,client_visits.birth_date, CURDATE()) > 5 AND TIMESTAMPDIFF(YEAR,client_visits.birth_date, CURDATE()) <= 21 , 1, 0))) as 'Pediatrics',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(client_visits.patient_gender = 'F' , 1, 0))) as 'Maternity Mothers Only',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(client_visits.patient_gender = 'F' , 1, 0))) as 'Amenity',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(client_visits.patient_gender = 'M' , 1, 1))) as 'TOTAL'


FROM
  (SELECT DISTINCT 
                   visit_attribute.visit_attribute_id as visit_attribute_id,
                   visit_attribute.value_reference as value_reference,
                   patient.patient_id AS patient_id,
                   observed_age_group.name AS age_group,
                   observed_age_group.id as age_group_id,
                   patient.date_created AS first_visit_date,
                   person.gender AS patient_gender,
                   person.birthdate AS birth_date,
                   visit.date_started AS visit_date,
                   observed_age_group.sort_order AS sort_order
   FROM visit_attribute
     INNER JOIN visit ON visit_attribute.visit_id = visit.visit_id
     INNER JOIN patient ON visit.patient_id = patient.patient_id AND DATE(visit.date_stopped) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND patient.voided = 0 AND visit.voided = 0
     INNER JOIN person ON person.person_id = patient.patient_id AND person.voided = 0
     RIGHT OUTER JOIN reporting_age_group AS observed_age_group ON
                                                                  DATE(visit.date_stopped) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.min_years YEAR), INTERVAL observed_age_group.min_days DAY))
                                                                  AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.max_years YEAR), INTERVAL observed_age_group.max_days DAY))
   WHERE observed_age_group.id = 3 ) AS client_visits
UNION ALL
SELECT 'B.1.6 Beds- Actual Physial' AS 'Service',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(TIMESTAMPDIFF(YEAR,client_visits.birth_date, CURDATE()) > 5,IF(client_visits.value_reference = 'Discharged', 1, 0),0))) AS 'General Adults',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(TIMESTAMPDIFF(YEAR,client_visits.birth_date, CURDATE()) > 5 AND TIMESTAMPDIFF(YEAR,client_visits.birth_date, CURDATE()) <= 21 , 1, 0))) as 'Pediatrics',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(client_visits.patient_gender = 'F' , 1, 0))) as 'Maternity Mothers Only',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(client_visits.patient_gender = 'F' , 1, 0))) as 'Amenity',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(client_visits.patient_gender = 'M' , 1, 1))) as 'TOTAL'


FROM
  (SELECT DISTINCT 
                   visit_attribute.visit_attribute_id as visit_attribute_id,
                   visit_attribute.value_reference as value_reference,
                   patient.patient_id AS patient_id,
                   observed_age_group.name AS age_group,
                   observed_age_group.id as age_group_id,
                   patient.date_created AS first_visit_date,
                   person.gender AS patient_gender,
                   person.birthdate AS birth_date,
                   visit.date_started AS visit_date,
                   observed_age_group.sort_order AS sort_order
   FROM visit_attribute
     INNER JOIN visit ON visit_attribute.visit_id = visit.visit_id
     INNER JOIN patient ON visit.patient_id = patient.patient_id AND DATE(visit.date_stopped) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND patient.voided = 0 AND visit.voided = 0
     INNER JOIN person ON person.person_id = patient.patient_id AND person.voided = 0
     RIGHT OUTER JOIN reporting_age_group AS observed_age_group ON
                                                                  DATE(visit.date_stopped) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.min_years YEAR), INTERVAL observed_age_group.min_days DAY))
                                                                  AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.max_years YEAR), INTERVAL observed_age_group.max_days DAY))
   WHERE observed_age_group.id = 3 ) AS client_visits
UNION ALL
SELECT 'B.1.7 Cots Authorizeds' AS 'Service',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(TIMESTAMPDIFF(YEAR,client_visits.birth_date, CURDATE()) > 5,IF(client_visits.value_reference = 'Discharged', 1, 0),0))) AS 'General Adults',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(TIMESTAMPDIFF(YEAR,client_visits.birth_date, CURDATE()) > 5 AND TIMESTAMPDIFF(YEAR,client_visits.birth_date, CURDATE()) <= 21 , 1, 0))) as 'Pediatrics',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(client_visits.patient_gender = 'F' , 1, 0))) as 'Maternity Mothers Only',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(client_visits.patient_gender = 'F' , 1, 0))) as 'Amenity',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(client_visits.patient_gender = 'M' , 1, 1))) as 'TOTAL'


FROM
  (SELECT DISTINCT 
                   visit_attribute.visit_attribute_id as visit_attribute_id,
                   visit_attribute.value_reference as value_reference,
                   patient.patient_id AS patient_id,
                   observed_age_group.name AS age_group,
                   observed_age_group.id as age_group_id,
                   patient.date_created AS first_visit_date,
                   person.gender AS patient_gender,
                   person.birthdate AS birth_date,
                   visit.date_started AS visit_date,
                   observed_age_group.sort_order AS sort_order
   FROM visit_attribute
     INNER JOIN visit ON visit_attribute.visit_id = visit.visit_id
     INNER JOIN patient ON visit.patient_id = patient.patient_id AND DATE(visit.date_stopped) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND patient.voided = 0 AND visit.voided = 0
     INNER JOIN person ON person.person_id = patient.patient_id AND person.voided = 0
     RIGHT OUTER JOIN reporting_age_group AS observed_age_group ON
                                                                  DATE(visit.date_stopped) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.min_years YEAR), INTERVAL observed_age_group.min_days DAY))
                                                                  AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.max_years YEAR), INTERVAL observed_age_group.max_days DAY))
   WHERE observed_age_group.id = 3 ) AS client_visits
UNION ALL
SELECT 'B.1.15 Cots - Actual Physical' AS 'Service',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(TIMESTAMPDIFF(YEAR,client_visits.birth_date, CURDATE()) > 5,IF(client_visits.value_reference = 'Discharged', 1, 0),0))) AS 'General Adults',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(TIMESTAMPDIFF(YEAR,client_visits.birth_date, CURDATE()) > 5 AND TIMESTAMPDIFF(YEAR,client_visits.birth_date, CURDATE()) <= 21 , 1, 0))) as 'Pediatrics',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(client_visits.patient_gender = 'F' , 1, 0))) as 'Maternity Mothers Only',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(client_visits.patient_gender = 'F' , 1, 0))) as 'Amenity',
       IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(client_visits.patient_gender = 'M' , 1, 1))) as 'TOTAL'


FROM
  (SELECT DISTINCT 
                   visit_attribute.visit_attribute_id as visit_attribute_id,
                   visit_attribute.value_reference as value_reference,
                   patient.patient_id AS patient_id,
                   observed_age_group.name AS age_group,
                   observed_age_group.id as age_group_id,
                   patient.date_created AS first_visit_date,
                   person.gender AS patient_gender,
                   person.birthdate AS birth_date,
                   visit.date_started AS visit_date,
                   observed_age_group.sort_order AS sort_order
   FROM visit_attribute
     INNER JOIN visit ON visit_attribute.visit_id = visit.visit_id
     INNER JOIN patient ON visit.patient_id = patient.patient_id AND DATE(visit.date_stopped) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE) AND patient.voided = 0 AND visit.voided = 0
     INNER JOIN person ON person.person_id = patient.patient_id AND person.voided = 0
     RIGHT OUTER JOIN reporting_age_group AS observed_age_group ON
                                                                  DATE(visit.date_stopped) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.min_years YEAR), INTERVAL observed_age_group.min_days DAY))
                                                                  AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.max_years YEAR), INTERVAL observed_age_group.max_days DAY))
   WHERE observed_age_group.id = 3 ) AS client_visits

