-- Q-1. Display every employee with their department name.
USE company_db;
SELECT e.emp_id, e.emp_name, d.dept_name FROM employees e 
JOIN departments d ON e.dept_id = d.dept_id
order by emp_id;

-- Create project & employee_project table and insert data in it.
CREATE TABLE projects(
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100)
);

CREATE TABLE employee_projects(
    emp_id INT,
    project_id INT,
    PRIMARY KEY(emp_id, project_id),
    FOREIGN KEY(emp_id) REFERENCES employees(emp_id),
    FOREIGN KEY(project_id) REFERENCES projects(project_id)
);

INSERT INTO projects VALUES
(1,'E-Commerce Website'),
(2,'Banking System'),
(3,'Hospital Management'),
(4,'CRM Software'),
(5,'Inventory System');

INSERT INTO employee_projects VALUES
(1,1),(2,2),(3,3),(4,1),(5,2),(6,3),(7,4),(8,5),(9,1),(10,2),(12,3),(13,4),(14,5),(15,1),(16,2),(18,3),(19,4),(20,5);

-- Q-2. Display employees who are not assigned to any project. 
SELECT e.emp_id, e.emp_name FROM employees e
LEFT JOIN employee_projects ep
ON e.emp_id = ep.emp_id
WHERE ep.project_id IS NULL;

-- Q-3.Display all departments even if they have no employees. 
SELECT d.dept_id, d.dept_name, e.emp_id, e.emp_name
FROM departments d LEFT JOIN employees e ON d.dept_id = e.dept_id;

-- Q-4.Display every employee with all projects they are working on.
SELECT e.emp_id, e.emp_name, p.project_id, p.project_name FROM employees e
INNER JOIN employee_projects ep  ON e.emp_id= ep.emp_id
INNER JOIN projects p ON ep.project_id = p.project_id;

-- Q-7.Display project names with the number of assigned employees. 
SELECT p.project_name, COUNT(ep.emp_id) AS total_employees FROM projects p
INNER JOIN employee_projects ep
ON p.project_id = ep.project_id
GROUP BY p.project_id, p.project_name;

-- Q-5.Find employees earning more than the average salary. 
SELECT  e.emp_id, e.emp_name, s.salary FROM employees e
JOIN salaries s ON e.emp_id = s.emp_id
WHERE s.salary > (SELECT AVG(salary) FROM salaries);
    
-- Q-6.Find departments having more than five employees. 
SELECT d.dept_id, d.dept_name, COUNT(e.emp_id) AS total_employees FROM departments d
JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_id, d.dept_name
HAVING COUNT(e.emp_id) > 5;

-- Alter employees table and add manager_id column and give it foreign key  for Q-9
ALTER TABLE employees
ADD manager_id INT;

ALTER TABLE employees
ADD CONSTRAINT fk_manager
FOREIGN KEY (manager_id)
REFERENCES employees(emp_id);

UPDATE employees SET manager_id = NULL WHERE emp_id = 1;

-- Managers
UPDATE employees SET manager_id = 1 WHERE emp_id = 2;
UPDATE employees SET manager_id = 1 WHERE emp_id = 3;
UPDATE employees SET manager_id = 1 WHERE emp_id = 5;
UPDATE employees SET manager_id = 1 WHERE emp_id = 6;

-- IT Team
UPDATE employees SET manager_id = 2 WHERE emp_id = 4;
UPDATE employees SET manager_id = 2 WHERE emp_id = 7;
UPDATE employees SET manager_id = 2 WHERE emp_id = 13;
UPDATE employees SET manager_id = 2 WHERE emp_id = 18;

-- HR Team
UPDATE employees SET manager_id = 3 WHERE emp_id = 9;
UPDATE employees SET manager_id = 3 WHERE emp_id = 16;
UPDATE employees SET manager_id = 3 WHERE emp_id = 23;

-- Finance Team
UPDATE employees SET manager_id = 5 WHERE emp_id = 14;
UPDATE employees SET manager_id = 5 WHERE emp_id = 24;
UPDATE employees SET manager_id = 5 WHERE emp_id = 32;

-- Sales Team
UPDATE employees SET manager_id = 6 WHERE emp_id = 15;
UPDATE employees SET manager_id = 6 WHERE emp_id = 25;
UPDATE employees SET manager_id = 6 WHERE emp_id = 33;

ALTER TABLE projects
ADD dept_id INT;

