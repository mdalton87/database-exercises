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

drop temporary table payment;
#Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.

alter table payment add amount2 int;
update payment set amount2 = amount * 100;
alter table payment drop column amount;
alter table payment add amount int;
update payment set amount = amount2;
alter table payment drop column amount2;


# 3. Find out how the current average pay in each department compares to the overall, historical average pay. 
# In order to make the comparison easier, you should use the Z-score for salaries. 
# In terms of salary, what is the best department right now to work for? The worst?
drop temporary TABLE dept_sal;

create table dept_sal_emp as (
		select emp_no, salary, salaries.to_date as sal_to, dept_name, dept_emp.to_date as dept_to
		from employees.employees
		join employees.dept_emp using(emp_no)
		join employees.departments using(dept_no)
		join employees.salaries using(emp_no)
);

select dept_name
from dept_sal
group by dept_name;

use easley_1262;

select *
from dept_sal;

Alter table dept_sal drop column emp_no,
					 drop column sal_to,
					 drop column dept_to;

drop table dept_avg_sal;

# Average salary to each department					 
create table dept_avg_sal as		 
	(select dept_name, avg(salary) as Average
	from dept_sal
	where dept_name = "Customer Service")
	UNION
	(select dept_name, avg(salary)  as Average
	from dept_sal
	where dept_name = "Development")
	UNION
	(select dept_name, avg(salary)  as Average
	from dept_sal
	where dept_name = "Finance")
	UNION
	(select dept_name, avg(salary)  as Average
	from dept_sal
	where dept_name = "Human Resources")
	UNION
	(select dept_name, avg(salary)  as Average
	from dept_sal
	where dept_name = "Marketing")
	UNION
	(select dept_name, avg(salary)  as Average
	from dept_sal
	where dept_name = "Production")
	UNION
	(select dept_name, avg(salary)  as Average
	from dept_sal
	where dept_name = "Quality Management")
	UNION
	(select dept_name, avg(salary)  as Average
	from dept_sal
	where dept_name = "Research")
	UNION
	(select dept_name, avg(salary)  as Average
	from dept_sal
	where dept_name = "Sales");


# testing average
select avg(salary)
from dept_sal;
# testing SD
select stddev(salary)
from dept_sal;

# adding SD and Historical average to table	
alter table dept_avg_sal add hist_sd decimal(14,5);
update dept_avg_sal set hist_sd = (select stddev(salary)
										from dept_sal);
										
alter table dept_avg_sal add avg_hist_sal decimal(14,5);
update dept_avg_sal set avg_hist_sal = (select avg(salary)
										from dept_sal);
										
										
alter table dept_avg_sal drop column avg_hist_sal,
						 drop column hist_sd;
						
alter table dept_avg_sal rename column "avg(salary)" "dept_average";
										
select *
from dept_avg_sal;

alter table dept_avg_sal add zscore decimal(14,5);
update dept_avg_sal set zscore = (select ((Average - avg_hist_sal) / hist_sd)
from dept_avg_sal2);

select *
from dept_avg_sal
order by zscore desc;

select dept_name, ((Average - avg_hist_sal) / hist_sd) as zscore
from dept_avg_sal
order by zscore desc;



