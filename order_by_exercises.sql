USE employees;

SELECT * FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya') ORDER BY first_name;
-- 2 What was the first and last name in the first row of the results? Irena Reutenauer
-- What was the first and last name of the last person in the table? Vidya Simmen

SELECT * FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya') ORDER BY first_name, last_name;
-- 3 What was the first and last name in the first row of the results? Irena Acton
-- What was the first and last name of the last person in the table? Vidya Zweizig

SELECT * FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya') ORDER BY last_name, first_name;
-- 4 What was the first and last name in the first row of the results? Irena Acton
-- What was the first and last name of the last person in the table? Maya Zyda

SELECT * FROM employees WHERE last_name LIKE 'E%E' ORDER BY emp_no;
-- 5 Enter a comment with the number of employees returned: 899
-- the first employee number and their first and last name: 10021 Ramzi Erde
-- the last employee number with their first and last name: 499648 Tadahiro Erde

SELECT * FROM employees WHERE last_name LIKE 'E%E' ORDER BY hire_date DESC;
-- 6 Enter a comment with the number of employees returned: 899
-- the name of the newest employee: Teiji Eldridge
-- the name of the oldest employee: Sergi Erde

SELECT * FROM employees WHERE (YEAR(hire_date) BETWEEN 1990 AND 1999)
	AND (birth_date LIKE '%12-25') ORDER BY birth_date, hire_date DESC;
-- 7 Enter a comment with the number of employees returned: 362
-- the name of the oldest employee who was hired last: Khun Bernini
-- the name of the youngest employee who was hired first: Douadi Pettis