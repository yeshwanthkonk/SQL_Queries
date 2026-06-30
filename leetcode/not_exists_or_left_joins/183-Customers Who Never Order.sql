-- Write your PostgreSQL query statement below
SELECT 
    c.name AS Customers
FROM Customers c LEFT JOIN Orders o
    ON c.id = o.customerId
WHERE o.id IS NULL;

-- SubQuery Based: with NOT IN operator, hoping foreign key customerId has a NOT NULL constraint, but by default, the foreign key won't do it, it has to be enforced separately

-- SELECT
--     name AS Customers
-- FROM Customers
-- WHERE id NOT IN (SELECT customerId FROM Orders);

-- Not Exist Case: To handle Null values or Short circuit case when the table is large, but it is a correlated sub-query.

-- SELECT
--     name AS Customers
-- FROM Customers c
-- WHERE NOT EXISTS (SELECT 1 FROM Orders o WHERE c.id=o.customerId);
