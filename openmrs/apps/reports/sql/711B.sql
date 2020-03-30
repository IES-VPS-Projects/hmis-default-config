
SELECT 'A  FAMILY PLANNING ' AS 'Service',
     ' ' as 'NEW CLIENTS',
     ' ' AS 'RE-VISITS',
     ' ' as 'TOTAL'

    UNION ALL
SELECT '1    PILLS -  Microlut' AS 'Services',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) = DATE(services.visit_date),IF(services.voided = 0, 1, 0),0))) AS 'NEW CLIENTS',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) < DATE(services.visit_date),IF(services.voided = 0, 1, 0),0))) AS 'RE-VISITS',
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
WHERE form_concepts_map.map_id =13 ) AS services

UNION ALL
SELECT '2    Pills-Microgynon' AS 'Services',
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
     INNER JOIN visit ON visit.visit_id=encounter.visit_id  AND visit.voided = 0
     INNER JOIN patient ON patient.patient_id=visit.patient_id AND patient.voided = 0
WHERE form_concepts_map.map_id =14 ) AS services

UNION ALL
SELECT '3    INJECTIONS-INHECTIONS' AS 'Services',
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
     INNER JOIN visit ON visit.visit_id=encounter.visit_id  AND visit.voided = 0
     INNER JOIN patient ON patient.patient_id=visit.patient_id AND patient.voided = 0
WHERE form_concepts_map.map_id =15 ) AS services

UNION ALL
SELECT '4    IUCD-Inssertion' AS 'Services',
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
     INNER JOIN visit ON visit.visit_id=encounter.visit_id  AND visit.voided = 0
     INNER JOIN patient ON patient.patient_id=visit.patient_id AND patient.voided = 0
WHERE form_concepts_map.map_id =16 ) AS services

UNION ALL
SELECT '5    IMPLANTS-Inssertion' AS 'Services',
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
     INNER JOIN visit ON visit.visit_id=encounter.visit_id  AND visit.voided = 0
     INNER JOIN patient ON patient.patient_id=visit.patient_id AND patient.voided = 0
WHERE form_concepts_map.map_id =16 ) AS services
UNION ALL

SELECT '6    STERILIZATION-B.T.L' AS 'Services',
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
     INNER JOIN visit ON visit.visit_id=encounter.visit_id  AND visit.voided = 0
     INNER JOIN patient ON patient.patient_id=visit.patient_id AND patient.voided = 0
WHERE form_concepts_map.map_id =18 ) AS services
UNION ALL

SELECT '7    STERILIZATION-Vasectomy' AS 'Services',
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
     INNER JOIN visit ON visit.visit_id=encounter.visit_id  AND visit.voided = 0
     INNER JOIN patient ON patient.patient_id=visit.patient_id AND patient.voided = 0
WHERE form_concepts_map.map_id =19 ) AS services

UNION ALL
SELECT '8    Condoms-No of clients Receiving' AS 'Services',
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
     INNER JOIN visit ON visit.visit_id=encounter.visit_id  AND visit.voided = 0
     INNER JOIN patient ON patient.patient_id=visit.patient_id AND patient.voided = 0
WHERE form_concepts_map.map_id =20  OR form_concepts_map.map_id =21 ) AS services

UNION ALL
SELECT '9    All Others(Specify)' AS 'Services',
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
     INNER JOIN visit ON visit.visit_id=encounter.visit_id  AND visit.voided = 0
     INNER JOIN patient ON patient.patient_id=visit.patient_id AND patient.voided = 0
WHERE form_concepts_map.map_id =20 ) AS services

UNION ALL
SELECT '10    Total Num of Clients' AS 'Services',
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
     INNER JOIN visit ON visit.visit_id=encounter.visit_id  AND visit.voided = 0
     INNER JOIN patient ON patient.patient_id=visit.patient_id AND patient.voided = 0
WHERE form_concepts_map.map_id =20 OR form_concepts_map.map_id =13 OR form_concepts_map.map_id =14 OR form_concepts_map.map_id =15
OR form_concepts_map.map_id =16 OR form_concepts_map.map_id =18 OR form_concepts_map.map_id =19 OR form_concepts_map.map_id =19) AS services

UNION ALL

