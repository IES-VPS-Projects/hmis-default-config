SELECT 'B4. ORTHOPEDIC TRAUMA SERVICES ' AS 'Service',
     ' ' as '<5 Years New',
     '' as '<5 Years Revisit',
     ' ' as '>5 Years New',
     '' as '>5 Years Revisit'

UNION ALL

SELECT '1. No. of Casts fixed' AS 'Service',
       IF(ortho_val.encounter_id IS NULL, 0, SUM(IF(DATE(ortho_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 5 YEAR), INTERVAL 0 DAY))  , 1, 0))) AS '<5 Years New',
  IF(ortho_val.encounter_id IS NULL, 0, SUM(IF(DATE(ortho_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 5 YEAR), INTERVAL 0 DAY))  , 1, 0))) AS '<5 Years Revisit',
  IF(ortho_val.encounter_id IS NULL, 0, SUM(IF(DATE(ortho_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 5 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY))  , 1, 0))) AS '>5 Years New',
  IF(ortho_val.encounter_id IS NULL, 0, SUM(IF(DATE(ortho_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 5 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY))  , 1, 0))) AS '>5 Years Revisit'

FROM
  (SELECT DISTINCT
     encounter.encounter_id AS encounter_id,
     o.obs_id         AS obs_id,
     o.voided         AS voided,
     o.obs_datetime   AS obs_datetime,
     v.date_started   AS visit_date,
     p.patient_id     AS patient_id,
     person.birthdate AS birthdate,
     p.date_created   AS first_visit_date
   FROM encounter
     INNER JOIN visit v ON encounter.visit_id = v.visit_id
     INNER JOIN obs o ON encounter.encounter_id = o.encounter_id
                         AND DATE(o.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
                         AND o.voided = 0
     INNER JOIN concept c ON o.value_coded = c.concept_id
     INNER JOIN concept_view cv ON c.concept_id = cv.concept_id
                                   AND cv.concept_full_name=""
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
            AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 10 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 19 YEAR), INTERVAL 0 DAY))
   GROUP BY encounter_id
  ) AS ortho_val

UNION ALL

SELECT '2. No. of Tractions fixed' AS 'Service',
       IF(ortho_val.encounter_id IS NULL, 0, SUM(IF(DATE(ortho_val.first_visit_date) = DATE(ortho_val.obs_datetime) AND DATE(ortho_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 5 YEAR), INTERVAL 0 DAY))  , 1, 0))) AS '<5 Years New',
       IF(ortho_val.encounter_id IS NULL, 0, SUM(IF(DATE(ortho_val.first_visit_date) < DATE(ortho_val.obs_datetime) AND DATE(ortho_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 5 YEAR), INTERVAL 0 DAY))  , 1, 0))) AS '<5 Years Revisit',
       IF(ortho_val.encounter_id IS NULL, 0, SUM(IF(DATE(ortho_val.first_visit_date) = DATE(ortho_val.obs_datetime) AND DATE(ortho_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 5 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY))  , 1, 0))) AS '>5 Years New',
       IF(ortho_val.encounter_id IS NULL, 0, SUM(IF(DATE(ortho_val.first_visit_date) < DATE(ortho_val.obs_datetime) AND DATE(ortho_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 5 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY))  , 1, 0))) AS '>5 Years Revisit'

