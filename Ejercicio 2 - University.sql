CREATE SCHEMA University;

USE University;

# 1. Changing every symbol or name not allow to use in variable names in SQL (#, Time, Year, etc.)
# 2. Inserting every PRIMARY KEY in their appropriate table inside the create table query.
# 3. Introducing every FOREING KEY in their appropriate table into the create table query when possible.
# 4. Changing data types when needed

CREATE TABLE COLLEGE
(
	Cname                VARCHAR(50) NOT NULL,
	Dean                 VARCHAR(50) NULL,
	Coffice              VARCHAR(6) NULL, # It is possible it includes a letter (f.e.: 47-D)
    PRIMARY KEY (Cname) 
);


CREATE TABLE COURSE
(
	Co                   INTEGER NOT NULL,
	Course_name          VARCHAR(20) NULL,
	Cdesc                VARCHAR(200) NULL,
	Dname                VARCHAR(20) NOT NULL,
	Cname                VARCHAR(50) NOT NULL,
    PRIMARY KEY (Co,Dname,Cname)
);


CREATE TABLE CURRENT_SECTION
(
	SecCo                 INTEGER NOT NULL,
    PRIMARY KEY (SecCo)
);


CREATE TABLE DEGREE
(
	College              CHAR(18) NULL,
	Degree               CHAR(18) NULL,
	Year_                INTEGER NULL
);

CREATE TABLE DEPARTMENT
(
	Dname                VARCHAR(20) NOT NULL,
	Dphone               INTEGER NULL,
	Office               VARCHAR(6) NULL,
	Cname                VARCHAR(50) NOT NULL,
    PRIMARY KEY (Dname,Cname),
    FOREIGN KEY (Cname) REFERENCES COLLEGE (Cname)
);

ALTER TABLE COURSE
ADD CONSTRAINT DC FOREIGN KEY (Dname, Cname) REFERENCES DEPARTMENT (Dname, Cname);

CREATE TABLE FACULTY
(
	Rank                 VARCHAR(20) NULL,
	Foffice              VARCHAR(20) NULL,
	Fphone               VARCHAR(20) NULL,
	Salary               INTEGER NULL,
	Ssn                  VARCHAR(20) NOT NULL,
	Dname                VARCHAR(20) NULL,
	Cname                VARCHAR(50) NULL,
    PRIMARY KEY (Ssn),
    FOREIGN KEY (Dname, Cname) REFERENCES DEPARTMENT (Dname, Cname)
);


CREATE TABLE FACULTY_DEPARTMENT
(
	Ssn                  VARCHAR(20) NOT NULL,
	Dname                VARCHAR(20) NOT NULL,
	Cname                VARCHAR(50) NOT NULL,
    PRIMARY KEY (Ssn,Dname,Cname),
    FOREIGN KEY (Ssn) REFERENCES FACULTY (Ssn),
    FOREIGN KEY (Dname, Cname) REFERENCES DEPARTMENT (Dname, Cname)
);


CREATE TABLE FACULTY_GRAD_STUDENT
(
	Ssn                  VARCHAR(20) NOT NULL,
    PRIMARY KEY (Ssn),
    FOREIGN KEY (Ssn) REFERENCES FACULTY (Ssn)
);


CREATE TABLE GRAD_STUDENT
(
	Ssn                  VARCHAR(20) NOT NULL,
	PRIMARY KEY (Ssn)
);


ALTER TABLE FACULTY_GRAD_STUDENT
ADD CONSTRAINT R_9 FOREIGN KEY (Ssn) REFERENCES GRAD_STUDENT (Ssn);


CREATE TABLE GRAD_STUDENT_DEGREE
(
	Ssn                  VARCHAR(20) NOT NULL,
    PRIMARY KEY (Ssn),
    FOREIGN KEY (Ssn) REFERENCES GRAD_STUDENT (Ssn)
);


CREATE TABLE GRANT_
(
	Title                VARCHAR(20) NULL,
	Num                   INTEGER NOT NULL,
	Agency               VARCHAR(20) NULL,
	St_date              VARCHAR(20) NULL,
	Ssn                  VARCHAR(20) NULL,
    PRIMARY KEY (Num),
    FOREIGN KEY (Ssn) REFERENCES FACULTY (Ssn)
);


