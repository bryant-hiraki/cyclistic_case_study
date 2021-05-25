WITH 
    agg_tripdata_2020 AS (
        SELECT *
        FROM 
            `cyclistic-313319.tripdata.202004-divvy-tripdata`

        UNION ALL 

        SELECT *
        FROM 
            `cyclistic-313319.tripdata.202005-divvy-tripdata`

        UNION ALL 

        SELECT *
        FROM 
            `cyclistic-313319.tripdata.202006-divvy-tripdata`

        UNION ALL 

        SELECT *
        FROM 
            `cyclistic-313319.tripdata.202007-divvy-tripdata`

        UNION ALL 

        SELECT *
        FROM 
            `cyclistic-313319.tripdata.202008-divvy-tripdata`

        UNION ALL 

        SELECT *
        FROM 
            `cyclistic-313319.tripdata.202009-divvy-tripdata`

        UNION ALL 

        SELECT *
        FROM 
            `cyclistic-313319.tripdata.202010-divvy-tripdata`

        UNION ALL 

        SELECT *
        FROM 
            `cyclistic-313319.tripdata.202011-divvy-tripdata`
),
    agg_tripdata_2021 AS (
        SELECT *
        FROM 
            `cyclistic-313319.tripdata.202012-divvy-tripdata`

        UNION ALL 

        SELECT *
        FROM 
            `cyclistic-313319.tripdata.202101-divvy-tripdata`

        UNION ALL 

        SELECT *
        FROM 
            `cyclistic-313319.tripdata.202102-divvy-tripdata`

        UNION ALL 

        SELECT *
        FROM 
            `cyclistic-313319.tripdata.202103-divvy-tripdata`

        UNION ALL 

        SELECT *
        FROM 
            `cyclistic-313319.tripdata.202104-divvy-tripdata`
),
    agg_tripdata_all AS(
        SELECT 
            ride_id,
            rideable_type,
            started_at,
            ended_at,
            start_station_name,
            CAST(start_station_id AS STRING) AS start_id,
            end_station_name,
            CAST(end_station_id AS STRING) AS end_id,
            start_lat,
            start_lng,
            end_lat,
            end_lng,
            member_casual	

        FROM agg_tripdata_2020 

        UNION ALL 

        SELECT *
        FROM agg_tripdata_2021 
)
SELECT  
    a.ride_id,
    a.rideable_type,
    b.start_day,
    a.started_at,
    a.ended_at,
    b.total_seconds,
    a.start_station_name,
    a.start_id,
    a.end_station_name,
    a.end_id,
    a.start_lat,
    a.start_lng,
    a.end_lat,
    a.end_lng,
    ST_DISTANCE(b.start_pt, b.end_pt) AS station_dist, -- meters
    a.member_casual
FROM (
    SELECT  
        ride_id,
        TIMESTAMP_DIFF(ended_at, started_at, SECOND) AS total_seconds,
        ST_GEOGPOINT(start_lng, start_lat) AS start_pt,
        ST_GEOGPOINT(end_lng, end_lat) AS end_pt,
        CASE
            WHEN EXTRACT(DAYOFWEEK FROM started_at) = 1 THEN 'Sunday'
            WHEN EXTRACT(DAYOFWEEK FROM started_at) = 2 THEN 'Monday'
            WHEN EXTRACT(DAYOFWEEK FROM started_at) = 3 THEN 'Tuesday'
            WHEN EXTRACT(DAYOFWEEK FROM started_at) = 4 THEN 'Wednesday'
            WHEN EXTRACT(DAYOFWEEK FROM started_at) = 5 THEN 'Thursday'
            WHEN EXTRACT(DAYOFWEEK FROM started_at) = 6 THEN 'Friday'
            WHEN EXTRACT(DAYOFWEEK FROM started_at) = 7 THEN 'Saturday'
            END AS start_day
    FROM 
        agg_tripdata_all
) b
LEFT JOIN agg_tripdata_all a 
    ON a.ride_id = b.ride_id
WHERE 
    total_seconds  BETWEEN 0 AND 28800 -- ride duration 0-8 hours 
    AND ST_DISTANCE(b.start_pt, b.end_pt) IS NOT NULL -- removing unreturned bikes (no dock info)
ORDER BY station_dist  DESC
