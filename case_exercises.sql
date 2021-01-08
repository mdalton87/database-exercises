use employees;
# Write a query that returns all employees (emp_no), their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.

select emp_no, dept_no, hire_date, to_date, 
	case	when to_date > curdate() then 1
			else 0
			end as is_current_employee
from employees
join dept_emp using(emp_no);




# 2. Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.

select 
	case 	when last_name REGEXP '^(A|B|C|D|E|F|G|H)' then 'A-H'
			when last_name REGEXP '^(I|J|K|L|M|N|O|P|Q)' then 'I-Q'
			when last_name REGEXP '^(R|S|T|U|V|W|X|Y|Z)' then 'R-Z'
			end as alpha_group,
			count(*)
from employees
group by alpha_group;

# 3. How many employees (current or previous) were born in each decade?

select
	case	when birth_date like "195%" then '50s'
			when birth_date like "196%" then '60s'
			end as decade,
			count(*)
from employees
group by decade;


# BONUS: What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?


SELECT 
CASE 
		WHEN dept_name IN ('research', 'development') THEN 'R&D'
		WHEN dept_name IN ('sales', 'marketing') THEN 'Sales & Marketing' 
		WHEN dept_name in ('Production', 'Quality Management') THEN 'Prod & QM'
		WHEN dept_name in ('Finance', 'Human Resources') THEN 'Finance & HR'
		ELSE dept_name
		END AS dept_group,
	avg(salary) as group_avg_salary
FROM departments
join dept_emp using(dept_no)
join salaries using(emp_no)
group by dept_group;