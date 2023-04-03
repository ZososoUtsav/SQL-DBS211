/*
Sequential order to create the tables without any errors
supplier
store
products
transactions
customers
orders
orderDetails
productSupply
inventory
*/
CREATE TABLE customers (
    cusID INT PRIMARY KEY,
    cusFirstName VARCHAR(25),
    custLastName VARCHAR(25) DEFAULT 'Walk-in' NOT NULL,
    gender CHAR(1), 
    age INT,
    phone CHAR(10),
    email VARCHAR(40),
    CONSTRAINT chk_gender CHECK (gender IN ('M', 'F', 'O')),
    CONSTRAINT chk_age CHECK (age >= 0 AND age <= 120));

CREATE TABLE orders (
    orderNo INT PRIMARY KEY,
    orderDate DATE NOT NULL,
    cusID INT NOT NULL,
    empID INT NOT NULL,
    storeID INT NOT NULL,
    tranID INT NOT NULL,
    CONSTRAINT fk_cusID FOREIGN KEY (cusID) REFERENCES customers(cusID),
    CONSTRAINT fk_empID FOREIGN KEY (empID) REFERENCES employees(empID),
    CONSTRAINT fk_storeID FOREIGN KEY (storeID) REFERENCES store(storeID),
    CONSTRAINT fk_tranID FOREIGN KEY (tranID) REFERENCES transactions(tranID)
);

CREATE TABLE orderDetails (
    orderNo INT NOT NULL,
    productID INT NOT NULL,
    type VARCHAR(4) NOT NULL,
    size CHAR(1) NOT NULL,
    qty INT NOT NULL,
    PRIMARY KEY (orderNo, productID),
    CONSTRAINT fk_orderNo FOREIGN KEY (orderNo) REFERENCES orders(orderNo),
    CONSTRAINT fk_productId FOREIGN KEY (productId) REFERENCES products(productId),
    CONSTRAINT chk_type CHECK (type IN ('hot', 'cold')),
    CONSTRAINT chk_size CHECK (size IN ('S', 'L'))
);

CREATE TABLE transactions (
    tranID INT PRIMARY KEY,
    method VARCHAR(25) NOT NULL,
    cardNo CHAR(16),
    CONSTRAINT chk_method CHECK (method IN ('cash', 'credit', 'debit'))
);

CREATE TABLE products (
    productID INT PRIMARY KEY,
    productName VARCHAR(25) NOT NULL,
    productDes VARCHAR(100) NOT NULL,
    unitPrice DECIMAL(6,2) NOT NULL CHECK (unitPrice >= 0)
);

CREATE TABLE inventory (
    productID INT NOT NULL,
    storeID INT NOT NULL,
    stock INT NOT NULL,
    maxStock INT NOT NULL,
    PRIMARY KEY (productID, storeID),
    CONSTRAINT fk_productIdCheck FOREIGN KEY (productID) REFERENCES products(productID),
    CONSTRAINT fk_storeIDCh FOREIGN KEY (storeID) REFERENCES store(storeID)
);

CREATE TABLE productSupply (
    storeID INT NOT NULL,
    productID INT NOT NULL,
    supplierID INT NOT NULL,
    PRIMARY KEY (storeID, productID, supplierID),
    CONSTRAINT fk_storeID FOREIGN KEY (storeID) REFERENCES store(storeID),
    CONSTRAINT fk_productID FOREIGN KEY (productID) REFERENCES products(productID),
    CONSTRAINT fk_supplierID FOREIGN KEY (supplierID) REFERENCES suppliers(supplierID)
);

CREATE TABLE suppliers (
    supplierID INT PRIMARY KEY,
    supplierName VARCHAR(50) NOT NULL,
    supplierAddress VARCHAR(100) NOT NULL,
    supplierCity VARCHAR(50) NOT NULL,
    supplierProvince VARCHAR(50) NOT NULL,
    supplierPostalCode CHAR(6) NOT NULL,
    supplierPhone CHAR(10) NOT NULL,
    supplierEmail VARCHAR(40) NOT NULL
);

CREATE TABLE store (
    storeID INT PRIMARY KEY,
    storeName VARCHAR(50) NOT NULL,
    storeAddress VARCHAR(100) NOT NULL,
    storeCity VARCHAR(50) NOT NULL,
    storeProvince VARCHAR(50) NOT NULL,
    storePostalCode CHAR(6) NOT NULL,
    storePhone CHAR(10) NOT NULL,
    storeEmail VARCHAR(40) NOT NULL
);

