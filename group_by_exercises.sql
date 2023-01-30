USE employees;
DESCRIBE titles;

-- 2 In your script, use DISTINCT to find the unique titles in the titles table. 
SELECT COUNT(DISTINCT title) 
	FROM titles;
-- How many unique titles have there ever been? There have been 7 titles

-- 3 Write a query to to find a list of all unique last names of all employees that start and end with 'E' using GROUP BY.
SELECT last_name 
	FROM employees
    WHERE last_name LIKE 'e%e'
    GROUP BY last_name
    ORDER BY last_name;
    
-- 4 Write a query to to find all unique combinations of first and last names 
-- of all employees whose last names start and end with 'E'.
SELECT last_name, first_name
	FROM employees
    WHERE last_name LIKE 'e%e'
    GROUP BY last_name, first_name
    ORDER BY last_name, first_name;
    
-- 5 Write a query to find the unique last names with a 'q' but not 'qu'. 
SELECT last_name 
	FROM employees
    WHERE (last_name LIKE '%q%')
		AND NOT (last_name LIKE '%qu%') 
    GROUP BY last_name
    ORDER BY last_name;
/* Include those names in a comment in your sql code.
Chleq
Lindqvist
Qiwen */

-- 6 Add a COUNT() to your results (the query above) to find the number of employees with the same last name.
SELECT last_name, COUNT(*)
	FROM employees
    WHERE (last_name LIKE '%q%')
		AND NOT (last_name LIKE '%qu%') 
    GROUP BY last_name
    ORDER BY last_name;
/* Chleq, 189
Lindqvist, 190
Qiwen, 168 */

/* 7 Find all all employees with first names 'Irena', 'Vidya', or 'Maya'. 
Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names. */
SELECT first_name, gender, COUNT(*)
	FROM employees
	WHERE first_name IN ('Irena', 'Vidya', 'Maya')
    GROUP BY first_name, gender
    ORDER BY first_name, gender;
    
-- 8 Using your query that generates a username for all of the employees, generate a count employees for each unique username.
SELECT LOWER( CONCAT(
	SUBSTR(first_name, 1, 1), 
	LEFT(last_name, 4), 
    '_', 
    DATE_FORMAT(birth_date, '%m'), 
    DATE_FORMAT(birth_date, '%y')
    )) AS username 
	, COUNT(*) AS usr_count
    FROM employees
    GROUP BY username
    ORDER BY usr_count DESC;
    
/* 9 From your previous query, are there any duplicate usernames? yes
What is the higest number of times a username shows up?  6 times
Bonus: How many duplicate usernames are there from your previous query? 13251 */
SELECT LOWER( CONCAT(
	SUBSTR(first_name, 1, 1), 
	LEFT(last_name, 4), 
    '_', 
    DATE_FORMAT(birth_date, '%m'), 
    DATE_FORMAT(birth_date, '%y')
    )) AS username
    FROM employees
    GROUP BY username
    HAVING COUNT(*) > 1;
    
