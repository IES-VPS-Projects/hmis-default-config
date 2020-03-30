-- All active atients with vitals taken
		select distinct
          concat(pn.given_name,' ', ifnull(pn.family_name,'')) as name,
          pi.identifier as identifier,
          concat("",p.uuid) as uuid,
          concat("",v.uuid) as activeVisitUuid,
          cast(v.date_started as time) as startTime ,
          IF(va.value_reference = "Admitted", "true", "false") as hasBeenAdmitted
        from visit v
        left outer join obs ob on ob.person_id=v.patient_id and ob.voided = 0
        join person_name pn on v.patient_id = pn.person_id and pn.voided = 0
        join patient_identifier pi on v.patient_id = pi.patient_id
        join patient_identifier_type pit on pi.identifier_type = pit.patient_identifier_type_id
        join global_property gp on gp.property="bahmni.primaryIdentifierType" and gp.property_value=pit.uuid
        join person p on p.person_id = v.patient_id
        join location l on  v.location_id = l.location_id
        left outer join visit_attribute va on va.visit_id = v.visit_id and va.attribute_type_id = (
          select visit_attribute_type_id from visit_attribute_type where name="Admission Status"
        ) and va.voided = 0
        where v.date_stopped is null AND v.voided = 0 AND ob.concept_id in (122)