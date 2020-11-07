SELECT 'D. Family Planning (Number of clients issue with contraceptives) ' AS 'Service',
      '' AS 'NEW',
     ' ' as 'REVISITS'

UNION ALL

SELECT '1. No. of 1st ever users of contraceptive' AS 'Service',
  IF(fp_val.encounter_id IS NULL, 0, SUM(IF(fp_val.encounter_id IS NOT NULL  , 1, 0))) AS 'NEW', -- Sort out this condition
       ' ' as 'REVISITS'

FROM
  (SELECT DISTINCT
    encounter.encounter_id AS encounter_id,
     o.obs_id         AS obs_id,
     o.voided         AS voided,
     o.obs_datetime   AS date_time,
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
                          AND (cv.concept_full_name="FP,Using a regular FP Method" AND o.value_coded = 2147) -- Where not currently using
     INNER JOIN concept_view cv2 ON c.concept_id = cv2.concept_id
                                   AND (cv2.concept_full_name="FP,If Not using" AND o.value_coded = 2174) -- Where not currently using
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
   GROUP BY encounter_id
  ) AS fp_val


UNION ALL


SELECT '2.  Pills      |     Progrestin Only Pills' AS 'Service',
  IF(fp_val.encounter_id IS NULL, 0, SUM(IF(fp_val.encounter_id IS NOT NULL  , 1, 0))) AS 'NEW', -- Sort out this condition
  ' ' as 'REVISITS'

FROM
  (SELECT DISTINCT
     encounter.encounter_id AS encounter_id,
     o.obs_id         AS obs_id,
     o.voided         AS voided,
     o.obs_datetime   AS date_time,
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
                                   AND cv.concept_full_name="FP, Progesterone"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
   GROUP BY encounter_id
  ) AS fp_val

UNION ALL


SELECT '3.  Pills       |      Combined Oral Contraceptives pills' AS 'Service',
       IF(fp_val.encounter_id IS NULL, 0, SUM(IF(fp_val.encounter_id IS NOT NULL  , 1, 0))) AS 'NEW', -- Sort out this condition
       ' ' as 'REVISITS'

FROM
  (SELECT DISTINCT
     encounter.encounter_id AS encounter_id,
     o.obs_id         AS obs_id,
     o.voided         AS voided,
     o.obs_datetime   AS date_time,
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
                                   AND cv.concept_full_name="FP, Combined Pills"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
   GROUP BY encounter_id
  ) AS fp_val

UNION ALL


SELECT '4. Pills      |     Emergency Contraceptives pills' AS 'Service',
       IF(fp_val.encounter_id IS NULL, 0, SUM(IF(fp_val.encounter_id IS NOT NULL  , 1, 0))) AS 'NEW', -- Sort out this condition
       ' ' as 'REVISITS'

FROM
  (SELECT DISTINCT
     encounter.encounter_id AS encounter_id,
     o.obs_id         AS obs_id,
     o.voided         AS voided,
     o.obs_datetime   AS date_time,
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
                                   AND cv.concept_full_name="FP, Emergency Pills"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
   GROUP BY encounter_id
  ) AS fp_val

UNION ALL

SELECT '5. Injectibles      |     DMPA-IM' AS 'Service',
       IF(fp_val.encounter_id IS NULL, 0, SUM(IF(fp_val.encounter_id IS NOT NULL  , 1, 0))) AS 'NEW', -- Sort out this condition
       ' ' as 'REVISITS'

FROM
  (SELECT DISTINCT
     encounter.encounter_id AS encounter_id,
     o.obs_id         AS obs_id,
     o.voided         AS voided,
     o.obs_datetime   AS date_time,
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
                                   AND cv.concept_full_name="FP, DMPA IM"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
   GROUP BY encounter_id
  ) AS fp_val

UNION ALL

