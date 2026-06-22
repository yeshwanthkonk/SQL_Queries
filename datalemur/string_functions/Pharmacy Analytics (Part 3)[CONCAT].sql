SELECT 
  manufacturer,
  CONCAT('$',
    ROUND(SUM(total_sales)/(1000000)),
    ' ',
    'million' -- ' million'
  ) AS sale
FROM pharmacy_sales
GROUP BY manufacturer
ORDER BY SUM(total_sales) DESC, manufacturer;

-- Using CTE

-- WITH drug_sales AS (
--   SELECT 
--     manufacturer, 
--     SUM(total_sales) as sales 
--   FROM pharmacy_sales 
--   GROUP BY manufacturer
-- ) 

-- SELECT 
--   manufacturer, 
--   ('$' || ROUND(sales / 1000000) || ' million') AS sales_mil 
-- FROM drug_sales 
-- ORDER BY sales DESC, manufacturer;
