CREATE OR REPLACE DATABASE sf_tuts;



-- Creating Table
CREATE OR REPLACE TABLE emp_basic(
    first_name STRING, 
    last_name STRING, 
    email STRING, 
    streetaddress STRING, 
    city STRING, 
    start_date DATE
);

-- Creating virtual warehouse, DML
CREATE OR REPLACE WAREHOUSE sf_tuts_wh WITH 
    WAREHOUSE_SIZE='X-SMALL'
    AUTO_SUSPEND = 180
    AUTO_RESUME = TRUE 
    INITIALLY_SUSPENDED = TRUE;

SELECT CURRENT_DATABASE(), CURRENT_SCHEMA(), CURRENT_WAREHOUSE();

--  Each user and table in Snowflake gets an internal stage by default for staging data files.
-- Specify the file path at file:// (multiple file patterns matched)
-- @<namespace>.%<table_name>
-- The Put command compresses files by default using gzip
PUT file://C:\Users\P3159331\Documents\snowflake_project_1\data\employees0*.csv @sf_tuts.public.%emp_basic;

-- List the staged files
LIST @sf_tuts.public.%emp_basic;

--Copy the data into target tables from the internal stage
COPY INTO emp_basic
    FROM @%emp_basic
    FILE_FORMAT = (type = csv field_optionally_enclosed_by='"')
    PATTERN = '.*employees0[1-5].csv.gz'
    ON_ERROR = 'skip_file';


-- Now we can query the table we created 
SELECT * FROM emp_basic;

-- We can drop the objects we created if so desired: 
DROP DATABASE IF EXISTS sf_tuts;
DROP WAREHOUSE IF EXISTS sf_tuts_wh;