SELECT 'B  MCH-ANC-PMCT ' AS 'Service',
     ' ' as 'NEW CLIENTS',
     ' ' AS 'RE-VISITS',
     ' ' as 'TOTAL'

    UNION ALL
SELECT '1    Number of ANC Clients' AS 'Services',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) = DATE(services.visit_date),IF(services.voided = 0, 1, 0),0))) AS 'NEW CLIENTS',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) < DATE(services.visit_date),IF(services.voided = 0, 1, 0),0))) AS 'RE-VISITS',
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
WHERE form_concepts_map.map_id =8 ) AS services

UNION ALL

SELECT '2    Number of with Hb < 7 g/dl' AS 'Services',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) = DATE(services.visit_date),IF(services.voided = 0, 1, 0),0))) AS 'NEW CLIENTS',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) < DATE(services.visit_date),IF(services.voided = 0, 1, 0),0))) AS 'RE-VISITS',
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

SELECT '3  Number of Clients given IPT (Ist Dose) ' AS 'Service',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) = DATE(services.visit_date),IF(services.voided = 0, 1, 0),0))) AS 'NEW CLIENTS',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) < DATE(services.visit_date),IF(services.voided = 0, 1, 0),0))) AS 'RE-VISITS',
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

SELECT '4  Number of Clients given IPT (2nd Dose) ' AS 'Service',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) = DATE(services.visit_date),IF(services.voided = 0, 1, 0),0))) AS 'NEW CLIENTS',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) < DATE(services.visit_date),IF(services.voided = 0, 1, 0),0))) AS 'RE-VISITS',
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

SELECT '5  Number of Clients completed 4th Antenatal Visit' AS 'Service',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) = DATE(services.visit_date),IF(services.voided = 0, 1, 0),0))) AS 'NEW CLIENTS',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) < DATE(services.visit_date),IF(services.voided = 0, 1, 0),0))) AS 'RE-VISITS',
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

SELECT '6  Number of ITNs distributed to ANC clients ' AS 'Service',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) = DATE(services.visit_date),IF(services.voided = 0, 1, 0),0))) AS 'NEW CLIENTS',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) < DATE(services.visit_date),IF(services.voided = 0, 1, 0),0))) AS 'RE-VISITS',
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

SELECT '7  Number of ANC Clients -Counselled' AS 'Service',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) = DATE(services.visit_date),IF(services.voided = 0, 1, 0),0))) AS 'NEW CLIENTS',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) < DATE(services.visit_date),IF(services.voided = 0, 1, 0),0))) AS 'RE-VISITS',
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

SELECT '7  Number of ANC Clients -Tested for HIV' AS 'Service',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) = DATE(services.visit_date),IF(services.voided = 0, 1, 0),0))) AS 'NEW CLIENTS',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) < DATE(services.visit_date),IF(services.voided = 0, 1, 0),0))) AS 'RE-VISITS',
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

SELECT '7  Number of ANC Clients - HIV+' AS 'Service',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) = DATE(services.visit_date),IF(services.voided = 0, 1, 0),0))) AS 'NEW CLIENTS',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) < DATE(services.visit_date),IF(services.voided = 0, 1, 0),0))) AS 'RE-VISITS',
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

SELECT '7  Number of ANC Clients -Counselled' AS 'Service',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) = DATE(services.visit_date),IF(services.voided = 0, 1, 0),0))) AS 'NEW CLIENTS',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) < DATE(services.visit_date),IF(services.voided = 0, 1, 0),0))) AS 'RE-VISITS',
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

SELECT '8  Number of Clients - Tesed for Syphillis' AS 'Service',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) = DATE(services.visit_date),IF(services.voided = 0, 1, 0),0))) AS 'NEW CLIENTS',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) < DATE(services.visit_date),IF(services.voided = 0, 1, 0),0))) AS 'RE-VISITS',
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

SELECT '9  Number of Clients issued with preventive ARVs' AS 'Service',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) = DATE(services.visit_date),IF(services.voided = 0, 1, 0),0))) AS 'NEW CLIENTS',
       IF(services.patient_id IS NULL, 0, SUM(IF(DATE(services.first_visit_date) < DATE(services.visit_date),IF(services.voided = 0, 1, 0),0))) AS 'RE-VISITS',
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