FROM
  (SELECT DISTINCT p.patient_id AS patient_id,
                   encounter.encounter_id AS encounter_id,
                   o.obs_datetime   AS obs_datetime,
                   o.obs_id AS obs_id,
                   person.birthdate AS birthdate,
                   p.date_created   AS first_visit_date
   FROM encounter
     INNER JOIN visit v ON encounter.visit_id = v.visit_id
     INNER JOIN obs o ON encounter.encounter_id = o.encounter_id
                         AND DATE(o.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#'  AS DATE)
                         AND o.voided = 0
     INNER JOIN concept c ON o.value_coded = c.concept_id
     INNER JOIN concept_view cv ON c.concept_id = cv.concept_id
                                   AND cv.concept_full_name IN ("Ortho, Application of skin traction")
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
  ) AS ortho_val


UNION ALL

SELECT '3. No. of Closed Reductions (Fractures, Dislocations)' AS 'Service',
       IF(ortho_val.encounter_id IS NULL, 0, SUM(IF(DATE(ortho_val.first_visit_date) = DATE(ortho_val.obs_datetime) AND DATE(ortho_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 5 YEAR), INTERVAL 0 DAY))  , 1, 0))) AS '<5 Years New',
       IF(ortho_val.encounter_id IS NULL, 0, SUM(IF(DATE(ortho_val.first_visit_date) < DATE(ortho_val.obs_datetime) AND DATE(ortho_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 5 YEAR), INTERVAL 0 DAY))  , 1, 0))) AS '<5 Years Revisit',
       IF(ortho_val.encounter_id IS NULL, 0, SUM(IF(DATE(ortho_val.first_visit_date) = DATE(ortho_val.obs_datetime) AND DATE(ortho_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 5 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY))  , 1, 0))) AS '>5 Years New',
       IF(ortho_val.encounter_id IS NULL, 0, SUM(IF(DATE(ortho_val.first_visit_date) < DATE(ortho_val.obs_datetime) AND DATE(ortho_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 5 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY))  , 1, 0))) AS '>5 Years Revisit'

FROM
  (SELECT DISTINCT p.patient_id AS patient_id,
                   encounter.encounter_id AS encounter_id,
                   o.obs_datetime   AS obs_datetime,
                   o.obs_id AS obs_id,
                   person.birthdate AS birthdate,
                   p.date_created   AS first_visit_date
   FROM encounter
     INNER JOIN visit v ON encounter.visit_id = v.visit_id
     INNER JOIN obs o ON encounter.encounter_id = o.encounter_id
                         AND DATE(o.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#'  AS DATE)
                         AND o.voided = 0
     INNER JOIN concept c ON o.value_coded = c.concept_id
     INNER JOIN concept_view cv ON c.concept_id = cv.concept_id
                AND cv.concept_full_name IN ("Ortho, Shoulder", "Ortho, Elbow", "Ortho, Phalanges", "Ortho, Knee",
                                              "Ortho, Hip", "Ortho, Ankle", "Ortho, Wrist Joint")
     INNER JOIN concept_view cv2 ON cv2.concept_id=o.concept_id
                AND cv2.concept_full_name IN ("Ortho, Reduction of Dislocation")
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
     GROUP BY obs_id
  ) AS ortho_val

UNION ALL

SELECT '4. No. of Orthopedic cases assisted in theatre' AS 'Service',
       IF(ortho_val.encounter_id IS NULL, 0, SUM(IF(DATE(ortho_val.first_visit_date) = DATE(ortho_val.obs_datetime) AND DATE(ortho_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 5 YEAR), INTERVAL 0 DAY))  , 1, 0))) AS '<5 Years New',
       IF(ortho_val.encounter_id IS NULL, 0, SUM(IF(DATE(ortho_val.first_visit_date) < DATE(ortho_val.obs_datetime) AND DATE(ortho_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 5 YEAR), INTERVAL 0 DAY))  , 1, 0))) AS '<5 Years Revisit',
       IF(ortho_val.encounter_id IS NULL, 0, SUM(IF(DATE(ortho_val.first_visit_date) = DATE(ortho_val.obs_datetime) AND DATE(ortho_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 5 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY))  , 1, 0))) AS '>5 Years New',
       IF(ortho_val.encounter_id IS NULL, 0, SUM(IF(DATE(ortho_val.first_visit_date) < DATE(ortho_val.obs_datetime) AND DATE(ortho_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 5 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY))  , 1, 0))) AS '>5 Years Revisit'

