------------------------------------------HOTEL RESERVATION ANALYSIS-------------------------------------------------------

--KPIS REQUIREMENTS
--1.REVENUE.
--Total Reevue

SELECT 
      SUM(Total_Amount)
FROM Hotel_Reservations_Data

--1a.YTD Revenue.
--First of all , extract booking Year from the Booking Dates.


ALTER TABLE Hotel_Reservations_Data
ADD Booking_Year INT

UPDATE Hotel_Reservations_Data
SET Booking_Year = YEAR(Booking_Date)

SELECT *
FROM Hotel_Reservations_Data

--YTD Revenue

SELECT 
      SUM(Total_Amount)  as YTD_Revenue
FROM Hotel_Reservations_Data
WHERE "Booking_Year" = 2023

--PYTD Revenue

SELECT 
      SUM(Total_Amount)  as PYTD_Revenue
FROM Hotel_Reservations_Data
WHERE "Booking_Year" = 2022


--YoY Change in Revenue

SELECT
ROUND(
 100 * (
      CAST((SELECT SUM(Total_Amount)  FROM Hotel_Reservations_Data WHERE "Booking_Year" = 2023) AS FLOAT)-
	  CAST((SELECT SUM(Total_Amount)  FROM Hotel_Reservations_Data WHERE "Booking_Year" = 2022) AS FLOAT))/
	  CAST((SELECT SUM(Total_Amount)  FROM Hotel_Reservations_Data WHERE "Booking_Year" = 2022) AS FLOAT), 1) as YoY_Pct_Rev_Change

--2.ROOM COUNT.

SELECT 
     MAX(Room_number) as Number_of_Rooms
FROM Hotel_Reservations_Data

--3.RESERVATIONS
--YTD Reservations

SELECT 
     COUNT(Reservation_ID)  as YTD_Reservation
FROM Hotel_Reservations_Data
WHERE "Booking_Year" = 2023

--PYTD Reservations

SELECT 
     COUNT(Reservation_ID)  as PYTD_Reservation
FROM Hotel_Reservations_Data
WHERE "Booking_Year" = 2022

--YoY pct Change in Reservation

SELECT
ROUND(
 100 * (
      CAST((SELECT COUNT(Reservation_ID)  FROM Hotel_Reservations_Data WHERE "Booking_Year" = 2023) AS FLOAT)-
	  CAST((SELECT COUNT(Reservation_ID)  FROM Hotel_Reservations_Data WHERE "Booking_Year" = 2022) AS FLOAT))/
	  CAST((SELECT COUNT(Reservation_ID)  FROM Hotel_Reservations_Data WHERE "Booking_Year" = 2022) AS FLOAT), 1) as YoY_Pct_Reservation_Change

--4.GUESTS
--YTD Total Guests

SELECT 
     SUM("Adults" + "Children") as YTD_Total_Guests
FROM Hotel_Reservations_Data
WHERE "Booking_Year" = 2023

--PYTD Total Guests

SELECT 
     SUM("Adults" + "Children") as PYTD_Total_Guests
FROM Hotel_Reservations_Data
WHERE "Booking_Year" = 2022

--YoY pct change in total guests

SELECT
ROUND(
 100 * (
      CAST((SELECT SUM("Adults" + "Children") FROM Hotel_Reservations_Data WHERE "Booking_Year" = 2023) AS FLOAT)-
	  CAST((SELECT SUM("Adults" + "Children") FROM Hotel_Reservations_Data WHERE "Booking_Year" = 2022) AS FLOAT))/
	  CAST((SELECT SUM("Adults" + "Children") FROM Hotel_Reservations_Data WHERE "Booking_Year" = 2022) AS FLOAT), 1) as YoY_Pct_Guests_Change

--5.NATIONALITIES
SELECT 
       DISTINCT(Nationality)
FROM Hotel_Reservations_Data


SELECT 
     Nationality,
     COUNT(Reservation_ID) as Reservation_per_country