ALTER TABLE projects
ADD CONSTRAINT fk_project_department
FOREIGN KEY (dept_id)
REFERENCES departments(dept_id);

UPDATE projects SET dept_id = 2 WHERE project_id = 1;
UPDATE projects SET dept_id = 5 WHERE project_id = 2;
UPDATE projects SET dept_id = 3 WHERE project_id = 3;
UPDATE projects SET dept_id = 4 WHERE project_id = 4;
UPDATE projects SET dept_id = 6 WHERE project_id = 5;

SELECT * FROM projects;
SELECT * FROM employees;

-- Q-10.Display every possible Employee–Project combination.
SELECT e.emp_id, e.emp_name, p.project_name FROM employees e
JOIN employee_projects ep ON e.emp_id = ep.emp_id
JOIN projects p ON ep.project_id = p.project_id;

-- Q-8.Find employees who belong to the same department and earn the same salary.
SELECT e1.emp_name, e2.emp_name, s1.salary
FROM employees e1
JOIN employees e2
    ON e1.dept_id = e2.dept_id
   AND e1.emp_id < e2.emp_id
JOIN salaries s1
    ON e1.emp_id = s1.emp_id
JOIN salaries s2
    ON e2.emp_id = s2.emp_id
   AND s1.salary = s2.salary;

-- Q-9.Find all employees hired after their department manager joined.
SELECT e.emp_name FROM employees e
JOIN employees m ON e.manager_id = m.emp_id
WHERE e.hire_date > m.hire_date;

-- Q-11.Find employees earning the highest salary in each department.
SELECT e.emp_name, e.dept_id, s.salary FROM employees e
JOIN salaries s ON e.emp_id = s.emp_id
WHERE s.salary = (
    SELECT MAX(s2.salary)
    FROM employees e2
    JOIN salaries s2
    ON e2.emp_id = s2.emp_id
    WHERE e2.dept_id = e.dept_id);

-- Q-12. Find departments whose average salary is greater than the company average.
SELECT d.dept_name, AVG(s.salary) AS avg_salary
FROM employees e JOIN salaries s ON e.emp_id = s.emp_id
JOIN departments d ON e.dept_id = d.dept_id
GROUP BY d.dept_name
HAVING AVG(s.salary) > (SELECT AVG(salary) FROM salaries ); 

-- Q-13. Find employees working on more projects than the company average.
SELECT e.emp_name,
       COUNT(ep.project_id) AS total_projects
FROM employees e
JOIN employee_projects ep ON e.emp_id = ep.emp_id
GROUP BY e.emp_id, e.emp_name
HAVING COUNT(ep.project_id) > (
    SELECT AVG(project_count)
    FROM (
        SELECT COUNT(project_id) AS project_count
        FROM employee_projects
        GROUP BY emp_id
    ) t
);

-- Q-14. Find employees who worked on every project in their department.
SELECT e.emp_id, e.emp_name
FROM employees e
WHERE NOT EXISTS ( SELECT p.project_id FROM projects p WHERE p.dept_id = e.dept_id
    AND NOT EXISTS (
        SELECT 1
        FROM employee_projects ep
        WHERE ep.emp_id = e.emp_id
        AND ep.project_id = p.project_id )
);

-- Q-19. Display employee names in uppercase with their joining year.
 SELECT UPPER(emp_name),
YEAR(hire_date) AS joining_year FROM employees; 
 
-- Q-15. Display employees whose salary is greater than their manager's salary.
SELECT e.emp_name
FROM employees e
JOIN employees m
ON e.manager_id = m.emp_id
JOIN salaries s
ON e.emp_id = s.emp_id
JOIN salaries ms
ON m.emp_id = ms.emp_id
WHERE s.salary > ms.salary;

-- Q-16. Combine active and inactive employee lists.
-- Add the status column in employeee table -- 
ALTER TABLE employees
ADD status VARCHAR(10);

