-- create table (if not exists) table_name (
    -- columns cofiguration
-- );

-- 1. Write a SQL statement to create a simple table countries including columns country_id,country_name and region_id.
create table countries (
    country_id varchar(3),
    country_name varchar(45),
    region_id decimal(10,0)
);

-- 2. Write a SQL statement to create a simple table countries including columns country_id,
-- country_name and region_id which already exist.
create table countries (
    country_id varchar(3),
    country_name varchar(45),
    region_id decimal(10,0)
);

-- ERROR:  relation "countries" already exists

-- 3. Write a SQL statement to create the structure of a table dup_countries similar to countries.
create table dup_countries as (select * from countries) with no data;

-- 4. Write a SQL statement to create a duplicate copy of countries table including structure and data by name dup_countries.
create table dup_countries as select * from countries;

-- 5. Write a SQL statement to create a table countries set a constraint NULL.
create table if not exists countries (
    country_id varchar(2) not null,
    country_name varchar(40) not null,
    region_id decimal(10,0) not null
);

-- 6. Write a SQL statement to create a table named jobs including columns job_id, job_title, min_salary, 
-- max_salary and check whether the max_salary amount exceeding the upper limit 25000.
create table jobs (
    job_id varchar(10) not null,
    job_title varchar(35) not null,
    min_salary decimal(6,0),
    max_salary decimal(6,0) check(max_salary<=25000)
)

-- 7. Write a SQL statement to create a table named countries including columns country_id, country_name 
-- and region_id and make sure that no countries except Italy, India and China will be entered in the table.
create table if not exists countries (
    country_id varchar(2),
    country_name varchar(40) check(country_name in('Italy', 'India', 'China')),
    region_id decimal(10,0)
)

-- 8. Write a SQL statement to create a table named countries including columns country_id,country_name and 
-- region_id and make sure that no duplicate data against column country_id will be allowed at the time of insertion.
create table if not exists countries (
    country_id varchar(2) not null unique,
    country_name varchar(40) not null,
    region_id decimal(10,0) not null,
    -- unique(country_id)
)

-- 9. Write a SQL statement to create a table named jobs including columns job_id, job_title, min_salary and max_salary, 
-- and make sure that, the default value for job_title is blank and min_salary is 8000 and max_salary is NULL will be 
-- entered automatically at the time of insertion if no value assigned for the specified columns.
create table if not exists jobs (
    job_id varchar(10) not null unique,
    job_title varchar(35) default ' ',
    min_salary decimal(6,0) default 8000,
    max_salary decimal(6,0) default null
)

-- 10. Write a SQL statement to create a table named countries including columns country_id, country_name and region_id 
-- and make sure that the country_id column will be a key field which will not contain any duplicate data at the time of insertion.
create table if not exists countries (
    country_id varchar(2) not null unique primary key,
    country_name varchar(40) not null,
    region_id decimal(10,0) not null
    -- primary key (country_id)
)

-- 11. Write a SQL statement to create a table countries including columns country_id, country_name and region_id and 
-- make sure that the column country_id will be unique and store an auto-incremented value.
create table if not exists countries (
    country_id serial primary key,
    country_name varchar(40) not null,
    region_id decimal(10,0) not null
)

-- 12. Write a SQL statement to create a table countries including columns country_id, country_name and region_id and make
--  sure that the combination of columns country_id and region_id will be unique.
create table if not exists countries (
    country_id varchar(2) not null unique default ' ',
    country_name varchar(40) default null,
    region_id decimal(10,0) not null,
    primary key (country_id, country_name)
)

-- 13. Write a SQL statement to create a table job_history including columns employee_id, start_date, end_date, job_id and 
-- department_id and make sure that, the employee_id column does not contain any duplicate value at the time of insertion and
--  the foreign key column job_id contain only those values which exist in the jobs table.

