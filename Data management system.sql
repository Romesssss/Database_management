

CREATE TABLE patients (
    patient_id INT NOT NULL AUTO_INCREMENT, 
    name VARCHAR(50), 
    dob DATE, 
    gender VARCHAR(10), 
    phone VARCHAR(20),
    PRIMARY KEY (patient_id)
);

INSERT INTO patients (name, dob, gender, phone)
VALUES 
('ROMEO ESCOREL',    '2002-05-02', 'male',   '+639683274508'),
('NARUTO UZUMAKI',   '1996-06-19', 'male',   '+63321234567'),
('ICHIGO KUROSAKI',  '1997-10-03', 'male',   '+6322345678'),
('GOKU',             '1999-04-22', 'male',   '+63823456789'),
('ERZA SCARLET',     '2001-08-14', 'female', '+63744567890'),
('BURNICE',          '2002-11-11', 'female', '+63445678901'),
('LUCY HEARTFILIA',  '2001-04-25', 'female', '+63346789012')
;
ALTER TABLE patients AUTO_INCREMENT = 8;

INSERT INTO patients (name, dob, gender, phone)
VALUES ('ITADORI YUJI', '2002-05-21', 'male', '+639915148091');

CREATE TABLE doctors (
	doctor_id INT NOT NULL AUTO_INCREMENT, 
    name VARCHAR(50), 
    specialty VARCHAR(50), 
    department VARCHAR(50),
    PRIMARY KEY (doctor_id)
);


CREATE TABLE admission (
	admission_id INT NOT NULL AUTO_INCREMENT,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    admit_date DATE, 
    discharge_date DATE, 
    ward VARCHAR(50),
    PRIMARY KEY (admission_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);

CREATE TABLE diagnose (
	diagnosis_id INT NOT NULL AUTO_INCREMENT,
    admission_id INT NOT NULL,
    icd_code VARCHAR(20), 
    description VARCHAR(255),
    severity VARCHAR(50),
    PRIMARY KEY (diagnosis_id),
    FOREIGN KEY (admission_id) REFERENCES admission(admission_id)
);

CREATE TABLE prescription (
	prescription_id INT NOT NULL AUTO_INCREMENT,
    admission_id INT NOT NULL,
    drug_name VARCHAR(50), 
    dosage VARCHAR(10),
    duration_days INT,
    PRIMARY KEY (prescription_id),
    FOREIGN KEY (admission_id) REFERENCES admission(admission_id)
);
ALTER TABLE prescription
MODIFY COLUMN dosage VARCHAR(255);
CREATE TABLE bills (
	bills_id INT NOT NULL AUTO_INCREMENT,
    admission_id INT NOT NULL,
    total_amount DECIMAL, 
    payment_status VARCHAR(50),
    bill_date DATE,
    PRIMARY KEY (bills_id),
    FOREIGN KEY (admission_id) REFERENCES admission(admission_id)
);


INSERT INTO doctors (name, specialty, department)
VALUES 
('Dr. chopper', 'Surgery', 'Operating Room'),
('Dr. raven', 'Orthopedist', 'Emergency'),
('Dr. nami', 'Pedriatician', 'Pedriatics'),
('Dr. grace', 'Neurosurgeon', 'Neurologist'),
('Dr. rina', 'Anestheologist', 'Operating Room')
;

INSERT INTO admission (patient_id, doctor_id, admit_date, discharge_date, ward)
VALUES
(1,1,'2026-10-28', '2026-10-30', 'General Ward'),
(2,1,'2026-10-10', '2026-10-15', 'General Ward'),
(3,2,'2026-10-01', '2026-10-10', 'General Ward'),
(4,2,'2026-10-06', '2026-10-08', 'Male Ward'),
(5,3,'2026-10-06', '2026-10-09', 'Female Ward'),
(6,3,'2026-10-26', '2026-10-30', 'Female Ward'),
(7,4,'2026-10-21', '2026-10-22', 'Female Ward')
;
INSERT INTO admission (patient_id, doctor_id, admit_date, discharge_date, ward)
VALUES
(8,2,'2026-10-28', '2026-10-28', 'Emergency Ward')
;

INSERT INTO diagnose (admission_id, icd_code, description, severity)
VALUES
(1, 'J45.909', 'Unspecified Asthma', 'mild'),
(2, 'S61.412', 'Laceration without foreign body, left hand, initial encounter', 'severe'),
(3, 'K80.20', 'Calculus of gallbladder without cholecystitis, unspecified', 'mild'),
(4, 'I20.0', 'Unstable Angina', 'mild'),
(5, 'I10', 'Hypertension', 'mild'),
(6, 'J18.9 ', 'Pneumonia, Unspecified', 'mild'),
(7, 'I42.9', 'Cardriomyopathy', 'severe')
;
INSERT INTO diagnose (admission_id, icd_code, description, severity)
VALUES
(8, 'S61.412', 'Laceration without foreign body, left hand, initial encounter', 'severe')
;
INSERT INTO prescription (admission_id, drug_name, dosage, duration_days)
VALUES
(1, 'Salbutamol (Albuterol)', '2.5mg via nebulizer q4–6h', 6),
(2, 'Amoxicillin-Clavulanate', '875/125mg twice daily', 7),
(3, 'Piperacillin-Tazobactam', '3.375g IV q6h', 10),
(4, 'Aspirin + Nitroglycerin', '325mg loading / 0.4mg SL PRN', 30),
(5, 'Amlodipine', '5–10mg once daily', 90),
(6, 'Azithromycin', '500mg once daily', 5),
(7, 'Carvedilol', '3.125mg twice daily', 90)
;
INSERT INTO prescription (admission_id, drug_name, dosage, duration_days)
VALUES
(8, 'Amoxicillin-Clavulanate', '875/125mg twice daily', 7)
;

INSERT INTO bills (admission_id, total_amount, payment_status, bill_date)
VALUES
(1, 10000, 'Paid', '2026-10-30'),
(2, 8503, 'Paid', '2026-10-30'),
(3, 11500, 'Paid', '2026-10-30'),
(4, 12200, 'Paid', '2026-10-30'),
(5, 5600, 'Paid', '2026-10-30'),
(6, 20000, 'Paid', '2026-10-30'),
(7, 35000, 'Paid', '2026-10-30'),
(8, 8550, 'Paid', '2026-10-30')
;



ALTER TABLE bills MODIFY COLUMN total_amount DECIMAL(10,2);


UPDATE doctors SET specialty = 'Pediatrician'     WHERE doctor_id = 3;
UPDATE doctors SET department = 'Pediatrics'      WHERE doctor_id = 3;
UPDATE doctors SET specialty = 'Anesthesiologist' WHERE doctor_id = 5;
UPDATE doctors SET department = 'Neurology'       WHERE doctor_id = 4;


UPDATE diagnose SET description = 'Cardiomyopathy' WHERE diagnosis_id = 7;


UPDATE bills SET payment_status = 'Unpaid' WHERE bills_id = 6 and 8;
UPDATE bills SET payment_status = 'Unpaid' WHERE bills_id = 8;