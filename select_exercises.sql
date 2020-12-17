USE albums_db;

describe albums;

select name
from albums
where artist = 'Pink Floyd';

select release_date
from albums
where name = 'Sgt. Pepper\'s Lonely Hearts Club Band';

select genre
from albums
where name = 'Nevermind';

select name
from albums
where release_date between 1990 and 1999;

select name
from albums
where sales < 20;

select name 
from albums
where genre = 'rock';
# Not all rock genres are showing because the query above is looking for "rock" as the entire string."

# The string below will add all rock genres
select name 
from albums
where genre LIKE '%rock%';

