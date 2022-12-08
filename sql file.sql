use sakila;
-- 1. Create a query or queries to extract the information you think may be relevant
-- for building the prediction model. It should include some film features and some rental features.
-- Use the data from 2005.
-- 2. Create a query to get the list of films and a boolean indicating if it was rented last month (May 2005).
-- This would be our target variable.
-- 3. Read the data into a Pandas dataframe.
-- 4. Analyze extracted features and transform them. You may need to encode some categorical variables,
-- or scale numerical variables.
-- 5. Create a logistic regression model to predict this variable from the cleaned data.
-- 6. Evaluate the results.

-- 1
-- rented films, , f.film_id, f.title, release_year ,rental_date, 
-- rental_rate,(i.inventory_id), return_date, length
select distinct f.film_id, f.title, r.rental_date, 
f.rental_rate, r.return_date, i.inventory_id, f.length
from film f join inventory i on i.film_id = f.film_id
join rental r on r.inventory_id = i.inventory_id
where date_format((r.rental_date), "%Y") = 2005;

-- 1.2
select count(f.film_id), f.title, r.rental_date, 
f.rental_rate, r.return_date, i.inventory_id, f.length,
case when
(
sum(
case
when date_format((r.rental_date), "%M") = "May" and
date_format((r.rental_date), "%Y") = 2005 then True
else False
end 
)
) >= 1 then 1 else 0 end as rented_in_may_2005

from film f
join inventory i on i.film_id = f.film_id
join rental r on r.inventory_id = i.inventory_id
group by f.title;

-- 1.3
select count(f.film_id), f.title, r.rental_date, 
f.rental_rate, r.return_date, i.inventory_id, f.length
from film f
join inventory i on i.film_id = f.film_id
join rental r on r.inventory_id = i.inventory_id
where date_format((r.rental_date), "%Y") = 2005
group by f.title order by r.rental_date desc;

-- 2
select distinct f.title, case when
(
sum(
case
when date_format((r.rental_date), "%M") = "May" and
date_format((r.rental_date), "%Y") = 2005 then True
else False
end 
)
) >= 1 then 1 else 0 end as rented_in_may_2005

from film f
join inventory i on i.film_id = f.film_id
join rental r on r.inventory_id = i.inventory_id
group by f.title;
-- where i.inventory_id in
-- (
-- select r.inventory_id from rental r
-- where date_format((r.rental_date), "%M") = "May" and
-- date_format((r.rental_date), "%Y") = 2005
-- );

-- 3
select distinct f.film_id, f.title, r.rental_date, 
f.rental_rate, r.return_date, i.inventory_id, f.length,
case when
(
sum(
case
when date_format((r.rental_date), "%M") = "May" and
date_format((r.rental_date), "%Y") = 2005 then True
else False
end 
)
) >= 1 then 1 else 0 end as rented_in_may_2005

from film f
join inventory i on i.film_id = f.film_id
join rental r on r.inventory_id = i.inventory_id
group by f.title;