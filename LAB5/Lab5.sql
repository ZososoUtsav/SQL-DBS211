SET AUTOCOMMIT ON; 
/* 
Name: Utsav Gautam
oracle-id: dbs211_231zaa50
student-id: 157891219
Purpose: Lab5
Date: 8th Feb
*/

-- Answer no.1 
SELECT employees.employeenumber, employees.firstname,employees.lastname, offices.city, offices.phone, offices.postalcode
FROM employees
INNER JOIN offices  
ON employees.officecode = offices.officecode
WHERE UPPER(offices.country) LIKE 'FRANCE';

-- Answer no.2
SELECT customers.customernumber, customers.customername, to_char(payments.paymentdate, 'mon dd, yyyy') AS paymentdate,  payments.amount
FROM customers
INNER JOIN payments
ON customers.customernumber = payments.customernumber AND payments.paymentdate IS NOT NULL
WHERE UPPER(country) LIKE 'CANADA'
ORDER BY customers.customernumber; 

-- Answer no.3
SELECT customers.customernumber, customers.customername
FROM customers LEFT JOIN payments
ON customers.customernumber = payments.customernumber 
WHERE UPPER(customers.country) LIKE 'USA' AND payments.paymentdate IS NULL
ORDER BY customers.customernumber; 

-- Answer no.4 a
CREATE VIEW vwCustomerOrder AS
(SELECT orders.customernumber, orders.ordernumber, orders.orderdate, products.productname, orderdetails.quantityordered, orderdetails.priceeach
FROM orders INNER JOIN orderdetails 
ON orders.ordernumber = orderdetails.ordernumber
INNER JOIN  products 
ON orderdetails.productcode = products.productcode) ; 

-- Answer no.4 b
SELECT * FROM vwCustomerOrder; 

-- Answer no.5

SELECT * 
FROM vwCustomerOrder v
INNER JOIN orderdetails od
ON od.ordernumber = v.ordernumber
WHERE customernumber = 124
ORDER BY v.ordernumber , od.orderlinenumber; 

-- Answer no.6

SELECT cst.customernumber, cst.contactfirstname, cst.contactlastname,cst.phone,cst.creditlimit
FROM customers cst LEFT JOIN orders odr
ON cst.customernumber = odr.customernumber
WHERE odr.ordernumber IS NULL ; 

-- Answer no.7 

CREATE VIEW vwEmployeeManager AS 
(SELECT empl.employeenumber ,empl.lastname, empl.firstname, empl.extension, empl.email, empl.officecode,empl.reportsto, empl.jobtitle,man.firstname AS "managerFirstName",man.lastname AS "managersLastName"
FROM employees empl 
LEFT JOIN  employees man
ON empl.reportsto = man.employeenumber); 

-- Answer no.8 

CREATE OR REPLACE VIEW vwEmployeeManager AS 
(SELECT empl.employeenumber ,empl.lastname, empl.firstname, empl.extension, empl.email, empl.officecode,empl.reportsto, empl.jobtitle,man.firstname AS "managerFirstName",man.lastname AS "managersLastName"
FROM employees empl 
INNER JOIN employees man
ON empl.reportsto = man.employeenumber);

-- Answer no.9 
DROP VIEW vwCustomerOrder; 
DROP VIEW vwEmployeeManager

