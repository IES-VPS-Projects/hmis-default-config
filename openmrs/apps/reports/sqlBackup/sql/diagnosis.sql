SELECT disease.map_id AS 'No.' ,disease.disease_name AS 'DISEASES (New Cases Only) ',
    IF(disease.value_coded IS NULL, 0, SUM(IF(DATE(disease.first_visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF(DAY(DATE(disease.date_time)) = 1, 1, 0),0))) AS '1',
    IF(disease.value_coded IS NULL, 0, SUM(IF(DATE(disease.first_visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF(DAY(DATE(disease.date_time)) = 2, 1, 0),0))) AS '2',
    IF(disease.value_coded IS NULL, 0, SUM(IF(DATE(disease.first_visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF(DAY(DATE(disease.date_time)) = 3, 1, 0),0))) AS '3',
    IF(disease.value_coded IS NULL, 0, SUM(IF(DATE(disease.first_visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF(DAY(DATE(disease.date_time)) = 4, 1, 0),0))) AS '4',
    IF(disease.value_coded IS NULL, 0, SUM(IF(DATE(disease.first_visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF(DAY(DATE(disease.date_time)) = 5, 1, 0),0))) AS '5',
    IF(disease.value_coded IS NULL, 0, SUM(IF(DATE(disease.first_visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF(DAY(DATE(disease.date_time)) = 6, 1, 0),0))) AS '6',
    IF(disease.value_coded IS NULL, 0, SUM(IF(DATE(disease.first_visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF(DAY(DATE(disease.date_time)) = 7, 1, 0),0))) AS '7',
    IF(disease.value_coded IS NULL, 0, SUM(IF(DATE(disease.first_visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF(DAY(DATE(disease.date_time)) = 8, 1, 0),0))) AS '8',
    IF(disease.value_coded IS NULL, 0, SUM(IF(DATE(disease.first_visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF(DAY(DATE(disease.date_time)) = 9, 1, 0),0))) AS '9',
    IF(disease.value_coded IS NULL, 0, SUM(IF(DATE(disease.first_visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF(DAY(DATE(disease.date_time)) = 10, 1, 0),0))) AS '10',
    IF(disease.value_coded IS NULL, 0, SUM(IF(DATE(disease.first_visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF(DAY(DATE(disease.date_time)) = 11, 1, 0),0))) AS '11',
    IF(disease.value_coded IS NULL, 0, SUM(IF(DATE(disease.first_visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF(DAY(DATE(disease.date_time)) = 12, 1, 0),0))) AS '12',
    IF(disease.value_coded IS NULL, 0, SUM(IF(DATE(disease.first_visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF(DAY(DATE(disease.date_time)) = 13, 1, 0),0))) AS '13',
    IF(disease.value_coded IS NULL, 0, SUM(IF(DATE(disease.first_visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF(DAY(DATE(disease.date_time)) = 14, 1, 0),0))) AS '14',
    IF(disease.value_coded IS NULL, 0, SUM(IF(DATE(disease.first_visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF(DAY(DATE(disease.date_time)) = 15, 1, 0),0))) AS '15',
    IF(disease.value_coded IS NULL, 0, SUM(IF(DATE(disease.first_visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF(DAY(DATE(disease.date_time)) = 16, 1, 0),0))) AS '16',
    IF(disease.value_coded IS NULL, 0, SUM(IF(DATE(disease.first_visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF(DAY(DATE(disease.date_time)) = 17, 1, 0),0))) AS '17',
    IF(disease.value_coded IS NULL, 0, SUM(IF(DATE(disease.first_visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF(DAY(DATE(disease.date_time)) = 18, 1, 0),0))) AS '18',
    IF(disease.value_coded IS NULL, 0, SUM(IF(DATE(disease.first_visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF(DAY(DATE(disease.date_time)) = 19, 1, 0),0))) AS '19',
    IF(disease.value_coded IS NULL, 0, SUM(IF(DATE(disease.first_visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF(DAY(DATE(disease.date_time)) = 20, 1, 0),0))) AS '20',
    IF(disease.value_coded IS NULL, 0, SUM(IF(DATE(disease.first_visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF(DAY(DATE(disease.date_time)) = 21, 1, 0),0))) AS '21',
    IF(disease.value_coded IS NULL, 0, SUM(IF(DATE(disease.first_visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF(DAY(DATE(disease.date_time)) = 22, 1, 0),0))) AS '22',
    IF(disease.value_coded IS NULL, 0, SUM(IF(DATE(disease.first_visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF(DAY(DATE(disease.date_time)) = 23, 1, 0),0))) AS '23',
    IF(disease.value_coded IS NULL, 0, SUM(IF(DATE(disease.first_visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF(DAY(DATE(disease.date_time)) = 24, 1, 0),0))) AS '24',
    IF(disease.value_coded IS NULL, 0, SUM(IF(DATE(disease.first_visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF(DAY(DATE(disease.date_time)) = 25, 1, 0),0))) AS '25',
    IF(disease.value_coded IS NULL, 0, SUM(IF(DATE(disease.first_visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF(DAY(DATE(disease.date_time)) = 26, 1, 0),0))) AS '26',
    IF(disease.value_coded IS NULL, 0, SUM(IF(DATE(disease.first_visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF(DAY(DATE(disease.date_time)) = 27, 1, 0),0))) AS '27',
    IF(disease.value_coded IS NULL, 0, SUM(IF(DATE(disease.first_visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF(DAY(DATE(disease.date_time)) = 28, 1, 0),0))) AS '28',
    IF(disease.value_coded IS NULL, 0, SUM(IF(DATE(disease.first_visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF(DAY(DATE(disease.date_time)) = 29, 1, 0),0))) AS '29',
    IF(disease.value_coded IS NULL, 0, SUM(IF(DATE(disease.first_visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF(DAY(DATE(disease.date_time)) = 30, 1, 0),0))) AS '30',
    IF(disease.value_coded IS NULL, 0, SUM(IF(DATE(disease.first_visit_date) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE),IF(DAY(DATE(disease.date_time)) = 31, 1, 0),0))) AS '31'


FROM
  (SELECT DISTINCT obs.obs_id AS obs_id,
                   obs.value_coded AS value_coded,
                   obs.voided AS voided,
                   obs.obs_datetime AS date_time,
                   patient.date_created AS first_visit_date,
                   disease_concepts_map.disease_name AS disease_name,
                   disease_concepts_map.map_id AS map_id

FROM disease_concepts_map
 LEFT OUTER JOIN obs ON  obs.value_coded = disease_concepts_map.concept_id
 LEFT OUTER JOIN encounter ON encounter.encounter_id = obs.encounter_id
 LEFT OUTER JOIN visit ON visit.visit_id = encounter.visit_id
 LEFT OUTER JOIN patient ON patient.patient_id=obs.person_id
 LEFT OUTER JOIN person ON person.person_id=patient.patient_id
 LEFT OUTER JOIN reporting_age_group AS observed_age_group ON
                                                                  DATE(visit.date_stopped) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.min_years YEAR), INTERVAL observed_age_group.min_days DAY))
                                                                  AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL observed_age_group.max_years YEAR), INTERVAL observed_age_group.max_days DAY))
) AS disease
GROUP BY disease.map_id;