SELECT '6. Injectibles      |     DMPA-SC' AS 'Service',
       IF(fp_val.encounter_id IS NULL, 0, SUM(IF(fp_val.encounter_id IS NOT NULL  , 1, 0))) AS 'NEW', -- Sort out this condition
       ' ' as 'REVISITS'

FROM
  (SELECT DISTINCT
     encounter.encounter_id AS encounter_id,
     o.obs_id         AS obs_id,
     o.voided         AS voided,
     o.obs_datetime   AS date_time,
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
                                   AND cv.concept_full_name="FP, DMPA SC"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
   GROUP BY encounter_id
  ) AS fp_val

UNION ALL

SELECT '7. Condoms      |     No of clients received (Male condoms)' AS 'Service',
       IF(fp_val.encounter_id IS NULL, 0, SUM(IF(fp_val.encounter_id IS NOT NULL  , 1, 0))) AS 'NEW', -- Sort out this condition
       ' ' as 'REVISITS'

FROM
  (SELECT DISTINCT
     encounter.encounter_id AS encounter_id,
     o.obs_id         AS obs_id,
     o.voided         AS voided,
     o.obs_datetime   AS date_time,
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
                                   AND cv.concept_full_name="FP,Male Condoms"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
   GROUP BY encounter_id
  ) AS fp_val

UNION ALL

SELECT '8. Condoms      |     No of clients received (Female condoms)' AS 'Service',
       IF(fp_val.encounter_id IS NULL, 0, SUM(IF(fp_val.encounter_id IS NOT NULL  , 1, 0))) AS 'NEW', -- Sort out this condition
       ' ' as 'REVISITS'

FROM
  (SELECT DISTINCT
     encounter.encounter_id AS encounter_id,
     o.obs_id         AS obs_id,
     o.voided         AS voided,
     o.obs_datetime   AS date_time,
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
                                   AND cv.concept_full_name="FP,Female Condom"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
   GROUP BY encounter_id
  ) AS fp_val

UNION ALL

SELECT '9. Condoms      |     No of clients received (Both Male and Female condoms)' AS 'Service',
       IF(fp_val.encounter_id IS NULL, 0, SUM(IF(fp_val.encounter_id IS NOT NULL  , 1, 0))) AS 'NEW', -- Sort out this condition
       ' ' as 'REVISITS'

FROM
  (SELECT DISTINCT
     encounter.encounter_id AS encounter_id,
     o.obs_id         AS obs_id,
     o.voided         AS voided,
     o.obs_datetime   AS date_time,
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
                                   AND cv.concept_full_name IN ("FP,Female Condom","FP,Male Condoms")
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
   GROUP BY encounter_id
  ) AS fp_val

UNION ALL

SELECT '10. Natural FP      |     No of counselled on Natural FP' AS 'Service',
       IF(fp_val.encounter_id IS NULL, 0, SUM(IF(fp_val.encounter_id IS NOT NULL  , 1, 0))) AS 'NEW', -- Sort out this condition
       ' ' as 'REVISITS'