FROM
  (SELECT DISTINCT p.patient_id AS patient_id,
                   encounter.encounter_id AS encounter_id,
                   o.obs_datetime   AS obs_datetime,
                   o.obs_id AS obs_id,
                   person.birthdate AS birthdate,
                   p.date_created   AS first_visit_date
   FROM encounter
     INNER JOIN visit v ON encounter.visit_id = v.visit_id
     INNER JOIN obs o ON encounter.encounter_id = o.encounter_id
                         AND DATE(o.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#'  AS DATE)
                         AND o.voided = 0
     INNER JOIN concept c ON o.value_coded = c.concept_id
     INNER JOIN concept_view cv ON c.concept_id = cv.concept_id
                                   AND cv.concept_full_name IN ("")
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
  ) AS ortho_val

UNION ALL

SELECT '5. No. of club foot seen/ corrected (Ponseti method)' AS 'Service',
       IF(ortho_val.encounter_id IS NULL, 0, SUM(IF(DATE(ortho_val.first_visit_date) = DATE(ortho_val.obs_datetime) AND DATE(ortho_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 5 YEAR), INTERVAL 0 DAY))  , 1, 0))) AS '<5 Years New',
       IF(ortho_val.encounter_id IS NULL, 0, SUM(IF(DATE(ortho_val.first_visit_date) < DATE(ortho_val.obs_datetime) AND DATE(ortho_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 5 YEAR), INTERVAL 0 DAY))  , 1, 0))) AS '<5 Years Revisit',
       IF(ortho_val.encounter_id IS NULL, 0, SUM(IF(DATE(ortho_val.first_visit_date) = DATE(ortho_val.obs_datetime) AND DATE(ortho_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 5 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY))  , 1, 0))) AS '>5 Years New',
       IF(ortho_val.encounter_id IS NULL, 0, SUM(IF(DATE(ortho_val.first_visit_date) < DATE(ortho_val.obs_datetime) AND DATE(ortho_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 5 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY))  , 1, 0))) AS '>5 Years Revisit'

FROM
  (SELECT DISTINCT p.patient_id AS patient_id,
                   encounter.encounter_id AS encounter_id,
                   o.obs_datetime   AS obs_datetime,
                   o.obs_id AS obs_id,
                   person.birthdate AS birthdate,
                   p.date_created   AS first_visit_date
   FROM encounter
     INNER JOIN visit v ON encounter.visit_id = v.visit_id
     INNER JOIN obs o ON encounter.encounter_id = o.encounter_id
                         AND DATE(o.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#'  AS DATE)
                         AND o.voided = 0
     INNER JOIN concept c ON o.value_coded = c.concept_id
     INNER JOIN concept_view cv ON c.concept_id = cv.concept_id
                                   AND cv.concept_full_name IN ("")
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
  ) AS ortho_val

UNION ALL

SELECT '6. No. of crepe bandages and arm slings applied' AS 'Service',
       IF(ortho_val.encounter_id IS NULL, 0, SUM(IF(DATE(ortho_val.first_visit_date) = DATE(ortho_val.obs_datetime) AND DATE(ortho_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 5 YEAR), INTERVAL 0 DAY))  , 1, 0))) AS '<5 Years New',
       IF(ortho_val.encounter_id IS NULL, 0, SUM(IF(DATE(ortho_val.first_visit_date) < DATE(ortho_val.obs_datetime) AND DATE(ortho_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 5 YEAR), INTERVAL 0 DAY))  , 1, 0))) AS '<5 Years Revisit',
       IF(ortho_val.encounter_id IS NULL, 0, SUM(IF(DATE(ortho_val.first_visit_date) = DATE(ortho_val.obs_datetime) AND DATE(ortho_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 5 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY))  , 1, 0))) AS '>5 Years New',
       IF(ortho_val.encounter_id IS NULL, 0, SUM(IF(DATE(ortho_val.first_visit_date) < DATE(ortho_val.obs_datetime) AND DATE(ortho_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 5 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY))  , 1, 0))) AS '>5 Years Revisit'

