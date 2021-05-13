-- SQL Exercises #2

CREATE TABLE Departments (
  Code INTEGER PRIMARY KEY,
  Name varchar(255) NOT NULL ,
  Budget decimal NOT NULL 
);

CREATE TABLE Employees (
  SSN INTEGER PRIMARY KEY,
  Name varchar(255) NOT NULL ,
  LastName varchar(255) NOT NULL ,
  Department INTEGER NOT NULL , 
  foreign key (department) references Departments(Code) 
);

BEGIN
INSERT INTO Departments(Code,Name,Budget) VALUES(14,'IT',65000);
INSERT INTO Departments(Code,Name,Budget) VALUES(37,'Accounting',15000);
INSERT INTO Departments(Code,Name,Budget) VALUES(59,'Human Resources',240000);
INSERT INTO Departments(Code,Name,Budget) VALUES(77,'Research',55000);
END;
/

BEGIN
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('123234877','Michael','Rogers',14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('152934485','Anand','Manikutty',14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('222364883','Carol','Smith',37);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('326587417','Joe','Stevens',37);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('332154719','Mary-Anne','Foster',14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('332569843','George','ODonnell',77);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('546523478','John','Doe',59);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('631231482','David','Smith',77);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('654873219','Zacary','Efron',59);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('745685214','Eric','Goldsmith',59);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('845657245','Elizabeth','Doe',14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('845657246','Kumar','Swamy',14);
END;
/

--2.1 Select the last name of all employees
SELECT lastname FROM employees;

--2.2 Select the last name of all employees, without duplicates.
SELECT DISTINCT lastname FROM employees;

--2.3 Select all teh data of employees whose last name is "Smith".
SELECT * FROM employees
WHERE lastname = 'Smith';

--2.4 Select all the data of employees whose last name is "Smith" and "Doe".
SELECT * FROM employees
WHERE lastname = 'Smith'
OR lastname = 'Doe';

--2.5 Select all the data of employees that work in department 14
SELECT * FROM employees
WHERE department = 14;

--2.6 Select all the data of employees that work in department 37 or department 77.
SELECT * FROM employees
WHERE department = 37
OR department = 77;

--2.7 Select all the data of employees whose last name begins with an "S".
SELECT * FROM employees
WHERE lastname LIKE 'S%';

--2.8 Select the sum of all the departments' budgets.
SELECT SUM(budget) FROM departments;

--2.9 Select the number of employees in each department ( You only need to show the department code and the number of employees).
SELECT department, COUNT(*) FROM employees
GROUP BY department;

--2.10 Select all the data of employees, including each employee's department's data.
SELECT E.*, D.name FROM employees E
JOIN departments D
ON E.department = D.code;

--2.11 Select the name and last name of each employee, along with the name and budget of the employee's department.
SELECT E.name AS "First Name", E.lastname AS "Last Name", D.name AS "Department", D.budget AS "Budget" FROM employees E
JOIN departments D
ON E.department = D.code;

--2.12 Select the name and last name of employees working for departments with a budget greater than $60,000.
SELECT E.name AS "First Name", E.lastname AS "Last Name" FROM employees E
INNER JOIN departments D
ON E.department = D.code
WHERE D.budget > 60000;

--2.13 Select the departments with a budget larger than the average budget of all the departments.
SELECT name FROM departments
WHERE budget > (
    SELECT AVG(budget) FROM departments
);

--2.14 Select the names of departments with more than two employees.
SELECT D.name FROM departments D
JOIN employees E
ON D.code = E.department
GROUP BY D.name
HAVING COUNT(E.department) > 2;

--2.15 Very Important - Select the name and last name of employees working for departments with second lowest budget.
SELECT E.name AS "First Name", E.lastname AS "Last Name" FROM employees E
JOIN departments D 
ON E.department = D.code
WHERE D.budget = (
    SELECT budget FROM departments
    WHERE budget IN (
        SELECT budget FROM departments
        ORDER BY budget ASC
        FETCH FIRST 2 ROWS ONLY
    )
    ORDER BY budget DESC
    FETCH FIRST 1 ROWS ONLY
);

--2.16 Add a new department called "Quality Assurance", with a budget of $40,000 and departmental code 11. 
-- And Add an employee called "Mary Moore" in that department, with SSN 847-21-9811.

INSERT INTO departments VALUES (11, 'Quality Assurance', 40000);
INSERT INTO employees VALUES (847219811, 'Mary', 'Moore', 11);

--2.17 Reduce the budget of all departments by 10%.

UPDATE departments
SET budget = budget * 0.90;

--2.18 Reassign all employees from the Research department (code 77) to the IT department (code 14).

UPDATE employees
SET department = 14
WHERE department = 77;

--2.19 Delete from the table all employees in the IT department (code 14).

DELETE FROM employees
WHERE department = 14;

--2.20 Delete from the table all employees who work in departments with a budget greater than or equal to $60,000.

DELETE FROM employees
WHERE department IN (
    SELECT code FROM department
    WHERE budget >= 60000
);

--2.21 Delete from the table all employees.

DELETE FROM employees;
