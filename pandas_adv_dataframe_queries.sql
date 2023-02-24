USE employees;
SHOW tables;
SELECT * FROM departments;
SELECT * FROM dept_emp;
SELECT * FROM titles;
SELECT * FROM salaries;

SELECT emp_no, title, dept_name 
FROM titles
	JOIN dept_emp
		USING (emp_no)
	JOIN departments
		USING (dept_no)
;

SELECT emp_no, title, dept_name 
FROM titles
	JOIN dept_emp
		USING (emp_no)
	JOIN departments
		USING (dept_no)
WHERE titles.to_date > now()
	AND dept_emp.to_date > now()
;

SELECT emp_no, title, dept_name, salary
FROM titles
	JOIN dept_emp
		USING (emp_no)
	JOIN departments
		USING (dept_no)
	JOIN salaries
		USING (emp_no)
WHERE titles.to_date > now()
	AND dept_emp.to_date > now()
    AND salaries.to_date > now()
;