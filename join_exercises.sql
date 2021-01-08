# How much do the current managers of each department get paid, relative to the average salary for the department? Is there any department where the department manager gets paid less than the average salary?

use employees;

# Dept manager salary`
select dept_name, salary as mgr_salary
from dept_manager
join salaries using(emp_no)
join departments using(dept_no)
where dept_manager.to_date > curdate()
	and
	salaries.to_date > curdate();

# current average salary of all employees per department
select dept_name, avg(salary) as avg_salary
from dept_emp
join salaries using(emp_no)
join departments using(dept_no)
where salaries.to_date > curdate()
	and 
	dept_emp.to_date > curdate()
group by dept_name;


use easley_1262;
# dept_mgr_sal table
Create temporary table dept_mgr_sal as 
(
select dept_name, salary as mgr_salary
from employees.dept_manager
join employees.salaries using(emp_no)
join employees.departments using(dept_no)
where dept_manager.to_date > curdate()
	and
	salaries.to_date > curdate()
);
# dept_avg_salary table
create temporary table dept_avg_salary as
(
select dept_name, avg(salary) as avg_salary
from employees.dept_emp
join employees.salaries using(emp_no)
join employees.departments using(dept_no)
where salaries.to_date > curdate()
	and 
	dept_emp.to_date > curdate()
group by dept_name
);

# Joiner table
select *, (mgr_salary - avg_salary) as difference_of_manager_salary							
from dept_mgr_sal
join dept_avg_salary using(dept_name)
order by difference_of_manager_salary desc;

# WORLD DB
use world;

# What languages are spoken in Santa Monica?
select language, percentage
from countrylanguage
join city using(countrycode)
where city.name = 'Santa Monica'
order by percentage desc;

# How many different countries are in each region?

select region, count(*)
from country
group by region
order by count(*);

# What is the population for each region?

select region, sum(population) as reg_pop
from country

group by region
order by reg_pop desc;

# What is the population for each continent?

select continent, sum(population) as cont_pop
from country
group by continent
order by cont_pop desc;

# What is the average life expectancy globally?

select avg(lifeexpectancy)
from country;

# What is the average life expectancy for each region, each continent? Sort the results from shortest to longest

select region, avg(lifeexpectancy)
from country
group by region
order by avg(lifeexpectancy);

select continent, avg(lifeexpectancy)
from country
group by continent
order by avg(lifeexpectancy);


# BONUS

# Find all the countries whose local name is different from the official name

select Name, LocalName
from country
where Name != LocalName;

# How many countries have a life expectancy less than x?

select count(*)
from country
where LifeExpectancy < x; 

# What state is city x located in?

select District
from city
where Name = 'x'; 

# What region of the world is city x located in?

select region 
from country
join city on city.CountryCode = country.Code
where city.Name = 'x';

# What country (use the human readable name) city x located in?

select country.Name 
from country
join city on city.CountryCode = country.Code
where city.Name = 'x';

# What is the life expectancy in city x?

select LifeExpectancy
from country
join city on city.CountryCode = country.Code
where city.Name = 'x';

# SAKILA DB
use sakila;

# 1. Display the first and last names in all lowercase of all the actors.

select lower(first_name), lower(last_name)
from actor;

# 2. You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." What is one query would you could use to obtain this information?

select actor_id, first_name, last_name
from actor
where first_name = 'Joe';

# 3. Find all actors whose last name contain the letters "gen":

select first_name, last_name
from actor
where last_name like '%gen%';

# 4. Find all actors whose last names contain the letters "li". This time, order the rows by last name and first name, in that order.

select last_name, first_name
from actor
where last_name like '%li%';

# 5. Using IN, display the country_id and country columns for the following countries: Afghanistan, Bangladesh, and China:

select country_id, country
from country
where country in ('afghanistan', 'bangladesh', 'china');

# 6. List the last names of all the actors, as well as how many actors have that last name.

select last_name, count(*)
from actor
group by last_name;

# 7. List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors


select last_name, count(*)
from actor
group by last_name
having count(*) > 1;

# 8. You cannot locate the schema of the address table. Which query would you use to re-create it?

show create table address;

# 9. Use JOIN to display the first and last names, as well as the address, of each staff member.

select first_name, last_name, address
from staff
join address using(address_id);

# 10. Use JOIN to display the total amount rung up by each staff member in August of 2005.
`
select first_name, last_name;
`
# 11. List each film and the number of actors who are listed for that film.

select title, count(actor_id)
from film_actor
join film using(film_id)
join actor using(actor_id)
group by title;

# 12. How many copies of the film Hunchback Impossible exist in the inventory system?

select count(*)
from film
join inventory using(film_id)
where title = 'Hunchback Impossible';

# 13. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters K and Q have also soared in popularity. Use subqueries to display the titles of movies starting with the letters K and Q whose language is English.

select title
from film
join language using(language_id)
where language.name = 'english'
	and 
	title regexp '^(q|k)';

# 14. Use subqueries to display all actors who appear in the film Alone Trip.

select 

# 15. You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers.



# 16. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as  films.



# 17. Write a query to display how much business, in dollars, each store brought in.



# 18. Write a query to display for each store its store ID, city, and country.



# 19. List the top five genres in gross revenue in descending order. (Hint: you may need to use the following tables: category, film_category, inventory, payment, and rental.)








