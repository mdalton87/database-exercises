USE employees;

show tables;

describe employees;
# emp_no contains numbers
# first_name, last_name, gender contain strings
# birth_date and hire_date contain dates
describe current_dept_emp;
describe departments;
describe dept_emp;
describe dept_emp_latest_date;
describe dept_manager;
describe employees_with_departments;
describe salaries;
describe titles;
# Tables with numerical type columns: employees, current_dept_emp, dept_emp, dept_emp_latest_date, dept_manager, employees_with_departments, salaries, titles
# Tables with string type columns: employees, departments, current_dept_emp, dept_emp, dept_manager, employees_with_departments, salaries, titles
#Tables with data type columns: All tables contain data types
describe employees;
describe departments;
# No field ties those two tables together, but if you incorporate another table, like "current_dept_emp", they can be linked

show create table dept_manager;


 
