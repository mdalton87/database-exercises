use employees;

# 1. Find all the current employees with the same hire date as employee 101010 using a sub-query.

select concat(first_name," ",last_name) as full_name
from employees
where hire_date in (
		select hire_date
		from employees
		where emp_no = 101010 
		);
## 69 rows returned

# 2. Find all the titles ever held by all current employees with the first name Aamod.

# titles -> emp_no <- employees
select title, count(*)
from titles
join employees using(emp_no)
where first_name in (
		select first_name
		from employees
		where first_name like "Aamod"
		)
group by title;

# 3. How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.

SELECT count(emp_no)
FROM employees
join salaries using(emp_no) 
WHERE emp_no IN (
				select emp_no
				from salaries
				);
# 85108?
# 59900?


select count(*)
from dept_emp
where to_date < curdate();

# 4. Find all the current department managers that are female. List their names in a comment in your code.

select concat(first_name," ",last_name) as "Full_Name"
from dept_manager
join employees using(emp_no)
where to_date > curdate()
	and 
	gender = "F";
# Isamu Legleitner, Karsten Sigstam, Leon DasSarma, Hilary Kambil

# 5. Find all the employees who currently have a higher salary than the companies overall, historical average salary.

# average historical salary
select avg(salary)
from salaries;


select concat(first_name," ",last_name) as "full_name", salary
from employees
join salaries using(emp_no)
where salary > 
		(
		select avg(salary)
		from salaries
		)
	and 
	salaries.to_date > curdate()
order by salary;
# 154543 employees


# 6. How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?

# 1 standard deviation of current salaries
select stddev(salary)
from salaries
where to_date > curdate();
# 17309.95933634675

# max(salary)
select max(salary)
from salaries
where to_date > curdate();
# 158220


# total count of current salaries >= 1 stddev from highest salary
select count(*)
from salaries
where salary >=
		((select max(salary)
		from salaries)
		-
		(select stddev(salary)
		from salaries))
	and 
	salaries.to_date > curdate();
# 78
	
# total number of current salaries
select count(*)
from salaries
where to_date > curdate();
# 240124

# Final 					
select concat((((
		select count(*)
		from salaries
		where salary >=
				((select max(salary)
				from salaries
				where to_date > curdate())
				-
				(select stddev(salary)
				from salaries
				where to_date > curdate()))
			and 
			salaries.to_date > curdate()
		)
		/ count(salary)) * 100),"%") as "Percent of people 1-SD from the Top"
from salaries
where to_date > curdate();

# 0.0346%

################################################################################################################################################
# BONUS:
################################################################################################################################################

# 1. Find all the department names that currently have female managers.

select dept_name as "Departments with Female Managers"
from departments
join dept_manager using(dept_no)
join employees using(emp_no)
where gender in 
		(
		select gender
		from employees
		where gender = "F"
		)
	and 
	to_date > curdate();




# 2. Find the first and last name of the employee with the highest salary.

select first_name, last_name, salary
from employees
join salaries using(emp_no)
where salary in (
				select max(salary)
				from salaries
				where to_date > curdate()
				);



# 3. Find the department name that the employee with the highest salary works in.

select first_name, last_name, salary, dept_name
from employees
join salaries using(emp_no)
join dept_emp using(emp_no)
join departments using(dept_no)
where salary in (
				select max(salary)
				from salaries
				where to_date > curdate()
				);