CREATE TABLE GRANT_INSTRUCTOR_RESEARCHER
(
	Num                  	INTEGER NOT NULL,
	Ssn                  	VARCHAR(20) NOT NULL,
	Start_date          	DATE NULL,
	Time_                 	INTEGER NULL,
	End_                  	DATE NULL,
    PRIMARY KEY (Num,Ssn),
    FOREIGN KEY (Num) REFERENCES GRANT_ (Num)
);


CREATE TABLE INSTRUCTOR_RESEARCHER
(
	Ssn                  VARCHAR(20) NOT NULL,
    PRIMARY KEY (Ssn),
    FOREIGN KEY (Ssn) REFERENCES FACULTY (Ssn)
);

ALTER TABLE GRANT_INSTRUCTOR_RESEARCHER
ADD CONSTRAINT R_19 FOREIGN KEY (Ssn) REFERENCES INSTRUCTOR_RESEARCHER (Ssn);


CREATE TABLE PERSON
(
	Fname                VARCHAR(20) NULL,
	Minit                VARCHAR(20) NULL,
	Lname                VARCHAR(20) NULL,
	Ssn                  VARCHAR(20) NOT NULL,
	Bdate                DATE NULL,
	Sex                  CHAR(1) NULL,
	Address              VARCHAR(80) NULL,
    PRIMARY KEY (Ssn)
);

ALTER TABLE FACULTY
ADD CONSTRAINT R_1 FOREIGN KEY (Ssn) REFERENCES PERSON (Ssn) 	ON DELETE CASCADE;

CREATE TABLE SECTION
(
	SecCo                 INTEGER NOT NULL,
	Year_                 INTEGER NULL,
	Qtr                  INTEGER NULL,
	Ssn                  VARCHAR(20) NULL,
	Co                   INTEGER NULL,
	Dname                VARCHAR(20) NULL,
	Cname                VARCHAR(50) NULL,
    PRIMARY KEY (SecCo),
    FOREIGN KEY (Co, Dname, Cname) REFERENCES COURSE (Co, Dname, Cname),
    FOREIGN KEY (Ssn) REFERENCES INSTRUCTOR_RESEARCHER (Ssn)
);

ALTER TABLE CURRENT_SECTION
ADD CONSTRAINT R_27 FOREIGN KEY (SecCo) REFERENCES SECTION (SecCo) 		ON DELETE CASCADE;

CREATE TABLE SECTION_STUDENT
(
	SecCo                INTEGER NOT NULL,
	Ssn                  VARCHAR(20) NOT NULL,
	Grade                INTEGER NULL,
    PRIMARY KEY (SecCo,Ssn),
    FOREIGN KEY (SecCo) REFERENCES SECTION (SecCo)
);


CREATE TABLE STUDENT
(
	Class                VARCHAR(20) NULL,
	Ssn                  VARCHAR(20) NOT NULL,
	Dname                VARCHAR(20) NULL,
	Cname                VARCHAR(50) NULL,
    PRIMARY KEY (Ssn),
	CONSTRAINT Minor FOREIGN KEY (Dname, Cname) REFERENCES DEPARTMENT (Dname, Cname),
    CONSTRAINT Major FOREIGN KEY (Dname, Cname) REFERENCES DEPARTMENT (Dname, Cname),
    FOREIGN KEY (Ssn) REFERENCES PERSON (Ssn)	ON DELETE CASCADE
);

ALTER TABLE INSTRUCTOR_RESEARCHER
ADD CONSTRAINT Cat2_Inst FOREIGN KEY (Ssn) REFERENCES STUDENT (Ssn);

ALTER TABLE SECTION_STUDENT
ADD CONSTRAINT R_33 FOREIGN KEY (Ssn) REFERENCES STUDENT (Ssn);


CREATE TABLE STUDENT_CURRENT_SECTION
(
	Ssn                 VARCHAR(20) NOT NULL,
	SecCo               INTEGER NOT NULL,
    PRIMARY KEY (Ssn,SecCo),
    FOREIGN KEY (Ssn) REFERENCES STUDENT (Ssn),
    FOREIGN KEY (SecCo) REFERENCES CURRENT_SECTION (SecCo)
);

