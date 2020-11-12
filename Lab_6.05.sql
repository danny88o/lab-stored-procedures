-- lab 6.05 -- Stored Procedures
use sakila;

-- 1
drop procedure Name_Category;
delimiter $$
create procedure Name_Category(in cat varchar(30))
begin
  select first_name, last_name, email
  from customer
  join rental on customer.customer_id = rental.customer_id
  join inventory on rental.inventory_id = inventory.inventory_id
  join film on film.film_id = inventory.film_id
  join film_category on film_category.film_id = film.film_id
  join category on category.category_id = film_category.category_id
  where category.name = cat
  group by first_name, last_name, email;
end $$
delimiter ;

call  Name_Category("Animation");

-- 2
select c.name, count(f.film_id)
from film f
left join film_category fcat on fcat.film_id = f.film_id
left join category c on c.category_id = fcat.category_id
group by c.name
having count(f.film_id) > 60
;

drop procedure movie_limit;
delimiter $$
create procedure movie_limit(in num int)
begin
	select c.name, count(f.film_id) as countnum
	from film f
	left join film_category fcat on fcat.film_id = f.film_id
	left join category c on c.category_id = fcat.category_id
    group by c.name
   	having count(f.film_id) > num
    ;
	end $$
delimiter ;

call movie_limit(60)

