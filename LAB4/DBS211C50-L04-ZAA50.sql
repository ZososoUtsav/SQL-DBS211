SET AUTOCOMMIT ON; 
/* 
Name: Utsav Gautam
oracle-id: dbs211_231zaa50
student-id: 157891219
Purpose: Lab4
Date: 2nd Feb
*/
-- Answer no.1A
CREATE TABLE movies(
mid INT NOT NULL PRIMARY KEY, 
title VARCHAR(35) NOT NULL, 
releaseYear INT NOT NULL, 
director INT NOT NULL, 
score decimal(3,2) NULL); 

-- Answer no.1B
CREATE TABLE actors(
aid INT PRIMARY KEY NOT NULL, 
firstName VARCHAR(20) NOT NULL, 
lastName VARCHAR(30) NOT NULL
); 

-- Answer no.1C
CREATE TABLE castings(
movieid INT NOT NULL, 
actorid INT NOT NULL, 
PRIMARY KEY (movieid, actorid),
FOREIGN KEY (movieid) REFERENCES movies (mid),
FOREIGN KEY (actorid) REFERENCES actors (aid) 
); 

-- Answer no.1D
CREATE TABLE directors(
id INT PRIMARY KEY NOT NULL, 
name VARCHAR(20) NOT NULL, 
Lastname VARCHAR(30) NOT NULL
); 

-- Answer no.2
ALTER TABLE movies
ADD CONSTRAINT director_fk FOREIGN KEY (director) REFERENCES directors; 

-- Answer no.3
ALTER TABLE movies 
ADD CONSTRAINT title_uni UNIQUE(title); 

-- Answer no.4
INSERT ALL 
INTO directors VALUES(1010, 'Rob', 'Minkoff') 
INTO directors VALUES(1020, 'Bill', 'Condon')
INTO directors VALUES(1050, 'Josh' ,'Cooley') 
INTO directors VALUES (2010, 'Brad','Bird')
INTO directors VALUES (3020, 'Lake', 'Bell')
SELECT * FROM dual;

INSERT ALL 
INTO movies VALUES (100, 'The Lion King', 2019, 3020,3.5) 
INTO movies VALUES (200, 'Beauty and the Beast', 2017, 1050, 4.20) 
INTO movies VALUES (300, 'Toy Story 4', 2019, 1020, 4.50) 
INTO movies VALUES (400, 'Mission Impossible', 2018, 2010,5.00) 
INTO movies VALUES (500, 'The Secret Life of Pets', 2016, 1010,3.90) 
SELECT * FROM dual; 

-- Answer no.5
DROP TABLE castings, movies, actors, directors; 
/* 
order matters because we cant attpemt to delete the child table without deleting the parent table. 
The parent table cannot be deleted when foreign key is used in child table. Therefore, the child table 
needs to be deleted first 
*/

-- Answer no.6
CREATE TABLE employee2 
(
employeenumber INT PRIMARY KEY, 
lastname VARCHAR(50) NOT NULL, 
firstname VARCHAR(50) NOT NULL, 
extension VARCHAR(10) NOT NULL, 
email VARCHAR(100) NOT NULL, 
officecode VARCHAR(10) NOT NULL, 
reportsto INT DEFAULT NULL, 
jobtitle VARCHAR(50) NOT NULL, 
CONSTRAINT officecode_FK FOREIGN KEY (officecode) REFERENCES offices, 
CONSTRAINT report_FK FOREIGN KEY (reportsto) REFERENCES employees); 
);

-- Answer no.7
ALTER TABLE employee2 
ADD username VARCHAR(40) NULL; 

-- Answer no.8
DELETE FROM employee2; 

-- Answer no.9
INSERT INTO employee2 (employeenumber, lastname, firstname, extension,email,officecode,reportsto,jobtitle) 
SELECT *  FROM employees; 

-- Answer no.10
UPDATE employee2 
SET firstname = 'Utsav',
lastname ='Gautam'
WHERE employeenumber = 1002;

--Answer no.11
SELECT rownum,lower(concat(substr(firstname,1,1),lastname))|| '@gmail.com' 
FROM employee2;

-- Answer no.12
DELETE FROM employee2
WHERE officecode = 4; 

--Answer no.13
DROP TABLE employee2; 
