USE hospital_db;

-- ==========================
-- TASK 15 : PERFORMANCE TEST
-- ==========================
-- BEFORE INDEX
-- Query speed check using EXPLAIN

EXPLAIN
SELECT 
p.first_name,
p.last_name,
b.bill_date,
b.total_amount

FROM patients p
JOIN bills b
ON p.patient_id=b.patient_id

WHERE p.patient_id=101
AND b.bill_date>'2026-01-01';

-- Create Index to improve speed
CREATE INDEX idx_bills_patient_id
ON bills(patient_id);

CREATE INDEX idx_bills_bill_date
ON bills(bill_date);

-- AFTER INDEX
-- Same query again

EXPLAIN
SELECT 
p.first_name,
p.last_name,
b.bill_date,
b.total_amount

FROM patients p
JOIN bills b
ON p.patient_id=b.patient_id

WHERE p.patient_id=101
AND b.bill_date>'2026-01-01';

SHOW INDEX FROM bills;