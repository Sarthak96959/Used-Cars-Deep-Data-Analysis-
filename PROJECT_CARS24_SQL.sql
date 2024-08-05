create database cars_24;
use cars_24;
#RENAME THE FILE NAME 
ALTER TABLE cars_24_final_file112 
RENAME TO CARS;

# SEE THE ALL THE DATA 

SELECT * FROM CARS;

#The least expensive and most expensive cars for each brand along with their specifications.

WITH X AS (SELECT * , MAX(CAR_PRICE) OVER(PARTITION BY BRAND ) AS MAX_PRICE , MIN(CAR_PRICE) OVER(PARTITION BY BRAND) AS MIN_PRICE
FROM CARS)
SELECT * FROM X WHERE CAR_PRICE = MAX_PRICE OR CAR_PRICE = MIN_PRICE ORDER BY BRAND , CAR_PRICE DESC;


# A comparison of the average prices of cars from each brand this year to those from last year.


WITH 
X AS 
(SELECT BRAND , ROUND(AVG(CAR_PRICE),0) AS AVG_2020 FROM CARS WHERE CAR_MODAL = "2020" GROUP BY 1 ORDER BY 2 DESC)

,Y AS 
(SELECT BRAND , ROUND(AVG(CAR_PRICE),0) AS AVG_2019 FROM CARS WHERE CAR_MODAL = "2019"  GROUP BY 1 ORDER BY 2 DESC),

C AS 
(SELECT X.BRAND, AVG_2019,AVG_2020 FROM Y RIGHT JOIN X ON Y.BRAND = X.BRAND
UNION
SELECT Y.BRAND , AVG_2019 ,AVG_2020 FROM X RIGHT JOIN Y ON Y.BRAND = X.BRAND
ORDER BY BRAND)

SELECT BRAND , AVG_2019 ,AVG_2020 ,(AVG_2020-AVG_2019) AS INCREASING_PRICE FROM C ORDER BY 4 DESC
;




#TOTAL NUMBER OF THE BRANDS 

SELECT COUNT(DISTINCT BRAND) AS TOTAL_NUMBER_OF_BRAND_IN_INDIA FROM CARS;


# COUNT OF THE CARS OF EACH BRANDS AND THEIR TOTAL PRICES IN CR


SELECT BRAND , COUNT(BRAND) AS CAR_CONUNT , CONCAT(ROUND(SUM(CAR_PRICE)/10000000,0)," CR") AS TOTAL_CAR_PRICE
FROM CARS GROUP BY 1 ORDER BY 2 DESC;













