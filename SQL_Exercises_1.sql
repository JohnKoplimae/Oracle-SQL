-- SQL Exercises #1

CREATE TABLE Manufacturers (
  Code INTEGER,
  Name VARCHAR(255) NOT NULL,
  PRIMARY KEY (Code)   
);

CREATE TABLE Products (
  Code INTEGER,
  Name VARCHAR(255) NOT NULL ,
  Price DECIMAL NOT NULL ,
  Manufacturer INTEGER NOT NULL,
  PRIMARY KEY (Code), 
  FOREIGN KEY (Manufacturer) REFERENCES Manufacturers(Code)
) ENGINE=INNODB;

INSERT INTO Manufacturers(Code,Name) VALUES(1,'Sony');
INSERT INTO Manufacturers(Code,Name) VALUES(2,'Creative Labs');
INSERT INTO Manufacturers(Code,Name) VALUES(3,'Hewlett-Packard');
INSERT INTO Manufacturers(Code,Name) VALUES(4,'Iomega');
INSERT INTO Manufacturers(Code,Name) VALUES(5,'Fujitsu');
INSERT INTO Manufacturers(Code,Name) VALUES(6,'Winchester');

INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(1,'Hard drive',240,5);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(2,'Memory',120,6);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(3,'ZIP drive',150,4);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(4,'Floppy disk',5,6);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(5,'Monitor',240,1);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(6,'DVD drive',180,2);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(7,'CD drive',90,2);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(8,'Printer',270,3);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(9,'Toner cartridge',66,3);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(10,'DVD burner',180,2);

--1.1
SELECT name FROM products;

--1.2
SELECT name, price FROM products;

--1.3
SELECT name FROM products
WHERE price <= 200;

--1.4
SELECT * FROM products
WHERE price BETWEEN 60 AND 120;

--1.5
SELECT name, price*100 AS "Price in Cents" FROM products;

--1.6
SELECT AVG(price) AS "Average Price" FROM products;

--1.7
SELECT AVG(price) AS "Average Price" FROM products
WHERE manufacturer = 2;

--1.8
SELECT COUNT(*) FROM products
WHERE price >= 180;

--1.9
SELECT name, price FROM products
WHERE price >= 180
ORDER BY price DESC, name ASC;

--1.10
SELECT P.*, M.name FROM products P
JOIN manufacturers M 
ON P.manufacturer = M.code
ORDER BY P.code;

--1.11
SELECT P.name, P.price, M.name FROM products P
INNER JOIN manufacturers M
ON P.manufacturer = M.code;

--1.12
SELECT manufacturer, AVG(price) AS "Average" FROM products 
GROUP BY manufacturer
ORDER BY manufacturer;

--1.13
SELECT M.name, AVG(P.price) AS "Average Price" FROM products P
JOIN manufacturers M 
ON P.manufacturer = M.code
GROUP BY M.name;

--1.14
SELECT M.name, AVG(P.price) AS "Average Price" FROM products P
JOIN manufacturers M 
ON P.manufacturer = M.code
GROUP BY M.name
HAVING AVG(P.price) >= 150;

--1.15
SELECT name, price FROM products
WHERE price = (
    SELECT MIN(price) FROM products
);

---1.16
SELECT M.name, P.name, P.price FROM products P
INNER JOIN manufacturers M
ON P.manufacturer = M.code
WHERE P.price IN (
    SELECT MAX(price) FROM products
    GROUP BY manufacturer
);

--1.17
INSERT INTO products VALUES (11, 'Loudspeaker', 70, 2);

--1.18
UPDATE products
SET name = 'Laser Printer'
WHERE code = 8;

--1.19
UPDATE products
SET price = price*0.9;

--1.20
UPDATE products
SET price = price*0.9
WHERE price >= 120;
