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

-- =====  Show the dummy data  =====

SELECT * FROM departments;
SELECT * FROM employees;  
SELECT * FROM salaries;

-- ===== EASY - Filtering + Limiting =====
use company_db;

-- Q1. Saare employees dikhao
SELECT emp_id, emp_name, dept_id, hire_date, email FROM employees;

dept_id-- Q2. Sirf IT department ke employees - dept_id = 2
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