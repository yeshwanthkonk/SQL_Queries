WITH cte_window_results AS (  
  SELECT 
    EXTRACT(YEAR FROM transaction_date) AS year,
    product_id,
    spend as curr_year_spend,
    LAG(spend) OVER(PARTITION BY product_id ORDER BY product_id, transaction_date) AS prev_year_spend
  FROM user_transactions -- ORDER BY product_id, EXTRACT(YEAR FROM transaction_date) provided in solution, but my version seems close meaning
)
SELECT
  year,
  product_id,
  curr_year_spend,
  prev_year_spend,
  ROUND(((curr_year_spend-prev_year_spend)/prev_year_spend)*100, 2) AS yoy_rate
FROM cte_window_results;