FROM
  (SELECT DISTINCT
     encounter.encounter_id AS encounter_id,
     o.obs_id         AS obs_id,
     o.voided         AS voided,
     o.obs_datetime   AS date_time,
     v.date_started   AS visit_date,
     p.patient_id     AS patient_id,
     person.birthdate AS birthdate,
     p.date_created   AS first_visit_date
   FROM encounter
     INNER JOIN visit v ON encounter.visit_id = v.visit_id
     INNER JOIN obs o ON encounter.encounter_id = o.encounter_id
                         AND DATE(o.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
                         AND o.voided = 0
                         AND o.concept_id = (select concept_id from concept_view where concept_full_name="FP, Counselled on Natural FP")
     INNER JOIN concept c ON o.value_coded = c.concept_id
     INNER JOIN concept_view cv ON c.concept_id = cv.concept_id
                                   AND cv.concept_full_name="True"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
   GROUP BY encounter_id
  ) AS fp_val

UNION ALL

SELECT '11. Natural FP      |     No of clients given cycle beads' AS 'Service',
       IF(fp_val.encounter_id IS NULL, 0, SUM(IF(fp_val.encounter_id IS NOT NULL  , 1, 0))) AS 'NEW', -- Sort out this condition
       ' ' as 'REVISITS'

FROM
  (SELECT DISTINCT
     encounter.encounter_id AS encounter_id,
     o.obs_id         AS obs_id,
     o.voided         AS voided,
     o.obs_datetime   AS date_time,
     v.date_started   AS visit_date,
     p.patient_id     AS patient_id,
     person.birthdate AS birthdate,
     p.date_created   AS first_visit_date
   FROM encounter
     INNER JOIN visit v ON encounter.visit_id = v.visit_id
     INNER JOIN obs o ON encounter.encounter_id = o.encounter_id
                         AND DATE(o.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
                         AND o.concept_id = (select concept_id from concept_view where concept_full_name="FP, Given Cycle Beads")
                         AND o.voided = 0
     INNER JOIN concept c ON o.value_coded = c.concept_id
     INNER JOIN concept_view cv ON c.concept_id = cv.concept_id
                                   AND cv.concept_full_name IN ("True")
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
   GROUP BY encounter_id
  ) AS fp_val

UNION ALL

SELECT '' AS 'Service',
       '' AS 'NEW',
       ' ' as 'REVISITS'

UNION ALL

SELECT '' AS 'Service',
       '' AS 'NEW',
       ' ' as 'REVISITS'

UNION ALL

SELECT 'Long Acting and permanent methods' AS 'Service',
       '1st Time Insertion' AS 'NEW',
       ' Reinsertion' as 'REVISITS'
UNION ALL

SELECT '12. Implants      |     1 Rod' AS 'Service',
       IF(fp_val.encounter_id IS NULL, 0, SUM(IF(fp_val.encounter_id IS NOT NULL  , 1, 0))) AS 'NEW', -- Sort out this condition
       ' ' as 'REVISITS'

FROM
  (SELECT DISTINCT
     encounter.encounter_id AS encounter_id,
     o.obs_id         AS obs_id,
     o.voided         AS voided,
     o.obs_datetime   AS date_time,
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
   GROUP BY encounter_id
  ) AS fp_val

UNION ALL

SELECT '13. Implants      |     2 Rods' AS 'Service',
       IF(fp_val.encounter_id IS NULL, 0, SUM(IF(fp_val.encounter_id IS NOT NULL  , 1, 0))) AS 'NEW', -- Sort out this condition
       ' ' as 'REVISITS'

FROM
  (SELECT DISTINCT
     encounter.encounter_id AS encounter_id,
     o.obs_id         AS obs_id,
     o.voided         AS voided,
     o.obs_datetime   AS date_time,
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
   GROUP BY encounter_id
  ) AS fp_val

UNION ALL

SELECT '14. I.U.C.D Insertion      |     Hormonal' AS 'Service',
       IF(fp_val.encounter_id IS NULL, 0, SUM(IF(fp_val.encounter_id IS NOT NULL  , 1, 0))) AS 'NEW', -- Sort out this condition
       ' ' as 'REVISITS'

FROM
  (SELECT DISTINCT
     encounter.encounter_id AS encounter_id,
     o.obs_id         AS obs_id,
     o.voided         AS voided,
     o.obs_datetime   AS date_time,
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
                                   AND cv.concept_full_name="FP, Hormonal IUCD"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
   GROUP BY encounter_id
  ) AS fp_val

UNION ALL

SELECT '15. I.U.C.D Insertion      |     Non-Hormonal' AS 'Service',
       IF(fp_val.encounter_id IS NULL, 0, SUM(IF(fp_val.encounter_id IS NOT NULL  , 1, 0))) AS 'NEW', -- Sort out this condition
       ' ' as 'REVISITS'

FROM
  (SELECT DISTINCT
     encounter.encounter_id AS encounter_id,
     o.obs_id         AS obs_id,
     o.voided         AS voided,
     o.obs_datetime   AS date_time,
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
                                   AND cv.concept_full_name="FP, Non Hormonal IUCD"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
   GROUP BY encounter_id
  ) AS fp_val

UNION ALL

SELECT '16. Voluntary surgical contraception      |     BTL' AS 'Service',
       IF(fp_val.encounter_id IS NULL, 0, SUM(IF(fp_val.encounter_id IS NOT NULL  , 1, 0))) AS 'NEW', -- Sort out this condition
       ' ' as 'REVISITS'

FROM
  (SELECT DISTINCT
     encounter.encounter_id AS encounter_id,
     o.obs_id         AS obs_id,
     o.voided         AS voided,
     o.obs_datetime   AS date_time,
     v.date_started   AS visit_date,
     p.patient_id     AS patient_id,
     person.birthdate AS birthdate,
     p.date_created   AS first_visit_date
   FROM encounter
     INNER JOIN visit v ON encounter.visit_id = v.visit_id
     INNER JOIN obs o ON encounter.encounter_id = o.encounter_id
                         AND DATE(o.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
                         AND o.voided = 0
                         AND o.concept_id = (select concept_id from concept_view where concept_full_name="FP, Voluntary Surgical")
     INNER JOIN concept c ON o.value_coded = c.concept_id
     INNER JOIN concept_view cv ON c.concept_id = cv.concept_id
                                   AND cv.concept_full_name="FP, BTL"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
   GROUP BY encounter_id
  ) AS fp_val

UNION ALL

SELECT '17. Voluntary surgical contraception      |     Vasectomy' AS 'Service',
       IF(fp_val.encounter_id IS NULL, 0, SUM(IF(fp_val.encounter_id IS NOT NULL  , 1, 0))) AS 'NEW', -- Sort out this condition
       ' ' as 'REVISITS'

FROM
  (SELECT DISTINCT
     encounter.encounter_id AS encounter_id,
     o.obs_id         AS obs_id,
     o.voided         AS voided,
     o.obs_datetime   AS date_time,
     v.date_started   AS visit_date,
     p.patient_id     AS patient_id,
     person.birthdate AS birthdate,
     p.date_created   AS first_visit_date
   FROM encounter
     INNER JOIN visit v ON encounter.visit_id = v.visit_id
     INNER JOIN obs o ON encounter.encounter_id = o.encounter_id
                         AND DATE(o.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
                         AND o.voided = 0
                         AND o.concept_id = (select concept_id from concept_view where concept_full_name="FP, Voluntary Surgical")
     INNER JOIN concept c ON o.value_coded = c.concept_id
     INNER JOIN concept_view cv ON c.concept_id = cv.concept_id
                                   AND cv.concept_full_name="FP,vasectomy"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
   GROUP BY encounter_id
  ) AS fp_val

UNION ALL

SELECT '' AS 'Service',
       '' AS 'NEW',
       ' ' as 'REVISITS'

UNION ALL

SELECT '' AS 'Service',
       '' AS 'NEW',
       ' ' as 'REVISITS'

UNION ALL

SELECT 'Removals' AS 'Service',
       'Number' AS 'NEW',
       '' as 'REVISITS'
UNION ALL

SELECT '18. I.U.C.D' AS 'Service',
       IF(fp_val.encounter_id IS NULL, 0, SUM(IF(fp_val.encounter_id IS NOT NULL  , 1, 0))) AS 'NEW', -- Sort out this condition
       ' ' as 'REVISITS'

FROM
  (SELECT DISTINCT
     encounter.encounter_id AS encounter_id,
     o.obs_id         AS obs_id,
     o.voided         AS voided,
     o.obs_datetime   AS date_time,
     v.date_started   AS visit_date,
     p.patient_id     AS patient_id,
     person.birthdate AS birthdate,
     p.date_created   AS first_visit_date
   FROM encounter
     INNER JOIN visit v ON encounter.visit_id = v.visit_id
     INNER JOIN obs o ON encounter.encounter_id = o.encounter_id
                         AND DATE(o.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
                         AND o.voided = 0
                         AND o.concept_id = (select concept_id from concept_view where concept_full_name="FP, Removal")
     INNER JOIN concept c ON o.value_coded = c.concept_id
     INNER JOIN concept_view cv ON c.concept_id = cv.concept_id
                                   AND cv.concept_full_name="FP, IUCD"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
   GROUP BY encounter_id
  ) AS fp_val

UNION ALL

SELECT '19. Vasectomy' AS 'Service',
       IF(fp_val.encounter_id IS NULL, 0, SUM(IF(fp_val.encounter_id IS NOT NULL  , 1, 0))) AS 'NEW', -- Sort out this condition
       ' ' as 'REVISITS'

FROM
  (SELECT DISTINCT
     encounter.encounter_id AS encounter_id,
     o.obs_id         AS obs_id,
     o.voided         AS voided,
     o.obs_datetime   AS date_time,
     v.date_started   AS visit_date,
     p.patient_id     AS patient_id,
     person.birthdate AS birthdate,
     p.date_created   AS first_visit_date
   FROM encounter
     INNER JOIN visit v ON encounter.visit_id = v.visit_id
     INNER JOIN obs o ON encounter.encounter_id = o.encounter_id
                         AND DATE(o.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
                         AND o.voided = 0
                         AND o.concept_id = (select concept_id from concept_view where concept_full_name="FP, Removal")
     INNER JOIN concept c ON o.value_coded = c.concept_id
     INNER JOIN concept_view cv ON c.concept_id = cv.concept_id
                                   AND cv.concept_full_name="FP,vasectomy"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
   GROUP BY encounter_id
  ) AS fp_val

UNION ALL

SELECT '' AS 'Service',
       '' AS 'NEW',
       ' ' as 'REVISITS'

UNION ALL

SELECT '' AS 'Service',
       '' AS 'NEW',
       ' ' as 'REVISITS'

UNION ALL

SELECT 'Number of clients receiving all FP Services (Issued with commodities plus other FP services)' AS 'Service',
       'New' AS 'NEW',
       'Revisits' as 'REVISITS'
UNION ALL

SELECT '20. Adolescent clients (10-14 Years) receiving FP Services' AS 'Service',
       IF(fp_val.encounter_id IS NULL, 0, SUM(IF(fp_val.encounter_id IS NOT NULL  , 1, 0))) AS 'NEW', -- Sort out this condition
       ' ' as 'REVISITS'

FROM
  (SELECT DISTINCT
     encounter.encounter_id AS encounter_id,
     o.obs_id         AS obs_id,
     o.voided         AS voided,
     o.obs_datetime   AS date_time,
     v.date_started   AS visit_date,
     p.patient_id     AS patient_id,
     person.birthdate AS birthdate,
     p.date_created   AS first_visit_date
   FROM encounter
     INNER JOIN visit v ON encounter.visit_id = v.visit_id
     INNER JOIN obs o ON encounter.encounter_id = o.encounter_id
                         AND DATE(o.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
                         AND o.voided = 0
     INNER JOIN concept c ON o.concept_id = c.concept_id
     INNER JOIN concept_view cv ON c.concept_id = cv.concept_id
                                   AND cv.concept_full_name="Family Planning First Visit Card"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
            AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 10 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 14 YEAR), INTERVAL 0 DAY))
   GROUP BY encounter_id
  ) AS fp_val

UNION ALL

SELECT '21. Adolescent clients (15-19 Years) receiving FP Services' AS 'Service',
       IF(fp_val.encounter_id IS NULL, 0, SUM(IF(fp_val.encounter_id IS NOT NULL  , 1, 0))) AS 'NEW', -- Sort out this condition
       ' ' as 'REVISITS'

FROM
  (SELECT DISTINCT
     encounter.encounter_id AS encounter_id,
     o.obs_id         AS obs_id,
     o.voided         AS voided,
     o.obs_datetime   AS date_time,
     v.date_started   AS visit_date,
     p.patient_id     AS patient_id,
     person.birthdate AS birthdate,
     p.date_created   AS first_visit_date
   FROM encounter
     INNER JOIN visit v ON encounter.visit_id = v.visit_id
     INNER JOIN obs o ON encounter.encounter_id = o.encounter_id
                         AND DATE(o.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
                         AND o.voided = 0
     INNER JOIN concept c ON o.concept_id = c.concept_id
     INNER JOIN concept_view cv ON c.concept_id = cv.concept_id
                                   AND cv.concept_full_name="Family Planning First Visit Card"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
                          AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 15 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 19 YEAR), INTERVAL 0 DAY))
   GROUP BY encounter_id
  ) AS fp_val

UNION ALL

SELECT '22. Youth clients (20-24 Years) receiving FP Services' AS 'Service',
       IF(fp_val.encounter_id IS NULL, 0, SUM(IF(fp_val.encounter_id IS NOT NULL  , 1, 0))) AS 'NEW', -- Sort out this condition
       ' ' as 'REVISITS'

FROM
  (SELECT DISTINCT
     encounter.encounter_id AS encounter_id,
     o.obs_id         AS obs_id,
     o.voided         AS voided,
     o.obs_datetime   AS date_time,
     v.date_started   AS visit_date,
     p.patient_id     AS patient_id,
     person.birthdate AS birthdate,
     p.date_created   AS first_visit_date
   FROM encounter
     INNER JOIN visit v ON encounter.visit_id = v.visit_id
     INNER JOIN obs o ON encounter.encounter_id = o.encounter_id
                         AND DATE(o.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
                         AND o.voided = 0
     INNER JOIN concept c ON o.concept_id = c.concept_id
     INNER JOIN concept_view cv ON c.concept_id = cv.concept_id
                                   AND cv.concept_full_name="Family Planning First Visit Card"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
                          AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 20 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 24 YEAR), INTERVAL 0 DAY))
   GROUP BY encounter_id
  ) AS fp_val

