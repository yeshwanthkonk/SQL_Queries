-- Write your PostgreSQL query statement below
SELECT
    emp.name AS Employee 
FROM Employee emp JOIN Employee mgr
    ON emp.managerId = mgr.id
WHERE emp.salary > mgr.salary;

-- Another Approach EXISTS Clause Correlated Subquery

-- SELECT
--     emp.name AS Employee 
-- FROM Employee emp
-- WHERE EXISTS (SELECT 1 FROM Employee mgr WHERE emp.managerId=mgr.id AND emp.salary > mgr.salary);

-- Another approach Scalar Correlated Subquery, but slower execution/higher runtime

-- SELECT
--     emp.name AS Employee 
-- FROM Employee emp
-- WHERE emp.salary > (SELECT salary FROM Employee mgr WHERE emp.managerId=mgr.id);
