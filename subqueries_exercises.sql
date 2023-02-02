USE employees;

-- 1 Find all the current employees with the same hire date as employee 101010 using a subquery.
SELECT *
FROM employees
	JOIN dept_emp
		USING (emp_no)
WHERE hire_date = (
	SELECT hire_date
	FROM employees
	WHERE emp_no = 101010)
	AND to_date > NOW()
;

-- 2 Find all the titles ever held by all current employees with the first name Aamod.
SELECT DISTINCT title
FROM titles
WHERE emp_no IN (
	SELECT emp_no
	FROM employees
	WHERE first_name = 'Aamod'
    )
    AND emp_no IN (
		SELECT emp_no
        FROM dept_emp de
		WHERE de.to_date > NOW())
ORDER BY title
;

-- 3 How many people in the employees table are no longer working for the company? 
-- Give the answer in a comment in your code.
SELECT COUNT(*)
FROM employees
WHERE emp_no NOT IN (
	SELECT emp_no 
	FROM dept_emp
	WHERE to_date > CURDATE())
; -- 59,900 employees

-- 4 Find all the current department managers that are female. 
-- List their names in a comment in your code.
SELECT first_name, last_name
FROM employees
WHERE emp_no IN 
	(SELECT emp_no
	FROM dept_manager
	WHERE to_date = '9999-01-01')
	AND gender = 'F'
;

-- 5 Find all the employees who currently have a higher salary than the companies overall, historical average salary.
SELECT e.first_name, e.last_name, s.salary
FROM salaries s
	JOIN employees e
		USING (emp_no)
WHERE salary > (SELECT AVG(salary) FROM salaries)
	AND (to_date = '9999-01-01')
;

/* 6 How many current salaries are within 1 standard deviation of the current highest salary? 
(Hint: you can use a built in function to calculate the standard deviation.) 
What percentage of all salaries is this?
Hint You will likely use multiple subqueries in a variety of ways
Hint It's a good practice to write out all of the small queries that you can. 
Add a comment above the query showing the number of rows returned. You will use this number 
(or the query that produced it) in other, larger queries. */

SELECT a.*, (within_1_stddev / (SELECT COUNT(salary) FROM salaries WHERE to_date > CURDATE()) * 100) AS percent_within_1_stddev
FROM
	(SELECT
		(
			SELECT COUNT(*)
			FROM salaries
			WHERE salary > 
				(
					SELECT MAX(salary)
					FROM salaries
					WHERE to_date = '9999-01-01') -
					(SELECT STDDEV(salary)
					FROM salaries
					WHERE to_date > NOW()
                )
				AND (to_date = '9999-01-01')
		) AS within_1_stddev,
		(
			SELECT COUNT(*) 
			FROM salaries
			WHERE to_date > NOW()
		) AS total_current
	) as a
;

-- get total count of salaries within 1 stddev of max current salary--> 83 total
SELECT COUNT(*) AS within_1_stddev
FROM salaries
WHERE (to_date = '9999-01-01')
	AND salary > 
		(SELECT MAX(salary)
		FROM salaries
		WHERE to_date = '9999-01-01') -
		(SELECT STDDEV(salary)
		FROM salaries
		WHERE to_date > NOW())
;

-- get total current salaries --> 240124 total
SELECT COUNT(*) 
FROM salaries
WHERE to_date > NOW();

-- get max of current salaries --> 158220
SELECT MAX(salary)
FROM salaries
WHERE to_date = '9999-01-01';

-- get stddev of current salaries --> 17309.95933634675
SELECT STDDEV(salary)
FROM salaries
WHERE to_date > NOW();

-- B1 Find all the department names that currently have female managers.
SELECT dept_name
FROM departments
WHERE dept_no IN
	(SELECT dept_no
	FROM dept_manager
		JOIN employees
			USING (emp_no)
	WHERE gender = 'F'
		AND to_date = '9999-01-01'
	)
;

-- B2 Find the first and last name of the employee with the highest salary.
SELECT first_name, last_name
FROM employees
WHERE emp_no =
	(SELECT emp_no
    FROM salaries
    WHERE to_date = '9999-01-01'
    ORDER BY salary DESC
    LIMIT 1 
    )
;

-- B3 Find the department name that the employee with the highest salary works in.
SELECT dept_name
FROM departments
	JOIN dept_emp de
		USING (dept_no)
WHERE emp_no =
	(SELECT emp_no
    FROM salaries s
    WHERE s.to_date = '9999-01-01'
    ORDER BY salary DESC
    LIMIT 1
    )
    AND de.to_date = '9999-01-01'
;