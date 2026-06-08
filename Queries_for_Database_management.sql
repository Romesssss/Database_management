CREATE VIEW patient_summary AS
SELECT 
p.patient_id AS ID,
p.name AS Name, 
a.admit_date AS Admitted, 
a.discharge_date as Discharged,
g.icd_code AS Final_Diagnosis,
g.description,
g.severity,
d.name AS Doctor_Assigned,
c.drug_name AS Medication,
c.dosage AS Dosage,
c.duration_days AS Duration,
l.total_amount AS Total,
l.payment_status
FROM patients as p
LEFT JOIN admission as a
ON a.patient_id = p.patient_id
LEFT JOIN doctors as d
ON d.doctor_id = a.doctor_id
LEFT JOIN diagnose as g
ON g.admission_id = a.admission_id
LEFT JOIN prescription as c
ON c.admission_id = a.admission_id
LEFT JOIN bills as l
on l.admission_id = a.admission_id
;



SELECT * FROM patient_summary;


-- SELECT --
SELECT * FROM patients
WHERE gender = 'female'
;

SELECT doctor_id, name, specialty 
FROM doctors;

SELECT p.name AS Patient, a.ward FROM admission a
JOIN patients p
ON p.patient_id = a.patient_id
WHERE ward = 'Female Ward' 
;

SELECT * FROM bills
WHERE payment_status = 'unpaid'
;

-- JOINS --

SELECT 
p.name AS Patient,
d.name AS Doctor 
FROM patients as p
JOIN admission as a
ON a.patient_id = p.patient_id
JOIN doctors d
ON d.doctor_id = a.doctor_id
;

SELECT  
name AS patient, 
d.description
FROM patients AS p
JOIN admission AS a ON a.patient_id = p.patient_id
JOIN diagnose AS d ON d.admission_id = a.admission_id
;

SELECT p.name AS Patient, b.total_amount AS Bill_Amount FROM patients p
JOIN admission AS a
ON a.patient_id = p.patient_id
JOIN bills b
ON b.admission_id = a.admission_id;

SELECT p.name AS Patient,
a.admit_date  
FROM patients p 
JOIN admission a 
ON a.patient_id = p.patient_id
WHERE admit_date BETWEEN '2026-10-01' AND '2026-10-30'
;

-- Aggregation --

SELECT d.name AS Doctor,
COUNT(p.patient_id) AS Patient_count
FROM doctors as D
JOIN admission as a
ON a.doctor_id = d.doctor_id
JOIN patients as p
ON p.patient_id = a.patient_id 
GROUP by d.name
;

SELECT 
b.total_amount,
p.name AS patient
FROM bills b
JOIN admission as a
ON a.admission_id = b.admission_id
JOIN patients as p
ON p.patient_id = a.patient_id
WHERE total_amount > 30000 
;

SELECT AVG(total_amount) AS Average_Bill
FROM bills
;

SELECT a.ward, COUNT(p.patient_id) AS Patient FROM admission a
JOIN patients p 
ON p.patient_id = a.patient_id
GROUP BY a.ward
ORDER BY ward ASC                                                                                                 
;

-- Sorting --

SELECT 
b.total_amount,
p.name AS patient
FROM bills b
JOIN admission as a
ON a.admission_id = b.admission_id
JOIN patients as p
ON p.patient_id = a.patient_id
ORDER BY b.total_amount DESC
;

SELECT p.name as Patient,
d.severity AS Intensity
FROM diagnose d
JOIN admission a
ON a.admission_id = d.admission_id
JOIN patients p 
ON p.patient_id = a.patient_id
WHERE d.severity = 'severe'
;

SELECT p.name AS Patient, a.admit_date AS Admitted, a.discharge_date AS Discharged FROM admission a
JOIN patients p
ON p.patient_id = a.patient_id
WHERE a.admit_date < a.discharge_date - INTERVAL 3 DAY 
;
-- ALT sorting--
SELECT p.name AS Patient, a.admit_date AS Admitted, a.discharge_date AS Discharged FROM admission a
JOIN patients p
ON p.patient_id = a.patient_id
WHERE DATEDIFF(a.discharge_date, a.admit_date) > 3
;

SELECT SUM(total_amount) FROM bills
WHERE payment_status = 'Paid'
;

