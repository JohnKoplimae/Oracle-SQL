-- SQL Exercises 6

create table Scientists (
  SSN int,
  Name Char(30) not null,
  Primary Key (SSN)
);

Create table Projects (
  Code Char(4),
  Name Char(50) not null,
  Hours int,
  Primary Key (Code)
);
	
create table AssignedTo (
  Scientist int not null,
  Project char(4) not null,
  Primary Key (Scientist, Project),
  Foreign Key (Scientist) references Scientists (SSN),
  Foreign Key (Project) references Projects (Code)
);


INSERT ALL
INTO Scientists(SSN,Name) VALUES(123234877,'Michael Rogers')
INTO Scientists(SSN,Name) VALUES(152934485,'Anand Manikutty')
INTO Scientists(SSN,Name) VALUES(222364883, 'Carol Smith')
INTO Scientists(SSN,Name) VALUES(326587417,'Joe Stevens')
INTO Scientists(SSN,Name) VALUES(332154719,'Mary-Anne Foster')
INTO Scientists(SSN,Name) VALUES(332569843,'George ODonnell')
INTO Scientists(SSN,Name) VALUES(546523478,'John Doe')
INTO Scientists(SSN,Name) VALUES(631231482,'David Smith')
INTO Scientists(SSN,Name) VALUES(654873219,'Zacary Efron')
INTO Scientists(SSN,Name) VALUES(745685214,'Eric Goldsmith')
INTO Scientists(SSN,Name) VALUES(845657245,'Elizabeth Doe')
INTO Scientists(SSN,Name) VALUES(845657246,'Kumar Swamy')
SELECT * FROM dual;

 INSERT ALL
 INTO Projects (Code, Name, Hours) VALUES ('AeH1','Winds: Studying Bernoullis Principle', 156)
       INTO Projects (Code, Name, Hours) VALUES('AeH2','Aerodynamics and Bridge Design',189)
       INTO Projects (Code, Name, Hours) VALUES('AeH3','Aerodynamics and Gas Mileage', 256)
       INTO Projects (Code, Name, Hours) VALUES('AeH4','Aerodynamics and Ice Hockey', 789)
       INTO Projects (Code, Name, Hours) VALUES('AeH5','Aerodynamics of a Football', 98)
       INTO Projects (Code, Name, Hours) VALUES('AeH6','Aerodynamics of Air Hockey',89)
       INTO Projects (Code, Name, Hours) VALUES('Ast1','A Matter of Time',112)
       INTO Projects (Code, Name, Hours) VALUES('Ast2','A Puzzling Parallax', 299)
       INTO Projects (Code, Name, Hours) VALUES('Ast3','Build Your Own Telescope', 6546)
       INTO Projects (Code, Name, Hours) VALUES('Bte1','Juicy: Extracting Apple Juice with Pectinase', 321)
       INTO Projects (Code, Name, Hours) VALUES('Bte2','A Magnetic Primer Designer', 9684)
       INTO Projects (Code, Name, Hours) VALUES('Bte3','Bacterial Transformation Efficiency', 321)
       INTO Projects (Code, Name, Hours) VALUES('Che1','A Silver-Cleaning Battery', 545)
       INTO Projects (Code, Name, Hours) VALUES('Che2','A Soluble Separation Solution', 778)
       SELECT * FROM dual;

 INSERT ALL
 INTO AssignedTo ( Scientist, Project) VALUES (123234877,'AeH1')
     INTO AssignedTo ( Scientist, Project) VALUES(152934485,'AeH3')
     INTO AssignedTo ( Scientist, Project) VALUES(222364883,'Ast3')
     INTO AssignedTo ( Scientist, Project) VALUES(326587417,'Ast3')
     INTO AssignedTo ( Scientist, Project) VALUES(332154719,'Bte1')
     INTO AssignedTo ( Scientist, Project) VALUES(546523478,'Che1')
     INTO AssignedTo ( Scientist, Project) VALUES(631231482,'Ast3')
     INTO AssignedTo ( Scientist, Project) VALUES(654873219,'Che1')
     INTO AssignedTo ( Scientist, Project) VALUES(745685214,'AeH3')
     INTO AssignedTo ( Scientist, Project) VALUES(845657245,'Ast1')
     INTO AssignedTo ( Scientist, Project) VALUES(845657246,'Ast2')
     INTO AssignedTo ( Scientist, Project) VALUES(332569843,'AeH4')
SELECT * FROM dual;

SELECT * FROM scientists;
SELECT * FROM projects;
SELECT * FROM assignedto;

-- 6.1 List all the scientists' names, their projects' names, 
    -- and the hours worked by that scientist on each project, 
    -- in alphabetical order of project name, then scientist name.

SELECT S.name, P.name, P.hours FROM Projects P
    INNER JOIN assignedto A ON
    A.project = P.code
    INNER JOIN scientists S ON
    A.scientist = S.ssn
ORDER BY P.name, S.name; --6.1

-- 6.2 Select the project names which are not assigned yet

SELECT name FROM Projects
WHERE code NOT IN (
    SELECT project FROM assignedto
); --6.2
 
