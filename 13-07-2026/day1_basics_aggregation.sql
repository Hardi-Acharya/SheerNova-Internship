CREATE DATABASE company_db;
USE company_db;

CREATE TABLE departments (
dept_id INT PRIMARY KEY,
dept_name VARCHAR(50),
location VARCHAR(50)
);

CREATE TABLE employees (
emp_id INT PRIMARY KEY,
emp_name VARCHAR(100),
dept_id INT,
hire_date DATE,
email VARCHAR(100),
FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

CREATE TABLE salaries (
salary_id INT PRIMARY KEY AUTO_INCREMENT,
emp_id INT,
salary DECIMAL(10,2),
from_date DATE,
to_date DATE,
FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);


-- 1. DEPARTMENTS - 10 rows
INSERT INTO departments (dept_id, dept_name, location) VALUES
(1, 'HR', 'Mumbai'),
 (2, 'IT', 'Pune'), 
 (3, 'Sales', 'Delhi'), 
(4, 'Marketing', 'Bangalore'), 
(5, 'Finance', 'Chennai'),
(6, 'Operations', 'Hyderabad'),
 (7, 'Support', 'Noida'), 
(8, 'R&D', 'Gurgaon'), 
(9, 'Admin', 'Kolkata'),
 (10, 'Legal', 'Ahmedabad');

-- 2. EMPLOYEES - 50 rows. Yaha date fix hai row 42
INSERT INTO employees (emp_id, emp_name, dept_id, hire_date, email) VALUES
(1, 'Amit Sharma', 1, '2022-01-15', 'amit@co.com'),
(2, 'Priya Verma', 2, '2021-03-10', 'priya@co.com'),
(3, 'Rahul Singh', 3, '2023-05-20', 'rahul@co.com'),
(4, 'Sneha Patel', 2, '2020-11-05', NULL),
(5, 'Vikas Gupta', 4, '2022-07-12', 'vikas@co.com'),
(6, 'Anjali Mehta', 5, '2023-01-30', NULL),
(7, 'Rohit Kumar', 2, '2021-09-18', 'rohit@co.com'),
(8, 'Pooja Reddy', 6, '2022-04-22', 'pooja@co.com'),
(9, 'Karan Joshi', 3, '2023-08-01', 'karan@co.com'),
(10, 'Neha Jain', 1, '2020-06-14', 'neha@co.com'),
(11, 'Suresh Rao', 7, '2021-12-25', NULL),
(12, 'Divya Nair', 8, '2022-02-11', 'divya@co.com'),
(13, 'Manish Tiwari', 2, '2023-03-05', 'manish@co.com'),
(14, 'Kavita Das', 4, '2021-07-19', NULL),
(15, 'Arjun Iyer', 5, '2022-10-10', 'arjun@co.com'),
(16, 'Riya Saxena', 3, '2023-06-17', 'riya@co.com'),
(17, 'Deepak Malhotra', 9, '2020-08-30', NULL),
(18, 'Simran Kaur', 2, '2021-04-04', 'simran@co.com'),
(19, 'Nitin Bansal', 6, '2022-12-12', 'nitin@co.com'),
(20, 'Tanvi Agarwal', 1, '2023-09-09', 'tanvi@co.com'),
(21, 'Mohit Sinha', 10, '2021-01-21', NULL),
(22, 'Shreya Bose', 2, '2022-05-25', 'shreya@co.com'),
(23, 'Aman Khan', 3, '2023-02-28', 'aman@co.com'),
(24, 'Ishita Roy', 4, '2020-09-15', NULL),
(25, 'Varun Chopra', 5, '2021-11-11', 'varun@co.com'),
(26, 'Ananya Mishra', 2, '2022-08-08', 'ananya@co.com'),
(27, 'Siddharth Gill', 7, '2023-04-19', NULL),
(28, 'Muskan Ali', 8, '2021-06-06', 'muskan@co.com'),
(29, 'Harsh Vardhan', 3, '2022-03-14', 'harsh@co.com'),
(30, 'Ritika Pandey', 1, '2023-07-07', NULL),
(31, 'Yash Dubey', 2, '2020-12-01', 'yash@co.com'),
(32, 'Aishwarya Bhat', 4, '2021-08-22', 'aish@co.com'),
(33, 'Prateek Jain', 5, '2022-01-05', NULL),
(34, 'Swati Kulkarni', 6, '2023-05-16', 'swati@co.com'),
(35, 'Abhishek Yadav', 2, '2021-10-10', 'abhi@co.com'),
(36, 'Kritika Sharma', 9, '2022-11-30', NULL),
(37, 'Rajat Singhania', 3, '2023-03-21', 'rajat@co.com'),
(38, 'Payal Mehra', 2, '2020-07-25', 'payal@co.com'),
(39, 'Nikhil Desai', 4, '2021-05-13', NULL),
(40, 'Sonam Gupta', 5, '2022-09-09', 'sonam@co.com'),
(41, 'Faizan Ahmed', 2, '2023-01-17', 'faizan@co.com'),
(42, 'Bhavna Seth', 7, '2021-02-28', NULL),  
(43, 'Gaurav Nanda', 8, '2022-06-18', 'gaurav@co.com'),
(44, 'Tanya Kapoor', 3, '2023-08-08', 'tanya@co.com'),
(45, 'Chirag Malhotra', 2, '2020-04-04', NULL),
(46, 'Pallavi Joshi', 1, '2021-12-12', 'pallavi@co.com'),
(47, 'Akash Verma', 4, '2022-10-25', 'akash@co.com'),
(48, 'Shruti Rane', 5, '2023-06-30', NULL),
(49, 'Devendra Singh', 2, '2021-03-03', 'dev@co.com'),
(50, 'Rashmi Iyer', 6, '2022-07-07', 'rashmi@co.com');

-- 3. SALARIES - 50 rows
INSERT INTO salaries (emp_id, salary, from_date, to_date) VALUES
(1, 45000, '2022-01-15', '2024-12-31'), 
(2, 85000, '2021-03-10', '2024-12-31'),
(3, 55000, '2023-05-20', '2024-12-31'), 
(4, 90000, '2020-11-05', '2024-12-31'),
(5, 60000, '2022-07-12', '2024-12-31'), 
(6, 75000, '2023-01-30', '2024-12-31'),
(7, 95000, '2021-09-18', '2024-12-31'),
 (8, 50000, '2022-04-22', '2024-12-31'),
(9, 58000, '2023-08-01', '2024-12-31'), 
(10, 47000, '2020-06-14', '2024-12-31'),
(11, 40000, '2021-12-25', '2024-12-31'), 
(12, 110000, '2022-02-11', '2024-12-31'),
(13, 88000, '2023-03-05', '2024-12-31'), 
(14, 62000, '2021-07-19', '2024-12-31'),
(15, 80000, '2022-10-10', '2024-12-31'),
(16, 56000, '2023-06-17', '2024-12-31'),
(17, 42000, '2020-08-30', '2024-12-31'), 
(18, 92000, '2021-04-04', '2024-12-31'),
(19, 52000, '2022-12-12', '2024-12-31'),
 (20, 46000, '2023-09-09', '2024-12-31'),
(21, 70000, '2021-01-21', '2024-12-31'), 
(22, 87000, '2022-05-25', '2024-12-31'),
(23, 54000, '2023-02-28', '2024-12-31'),
 (24, 61000, '2020-09-15', '2024-12-31'),
(25, 78000, '2021-11-11', '2024-12-31'), 
(26, 91000, '2022-08-08', '2024-12-31'),
(27, 41000, '2023-04-19', '2024-12-31'), 
(28, 105000, '2021-06-06', '2024-12-31'),
(29, 57000, '2022-03-14', '2024-12-31'), 
(30, 48000, '2023-07-07', '2024-12-31'),
(31, 89000, '2020-12-01', '2024-12-31'), 
(32, 63000, '2021-08-22', '2024-12-31'),
(33, 76000, '2022-01-05', '2024-12-31'),
 (34, 51000, '2023-05-16', '2024-12-31'),
(35, 93000, '2021-10-10', '2024-12-31'), 
(36, 43000, '2022-11-30', '2024-12-31'),
(37, 59000, '2023-03-21', '2024-12-31'),
 (38, 86000, '2020-07-25', '2024-12-31'),
(39, 64000, '2021-05-13', '2024-12-31'),
 (40, 79000, '2022-09-09', '2024-12-31'),
(41, 94000, '2023-01-17', '2024-12-31'), 
(42, 40500, '2021-02-28', '2024-12-31'), 
(43, 108000, '2022-06-18', '2024-12-31'), 
(44, 53000, '2023-08-08', '2024-12-31'),
(45, 97000, '2020-04-04', '2024-12-31'), 
(46, 49000, '2021-12-12', '2024-12-31'),
(47, 65000, '2022-10-25', '2024-12-31'), 
(48, 77000, '2023-06-30', '2024-12-31'),
(49, 88000, '2021-03-03', '2024-12-31'),
 (50, 53000, '2022-07-07', '2024-12-31');

-- ===== EASY - Filtering + Limiting =====
use company_db;

-- Q1. Saare employees dikhao
SELECT emp_id, emp_name, dept_id, hire_date, email FROM employees;

-- Q2. Sirf IT department ke employees - dept_id = 2
SELECT emp_id, emp_name, hire_date 
FROM employees WHERE dept_id = 2;

-- Q3. Jinki salary 80000 se zyada hai
SELECT e.emp_id, e.emp_name, s.salary 
FROM employees e JOIN salaries s ON e.emp_id = s.emp_id
WHERE s.salary > 80000;

-- Q4. Jinka email NULL hai
SELECT emp_id, emp_name, dept_id FROM employees WHERE email IS NULL;

-- Q5. Pehle 10 employees dikhao
SELECT emp_id, emp_name, hire_date FROM employees LIMIT 10;

-- ===== MEDIUM - Sorting + Filtering =====
-- Q6. Salary ke hisaab se sabse zyada wale 5
SELECT e.emp_id, e.emp_name, s.salary
FROM employees e JOIN salaries s ON e.emp_id = s.emp_id
ORDER BY s.salary DESC LIMIT 5;

-- Q7. Sabse naye join kiye 5 employees
SELECT emp_id, emp_name, hire_date FROM employees ORDER BY hire_date DESC LIMIT 5;

-- Q8. 'A' se shuru hone wale naam
SELECT emp_id, emp_name, email FROM employees WHERE emp_name LIKE 'A%';

-- Q9. Salary 50000 se 70000 ke beech
SELECT e.emp_id, e.emp_name, s.salary
FROM employees e JOIN salaries s ON e.emp_id = s.emp_id
WHERE s.salary BETWEEN 50000 AND 70000;

-- Q10. 2022 me join kiye hue employees
SELECT emp_id, emp_name, hire_date FROM employees WHERE YEAR(hire_date) = 2022;

-- Q11. HR aur IT department ke employees
SELECT emp_id, emp_name, dept_id FROM employees WHERE dept_id IN (1, 2);

-- Q12. Name ke hisaab se A to Z sort
SELECT emp_id, emp_name, hire_date FROM employees ORDER BY emp_name ASC;

-- Q13. Sabse kam salary wale 3 employee
SELECT e.emp_id, e.emp_name, s.salary
FROM employees e JOIN salaries s ON e.emp_id = s.emp_id
ORDER BY s.salary ASC LIMIT 3;

-- Q14. Jinki hire_date 2021-01-01 ke baad hai
SELECT emp_id, emp_name, hire_date FROM employees WHERE hire_date > '2021-01-01';

-- Q15. Email hai unke naam
SELECT emp_id, emp_name, email FROM employees WHERE email IS NOT NULL;


-- Q16. Employee ka naam + uska department ka naam
SELECT e.emp_id, e.emp_name, d.dept_name 
FROM employees e JOIN departments d ON e.dept_id = d.dept_id;

-- Q17. Har department me kitne employee hain
SELECT d.dept_id, d.dept_name, COUNT(e.emp_id) AS Total_Emp
FROM departments d LEFT JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_id, d.dept_name;

-- Q18. Employee + Department + Salary ek saath
SELECT e.emp_id, e.emp_name, d.dept_name, s.salary
FROM employees e 
JOIN departments d ON e.dept_id = d.dept_id
JOIN salaries s ON e.emp_id = s.emp_id
LIMIT 10;

-- Q19. Sabse purane 5 employees
SELECT emp_id, emp_name, hire_date FROM employees ORDER BY hire_date ASC LIMIT 5;

-- Q20. Pune me kaun sa department hai
SELECT dept_id, dept_name, location FROM departments WHERE location = 'Pune';

-- Q21. Salary +10% increment ke baad kitni hogi
SELECT e.emp_id, e.emp_name, s.salary, ROUND(s.salary * 1.1, 0) AS New_Salary
FROM employees e JOIN salaries s ON e.emp_id = s.emp_id
LIMIT 10;

-- Q22. Delhi me kaun kaun se department hain
SELECT dept_id, dept_name FROM departments WHERE location = 'Delhi';

-- Q23. 90000 se zyada salary wale
SELECT e.emp_id, e.emp_name, s.salary
FROM employees e JOIN salaries s ON e.emp_id = s.emp_id
WHERE s.salary > 90000;

-- Q24. Email nahi hai aur 2023 me join kiye
SELECT emp_id, emp_name, hire_date 
FROM employees 
WHERE email IS NULL AND YEAR(hire_date) = 2023;

-- Q25. Har location me kitne department
SELECT location, COUNT(dept_id) AS No_of_Dept 
FROM departments 
GROUP BY location;

-- ===== NULL handling  =====

-- Q1. Jinke paas email nahi hai unke naam dikhao
SELECT emp_name, dept_id 
FROM employees 
WHERE email IS NULL;

-- Q2. Jinke paas email hai unke naam + email dikhao
SELECT emp_id, emp_name, email 
FROM employees 
WHERE email IS NOT NULL;

-- Q3. Kitne employees ka email NULL hai - COUNT
SELECT COUNT(*) AS Total_Without_Email
FROM employees
WHERE email IS NULL;

-- Q4. Email nahi hai aur wo IT department me hain
SELECT emp_id, emp_name, hire_date 
FROM employees 
WHERE email IS NULL AND dept_id = 2;

-- Q5. Email hai aur unko hire_date ke hisaab se sort karo - naye upar
SELECT emp_id, emp_name, email, hire_date
FROM employees
WHERE email IS NOT NULL
ORDER BY hire_date DESC;

-- =====  20 aggregation queries on employees/salaries =====

-- ===== COUNT - Ginti nikalna =====
-- Q1. Total kitne employees hain
SELECT COUNT(emp_id) AS Total_Employees FROM employees;

-- Q2. Har department me kitne employee hain
SELECT d.dept_id, d.dept_name, COUNT(e.emp_id) AS Total_Emp
FROM departments d LEFT JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_id, d.dept_name;

-- Q3. Kitne employees ka email hai
SELECT COUNT(emp_id) AS Employees_With_Email 
FROM employees WHERE email IS NOT NULL;

-- Q4. Kitne employees ka email nahi hai
SELECT COUNT(emp_id) AS Employees_Without_Email 
FROM employees WHERE email IS NULL;

-- Q5. Har location me kitne department hain
SELECT location, COUNT(dept_id) AS No_of_Dept 
FROM departments GROUP BY location;

-- ===== SUM - Total jodna =====
-- Q6. Company ki total salary payout kitni hai
SELECT SUM(salary) AS Total_Salary FROM salaries;

-- Q7. Har department ki total salary
SELECT d.dept_id, d.dept_name, SUM(s.salary) AS Total_Dept_Salary
FROM employees e 
JOIN departments d ON e.dept_id = d.dept_id
JOIN salaries s ON e.emp_id = s.emp_id
GROUP BY d.dept_id, d.dept_name;

-- Q8. IT department ki total salary - dept_id = 2
SELECT SUM(s.salary) AS IT_Total_Salary
FROM employees e JOIN salaries s ON e.emp_id = s.emp_id
WHERE e.dept_id = 2;

-- ===== AVG - Average nikalna =====
-- Q9. Company ki average salary kitni hai
SELECT AVG(salary) AS Avg_Salary FROM salaries;

-- Q10. Har department ki average salary
SELECT d.dept_id, d.dept_name, ROUND(AVG(s.salary), 2) AS Avg_Dept_Salary
FROM employees e 
JOIN departments d ON e.dept_id = d.dept_id
JOIN salaries s ON e.emp_id = s.emp_id
GROUP BY d.dept_id, d.dept_name;

-- Q11. 2022 me join kiye hue employees ki average salary
SELECT ROUND(AVG(s.salary), 2) AS Avg_Salary_2022
FROM employees e JOIN salaries s ON e.emp_id = s.emp_id
WHERE YEAR(e.hire_date) = 2022;

-- ===== MAX, MIN - Sabse zyada / Sabse kam =====
-- Q12. Sabse zyada salary kitni hai
SELECT MAX(salary) AS Highest_Salary FROM salaries;

-- Q13. Sabse kam salary kitni hai
SELECT MIN(salary) AS Lowest_Salary FROM salaries;

-- Q14. Har department me sabse zyada salary
SELECT d.dept_id, d.dept_name, MAX(s.salary) AS Max_Salary
FROM employees e 
JOIN departments d ON e.dept_id = d.dept_id
JOIN salaries s ON e.emp_id = s.emp_id
GROUP BY d.dept_id, d.dept_name;

-- Q15. Har department me sabse kam salary
SELECT d.dept_id, d.dept_name, MIN(s.salary) AS Min_Salary
FROM employees e 
JOIN departments d ON e.dept_id = d.dept_id
JOIN salaries s ON e.emp_id = s.emp_id
GROUP BY d.dept_id, d.dept_name;

-- ===== MIXED - GROUP BY + ORDER BY + LIMIT =====
-- Q16. Top 3 departments jinme sabse zyada employee hain
SELECT d.dept_id, d.dept_name, COUNT(e.emp_id) AS Emp_Count
FROM departments d JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_id, d.dept_name
ORDER BY Emp_Count DESC LIMIT 3;

-- Q17. Jinki salary average se zyada hai unki count
SELECT COUNT(e.emp_id) AS Above_Avg_Count
FROM employees e JOIN salaries s ON e.emp_id = s.emp_id
WHERE s.salary > (SELECT AVG(salary) FROM salaries);

-- Q18. Har saal kitne employees join hue
SELECT YEAR(hire_date) AS Join_Year, COUNT(emp_id) AS Total_Joined
FROM employees GROUP BY YEAR(hire_date) ORDER BY Join_Year;

-- Q19. Salary 50000 se 80000 ke beech kitne employee hain
SELECT COUNT(e.emp_id) AS Emp_Count
FROM employees e JOIN salaries s ON e.emp_id = s.emp_id
WHERE s.salary BETWEEN 50000 AND 80000;

-- Q20. Har department me kitne employees ki email hai
SELECT d.dept_id, d.dept_name, COUNT(e.emp_id) AS Emp_With_Email
FROM employees e 
JOIN departments d ON e.dept_id = d.dept_id
WHERE e.email IS NOT NULL
GROUP BY d.dept_id, d.dept_name;

-- =====  Highest Paid Employee per Department =====

SELECT e.emp_id, e.emp_name, d.dept_name, s.salary
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
JOIN salaries s ON e.emp_id = s.emp_id
WHERE (e.dept_id, s.salary) IN (
    SELECT e2.dept_id, MAX(s2.salary)
    FROM employees e2
    JOIN salaries s2 ON e2.emp_id = s2.emp_id
    GROUP BY e2.dept_id
)
ORDER BY d.dept_name;

-- =====  Average Salary per Department  =====

SELECT d.dept_id, d.dept_name, ROUND(AVG(s.salary), 2) AS Avg_Salary
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
JOIN salaries s ON e.emp_id = s.emp_id
GROUP BY d.dept_id, d.dept_name
ORDER BY Avg_Salary DESC;

-- =====Department with Most Employees  =====

SELECT d.dept_id, d.dept_name, COUNT(e.emp_id) AS Total_Employees
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_id, d.dept_name
ORDER BY Total_Employees DESC
LIMIT 1;

-- =====  10 queries combining WHERE + GROUP BY + HAVING  =====

-- Q1. 2022 ke baad join kiye, har dept me kitne. Jaha 2 se zyada ho
SELECT d.dept_id, d.dept_name, COUNT(e.emp_id) AS New_Hires
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
WHERE e.hire_date > '2022-01-01' -- 1. Pehle row filter
GROUP BY d.dept_id, d.dept_name -- 2. Group banao
HAVING COUNT(e.emp_id) > 2; -- 3. Group filter

-- Q2. Email wale employees, har location me. Jaha avg salary 70000 se zyada
SELECT d.location, COUNT(e.emp_id) AS Emp_Count, AVG(s.salary) AS Avg_Sal
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
JOIN salaries s ON e.emp_id = s.emp_id
WHERE e.email IS NOT NULL -- Email wale hi
GROUP BY d.location
HAVING AVG(s.salary) > 70000;

-- Q3. Salary 50000 se zyada, har dept ki max salary. Jaha max 90000 se zyada ho
SELECT d.dept_name, MAX(s.salary) AS Max_Salary
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
JOIN salaries s ON e.emp_id = s.emp_id
WHERE s.salary > 50000
GROUP BY d.dept_name
HAVING MAX(s.salary) > 90000;

-- Q4. 'A' se naam shuru, har saal kitne join hue. Jaha 3 se zyada ho
SELECT YEAR(e.hire_date) AS Join_Year, COUNT(e.emp_id) AS Total
FROM employees e
WHERE e.emp_name LIKE 'A%' -- Naam A se
GROUP BY YEAR(e.hire_date)
HAVING COUNT(e.emp_id) > 3;

-- Q5. HR aur IT dept, har dept me total salary. Jaha total 5 lakh se zyada
SELECT d.dept_name, SUM(s.salary) AS Total_Salary
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
JOIN salaries s ON e.emp_id = s.emp_id
WHERE e.dept_id IN (1, 2) -- HR=1, IT=2
GROUP BY d.dept_name
HAVING SUM(s.salary) > 500000;

-- Q6. Email nahi hai, har dept me kitne. Jaha 1 se zyada ho
SELECT d.dept_name, COUNT(e.emp_id) AS Without_Email
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
WHERE e.email IS NULL -- Email NULL
GROUP BY d.dept_name
HAVING COUNT(e.emp_id) > 1;

-- Q7. Mumbai aur Pune location, har location me avg salary. Jaha avg 60000 se kam
SELECT d.location, ROUND(AVG(s.salary), 2) AS Avg_Sal
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
JOIN salaries s ON e.emp_id = s.emp_id
WHERE d.location IN ('Mumbai', 'Pune')
GROUP BY d.location
HAVING AVG(s.salary) < 60000;

-- Q8. 2021 me join kiye, har dept ki min salary. Jaha min 40000 se zyada
SELECT d.dept_name, MIN(s.salary) AS Min_Salary
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
JOIN salaries s ON e.emp_id = s.emp_id
WHERE YEAR(e.hire_date) = 2021
GROUP BY d.dept_name
HAVING MIN(s.salary) > 40000;

-- Q9. Salary 80000 se kam, har dept me count. Jaha 5 se zyada employee ho
SELECT d.dept_name, COUNT(e.emp_id) AS Low_Paid_Count
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
JOIN salaries s ON e.emp_id = s.emp_id
WHERE s.salary < 80000
GROUP BY d.dept_name
HAVING COUNT(e.emp_id) > 5;

-- Q10. 'gmail' wale email, har dept me kitne. Jaha 2 se zyada ho
SELECT d.dept_name, COUNT(e.emp_id) AS Gmail_Users
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
WHERE e.email LIKE '%gmail%' -- Gmail wale
GROUP BY d.dept_name
HAVING COUNT(e.emp_id) > 2;

-- =====  Departments where Avg Salary > Company Avg Salary  =====

USE company_db;

SELECT d.dept_id, d.dept_name, ROUND(AVG(s.salary), 2) AS Dept_Avg_Salary
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
JOIN salaries s ON e.emp_id = s.emp_id
GROUP BY d.dept_id, d.dept_name  
HAVING AVG(s.salary) > (         
    SELECT AVG(salary)            
    FROM salaries
)
ORDER BY Dept_Avg_Salary DESC;

-- =====  Employees with Salary > 1.5x Dept Average  =====

SELECT e.emp_id, e.emp_name, d.dept_name, s.salary, 
       ROUND(dept_avg.Avg_Salary, 2) AS Dept_Avg, 
       ROUND(s.salary / dept_avg.Avg_Salary, 2) AS Ratio
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
JOIN salaries s ON e.emp_id = s.emp_id
JOIN (
    SELECT e2.dept_id, AVG(s2.salary) AS Avg_Salary
    FROM employees e2
    JOIN salaries s2 ON e2.emp_id = s2.emp_id
    GROUP BY e2.dept_id
) AS dept_avg ON e.dept_id = dept_avg.dept_id  
WHERE s.salary > 1.0 * dept_avg.Avg_Salary    
ORDER BY d.dept_name, s.salary DESC;  

-- =====  Per Department All Metrics  =====

SELECT 
    d.dept_id,
    d.dept_name,
    COUNT(e.emp_id) AS Headcount,              
    SUM(s.salary) AS Total_Payroll,           
    ROUND(AVG(s.salary), 2) AS Avg_Salary,     
    MIN(s.salary) AS Min_Salary,              
    MAX(s.salary) AS Max_Salary                
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id    
LEFT JOIN salaries s ON e.emp_id = s.emp_id
GROUP BY d.dept_id, d.dept_name                   
ORDER BY Total_Payroll DESC;