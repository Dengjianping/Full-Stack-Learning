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

-- 5. Write a query to get the first name of the employee who holds the letter 'c' and 'e' in the first name.
SELECT first_name FROM employees WHERE first_name LIKE '%c%' AND first_name LIKE '%e%';

-- 6. Write a query to display the last name, job, and salary for all those employees who hasn't worked as a Programmer 
-- or a Shipping Clerk, and not drawing the salary $4,500, $10,000, or $15,000.
SELECT last_name,job_id,salary FROM employees WHERE job_id IN ("PROGRAMER", "Shipping Clerk") and salary NOT IN (4500,10000,15000);

-- 7. Write a query to display the last names of employees whose name contain exactly six characters.
SELECT last_name FROM employees WHERE LENGTH(last_name)=6;
SELECT last_name FROM employees WHERE last_name LIKE '______';

-- 8. Write a query to display the last name of employees having 'e' as the third character.
SELECT last_name FROM employees WHERE last_name LIKE '__e%';

-- 9. Write a query to display the jobs/designations available in the employees table.
SELECT DISTINCT job_id  FROM employees;

-- 10. Write a query to display the name, including first_name, last_name, salary and 15% of salary as PF of all employees.
SELECT first_name,last_name,salary,salary*.15 as "PF" FROM employees;

-- 11. Write a query to select all information of employees whose last name is either 'JONES' or 'BLAKE' or 'SCOTT' or 'KING' or 'FORD'.
SELECT last_name FROM employees WHERE last_name IN ('JONS','SCOTT','KING','FORD');