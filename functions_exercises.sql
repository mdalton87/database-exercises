# 1. Copy the order by exercise and save it as functions_exercises.sql.
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

# 2 . Write a query to to find all current employees whose last name starts and ends with 'E'. Use concat() to combine their first and last name together as a single column named full_name.

select concat(first_name, " ",last_name) as 'full_name'
from employees
where last_name like 'e%e';

# 3. Convert the names produced in your last query to all uppercase.

select upper(concat(first_name, " ",last_name)) as 'full_name'
from employees
where last_name like 'e%e';

# 4. Find all previous employees hired in the 90s and born on Christmas. Use datediff() function to find how many days they have been working at the company (Hint: You will also need to use NOW() or CURDATE()),

select concat(first_name," ",last_name) as full_name,
	concat(datediff(now(), hire_date)) as 'days working here'
from employees
where hire_date like '199%'
	and birth_date like '%12-25';

# 5. Find the smallest and largest current salary from the salaries table.

select min(salary), max(salary)
from salaries;


/*
6. Use your knowledge of built in SQL functions to generate a username for all of the current and previous employees. A username should be:
all lowercase, 
consist of the first character of the employees first name, 
the first 4 characters of the employees last name, 
an underscore, 
the month the employee was born, 
and the last two digits of the year that they were born. 
Below is an example of what the first 10 rows will look like:
+------------+------------+-----------+------------+
| username   | first_name | last_name | birth_date |
+------------+------------+-----------+------------+
| gface_0953 | Georgi     | Facello   | 1953-09-02 |
| bsimm_0664 | Bezalel    | Simmel    | 1964-06-02 |
| pbamf_1259 | Parto      | Bamford   | 1959-12-03 |
| ckobl_0554 | Chirstian  | Koblick   | 1954-05-01 |
| kmali_0155 | Kyoichi    | Maliniak  | 1955-01-21 |
| apreu_0453 | Anneke     | Preusig   | 1953-04-20 |
| tziel_0557 | Tzvetan    | Zielinski | 1957-05-23 |
| skall_0258 | Saniya     | Kalloufi  | 1958-02-19 |
| speac_0452 | Sumant     | Peac      | 1952-04-19 |
| dpive_0663 | Duangkaew  | Piveteau  | 1963-06-01 |
+------------+------------+-----------+------------+
*/
select lower(
	concat(
		substr(first_name, 1, 1),substr(last_name, 1, 4),"_",substr(birth_date, 6, 2),substr(birth_date, 3, 2))
        ) as 'Username', 
        first_name, 
        last_name, 
        birth_date
from employees
limit 10;
/* 
gface_0953	Georgi	Facello	1953-09-02
bsimm_0664	Bezalel	Simmel	1964-06-02
pbamf_1259	Parto	Bamford	1959-12-03
ckobl_0554	Chirstian	Koblick	1954-05-01
kmali_0155	Kyoichi	Maliniak	1955-01-21
apreu_0453	Anneke	Preusig	1953-04-20
tziel_0557	Tzvetan	Zielinski	1957-05-23
skall_0258	Saniya	Kalloufi	1958-02-19
speac_0452	Sumant	Peac	1952-04-19
dpive_0663	Duangkaew	Piveteau	1963-06-01
*/
