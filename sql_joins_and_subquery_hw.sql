-- WEEK 5 WEDNESDAY QUESTIONS

-- 1. List all customers who live in Texas (use JOINs)
select customer_id, first_name, last_name, address, district
from customer 
full join address
on customer.address_id = address.address_id
where district = 'Texas';

-- 2. Get all payments above $6.99 with the Customer's Full Name
select first_name, last_name, amount
from customer
full join payment
on customer.customer_id = payment.customer_id
where amount > 6.99;

-- 3. Show all customers names who have made payments over $175(use subqueries)
select first_name, last_name
from customer 
where customer_id in (
	select customer_id
	from payment
	group by customer_id
	having sum(amount) > 175
	order by sum(amount) desc	
);

-- 4. List all customers that live in Nepal (use the city table)
select first_name, last_name, city
from customer
full join address
on customer.address_id = address.address_id 
full join city
on address.city_id = city.city_id 
where city = 'Nepal';
-- to double check:
--select city from city where city = 'Nepal';

-- 5. Which staff member had the most transactions?
-- notes: returns counts and staff ids in descending order. 
--		select staff_id 
--		from payment
--		group by staff_id
--		order by count(staff_id) desc;
--answer:
select count(payment.staff_id), payment.staff_id, first_name, last_name
from staff
full join payment 
on payment.staff_id = staff.staff_id 
group by payment.staff_id, first_name, last_name
order by count(payment.staff_id) desc
limit 1;

-- 6. How many movies of each rating are there? (no data in movie table - use film table)
select rating, count(rating)
from film
group by rating
order by count(rating) desc;

-- 7.Show all customers who have made a single payment above $6.99 (Use Subqueries)
select customer_id, first_name, last_name
from customer
where customer_id in (
	select customer_id 
	from payment
	where amount > 6.99
	group by customer_id
	having count(customer_id) = 1	
);
-- to check:
--select customer_id, amount from payment where customer_id = 97 and amount > 6.99;

-- 8. How many free rentals did our stores give away?
select count(payment.rental_id)
from rental
full join payment 
on payment.rental_id = rental.rental_id 
where amount = 0.00;
-- to check:
-- select amount from payment order by amount asc;




