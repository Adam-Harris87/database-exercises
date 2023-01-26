USE employees;

SELECT * FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya');
-- 2 There was 709 rows returned

SELECT * FROM employees WHERE first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya';
-- 3 There was 709 rows returned

SELECT * FROM employees WHERE (first_name = 'Irena' 
	OR first_name = 'Vidya' OR first_name = 'Maya') AND gender = 'M';
-- 4 There was 441 rows returned 

SELECT * FROM employees WHERE last_name LIKE 'E%';
-- 5 There are 7330 people with last names starting with 'e'

SELECT * FROM employees WHERE last_name LIKE 'E%' OR last_name LIKE '%E';
-- 6 There are 30723 people with last names beginning OR ending with 'e'
SELECT 30723 - 7330;
-- 6 There are 23393 people that have last names ending with 'e' but not starting with 'e'

SELECT * FROM employees WHERE last_name LIKE 'E%E';
-- 7 There are 899 people with last names beginning AND ending with 'e'
SELECT 30723 - 7330 + 899;
-- 7 There are 24292 people with last names ending with 'e'

DESCRIBE employees;
SELECT * FROM employees WHERE YEAR(hire_date) BETWEEN 1990 AND 1999;
-- 8 There were 135214 people hired in the 90s

SELECT * FROM employees WHERE birth_date LIKE '%12-25';
-- 9 There were 842 people born on Christmas

SELECT * FROM employees WHERE (YEAR(hire_date) BETWEEN 1990 AND 1999)
	AND (birth_date LIKE '%12-25');
-- 10 There were 362 people hired in the 90s that were born on Christmas

SELECT * FROM employees WHERE last_name LIKE '%q%';
-- 11 There are 1873 people with last names having a 'q'

SELECT * FROM employees WHERE (last_name LIKE '%q%') AND (last_name NOT LIKE '%qu%');
-- 12 There are 547 people with last names having a 'q' but not 'qu'