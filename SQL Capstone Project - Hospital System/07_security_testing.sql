USE hospital_db;

-- =====================================
-- TASK 16 : LIMITED USER ACCESS
-- =====================================

DROP USER IF EXISTS 'report_user'@'localhost';

CREATE USER 'report_user'@'localhost'
IDENTIFIED BY 'Report123';

GRANT SELECT ON hospital_db.* TO 'report_user'@'localhost';

FLUSH PRIVILEGES;

-- Login as report_user and run these

SELECT * FROM patients LIMIT 5;

UPDATE patients
SET first_name = 'Test'
WHERE patient_id = 1;

SELECT * FROM patients;

-- =====================================
-- TASK 17 : SQL INJECTION
-- =====================================

-- Normal Search
SELECT *
FROM patients
WHERE first_name = 'John';

-- Unsafe Search (SQL Injection)
SELECT *
FROM patients
WHERE first_name = '' OR '1'='1';


DELIMITER $$

DROP PROCEDURE IF EXISTS search_patient $$

CREATE PROCEDURE search_patient(IN p_name VARCHAR(50))
BEGIN
    SELECT *
    FROM patients
    WHERE first_name = p_name;
END $$

DELIMITER ;

-- Safe Search
CALL search_patient('John');

-- SQL Injection Attempt (Safe)
CALL search_patient("' OR '1'='1");