-- Here is the structure of the table jobs;
--    Column   |         Type          |               Modifiers
-- ------------+-----------------------+----------------------------------------
--  job_id     | character varying(10) | not null default ''::character varying
--  job_title  | character varying(35) | not null
--  min_salary | numeric(6,0)          | default NULL::numeric
--  max_salary | numeric(6,0)          | default NULL::numeric
-- Indexes:
--     "jobs_pkey" PRIMARY KEY, btree (job_id)
create table if not exists job_history (
    employee_id decimal(6,0) not null primary key,
    start_date date not null,
    end_date date not null,
    job_id varchar(10) not null,
    department_id decimal(4,0) default null,
    foreign key (job_id) references jobs(job_id)
)

-- 14. Write a SQL statement to create a table employees including columns employee_id, first_name, last_name, email, phone_number hire_date, 
-- job_id, salary, commission, manager_id and department_id and make sure that, the employee_id column does not contain 
-- any duplicate value at the time of insertion and the foreign key columns combined by department_id and manager_id columns contain only 
-- those unique combination values, which combinations exist in the departments table.

-- Assume the structure of departments table below.
--      Column      |         Type          |           Modifiers
-- -----------------+-----------------------+--------------------------------
--  department_id   | numeric(4,0)          | not null
--  department_name | character varying(30) | not null
--  manager_id      | numeric(6,0)          | not null default NULL::numeric
--  location_id     | numeric(4,0)          | default NULL::numeric
-- Indexes:
--     "departments_pkey" PRIMARY KEY, btree (department_id, manager_id)
create table if not exists employees (
    employee_id decimal(6,0) not null primary key,
    first_name varchar(35) default null,
    last_name varchar(35) default null,
    email varchar(35) not null,
    phone_number decimal(13,0) default null,
    hire_date date default now,
    job_id varchar(10) not null,
    salary decimal(6,0) default null,
    commission_pct decimal(2,0) default null,
    manager_id varchar(10) default null,
    department_id decimal(4,0) default null,
    foreign key (manager_id, department_id) references departments(manager_id, department_id)
)

-- 15. Write a SQL statement to create a table employees including columns employee_id, first_name, last_name, email, 
-- phone_number hire_date, job_id, salary, commission, manager_id and department_id and make sure that, the employee_id 
-- column does not contain any duplicate value at the time of insertion, and the foreign key column department_id, reference 
-- by the column department_id of departments table, can contain only those values which are exist in the departments table and 
-- another foreign key column job_id, referenced by the column job_id of jobs table, can contain only those values which exist 
-- in the jobs table.

-- Assume that the structure of two tables departments and jobs.

--      Column      |         Type          |       Modifiers
-- -----------------+-----------------------+-----------------------
--  department_id   | numeric(4,0)          | not null
--  department_name | character varying(30) | not null
--  manager_id      | numeric(6,0)          | default NULL::numeric
--  location_id     | numeric(4,0)          | default NULL::numeric
-- Indexes:
--     "departments_pkey" PRIMARY KEY, btree (department_id)

--    Column   |         Type          |               Modifiers
-- ------------+-----------------------+----------------------------------------
--  job_id     | character varying(10) | not null default ''::character varying
--  job_title  | character varying(35) | not null
--  min_salary | numeric(6,0)          | default NULL::numeric
--  max_salary | numeric(6,0)          | default NULL::numeric
-- Indexes:
--     "jobs_pkey" PRIMARY KEY, btree (job_id)
create table if not exists employees (
    employee_id decimal(6,0) not null primary key,
    first_name varchar(35) default null,
    last_name varchar(35) default null,
    email varchar(35) not null,
    phone_number decimal(13,0) default null,
    hire_date date default now,
    job_id varchar(10) not null,
    salary decimal(6,0) default null,
    commission_pct decimal(2,0) default null,
    manager_id varchar(10) default null,
    department_id decimal(4,0) default null,
    foreign key (department_id) references departments(department_id),
    foreign key (job_id) references jobs(job_id)
)

