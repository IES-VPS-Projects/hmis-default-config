SELECT
  CONCAT(COALESCE(pn.given_name,''),' ',COALESCE(pn.middle_name,''),' ',COALESCE(pn.family_name,''))  AS 'Name',
  FLOOR(DATEDIFF(v.date_started,p.birthdate)/365) as age,
  p.gender,
  GROUP_CONCAT(cn.name) as 'Diagnosis'


from patient pt
INNER JOIN person p ON pt.patient_id = p.person_id
INNER JOIN person_name pn ON p.person_id = pn.person_id
INNER JOIN visit v ON pt.patient_id = v.patient_id
      AND DATE(v.date_started) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
LEFT JOIN encounter e ON v.visit_id = e.visit_id
      AND DATE(e.encounter_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
LEFT JOIN obs ON e.encounter_id = obs.encounter_id
      AND obs.concept_id= (select concept_view.concept_id from concept_view where concept_full_name="Coded Diagnosis")
LEFT JOIN concept_view cv ON cv.concept_id=obs.value_coded
LEFT JOIN (select if(cv.concept_short_name IS NOT NUll, cv.concept_short_name, cv.concept_full_name) as name,
                  cv.concept_id
           from concept_view cv)cn ON cn.concept_id=cv.concept_id
GROUP BY pt.patient_id
