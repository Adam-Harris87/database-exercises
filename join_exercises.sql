USE join_example_db;

-- 1-1 Select all the records from both the users and roles tables.
SELECT * FROM users;
SELECT * FROM roles;

/* 1-2 Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. 
Before you run each query, guess the expected number of results.
JOIN will return 4 results
LEFT JOIN will return 6 results
RIGHT JOIN will return 5 results */
SELECT * FROM users u
	JOIN roles r
		ON u.role_id = r.id;
SELECT * FROM users u
	LEFT JOIN roles r
		ON u.role_id = r.id;
SELECT * FROM users u
	RIGHT JOIN roles r
		ON u.role_id = r.id;
        
/* 1-3 Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries.
Use count and the appropriate join type to get a list of roles along with the number of users that has the role.
Hint: You will also need to use group by in the query. */
SELECT r.name, COUNT(*)
	FROM roles r
	JOIN users u
		ON r.id = u.role_id
	GROUP BY r.name;
    
-- 2-1 Use the employees database.
USE employees;

-- 2-2 Using the example in the Associative Table Joins section as a guide, 
-- write a query that shows each department along with the name of the current manager for that department.
SHOW TABLES;
DESCRIBE departments;
DESCRIBE dept_manager;
DESCRIBE employees;
SELECT d.dept_name AS 'Department Name', 
	CONCAT(e.first_name, ' ', e.last_name) AS 'Department Manager'
	FROM departments d
    JOIN dept_manager dm
		ON d.dept_no = dm.dept_no
	JOIN employees e
		ON dm.emp_no = e.emp_no
	WHERE dm.to_date = '9999-01-01'
    ORDER BY d.dept_name;
    
-- 2-3 Find the name of all departments currently managed by women.
SELECT d.dept_name AS 'Department Name', 
	CONCAT(e.first_name, ' ', e.last_name) AS 'Department Manager'
	FROM departments d
    JOIN dept_manager dm
		ON d.dept_no = dm.dept_no
	JOIN employees e
		ON dm.emp_no = e.emp_no
	WHERE (dm.to_date = '9999-01-01')
		AND (e.gender = 'F')
    ORDER BY d.dept_name;
    
-- 2-4 Find the current titles of employees currently working in the Customer Service department.
DESCRIBE departments;
DESCRIBE dept_emp;
DESCRIBE titles;
SELECT t.title AS Title, COUNT(*) AS Count
	FROM titles t
    JOIN dept_emp de
		ON t.emp_no = de.emp_no
	JOIN departments d
		ON de.dept_no = d.dept_no
	WHERE (t.to_date = '9999-01-01')
		AND (de.to_date = '9999-01-01')
        AND (d.dept_name = 'Customer Service')
	GROUP BY t.title
    ORDER BY t.title;
        
-- 2-5 Find the current salary of all current managers.
DESCRIBE dept_manager;
DESCRIBE salaries;
SELECT d.dept_name AS 'Department Name', 
	CONCAT(e.first_name, ' ', e.last_name) AS Name, s.salary
	FROM salaries s
	JOIN dept_manager dm
		ON s.emp_no = dm.emp_no
	JOIN departments d
		ON dm.dept_no = d.dept_no
	JOIN employees e
		ON dm.emp_no = e.emp_no
	WHERE (dm.to_date = '9999-01-01')
		AND (s.to_date = '9999-01-01')
	ORDER BY d.dept_name;
        
-- 2-6 Find the number of current employees in each department.
DESCRIBE departments;
DESCRIBE dept_emp;
SELECT d.dept_no, d.dept_name, COUNT(*) AS Count
	FROM departments d
    JOIN dept_emp de
		ON d.dept_no = de.dept_no
	WHERE de.to_date = '9999-01-01'
	GROUP BY d.dept_name
    ORDER BY d.dept_no;
    
-- 2-7 Which department has the highest average salary? Sales
-- Hint: Use current not historic information.
DESCRIBE salaries;
SELECT d.dept_name, AVG(s.salary) AS avgerage_salary
	FROM departments d
	JOIN dept_emp de
		ON d.dept_no = de.dept_no
	JOIN salaries s
		ON de.emp_no = s.emp_no
	WHERE (de.to_date = '9999-01-01')
		AND (s.to_date = '9999-01-01')
	GROUP BY d.dept_name
    ORDER BY avgerage_salary DESC
    LIMIT 1;
    
-- 2-8 Who is the highest paid employee in the Marketing department? Akemi Warwick
SELECT e.first_name, e.last_name
	FROM employees e
	JOIN dept_emp de
		ON e.emp_no = de.emp_no
	JOIN departments d
		ON de.dept_no = d.dept_no
	JOIN salaries s
		ON e.emp_no = s.emp_no
	WHERE (de.to_date = '9999-01-01')
		AND (s.to_date = '9999-01-01')
        AND (d.dept_name = 'Marketing')
	ORDER BY s.salary DESC
    LIMIT 1;
    
-- 2-9 Which current department manager has the highest salary?
SELECT e.first_name, e.last_name, s.salary, d.dept_name
	FROM employees e
	JOIN dept_manager dm
		ON e.emp_no = dm.emp_no
	JOIN salaries s
		ON e.emp_no = s.emp_no
	JOIN departments d
		ON dm.dept_no = d.dept_no
	WHERE (dm.to_date = '9999-01-01')
		AND (s.to_date = '9999-01-01')
	ORDER BY s.salary DESC
    LIMIT 1;
    
-- 2-10 Determine the average salary for each department. 
-- Use all salary information and round your results.
SELECT d.dept_name, ROUND(AVG(s.salary), 0) AS average_salary
	FROM departments d
    JOIN dept_emp de
		ON d.dept_no = de.dept_no
	JOIN employees e
		ON de.emp_no = e.emp_no
    JOIN salaries s
		ON e.emp_no = s.emp_no
	GROUP BY d.dept_name
    ORDER BY average_salary DESC;
    
-- 2-11 Bonus Find the names of all current employees, their department name, and their current manager's name.
SELECT CONCAT(e.first_name, ' ', e.last_name) AS 'Employee Name',
	d.dept_name AS 'Department Name',
    CONCAT(dme.first_name, ' ', dme.last_name) AS 'Department Manager'
    FROM employees e
    JOIN dept_emp de
		ON e.emp_no = de.emp_no
	JOIN departments d
		ON de.dept_no = d.dept_no
	JOIN dept_manager dm
		ON dm.dept_no = d.dept_no
	JOIN employees dme
		ON dm.emp_no = dme.emp_no
	WHERE (de.to_date = '9999-01-01')
		AND (dm.to_date = '9999-01-01')
	ORDER BY d.dept_name, e.last_name, e.first_name;
    
-- 2-12 Bonus Who is the highest paid employee within each department.
SELECT CONCAT(e.first_name, ' ', e.last_name) AS Employee_Name,
	d.dept_name, s.salary
    FROM employees e
    JOIN dept_emp de
		ON e.emp_no = de.emp_no
	JOIN departments d
		ON de.dept_no = d.dept_no
	JOIN salaries s
		ON e.emp_no = s.emp_no
	WHERE (s.to_date = '9999-01-01')
		AND (de.to_date = '9999-01-01')
        AND (de.dept_no, s.salary) IN (
			SELECT dept_emp.dept_no, MAX(salaries.salary)
            FROM salaries 
            JOIN dept_emp
				ON salaries.emp_no = dept_emp.emp_no
			GROUP BY dept_emp.dept_no)
    ORDER BY d.dept_name
