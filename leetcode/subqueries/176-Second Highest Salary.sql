-- Write your PostgreSQL query statement below
-- WITH cte_sal_rank AS (
--     SELECT
--         salary,
--         DENSE_RANK() OVER(ORDER BY SALARY DESC) AS sal_rank
--     FROM Employee
-- ),
-- cte_second_highest AS (
--     SELECT
--         DISTINCT salary 
--     FROM cte_sal_rank
--     WHERE sal_rank=2
-- )

-- SELECT 
--     CASE
--         WHEN EXISTS (SELECT salary FROM cte_second_highest)
--             THEN (SELECT salary FROM cte_second_highest)
--         ELSE NULL
--     END AS SecondHighestSalary;

-- Scaler SubQuery instead of Case Clause
WITH cte_sal_rank AS (
    SELECT
        salary,
        DENSE_RANK() OVER(ORDER BY SALARY DESC) AS sal_rank
    FROM Employee
)
SELECT (
    SELECT
        DISTINCT salary AS SecondHighestSalary
    FROM cte_sal_rank
    WHERE sal_rank=2
);

-- Solution from Discussion board

-- SELECT (
--     SELECT DISTINCT salary
--     FROM (
--         SELECT 
--             salary,
--             DENSE_RANK() OVER (ORDER BY salary DESC) as rnk
--         FROM Employee
--     ) AS RankedSalaries
--     WHERE rnk = 2
-- ) AS SecondHighestSalary;