FROM
  (SELECT DISTINCT p.patient_id AS patient_id,
                   encounter.encounter_id AS encounter_id,
                   o.obs_datetime   AS obs_datetime,
                   o.obs_id AS obs_id,
                   person.birthdate AS birthdate,
                   p.date_created   AS first_visit_date
   FROM encounter
     INNER JOIN visit v ON encounter.visit_id = v.visit_id
     INNER JOIN obs o ON encounter.encounter_id = o.encounter_id
                         AND DATE(o.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#'  AS DATE)
                         AND o.voided = 0
     INNER JOIN concept c ON o.value_coded = c.concept_id
     INNER JOIN concept_view cv ON c.concept_id = cv.concept_id
                                   AND cv.concept_full_name IN ("Ortho, Application of crepe bandage",
                                   "Ortho, Application of crepe bandage - 100ksh", "Ortho, Application of crepe bandage - 200ksh")
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
  ) AS ortho_val

UNION ALL

SELECT '' AS 'Service',
       ' ' as '<5 Years New',
       '' as '<5 Years Revisit',
       ' ' as '>5 Years New',
       '' as '>5 Years Revisit'

UNION ALL

SELECT 'Removals ' AS 'Service',
       ' ' as '<5 Years New',
       '' as '<5 Years Revisit',
       ' ' as '>5 Years New',
       '' as '>5 Years Revisit'

UNION ALL

SELECT 'No. of removal done - Casts' AS 'Service',
       IF(ortho_val.encounter_id IS NULL, 0, SUM(IF(DATE(ortho_val.first_visit_date) = DATE(ortho_val.obs_datetime) AND DATE(ortho_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 5 YEAR), INTERVAL 0 DAY))  , 1, 0))) AS '<5 Years New',
       IF(ortho_val.encounter_id IS NULL, 0, SUM(IF(DATE(ortho_val.first_visit_date) < DATE(ortho_val.obs_datetime) AND DATE(ortho_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 5 YEAR), INTERVAL 0 DAY))  , 1, 0))) AS '<5 Years Revisit',
       IF(ortho_val.encounter_id IS NULL, 0, SUM(IF(DATE(ortho_val.first_visit_date) = DATE(ortho_val.obs_datetime) AND DATE(ortho_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 5 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY))  , 1, 0))) AS '>5 Years New',
       IF(ortho_val.encounter_id IS NULL, 0, SUM(IF(DATE(ortho_val.first_visit_date) < DATE(ortho_val.obs_datetime) AND DATE(ortho_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 5 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY))  , 1, 0))) AS '>5 Years Revisit'

FROM
  (SELECT DISTINCT p.patient_id AS patient_id,
                   encounter.encounter_id AS encounter_id,
                   o.obs_datetime   AS obs_datetime,
                   o.obs_id AS obs_id,
                   person.birthdate AS birthdate,
                   p.date_created   AS first_visit_date
   FROM encounter
     INNER JOIN visit v ON encounter.visit_id = v.visit_id
     INNER JOIN obs o ON encounter.encounter_id = o.encounter_id
                         AND DATE(o.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#'  AS DATE)
                         AND o.voided = 0
     INNER JOIN concept c ON o.value_coded = c.concept_id
     INNER JOIN concept_view cv ON c.concept_id = cv.concept_id
                AND cv.concept_full_name IN ("Ortho, POP")
     INNER JOIN concept_view cv2 ON cv2.concept_id=o.concept_id
                AND cv2.concept_full_name IN ("Ortho, Inpatient Removals")
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
     GROUP BY obs_id
  ) AS ortho_val

UNION ALL

SELECT 'No. of removal done - Tractions' AS 'Service',
       IF(ortho_val.encounter_id IS NULL, 0, SUM(IF(DATE(ortho_val.first_visit_date) = DATE(ortho_val.obs_datetime) AND DATE(ortho_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 5 YEAR), INTERVAL 0 DAY))  , 1, 0))) AS '<5 Years New',
       IF(ortho_val.encounter_id IS NULL, 0, SUM(IF(DATE(ortho_val.first_visit_date) < DATE(ortho_val.obs_datetime) AND DATE(ortho_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 5 YEAR), INTERVAL 0 DAY))  , 1, 0))) AS '<5 Years Revisit',
       IF(ortho_val.encounter_id IS NULL, 0, SUM(IF(DATE(ortho_val.first_visit_date) = DATE(ortho_val.obs_datetime) AND DATE(ortho_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 5 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY))  , 1, 0))) AS '>5 Years New',
       IF(ortho_val.encounter_id IS NULL, 0, SUM(IF(DATE(ortho_val.first_visit_date) < DATE(ortho_val.obs_datetime) AND DATE(ortho_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 5 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY))  , 1, 0))) AS '>5 Years Revisit'

