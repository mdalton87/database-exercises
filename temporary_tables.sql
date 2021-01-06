# 1. Using the example from the lesson, re-create the employees_with_departments table.

# Query to make employees_with_departments table
create temporary table employees_with_departments as (
	select *	
	from employees.employees
	join employees.dept_emp using(emp_no)
	join employees.departments using(dept_no)
	);

# a. Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns

alter table employees_with_departments add full_name varchar(30);

# b. Update the table so that full name column contains the correct data

update employees_with_departments
set full_name = concat(first_name," ",last_name);

# c. Remove the first_name and last_name columns from the table.

alter table employees_with_departments drop column first_name;
alter table employees_with_departments drop column last_name;


select emp_no, full_name, dept_no, dept_name
from employees_with_departments;

# d. What is another way you could have ended up with this same table?

create temporary table ewd as
	(
	select emp_no, concat(first_name," ",last_name) as full_name, dept_no, dept_name
	from employees.employees
	join employees.dept_emp using(emp_no)
	join employees.departments using(dept_no)
	);
	
select *
from ewd;


# 2. Create a temporary table based on the payment table from the sakila database.

CREATE TEMPORARY TABLE `payment` (
	select *
	from sakila.payment
	);
	
select *
from payment;

#Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.

