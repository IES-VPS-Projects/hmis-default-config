'''with w as (select test.Name,COUNT(*) as "Number Positive"
from  clinlims.analysis
left join clinlims.test on analysis.test_id=test.id
where test.name in ('Glucose(F)','Urine Ketone','Urine Protein','Pus Cells','Urine haemoglobin','Vaginal Trichomonas','Yeast Cell')
group  by test.name)
select '1.1 Urine Chemistry' as "Urine Analysis",null as "Number Positive"
union all
select "name","Number Positive" from w
where "name" in ('Glucose(F)','Urine Ketone','Urine Protein')
union all
select 'Total Exam',sum("Number Positive") as "Number of Positive" from w
where "name" in ('Glucose(F)','Urine Ketone','Urine Protein')
union all
select '1.5 Urine Microscopy',NULL
union all
select "name","Number Positive" from w
where "name" in ('Pus Cells','Urine haemoglobin','Vaginal Trichomonas','Yeast Cell')
union all
select 'Total Exam',sum("Number Positive") as "Number of Positive" from w
where "name" in ('Pus Cells','Urine haemoglobin','Vaginal Trichomonas','Yeast Cell');'''

select test.description as "Specimen referral",COUNT(*) as "No. of Specimen" ,COALESCE(count(referral.sent_date),0) AS "No. of results received"
from clinlims.referral
inner join clinlims.analysis on referral.analysis_id=analysis.id
inner join clinlims.test on analysis.test_id=test.id
where test.description in('EID','Viral Load','TB Culture','CD4','Virological','Blood samples for transfusion Screening')
group by test.description;
