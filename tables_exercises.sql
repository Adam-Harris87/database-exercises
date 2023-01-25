USE employees;
SHOW TABLES;
DESCRIBE employees;
-- The data types are: int, date, varchar(14), varchar(16), enum('M','F'), Date
-- The table that stores numerical info is: emp_no
-- The tables that store string info are: first_name, last_name, gender
-- The tables that store date info are: birth_date, hire_date
DESCRIBE departments;
DESCRIBE dept_emp;
-- What is the relationship between the employees and the departments tables?
-- The tables are related through the table dept_emp, which connects employees.emp_no and departments.dept_no
SHOW CREATE TABLE dept_manager;
/* CREATE TABLE `dept_manager` (
  `emp_no` int NOT NULL,
  `dept_no` char(4) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  PRIMARY KEY (`emp_no`,`dept_no`),
  KEY `dept_no` (`dept_no`),
  CONSTRAINT `dept_manager_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `dept_manager_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`) ON DELETE CASCADE ON UPDATE RESTRICT
) */