-- add status into employee table
UPDATE employees SET status = 'Active' WHERE emp_id = 1;
UPDATE employees SET status = 'Inactive' WHERE emp_id = 2;
UPDATE employees SET status = 'Active' WHERE emp_id = 3;
UPDATE employees SET status = 'Active' WHERE emp_id = 4;
UPDATE employees SET status = 'Inactive' WHERE emp_id = 5;
UPDATE employees SET status = 'Active' WHERE emp_id = 6;
UPDATE employees SET status = 'Inactive' WHERE emp_id = 7;
UPDATE employees SET status = 'Active' WHERE emp_id = 8;
UPDATE employees SET status = 'Active' WHERE emp_id = 9;
UPDATE employees SET status = 'Inactive' WHERE emp_id = 10;
UPDATE employees SET status = 'Active' WHERE emp_id = 11;
UPDATE employees SET status = 'Inactive' WHERE emp_id = 12;
UPDATE employees SET status = 'Active' WHERE emp_id = 13;
UPDATE employees SET status = 'Active' WHERE emp_id = 14;
UPDATE employees SET status = 'Inactive' WHERE emp_id = 15;
UPDATE employees SET status = 'Active' WHERE emp_id = 16;
UPDATE employees SET status = 'Inactive' WHERE emp_id = 17;
UPDATE employees SET status = 'Active' WHERE emp_id = 18;
UPDATE employees SET status = 'Active' WHERE emp_id = 19;
UPDATE employees SET status = 'Inactive' WHERE emp_id = 20;
UPDATE employees SET status = 'Active' WHERE emp_id = 21;
UPDATE employees SET status = 'Inactive' WHERE emp_id = 22;
UPDATE employees SET status = 'Active' WHERE emp_id = 23;
UPDATE employees SET status = 'Active' WHERE emp_id = 24;
UPDATE employees SET status = 'Inactive' WHERE emp_id = 25;
UPDATE employees SET status = 'Active' WHERE emp_id = 26;
UPDATE employees SET status = 'Inactive' WHERE emp_id = 27;
UPDATE employees SET status = 'Active' WHERE emp_id = 28;
UPDATE employees SET status = 'Active' WHERE emp_id = 29;
UPDATE employees SET status = 'Inactive' WHERE emp_id = 30;
UPDATE employees SET status = 'Active' WHERE emp_id = 31;
UPDATE employees SET status = 'Inactive' WHERE emp_id = 32;
UPDATE employees SET status = 'Active' WHERE emp_id = 33;
UPDATE employees SET status = 'Active' WHERE emp_id = 34;
UPDATE employees SET status = 'Inactive' WHERE emp_id = 35;
UPDATE employees SET status = 'Active' WHERE emp_id = 36;
UPDATE employees SET status = 'Inactive' WHERE emp_id = 37;
UPDATE employees SET status = 'Active' WHERE emp_id = 38;
UPDATE employees SET status = 'Active' WHERE emp_id = 39;
UPDATE employees SET status = 'Inactive' WHERE emp_id = 40;
UPDATE employees SET status = 'Active' WHERE emp_id = 41;
UPDATE employees SET status = 'Inactive' WHERE emp_id = 42;
UPDATE employees SET status = 'Active' WHERE emp_id = 43;
UPDATE employees SET status = 'Active' WHERE emp_id = 44;
UPDATE employees SET status = 'Inactive' WHERE emp_id = 45;
UPDATE employees SET status = 'Active' WHERE emp_id = 46;
UPDATE employees SET status = 'Inactive' WHERE emp_id = 47;
UPDATE employees SET status = 'Active' WHERE emp_id = 48;
UPDATE employees SET status = 'Active' WHERE emp_id = 49;
UPDATE employees SET status = 'Inactive' WHERE emp_id = 50;
 
SELECT emp_id, emp_name, status FROM employees WHERE status = 'Active'
UNION
SELECT emp_id, emp_name, status FROM employees WHERE status = 'Inactive'; 

-- Q-17. Find employees present in both Project A and Project B.
SELECT emp_id FROM employee_projects
WHERE project_id = 1 AND emp_id IN
(
 SELECT emp_id
 FROM employee_projects
 WHERE project_id = 2
); 

-- Q-18. Find employees assigned to Project A but not Project B.
SELECT e.emp_name FROM employees e
JOIN employee_projects ep
ON e.emp_id = ep.emp_id
WHERE ep.project_id = 1
AND e.emp_id NOT IN
(
    SELECT emp_id
    FROM employee_projects
    WHERE project_id = 2
);

-- Q-20. Calculate each employee's tenure in years.
SELECT emp_id, emp_name,
YEAR(CURDATE()) - YEAR(hire_date) AS tenure FROM employees;

-- Q-21. Create employee email IDs using first name and last name.
SELECT emp_name,
       LOWER(REPLACE(emp_name, ' ', '.')) AS employee_email
FROM employees;

