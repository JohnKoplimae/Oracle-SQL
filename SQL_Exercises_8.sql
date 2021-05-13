-- Exercise questions from w3resource, Hospital dataset
-- Some values where set as NUMBER because Oracle does not support BOOLEAN

-- Q1 Write a query to find all the information of the nurses who are yet to be registered

SELECT * FROM nurse
WHERE registered = 0;

-- Q2 Write a query to find the name of the nurses who are the head of their department

SELECT name FROM nurse
WHERE position = 'Head Nurse';

-- Q3 Write a query to obtain the name of the physicians who are the head of each department

SELECT name FROM physician
WHERE employeeid IN (
    SELECT head FROM department
);

--Q4 Write a query to count the number of patients who have taken an appointment with at least one physician

SELECT count (DISTINCT patient) AS "Count" FROM appointment;

-- Q5 Write a query to find the floor and block where the room 212 is

SELECT blockfloor, blockcode from room
WHERE roomnumber = 212;

--Q6 Write a query to count the number of available rooms

SELECT count(*) FROM room
WHERE unavailable = 0;

--Q7 Write a query to count the number of unavailable rooms

SELECT count(*) FROM room
WHERE unavailable = 1;

--Q8 Write a query to obtain the name of the physician and the departments they are affiliated with.

SELECT P.name, D.name FROM physician P 
INNER JOIN affiliated_with A ON
P.employeeid = A.physician
INNER JOIN department D ON
A.department = D.departmentid;

-- Alternate solution

SELECT p.name AS "Physician",
       d.name AS "Department"
FROM physician p,
     department d,
     affiliated_with a
WHERE p.employeeid=a.physician
  AND a.department=d.departmentid;

-- Q9 Write a query to obtain the name of the physicians who are trained for a special treatment

SELECT name FROM physician 
WHERE employeeid IN (
    SELECT T.physician FROM trained_in T
    INNER JOIN procedures P ON
    P.code = T.treatment
);
-- Alternate: List of physicians and treatments

SELECT P.name AS "Physician", PR.name AS "Procedure" FROM physician P, procedures PR, trained_in T
WHERE PR.code = T.treatment
AND T.physician = P.employeeid;

-- Q10 Write a query to obtain the name of the physicians with no department affiliation. (Show position and department)

SELECT P.name AS "Physician", P.position AS "Position", D.name AS "Department" FROM physician P
INNER JOIN affiliated_with A ON
P.employeeid = A.physician
INNER JOIN department D ON
D.departmentid = A.department
WHERE primaryaffiliation = 0;

--Q11 Write a query to obtain the name of the physicians who are not a specialized physician.

SELECT P.name FROM physician P
WHERE NOT EXISTS (
    SELECT * FROM trained_in T
    WHERE P.employeeid = T.physician
);
-- ALternate solution
SELECT p.name AS "Physician",
       p.position "Designation"
FROM physician p
LEFT JOIN trained_in t ON p.employeeid=t.physician
WHERE t.treatment IS NULL;

-- Q12 Write a query to obtain the name of the patients with their physicians by whom they got their preliminary treatment

SELECT PA.name AS "Patient", P.name AS "physician" FROM patient PA
INNER JOIN physician P ON
PA.pcp = P.employeeid; 

--Q13 Write a query to find the name of the patients and the number of physicians they have taken an appointment with

SELECT PA.name, count(A.patient) AS "Physician Count" FROM patient PA
LEFT JOIN appointment A ON
A.patient = PA.ssn
GROUP BY PA.name
HAVING count(A.patient) >= 1;

--Q29 Write a query to obtain the nurses and the block where they are booked for attending the patients on call.

SELECT N.name AS "Nurse", O.blockcode AS "Block" FROM nurse N
INNER JOIN on_call O ON
N.employeeid = O.nurse;

--Q30 Write a query to make a report which will show:
-- a) Name of patient
-- b) name of the physician who is treating the patient
-- c) name of the nurse who is attending
-- d) which treatment is on going
-- e) the date of release
-- f) in which room the patient was admitted and which floor and block the room belongs to

SELECT PT.name AS "Patient", P.name AS "Physician", N.name AS "Nurse", PR.name AS "Procedure", ST.stayend AS "Release Date", R.roomnumber AS "Room", R.blockcode AS "Block", R.blockfloor AS "Floor"
FROM undergoes U
JOIN patient PT ON PT.ssn = U.patient
JOIN physician P ON P.employeeid = U.physician
LEFT JOIN nurse N ON U.assistingnurse = N.employeeid
JOIN stay ST ON ST.stayid = U.stay
JOIN room R ON R.roomnumber = ST.room
JOIN procedures PR ON PR.code = U.procedures;

-- Q31 Write a query to obtain the names of all the physicians who performed a medical procedure but they are not certified to perform it

SELECT name AS "Physician" FROM physician
WHERE employeeid IN (
    SELECT undergoes.physician FROM undergoes
    LEFT JOIN trained_in ON undergoes.physician = trained_in.physician
    AND undergoes.procedures = trained_in.treatment
    WHERE treatment IS NULL
);

