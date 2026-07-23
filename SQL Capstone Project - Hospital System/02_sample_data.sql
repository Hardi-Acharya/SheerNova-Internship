USE hospital_db;

-- 1. patients - 10 records
INSERT INTO patients (patient_code, first_name, last_name, gender, date_of_birth, blood_group, phone, email, marital_status) VALUES
('P001','Amit','Sharma','Male','1990-05-12','B+','9876543210','amit@gmail.com','Married'),
('P002','Priya','Verma','Female','1985-08-22','O+','9876543211','priya@gmail.com','Single'),
('P003','Rahul','Mehta','Male','1992-01-10','A+','9876543212','rahul@gmail.com','Married'),
('P004','Sneha','Patel','Female','1998-11-30','AB+','9876543213','sneha@gmail.com','Single'),
('P005','Vikram','Singh','Male','1978-03-15','O-','9876543214','vikram@gmail.com','Married'),
('P006','Anjali','Gupta','Female','1995-07-19','B-','9876543215','anjali@gmail.com','Single'),
('P007','Rohit','Jain','Male','2000-12-05','A-','9876543216','rohit@gmail.com','Single'),
('P008','Kavita','Yadav','Female','1988-04-25','AB-','9876543217','kavita@gmail.com','Married'),
('P009','Deepak','Kumar','Male','1993-09-14','O+','9876543218','deepak@gmail.com','Married'),
('P010','Pooja','Shah','Female','1996-02-28','B+','9876543219','pooja@gmail.com','Single');

-- 2. patient_addresses
INSERT INTO patient_addresses (patient_id, address_type, address_line1, city, state, pincode) VALUES
(1,'Home','101 MG Road','Mumbai','Maharashtra','400001'),(2,'Home','202 Park Street','Delhi','Delhi','110001'),
(3,'Home','303 Civil Lines','Pune','Maharashtra','411001'),(4,'Home','404 Gandhi Nagar','Ahmedabad','Gujarat','380001'),
(5,'Home','505 Sector 15','Jaipur','Rajasthan','302001'),(6,'Home','606 Lake View','Kolkata','West Bengal','700001'),
(7,'Home','707 Hill Road','Bangalore','Karnataka','560001'),(8,'Home','808 Beach Road','Chennai','Tamil Nadu','600001'),
(9,'Home','909 Railway Colony','Hyderabad','Telangana','500001'),(10,'Home','1001 Temple Road','Lucknow','UP','226001');

-- 3. departments
INSERT INTO departments (department_name, department_code, location, phone_extension) VALUES
('Cardiology','CARD','Block A','101'),('Neurology','NEURO','Block B','102'),('Orthopedics','ORTHO','Block C','103'),
('Pediatrics','PED','Block D','104'),('Gynecology','GYNAE','Block E','105'),('General Medicine','GEN','Block F','106'),
('Surgery','SURG','Block G','107'),('ENT','ENT','Block H','108'),('Dermatology','DERM','Block I','109'),
('Radiology','RADIO','Block J','110');

-- 4. employees
INSERT INTO employees (employee_code, first_name, last_name, gender, dob, phone, email, department_id, role, hire_date, salary) VALUES
('E001','Suresh','Kumar','Male','1980-01-01','9000001001','suresh@hosp.com',6,'Admin','2020-01-01',80000),
('E002','Meena','Rao','Female','1985-02-02','9000001002','meena@hosp.com',6,'Receptionist','2021-03-01',25000),
('E003','Kiran','Das','Male','1990-03-03','9000001003','kiran@hosp.com',6,'Cashier','2021-04-01',30000),
('E004','Sunita','Nair','Female','1988-04-04','9000001004','sunita@hosp.com',2,'Nurse','2020-05-01',35000),
('E005','Raj','Malik','Male','1987-05-05','9000001005','raj@hosp.com',1,'Nurse','2020-06-01',35000),
('E006','Anita','Bose','Female','1992-06-06','9000001006','anita@hosp.com',3,'Nurse','2021-07-01',35000),
('E007','Prakash','Reddy','Male','1989-07-07','9000001007','prakash@hosp.com',4,'Lab Technician','2020-08-01',40000),
('E008','Leela','Ghosh','Female','1991-08-08','9000001008','leela@hosp.com',5,'Pharmacist','2021-09-01',32000),
('E009','Mohan','Iyer','Male','1986-09-09','9000001009','mohan@hosp.com',6,'HR','2020-10-01',45000),
('E010','Rekha','Joshi','Female','1993-10-10','9000001010','rekha@hosp.com',6,'Cleaner','2021-11-01',18000);

