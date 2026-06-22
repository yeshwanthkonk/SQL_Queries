SELECT 
  emp.employee_id,
  emp.name
  -- e1.salary,
  -- m1.salary
FROM employee AS emp INNER JOIN employee AS mgr
  ON emp.manager_id=mgr.employee_id
where emp.salary > mgr.salary;