-- 16. Write a SQL statement to create a table employees including columns employee_id, first_name, last_name, job_id, 
-- salary and make sure that, the employee_id column does not contain any duplicate value at the time of insertion, 
-- and the foreign key column job_id, referenced by the column job_id of jobs table, can contain only those values 
-- which exist in the jobs table. The specialty of the statement is that the ON UPDATE CASCADE action allows you to 
-- perform the cross-table update and ON DELETE RESTRICT action rejects the deletion. The default action is ON DELETE RESTRICT.

-- Assume that the following is the structure of the table jobs.

-- CREATE TABLE IF NOT EXISTS jobs ( 
-- JOB_ID INTEGER NOT NULL UNIQUE PRIMARY KEY, 
-- JOB_TITLE varchar(35) NOT NULL DEFAULT ' ', 
-- MIN_SALARY decimal(6,0) DEFAULT 8000, 
-- MAX_SALARY decimal(6,0) DEFAULT NULL
-- );

--    Column   |         Type          |                Modifiers
-- ------------+-----------------------+-----------------------------------------
--  job_id     | integer               | not null
--  job_title  | character varying(35) | not null default ' '::character varying
--  min_salary | numeric(6,0)          | default 8000
--  max_salary | numeric(6,0)          | default NULL::numeric
-- Indexes:
--     "jobs_pkey" PRIMARY KEY, btree (job_id)
create table if not exists employees (
    employee_id decimal(6,0) not null primary key,
    first_name varchar(35) default null,
    last_name varchar(35) default null,
    email varchar(35) not null,
    phone_number decimal(13,0) default null,
    hire_date date default now,
    job_id varchar(10) not null,
    salary decimal(6,0) default null,
    commission_pct decimal(2,0) default null,
    manager_id varchar(10) default null,
    department_id decimal(4,0) default null,
    foreign key (job_id) references jobs(job_id) on update CASCADE on delete RESTRICT
);

-- 17. Write a SQL statement to create a table employees including columns employee_id, first_name, last_name, job_id, 
-- salary and make sure that, the employee_id column does not contain any duplicate value at the time of insertion, 
-- and the foreign key column job_id, referenced by the column job_id of jobs table, can contain only those values 
-- which exist in the jobs table. The specialty of the statement is that the ON DELETE CASCADE that lets you allow 
-- to delete records in the employees(child) table that refers to a record in the jobs(parent) table when the record 
-- in the parent table is deleted and the ON UPDATE RESTRICT actions reject any updates.

-- Assume that the following is the structure of the table jobs.

-- CREATE TABLE IF NOT EXISTS jobs ( 
-- JOB_ID INTEGER NOT NULL UNIQUE PRIMARY KEY, 
-- JOB_TITLE varchar(35) NOT NULL DEFAULT ' ', 
-- MIN_SALARY decimal(6,0) DEFAULT 8000, 
-- MAX_SALARY decimal(6,0) DEFAULT NULL
-- );

--    Column   |         Type          |                Modifiers
-- ------------+-----------------------+-----------------------------------------
--  job_id     | integer               | not null
--  job_title  | character varying(35) | not null default ' '::character varying
--  min_salary | numeric(6,0)          | default 8000
--  max_salary | numeric(6,0)          | default NULL::numeric
-- Indexes:
--     "jobs_pkey" PRIMARY KEY, btree (job_id)
create table if not exists employees (
    employee_id decimal(6,0) not null primary key,
    first_name varchar(35) default null,
    last_name varchar(35) default null,
    email varchar(35) not null,
    phone_number decimal(13,0) default null,
    hire_date date default now,
    job_id varchar(10) not null,
    salary decimal(6,0) default null,
    commission_pct decimal(2,0) default null,
    manager_id varchar(10) default null,
    department_id decimal(4,0) default null,
    FOREIGN KEY (job_id) REFERENCES jobs(job_id) on update RESTRICT on delete CASCADE
)