-- 5. doctors
INSERT INTO doctors (doctor_code, first_name, last_name, gender, dob, phone, email, consultation_fee, qualification, license_number, department_id, joining_date) VALUES
('D001','Dr. Arjun','Kapoor','Male','1975-01-15','9100001','arjun@hosp.com',800,'MD Cardiology','LIC1001',1,'2015-01-01'),
('D002','Dr. Kavita','Rao','Female','1978-02-20','9100000002','kavita@hosp.com',900,'MD Neurology','LIC1002',2,'2016-02-01'),
('D003','Dr. Manish','Verma','Male','1980-03-25','9100000003','manish@hosp.com',700,'MS Ortho','LIC1003',3,'2017-03-01'),
('D004','Dr. Sneha','Patel','Female','1982-04-30','9100000004','sneha@hosp.com',600,'MD Pediatrics','LIC1004',4,'2018-04-01'),
('D005','Dr. Ritu','Sharma','Female','1983-05-05','9100000005','ritu@hosp.com',750,'MD Gynaecology','LIC1005',5,'2018-05-01'),
('D006','Dr. Ajay','Singh','Male','1979-06-10','9100000006','ajay@hosp.com',500,'MD General','LIC1006',6,'2016-06-01'),
('D007','Dr. Pooja','Mehta','Female','1981-07-15','9100000007','pooja@hosp.com',1200,'MS Surgery','LIC1007',7,'2017-07-01'),
('D008','Dr. Rahul','Khan','Male','1984-08-20','9100000008','rahul@hosp.com',550,'MS ENT','LIC1008',8,'2019-08-01'),
('D009','Dr. Neha','Gupta','Female','1986-09-25','9100000009','neha@hosp.com',650,'MD Dermatology','LIC1009',9,'2020-09-01'),
('D010','Dr. Sanjay','Yadav','Male','1977-10-30','9100000010','sanjay@hosp.com',700,'MD Radiology','LIC1010',10,'2015-10-01');

UPDATE departments SET head_doctor_id = 1 WHERE department_id = 1;
UPDATE departments SET head_doctor_id = 2 WHERE department_id = 2;

-- 6. specializations
INSERT INTO specializations (specialization_name) VALUES
('Interventional Cardiology'),('Pediatric Neurology'),('Joint Replacement'),('Neonatology'),
('IVF'),('Diabetology'),('Laparoscopic Surgery'),('Audiology'),('Cosmetic Dermatology'),('MRI');

-- 7. doctor_specializations
INSERT INTO doctor_specializations (doctor_id, specialization_id) VALUES
(1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10);

-- 8. doctor_slots
INSERT INTO doctor_slots (doctor_id, day_of_week, start_time, end_time, max_patients) VALUES
(1,'Monday','09:00:00','12:00:00',20),(2,'Tuesday','10:00:00','13:00:00',15),(3,'Wednesday','09:00:00','12:00:00',18),
(4,'Thursday','10:00:00','13:00:00',25),(5,'Friday','09:00:00','12:00:00',20),(6,'Saturday','10:00:00','13:00:00',30),
(7,'Monday','14:00:00','17:00:00',10),(8,'Tuesday','14:00:00','17:00:00',15),(9,'Wednesday','14:00:00','17:00:00',20),
(10,'Thursday','14:00:00','17:00:00',15);

-- 9. appointments
INSERT INTO appointments (patient_id, doctor_id, slot_id, appointment_date, token_number, visit_type, reason) VALUES
(1,1,1,'2026-07-25',1,'New','Chest Pain'),(2,2,2,'2026-07-26',1,'New','Headache'),
(3,3,3,'2026-07-27',1,'Follow-up','Knee Pain'),(4,4,4,'2026-07-28',1,'New','Fever'),
(5,5,5,'2026-07-29',1,'New','Pregnancy Checkup'),(6,6,6,'2026-07-30',1,'New','Fever'),
(7,7,7,'2026-07-25',2,'New','Appendix'),(8,8,8,'2026-07-26',2,'Follow-up','Ear Pain'),
(9,9,9,'2026-07-27',2,'New','Skin Rash'),(10,10,10,'2026-07-28',2,'New','X-Ray');

-- 10. appointment_status_history
INSERT INTO appointment_status_history (appointment_id, old_status, new_status, changed_by_employee_id) VALUES
(1,'Scheduled','Completed',2),(2,'Scheduled','Completed',2),(3,'Scheduled','Completed',2),
(4,'Scheduled','Checked-In',2),(5,'Scheduled','Scheduled',2),(6,'Scheduled','Cancelled',2),
(7,'Scheduled','Completed',2),(8,'Scheduled','Completed',2),(9,'Scheduled','No Show',2),
(10,'Scheduled','Completed',2);

