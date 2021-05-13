-- SQL Exercises 7

CREATE TABLE Employee (
  EmployeeID INTEGER PRIMARY KEY,
  Name VARCHAR(255) NOT NULL,
  Position VARCHAR(255) NOT NULL,
  Salary REAL NOT NULL,
  Remarks VARCHAR(255)
); 

CREATE TABLE Planet (
  PlanetID INTEGER PRIMARY KEY,
  Name VARCHAR(255) NOT NULL,
  Coordinates REAL NOT NULL
); 

CREATE TABLE Shipment (
  ShipmentID INTEGER PRIMARY KEY,
  Dated DATE,
  Manager INTEGER NOT NULL,
  Planet INTEGER NOT NULL,
  FOREIGN KEY (Manager) REFERENCES Employee(EmployeeID),
  FOREIGN KEY (Planet) REFERENCES Planet(PlanetID)
);

CREATE TABLE Has_Clearance (
  Employee INTEGER NOT NULL,
  Planet INTEGER NOT NULL,
  Levels INTEGER NOT NULL,
  FOREIGN KEY (Employee) REFERENCES Employee(EmployeeID),
  FOREIGN KEY (Planet) REFERENCES Planet(PlanetID)
); 

CREATE TABLE Client (
  AccountNumber INTEGER PRIMARY KEY,
  Name VARCHAR(255) NOT NULL
);
  
CREATE TABLE Package (
  Shipment INTEGER NOT NULL,
  PackageNumber INTEGER NOT NULL,
  Contents VARCHAR(255) NOT NULL,
  Weight REAL NOT NULL,
  Sender INTEGER NOT NULL,
  Recipient INTEGER NOT NULL,
  PRIMARY KEY(Shipment, PackageNumber),
  FOREIGN KEY (Shipment) REFERENCES Shipment(ShipmentID),
  FOREIGN KEY (Sender) REFERENCES Client(AccountNumber),
  FOREIGN KEY (Recipient) REFERENCES Client(AccountNumber)
);

BEGIN
INSERT INTO Client VALUES(1, 'Zapp Brannigan');
INSERT INTO Client VALUES(2, 'Al Gores Head');
INSERT INTO Client VALUES(3, 'Barbados Slim');
INSERT INTO Client VALUES(4, 'Ogden Wernstrom');
INSERT INTO Client VALUES(5, 'Leo Wong');
INSERT INTO Client VALUES(6, 'Lrrr');
INSERT INTO Client VALUES(7, 'John Zoidberg');
INSERT INTO Client VALUES(8, 'John Zoidfarb');
INSERT INTO Client VALUES(9, 'Morbo');
INSERT INTO Client VALUES(10, 'Judge John Whitey');
INSERT INTO Client VALUES(11, 'Calculon');
END;
/

BEGIN
INSERT INTO Employee VALUES(1, 'Phillip J. Fry', 'Delivery boy', 7500.0, 'Not to be confused with the Philip J. Fry from Hovering Squid World 97a');
INSERT INTO Employee VALUES(2, 'Turanga Leela', 'Captain', 10000.0, NULL);
INSERT INTO Employee VALUES(3, 'Bender Bending Rodriguez', 'Robot', 7500.0, NULL);
INSERT INTO Employee VALUES(4, 'Hubert J. Farnsworth', 'CEO', 20000.0, NULL);
INSERT INTO Employee VALUES(5, 'John A. Zoidberg', 'Physician', 25.0, NULL);
INSERT INTO Employee VALUES(6, 'Amy Wong', 'Intern', 5000.0, NULL);
INSERT INTO Employee VALUES(7, 'Hermes Conrad', 'Bureaucrat', 10000.0, NULL);
INSERT INTO Employee VALUES(8, 'Scruffy Scruffington', 'Janitor', 5000.0, NULL);
END;
/

BEGIN
INSERT INTO Planet VALUES(1, 'Omicron Persei 8', 89475345.3545);
INSERT INTO Planet VALUES(2, 'Decapod X', 65498463216.3466);
INSERT INTO Planet VALUES(3, 'Mars', 32435021.65468);
INSERT INTO Planet VALUES(4, 'Omega III', 98432121.5464);
INSERT INTO Planet VALUES(5, 'Tarantulon VI', 849842198.354654);
INSERT INTO Planet VALUES(6, 'Cannibalon', 654321987.21654);
INSERT INTO Planet VALUES(7, 'DogDoo VII', 65498721354.688);
INSERT INTO Planet VALUES(8, 'Nintenduu 64', 6543219894.1654);
INSERT INTO Planet VALUES(9, 'Amazonia', 65432135979.6547);
END;
/

BEGIN
INSERT INTO Has_Clearance VALUES(1, 1, 2);
INSERT INTO Has_Clearance VALUES(1, 2, 3);
INSERT INTO Has_Clearance VALUES(2, 3, 2);
INSERT INTO Has_Clearance VALUES(2, 4, 4);
INSERT INTO Has_Clearance VALUES(3, 5, 2);
INSERT INTO Has_Clearance VALUES(3, 6, 4);
INSERT INTO Has_Clearance VALUES(4, 7, 1);
END;
/

BEGIN
INSERT INTO Shipment VALUES(1, '05/11/3004', 1, 1);
INSERT INTO Shipment VALUES(2, '05/11/3004', 1, 2);
INSERT INTO Shipment VALUES(3, NULL, 2, 3);
INSERT INTO Shipment VALUES(4, NULL, 2, 4);
INSERT INTO Shipment VALUES(5, NULL, 7, 5);
END;
/

BEGIN
INSERT INTO Package VALUES(1, 1, 'Undeclared', 1.5, 1, 2);
INSERT INTO Package VALUES(2, 1, 'Undeclared', 10.0, 2, 3);
INSERT INTO Package VALUES(2, 2, 'A bucket of krill', 2.0, 8, 7);
INSERT INTO Package VALUES(3, 1, 'Undeclared', 15.0, 3, 4);
INSERT INTO Package VALUES(3, 2, 'Undeclared', 3.0, 5, 1);
INSERT INTO Package VALUES(3, 3, 'Undeclared', 7.0, 2, 3);
INSERT INTO Package VALUES(4, 1, 'Undeclared', 5.0, 4, 5);
INSERT INTO Package VALUES(4, 2, 'Undeclared', 27.0, 1, 2);
INSERT INTO Package VALUES(5, 1, 'Undeclared', 100.0, 5, 1);
END;
/

SELECT E.name FROM employee E
    INNER JOIN shipment S ON
    E.employeeId = S.manager
    INNER JOIN package P ON
    S.shipmentId = P.packagenumber
WHERE P.weight = 1.5; --Sender, not the right answer. Needs to be recipient 

SELECT C.name FROM client C
    INNER JOIN package P ON
    C.accountnumber = P.recipient
WHERE P.weight = 1.5; --7.1 

SELECT SUM(P.weight) FROM package P
WHERE sender = (
    SELECT recipient FROM package
    WHERE weight = 1.5
); --7.2
