-- My Solution

WITH cte_ranking AS (
SELECT 
  DATE_TRUNC('DAY', measurement_time) AS measurement_day,
  measurement_value,
  ROW_NUMBER() OVER(
    PARTITION BY DATE_TRUNC('DAY', measurement_time)
    ORDER BY measurement_time
  ) AS ranking
FROM measurements
)
SELECT 
  measurement_day,
  SUM(
    CASE
      WHEN (ranking%2)!=0
        THEN measurement_value
      ELSE 0
    END
  ) AS odd_sum,
  SUM(
    CASE
      WHEN (ranking%2)=0
        THEN measurement_value
      ELSE 0
    END
  ) AS even_sum
FROM cte_ranking
GROUP BY measurement_day;

-- Solution Provided

-- WITH ranked_measurements AS (
--   SELECT 
--     CAST(measurement_time AS DATE) AS measurement_day, 
--     measurement_value, 
--     ROW_NUMBER() OVER (
--       PARTITION BY CAST(measurement_time AS DATE) 
--       ORDER BY measurement_time) AS measurement_num 
--   FROM measurements
-- ) 

-- SELECT 
--   measurement_day, 
--   SUM(measurement_value) FILTER (WHERE measurement_num % 2 != 0) AS odd_sum, -- FILTER used in recent engines, specially used in aggregation filter instead of case/when statements
--   SUM(measurement_value) FILTER (WHERE measurement_num % 2 = 0) AS even_sum 
-- FROM ranked_measurements
-- GROUP BY measurement_day;