-- Q-22. Categorize salaries a. Below 30,000 → Low b. 30,000–60,000 → Medium c. Above 60,000 → High.
SELECT e.emp_name,s.salary,
       CASE
         WHEN s.salary < 30000 THEN 'Low'
         WHEN s.salary <= 60000 THEN 'Medium'
         ELSE 'High'
       END AS Salary_Category
FROM employees e JOIN salaries s ON e.emp_id = s.emp_id; 

-- Q-23.Rank employees by salary within each department.
SELECT e.emp_name, s.salary,
RANK() OVER(PARTITION BY e.dept_id ORDER BY s.salary DESC) AS salary_rank
FROM employees e
JOIN salaries s ON e.emp_id = s.emp_id;

-- Q-24. Find the second highest salary in every department using a Window Function.
SELECT emp_name, dept_name, salary
FROM (
  SELECT e.emp_name,
         d.dept_name,
         s.salary,
         DENSE_RANK() OVER(PARTITION BY d.dept_name ORDER BY s.salary DESC) AS rnk
  FROM employees e
  JOIN salaries s ON e.emp_id = s.emp_id
  JOIN departments d ON e.dept_id = d.dept_id
) t
WHERE rnk = 2;

-- Q-25.25. Generate a Department Analytics Report containing:
-- ● Department Name
-- ● Total Employees
-- -- ● Average Salary
-- ● Highest Salary
-- ● Lowest Salary
-- ● Number of Projects
-- ● Employees without Projects
-- ● Highest Paid Employee
-- ● Salary Rank within Department
-- ● Department Expense Running Total
-- ● Salary Quartile using NTILE(4)

WITH department_report AS(
SELECT d.dept_id,d.dept_name,e.emp_id,e.emp_name,s.salary,ep.project_id,
COUNT(e.emp_id) OVER(PARTITION BY d.dept_id) total_employees,
AVG(s.salary) OVER(PARTITION BY d.dept_id) average_salary,
MAX(s.salary) OVER(PARTITION BY d.dept_id) highest_salary,
MIN(s.salary) OVER(PARTITION BY d.dept_id) lowest_salary,
(SELECT COUNT(DISTINCT ep2.project_id)
 FROM employee_projects ep2
 JOIN employees e2
 ON ep2.emp_id=e2.emp_id
 WHERE e2.dept_id=d.dept_id) number_of_projects,
CASE WHEN ep.project_id IS NULL THEN 1 ELSE 0 END employee_without_project,
FIRST_VALUE(e.emp_name) OVER(
PARTITION BY d.dept_id
ORDER BY s.salary DESC
) highest_paid_employee,
RANK() OVER(PARTITION BY d.dept_id ORDER BY s.salary DESC) salary_rank,
SUM(s.salary) OVER(
PARTITION BY d.dept_id
ORDER BY s.salary DESC
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
) department_expense_running_total,
NTILE(4) OVER(PARTITION BY d.dept_id ORDER BY s.salary DESC) salary_quartile
FROM departments d
JOIN employees e
ON d.dept_id=e.dept_id
JOIN salaries s
ON s.emp_id=e.emp_id
LEFT JOIN employee_projects ep
ON ep.emp_id=e.emp_id
)
SELECT dept_name,emp_name,salary,total_employees,
ROUND(average_salary,2) average_salary,
highest_salary,lowest_salary,
number_of_projects,
SUM(employee_without_project) OVER(PARTITION BY dept_id) employees_without_projects,
highest_paid_employee,salary_rank,
department_expense_running_total,salary_quartile
FROM department_report
ORDER BY dept_name,salary_rank,emp_name;


-- Q-1. Employees who worked on every project in their department.
SELECT e.emp_name FROM employees e
WHERE NOT EXISTS ( SELECT * FROM employee_projects ep WHERE ep.emp_id = e.emp_id);

-- Q-2. Projects with zero employees assigned.
SELECT project_name FROM projects p
WHERE NOT EXISTS ( SELECT * FROM employee_projects ep WHERE ep.project_id = p.project_id );

-- Q-3. Employees with zero assigned projects.
SELECT e.emp_id, e.emp_name FROM employees e
LEFT JOIN employee_projects ep ON e.emp_id = ep.emp_id WHERE ep.emp_id IS NULL;

-- Q-4. Find salary decreases using LAG()
SELECT emp_id,salary,prev_salary FROM(
SELECT emp_id,salary,LAG(salary)OVER(ORDER BY from_date)prev_salary
FROM salaries)x WHERE salary<prev_salary;

