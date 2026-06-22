-- JOIN clause logic

-- SELECT 
--   pg.page_id 
-- FROM pages AS pg LEFT JOIN page_likes AS pl
--   ON pg.page_id=pl.page_id
-- WHERE pl.page_id IS NULL
-- ORDER BY pg.page_id;

-- Except Clause

SELECT page_id FROM pages
  EXCEPT
SELECT page_id FROM page_likes
AS table_for_ordering
ORDER BY page_id;

-- NOT IN Clause logic with simple sub-query

-- SELECT page_id
-- FROM pages
-- WHERE page_id NOT IN (
--   SELECT page_id
--   FROM page_likes
--   WHERE page_id IS NOT NULL
-- )
-- order by page_id;

-- NOT EXISTS Clause logic with Correlated Subquery

-- SELECT page_id
-- FROM pages
-- WHERE NOT EXISTS (
--   SELECT page_id
--   FROM page_likes AS likes
--   WHERE likes.page_id = pages.page_id
-- )
-- order by page_id;
