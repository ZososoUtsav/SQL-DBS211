SET AUTOCOMMIT ON; 
/*
Name: utsav gautam 
User Id: dbs211_231zaa50
Student Id: 157891219
Date: 26 Jan 2023
Purpose: DBS211C50-Lab 03
*/

-- Answer 1
SELECT * FROM offices; 

-- Answer 2 
SELECT employeenumber 
FROM employees
where officecode  = 1;

-- Answer 3 
SELECT customernumber, customername, contactfirstname, contactlastname, phone
FROM customers
WHERE upper(city) = 'PARIS'; 

-- Answer 4 
SELECT customernumber, customername, contactlastname ||','|| contactfirstname As contact, phone 
FROM customers
WHERE upper(country) = 'CANADA' ;

-- Answer 5 
SELECT DISTINCT customernumber
From payments;

-- Answer 6 
SELECT customernumber, checknumber, amount
FROM payments 
WHERE amount NOT BETWEEN 30000 AND 65000
ORDER BY amount DESC; 

-- Answer 7 
SELECT * FROM orders
WHERE LOWER(status) LIKE 'cancelled'; 

-- Answer 8
SELECT productcode, productname, buyprice, msrp, msrp - buyprice AS markup,
ROUND (100 * (msrp - buyprice) / buyprice,1) AS percmarkup
FROM products; 

-- Answer 9 
SELECT *  FROM products 
WHERE UPPER(productname) LIKE '%CO%'; 

-- Answer 10 
SELECT * FROM customers
WHERE UPPER(contactfirstname) LIKE 'S%E%';  

-- Answer 11 
INSERT INTO employees (employeenumber, lastname, firstname, extension, email, officecode, reportsto, jobtitle)
VALUES (1110, 'Gautam', 'Utsav', 'x17', 'ugautam4@myseneca.ca', 4, 1088, 'Cashier'); 

--  Answer 12
SELECT * FROM employees 
WHERE employeenumber = 1110; 

-- Answer 13 
UPDATE employees
SET jobtitle = 'Head Cashier' 
WHERE employeenumber = 1110; 

-- Answer 14
INSERT INTO employees (employeenumber, lastname, firstname, extension, email, officecode, reportsto, jobtitle) 
VALUES (2, 'Frankson', 'Elliot', 'x11212', 'elliot7@yahoo.com', 4, 1110, 'Cashier'); 

-- Answer 15 
DELETE FROM employees
WHERE employeenumber = 1110; 
/* Did not work integrity constraints violated 
we cannot delete parent record without deleting child record */

-- Answer 16
DELETE FROM employees
WHERE employeenumber = 2; 
DELETE FROM employees 
WHERE employeenumber = 1110; 
/* Yes it worked */

-- Answer 17
INSERT ALL 
INTO employees VALUES (1110, 'Gautam', 'Utsav', 'x17', 'ugautam4@myseneca.ca', 4, 1088, 'Head Cashier')
INTO employees VALUES (2, 'Frankson', 'Elliot', 'x11212', 'elliot7@yahoo.com', 4, 1088, 'Cashier')
SELECT * FROM dual; 

-- Answer 18 
DELETE FROM employees
WHERE employeenumber = 1110 OR employeenumber = 2; 