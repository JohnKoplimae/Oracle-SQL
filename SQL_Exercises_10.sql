-- SQL Exercise #10

CREATE TABLE PEOPLE (id INTEGER, name CHAR);


INSERT INTO PEOPLE VALUES(1, 'A')
INSERT INTO PEOPLE VALUES(2, 'B')
INSERT INTO PEOPLE VALUES(3, 'C')
INSERT INTO PEOPLE VALUES(4, 'D')


-- ADDRESS: containing the history of address information of each ID.
CREATE TABLE ADDRESS (id INTEGER, address VARCHAR2 (20), updatedate date);

BEGIN
INSERT INTO ADDRESS VALUES(1, 'address-1-1', '01/01/2016')
INSERT INTO ADDRESS VALUES(1, 'address-1-2', '09/02/2016');
INSERT INTO ADDRESS VALUES(2, 'address-2-1', '11/01/2015');
INSERT INTO ADDRESS VALUES(3, 'address-3-1', '12/01/2016');
INSERT INTO ADDRESS VALUES(3, 'address-3-2', '09/11/2014');
INSERT INTO ADDRESS VALUES(3, 'address-3-3', '01/01/2015');
INSERT INTO ADDRESS VALUES(4, 'address-4-1', '05/21/2010');
INSERT INTO ADDRESS VALUES(4, 'address-4-2', '02/11/2012');
INSERT INTO ADDRESS VALUES(4, 'address-4-3', '04/27/2015');
INSERT INTO ADDRESS VALUES(4, 'address-4-4', '01/01/2014');
END;
/

--10.1
SELECT P.id, P.name, TEMP.dress FROM people P
LEFT JOIN (
    SELECT id, MAX(address) as dress FROM address
    GROUP BY id
) TEMP
ON P.id = TEMP.id
ORDER BY P.id;

--10.2
SELECT P.id, P.name, TEMP.dress FROM people P
LEFT JOIN (
    SELECT Ad.id, Ad.address as dress, Ad.updatedate FROM address Ad
   INNER JOIN (
        SELECT id, MAX(updatedate) as recent FROM address
        GROUP BY id
    ) TT
    ON Ad.updatedate = TT.recent
) TEMP
ON P.id = TEMP.id
ORDER BY P.id;
