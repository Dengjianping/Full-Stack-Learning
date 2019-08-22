-- UPDATE table_name SET col1=val1, col2=val2,... where some_cols=some_val(and);

-- 1. Write a SQL statement to change the email column of the employees table with 'not available' for all employees.
UPDATE employees SET email='not available';

-- 2. Write a SQL statement to change the email and commission_pct column of the employees 
-- table with 'not available' and 0.10 for all employees.
UPDATE employees SET email='not available', commission_pct=0.10;

-- 3. Write a SQL statement to change the email and commission_pct column of the employees table with 'not available' 
-- and 0.10 for those employees whose department_id is 110.
UPDATE employees SET email='not available', commission_pct=0.10 WHERE department_id=110;

-- 4. Write a SQL statement to change the email column of employees table with 'not available' for those employees 
-- whose department_id is 80 and gets a commission is less than.20%.
UPDATE employees SET email='not available' where department_id=80 AND commission_pct<.20;

-- 5. Write a SQL statement to change the email column of the employees table with 'not available' 
-- for those employees who belongs to the 'Accounting' department.
UPDATE employees SET email='not available' where department_id=(SELECT department_id FROM departments WHERE department_name='Accounting');

-- 6. Write a SQL statement to change the salary of an employee to 8000 whose ID is 105, if the existing salary is less than 5000.
UPDATE employees SET salary=8000 WHERE employee_id=105 and salary<5000;

-- 7. Write a SQL statement to change the job ID of the employee which ID is 118 to SH_CLERK if the employee belongs to a department 
-- which ID is 30 and the existing job ID does not start with SH.
UPDATE employees SET job_id='SH_CLERK' WHERE department_id=118 AND department_id=30 AND NOT job_id LIKE 'SH%';

-- 8. Write a SQL statement to increase the salary of employees under the department 40, 90 and 110 according to the company rules that, 
-- the salary will be increased by 25% of the department 40, 15% for department 90 and 10% of the department 110 and the rest of the 
-- department will remain same.
UPDATE employees SET salary= CASE department_id 
WHEN 40 THEN salary+(salary*.25) 
WHEN 90 THEN salary+(salary*.15)
WHEN 110 THEN salary+(salary*.10)
ELSE salary
END
WHERE department_id IN (40,50,50,60,70,80,90,110);