FROM Hotel_Reservations_Data 
GROUP BY Nationality
ORDER BY 2 DESC

--CHARTS REQUIREMENT.

--Reservation source.

SELECT 
     Reservation_Source,
     COUNT(Reservation_ID) as Res_count_per_source
FROM Hotel_Reservations_Data
GROUP BY Reservation_Source
ORDER BY 2 DESC

--Reservation by Payment methods

SELECT 
     Mode_of_Payment,
     COUNT(Mode_of_Payment) Res_as_mode_of_pmt 
FROM Hotel_Reservations_Data
GROUP BY Mode_of_Payment
ORDER BY 2 DESC

--Bookings by Months & Seasons
--YTD Reservations by Month

SELECT
     MONTH(Booking_Date) AS Month_no,
	 DATENAME(MONTH,Booking_Date) AS Month_Name,
     COUNT(Reservation_ID) as Reservation_per_month
FROM Hotel_Reservations_Data
WHERE Booking_Year = 2023
GROUP BY MONTH(Booking_Date),DATENAME(MONTH,Booking_Date)
ORDER BY 1

--PYTD Reservations by Month

SELECT
     MONTH(Booking_Date) AS Month_no,
	 DATENAME(MONTH,Booking_Date) AS Month_Name,
     COUNT(Reservation_ID) as Reservation_per_month
FROM Hotel_Reservations_Data
WHERE Booking_Year = 2022
GROUP BY MONTH(Booking_Date),DATENAME(MONTH,Booking_Date)
ORDER BY 1

--BY Seasons
--Adding Month Column.
ALTER TABLE Hotel_Reservations_Data
ADD Month_Name VARCHAR(50)

SELECT *
FROM Hotel_Reservations_Data

UPDATE Hotel_Reservations_Data
SET Month_Name = DATENAME(MONTH, Booking_Date)

--Adding Seasons column

ALTER TABLE Hotel_Reservations_Data
ADD Seasons VARCHAR(50)

UPDATE Hotel_Reservations_Data
SET Month_Name

SELECT
    Reservation_ID,
    CASE
        WHEN Month_Name IN ('December', 'January', 'February') THEN 'Winter'
        WHEN Month_Name IN ('March', 'April', 'May') THEN 'Spring'
        WHEN Month_Name IN ('June', 'July', 'August') THEN 'Summer'
        WHEN Month_Name IN ('September', 'October', 'November') THEN 'Autumn'
        END AS Seasons
FROM Hotel_Reservations_Data

UPDATE Hotel_Reservations_Data
SET Seasons = (
    (CASE
        WHEN Month_Name IN ('December', 'January', 'February') THEN 'Winter'
        WHEN Month_Name IN ('March', 'April', 'May') THEN 'Spring'
        WHEN Month_Name IN ('June', 'July', 'August') THEN 'Summer'
        WHEN Month_Name IN ('September', 'October', 'November') THEN 'Autumn'
		END)
   )

--YTD Seasons Reservations

SELECT
     Seasons,
     COUNT(Reservation_ID) as Reservation_per_season
FROM Hotel_Reservations_Data
WHERE Booking_Year = 2023
GROUP BY Seasons
ORDER BY 2 DESC

--PYTD Seasons Reservations

SELECT
     Seasons,
     COUNT(Reservation_ID) as Reservation_per_season
FROM Hotel_Reservations_Data
WHERE Booking_Year = 2022
GROUP BY Seasons
ORDER BY 2 DESC


--Reservation by Gender
--YTD

SELECT
     Gender,
     COUNT(Reservation_ID) as Reservation_per_gender
FROM Hotel_Reservations_Data
WHERE Booking_Year = 2023
GROUP BY Gender
ORDER BY 2 DESC

--Reservation by Nationalities

SELECT
     Nationality,
     COUNT(Reservation_ID) as Reservation_per_nationality
FROM Hotel_Reservations_Data
WHERE Booking_Year = 2023
GROUP BY Nationality
ORDER BY 2 DESC























