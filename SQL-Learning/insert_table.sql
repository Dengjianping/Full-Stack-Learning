-- INSERT INTO table_name VALUES (v1,v2,v3,...);
-- INSERT INTO table_name (col1,col2,col3,...) VALUES (v1,v2,v3,...);

-- 1. Write a SQL statement to insert a record with your own value into the table countries against each column.

-- Here in the following is the structure of the table countries.

--     Column    |         Type          | Modifiers
-- --------------+-----------------------+-----------
--  country_id   | character varying(2)  |
--  country_name | character varying(40) |
--  region_id    | numeric(10,0)         |
INSERT INTO countries VALUES('CN', 'CHINA', 10);

-- 2. Write a SQL statement to insert one row into the table countries against the column country_id and country_name.

-- Here in the following is the structure of the table countries.

--     Column    |         Type          | Modifiers
-- --------------+-----------------------+-----------
--  country_id   | character varying(2)  |
--  country_name | character varying(40) |
--  region_id    | numeric(10,0)         |
INSERT INTO countries (country_id, country_name) VALUES('CN','CHINA');

-- 3. Write a SQL statement to create duplicates of countries table named country_new with all structure and data.

-- Here in the following is the structure of the table countries.

--     Column    |         Type          | Modifiers
-- --------------+-----------------------+-----------
--  country_id   | character varying(2)  |
--  country_name | character varying(40) |
--  region_id    | numeric(10,0)         |
CREATE TABLE country_new AS SELECT * FROM countries;

-- 4. Write a SQL statement to insert NULL values into region_id column for a row of countries table.
INSERT INTO countries (country_id,country_name,region_id) VALUES('C3','UK',NULL);

-- 5. Write a SQL statement to insert 3 rows by a single insert statement.
INSERT INTO countries VALUES('C4', 'INDIA', 1001), ('C5','USA',1007),('C6','UK',1003);

-- 6. Write a SQL statement insert rows from the country_new table to countries table.

-- Here are the rows for country_new table. Assume that, the countries table is empty.

--  country_id | country_name | region_id
-- ------------+--------------+-----------
--  C1         | India        |      1002
--  C2         | USA          |
--  C3         | UK           |
--  C4         | India        |      1001
--  C5         | USA          |      1007
--  C6         | UK           |      1003
-- (6 rows)
INSERT INTO countries SELECT * FROM country_new;

-- 7. Write a SQL statement to insert one row in the jobs table to ensure that no duplicate values will be entered into the job_id column.
CREATE TABLE jobs ( 
    JOB_ID integer NOT NULL UNIQUE , 
    JOB_TITLE varchar(35) NOT NULL, 
    MIN_SALARY decimal(6,0)
);
INSERT INTO jobs VALUES(1001,'OFFICER',8000);

-- 8. Write a SQL statement to insert a record into the table countries to ensure that, at country_id and the region_id 
-- combination will be entered once in the table.
CREATE TABLE countries ( 
    COUNTRY_ID integer NOT NULL,
    COUNTRY_NAME varchar(40) NOT NULL,
    REGION_ID integer NOT NULL,
    PRIMARY KEY (COUNTRY_ID,REGION_ID)
);
INSERT INTO countries VALUES(100,'CHINA' 102);

-- 9. Write a SQL statement to insert rows into the table countries in which the value 
-- of country_id column will be unique and auto incremented.
CREATE TABLE countries (
    country_id SERIAL PRIMARY KEY,
    COUNTRY_NAME varchar(40) NOT NULL,
    REGION_ID integer NOT NULL
);
INSERT INTO countries(COUNTRY_NAME,REGION_ID) VALUES('CN', 102);

-- 10. Write a SQL statement to insert records into the table countries to ensure that the country_id column 
-- will not contain any duplicate data and this will be automatically incremented and the column country_name 
-- will be filled up by 'N/A' if no value assigned to that column.
CREATE TABLE countries (
    country_id SERIAL PRIMARY KEY,
    country_name VARCHAR(40) NOT NULL DEFAULT 'N/A';
    region_id INTEGER NOT NULL
);
INSERT INTO countries (region_id) VALUES(100);

-- 11. Write a SQL statement to insert rows into the job_history table in which one column job_id is containing 
-- those values which exist in job_id column of jobs table.
CREATE TABLE jobs ( 
    JOB_ID integer NOT NULL UNIQUE PRIMARY KEY, 
    JOB_TITLE varchar(35) NOT NULL DEFAULT ' ', 
    MIN_SALARY decimal(6,0) DEFAULT 8000, 
    MAX_SALARY decimal(6,0) DEFAULT 20000
);
INSERT INTO jobs(JOB_ID,JOB_TITLE) VALUES(1001,'OFFICER');
INSERT INTO jobs(JOB_ID,JOB_TITLE) VALUES(1002,'CLERK');

