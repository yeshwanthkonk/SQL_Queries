-- Write your PostgreSQL query statement below
WITH cte_rn AS (
    SELECT 
        id,
        email,
        ROW_NUMBER() OVER(PARTITION BY email ORDER BY id) AS RN
    FROM Person
)
DELETE FROM Person p
-- WHERE NOT EXISTS (
--     SELECT 
--         1
--     FROM cte_rn
--     WHERE RN=1 AND p.id=cte_rn.id
-- ); -- when compared took more time, but might be fast when the data is huge because of short-circuiting
WHERE id NOT IN (
    SELECT 
        id
    FROM cte_rn
    WHERE RN=1
);
