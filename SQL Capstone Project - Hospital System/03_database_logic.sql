-- Task 7 - Automatic Helpers ---------------------------
-- 1. Appointment Status History Trigger 
USE hospital_db;

DELIMITER $$

CREATE TRIGGER trg_appointment_status_history
AFTER UPDATE ON appointments
FOR EACH ROW
BEGIN
    IF OLD.status <> NEW.status THEN
        INSERT INTO appointment_status_history
        (
            appointment_id,
            old_status,
            new_status,
            changed_by_employee_id,
            remarks
        )
        VALUES
        (
            NEW.appointment_id,
            OLD.status,
            NEW.status,
            2,
            'Status updated automatically'
        );
    END IF;
END$$
DELIMITER ;

-- Appointment Status History
UPDATE appointments SET status = 'Completed' WHERE appointment_id = 2;
SELECT * FROM appointment_status_history WHERE appointment_id = 2;

-- 2.Never Allow Medicine Stock Below Zero
DELIMITER $$
CREATE TRIGGER trg_check_stock_before_prescription
BEFORE INSERT ON prescription_items
FOR EACH ROW
BEGIN
    DECLARE available_stock INT;
    SELECT stock_quantity
    INTO available_stock
    FROM medicine_inventory
    WHERE medicine_id = NEW.medicine_id
    LIMIT 1;
    IF available_stock < 10 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Medicine Stock is Less Than 10';
    END IF;
END$$
DELIMITER ;

-- Stock ko 5 kar do
UPDATE medicine_inventory SET stock_quantity = 5 WHERE medicine_id = 2;
INSERT INTO prescription_items (prescription_id, medicine_id, dosage, frequency, duration_days) VALUES (1,2,'500mg','1-0-1',5);

-- 3. Automatically Reduce Medicine Stock
USE hospital_db;
DELIMITER $$
CREATE TRIGGER trg_reduce_stock
AFTER INSERT ON prescription_items
FOR EACH ROW
BEGIN
    UPDATE medicine_inventory
    SET stock_quantity = stock_quantity - 1
    WHERE medicine_id = NEW.medicine_id;
END$$
DELIMITER ;
UPDATE medicine_inventory SET stock_quantity = 200 WHERE medicine_id = 5;
SELECT * FROM medicine_inventory;

-- Task 8 - Build Reusable Answers and Calculators
-- 1. View - Today's Appointments
USE hospital_db;
CREATE OR REPLACE VIEW vw_today_appointments AS
SELECT
    a.appointment_id,
    CONCAT(p.first_name,' ',p.last_name) AS patient_name,
    CONCAT(d.first_name,' ',d.last_name) AS doctor_name,
    a.appointment_date,
    a.token_number,
    a.status
FROM appointments a
JOIN patients p
ON a.patient_id = p.patient_id
JOIN doctors d
ON a.doctor_id = d.doctor_id
WHERE a.appointment_date = CURDATE();

SELECT * FROM vw_today_appointments;
-- 2. Function - Patient Age
DELIMITER $$
CREATE FUNCTION fn_patient_age(p_patient_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
DECLARE age_years INT;
SELECT TIMESTAMPDIFF
(
YEAR,
date_of_birth,
CURDATE()
)
INTO age_years
FROM patients
WHERE patient_id=p_patient_id;
RETURN age_years;
END$$
DELIMITER ;

SELECT fn_patient_age(5);

-- 3. Function - Bill Total Including GST (18%)
DELIMITER $$
CREATE FUNCTION fn_bill_total_with_tax(p_bill_id INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
DECLARE total DECIMAL(10,2);
SELECT total_amount*1.18
INTO total
FROM bills
WHERE bill_id=p_bill_id;
RETURN total;
END$$
DELIMITER ; 

SELECT fn_bill_total_with_tax(5);

-- 4. Stored Procedure - Patient Visit History
DELIMITER $$
CREATE PROCEDURE sp_patient_visit_history
(
IN p_patient_id INT
)
BEGIN
SELECT
appointment_id,
appointment_date,
status,
reason
FROM appointments
WHERE patient_id=p_patient_id;
SELECT
admission_id,
admission_date,
discharge_date,
diagnosis
FROM admissions
WHERE patient_id=p_patient_id;

SELECT
bill_id,
total_amount
FROM bills
WHERE patient_id=p_patient_id;
END$$
DELIMITER ;
CALL sp_patient_visit_history(5);

-- Task 9 - Insurance Discount
DELIMITER $$
CREATE PROCEDURE sp_apply_bill_discount
(
IN p_bill_id INT
)
BEGIN
DECLARE bill_total DECIMAL(10,2);
DECLARE discount DECIMAL(10,2);
SELECT total_amount
INTO bill_total
FROM bills
WHERE bill_id=p_bill_id;
IF bill_total>=50000 THEN
SET discount=20;
ELSEIF bill_total>=20000 THEN
SET discount=15;
ELSEIF bill_total>=10000 THEN
SET discount=10;
ELSEIF bill_total>=5000 THEN
SET discount=5;
ELSE
SET discount=0;
END IF;
UPDATE bills
SET total_amount=total_amount-(total_amount*discount/100)
WHERE bill_id=p_bill_id;
SELECT
bill_id,
bill_total AS Original_Bill,
discount AS Discount_Percentage,
bill_total-(bill_total*discount/100) AS Final_Bill
FROM bills
WHERE bill_id=p_bill_id;
END$$
DELIMITER ;

CALL sp_apply_bill_discount(8);