CREATE TABLE job_history ( 
    EMPLOYEE_ID integer NOT NULL PRIMARY KEY, 
    JOB_ID integer NOT NULL, 
    DEPARTMENT_ID integer DEFAULT NULL, 
    FOREIGN KEY (job_id) REFERENCES jobs(job_id)
);
INSERT INTO job_history VALUES(501,1001,60);

INSERT INTO job_history VALUES(502,1003,80);

-- 12. Write a SQL statement to insert rows into the table employees in which a set of columns department_id and 
-- manager_id contains a unique value and that combined value must have existed into the table departments.
CREATE TABLE departments ( 
    DEPARTMENT_ID integer NOT NULL UNIQUE, 
    DEPARTMENT_NAME varchar(30) NOT NULL, 
    MANAGER_ID integer DEFAULT NULL, 
    LOCATION_ID integer DEFAULT NULL, 
    PRIMARY KEY (DEPARTMENT_ID,MANAGER_ID) 
);
INSERT INTO departments VALUES(60,'SALES',201,89);
INSERT INTO departments VALUES(61,'ACCOUNTS',201,89);
INSERT INTO departments VALUES(80,'FINANCE',211,90);

CREATE TABLE employees ( 
    EMPLOYEE_ID integer NOT NULL PRIMARY KEY, 
    FIRST_NAME varchar(20) DEFAULT NULL, 
    LAST_NAME varchar(25) NOT NULL, 
    JOB_ID varchar(10) NOT NULL, 
    SALARY decimal(8,2) DEFAULT NULL, 
    MANAGER_ID integer DEFAULT NULL, 
    DEPARTMENT_ID integer DEFAULT NULL, 
    FOREIGN KEY(DEPARTMENT_ID,MANAGER_ID) 
    REFERENCES  departments(DEPARTMENT_ID,MANAGER_ID)
);
INSERT INTO employees VALUES(510,'Alex','Hanes','CLERK',18000,201,60);
INSERT INTO employees VALUES(511,'Kim','Leon','CLERK',18000,211,80);

-- 13. Write a SQL statement to insert rows into the table employees in which a set of columns department_id and 
-- job_id contains the values which must have existed into the table departments and jobs.
CREATE TABLE departments ( 
    DEPARTMENT_ID integer NOT NULL UNIQUE, 
    DEPARTMENT_NAME varchar(30) NOT NULL, 
    MANAGER_ID integer DEFAULT NULL, 
    LOCATION_ID integer DEFAULT NULL, 
    PRIMARY KEY (DEPARTMENT_ID) 
);
INSERT INTO departments VALUES(60,'SALES',201,89);
INSERT INTO departments VALUES(61,'ACCOUNTS',201,89);

CREATE TABLE jobs ( 
    JOB_ID integer NOT NULL UNIQUE PRIMARY KEY, 
    JOB_TITLE varchar(35) NOT NULL DEFAULT ' ', 
    MIN_SALARY decimal(6,0) DEFAULT 8000, 
    MAX_SALARY decimal(6,0) DEFAULT 20000
);
INSERT INTO jobs(JOB_ID,JOB_TITLE) VALUES(1001,'OFFICER');
INSERT INTO jobs(JOB_ID,JOB_TITLE) VALUES(1002,'CLERK');

CREATE TABLE employees ( 
    EMPLOYEE_ID integer NOT NULL PRIMARY KEY, 
    FIRST_NAME varchar(20) DEFAULT NULL, 
    LAST_NAME varchar(25) NOT NULL, 
    DEPARTMENT_ID integer DEFAULT NULL, 
    FOREIGN KEY(DEPARTMENT_ID) 
    REFERENCES  departments(DEPARTMENT_ID),
    JOB_ID integer NOT NULL, 
    FOREIGN KEY(JOB_ID) 
    REFERENCES  jobs(JOB_ID),
    SALARY decimal(8,2) DEFAULT NULL
);
INSERT INTO employees VALUES(510,'Alex','Hanes',60,1001,18000);
INSERT INTO employees VALUES(511,'Tom','Elan',60,1003,22000); -- error
INSERT INTO employees VALUES(511,'Tom','Elan',80,1001,22000); -- error