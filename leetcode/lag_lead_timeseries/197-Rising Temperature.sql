-- https://leetcode.com/problems/rising-temperature/

-- Write your MySQL query statement below
WITH cte_extract_previous AS (
    SELECT
        id,
        temperature,
        LAG(temperature, 1) OVER W AS prev_day_temp,
        DATEDIFF(recordDate, LAG(recordDate, 1) OVER W) AS prev_day_diff
    FROM Weather
    WINDOW W AS (ORDER BY recordDate)
)
SELECT 
    id
FROM cte_extract_previous
WHERE temperature > prev_day_temp AND prev_day_diff = 1;


-- another way to write but not recommend for maintability due missing intermediate data to change compare logic later.

-- WITH cte AS (
--     SELECT
--         id,
--         temperature > LAG(temperature) OVER w AS is_warmer,
--         DATEDIFF(recordDate, LAG(recordDate) OVER w) AS day_gap
--     FROM Weather
--     WINDOW w AS (ORDER BY recordDate)
-- )
-- SELECT id
-- FROM cte
-- WHERE is_warmer
--   AND day_gap = 1;