UNION ALL

SELECT '23. Adults (25+ Years) receiving FP Services' AS 'Service',
       IF(fp_val.encounter_id IS NULL, 0, SUM(IF(fp_val.encounter_id IS NOT NULL  , 1, 0))) AS 'NEW', -- Sort out this condition
       ' ' as 'REVISITS'

FROM
  (SELECT DISTINCT
     encounter.encounter_id AS encounter_id,
     o.obs_id         AS obs_id,
     o.voided         AS voided,
     o.obs_datetime   AS date_time,
     v.date_started   AS visit_date,
     p.patient_id     AS patient_id,
     person.birthdate AS birthdate,
     p.date_created   AS first_visit_date
   FROM encounter
     INNER JOIN visit v ON encounter.visit_id = v.visit_id
     INNER JOIN obs o ON encounter.encounter_id = o.encounter_id
                         AND DATE(o.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
                         AND o.voided = 0
     INNER JOIN concept c ON o.concept_id = c.concept_id
     INNER JOIN concept_view cv ON c.concept_id = cv.concept_id
                                   AND cv.concept_full_name="Family Planning First Visit Card"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
                          AND DATE(o.obs_datetime) BETWEEN (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 25 YEAR), INTERVAL 0 DAY)) AND (DATE_ADD(DATE_ADD(person.birthdate, INTERVAL 200 YEAR), INTERVAL 0 DAY))
   GROUP BY encounter_id
  ) AS fp_val

