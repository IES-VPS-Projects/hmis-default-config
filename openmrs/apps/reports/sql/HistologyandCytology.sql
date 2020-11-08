with S as (select test.Name as Test,result.value  as result,analysis.started_date :: timestamp :: date
from  clinlims.analysis
join clinlims.test on analysis.test_id=test.id
join clinlims.result on analysis.id = result.analysis_id)
select 'Smears' as "Test",null as "Total Exam",null as "Malignant"
union all
select '6.1 PAP Smear',sum((test = 'PAP Smear' )::integer) As "Total Exam",
(Select Sum((test = 'PAP Smear' and result = 'Positive' )::integer ) from S  
where test = 'PAP Smear'  group by test)
from S  where test = 'PAP Smear'  and started_date between '#startDate#' and '#endDate#' group by test
union all
select '6.2 Touch preparations',sum((test = 'Touch preparations' )::integer) As "Total Exam",
(Select Sum((test = 'Touch preparations' and result = 'Positive' )::integer ) from S  
where test = 'Touch preparations'  group by test)
from S  where test = 'Touch preparations'  and started_date between '#startDate#' and '#endDate#' group by test
union all
select '6.3 Tissue Impressions',sum((test = 'Tissue Impressions' )::integer) As "Total Exam",
(Select Sum((test = 'Tissue Impressions' and result = 'Positive' )::integer ) from S  
where test = 'Tissue Impressions'  group by test)
from S  where test = 'Tissue Impressions'  and started_date between '#startDate#' and '#endDate#'  group by test
union all
select 'Fine Needle Aspirates' as "Test",null as "Total Exam",null as "Malignant"
union all
select '6.4 Thyroid',sum((test = 'Thyroid' )::integer) As "Total Exam",
(Select Sum((test = 'Thyroid' and result = 'Positive' )::integer ) from S  
where test = 'Thyroid'  group by test)
from S  where test = 'Thyroid'  and started_date between '#startDate#' and '#endDate#' group by test
union all
select '6.5 Lymphs nodes',sum((test = 'Lymphs nodes' )::integer) As "Total Exam",
(Select Sum((test = 'Lymphs nodes' and result = 'Positive' )::integer ) from S  
where test = 'Lymphs nodes'  group by test)
from S  where test = 'Lymphs nodes'  and started_date between '#startDate#' and '#endDate#'  group by test
union all
select '6.6 Liver',sum((test = 'Liver' )::integer) As "Total Exam",
(Select Sum((test = 'Liver' and result = 'Positive' )::integer ) from S  
where test = 'Liver'  group by test)
from S  where test = 'Liver'  and started_date between '#startDate#' and '#endDate#' group by test
union all
select '6.7 Breast',sum((test = 'Breast' )::integer) As "Total Exam",
(Select Sum((test = 'Breast' and result = 'Positive' )::integer ) from S  
where test = 'Breast'  group by test)
from S  where test = 'Breast'  and started_date between '#startDate#' and '#endDate#' group by test
union all
select '6.8 Soft tissue Masses',sum((test = 'Soft tissue Masses' )::integer) As "Total Exam",
(Select Sum((test = 'Soft tissue Masses' and result = 'Positive' )::integer ) from S  
where test = 'Soft tissue Masses'  group by test)
from S  where test = 'Soft tissue Masses' and started_date between '#startDate#' and '#endDate#' group by test
union all
select 'Fluid Cytology' as "Test",null as "Total Exam",null as "Malignant"
union all
select '6.9 Ascitic Fluid',sum((test = 'Ascitic Fluid' )::integer) As "Total Exam",
(Select Sum((test = 'Ascitic Fluid' and result = 'Positive' )::integer ) from S  
where test = 'Ascitic Fluid'  group by test)
from S  where test = 'Ascitic Fluid'  and started_date between '#startDate#' and '#endDate#' group by test
union all
select '6.10 CSF,',sum((test = 'CSF,' )::integer) As "Total Exam",
(Select Sum((test = 'CSF,' and result = 'Positive' )::integer ) from S  
where test = 'CSF,'  group by test)
from S  where test = 'CSF,' and started_date between '#startDate#' and '#endDate#' group by test
union all
select '6.11 Pleural Fluid,',sum((test = 'Pleural Fluid,' )::integer) As "Total Exam",
(Select Sum((test = 'Pleural Fluid,' and result = 'Positive' )::integer ) from S  
where test = 'Pleural Fluid,'  group by test)
from S  where test = 'Pleural Fluid,' and started_date between '#startDate#' and '#endDate#' group by test
union all
select '6.12 Urine,',sum((test = 'Urine,' )::integer) As "Total Exam",
(Select Sum((test = 'Urine,' and result = 'Positive' )::integer ) from S  
where test = 'Urine,'  group by test)
from S  where test = 'Urine,' and started_date between '#startDate#' and '#endDate#' group by test
union all
select 'Fluid Cytology' as "Test",null as "Total Exam",null as "Malignant"
union all
select '6.13 Cervix',sum((test = 'Cervix' )::integer) As "Total Exam",
(Select Sum((test = 'Cervix' and result = 'Positive' )::integer ) from S  
where test = 'Cervix'  group by test)
from S  where test = 'Cervix' and started_date between '#startDate#' and '#endDate#' group by test
union all
select '6.14 Prostrate,',sum((test = 'Prostrate,' )::integer) As "Total Exam",
(Select Sum((test = 'Prostrate,' and result = 'Positive' )::integer ) from S  
where test = 'Prostrate,'  group by test)
from S  where test = 'Prostrate,' and started_date between '#startDate#' and '#endDate#' group by test
union all
select '6.15 Breast Tissue',sum((test = 'Breast Tissue' )::integer) As "Total Exam",
(Select Sum((test = 'Breast Tissue' and result = 'Positive' )::integer ) from S  
where test = 'Breast Tissue'  group by test)
from S  where test = 'Breast Tissue' and started_date between '#startDate#' and '#endDate#' group by test
union all
select '6.16 Ovary',sum((test = 'Ovary' )::integer) As "Total Exam",
(Select Sum((test = 'Ovary' and result = 'Positive' )::integer ) from S  
where test = 'Ovary'  group by test)
from S  where test = 'Ovary' and started_date between '#startDate#' and '#endDate#' group by test
union all
select '6.17 Uterus',sum((test = 'Uterus' )::integer) As "Total Exam",
(Select Sum((test = 'Uterus' and result = 'Positive' )::integer ) from S  
where test = 'Uterus'  group by test)
from S  where test = 'Uterus' and started_date between '#startDate#' and '#endDate#' group by test
union all
select '6.18 Skin',sum((test = 'Skin' )::integer) As "Total Exam",
(Select Sum((test = 'Skin' and result = 'Positive' )::integer ) from S  
where test = 'Skin'  group by test)
from S  where test = 'Skin' and started_date between '#startDate#' and '#endDate#' group by test
union all
select '6.19 Head and Neck',sum((test = 'Head and Neck' )::integer) As "Total Exam",
(Select Sum((test = 'Head and Neck' and result = 'Positive' )::integer ) from S  
where test = 'Head and Neck'  group by test)
from S  where test = 'Head and Neck' and started_date between '#startDate#' and '#endDate#' group by test
union all
select '6.20 Dental',sum((test = 'Dental' )::integer) As "Total Exam",
(Select Sum((test = 'Dental' and result = 'Positive' )::integer ) from S  
where test = 'Dental'  group by test)
from S  where test = 'Dental' and started_date between '#startDate#' and '#endDate#' group by test
union all
select '6.21 GIT',sum((test = 'GIT' )::integer) As "Total Exam",
(Select Sum((test = 'GIT' and result = 'Positive' )::integer ) from S  
where test = 'GIT'  group by test)
from S  where test = 'GIT' and started_date between '#startDate#' and '#endDate#' group by test
union all
select '6.22 Lymph node tissue',sum((test = 'Lymph node tissue' )::integer) As "Total Exam",
(Select Sum((test = 'Lymph node tissue' and result = 'Positive' )::integer ) from S  
where test = 'Lymph node tissue'  group by test)
from S  where test = 'Lymph node tissue' and started_date between '#startDate#' and '#endDate#' group by test
union all
select 'Bone Marrow Studies' as "Test",null as "Total Exam",null as "Malignant"
union all
select '6.23 Bone Marrow Aspirate',sum((test = 'Bone Marrow Aspirate' )::integer) As "Total Exam",
(Select Sum((test = 'Bone Marrow Aspirate' and result = 'Positive' )::integer ) from S  
where test = 'Bone Marrow Aspirate'  group by test)
from S  where test = 'Bone Marrow Aspirate' and started_date between '#startDate#' and '#endDate#' group by test
union all
select '6.24 Trephine biopsy',sum((test = 'Trephine biopsy' )::integer) As "Total Exam",
(Select Sum((test = 'Trephine biopsy' and result = 'Positive' )::integer ) from S  
where test = 'Trephine biopsy'  group by test)
from S  where test = 'Trephine biopsy' and started_date between '#startDate#' and '#endDate#' group by test