-- Q-5. Running monthly department expense using SUM() OVER().
SELECT e.dept_id, SUM(s.salary) AS total_expense
FROM employees e
JOIN salaries s
ON e.emp_id = s.emp_id
GROUP BY e.dept_id;

-- Q-6. Find consecutive(one after another, without interruption) salary increase streaks (Gaps & Islands).
SELECT emp_id, from_date, salary,
 LAG(salary) OVER(
 PARTITION BY emp_id
 ORDER BY from_date
 ) AS previous_salary
FROM salaries; 


-- Q-7. Divide employees into salary quartiles using NTILE(4).
SELECT e.emp_name, s.salary,
 NTILE(4) OVER(ORDER BY s.salary DESC) AS salary_quartile
FROM employees e JOIN salaries s ON e.emp_id = s.emp_id; 

-- Q-8. Compare JOIN vs EXISTS performance.
-- Using JOIN
SELECT DISTINCT e.emp_id, e.emp_name
FROM employees e
JOIN employee_projects ep
ON e.emp_id = ep.emp_id; 

-- Using EXISTS 
SELECT e.emp_id, e.emp_name FROM employees e
WHERE EXISTS ( SELECT * FROM employee_projects ep WHERE ep.emp_id = e.emp_id ); 

-- Q-9. Rewrite five subqueries using joins.
-- Q-9.1 .1. Employees earning more than the average salary.
SELECT e.emp_id, e.emp_name
FROM employees e
JOIN salaries s
ON e.emp_id = s.emp_id
WHERE s.salary > ( SELECT AVG(salary) FROM salaries );

-- Q-9.2. Highest salary in each department.
SELECT e.emp_name, s.salary
FROM employees e
JOIN salaries s
ON e.emp_id = s.emp_id
JOIN (
    SELECT e.dept_id, MAX(s.salary) AS max_salary
    FROM employees e
    JOIN salaries s
    ON e.emp_id = s.emp_id
    GROUP BY e.dept_id
) m
ON e.dept_id = m.dept_id
AND s.salary = m.max_salary;

-- Q-9.3. Find employees who are assigned to at least one project.
SELECT emp_name FROM employees
WHERE emp_id IN ( SELECT emp_id FROM employee_projects );

-- Q-9.4. Find employees earning less than the highest salary.
SELECT e.emp_name
FROM employees e JOIN salaries s ON e.emp_id = s.emp_id
WHERE s.salary < (
    SELECT MAX(salary)
    FROM salaries
);

-- Q-9.5. Find departments that have at least one employee earning more than 90,000.
SELECT dept_name FROM departments
WHERE dept_id IN (
    SELECT e.dept_id
    FROM employees e
    JOIN salaries s
    ON e.emp_id = s.emp_id
    WHERE s.salary > 90000
);

-- Q-10.Build a complete Department Dashboard using a single SQL query.
WITH department_dashboard AS
(
SELECT d.dept_name,
e.emp_id,
e.emp_name,
s.salary,
ep.project_id,
RANK() OVER(
PARTITION BY d.dept_id
ORDER BY s.salary DESC
) salary_rank,
NTILE(4) OVER(
PARTITION BY d.dept_id
ORDER BY s.salary DESC
) salary_quartile,
SUM(s.salary) OVER(
PARTITION BY d.dept_id
ORDER BY s.salary
) department_expense
FROM departments d
LEFT JOIN employees e
ON d.dept_id=e.dept_id
LEFT JOIN salaries s
ON e.emp_id=s.emp_id
LEFT JOIN employee_projects ep
ON e.emp_id=ep.emp_id
)
SELECT dept_name,
COUNT(DISTINCT emp_id) total_employees,
ROUND(AVG(salary),2) average_salary,
MAX(salary) highest_salary,
MIN(salary) lowest_salary,
COUNT(DISTINCT project_id) number_of_projects,
COUNT(DISTINCT CASE
WHEN project_id IS NULL THEN emp_id
END) employees_without_projects,
MAX(CASE
WHEN salary_rank=1 THEN emp_name
END) highest_paid_employee,
MAX(department_expense) department_expense,
MAX(salary_rank) salary_rank,
MAX(salary_quartile) salary_quartile
FROM department_dashboard
GROUP BY dept_name
ORDER BY dept_name;