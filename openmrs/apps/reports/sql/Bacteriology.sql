with S as (select test.Name as Test,result.value  as result
from  clinlims.analysis
join clinlims.test on analysis.test_id=test.id
join clinlims.result on analysis.id = result.analysis_id)
select Test,sum((test = 'Blood Sugar Random' )::integer) As "Total" ,
(select sum((test = 'Blood Sugar Random' )::integer) as low from s where  CASE WHEN result ~ '^\d+$'  -- only digits  
THEN result::int <= 14 END and test= 'Blood Sugar Random' group by test),
(select sum((test = 'Blood Sugar Random' )::integer) as HIGH from s where  CASE WHEN result ~ '^\d+$'  -- only digits  
THEN result::int >= 14 END and test= 'Blood Sugar Random' group by test)
from s where test= 'Blood Sugar Random'  group by test
union all
select Test,sum((test = 'OGTT' )::integer) As "Total" ,
(select sum((test = 'OGTT' )::integer) as low from s where  CASE WHEN result ~ '^\d+$'  -- only digits  
THEN result::int <= 14 END and test= 'OGTT' group by test),
(select sum((test = 'OGTT' )::integer) as HIGH from s where  CASE WHEN result ~ '^\d+$'  -- only digits  
THEN result::int >= 14 END and test= 'OGTT' group by test)
FROM S where test = 'OGTT' group by test
union all
Select 'Renal Function Test',
(select count(*) from s where test in ('Creatinine','Urea','Sodium','Potassium','Chloride')) as total,null,null
union all
select '2.4 Creatinine',null,
(select sum((test = 'Creatinine' )::integer) as low from s where  CASE WHEN result ~ '^\d+$'  -- only digits  
THEN result::int <= 14 END and test= 'Creatinine' group by test),
(select sum((test = 'Creatinine' )::integer) as HIGH from s where  CASE WHEN result ~ '^\d+$'  -- only digits  
THEN result::int >= 14 END and test= 'Creatinine' group by test)
from s where test= 'Creatinine'  group by test
union all
select '2.5 Urea',null,
(select sum((test = 'Urea' )::integer) as low from s where  CASE WHEN result ~ '^\d+$'  -- only digits  
THEN result::int <= 14 END and test= 'Urea' group by test),
(select sum((test = 'Urea' )::integer) as HIGH from s where  CASE WHEN result ~ '^\d+$'  -- only digits  
THEN result::int >= 14 END and test= 'Urea' group by test)
from s where test= 'Urea'  group by test
UNION ALL
select '2.6 Sodium',null,
(select sum((test = 'Sodium' )::integer) as low from s where  CASE WHEN result ~ '^\d+$'  -- only digits  
THEN result::int <= 14 END and test= 'Sodium' group by test),
(select sum((test = 'Sodium' )::integer) as HIGH from s where  CASE WHEN result ~ '^\d+$'  -- only digits  
THEN result::int >= 14 END and test= 'Sodium' group by test)
from s where test= 'Sodium'  group by test
union all
select '2.7 Potassium',null,
(select sum((test = 'Potassium' )::integer) as low from s where  CASE WHEN result ~ '^\d+$'  -- only digits  
THEN result::int <= 14 END and test= 'Potassium' group by test),
(select sum((test = 'Potassium' )::integer) as HIGH from s where  CASE WHEN result ~ '^\d+$'  -- only digits  
THEN result::int >= 14 END and test= 'Potassium' group by test)
from s where test= 'Potassium'  group by test
union all
select '2.5 Chloride',null,
(select sum((test = 'Chloride' )::integer) as low from s where  CASE WHEN result ~ '^\d+$'  -- only digits  
THEN result::int <= 14 END and test= 'Chloride' group by test),
(select sum((test = 'Chloride' )::integer) as HIGH from s where  CASE WHEN result ~ '^\d+$'  -- only digits  
THEN result::int >= 14 END and test= 'Chloride' group by test)
from s where test= 'Chloride'  group by test
union all
select '2.9 Liver Function Test',
(select count(*) from s where test in ('Direct Bilirubin','Total Bilirubin','SGOT/AST','SGPT/ALT','Protein (Serum)','Albumin','Alkaline Phosphate')) as total,null,null
union all
select '2.10 Direct Bilirubin',null,
(select sum((test = 'Direct Bilirubin' )::integer) as low from s where  CASE WHEN result ~ '^\d+$'  -- only digits  
THEN result::int <= 14 END and test= 'Direct Bilirubin' group by test),
(select sum((test = 'Direct Bilirubin' )::integer) as HIGH from s where  CASE WHEN result ~ '^\d+$'  -- only digits  
THEN result::int >= 14 END and test= 'Direct Bilirubin' group by test)
from s where test= 'Direct Bilirubin'  group by test
union all
select '2.11 Total Bilirubin',null,
(select sum((test = 'Total Bilirubin' )::integer) as low from s where  CASE WHEN result ~ '^\d+$'  -- only digits  
THEN result::int <= 14 END and test= 'Total Bilirubin' group by test),
(select sum((test = 'Total Bilirubin' )::integer) as HIGH from s where  CASE WHEN result ~ '^\d+$'  -- only digits  
THEN result::int >= 14 END and test= 'Total Bilirubin' group by test)
from s where test= 'Total Bilirubin'  group by test
union all
select '2.12 SGOT/AST ',null,
(select sum((test = 'SGOT/AST' )::integer) as low from s where  CASE WHEN result ~ '^\d+$'  -- only digits  
THEN result::int <= 14 END and test= 'SGOT/AST ' group by test),
(select sum((test = 'SGOT/AST' )::integer) as HIGH from s where  CASE WHEN result ~ '^\d+$'  -- only digits  
THEN result::int >= 14 END and test= 'SGOT/AST' group by test)
from s where test= 'SGOT/AST'  group by test
union all
select '2.13 SGPT/ALT ',null,
(select sum((test = 'SGPT/ALT' )::integer) as low from s where  CASE WHEN result ~ '^\d+$'  -- only digits  
THEN result::int <= 14 END and test= 'SGPT/ALT ' group by test),
(select sum((test = 'SGPT/ALT' )::integer) as HIGH from s where  CASE WHEN result ~ '^\d+$'  -- only digits  
THEN result::int >= 14 END and test= 'SGPT/ALT' group by test)
from s where test= 'SGPT/ALT'  group by test
union all
select '2.14 Protein (Serum) ',null,
(select sum((test = 'Protein (Serum)' )::integer) as low from s where  CASE WHEN result ~ '^\d+$'  -- only digits  
THEN result::int <= 14 END and test= 'Protein (Serum) ' group by test),
(select sum((test = 'Protein (Serum)' )::integer) as HIGH from s where  CASE WHEN result ~ '^\d+$'  -- only digits  
THEN result::int >= 14 END and test= 'Protein (Serum)' group by test)
from s where test= 'Protein (Serum)'  group by test
union all
select '2.15 Albumin (Serum) ',null,
(select sum((test = 'Albumin (Serum)' )::integer) as low from s where  CASE WHEN result ~ '^\d+$'  -- only digits  
THEN result::int <= 14 END and test= 'Albumin (Serum) ' group by test),
(select sum((test = 'Albumin (Serum)' )::integer) as HIGH from s where  CASE WHEN result ~ '^\d+$'  -- only digits  
THEN result::int >= 14 END and test= 'Albumin (Serum)' group by test)
from s where test= 'Albumin (Serum)'  group by test
union all
select '2.16 Alkaline Phosphate ',null,
(select sum((test = 'Alkaline Phosphate' )::integer) as low from s where  CASE WHEN result ~ '^\d+$'  -- only digits  
THEN result::int <= 14 END and test= 'Alkaline Phosphate ' group by test),
(select sum((test = 'Alkaline Phosphate' )::integer) as HIGH from s where  CASE WHEN result ~ '^\d+$'  -- only digits  
THEN result::int >= 14 END and test= 'Alkaline Phosphate' group by test)
from s where test= 'Alkaline Phosphate'  group by test
union all
Select '2.17 Lipid Profile',
(select count(*) from s where test in ('Total Cholestrol','S. Triglyceride','LDL')) as total,null,null
union all
select '2.18 Total Cholesterol ',null,
(select sum((test = 'Total Cholesterol' )::integer) as low from s where  CASE WHEN result ~ '^\d+$'  -- only digits  
THEN result::int <= 14 END and test= 'Total Cholesterol ' group by test),
(select sum((test = 'Total Cholesterol' )::integer) as HIGH from s where  CASE WHEN result ~ '^\d+$'  -- only digits  
THEN result::int >= 14 END and test= 'Total Cholesterol' group by test)
from s where test= 'Total Cholesterol'  group by test
union all
select '2.19 Triglyceride ',null,
(select sum((test = 'Triglyceride' )::integer) as low from s where  CASE WHEN result ~ '^\d+$'  -- only digits  
THEN result::int <= 14 END and test= 'Triglyceride ' group by test),
(select sum((test = 'Triglyceride' )::integer) as HIGH from s where  CASE WHEN result ~ '^\d+$'  -- only digits  
THEN result::int >= 14 END and test= 'Triglyceride' group by test)
from s where test= 'Triglyceride'  group by test
union all
select '2.20 LDL ',null,
(select sum((test = 'LDL' )::integer) as low from s where  CASE WHEN result ~ '^\d+$'  -- only digits  
THEN result::int <= 14 END and test= 'LDL ' group by test),
(select sum((test = 'LDL' )::integer) as HIGH from s where  CASE WHEN result ~ '^\d+$'  -- only digits  
THEN result::int >= 14 END and test= 'LDL' group by test)
from s where test= 'LDL'  group by test
union all
Select '2.21 Hormonal Test',
(select count(*) from s where test in ('T3','T4','TSH','PSA')) as total,null,null
union all
select '2.22 T3 ',null,
(select sum((test = 'T3' )::integer) as low from s where  CASE WHEN result ~ '^\d+$'  -- only digits  
THEN result::int <= 14 END and test= 'T3 ' group by test),
(select sum((test = 'T3' )::integer) as HIGH from s where  CASE WHEN result ~ '^\d+$'  -- only digits  
THEN result::int >= 14 END and test= 'T3' group by test)
from s where test= 'T3'  group by test
union all
select '2.23 T4 ',null,
(select sum((test = 'T4' )::integer) as low from s where  CASE WHEN result ~ '^\d+$'  -- only digits  
THEN result::int <= 14 END and test= 'T4 ' group by test),
(select sum((test = 'T4' )::integer) as HIGH from s where  CASE WHEN result ~ '^\d+$'  -- only digits  
THEN result::int >= 14 END and test= 'T4' group by test)
from s where test= 'T4'  group by test
union all
select '2.24 TSH ',null,
(select sum((test = 'TSH' )::integer) as low from s where  CASE WHEN result ~ '^\d+$'  -- only digits  
THEN result::int <= 14 END and test= 'TSH ' group by test),
(select sum((test = 'TSH' )::integer) as HIGH from s where  CASE WHEN result ~ '^\d+$'  -- only digits  
THEN result::int >= 14 END and test= 'TSH' group by test)
from s where test= 'TSH'  group by test
union all
select '2.25 PSA ',null,
(select sum((test = 'PSA' )::integer) as low from s where  CASE WHEN result ~ '^\d+$'  -- only digits  
THEN result::int <= 14 END and test= 'PSA ' group by test),
(select sum((test = 'PSA' )::integer) as HIGH from s where  CASE WHEN result ~ '^\d+$'  -- only digits  
THEN result::int >= 14 END and test= 'PSA' group by test)
from s where test= 'PSA'  group by test
union all
Select '2.26 Tumor Markers',
(select count(*) from s where test in ('CEA','C15 3')) as total,null,null
union all
select '2.27 CEA ',null,
(select sum((test = 'CEA' )::integer) as low from s where  CASE WHEN result ~ '^\d+$'  -- only digits  
THEN result::int <= 14 END and test= 'CEA ' group by test),
(select sum((test = 'CEA' )::integer) as HIGH from s where  CASE WHEN result ~ '^\d+$'  -- only digits  
THEN result::int >= 14 END and test= 'CEA' group by test)
from s where test= 'CEA'  group by test
union all
Select '2.28 Tumor Markers',
(select count(*) from s where test in ('Protein (CSF)','Glucose')) as total,null,null
union all
select '2.29 Protein (CSF) ',null,
(select sum((test = 'Protein (CSF)' )::integer) as low from s where  CASE WHEN result ~ '^\d+$'  -- only digits  
THEN result::int <= 14 END and test= 'Protein (CSF) ' group by test),
(select sum((test = 'Protein (CSF)' )::integer) as HIGH from s where  CASE WHEN result ~ '^\d+$'  -- only digits  
THEN result::int >= 14 END and test= 'Protein (CSF)' group by test)
from s where test= 'Protein (CSF)'  group by test
union all
select '2.30 Glucose (CSF) (CSF) ',null,
(select sum((test = 'Glucose (CSF)' )::integer) as low from s where  CASE WHEN result ~ '^\d+$'  -- only digits  
THEN result::int <= 14 END and test= 'Glucose (CSF) ' group by test),
(select sum((test = 'Glucose (CSF)' )::integer) as HIGH from s where  CASE WHEN result ~ '^\d+$'  -- only digits  
THEN result::int >= 14 END and test= 'Glucose (CSF)' group by test)
from s where test= 'Glucose (CSF)'  group by test
