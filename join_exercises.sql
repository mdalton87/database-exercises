# 1. use join_example db

use `join_example_db`;


select *
from users

select *
from roles

# 2. Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. Before you run each query, guess the expected number of results.

select *
from users # by putting USERS in FROM and choosing LEFT means we get all the users, whether or not they have a roles
left join roles on roles.id = users.role_id;

select *
from users
right join roles on roles.id = users.role_id, COUNT(roles);


# 3. Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. Use count and the appropriate join type to get a list of roles along with the number of users that has the role. Hint: You will also need to use group by in the query.

SELECT users.name, roles.name, count(*)
FROM users
JOIN roles ON users.role_id = roles.id
GROUP BY roles.name;


# 1. use employees db

USE employees;

# 2. Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.

select dept_name as "Department Name", concat(first_name," ",last_name) as "Manager Name"
from departments 
# join dept_no from departments to dept_no from dept_manager
join  dept_manager on departments.dept_no = dept_manager.dept_no
# join emp_no from dept_manager to emp_no from employees
join employees on dept_manager.emp_no = employees.emp_no
where dept_manager.to_date > curdate()
order by dept_name;


# 3. Find the name of all departments currently managed by women.

select dept_name as "Department Name", concat(first_name," ",last_name) as "Manager Name"
from departments 
# join dept_no from departments to dept_no from dept_manager
join  dept_manager on departments.dept_no = dept_manager.dept_no
# join emp_no from dept_manager to emp_no from employees
join employees on dept_manager.emp_no = employees.emp_no
where dept_manager.to_date > curdate()
AND employees.gender = "F"
order by dept_name;


# 4. Find the current titles of employees currently working in the Customer Service department.

# GROUP BY title, titles.emp_no -> dept_emp.emp_no, dept_emp.dept-no -> departments.dept_no, WHERE = dept_name = customer service AND currenly working

select title as "Title", count(*) as "Count"
from titles
join dept_emp on dept_emp.emp_no = titles.emp_no
join departments on departments.dept_no = dept_emp.dept_no
where dept_name = "Customer Service"
	and
	titles.to_date > curdate()
	and
	dept_emp.to_date > curdate()
group by title;


# 5. Find the current salary of all current managers.

select dept_name as "Department Name", concat(first_name," ",last_name) as "Name", salary as "Salary"
from departments 
# join dept_no from departments to dept_no from dept_manager
join  dept_manager on departments.dept_no = dept_manager.dept_no
# join emp_no from dept_manager to emp_no from employees
join employees on dept_manager.emp_no = employees.emp_no
# JOIN salary.emp_no to employee.emp_no
join salaries on employees.emp_no = salaries.emp_no
where dept_manager.to_date > curdate()
	and
	salaries.to_date > curdate()
order by dept_name;


# 6. Find the number of current employees in each department.

select departments.dept_no, dept_name, count(*) as "num_employees"
from departments
join dept_emp on departments.dept_no = dept_emp.dept_no
where dept_emp.to_date > curdate()
group by departments.dept_no;


# 7 Which department has the highest average salary? Hint: Use current not historic information.

#salaries -> emp_no -> dept_emp, dept_emp -> dept_no -> departments


select dept_name, avg(salaries.salary) as "average_salary"
from salaries
join dept_emp on salaries.emp_no = dept_emp.emp_no
join departments on dept_emp.dept_no = departments.dept_no
where salaries.to_date > curdate()
group by dept_name
order by average_salary desc
limit 1;


# 8. Who is the highest paid employee in the Marketing department?

select e.first_name, e.last_name, 
from salaries as s
join dept_emp as de 
	on s.emp_no = de.emp_no
join departments as d
	on de.dept_no = d.dept_no
join employees as e
	on s.emp_no = e.emp_no
where s.to_date > curdate()
	and 
	d.dept_name = "Marketing"
order by s.salary desc
limit 1;


# 9. Which current department manager has the highest salary?

select e.first_name, e.last_name, s.salary, d.dept_name
from departments as d
join  dept_manager as dm
	on d.dept_no = dm.dept_no
join employees as e
	on dm.emp_no = e.emp_no
join salaries as s
	on s.emp_no = e.emp_no
where dm.to_date > curdate()
	and s.to_date > curdate()
order by s.salary desc
limit 1;


# 10. BONUS:  Find the names of all current employees, their department name, and their current manager's name 

select concat(e.first_name," ",e.last_name) as "Employee Name", dept_name as "Department Name"
from employees as e
join salaries as s 
	on e.emp_no = s.emp_no
join dept_emp as de
	on de.emp_no = e.emp_no
join departments as d
	on de.dept_no = d.dept_no
join dept_manager as dm
	on d.dept_no = dm.dept_no
where s.to_date > curdate();





# 11. BONUS:  Who is the highest paid employee within each department.









