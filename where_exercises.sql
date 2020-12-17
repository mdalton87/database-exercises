use employees;

# Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya' using IN. Enter a comment with the number of records returned.
select * 
from employees
where first_name in ('Irena', 'Vidya', 'Maya');
# 709 records returned

# Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', as in Q2, but use OR instead of IN. Enter a comment with the number of records returned. Does it match number of rows from Q2?
select * 
from employees
where first_name = 'Irena'
or first_name = 'Vidya'
or first_name = 'Maya';
# 709 records returned, both queries are equal

# Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', using OR, and who is male. Enter a comment with the number of records returned.
select * 
from employees
where 
	(first_name = 'Irena' or first_name = 'Vidya' or first_name = 'Maya')
and 
	gender = 'm';
# 441 records returned

# Find all current or previous employees whose last name starts with 'E'. Enter a comment with the number of employees whose last name starts with E.
select *
from employees
where last_name like 'E%';
# 7330 records returned

# Find all current or previous employees whose last name starts or ends with 'E'. Enter a comment with the number of employees whose last name starts or ends with E. 
select *
from employees
where last_name like 'E%'
or last_name like '%e';
# 30723 records returned

# -- How many employees have a last name that ends with E, but does not start with E?
select *
from employees
where last_name like '%e'
and last_name not like 'e%';
# 23393 records returned

# Find all current or previous employees employees whose last name starts and ends with 'E'. Enter a comment with the number of employees whose last name starts and ends with E. 
select *
from employees
where last_name like 'E%'
and last_name like '%e';
# 899 records returned

# -- How many employees' last names end with E, regardless of whether they start with E?
select *
from employees
where last_name like '%e';
# 24292 records returned

# Find all current or previous employees hired in the 90s. Enter a comment with the number of employees returned.
select *
from employees
where hire_date like '199%';
# 135214 records found

# Find all current or previous employees born on Christmas. Enter a comment with the number of employees returned.
select *
from employees
where birth_date like '%12-25';
# 842 records returned

# Find all current or previous employees hired in the 90s and born on Christmas. Enter a comment with the number of employees returned.
select *
from employees
where birth_date like '%12-25'
and hire_date like '199%'; 
# 362 records returned

# Find all current or previous employees with a 'q' in their last name. Enter a comment with the number of records returned.
select * 
from employees
where last_name like '%q%';
# 1873 records returned

# Find all current or previous employees with a 'q' in their last name but not 'qu'. How many employees are found?
select * 
from employees
where last_name like '%q%'
and not last_name like '%qu%';
# 547 records returned


