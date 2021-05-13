-- SQL Exercises #5

CREATE TABLE Pieces (
 Code INTEGER PRIMARY KEY NOT NULL,
 Name TEXT NOT NULL
 );
CREATE TABLE Providers (
 Code VARCHAR(40) 
 PRIMARY KEY NOT NULL,  
 Name TEXT NOT NULL 
 );
CREATE TABLE Provides (
 Piece INTEGER, 
 FOREIGN KEY (Piece) REFERENCES Pieces(Code),
 Provider VARCHAR(40), 
 FOREIGN KEY (Provider) REFERENCES Providers(Code),  
 Price INTEGER NOT NULL,
 PRIMARY KEY(Piece, Provider) 
 );
 
-- alternative one for SQLite
  /* 
 CREATE TABLE Provides (
 Piece INTEGER,
 Provider VARCHAR(40),  
 Price INTEGER NOT NULL,
 PRIMARY KEY(Piece, Provider) 
 );
 */
 
 BEGIN
 
INSERT INTO Providers(Code, Name) VALUES('HAL','Clarke Enterprises');
INSERT INTO Providers(Code, Name) VALUES('RBT','Susan Calvin Corp.');
INSERT INTO Providers(Code, Name) VALUES('TNBC','Skellington Supplies');

INSERT INTO Pieces(Code, Name) VALUES(1,'Sprocket');
INSERT INTO Pieces(Code, Name) VALUES(2,'Screw');
INSERT INTO Pieces(Code, Name) VALUES(3,'Nut');
INSERT INTO Pieces(Code, Name) VALUES(4,'Bolt');

INSERT INTO Provides(Piece, Provider, Price) VALUES(1,'HAL',10);
INSERT INTO Provides(Piece, Provider, Price) VALUES(1,'RBT',15);
INSERT INTO Provides(Piece, Provider, Price) VALUES(2,'HAL',20);
INSERT INTO Provides(Piece, Provider, Price) VALUES(2,'RBT',15);
INSERT INTO Provides(Piece, Provider, Price) VALUES(2,'TNBC',14);
INSERT INTO Provides(Piece, Provider, Price) VALUES(3,'RBT',50);
INSERT INTO Provides(Piece, Provider, Price) VALUES(3,'TNBC',45);
INSERT INTO Provides(Piece, Provider, Price) VALUES(4,'HAL',5);
INSERT INTO Provides(Piece, Provider, Price) VALUES(4,'RBT',7);

END;
/

SELECT * FROM pieces;
SELECT * FROM provides;
SELECT * FROM providers;

SELECT name FROM pieces; --5.1

SELECT * FROM providers; --5.2

SELECT piece, AVG(price) FROM provides
GROUP BY piece; --5.3

SELECT name FROM providers
WHERE code IN (
    SELECT provider FROM provides
    WHERE piece = 1 
); --5.4

SELECT name FROM pieces
WHERE code IN (
    SELECT piece FROM provides
    WHERE provider = 'HAL'
); --5.5

SELECT pieces.name, providers.name, provides.price FROM provides
    LEFT JOIN providers ON
    provides.provider = providers.code
    LEFT JOIN pieces ON
    provides.piece = pieces.code
WHERE price IN (
    SELECT MAX(price) FROM provides
    WHERE provides.piece = pieces.code
); --5.6

INSERT INTO provides VALUES (1, 'TNBC', 7); --5.7

UPDATE provides
SET price = price + 1; --5.8

DELETE FROM provides
WHERE provider = 'RBT'
AND piece = 4; --5.9

DELETE FROM provides
WHERE provider = 'RBT'; --5.10
