/*
You work for an airline, and you've been tasked with improving the procedure for reserving and buying seats.
You have the table seats, which describes seats in the airplane. It has the following columns:

seat_no - The unique number of the seat;
status - The status of the seat (0 indicates free, 1 indicates reserved, and 2 indicates purchased);
person_id - The ID of the person who reserved/purchased this seat (0 if the corresponding status is 0).
You also have the table requests, which contains the following columns:

request_id - The unique ID of the request;
request - The description of the request (1 indicates reserve, 2 indicates purchase);
seat_no - The number of the seat that the person want to reserve/purchase;
person_id - The ID of the person who wants to reserve/purchase this seat.
A person can reserve/purchase a free seat and can purchase a seat that they have reserved.

Your task is to return the table seats after the given requests have been performed.

Note: requests are applied from the lowest request_id; it's guaranteed that all values of seat_no in the table requests are presented in the table seats.

Example

For the given tables seats

seat_no	status	person_id
1	1	1
2	1	2
3	0	0
4	2	3
5	0	0
and requests

request_id	request	seat_no	person_id
1	1	3	4
2	2	2	5
3	2	1	1
the output should be

seat_no	status	person_id
1	2	1
2	1	2
3	1	4
4	2	3
5	0	0
The first request is completed because seat number 3 is free. The second request is ignored because seat number 2 is already reserved by another person. The third request is completed because seat number 1 was reserved by this person, so they can purchase it.
*/
-------------------------------------------------------------------------------------------------------------------------- Only First 2 step, which process upto first 2 request for same seat_no
WITH reqs AS (
  SELECT *, ROW_NUMBER() OVER (PARTITION BY seat_no ORDER BY request_id) AS rn
  FROM requests
),
step1 AS (
  SELECT 
    s.seat_no,
    CASE
      WHEN r.request = 1 AND s.status = 0 THEN 1
      WHEN r.request = 2 AND s.status = 0 THEN 2
      WHEN r.request = 2 AND s.status = 1 AND r.person_id = s.person_id THEN 2
      ELSE s.status
    END AS status,
    CASE
      WHEN (r.request IN (1,2)) AND (
            (s.status = 0) OR
            (s.status = 1 AND r.request = 2 AND r.person_id = s.person_id)
          )
      THEN r.person_id
      ELSE s.person_id
    END AS person_id
  FROM seats s
  LEFT JOIN reqs r
  ON s.seat_no = r.seat_no AND r.rn = 1
),
-- Step 2: Apply second request
step2 AS (
  SELECT 
    s.seat_no,
    CASE
      WHEN r.request = 1 AND s.status = 0 THEN 1
      WHEN r.request = 2 AND s.status = 0 THEN 2
      WHEN r.request = 2 AND s.status = 1 AND r.person_id = s.person_id THEN 2
      ELSE s.status
    END AS status,
    CASE
      WHEN (r.request IN (1,2)) AND (
            (s.status = 0) OR
            (s.status = 1 AND r.request = 2 AND r.person_id = s.person_id)
          )
      THEN r.person_id
      ELSE s.person_id
    END AS person_id
  FROM step1 s
  LEFT JOIN reqs r
  ON s.seat_no = r.seat_no AND r.rn = 2
)

SELECT * FROM step2 ORDER BY seat_no;


------------------------------------------------------------------------------------------------------------------------------- Recursive Solution for all steps:
WITH RECURSIVE process_requests AS (
  -- Base case: starting with initial seat states
  SELECT 
    s.seat_no,
    s.status,
    s.person_id,
    CAST(NULL AS SIGNED) AS request_id,  -- make sure this matches request_id's INT type
    0 AS step
  FROM seats s

  UNION ALL

  -- Recursive case: apply next request by request_id order
  SELECT
    pr.seat_no,
    CASE
      WHEN r.request = 1 AND pr.status = 0 THEN 1
      WHEN r.request = 2 AND pr.status = 0 THEN 2
      WHEN r.request = 2 AND pr.status = 1 AND pr.person_id = r.person_id THEN 2
      ELSE pr.status
    END AS status,
    CASE
      WHEN r.request = 1 AND pr.status = 0 THEN r.person_id
      WHEN r.request = 2 AND pr.status = 0 THEN r.person_id
      WHEN r.request = 2 AND pr.status = 1 AND pr.person_id = r.person_id THEN r.person_id
      ELSE pr.person_id
    END AS person_id,
    r.request_id,
    pr.step + 1
  FROM process_requests pr
  JOIN requests r
    ON r.seat_no = pr.seat_no
   AND r.request_id = (
     SELECT MIN(r2.request_id)
     FROM requests r2
     WHERE r2.seat_no = pr.seat_no
       AND (pr.request_id IS NULL OR r2.request_id > pr.request_id)
   )
)

-- Get the last applied state per seat
SELECT seat_no, status, person_id
FROM (
  SELECT *, ROW_NUMBER() OVER (PARTITION BY seat_no ORDER BY step DESC) AS rn
  FROM process_requests
) t
WHERE rn = 1
ORDER BY seat_no;
