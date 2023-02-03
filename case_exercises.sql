USE employees;

/* Write a query that returns all employees, their department number, their start date, their end date, 
and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not. */
SELECT first_name, last_name, dept_no, hire_date, to_date,
	IF(to_date > NOW(), 1, 0) AS is_current_employee
FROM employees
	JOIN dept_emp
		USING (emp_no)
ORDER BY last_name, first_name;

/* 2 Write a query that returns all employee names (previous and current), 
and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' 
depending on the first letter of their last name. */
SELECT first_name, last_name,
	CASE
		WHEN SUBSTR(last_name, 1, 1) IN ('a','b','c','d','e','f','g','h') THEN 'A-H'
        WHEN SUBSTR(last_name, 1, 1) IN ('i','j','k','l','m','n','o','p','q') THEN 'I-Q'
        ELSE 'R-Z'
	END AS alpha_group
FROM employees
ORDER BY first_name;

-- 3 How many employees (current or previous) were born in each decade?
SELECT 
	COUNT(CASE SUBSTR(birth_date, 3, 1) WHEN 5 THEN 1 ELSE NULL END) AS '1950s', 
	COUNT(CASE SUBSTR(birth_date, 3, 1) WHEN 6 THEN 1 ELSE NULL END) AS '1960s' 
FROM employees;

SELECT * FROM departments;
/* 4 What is the current average salary for each of the following department groups: 
R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service? */
SELECT 
	ROUND(AVG(CASE WHEN de.dept_no IN ('d001', 'd007') THEN salary ELSE NULL END), 2) AS 'Sales & Marketing',
	ROUND(AVG(CASE WHEN de.dept_no IN ('d002', 'd003') THEN salary ELSE NULL END), 2) AS 'Finance & HR',
    ROUND(AVG(CASE WHEN de.dept_no IN ('d004', 'd006') THEN salary ELSE NULL END), 2) AS 'Prod & QM',
    ROUND(AVG(CASE WHEN de.dept_no IN ('d005', 'd008') THEN salary ELSE NULL END), 2) AS 'R&D',
    ROUND(AVG(CASE WHEN de.dept_no = 'd009' THEN salary ELSE NULL END), 2) AS 'Customer Service'
FROM departments d
	JOIN dept_emp de
		ON d.dept_no = de.dept_no
        AND de.to_date > CURDATE()
	JOIN salaries s
		ON de.emp_no = s.emp_no
        AND s.to_date > CURDATE()
;
		
