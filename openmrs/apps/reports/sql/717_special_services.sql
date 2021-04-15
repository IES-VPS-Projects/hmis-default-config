SELECT 'C. SPECIAL SERVICE (includes both inpatients and outpatients) ' AS 'Service',
     ' ' as 'Routine',
     '' as 'Number',
     ' ' as 'Services',
     '' as 'Number.'

UNION ALL

SELECT 'C.1 Laboratry - Number of tests ' AS 'Service',
     'Routine' as 'Routine',
     'Number' as 'Number',
     'Special' as 'Services',
     '' as 'Number.'

UNION ALL

SELECT 'C.2 X-Ray and Imaging - Nmber of Examinations ' AS 'Service',
     'Routine' as 'Routine',
     'Number' as 'Number',
     'Special' as 'Services',
     'Number' as 'Number.'

UNION ALL

SELECT '' AS 'Service',
     'Plain X-Ray qithout contrast enhancement' as 'Routine',
     '' as 'Number',
     'Contrast enhanced examinations' as 'Services',
     '' as 'Number.'

UNION ALL 

SELECT '' AS 'Service',
     '' as 'Routine',
     '' as 'Number',
     'Magnetic Resonance Imaging' as 'Services',
     '' as 'Number.'

UNION ALL 

SELECT '' AS 'Service',
     '' as 'Routine',
     '' as 'Number',
     'Computerized Tomography' as 'Services',
     '' as 'Number.'

UNION ALL 

SELECT '' AS 'Service',
     '' as 'Routine',
     '' as 'Number',
     'Mamography' as 'Services',
     '' as 'Number.'

UNION ALL 

SELECT '' AS 'Service',
     '' as 'Routine',
     '' as 'Number',
     'Chest X-Ray fot PTB with specialist report' as 'Services',
     '' as 'Number.'

UNION ALL 

SELECT 'C.3 Number of ultrasound examinations' AS 'Service',
     'General ultrasound' as 'Routine',
     '' as 'Number',
     'Obsteric ultrasound' as 'Services',
     '' as 'Number.'

UNION ALL 

SELECT 'C.4 Total routine (X-Ray and Imaging)' AS 'Service',
     'General ultrasound' as 'Routine',
     '' as 'Number',
     'Total special (X-Ray and Imaging)' as 'Services',
     '' as 'Number.'

UNION ALL 

SELECT 'C.5 Physiotherapy -Number of patients' AS 'Service',
     '' as 'Routine',
     '' as 'Number',
     '' as 'Services',
     '' as 'Number.'

     UNION ALL 

SELECT 'C.5 Occupational therapy - Number of patients' AS 'Service',
     '' as 'Routine',
     '' as 'Number',
     '' as 'Services',
     '' as 'Number.'

     UNION ALL 

SELECT 'C.6 Orthopedic technology' AS 'Service',
     '' as 'Routine',
     '' as 'Number',
     '' as 'Services',
     '' as 'Number.'

          UNION ALL 

SELECT 'C.7 Orthopedic technology' AS 'Service',
     '' as 'Routine',
     '' as 'Number',
     '' as 'Services',
     '' as 'Number.'