-- 11. room_types
INSERT INTO room_types (room_type_name, daily_charge) VALUES
('General Ward',1000),('Semi Private',2500),('Private Room',5000),('ICU',10000),
('NICU',12000),('Deluxe Room',8000),('Suite',15000),('Day Care',800),('Emergency',2000),('Observation',1500);

-- 12. rooms
INSERT INTO rooms (room_number, room_type_id, floor_no, bed_count) VALUES
('101',1,1,4),('102',2,1,2),('201',3,2,1),('202',4,2,1),('301',5,3,1),
('302',6,3,1),('401',7,4,1),('402',8,4,2),('501',9,5,2),('502',10,5,2);

-- 13. admissions
INSERT INTO admissions (patient_id, doctor_id, room_id, admission_date, diagnosis) VALUES
(1,1,2,'2026-07-20 10:00:00','Heart Attack'),(2,2,3,'2026-07-21 11:00:00','Migraine'),
(3,3,1,'2026-07-22 09:00:00','Fracture'),(4,4,4,'2026-07-23 12:00:00','Dengue'),
(5,5,5,'2026-07-24 08:00:00','Delivery'),(6,6,6,'2026-07-25 14:00:00','Typhoid'),
(7,7,7,'2026-07-26 15:00:00','Surgery'),(8,8,8,'2026-07-27 10:00:00','Infection'),
(9,9,9,'2026-07-28 11:00:00','Eczema'),(10,10,10,'2026-07-29 09:00:00','Observation');

-- 14. medicines
INSERT INTO medicines (medicine_name, generic_name, manufacturer, medicine_type, unit_price) VALUES
('Paracetamol','Acetaminophen','Cipla','Tablet',2.00),('Crocin','Paracetamol','GSK','Tablet',3.00),
('Dolo 650','Paracetamol','Micro Labs','Tablet',2.50),('Azithromycin','Azithromycin','Sun Pharma','Tablet',25.00),
('Insulin','Insulin','Novo Nordisk','Injection',200.00),('Cetirizine','Cetirizine','Dr Reddy','Tablet',5.00),
('Amoxicillin','Amoxicillin','Abbott','Capsule',10.00),('Cough Syrup','Dextromethorphan','Dabur','Syrup',80.00),
('Betadine','Povidone','Piramal','Cream',40.00),('Eye Drops','Tropicamide','Cipla','Drops',30.00);

-- 15. suppliers
INSERT INTO suppliers (supplier_name, contact_person, phone, email, address, city, gst_number) VALUES
('MediCorp','Ravi','9800000001','ravi@medicorp.com','123 Industrial Area','Mumbai','27ABCDE1234F1Z5'),
('HealthPlus','Sunil','9800000002','sunil@health.com','456 Pharma Lane','Delhi','07ABCDE1234F1Z5'),
('PharmaWorld','Anita','9800003','anita@pharma.com','789 Drug Street','Pune','27ABCDE1234F2Z5'),
('CareMeds','Kiran','9800004','kiran@care.com','101 Medical Road','Ahmedabad','24ABCDE1234F1Z5'),
('LifeLine','Meena','9800000005','meena@life.com','202 Health Ave','Jaipur','08ABCDE1234F1Z5'),
('DrugMart','Prakash','9800000006','prakash@drug.com','303 Pharma Park','Kolkata','19ABCDE1234F1Z5'),
('MediSupply','Leela','9800000007','leela@supply.com','404 Drug Hub','Bangalore','29ABCDE1234F1Z5'),
('HealthCare','Mohan','9800000008','mohan@care.com','505 Medicine St','Chennai','33ABCDE1234F1Z5'),
('PharmaLink','Rekha','9800000009','rekha@link.com','606 Industrial Zone','Hyderabad','36ABCDE1234F1Z5'),
('MediTrade','Suresh','9800000010','suresh@trade.com','707 Pharma City','Lucknow','09ABCDE1234F1Z5');

