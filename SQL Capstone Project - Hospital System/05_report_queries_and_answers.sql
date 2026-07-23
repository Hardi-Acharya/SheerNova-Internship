USE hospital_db;

-- =========================
-- TASK 13 : HOSPITAL REPORTS
-- =========================


-- 1. All appointments with patient and doctor name

SELECT 
a.appointment_id,
a.appointment_date,
a.status,
CONCAT(p.first_name,' ',p.last_name) AS patient_name,
CONCAT(d.first_name,' ',d.last_name) AS doctor_name
FROM appointments a
JOIN patients p ON a.patient_id=p.patient_id
JOIN doctors d ON a.doctor_id=d.doctor_id
ORDER BY a.appointment_date DESC;



-- 2. All doctors including doctors with no patients

SELECT
d.doctor_id,
CONCAT(d.first_name,' ',d.last_name) AS doctor_name,
dept.department_name,
COUNT(a.appointment_id) AS total_appointments
FROM doctors d
LEFT JOIN departments dept 
ON d.department_id=dept.department_id
LEFT JOIN appointments a
ON d.doctor_id=a.doctor_id
AND a.status='Completed'
GROUP BY d.doctor_id,d.first_name,d.last_name,dept.department_name
ORDER BY total_appointments DESC;



-- 3. Department revenue and hospital revenue share

SELECT
dept.department_name,
COALESCE(SUM(b.total_amount),0) AS department_revenue,

ROUND(
COALESCE(SUM(b.total_amount),0)*100/
NULLIF((SELECT SUM(total_amount)
FROM bills
WHERE bill_status='Paid'),0)
,2) AS revenue_share_percent

FROM departments dept
LEFT JOIN doctors d
ON dept.department_id=d.department_id
LEFT JOIN appointments a
ON d.doctor_id=a.doctor_id
LEFT JOIN bills b
ON a.appointment_id=b.appointment_id
AND b.bill_status='Paid'

GROUP BY dept.department_id,dept.department_name;



-- 4. Current month vs previous month revenue

SELECT

SUM(CASE
WHEN YEAR(bill_date)=YEAR(CURDATE())
AND MONTH(bill_date)=MONTH(CURDATE())
THEN total_amount ELSE 0 END) AS this_month_revenue,

SUM(CASE
WHEN YEAR(bill_date)=YEAR(CURDATE()-INTERVAL 1 MONTH)
AND MONTH(bill_date)=MONTH(CURDATE()-INTERVAL 1 MONTH)
THEN total_amount ELSE 0 END) AS last_month_revenue

FROM bills
WHERE bill_status='Paid';



-- 5. Hospital busiest appointment hour

SELECT
HOUR(created_at) AS hour,
COUNT(*) AS appointments
FROM appointments
GROUP BY HOUR(created_at)
ORDER BY appointments DESC
LIMIT 1;



-- 6. Doctors ranked by revenue inside department

SELECT
dept.department_name,
CONCAT(d.first_name,' ',d.last_name) AS doctor_name,
COALESCE(SUM(b.total_amount),0) AS revenue,

RANK() OVER(
PARTITION BY dept.department_id
ORDER BY SUM(b.total_amount) DESC
) AS rank_in_department

FROM doctors d
JOIN departments dept
ON d.department_id=dept.department_id
LEFT JOIN appointments a
ON d.doctor_id=a.doctor_id
LEFT JOIN bills b
ON a.appointment_id=b.appointment_id
AND b.bill_status='Paid'

GROUP BY 
dept.department_id,
dept.department_name,
d.doctor_id,
d.first_name,
d.last_name;



-- 7. Patient spending category

SELECT
p.patient_id,
CONCAT(p.first_name,' ',p.last_name) AS patient_name,

COALESCE(SUM(b.total_amount),0) AS total_spent,

CASE
WHEN COALESCE(SUM(b.total_amount),0)<5000
THEN 'Low'

WHEN COALESCE(SUM(b.total_amount),0)
BETWEEN 5000 AND 20000
THEN 'Medium'

ELSE 'High'
END AS category

FROM patients p
LEFT JOIN bills b
ON p.patient_id=b.patient_id
AND b.bill_status='Paid'

GROUP BY p.patient_id,p.first_name,p.last_name;



-- 8. Department Dashboard
-- department_id change karke dusra department dekh sakte hai

SELECT

dept.department_name,

COUNT(DISTINCT a.patient_id) AS patients_seen,

COALESCE(SUM(b.total_amount),0) AS revenue,

ROUND(AVG(b.total_amount),2) AS average_bill,

ROUND(
SUM(CASE WHEN a.status='Cancelled' THEN 1 ELSE 0 END)
*100/
NULLIF(COUNT(a.appointment_id),0)
,2) AS cancellation_rate

FROM departments dept

LEFT JOIN doctors d
ON dept.department_id=d.department_id

LEFT JOIN appointments a
ON d.doctor_id=a.doctor_id

LEFT JOIN bills b
ON a.appointment_id=b.appointment_id
AND b.bill_status='Paid'

WHERE dept.department_id=1

GROUP BY dept.department_id,dept.department_name;



-- =========================
-- TASK 14 : EMPTY MONTH FIX
-- =========================
-- Missing months ko bhi 0 revenue dikhayega


WITH RECURSIVE months AS
(
SELECT DATE_FORMAT(
CURDATE()-INTERVAL 11 MONTH,
'%Y-%m-01'
) AS month_start

UNION ALL

SELECT month_start+INTERVAL 1 MONTH
FROM months
WHERE month_start<DATE_FORMAT(CURDATE(),'%Y-%m-01')
)

SELECT

DATE_FORMAT(m.month_start,'%Y-%m') AS month,

COALESCE(SUM(b.total_amount),0) AS revenue

FROM months m

LEFT JOIN bills b
ON DATE_FORMAT(b.bill_date,'%Y-%m-01')=m.month_start
AND b.bill_status='Paid'

GROUP BY m.month_start
ORDER BY m.month_start;