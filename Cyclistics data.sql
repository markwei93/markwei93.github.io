Google Data Analytics Case Study 1

Data source: https://divvy-tripdata.s3.amazonaws.com/index.html
Queried using: BigQuery Sandbox
Data visualization: Tableau

--DATA COMBINING


-- merge 12 months of data into 1 table
CREATE TABLE `cyclistic.trip_2023_combined` AS 
(
  SELECT * FROM `onyx-codex-390102.cyclistic.trip202301`
  UNION ALL
  SELECT * FROM `onyx-codex-390102.cyclistic.trip202302`
  UNION ALL
  SELECT * FROM `onyx-codex-390102.cyclistic.trip202303`
  UNION ALL
  SELECT * FROM `onyx-codex-390102.cyclistic.trip202304`
  UNION ALL
  SELECT * FROM `onyx-codex-390102.cyclistic.trip202305`
  UNION ALL
  SELECT * FROM `onyx-codex-390102.cyclistic.trip202306`
  UNION ALL
  SELECT * FROM `onyx-codex-390102.cyclistic.trip202307`
  UNION ALL
  SELECT * FROM `onyx-codex-390102.cyclistic.trip202308`
  UNION ALL
  SELECT * FROM `onyx-codex-390102.cyclistic.trip202309`
  UNION ALL
  SELECT * FROM `onyx-codex-390102.cyclistic.trip202310`
  UNION ALL
  SELECT * FROM `onyx-codex-390102.cyclistic.trip202311`
  UNION ALL
  SELECT * FROM `onyx-codex-390102.cyclistic.trip202312`
);


-- Checking for missing and wrong data


-- Count how many rows are in the table
SELECT COUNT(*)
FROM `cyclistic.trip_2023_combined`; --total 5719877 rows

-- Checking for duplicates
SELECT COUNT(DISTINCT ride_id)
FROM `cyclistic.trip_2023_combined`;--5719877 disticnt ride_de, so no duplicates

-- Checking the data for null values


SELECT *
FROM `cyclistic.trip_2023_combined`
WHERE ride_id is NULL OR
rideable_type is NULL OR
started_at is NULL OR
ended_at is NULL OR
start_station_name is NULL OR
start_station_id is NULL OR
end_station_name is NULL OR
end_station_id is NULL OR
start_lat is NULL OR
start_lng is NULL OR
end_lat is NULL OR
end_lng is NULL OR
member_casual is NULL; --1388170 rows have missing data


-- Checking if there are wrong entries for data_id


SELECT LENGTH(ride_id) AS length_ride_id
FROM `cyclistic.trip_2023_combined`; -- ride_id should have the length of 16

SELECT ride_id
FROM `cyclistic.trip_2023_combined`
WHERE LENGTH(ride_id) !=16; -- All ride_id have the length of 16

--Checking for rideable_type
SELECT DISTINCT rideable_type,
COUNT(rideable_type) AS number_of_trips
FROM `cyclistic.trip_2023_combined`
GROUP BY rideable_type; -- There are 3 different rideable_types

--Checking for the length of each trip
SELECT ended_at, started_at,
ended_at - started_at AS length_of_trip
FROM `cyclistic.trip_2023_combined`
ORDER BY length_of_trip ASC;

SELECT ended_at, started_at,
ended_at - started_at AS length_of_trip
FROM `cyclistic.trip_2023_combined`
ORDER BY length_of_trip DESC; 
--We can see there are rows that have negative time for riding the bike and also some rows that are longer than a day


-- Checking for member_casucal which should be 2 unique values, member and casual
SELECT DISTINCT member_casual, COUNT( member_casual) AS no_of_trips
FROM `cyclistic.trip_2023_combined`
GROUP BY member_casual;


-- DATA CLEANING

--Create a new table with clean data

CREATE TABLE cyclistic.trips_2023_cleaned AS (
  SELECT
  ride_id, rideable_type, started_at, ended_at, 
    TIMESTAMP_DIFF(ended_at,started_at, MINUTE) AS ride_length,
    CASE EXTRACT(DAYOFWEEK FROM started_at) 
      WHEN 1 THEN 'SUN'
      WHEN 2 THEN 'MON'
      WHEN 3 THEN 'TUE'
      WHEN 4 THEN 'WED'
      WHEN 5 THEN 'THU'
      WHEN 6 THEN 'FRI'
      WHEN 7 THEN 'SAT'    
    END AS day_of_week,
    CASE EXTRACT(MONTH FROM started_at)
      WHEN 1 THEN 'JAN'
      WHEN 2 THEN 'FEB'
      WHEN 3 THEN 'MAR'
      WHEN 4 THEN 'APR'
      WHEN 5 THEN 'MAY'
      WHEN 6 THEN 'JUN'
      WHEN 7 THEN 'JUL'
      WHEN 8 THEN 'AUG'
      WHEN 9 THEN 'SEP'
      WHEN 10 THEN 'OCT'
      WHEN 11 THEN 'NOV'
      WHEN 12 THEN 'DEC'
    END AS month,
    start_station_name, end_station_name, 
    start_lat, start_lng, end_lat, end_lng, member_casual
FROM `cyclistic.trip_2023_combined`
  WHERE 
    start_station_name IS NOT NULL AND
    end_station_name IS NOT NULL AND
    end_lat IS NOT NULL AND
    end_lng IS NOT NULL AND
    TIMESTAMP_DIFF(ended_at,started_at, MINUTE) >1 AND TIMESTAMP_DIFF(ended_at,started_at, MINUTE) <1440
)
-- Now we have the table with all the clean data


-- DATA ANALYSIS

-- Bike types and average riding time by users
SELECT member_casual, rideable_type, COUNT(*) AS total_trips, AVG(ride_length) AS average_riding_time
FROM `cyclistic.trips_2023_cleaned`
GROUP BY member_casual, rideable_type
ORDER BY member_casual, total_trips;

--Total trips and average trip length per month
SELECT EXTRACT(MONTH FROM PARSE_DATE('%b',CONCAT(month))) AS month_of_year, member_casual,COUNT(ride_id) AS total_trips, AVG(ride_length) AS averge_riding_time
FROM `cyclistic.trips_2023_cleaned`
GROUP BY month_of_year, member_casual
ORDER BY month_of_year ASC, member_casual;

--Total trips and average trip length per day of week
SELECT day_of_week, member_casual, COUNT(ride_id) AS total_trips, AVG(ride_length) AS averge_riding_time
FROM `cyclistic.trips_2023_cleaned`
GROUP BY day_of_week, member_casual
ORDER BY day_of_week, member_casual;

--Total trips and average trip length per hour
SELECT EXTRACT(HOUR FROM started_at) AS hour_of_day, member_casual, COUNT(ride_id) AS total_trips, AVG(ride_length) AS averge_riding_time
FROM `cyclistic.trips_2023_cleaned`
GROUP BY hour_of_day, member_casual
ORDER BY hour_of_day, member_casual;

--Total trips for each start station with their location
SELECT start_station_name, member_casual,
  AVG(start_lat) AS start_lat, AVG(start_lng) AS start_lng,
  COUNT(ride_id) AS total_trips
FROM `cyclistic.trips_2023_cleaned`
GROUP BY start_station_name, member_casual;

--Total Trips for each end station with their location
SELECT end_station_name, member_casual,
  AVG(end_lat) AS end_lat, AVG(end_lng) AS end_lng,
  COUNT(ride_id) AS total_trips
FROM `cyclistic.trips_2023_cleaned`
GROUP BY end_station_name, member_casual;