-- 16. medicine_inventory
INSERT INTO medicine_inventory (medicine_id, supplier_id, batch_number, manufacture_date, expiry_date, stock_quantity, purchase_price, selling_price) VALUES
(1,1,'B001','2025-01-01','2027-01-01',500,1.50,2.00),(2,2,'B002','2025-02-01','2027-02-01',400,2.00,3.00),
(3,3,'B003','2025-03-01','2027-03-01',600,2.00,2.50),(4,4,'B004','2025-04-01','2027-04-01',200,20.00,25.00),
(5,5,'B005','2025-05-01','2027-05-01',100,180.00,200.00),(6,6,'B006','2025-06-01','2027-06-01',800,4.00,5.00),
(7,7,'B007','2025-07-01','2027-07-01',300,8.00,10.00),(8,8,'B008','2025-08-01','2027-08-01',150,70.00,80.00),
(9,9,'B009','2025-09-01','2027-09-01',250,35.00,40.00),(10,10,'B010','2025-10-01','2027-10-01',350,25.00,30.00);

-- 17. purchase_orders
INSERT INTO purchase_orders (supplier_id, medicine_id, order_date, quantity, unit_price, total_amount) VALUES
(1,1,'2026-07-01',100,1.50,150),(2,2,'2026-07-02',100,2.00,200),(3,3,'2026-07-03',100,2.00,200),
(4,4,'2026-07-04',50,20.00,1000),(5,5,'2026-07-05',20,180.00,3600),(6,6,'2026-07-06',200,4.00,800),
(7,7,'2026-07-07',100,8.00,800),(8,8,'2026-07-08',50,70.00,3500),(9,9,'2026-07-09',100,35.00,3500),
(10,10,'2026-07-10',150,25.00,3750);

-- 18. prescriptions
INSERT INTO prescriptions (appointment_id, patient_id, doctor_id, diagnosis) VALUES
(1,1,1,'Angina'),(2,2,2,'Migraine'),(3,3,3,'Arthritis'),(4,4,4,'Viral Fever'),
(5,5,5,'Pregnancy'),(6,6,6,'Bacterial Infection'),(7,7,7,'Appendicitis'),
(8,8,8,'Otitis'),(9,9,9,'Dermatitis'),(10,10,10,'Routine Check');

-- 19. prescription_items
INSERT INTO prescription_items (prescription_id, medicine_id, dosage, frequency, duration_days) VALUES
(1,1,'500mg','1-0-1',5),(2,6,'10mg','0-1-0',7),(3,3,'650mg','1-1-1',10),(4,2,'500mg','1-0-1',3),
(5,5,'10 Units','0-1-0',30),(6,4,'500mg','1-0-1',5),(7,7,'500mg','1-1-1',7),(8,10,'2 drops','1-0-1',5),
(9,9,'Apply','0-1-0',14),(10,1,'500mg','0-0-1',3);

-- 20. emergency_cases
INSERT INTO emergency_cases (patient_id, doctor_id, arrival_time, brought_by, emergency_type, severity_level) VALUES
(1,1,'2026-07-20 09:30:00','Ambulance','Heart Attack','Critical'),(2,2,'2026-07-21 10:30:00','Relative','Stroke','High'),
(3,3,'2026-07-22 08:30:00','Police','Accident','High'),(4,4,'2026-07-23 11:30:00','Self','Fever','Medium'),
(5,5,'2026-07-24 07:30:00','Ambulance','Pregnancy','High'),(6,6,'2026-07-25 13:30:00','Relative','Poisoning','Critical'),
(7,7,'2026-07-26 14:30:00','Ambulance','Accident','Critical'),(8,8,'2026-07-27 09:30:00','Self','Burn','Medium'),
(9,9,'2026-07-28 10:30:00','Relative','Allergy','Low'),(10,10,'2026-07-29 08:30:00','Ambulance','Other','Medium');

-- 21. bills - FIXED: missing NULL added
INSERT INTO bills (patient_id, bill_type, appointment_id, admission_id, emergency_case_id, total_amount) VALUES
(1,'OPD',1,NULL,1,800),(2,'IPD',2,2,NULL,15000),(3,'IPD',3,3,NULL,8000),
(4,'Emergency',4,NULL,4,5000),(5,'IPD',5,5,NULL,25000),(6,'OPD',6,NULL,NULL,500),
(7,'IPD',7,7,NULL,40000),(8,'OPD',8,NULL,NULL,700),(9,'OPD',9,NULL,NULL,900),
(10,'IPD',10,10,NULL,6000);

INSERT INTO bill_items (bill_id, item_type, item_name, quantity, unit_price, total_price) VALUES
 (1,'Consultation','Cardiology Consult',1,800,800),(2,'Room','Private Room',5,2500,12500),(2,'Consultation','Neurology',1,900,900),
 (3,'Room','General Ward',4,1000,4000),(3,'Surgery','Knee Surgery',1,4000,4000),(4,'Emergency','Emergency Charges',1,2000,2000),
 (5,'Room','NICU',7,12000,84000),(6,'Medicine','Antibiotics',1,500,500),(7,'Surgery','Appendix Surgery',1,35000,35000),
 (8,'Consultation','ENT Consult',1,550,550),(9,'Consultation','Dermatology',1,650,650),(10,'Room','Observation',3,1500,4500);

