-- Import and combine 12 month trip data --
-- Looking into CSV data, I created a table named "combined_data".--
-- PostgreSQL allows you to directly import multiple CSV files without needing additional coding.--
-- Therefore, all CSV files imported into created table for further data preparation.--

-- Calculated total rows (riding instances) after merge

SELECT * from public.combined_data; 

-- 5803720 rows

-- Confirmed successful merge via counting distinct unique identifier data (ride_id)

SELECT COUNT(DISTINCT ride_id) from public.combined_data; -- 5803720 rows located.

-- Creating a "cleaned_combined_data" with "ride_length" and "day_of_week" columns while removing rows with null cell values and rides less then 1 minute and longer than 24 hours.

CREATE TABLE IF NOT EXISTS public.cleaned_combined_data AS
(SELECT 
    r.ride_id, rideable_type, started_at, ended_at, 
    ride_length,
    TO_CHAR(started_at, 'DAY')    
    AS day_of_week,
    TO_CHAR(started_at, 'MONTH')  
    AS month,
    start_station_name, end_station_name, 
    start_lat, start_lng, end_lat, end_lng, member_casual
  FROM combined_data r
  JOIN (
    SELECT ride_id, (
      EXTRACT(HOUR FROM (ended_at - started_at)) * 60 +
      EXTRACT(MINUTE FROM (ended_at - started_at)) +
      EXTRACT(SECOND FROM (ended_at - started_at)) / 60) AS ride_length
    FROM public.combined_data
  ) s
  ON r.ride_id = s.ride_id
  WHERE 
    start_station_name IS NOT NULL AND
    end_station_name IS NOT NULL AND
    end_lat IS NOT NULL AND
    end_lng IS NOT NULL AND
    ride_length > 1 AND ride_length < 1440
);

-- Re-assigning "ride_id" as the primary key for the new dataset.--

ALTER TABLE public.cleaned_combined_data
ADD PRIMARY KEY(ride_id);

-- Confirming that station and location related columns have no remaining "NULL" values.--

CREATE TABLE IF NOT EXISTS public.null_found AS 
(SELECT * FROM public.cleaned_combined_data WHERE start_station_name NOT LIKE '%NULL%'
AND end_station_name  NOT LIKE '%NULL%'
AND start_lat <> NULL 
AND start_lng  <> NULL 
AND end_lat  <> NULL 
AND end_lng <> NULL );

-- The query returned with "0" rows

-- Removing maintainence records

DELETE FROM public.cleaned_combined_data
WHERE  start_station_name IN ('Base - 2132 W Hubbard Warehouse','Base - 2132 W Hubbard','WEST CHI','WEST CHI-WATSON')RETURNING *;

-- 1018 rows removed using "start_station_name"

DELETE FROM public.cleaned_combined_data
WHERE  end_station_name IN ('Base - 2132 W Hubbard Warehouse','Base - 2132 W Hubbard','WEST CHI','WEST CHI-WATSON','DIVVY CASSETTE REPAIR MOBILE STATION')RETURNING *;

-- 179 rows removed using "end_station_name"

-- Descriptive statistics after clean up--


-- Number of rows

SELECT COUNT(ride_id) AS no_of_clean_rows 
FROM public.cleaned_combined_data; 

-- Query returned 4396207 rows so 1407513 rows removed which accounts for %24.2 of initial data.

-- Distinct value

SELECT COUNT(DISTINCT ride_id) as dis_value
FROM public.cleaned_combined_data;

-- Query returned 4396207 rows

-- MIN, MAX and MEAN values for "ride_length"

SELECT MIN(ride_LENGTH), MAX(ride_length), ROUND(AVG(ride_length),2)
FROM public.cleaned_combined_data;

-- MIN: 1.02, MAX: 1439.37, MEAN: 16.90

-- MODE value of "day_of_week"

SELECT MODE() WITHIN GROUP (ORDER BY day_of_week) from public.cleaned_combined_data;

-- Query returned SATURDAY as mode day of the week.

-- Average ride length for members and casual riders -- 

SELECT member_casual, ROUND(AVG(ride_length),2)
FROM public.cleaned_combined_data
GROUP BY member_casual;

-- Qery returned casual: 23.60 and member: 12.51

-- Average ride length for users by day of week

SELECT day_of_week, ROUND(AVG(ride_length),2)
FROM public.cleaned_combined_data
GROUP BY day_of_week;

-- Query returned Monday:16.23, Tuesday:14.85, Wednesday: 14.54, Thursday: 15.24, Friday:16.30, Saturday: 20.51, Sunday: 20.42 minutes.

-- Number of rides for users by day of week

SELECT day_of_week, member_casual, COUNT(ride_id)
FROM public.cleaned_combined_data
GROUP BY day_of_week,member_casual
ORDER BY member_casual, (COUNT(ride_id)) DESC;

-- Query returned that casual riders mostly ride on Sundays and members mostly ride on Tuesdays.

-- Average ride length for users by day of week

SELECT day_of_week, member_casual, ROUND(AVG(ride_length),2)
FROM public.cleaned_combined_data
GROUP BY day_of_week,member_casual
ORDER BY member_casual, (ROUND(AVG(ride_length),2)) DESC;

-- Query returned that the highest average ride length for casual members on Sundays is 26.94 minutes and for members on Saturdays is 14.13

-- Number of rides per hour by user

SELECT EXTRACT(HOUR FROM started_at) AS hour_of_day, member_casual, COUNT(ride_id) AS ride_per_hour
FROM public.cleaned_combined_data
GROUP BY hour_of_day,member_casual
ORDER BY  member_casual, ride_per_hour DESC;

-- Number of rides per day by user

SELECT EXTRACT(DAY FROM started_at) AS day_ride, member_casual, COUNT(ride_id) AS ride_per_day
FROM public.cleaned_combined_data
GROUP BY day_ride,member_casual
ORDER BY  member_casual, ride_per_day DESC;

-- Number of rides per month by user 

SELECT EXTRACT(MONTH FROM started_at) AS month_ride, member_casual, COUNT(ride_id) AS ride_per_month
FROM public.cleaned_combined_data
GROUP BY month_ride,member_casual
ORDER BY  member_casual, ride_per_month DESC;


------------------------------------------------



