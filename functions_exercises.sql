USE employees;

-- Exercise 2
SELECT CONCAT(first_name, ' ', last_name) AS full_name
	FROM employees 
	WHERE last_name LIKE 'E%E' 
    ORDER BY emp_no;
    
-- Exercise 3
SELECT UPPER(CONCAT(first_name, ' ', last_name)) AS full_name
	FROM employees 
	WHERE last_name LIKE 'E%E' 
    ORDER BY emp_no;

-- Exercise 4
SELECT *, DATEDIFF(CURDATE(), hire_date) 
	FROM employees 
	WHERE (YEAR(hire_date) BETWEEN 1990 AND 1999)
	AND (birth_date LIKE '%12-25') 
    ORDER BY hire_date, birth_date DESC;

SHOW TABLES;

-- Exercise 5
SELECT MIN(salary), MAX(salary)
	FROM salaries;
    
-- Exercise 6
SELECT LOWER( CONCAT(
	LEFT(first_name, 1), 
	LEFT(last_name, 4), '_', 
    DATE_FORMAT(birth_date, '%m'), 
    DATE_FORMAT(birth_date, '%y')
    )) AS username, 
    first_name, last_name, birth_date
    FROM employees;