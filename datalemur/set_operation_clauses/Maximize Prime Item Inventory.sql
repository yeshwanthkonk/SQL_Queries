-- WITH cte_summary AS (
--   SELECT 
--     item_type,
--     SUM(square_footage) AS total_sqft,
--     COUNT(item_id) AS item_count
--   FROM inventory
--   GROUP BY item_type
-- ),
-- prime_items_summary AS (
--   SELECT 
--     item_type,
--     total_sqft,
--     FLOOR(500000/total_sqft) as prime_batches,
--     FLOOR(500000/total_sqft)*item_count AS item_count
--   FROM cte_summary
--   WHERE item_type = 'prime_eligible'
-- )

-- SELECT
--   item_type,
--   CASE
--     WHEN item_type = 'prime_eligible'
--       THEN (FLOOR(500000/total_sqft) * item_count)
--     WHEN item_type = 'not_prime'
--       THEN FLOOR(
--         (500000 - (SELECT total_sqft*prime_batches FROM prime_items_summary))/total_sqft
--       ) * item_count
--     END AS item_count
-- FROM cte_summary
-- ORDER BY item_type DESC;


-- Method #2: Using FILTER and UNION ALL operator

WITH summary AS (
  SELECT 
    SUM(square_footage) FILTER (WHERE item_type = 'prime_eligible') AS prime_sq_ft,
    COUNT(item_id) FILTER (WHERE item_type = 'prime_eligible') AS prime_item_count,
    SUM(square_footage) FILTER (WHERE item_type = 'not_prime') AS not_prime_sq_ft,
    COUNT(item_id) FILTER (WHERE item_type = 'not_prime') AS not_prime_item_count
  FROM inventory
),
prime_occupied_area AS (
  SELECT FLOOR(500000/prime_sq_ft)*prime_sq_ft AS max_prime_area
  FROM summary
)

SELECT 
  'prime_eligible' AS item_type,
  FLOOR(500000/prime_sq_ft)*prime_item_count AS item_count
FROM summary

UNION ALL

SELECT 
  'not_prime' AS item_type,
  FLOOR((500000-(SELECT max_prime_area FROM prime_occupied_area)) 
    / not_prime_sq_ft) * not_prime_item_count AS item_count
FROM summary;
