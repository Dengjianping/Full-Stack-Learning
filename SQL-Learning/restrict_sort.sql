-- 1. Write a query to display the name, including first_name and last_name and salary for all employees whose salary 
-- is out of the range between $10,000 and $15,000.
SELECT CONCAT(first_name, ' ', last_name) as "Whole Name", salary FROM employees WHERE salary NOT BETWEEN 10000 AND 15000;

-- 2. Write a query to display the name, including first_name and last_name, and department ID who works in the department 
-- 30 or 100 and arrange the result in ascending order according to the department ID.
SELECT first_name, last_name, department_id FROM employees WHERE department_id IN (30,100) ORDER BY department_id ASC;

-- 3. Write a query to display the name, including first_name and last_name, and salary who works in the department either 
-- 30 or 100 and salary is out of the range between $10,000 and $15,000.
SELECT first_name, last_name, salary FROM employees WHERE department_id IN (30,100) AND salary NOT BETWEEN 10000 AND 15000;

-- 4. Write a query to display the name, including first_name and last_name and hire date for all employees who were hired in 1987.
-- SELECT first_name, last_name, hire_date FROM employees WHERE SUBSTRING(hire_date, 1, 4)="1987";
SELECT first_name, last_name, hire_date FROM employees WHERE TO_CHAR(hire_date, 'YYYY')  LIKE '%1987';