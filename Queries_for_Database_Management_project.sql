SELECT * FROM employee_salary;

SELECT e.first_name, e.last_name, e.age, s.occupation, s.salary, p.department_name
FROM employee_demographics as e
JOIN employee_salary as s 
ON  e.employee_id = s.employee_id
LEFT JOIN parks_departments as p
ON s.dept_id = p.department_id
ORDER BY occupation;


SELECT * FROM parks_departments