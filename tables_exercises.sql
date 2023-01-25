USE employees;

SHOW TABLES;
-- The tables in employees are: departments, dept_emp, dept_manager, employees, salaries, titles

DESCRIBE departments;
DESCRIBE dept_emp;
DESCRIBE dept_manager;
DESCRIBE employees;
DESCRIBE salaries;
DESCRIBE titles;

-- The data types in employees are: int, date, varchar(14), varchar(16), enum('M','F'), Date

-- The tables that stores numerical info columns are: departments, dept_emp, dept_manager, employees, salaries, titles

-- The tables that store string info columns are: departments, dept_emp, dept_manager, employees, titles

-- The tables that store date info columns are: dept_emp, dept_manager, employees, salaries, titles

-- What is the relationship between the employees and the departments tables?
-- The tables are related through the table dept_emp, which connects employees.emp_no and departments.dept_no

SHOW CREATE TABLE dept_manager;
/* The command used to create the table dept_manager is:
CREATE TABLE `dept_manager` (
  `emp_no` int NOT NULL,
  `dept_no` char(4) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  PRIMARY KEY (`emp_no`,`dept_no`),
  KEY `dept_no` (`dept_no`),
  CONSTRAINT `dept_manager_ibfk_1` FOREIGN KEY (`emp_no`) 
  REFERENCES `employees` (`emp_no`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `dept_manager_ibfk_2` FOREIGN KEY (`dept_no`) 
  REFERENCES `departments` (`dept_no`) ON DELETE CASCADE ON UPDATE RESTRICT
) */