-- 18. Write a SQL statement to create a table employees including columns employee_id, first_name, 
-- last_name, job_id, salary and make sure that, the employee_id column does not contain any duplicate 
-- value at the time of insertion, and the foreign key column job_id, referenced by the column job_id of 
-- jobs table, can contain only those values which exist in the jobs table. The specialty of the statement 
-- is that the ON DELETE SET NULL action will set the foreign key column values in the child table(employees) 
-- to NULL when the record in the parent table(jobs) is deleted, with a condition that the foreign key column 
-- in the child table must accept NULL values and the ON UPDATE SET NULL action resets the values in the rows 
-- in the child table(employees) to NULL values when the rows in the parent table(jobs) are updated.

-- Assume that the following is the structure of two table jobs.

-- CREATE TABLE IF NOT EXISTS jobs ( 
-- JOB_ID INTEGER NOT NULL UNIQUE PRIMARY KEY, 
-- JOB_TITLE varchar(35) NOT NULL DEFAULT ' ', 
-- MIN_SALARY decimal(6,0) DEFAULT 8000, 
-- MAX_SALARY decimal(6,0) DEFAULT NULL
-- );

--    Column   |         Type          |                Modifiers
-- ------------+-----------------------+-----------------------------------------
--  job_id     | integer               | not null
--  job_title  | character varying(35) | not null default ' '::character varying
--  min_salary | numeric(6,0)          | default 8000
--  max_salary | numeric(6,0)          | default NULL::numeric
-- Indexes:
--     "jobs_pkey" PRIMARY KEY, btree (job_id)
create table if not exists employees (
    employee_id decimal(6,0) not null primary key,
    first_name varchar(35) default null,
    last_name varchar(35) default null,
    email varchar(35) not null,
    phone_number decimal(13,0) default null,
    hire_date date default now,
    job_id varchar(10) not null,
    salary decimal(6,0) default null,
    commission_pct decimal(2,0) default null,
    manager_id varchar(10) default null,
    department_id decimal(4,0) default null,
    FOREIGN KEY (job_id) REFERENCES jobs(job_id) on DELETE set NULL on UPDATE set null
)

-- 19. Write a SQL statement to create a table employees including columns employee_id, first_name, 
-- last_name, job_id, salary and make sure that, the employee_id column does not contain any duplicate 
-- value at the time of insertion, and the foreign key column job_id, referenced by the column job_id of 
-- jobs table, can contain only those values which exist in the jobs table. The specialty of the statement 
-- is that, The ON DELETE NO ACTION and the ON UPDATE NO ACTION actions will reject the deletion and any updates.

-- Assume that the following is the structure of two table jobs.

-- CREATE TABLE IF NOT EXISTS jobs ( 
-- JOB_ID INTEGER NOT NULL UNIQUE PRIMARY KEY, 
-- JOB_TITLE varchar(35) NOT NULL DEFAULT ' ', 
-- MIN_SALARY decimal(6,0) DEFAULT 8000, 
-- MAX_SALARY decimal(6,0) DEFAULT NULL
-- );

--    Column   |         Type          |                Modifiers
-- ------------+-----------------------+-----------------------------------------
--  job_id     | integer               | not null
--  job_title  | character varying(35) | not null default ' '::character varying
--  min_salary | numeric(6,0)          | default 8000
--  max_salary | numeric(6,0)          | default NULL::numeric
-- Indexes:
--     "jobs_pkey" PRIMARY KEY, btree (job_id)
create table if not exists employees (
    employee_id decimal(6,0) not null primary key,
    first_name varchar(35) default null,
    last_name varchar(35) default null,
    email varchar(35) not null,
    phone_number decimal(13,0) default null,
    hire_date date default now,
    job_id varchar(10) not null,
    salary decimal(6,0) default null,
    commission_pct decimal(2,0) default null,
    manager_id varchar(10) default null,
    department_id decimal(4,0) default null,
    FOREIGN KEY (job_id) REFERENCES jobs(job_id) on DELETE no action on UPDATE no action
)