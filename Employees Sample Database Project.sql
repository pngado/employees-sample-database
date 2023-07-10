/*
The Employees Sample Database consists of 4 million records in total, spread over 6 separate tables. 
Please refer to the employee-en.a4.pdf document for information on this dataset. 

Skills used: Joins, CTEs, Subqueries, Aggregate Functions, Stored Procedures
*/


--List 10 employees who started since 1999 
SELECT *
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) >= 1999
LIMIT 10;

--Count the number of female employees born between 1950 and 1960
SELECT count(emp_no)
FROM employees
WHERE EXTRACT(YEAR FROM birth_date) BETWEEN 1950 AND 1960
AND gender = 'F'; 

--Display the details and total salary of the employee with the id '10005' 
SELECT e.first_name, e.last_name, e.hire_date, sum(s.salary) AS salary_total
FROM employees AS e
INNER JOIN salaries AS s ON e.emp_no = s.emp_no
WHERE e.emp_no = '10005' AND s.to_date <= '1996-09-12';

--How many employees did Margareta Markovitch manage during his/her management term? 
WITH my_cte AS (
  SELECT 
    dept_emp.dept_no AS department_no, 
    dept_manager.from_date AS f_date, 
    dept_manager.to_date AS t_date
  FROM employees
  LEFT JOIN dept_manager ON employees.emp_no = dept_manager.emp_no
  INNER JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
  WHERE employees.first_name = 'Margareta' AND employees.last_name = 'Markovitch'
)
SELECT 
  count(dept_emp.emp_no) AS number_of_employees
FROM dept_emp
INNER JOIN my_cte ON dept_emp.emp_no = my_cte.department_no
WHERE dept_emp.dept_no = my_cte.department_no
AND dept_emp.from_date >= my_cte.f_date
AND dept_emp.to_date <= my_cte.t_date;

--Another way to count the number of Margaret Markovitch managed during his/her term, using subqueries
SELECT 
  count(dept_emp.emp_no) AS number_of_employees
FROM dept_emp, 
(SELECT 
    dept_emp.dept_no AS department_no, 
    dept_manager.from_date AS f_date, 
    dept_manager.to_date AS t_date
  FROM employees
  LEFT JOIN dept_manager ON employees.emp_no = dept_manager.emp_no
  INNER JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
  WHERE employees.first_name = 'Margareta' AND employees.last_name = 'Markovitch') AS emp_info
WHERE dept_emp.dept_no = emp_info.department_no
AND dept_emp.from_date >= emp_info.f_date
AND dept_emp.to_date <= emp_info.t_date;

--The total salary paid to each department between 1988-06-25 and 1989-06-25
SELECT sum(s.salary) AS salary, departments.dept_name AS department
FROM salaries AS s 
INNER JOIN dept_emp ON s.emp_no = dept_emp.emp_no
INNER JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE s.from_date = '1988-06-25' AND s.to_date = '1989-06-25'
GROUP BY department;

--Promote employee 10002 from 'Staff' to 'Senior Staff' 
UPDATE titles
SET to_date = now()
WHERE emp_no = '10002' AND title = 'Staff'; 

INSERT INTO titles
VALUES ('10002', 'Senior Staff', '2022-12-15', '9999-01-01');

--Add a new department 'Big Data & ML' and promote employee 29005 to the manager of this department 
INSERT INTO departments
VALUES ('d010', 'Big Data & ML');

INSERT INTO dept_manager
VALUES ('29005', 'd010', now(), '9999-01-01');

--Create a stored procedure which takes employee name as the input and displays their information 

DROP PROCEDURE IF EXISTS empInfo;

DELIMITER //

CREATE PROCEDURE empInfo(fullname varchar(50))
BEGIN 
    SELECT DISTINCT e.emp_no, CONCAT(e.first_name, ' ', e.last_name) AS full_name, e.gender, t.title, departments.dept_name, sum(s.salary) AS total_salary
    FROM employees AS e
    INNER JOIN titles AS t ON e.emp_no = t.emp_no
    INNER JOIN dept_emp ON e.emp_no = dept_emp.emp_no
    INNER JOIN departments ON dept_emp.dept_no = departments.dept_no
    INNER JOIN salaries AS s ON e.emp_no = s.emp_no
    WHERE CONCAT(e.first_name, ' ', e.last_name) = fullname
    GROUP BY e.emp_no, e.gender, full_name, t.title, departments.dept_name;
END //

DELIMITER ;

--execute the stored procedure 
CALL empInfo('Margareta Markovitch');

--Create a stored procedure to move employees between departments, with new roles and return their employee id, full name, gender, title, and new department name 
DROP PROCEDURE IF EXISTS move_dept; 

DELIMITER //

CREATE PROCEDURE move_dept (empno int, old_dept_no varchar(50), new_dept_no varchar(50))
BEGIN
    SELECT e.emp_no, CONCAT(e.first_name, ' ', e.last_name) AS full_name, e.gender, t.title, departments.dept_name
    FROM employees AS e
    INNER JOIN titles AS t ON e.emp_no = t.emp_no
    INNER JOIN dept_emp ON e.emp_no = dept_emp.emp_no
    INNER JOIN departments ON dept_emp.dept_no = departments.dept_no
    WHERE e.emp_no = empno; 
    
    UPDATE dept_emp 
    SET dept_no = new_dept_no
    WHERE dept_emp.emp_no = empno AND dept_no = old_dept_no; 
END //

DELIMITER ; 

--execute the stored procedure 
CALL move_dept('110022', 'd002', 'd003');
