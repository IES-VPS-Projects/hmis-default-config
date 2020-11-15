SELECT
  'a' AS 'Serial Number',
  'b' AS 'Outpatient Number',
  'c' AS 'Arrival Date',
  'd' AS 'Calculated Hours',
  'e'  AS 'Names',
  'f' AS 'Survivor/Perpetrator (S/P)',
  'g' AS 'Type of Case (N/R)',
  'e' AS 'Sublocation/LandMark',
  'f' AS 'Telephone Number (Client/Gurdian)'

UNION ALL

SELECT
  '' AS 'Serial Number',
  pi.identifier AS 'Outpatient Number',
  DATE(pt.date_created) AS 'Arrival Date',
  '' AS 'Calculated Hours',
  CONCAT(COALESCE(pn.given_name,''),' ',COALESCE(pn.middle_name,''),' ',COALESCE(pn.family_name,''))  AS 'Names',
  '' AS 'Survivor/Perpetrator (S/P)',
  '' AS 'Type of Case (N/R)',
  '' AS 'Sublocation/LandMark',
  mobile.mobile_number AS 'Telephone Number (Client/Gurdian)'

FROM patient pt
INNER JOIN person p ON pt.patient_id = p.person_id
INNER JOIN person_name pn ON p.person_id = pn.person_id
INNER JOIN patient_identifier pi ON pt.patient_id = pi.patient_id
      AND pi.identifier_type = (select identifier_type from patient_identifier_type WHERE name='Patient Identifier')
      AND pi.preferred = 1
LEFT JOIN (
    SELECT
      pn.person_id,
      IF(pa.value IS NOT NULL , pa.value, IF(pa3.value IS NOT NULL , pa3.value, '')) AS 'mobile_number'
    FROM person pn
    LEFT JOIN person_attribute pa ON pn.person_id = pa.person_id
          AND pa.person_attribute_type_id = (select person_attribute_type_id FROM person_attribute_type where name="mobileNo")
    LEFT JOIN person_attribute pa2 ON pn.person_id = pa2.person_id
          AND pa2.person_attribute_type_id = (select person_attribute_type_id FROM person_attribute_type where name="relationshiptype")
          AND pa2.value = (select concept_id from concept_view where concept_full_name="Guardian")
    LEFT JOIN person_attribute pa3 ON pa2.person_id = pa3.person_id
          AND pa3.person_attribute_type_id = (select person_attribute_type_id FROM person_attribute_type where name="nextOfKinPhoneNumber")
          AND pa2.value IS NOT NULL
)mobile ON mobile.person_id = pt.patient_id

