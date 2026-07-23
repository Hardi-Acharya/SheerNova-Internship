USE hospital_db;

SET AUTOCOMMIT=0;
SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;

DELIMITER $$

DROP PROCEDURE IF EXISTS book_appointment$$

CREATE PROCEDURE book_appointment(
IN p_patient_id INT,
IN p_doctor_id INT,
IN p_slot_id INT,
IN p_appointment_date DATE,
IN p_reason VARCHAR(255),
OUT p_appointment_id INT,
OUT p_status VARCHAR(50)
)
BEGIN
DECLARE v_token INT;
DECLARE v_max_patients INT;
DECLARE v_booked INT;

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
SET p_status='Failed';
SET p_appointment_id=NULL;
END;

START TRANSACTION;

SELECT max_patients INTO v_max_patients
FROM doctor_slots
WHERE slot_id=p_slot_id
FOR UPDATE;

SELECT COUNT(*) INTO v_booked
FROM appointments
WHERE doctor_id=p_doctor_id
AND slot_id=p_slot_id
AND appointment_date=p_appointment_date;

IF v_booked>=v_max_patients THEN

SET p_status='Slot Full';
SET p_appointment_id=NULL;
ROLLBACK;

ELSE

SELECT IFNULL(MAX(token_number),0)+1 INTO v_token
FROM appointments
WHERE doctor_id=p_doctor_id
AND appointment_date=p_appointment_date
FOR UPDATE;

INSERT INTO appointments
(patient_id,doctor_id,slot_id,appointment_date,token_number,visit_type,reason,status)
VALUES
(p_patient_id,p_doctor_id,p_slot_id,p_appointment_date,v_token,'New',p_reason,'Scheduled');

SET p_appointment_id=LAST_INSERT_ID();
SET p_status='Success';

COMMIT;

END IF;
END$$



DROP PROCEDURE IF EXISTS admit_patient$$

CREATE PROCEDURE admit_patient(
IN p_patient_id INT,
IN p_doctor_id INT,
IN p_room_id INT,
IN p_diagnosis VARCHAR(255),
OUT p_status VARCHAR(50)
)
BEGIN

DECLARE v_room_status VARCHAR(20);

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
SET p_status='Failed';
END;

START TRANSACTION;

SELECT status INTO v_room_status
FROM rooms
WHERE room_id=p_room_id
FOR UPDATE;

IF v_room_status<>'Available' THEN

SET p_status='Bed Not Available';
ROLLBACK;

ELSE

UPDATE rooms
SET status='Occupied'
WHERE room_id=p_room_id;

INSERT INTO admissions
(patient_id,doctor_id,room_id,admission_date,diagnosis,admission_status)
VALUES
(p_patient_id,p_doctor_id,p_room_id,NOW(),p_diagnosis,'Admitted');

SET p_status='Admitted Successfully';

COMMIT;

END IF;

END$$



DROP PROCEDURE IF EXISTS sell_medicine$$

CREATE PROCEDURE sell_medicine(
IN p_prescription_id INT,
IN p_medicine_id INT,
IN p_qty INT,
IN p_dosage VARCHAR(50),
IN p_frequency VARCHAR(50),
IN p_days INT,
OUT p_status VARCHAR(50)
)
BEGIN

DECLARE v_stock INT;

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
SET p_status='Failed';
END;

START TRANSACTION;

SELECT stock_quantity INTO v_stock
FROM medicine_inventory
WHERE medicine_id=p_medicine_id
FOR UPDATE;

IF v_stock<p_qty THEN

SET p_status='Stock Not Enough';
ROLLBACK;

ELSE

UPDATE medicine_inventory
SET stock_quantity=stock_quantity-p_qty
WHERE medicine_id=p_medicine_id;

INSERT INTO prescription_items
(prescription_id,medicine_id,dosage,frequency,duration_days)
VALUES
(p_prescription_id,p_medicine_id,p_dosage,p_frequency,p_days);

SET p_status='Medicine Issued';

COMMIT;

END IF;

END$$


DELIMITER ;


-- TASK 10 PROBLEM DEMO (RUN IN TWO CONNECTIONS)

-- CONNECTION A
START TRANSACTION;

SELECT COUNT(*)
FROM appointments
WHERE doctor_id=1
AND slot_id=1
AND appointment_date='2026-08-20';

INSERT INTO appointments
(patient_id,doctor_id,slot_id,appointment_date,token_number,visit_type,reason,status)
VALUES
(1,1,1,'2026-08-20',1,'New','Fever','Scheduled');

COMMIT;


-- CONNECTION B
START TRANSACTION;

SELECT COUNT(*)
FROM appointments
WHERE doctor_id=1
AND slot_id=1
AND appointment_date='2026-08-20';

INSERT INTO appointments
(patient_id,doctor_id,slot_id,appointment_date,token_number,visit_type,reason,status)
VALUES
(2,1,1,'2026-08-20',2,'New','Cold','Scheduled');

COMMIT;



-- TASK 12 STRESS TEST

CALL book_appointment(1,1,1,'2026-08-20','Test 1',@id,@status);
SELECT @status;

CALL book_appointment(2,1,1,'2026-08-20','Test 2',@id,@status);
SELECT @status;

CALL book_appointment(3,1,1,'2026-08-20','Test 3',@id,@status);
SELECT @status;

CALL book_appointment(4,1,1,'2026-08-20','Test 4',@id,@status);
SELECT @status;

CALL book_appointment(5,1,1,'2026-08-20','Test 5',@id,@status);
SELECT @status;


SELECT COUNT(*)
FROM appointments
WHERE doctor_id=1
AND slot_id=1
AND appointment_date='2026-08-20';



CALL admit_patient(1,1,1,'Fever',@status);
SELECT @status;

CALL admit_patient(2,1,1,'Cold',@status);
SELECT @status;

CALL admit_patient(3,1,1,'Pain',@status);
SELECT @status;



CALL sell_medicine(1,1,2,'500mg','1-0-1',5,@status);
SELECT @status;

CALL sell_medicine(1,1,2,'500mg','1-0-1',5,@status);
SELECT @status;

CALL sell_medicine(1,1,2,'500mg','1-0-1',5,@status);
SELECT @status;

CALL sell_medicine(1,1,2,'500mg','1-0-1',5,@status);
SELECT @status;


SELECT * FROM medicine_inventory WHERE medicine_id=1;