UNION ALL

SELECT '24. Number of clients receiving immediate post partum FP Method      |     within 48 Hours' AS 'Service',
       IF(fp_val.encounter_id IS NULL, 0, SUM(IF(fp_val.encounter_id IS NOT NULL  , 1, 0))) AS 'NEW', -- Sort out this condition
       ' ' as 'REVISITS'

FROM
  (SELECT DISTINCT
     encounter.encounter_id AS encounter_id,
     o.obs_id         AS obs_id,
     o.voided         AS voided,
     o.obs_datetime   AS date_time,
     v.date_started   AS visit_date,
     p.patient_id     AS patient_id,
     person.birthdate AS birthdate,
     p.date_created   AS first_visit_date
   FROM encounter
     INNER JOIN visit v ON encounter.visit_id = v.visit_id
     INNER JOIN obs o ON encounter.encounter_id = o.encounter_id
                         AND DATE(o.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
                         AND o.voided = 0
                         AND o.concept_id = (select concept_id from concept_view where concept_full_name="FP, Post Partum FP")
     INNER JOIN concept c ON o.value_coded = c.concept_id
     INNER JOIN concept_view cv ON c.concept_id = cv.concept_id
                                   AND cv.concept_full_name="FP, 48 Hours"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
   GROUP BY encounter_id
  ) AS fp_val

UNION ALL

SELECT '25. Number of clients receiving immediate post partum FP Method      |     4-6 weeks' AS 'Service',
       IF(fp_val.encounter_id IS NULL, 0, SUM(IF(fp_val.encounter_id IS NOT NULL  , 1, 0))) AS 'NEW', -- Sort out this condition
       ' ' as 'REVISITS'

FROM
  (SELECT DISTINCT
     encounter.encounter_id AS encounter_id,
     o.obs_id         AS obs_id,
     o.voided         AS voided,
     o.obs_datetime   AS date_time,
     v.date_started   AS visit_date,
     p.patient_id     AS patient_id,
     person.birthdate AS birthdate,
     p.date_created   AS first_visit_date
   FROM encounter
     INNER JOIN visit v ON encounter.visit_id = v.visit_id
     INNER JOIN obs o ON encounter.encounter_id = o.encounter_id
                         AND DATE(o.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
                         AND o.voided = 0
                         AND o.concept_id = (select concept_id from concept_view where concept_full_name="FP, Post Partum FP")
     INNER JOIN concept c ON o.value_coded = c.concept_id
     INNER JOIN concept_view cv ON c.concept_id = cv.concept_id
                                   AND cv.concept_full_name="FP, 48 Hours"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
   GROUP BY encounter_id
  ) AS fp_val

UNION ALL

SELECT '26. Number of clients receiving post abortion FP method' AS 'Service',
       IF(fp_val.encounter_id IS NULL, 0, SUM(IF(fp_val.encounter_id IS NOT NULL  , 1, 0))) AS 'NEW', -- Sort out this condition
       ' ' as 'REVISITS'

FROM
  (SELECT DISTINCT
     encounter.encounter_id AS encounter_id,
     o.obs_id         AS obs_id,
     o.voided         AS voided,
     o.obs_datetime   AS date_time,
     v.date_started   AS visit_date,
     p.patient_id     AS patient_id,
     person.birthdate AS birthdate,
     p.date_created   AS first_visit_date
   FROM encounter
     INNER JOIN visit v ON encounter.visit_id = v.visit_id
     INNER JOIN obs o ON encounter.encounter_id = o.encounter_id
                         AND DATE(o.obs_datetime) BETWEEN CAST('#startDate#' AS DATE) AND CAST('#endDate#' AS DATE)
                         AND o.voided = 0
                         AND o.concept_id = (select concept_id from concept_view where concept_full_name="FP, Post Abortion FP")
     INNER JOIN concept c ON o.value_coded = c.concept_id
     INNER JOIN concept_view cv ON c.concept_id = cv.concept_id
                                   AND cv.concept_full_name="True"
     INNER JOIN patient p ON encounter.patient_id = p.patient_id
     INNER JOIN person ON p.patient_id = person.person_id
   GROUP BY encounter_id
  ) AS fp_val