FROM
  (SELECT DISTINCT p.patient_id AS patient_id,
                   encounter.encounter_id AS encounter_id,
                   o.obs_datetime   AS obs_datetime,
                   o.obs_id AS obs_id,
                   person.birthdate AS birthdate,
                   p.date_created   AS first_visit_date
   FROM encounter
     INNER JOIN visit v ON encounter.visit_id = v.visit_id
     INNER JOIN obs o ON encounter.encounter_id = o.encounter_id
                         AND DATE(o.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#'  AS DATE)
                         AND o.voided = 0
     INNER JOIN concept c ON o.value_coded = c.concept_id
     INNER JOIN concept_view cv ON c.concept_id = cv.concept_id
                AND cv.concept_full_name IN ("Ortho, skin traction")
     INNER JOIN concept_view cv2 ON cv2.concept_id=o.concept_id
                AND cv2.concept_full_name IN ("Ortho, Inpatient Removals")
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
     GROUP BY obs_id
  ) AS ortho_val

UNION ALL

SELECT 'No. of removal done - Ex-Fixator' AS 'Service',
       IF(ortho_val.encounter_id IS NULL, 0, SUM(IF(DATE(ortho_val.first_visit_date) = DATE(ortho_val.obs_datetime) AND DATE(ortho_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 5 YEAR), INTERVAL 0 DAY))  , 1, 0))) AS '<5 Years New',
       IF(ortho_val.encounter_id IS NULL, 0, SUM(IF(DATE(ortho_val.first_visit_date) < DATE(ortho_val.obs_datetime) AND DATE(ortho_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 0 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 5 YEAR), INTERVAL 0 DAY))  , 1, 0))) AS '<5 Years Revisit',
       IF(ortho_val.encounter_id IS NULL, 0, SUM(IF(DATE(ortho_val.first_visit_date) = DATE(ortho_val.obs_datetime) AND DATE(ortho_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 5 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY))  , 1, 0))) AS '>5 Years New',
       IF(ortho_val.encounter_id IS NULL, 0, SUM(IF(DATE(ortho_val.first_visit_date) < DATE(ortho_val.obs_datetime) AND DATE(ortho_val.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 5 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(ortho_val.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY))  , 1, 0))) AS '>5 Years Revisit'

FROM
  (SELECT DISTINCT p.patient_id AS patient_id,
                   encounter.encounter_id AS encounter_id,
                   o.obs_datetime   AS obs_datetime,
                   o.obs_id AS obs_id,
                   person.birthdate AS birthdate,
                   p.date_created   AS first_visit_date
   FROM encounter
     INNER JOIN visit v ON encounter.visit_id = v.visit_id
     INNER JOIN obs o ON encounter.encounter_id = o.encounter_id
                         AND DATE(o.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#'  AS DATE)
                         AND o.voided = 0
     INNER JOIN concept c ON o.value_coded = c.concept_id
     INNER JOIN concept_view cv ON c.concept_id = cv.concept_id
                AND cv.concept_full_name IN ("")
     INNER JOIN concept_view cv2 ON cv2.concept_id=o.concept_id
                AND cv2.concept_full_name IN ("Ortho, Inpatient Removals")
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
     GROUP BY obs_id
  ) AS ortho_val
