USE hospital_db;

-- ============================
-- STEP 1 : Check data before backup
-- ============================

SELECT COUNT(*) AS total_patients_before FROM patients;
SELECT * FROM patients WHERE patient_id = 1;

-- ============================
-- STEP 2 : Take Backup
-- ============================
-- MySQL Workbench
-- Server -> Data Export
-- Select hospital_db
-- Export to Self-Contained File
-- Save as: hospital_db_backup.sql
-- Click Start Export

-- ============================
-- STEP 3 : Delete one record
-- ============================

DELETE FROM patients
WHERE patient_id = 1;

SELECT COUNT(*) AS total_patients_after_delete
FROM patients;

SELECT *
FROM patients
WHERE patient_id = 1;

-- ============================
-- STEP 4 : Restore Backup
-- ============================
-- Server -> Data Import
-- Import from Self-Contained File
-- Select hospital_db_backup.sql
-- Click Start Import

-- ============================
-- STEP 5 : Verify Recovery
-- ============================

SELECT COUNT(*) AS total_patients_after_restore
FROM patients;

