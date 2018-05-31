 # Schema creation
CREATE SCHEMA  Company;

# Works with company DataBase
USE company;

# Adding Mgr_startdate, which I forgot to do it in ERWIN, and adding every PRIMARY KEY to their tables
CREATE TABLE DEPARTMENT
(
	Dnumber             INTEGER NOT NULL,
	Dname               VARCHAR(20) NOT NULL, # It can't be NULL
	Mgr_ssn             VARCHAR(20) NULL, # Varchar because it could contain some letters
    	Mgr_startdate 	    DATE, # Added because it wasn't added in ERWIN
    	PRIMARY KEY	(Dnumber)  # It was created altering the table in the next step, which have no sense	
);

# Adding every possible FORIGN KEY from the end of the list according to the order
CREATE TABLE DEPARTMENT_LOCATION
(
	Dnumber              INTEGER NOT NULL, 
	dlocation            VARCHAR(20) NOT NULL,
    PRIMARY KEY (Dnumber, dlocation), # It was created altering the table in the next step and it could be done now
    FOREIGN KEY (Dnumber) REFERENCES DEPARTMENT (Dnumber) # It was created altering the table at the end and it could be done now
);

CREATE TABLE DEPENDENT
(
	Depend_name          VARCHAR(20) NOT NULL,
	Sex                  CHAR(1) NULL, # Sex indicated by M-F or M-H
	Bdate                DATE NULL,
	Relationship         VARCHAR(20) NULL,
	Essn                 VARCHAR(20) NOT NULL,
    PRIMARY KEY (Depend_name,Essn) # It was created altering the table in the next step and it could be done now
);


CREATE TABLE EMPLOYEE
(
	Ssn                  VARCHAR(20) NOT NULL, # It could contain some letters
	Super_ssn            VARCHAR(20) NULL,
	Bdate                DATE NULL,
	Fname                VARCHAR(20) NULL,
	Minit                VARCHAR(20) NULL,
	Lname                VARCHAR(20) NULL,
	Address              VARCHAR(80) NULL,
	Salary               INTEGER NULL,
	Sex                  CHAR NULL,
	Dno                  INTEGER NULL,
    PRIMARY KEY (Ssn),  # It was created altering the table in the next step and it could be done now
    FOREIGN KEY (Dno) REFERENCES DEPARTMENT (Dnumber) # It was created altering the table at the end and it could be done now
);
    

# Adding every ALTER TABLE needed when is possible (after creating tables affected)
ALTER TABLE EMPLOYEE
ADD CONSTRAINT Supervision FOREIGN KEY (Super_ssn) REFERENCES EMPLOYEE (Ssn);

ALTER TABLE DEPARTMENT
ADD CONSTRAINT Manages FOREIGN KEY (Mgr_ssn) REFERENCES EMPLOYEE (Ssn);

ALTER TABLE DEPENDENT
ADD CONSTRAINT Dependents_of FOREIGN KEY (Essn) REFERENCES EMPLOYEE (Ssn);

# EMPLOYEE_PROJECTS = "Works On"
CREATE TABLE EMPLOYEE_PROJECTS
(
	Ssn                  VARCHAR(20) NOT NULL,
	Pnumber              INTEGER NOT NULL,
	Hours                INTEGER NULL,
    PRIMARY KEY (Ssn,Pnumber),  # It was created altering the table in the next step and it could be done now
    FOREIGN KEY (Ssn) REFERENCES EMPLOYEE (Ssn) # It was created altering the table at the end and it could be done now
);


CREATE TABLE LOCATION
(
	dlocation            VARCHAR(20) NOT NULL,
    PRIMARY KEY (dlocation)  # It was created altering the table in the next step and it could be done now
);

ALTER TABLE DEPARTMENT_LOCATION
ADD CONSTRAINT R_8 FOREIGN KEY (dlocation) REFERENCES LOCATION (dlocation);


CREATE TABLE PROJECTS
(
	Pnumber              INTEGER NOT NULL, # It is a number, it hasn't any letter
	Pname                CHAR(18) NULL,
	Plocation            CHAR(18) NULL,
	Dnumber              INTEGER NULL,
    PRIMARY KEY (Pnumber),  # It was created altering the table in the next step and it could be done now
    FOREIGN KEY (Dnumber) REFERENCES DEPARTMENT (Dnumber) # It was created altering the table at the end and it could be done now
);


ALTER TABLE EMPLOYEE_PROJECTS
ADD CONSTRAINT R_5 FOREIGN KEY (Pnumber) REFERENCES PROJECTS (Pnumber);

# Changing all data types depending on what are they going to contain







