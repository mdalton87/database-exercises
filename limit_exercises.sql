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

################################################################################################################################################################################################################
################################################################################################################################################################################################################
################################################################################################################################################################################################################

# 2. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name. 
# -- In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?

select * 
from employees
where first_name in ('Irena', 'Vidya', 'Maya')
order by first_name;
# 2.  Irena Reutenauer, Vidya Simmen

# 3. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name and then last name. 
# -- In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?

select * 
from employees
where first_name in ('Irena', 'Vidya', 'Maya')
order by first_name, last_name;
# 3. Irena Acton, Vidya Zweizig

# 4. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by last name and then first name. 
# -- In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?

select * 
from employees
where first_name in ('Irena', 'Vidya', 'Maya')
order by last_name, first_name;
# 4. Irena Acton, Maya Zyda

# 5. Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their employee number. 
# -- Enter a comment with the number of employees returned, the first employee number and their first and last name, and the last employee number with their first and last name.

select *
from employees
where last_name like 'e%e'
order by emp_no;
# 899, Ramzi Erde, Tadahiro Erde

# 6. Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their hire date, so that the newest employees are listed first. 
# -- Enter a comment with the number of employees returned, the name of the newest employee, and the name of the oldest emmployee.

select *
from employees
where last_name like 'e%e'
order by hire_date desc;
# 899, Teiji Eldridge, Sergi Erde

# 7. Find all employees hired in the 90s and born on Christmas. Sort the results so that the oldest employee who was hired last is the first result. 
# -- Enter a comment with the number of employees returned, the name of the oldest employee who was hired last, and the name of the youngest emmployee who was hired first.

select *
from employees
where birth_date like '%12-25'
and hire_date like '199%'
order by birth_date asc, hire_date desc; 
# 362, Khun Bernini, Douadi Pettis

################################################################################################################################################################################################################
################################################################################################################################################################################################################
################################################################################################################################################################################################################

# 1. Create a new SQL script named limit_exercises.sql.

# 2. MySQL provides a way to return only unique results from our queries with the keyword DISTINCT. For example, to find all the unique titles within the company, we could run the following query:
# (SELECT DISTINCT title FROM titles);
# -- List the first 10 distinct last name sorted in descending order.

select distinct last_name
from employees
order by last_name desc
limit 10;
# 	Zykh, Zyda, Zwicker, Zweizig, Zumaque, Zultner, Zucker, Zuberek, Zschoche, Zongker

# 3. Find all previous or current employees hired in the 90s and born on Christmas. Find the first 5 employees hired in the 90's by sorting by hire date and limiting your results to the first 5 records. 
# Write a comment in your code that lists the five names of the employees returned.

select *
from employees
where hire_date like '199%'
	and birth_date like '%12-25'
order by hire_date
limit 5;
# Alselm Cappello, Utz Mandell, Bouchung Schreiter, Baocai Kushner, Petter Stroustrup

# 4. Try to think of your results as batches, sets, or pages. The first five results are your first page. The five after that would be your second page, etc. Update the query to find the tenth page of results.
# -- LIMIT and OFFSET can be used to create multiple pages of data. What is the relationship between OFFSET (number of results to skip), LIMIT (number of results per page), and the page number?

select *
from employees
where hire_date like '199%'
	and birth_date like '%12-25'
order by hire_date
limit 5 offset 45;
# offeset_number = (page_number - 1) * limit_number
#Pranay Narwekar, Marjo Farrow, Ennio Karcich, Dines Lubachevsky, Ipke Fontan


##