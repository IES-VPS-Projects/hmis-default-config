select test.description as "Specimen referral",COUNT(*) as "No. of Specimen" ,COALESCE(count(referral.sent_date),0) AS "No. of results received"
from clinlims.referral 
inner join clinlims.analysis on referral.analysis_id=analysis.id
inner join clinlims.test on analysis.test_id=test.id
where test.description in('EID','Viral Load','TB Culture','CD4','Virological','Blood samples for transfusion Screening') 
group by test.description;