--Q32 Write a query to obtain the names of all the physicians, their procedures, date when the procedure was carried out and the name of the patient on which
-- the procedure was carried out BUT those physicians are not certified for that procedure.

SELECT P.name AS "Physician", PR.name AS "Procedure", U.dateundergoes as "Procedure Date", PT.name AS "Patient" 
FROM physician P, undergoes U, patient PT, procedures PR
WHERE U.patient = PT.ssn
AND U.procedures = PR.code
AND U.physician = P.employeeid
AND NOT EXISTS (
    SELECT * FROM trained_in TR
    WHERE TR.treatment = U.procedures
    AND TR.physician = U.physician
);

--Q33 Write a query to obtain the name and position of all physicians who completed a medical procedure with an expired certification

SELECT P.name AS "Physician", TR.certificationexpires AS "Date Expired" FROM physician P
INNER JOIN trained_in TR ON P.employeeid = TR.physician
WHERE TR.treatment IN (
    SELECT U.procedures FROM undergoes U
    WHERE U.dateundergoes > TR.certificationexpires
);

--Q34 Write a query to obtain the name of all those physicians who completed a medical procedure with an expired certification, their position, procedure that was done,
-- date of the procedure, name of the patient, and date of expired certification.

SELECT P.name AS "Physician", P.position, PR.name AS "Procedure", U.dateundergoes "Date of Procedure", PT.name AS "Patient", TR.certificationexpires AS "Date Certification Expired"
FROM Physician P
INNER JOIN trained_in TR ON P.employeeid = TR.physician
INNER JOIN procedures PR ON TR.treatment = PR.code
INNER JOIN undergoes U ON PR.code = U.procedures
INNER JOIN patient PT ON U.patient = PT.ssn
WHERE TR.treatment IN (
    SELECT U.procedures FROM undergoes U
    WHERE U.dateundergoes > TR.certificationexpires
);

-- ALTERNATE SOLUTION 

SELECT p.name AS "Physician",
       p.position AS "Position",
       pr.name AS "Procedure",
       u.dateundergoes AS "Date of Procedure",
       pt.name AS "Patient",
       t.certificationexpires AS "Expiry Date of Certificate"
FROM physician p,
     undergoes u,
     patient pt,
     PROCEDUREs pr,
               trained_in t
WHERE u.patient = pt.ssn
  AND u.procedures = pr.code
  AND u.physician = p.employeeid
  AND Pr.code = t.treatment
  AND P.employeeid = t.physician
  AND u.Dateundergoes > t.certificationexpires;

  --Q35 Write a query to obtain the names of all the nurses who have ever been on call for room 122.

  SELECT N.name FROM nurse N
  WHERE N.employeeid IN (
      SELECT O.nurse FROM on_call O
      INNER JOIN room R ON O.blockfloor = R.blockfloor
      AND O.blockcode = R.blockcode
      WHERE R.roomnumber = 122
  );

-- Q36 Write a query to obtain the names of all patients who have been prescribed some medication by their primary care physician, include physicians name.

SELECT PT.name AS "Patient", P.name AS "Primary Care Physician" FROM patient PT
INNER JOIN physician P ON PT.pcp = P.employeeid
JOIN prescribes PS ON P.employeeid = PS.physician

-- ALTERNATE SOLUTION

SELECT pt.name AS "Patient",
       p.name AS "Physician"
FROM patient pt
JOIN prescribes pr ON pr.patient=pt.ssn
JOIN physician p ON pt.pcp=p.employeeid
WHERE pt.pcp=pr.physician
  AND pt.pcp=p.employeeid;

-- Q37 Write a query to obtain the names of all patients who have undergone a procedure that costs more then $5000 and the name of the physician who is their primary care.

SELECT PT.name AS "Patient", PR.name AS "Procedure", PR.cost AS "Procedure Price", P.name AS "Primary Care Physician" FROM patient PT
INNER JOIN physician P ON PT.pcp = P.employeeid
INNER JOIN undergoes U ON P.employeeid = U.physician
INNER JOIN procedures PR ON U.procedures = PR.code
WHERE PR.cost > 5000;

--Q38 Write a query to obtain the names of all patients who had at least two appointment where the nurse was registered and the physician has carried out primary care.

SELECT PT.name AS "Patient", N.name AS "Nurse", P.name AS "Primary Care Physician" FROM appointment AP
INNER JOIN patient PT ON AP.patient = PT.ssn
INNER JOIN physician P ON AP.physician = P.employeeid
INNER JOIN Nurse N ON AP.prepnurse = N.employeeid
WHERE AP.physician = PT.pcp
AND AP.prepnurse IN (
    SELECT N.employeeid FROM nurse 
    WHERE N.registered = 1)
AND AP.patient IN (
    SELECT AP.patient FROM appointment AP
    GROUP BY AP.patient
    HAVING count(*) >= 2
);

--Q39 Write a query to obtain the names of all patients whose primary care is taken by a physician who is not the head of any department, and name of their primary 
-- care physician.

SELECT PT.name AS "Patient", P.name AS "Physician" FROM patient PT
JOIN physician P ON PT.pcp = P.employeeid
WHERE PT.pcp NOT IN (
    SELECT head FROM department);
