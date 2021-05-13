-- SQL exercise Questions #9
-- .csv file was uploaded to be used for this set of questions

SELECT * FROM downloads;


--9.1
SELECT COUNT(*) FROM downloads;

--9.2
SELECT COUNT(DISTINCT package) FROM downloads;

--9.3
SELECT COUNT(*) FROM downloads
WHERE package = 'Rcpp';

--9.4
SELECT COUNT(*) FROM downloads
WHERE country = 'CN';

--9.5
SELECT package, COUNT(*) AS "Download Times" FROM downloads
GROUP BY package
ORDER BY 2 DESC;

--9.6
SELECT package, count(*) FROM downloads
WHERE time BETWEEN '09:00' AND '11:00'
GROUP BY package
ORDER BY 2 DESC;

--9.7
SELECT COUNT(*) FROM downloads
WHERE country = 'CN'
OR country = 'JP'
OR country = 'SG';

--9.8
SELECT Temp.country FROM (
    SELECT country, COUNT(*) AS downloaded FROM downloads
    GROUP BY country
) Temp
WHERE Temp.downloaded > (
    SELECT COUNT(*) FROM downloads
    WHERE country = 'CN'
);

--9.9 
SELECT AVG(LENGTH(temp.package)) FROM (
    SELECT DISTINCT package FROM downloads
) temp;

--9.10
SELECT Temp.PK AS "package", Temp.CT AS "count" FROM 
(
    SELECT package PK, COUNT(*) CT FROM downloads
    GROUP BY package
    ORDER BY CT DESC
    FETCH FIRST 2 ROWS ONLY
) Temp
ORDER BY Temp.CT ASC
FETCH FIRST 1 ROWS ONLY;

--9.11
SELECT Temp.package FROM (
    SELECT package, COUNT(*) b FROM downloads
    GROUP BY package
) Temp
WHERE Temp.b > 1000;

--Alternate Solution
SELECT package FROM downloads
GROUP BY package
HAVING COUNT(*) > 1000;
