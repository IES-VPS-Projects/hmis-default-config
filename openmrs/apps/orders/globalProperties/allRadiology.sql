-- orders PENDING
        SELECT DISTINCT
          concat(pn.given_name,' ', ifnull(pn.family_name,'')) as name,
          pi.identifier as identifier,
          concat("",p.uuid) as uuid,
          concat("",v.uuid) as activeVisitUuid
        from orders ord
        join encounter e on e.encounter_id=ord.encounter_id
        join visit v on v.visit_id=e.visit_id and v.date_stopped is null
        join person_name pn on v.patient_id = pn.person_id and pn.voided = 0
        join patient_identifier pi on v.patient_id = pi.patient_id
        join patient_identifier_type pit on pi.identifier_type = pit.patient_identifier_type_id
        join global_property gp on gp.property="bahmni.primaryIdentifierType" and gp.property_value=pit.uuid
        join person p on p.person_id = v.patient_id
        join location l on l.uuid = ${visit_location_uuid} and  v.location_id = l.location_id
        left outer join visit_attribute va on va.visit_id = v.visit_id and va.attribute_type_id = (
          select visit_attribute_type_id from visit_attribute_type where name="Admission Status"
        ) and va.voided = 0
        where v.date_stopped is null AND v.voided = 0 AND ord.order_type_id = 4 -- add check if they are not yet served
        AND ord.patient_id NOT IN 
        (
        select obs.person_id FROM openmrs.obs obs where obs.concept_id=35 and obs.voided=0 and date(obs.date_created)=date(ord.date_created) 
        and 
        (SELECT count(ord.order_id) FROM openmrs.obs obs where obs.concept_id=35 and obs.voided=0 and obs.person_id = ord.patient_id and date(obs.date_created)=date(ord.date_created)) 
		=
        (SELECT count(orders.order_id) FROM openmrs.orders WHERE patient_id = ord.patient_id and orders.voided=0 and date(orders.date_activated) = date(ord.date_created))
        )
		order by ord.date_created