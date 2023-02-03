USE employees;

/* 1 Using the example from the lesson, create a temporary table called employees_with_departments that contains 
first_name, last_name, and dept_name for employees currently with that department. 
Be absolutely sure to create this table on your own database. If you see "Access denied for user ...", 
it means that the query was attempting to write a new table to a database that you can only read. */
CREATE TEMPORARY TABLE oneil_2093.employees_with_departments AS
SELECT first_name, last_name, dept_name
FROM employees e
	JOIN dept_emp de
		ON e.emp_no = de.emp_no
        AND to_date > NOW()
	JOIN departments
		USING (dept_no);

USE oneil_2093;
/* 1.a Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of 
the lengths of the first name and last name columns. */
SELECT MAX(LENGTH(first_name)) + MAX(LENGTH(last_name))
FROM employees_with_departments; -- SUM is 30 

ALTER TABLE employees_with_departments
ADD full_name VARCHAR(30);

-- 1.b Update the table so that full name column contains the correct data.
UPDATE employees_with_departments
SET full_name = CONCAT(first_name, ' ', last_name);

SELECT * FROM employees_with_departments;

-- 1.c Remove the first_name and last_name columns from the table.
ALTER TABLE employees_with_departments
	DROP COLUMN first_name, 
    DROP COLUMN last_name;
    
-- 1.d What is another way you could have ended up with this same table? 

-- we could have created the table with the full_name from the start

-- 2 Create a temporary table based on the payment table from the sakila database.

CREATE TEMPORARY TABLE payment AS
SELECT * FROM sakila.payment;

SELECT * FROM payment;
DESCRIBE payment;
/* 2b Write the SQL necessary to transform the amount column such that it is stored as an integer representing 
the number of cents of the payment. For example, 1.99 should become 199. */
ALTER TABLE payment
MODIFY amount DECIMAL(10, 2);
UPDATE payment
SET amount = amount * 100;
ALTER TABLE payment
MODIFY amount INT;
SELECT * FROM payment;

USE employees;
SELECT * FROM departments;
/* 3a Find out how the current average pay in each department compares to the overall current pay for everyone at the company. 
For this comparison, you will calculate the z-score for each salary. */
CREATE TEMPORARY TABLE oneil_2093.averages AS
SELECT dept_name, ROUND(AVG(salary), 2) AS dept_avg
FROM dept_emp de
	JOIN salaries s
		ON de.emp_no = s.emp_no
        AND s.to_date > CURDATE()
	JOIN departments d
		USING (dept_no)
WHERE de.to_date > CURDATE()
GROUP BY dept_no;

DROP TABLE oneil_2093.averages;
SELECT * FROM oneil_2093.averages;
USE oneil_2093;

ALTER TABLE averages
ADD COLUMN current_avg DECIMAL(10, 2);
UPDATE averages
SET current_avg = ROUND((
	SELECT AVG(salary) 
    FROM employees.salaries 
    WHERE to_date > now()), 2)
;
ALTER TABLE averages
ADD COLUMN std_dev DECIMAL(10, 2);
UPDATE averages
SET std_dev = ROUND((
	SELECT STDDEV(salary) 
    FROM employees.salaries 
    WHERE to_date > now()), 2)
;
ALTER TABLE averages
ADD COLUMN z_score DECIMAL(10, 2);
UPDATE averages
SET z_score = (
	(dept_avg - current_avg) / std_dev);
    
SELECT * FROM averages;

-- 3b In terms of salary, what is the best department right now to work for? The worst? 
-- the best is Sales
-- the worst is Human Resources

/* 4 BONUS Determine the overall historic average department average salary, 
the historic overall average, and the historic z-scores for salary. 
Do the z-scores for current department average salaries 
(from exercise 3) tell a similar or a different story than the historic department salary z-scores? */

-- To get the historical data, we can simply remove the to_date comparisons from the previous commands
CREATE TEMPORARY TABLE oneil_2093.historic_averages AS
SELECT dept_name, ROUND(AVG(salary), 2) AS dept_avg
FROM dept_emp de
	JOIN salaries s
		ON de.emp_no = s.emp_no
	JOIN departments d
		USING (dept_no)
        
GROUP BY dept_no;
ALTER TABLE historic_averages
ADD COLUMN current_avg DECIMAL(10, 2);
UPDATE historic_averages
SET current_avg = ROUND((
	SELECT AVG(salary) 
    FROM employees.salaries 
	), 2);
    
ALTER TABLE historic_averages
ADD COLUMN std_dev DECIMAL(10, 2);
UPDATE historic_averages
SET std_dev = ROUND((
	SELECT STDDEV(salary) 
    FROM employees.salaries 
    ), 2);

ALTER TABLE historic_averages
ADD COLUMN z_score DECIMAL(10, 2);
UPDATE historic_averages
SET z_score = (
	(dept_avg - current_avg) / std_dev);
    
SELECT * FROM historic_averages;
-- worst dept historically is Human Resources
-- best dept historically is Sales
-- this is the same as current