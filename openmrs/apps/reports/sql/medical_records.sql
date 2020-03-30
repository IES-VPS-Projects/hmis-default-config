SELECT 'F     MEDICAL RECORDS ISSUED' AS 'Service',
     ' ' as 'Number'
UNION ALL
SELECT 'F.1   New Files' AS 'Service',
    IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(client_visits.patient_gender = 'M' , 0, 0))) as 'Number' 
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
SELECT 'F.2   Outpatient Records' AS 'Service',
    IF(client_visits.visit_attribute_id IS NULL, 0, SUM(IF(client_visits.patient_gender = 'M' , 0, 0))) as 'Number' 
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
   WHERE visit_attribute.voided = 0 ) AS client_visits;