-- 23. payments
INSERT INTO payments (bill_id, payment_method, amount_paid, transaction_reference, received_by_employee_id) VALUES
(1,'UPI',800,'TXN001',3),(2,'Card',15000,'TXN002',3),(3,'Cash',8000,'TXN003',3),
(4,'Insurance',5000,'TXN004',3),(5,'Net Banking',25000,'TXN005',3),(6,'Cash',500,'TXN006',3),
(7,'Cheque',40000,'TXN007',3),(8,'UPI',700,'TXN008',3),(9,'Card',900,'TXN009',3),
(10,'Insurance',6000,'TXN010',3);

-- 24. patient_insurance
INSERT INTO patient_insurance (patient_id, insurance_company, policy_number, coverage_amount, valid_from, valid_to) VALUES
(1,'Star Health','POL001',500000,'2025-01-01','2026-12-31'),(2,'ICICI Lombard','POL002',300000,'2025-02-01','2026-11-30'),
(3,'HDFC Ergo','POL003',400000,'2025-03-01','2026-10-31'),(4,'Tata AIG','POL004',250000,'2025-04-01','2026-09-30'),
(5,'Max Bupa','POL005',600000,'2025-05-01','2026-08-31'),(6,'Bajaj Allianz','POL006',200000,'2025-06-01','2026-07-31'),
(7,'New India','POL007',700000,'2025-07-01','2026-06-30'),(8,'Reliance','POL008',350000,'2025-08-01','2026-05-31'),
(9,'Oriental','POL009',450000,'2025-09-01','2026-04-30'),(10,'National','POL010',500000,'2025-10-01','2026-03-31');

-- 25. blood_bank
INSERT INTO blood_bank (blood_group, donor_name, donor_phone, collection_date, expiry_date, quantity_ml) VALUES
('A+','Ravi Kumar','9900001','2026-07-01','2026-09-01',450),('B+','Sunil Sharma','9900000002','2026-07-02','2026-09-02',450),
('O+','Anita Verma','9900000003','2026-07-03','2026-09-03',450),('AB+','Kiran Patel','9900000004','2026-07-04','2026-09-04',450),
('A-','Meena Singh','9900000005','2026-07-05','2026-09-05',450),('B-','Prakash Gupta','9900000006','2026-07-06','2026-09-06',450),
('O-','Leela Rao','9900007','2026-07-07','2026-09-07',450),('AB-','Mohan Das','9900000008','2026-07-08','2026-09-08',450),
('A+','Rekha Jain','9900000009','2026-07-09','2026-09-09',450),('B+','Suresh Yadav','9900000010','2026-07-10','2026-09-10',450);

-- 26. patient_feedback
INSERT INTO patient_feedback (patient_id, feedback_type, doctor_id, rating, feedback_text) VALUES
(1,'Doctor',1,5,'Excellent service'),(2,'Hospital',NULL,4,'Good facilities'),(3,'Staff',NULL,5,'Very helpful nurses'),
(4,'Room',NULL,3,'Room was clean'),(5,'Doctor',5,5,'Best gynecologist'),(6,'Hospital',NULL,4,'Affordable'),
(7,'Doctor',7,5,'Great surgeon'),(8,'Staff',NULL,4,'Cooperative'),(9,'Doctor',9,4,'Good treatment'),(10,'Hospital',NULL,5,'Highly recommend');

-- 27. employee_leaves
INSERT INTO employee_leaves (employee_id, leave_type, start_date, end_date, total_days, approved_by) VALUES
(2,'Casual','2026-07-01','2026-07-02',2,1),(3,'Sick','2026-07-05','2026-07-05',1,1),(4,'Earned','2026-07-10','2026-07-12',3,1),
(5,'Casual','2026-07-15','2026-07-15',1,1),(6,'Sick','2026-07-20','2026-07-21',2,1),(7,'Emergency','2026-07-25','2026-07-25',1,1),
(8,'Casual','2026-07-28','2026-07-29',2,1),(9,'Earned','2026-08-01','2026-08-03',3,1),(10,'Sick','2026-08-05','2026-08-05',1,1),
(1,'Casual','2026-08-10','2026-08-11',2,9);