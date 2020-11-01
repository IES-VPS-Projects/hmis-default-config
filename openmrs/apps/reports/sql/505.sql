-- SELECT 'Diseases, Conditions or Events' AS 'Title',
--        '<5 Yeas Cases' AS '<5 Caese',
--        '<5 Deaths' AS '5 Deaths',
--        '>5 Year Cases' AS '>5 Cases',
--        '>5 Deaths' AS '>5 Deaths',
--        'Total Cases' AS 'Total Cases',
--        'Total Deaths' AS 'Total Cases'
-- UNION ALL

SELECT
    disease.disease_name AS 'Diseases, Conditions or Events',
       IF(disease.value_coded IS NULL, 0, SUM(IF(DATE(disease.date_started) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF( (  DATE(disease.date_time) BETWEEN (DATE_ADD(DATE_ADD(disease.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(disease.birthdate, INTERVAL 5 YEAR), INTERVAL 0 DAY))  ) , 1, 0),0))) AS '<5 Years Cases',
       IF(disease.death_reason IS NULL, 0, SUM(IF(DATE(disease.date_started) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF( (  DATE(disease.death_time) BETWEEN (DATE_ADD(DATE_ADD(disease.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(disease.birthdate, INTERVAL 5 YEAR), INTERVAL 0 DAY))  ) , 1, 0),0))) AS '<5 Years Deaths',
       IF(disease.value_coded IS NULL, 0, SUM(IF(DATE(disease.date_started) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF( (  DATE(disease.date_time) BETWEEN (DATE_ADD(DATE_ADD(disease.birthdate, INTERVAL 5 YEAR), INTERVAL 1 DAY)) AND (DATE_ADD(DATE_ADD(disease.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY))  ) , 1, 0),0)))  AS '>5 Years Cases',
       IF(disease.death_reason IS NULL, 0, SUM(IF(DATE(disease.date_started) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF( (  DATE(disease.death_time) BETWEEN (DATE_ADD(DATE_ADD(disease.birthdate, INTERVAL 0 YEAR), INTERVAL 1 DAY)) AND (DATE_ADD(DATE_ADD(disease.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY))  ) , 1, 0),0))) AS '>5 Years Deaths',
       IF(disease.value_coded IS NULL, 0, SUM(IF(DATE(disease.date_started) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF( (  DATE(disease.date_time) BETWEEN (DATE_ADD(DATE_ADD(disease.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(disease.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY))  ) , 1, 0),0))) AS 'Total Cases',
       IF(disease.death_reason IS NULL, 0, SUM(IF(DATE(disease.date_started) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF( (  DATE(disease.death_time) BETWEEN (DATE_ADD(DATE_ADD(disease.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(disease.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY))  ) , 1, 0),0))) AS 'Total Deaths'
FROM(
    SELECT DISTINCT obs.obs_id AS obs_id,
                   obs.value_coded AS value_coded,
                   obs.voided AS voided,
                   obs.obs_datetime AS date_time,
                   obs2.value_coded AS death_reason,
                   obs2.voided AS death_voided,
                   obs2.obs_datetime AS death_time,
                   patient.date_created AS first_visit_date,
                   concept_map_505.name AS disease_name,
                   person.birthdate as birthdate,
                   visit.date_started AS date_started,
                   visit.date_stopped AS date_stopped,
                   concept_map_505.map_id AS map_id

FROM concept_map_505
 LEFT OUTER JOIN obs ON  obs.value_coded = concept_map_505.concept_id
      AND obs.concept_id = (select concept_id from concept_view where concept_full_name='Coded Diagnosis')
 LEFT OUTER JOIN encounter ON encounter.encounter_id = obs.encounter_id
 LEFT OUTER JOIN visit ON visit.visit_id = encounter.visit_id
 LEFT OUTER JOIN patient ON patient.patient_id=obs.person_id
 LEFT OUTER JOIN person ON person.person_id=patient.patient_id
 LEFT JOIN obs obs2 ON obs2.concept_id = (select concept_id from concept_view where concept_full_name='Death Note, Primary Cause of Death')
      AND obs2.value_coded = concept_map_505.concept_id
 LEFT OUTER JOIN patient patient2 ON patient2.patient_id=obs2.person_id
 LEFT OUTER JOIN  person person2 ON person2.person_id=patient2.patient_id
        )AS disease
GROUP BY disease.map_id

UNION ALL
SELECT
    '' AS 'Diseases, Conditions or Events',
    '' AS '<5 Years Cases',
    '' AS '<5 Years Deaths',
    '' AS '>5 Years Cases',
    '' AS '>5 Years Deaths',
    '' AS 'Total Cases',
    '' AS 'Total Cases'

UNION ALL
SELECT
    'Laboratory' AS 'Diseases, Conditions or Events',
    '<5 Yeas Tested' AS '<5 Years Cases',
    '<5 Years Tested +' AS '<5 Years Deaths',
    '>5 Years Tested' AS '>5 Years Cases',
    '>5 Years Tested +ve' AS '>5 Years Deaths',
    'Total Tested' AS 'Total Cases',
    'Total Tested +ve' AS 'Total Cases'
UNION ALL

SELECT
  'Shigella Dysentry' AS 'Diseases, Conditions or Events',
  IF(malaria.order_id IS NULL, 0, SUM(IF(DATE(malaria.date_started) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF( (  DATE(malaria.date_time) BETWEEN (DATE_ADD(DATE_ADD(malaria.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(malaria.birthdate, INTERVAL 5 YEAR), INTERVAL 0 DAY))  ) , 1, 0),0))) AS '<5 Years Cases',
  IF(malaria.result NOT IN ('Positive', 'positive', '+', '+ve') , 0, SUM(IF(DATE(malaria.date_started) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF( (  DATE(malaria.date_time) BETWEEN (DATE_ADD(DATE_ADD(malaria.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(malaria.birthdate, INTERVAL 5 YEAR), INTERVAL 0 DAY))  ) , 1, 0),0))) AS '<5 Years Deaths',
  IF(malaria.order_id IS NULL, 0, SUM(IF(DATE(malaria.date_started) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF( (  DATE(malaria.date_time) BETWEEN (DATE_ADD(DATE_ADD(malaria.birthdate, INTERVAL 5 YEAR), INTERVAL 1 DAY)) AND (DATE_ADD(DATE_ADD(malaria.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY))  ) , 1, 0),0))) AS '>5 Years Cases',
  IF(malaria.result NOT IN ('Positive', 'positive', '+', '+ve') , 0, SUM(IF(DATE(malaria.date_started) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF( (  DATE(malaria.date_time) BETWEEN (DATE_ADD(DATE_ADD(malaria.birthdate, INTERVAL 5 YEAR), INTERVAL 1 DAY)) AND (DATE_ADD(DATE_ADD(malaria.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY))  ) , 1, 0),0))) AS '>5 Years Deaths',
  IF(malaria.order_id IS NULL, 0, SUM(IF(DATE(malaria.date_started) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF( (  DATE(malaria.date_time) BETWEEN (DATE_ADD(DATE_ADD(malaria.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(malaria.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY))  ) , 1, 0),0))) AS 'Total Cases',
  IF(malaria.result NOT IN ('Positive', 'positive', '+', '+ve') , 0, SUM(IF(DATE(malaria.date_started) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF( (  DATE(malaria.date_time) BETWEEN (DATE_ADD(DATE_ADD(malaria.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(malaria.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY))  ) , 1, 0),0))) AS 'Total Deaths'
FROM (
SELECT DISTINCT
    o.order_id AS order_id,
    obs.obs_id AS obs_id,
    obs.value_coded AS value_coded,
    obs.value_text as result,
    obs.voided AS voided,
    obs.obs_datetime AS date_time,
    p2.date_created AS first_visit_date,
    p.birthdate as birthdate,
    v.date_started AS date_started,
    v.date_stopped AS date_stopped
FROM concept_view cv
INNER JOIN orders o on cv.concept_id = o.concept_id
INNER JOIN encounter e on o.encounter_id = e.encounter_id
INNER JOIN visit v on e.visit_id = v.visit_id
INNER JOIN obs on e.encounter_id = obs.encounter_id
    AND obs.concept_id in (select concept_id from concept_view where concept_full_name IN ('Malaria Parasites (Rapid kit)', 'Malaria Parasite', 'Malaria Ags' 'PBS for Malaria,Filaria Parasites'))
INNER JOIN person p on obs.person_id = p.person_id
INNER JOIN patient p2 on p.person_id = p2.patient_id
WHERE cv.concept_full_name IN ('Malaria Parasites (Rapid kit)', 'Malaria Parasite', 'Malaria Ags' 'PBS for Malaria,Filaria Parasites')
)as malaria

UNION ALL

SELECT
  'Shigella Dysentry' AS 'Diseases, Conditions or Events',
  IF(shiggella.order_id IS NULL, 0, SUM(IF(DATE(shiggella.date_started) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF( (  DATE(shiggella.date_time) BETWEEN (DATE_ADD(DATE_ADD(shiggella.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(shiggella.birthdate, INTERVAL 5 YEAR), INTERVAL 0 DAY))  ) , 1, 0),0))) AS '<5 Years Cases',
  IF(shiggella.result NOT IN ('Positive', 'positive', '+', '+ve') , 0, SUM(IF(DATE(shiggella.date_started) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF( (  DATE(shiggella.date_time) BETWEEN (DATE_ADD(DATE_ADD(shiggella.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(shiggella.birthdate, INTERVAL 5 YEAR), INTERVAL 0 DAY))  ) , 1, 0),0))) AS '<5 Years Deaths',
  IF(shiggella.order_id IS NULL, 0, SUM(IF(DATE(shiggella.date_started) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF( (  DATE(shiggella.date_time) BETWEEN (DATE_ADD(DATE_ADD(shiggella.birthdate, INTERVAL 5 YEAR), INTERVAL 1 DAY)) AND (DATE_ADD(DATE_ADD(shiggella.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY))  ) , 1, 0),0))) AS '>5 Years Cases',
  IF(shiggella.result NOT IN ('Positive', 'positive', '+', '+ve') , 0, SUM(IF(DATE(shiggella.date_started) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF( (  DATE(shiggella.date_time) BETWEEN (DATE_ADD(DATE_ADD(shiggella.birthdate, INTERVAL 5 YEAR), INTERVAL 1 DAY)) AND (DATE_ADD(DATE_ADD(shiggella.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY))  ) , 1, 0),0))) AS '>5 Years Deaths',
  IF(shiggella.order_id IS NULL, 0, SUM(IF(DATE(shiggella.date_started) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF( (  DATE(shiggella.date_time) BETWEEN (DATE_ADD(DATE_ADD(shiggella.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(shiggella.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY))  ) , 1, 0),0))) AS 'Total Cases',
  IF(shiggella.result NOT IN ('Positive', 'positive', '+', '+ve') , 0, SUM(IF(DATE(shiggella.date_started) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF( (  DATE(shiggella.date_time) BETWEEN (DATE_ADD(DATE_ADD(shiggella.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(shiggella.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY))  ) , 1, 0),0))) AS 'Total Deaths'
FROM (
SELECT DISTINCT
    o.order_id AS order_id,
    obs.obs_id AS obs_id,
    obs.value_coded AS value_coded,
    obs.value_text as result,
    obs.voided AS voided,
    obs.obs_datetime AS date_time,
    p2.date_created AS first_visit_date,
    p.birthdate as birthdate,
    v.date_started AS date_started,
    v.date_stopped AS date_stopped
FROM concept_view cv
INNER JOIN orders o on cv.concept_id = o.concept_id
INNER JOIN encounter e on o.encounter_id = e.encounter_id
INNER JOIN visit v on e.visit_id = v.visit_id
INNER JOIN obs on e.encounter_id = obs.encounter_id
    AND obs.concept_id in (select concept_id from concept_view where concept_full_name IN ('Shigella Dysentriae type 1'))
INNER JOIN person p on obs.person_id = p.person_id
INNER JOIN patient p2 on p.person_id = p2.patient_id
WHERE cv.concept_full_name IN ('Shigella Dysentriae type 1')
)as shiggella

UNION ALL


SELECT
  'Typhoid' AS 'Diseases, Conditions or Events',
  IF(typhoid.order_id IS NULL, 0, SUM(IF(DATE(typhoid.date_started) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF( (  DATE(typhoid.date_time) BETWEEN (DATE_ADD(DATE_ADD(typhoid.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(typhoid.birthdate, INTERVAL 5 YEAR), INTERVAL 0 DAY))  ) , 1, 0),0))) AS '<5 Years Cases',
  IF(typhoid.result NOT IN ('Positive', 'positive', '+', '+ve') , 0, SUM(IF(DATE(typhoid.date_started) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF( (  DATE(typhoid.date_time) BETWEEN (DATE_ADD(DATE_ADD(typhoid.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(typhoid.birthdate, INTERVAL 5 YEAR), INTERVAL 0 DAY))  ) , 1, 0),0))) AS '<5 Years Deaths',
  IF(typhoid.order_id IS NULL, 0, SUM(IF(DATE(typhoid.date_started) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF( (  DATE(typhoid.date_time) BETWEEN (DATE_ADD(DATE_ADD(typhoid.birthdate, INTERVAL 5 YEAR), INTERVAL 1 DAY)) AND (DATE_ADD(DATE_ADD(typhoid.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY))  ) , 1, 0),0))) AS '>5 Years Cases',
  IF(typhoid.result NOT IN ('Positive', 'positive', '+', '+ve') , 0, SUM(IF(DATE(typhoid.date_started) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF( (  DATE(typhoid.date_time) BETWEEN (DATE_ADD(DATE_ADD(typhoid.birthdate, INTERVAL 5 YEAR), INTERVAL 1 DAY)) AND (DATE_ADD(DATE_ADD(typhoid.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY))  ) , 1, 0),0))) AS '>5 Years Deaths',
  IF(typhoid.order_id IS NULL, 0, SUM(IF(DATE(typhoid.date_started) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF( (  DATE(typhoid.date_time) BETWEEN (DATE_ADD(DATE_ADD(typhoid.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(typhoid.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY))  ) , 1, 0),0))) AS 'Total Cases',
  IF(typhoid.result NOT IN ('Positive', 'positive', '+', '+ve') , 0, SUM(IF(DATE(typhoid.date_started) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF( (  DATE(typhoid.date_time) BETWEEN (DATE_ADD(DATE_ADD(typhoid.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(typhoid.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY))  ) , 1, 0),0))) AS 'Total Deaths'
FROM (
SELECT DISTINCT
    o.order_id AS order_id,
    obs.obs_id AS obs_id,
    obs.value_coded AS value_coded,
    obs.value_text as result,
    obs.voided AS voided,
    obs.obs_datetime AS date_time,
    p2.date_created AS first_visit_date,
    p.birthdate as birthdate,
    v.date_started AS date_started,
    v.date_stopped AS date_stopped
FROM concept_view cv
INNER JOIN orders o on cv.concept_id = o.concept_id
INNER JOIN encounter e on o.encounter_id = e.encounter_id
INNER JOIN visit v on e.visit_id = v.visit_id
INNER JOIN obs on e.encounter_id = obs.encounter_id
    AND obs.concept_id in (select concept_id from concept_view where concept_full_name IN ('Typhoid'))
INNER JOIN person p on obs.person_id = p.person_id
INNER JOIN patient p2 on p.person_id = p2.patient_id
WHERE cv.concept_full_name IN ('Typhoid')
)as typhoid


