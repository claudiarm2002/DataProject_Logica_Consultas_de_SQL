-- Data Project: Lógica Consultas SQL

-- 1. Crea el esquema de la BBDD.

-- 2. Muestra los nombres de todas las películas con una clasificación por edades de ‘R’.
select f."title"
from "film" f
where f."rating" = 'R';

-- 3. Encuentra los nombres de los actores que tengan un “actor_id” entre 30 y 40.
select CONCAT(a."first_name", ' ', a."last_name") as complete_name 
from "actor" a
where a."actor_id" between 30 and 40;

-- 4. Obtén las películas cuyo idioma coincide con el idioma original.
select f."film_id", f."title"
from "film" f
where f.language_id = f.original_language_id;

-- 5. Ordena las películas por duración de forma ascendente.
select f."film_id", f."title"
from "film" f
order by f."length" ASC;

-- 6. Encuentra el nombre y apellido de los actores que tengan ‘Allen’ en su apellido.
select CONCAT(a."first_name", ' ', a."last_name") 
from "actor" a
where a."last_name" = 'ALLEN';

-- 7. Encuentra la cantidad total de películas en cada clasificación de la tabla “film” y muestra la clasificación junto con el recuento.
select f."rating", COUNT(*) as total_films
from "film" f
group by f."rating";

-- 8. Encuentra el título de todas las películas que son ‘PG-13’ o tienen una duración mayor a 3 horas en la tabla film.
select f."title"
from "film" f
where f."rating" = 'PG-13' or f.length > 180;

-- 9. Encuentra la variabilidad de lo que costaría reemplazar las películas.
select STDDEV(f."replacement_cost")
from "film" f;

-- 10. Encuentra la mayor y menor duración de una película de nuestra BBDD.
select 
	MAX(f."length") as max_length,
	MIN(f."length") as min_length
from "film" f;

-- 11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.
-- I use join to be sure that I'm taking the third to last rental.
select p."amount" as cost_third_last
from "rental" r
join "payment" p on r."rental_id" = p."rental_id"
order by r."rental_date" desc
limit 1
offset 2;

-- 12. Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC-17’ ni ‘G’ en cuanto a su clasificación.
select "title" 
from "film"
where "rating" not in ('NC-17', 'G');

-- 13. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.
select "rating", AVG("length") as average_length
from "film"
group by "rating";

-- 14. Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.
select "title"
from "film"
where "length" > 180;

-- 15. ¿Cuánto dinero ha generado en total la empresa?
select SUM("amount") as total_gain
from "payment";

-- 16. Muestra los 10 clientes con mayor valor de id.
select CONCAT("first_name", ' ', "last_name") as customer_name
from "customer"
order by "customer_id" desc
limit 10;

-- 17. Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igby’.
select CONCAT(a.first_name, ' ', a.last_name) as actor_name
from "actor" a 
inner join "film_actor" fa on a.actor_id = fa.actor_id 
inner join "film" f on fa.film_id = f.film_id  
where f.title = 'EGG IGBY';

-- 18. Selecciona todos los nombres de las películas únicos.
select distinct "title"
from "film";

select "title"
from "film"
group by title
having COUNT(*) = 1;

-- 19. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “film”.
select f."title"
from "film" f
inner join "film_category" fc on f.film_id = fc.film_id 
inner join "category" c on fc.category_id = c.category_id 
where c."name" = 'Comedy' and f.length > 180;

-- 20. Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría junto con el promedio de duración.
select c."name" as category, AVG(f.length) as average_length
from "film" f
inner join "film_category" fc on f."film_id" = fc."film_id"
inner join "category" c on fc."category_id" = c."category_id"
group by c."name"
having AVG(f.length) > 110;

-- 21. ¿Cuál es la media de duración del alquiler de las películas?
select AVG("rental_duration") as average_rental_duration
from "film";

-- 22. Crea una columna con el nombre y apellidos de todos los actores y actrices.
select CONCAT("first_name", ' ', "last_name")
from "actor";

-- 23. Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.
select 
	DATE("rental_date") as day, 
	COUNT("rental_date") as amount
from "rental"
group by DATE("rental_date")
order by amount desc;

-- 24. Encuentra las películas con una duración superior al promedio.
select "title"
from "film"
where "length" > (select AVG("length") from "film");

-- 25. Averigua el número de alquileres registrados por mes.
select
	extract (year from "rental_date") as year,
	extract (month from "rental_date") as month,
	COUNT("rental_date") as amount
from "rental"
group by year, month;

-- 26. Encuentra el promedio, la desviación estándar y varianza del total pagado.
select 
	AVG("amount") as average_payments,
	STDDEV("amount") as standard_deviation_payments,
	VARIANCE("amount") as variance_payments
from "payment";

-- 27. ¿Qué películas se alquilan por encima del precio medio?
select "title"
from "film"
where "rental_rate" > (select AVG("rental_rate") from "film");

-- 28. Muestra el id de los actores que hayan participado en más de 40 películas.
select fa."actor_id"
from "film_actor" fa
group by fa.actor_id
having COUNT(fa."film_id") > 40;

-- 29. Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.
select 
	f."title", 
	COUNT(i."inventory_id") as available_num
from "film" f
left join "inventory" i on f."film_id" = i."film_id"
group by f."title";

-- 30. Obtener los actores y el número de películas en las que ha actuado.
select 
	CONCAT(a."first_name", ' ', a."last_name") as artist_name,
	COUNT(fa."film_id") as number_of_films
from "actor" a
left join "film_actor" fa on fa."actor_id" = a."actor_id"
group by a."actor_id", a."first_name", a."last_name";

-- 31. Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados.
select 
	f."title" as film_name,
	STRING_AGG(CONCAT(a.first_name, ' ', a.last_name), ', ') as actors
from "film" f
left join "film_actor" fa on f."film_id" = fa."film_id"
left join "actor" a on fa."actor_id" = a."actor_id"
group by f."title";

-- 32. Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película.
select 
	CONCAT(a."first_name", ' ', a."last_name") as artist_name,
	STRING_AGG(f."title", ', ') as films
from "actor" a
left join "film_actor" fa on a."actor_id" = fa."actor_id"
left join "film" f on f."film_id" = fa."film_id"
group by a."actor_id", a."first_name", a."last_name";

-- 33. Obtener todas las películas que tenemos y todos los registros de alquiler.
select f."title", r."rental_id" 
from "film" f
full join "inventory" i on f."film_id" = i."film_id"
full join "rental" r on i."inventory_id" = r."inventory_id";

-- Lists all movies and concatenates their rental record IDs into a single column
select 
	f."title", 
	STRING_AGG(r."rental_id"::text, ', ') as rental_records
from "film" f
full join "inventory" i on f."film_id" = i."film_id"
full join "rental" r on i."inventory_id" = r."inventory_id"
group by f."film_id", f."title";

-- 34.  Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.
select 
	c."customer_id",
	CONCAT(c."first_name", ' ', c."last_name") as customer_name,
	SUM(p."amount") as total_spent
from "customer" c
left join "payment" p on c."customer_id" = p."customer_id"
group by c."customer_id", c."first_name", c."last_name"
order by SUM(p."amount") desc
limit 5;

-- 35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.
select *
from "actor"
where "first_name" = 'JOHNNY';

-- 36. Renombra la columna “first_nameˮ como Nombre y “last_nameˮ como Apellido.
select 
	"first_name" as Nombre,
	"last_name" as Apellido
from "actor";

-- 37. Encuentra el ID del actor más bajo y más alto en la tabla actor.
select 
	MIN("actor_id") as min_id,
	MAX("actor_id") as max_id
from "actor";

-- 38. Cuenta cuántos actores hay en la tabla “actor”.
select COUNT("actor_id") as total_actors
from "actor";

-- 39. Selecciona todos los actores y ordénalos por apellido en orden ascendente.
select *
from "actor"
order by "last_name", "first_name" asc;

-- 40. Selecciona las primeras 5 películas de la tabla “film”.
select *
from "film"
limit 5;

-- 41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido?
select 
	"first_name",
	COUNT("first_name") as name_count
from "actor"
group by "first_name"
order by COUNT("first_name") desc;

-- 42. Encuentra todos los alquileres y los nombres de los clientes que los realizaron.
select 
	r."rental_id",
	CONCAT(c."first_name", ' ', c."last_name") as customer_name
from "rental" r
left join "customer" c on r."customer_id" = c."customer_id";

-- 43. Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.
select 
	CONCAT(c."first_name", ' ', c."last_name") as customer_name,
	r."rental_id"
from "customer" c
left join "rental" r on r."customer_id" = c."customer_id";

-- 44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación.
select
    f.title,
    c.name AS category_name
from film f
cross join category c;

-- No, it does not provide any value, as the CROSS JOIN displays all possible combinations between "film" and "category", even if they have no relationship.

-- 45. Encuentra los actores que han participado en películas de la categoría 'Action'.
select distinct (CONCAT(a."first_name", ' ', a."last_name")) as actor_name
from "actor" a
join "film_actor" fa on a.actor_id = fa.actor_id
join "film_category" fc on fa."film_id" = fc."film_id"
join "category" c on fc."category_id" = c."category_id"
where c."name" = 'Action';

-- 46. Encuentra todos los actores que no han participado en películas.
select CONCAT(a."first_name", ' ', a."last_name") as actor_name
from "actor" a
left join "film_actor" fa on a.actor_id = fa.actor_id
where fa."film_id" is null;

-- 47. Selecciona el nombre de los actores y la cantidad de películas en las que han participado.
-- This is the same query as number 30
select 
	CONCAT(a."first_name", ' ', a."last_name") as artist_name,
	COUNT(fa."film_id") as number_of_films
from "actor" a
left join "film_actor" fa on fa."actor_id" = a."actor_id"
group by a."actor_id", a."first_name", a."last_name";

-- 48. Crea una vista llamada “actor_num_peliculas” que muestre los nombres de los actores y el número de películas en las que han participado.
create view actor_num_peliculas as
select
	CONCAT(a."first_name", ' ', a."last_name") as artist_name,
	COUNT(fa."film_id") as number_of_films
from "actor" a
left join "film_actor" fa on fa."actor_id" = a."actor_id"
group by a."actor_id", a."first_name", a."last_name";

-- 49. Calcula el número total de alquileres realizados por cada cliente.
select 
	CONCAT(c."first_name", ' ', c."last_name") as customer_name,
	COUNT(r."customer_id") as total_rentals
from "customer" c
left join "rental" r on r."customer_id" = c."customer_id"
group by c."customer_id", c."first_name", c."last_name";

-- 50. Calcula la duración total de las películas en la categoría 'Action'.
select SUM(f."length") as total_action_minutes
from "film" f
inner join "film_category" fc on fc."film_id" = f."film_id"
inner join "category" c on fc."category_id" = c."category_id"
where c."name" = 'Action';

-- 51. Crea una tabla temporal llamada “cliente_rentas_temporal” para almacenar el total de alquileres por cliente.
create temporary table cliente_rentas_temporal as
select 
	CONCAT(c."first_name", ' ', c."last_name") as customer_name,
	COUNT(r."customer_id") as total_rentals
from "customer" c
left join "rental" r on r."customer_id" = c."customer_id"
group by c."customer_id", c."first_name", c."last_name";

-- 52. Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las películas que han sido alquiladas al menos 10 veces.
create temporary table peliculas_alquiladas as
select f."title", COUNT(f."film_id") as total_rentals
from "film" f
left join "inventory" i on f."film_id" = i."film_id"
inner join "rental" r on i."inventory_id" = r."inventory_id"
group by f."film_id", f."title"
having COUNT(f."film_id") > 9;

-- 53. Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sanders’ y que aún no se han devuelto. Ordena los resultados alfabéticamente por título de película.
select f."title"
from "customer" c
inner join "rental" r on c."customer_id" = r."customer_id"
inner join "inventory" i on r."inventory_id" = i."inventory_id"
inner join "film" f on i."film_id" = f."film_id"
where c."first_name" = 'TAMMY' and c."last_name" = 'SANDERS' and r.return_date is null
order by f."title";

-- 54. Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría ‘Sci-Fi’. Ordena los resultados alfabéticamente por apellido.
-- I am going to use the following table in another query (56).
create temporary table actor_category_table as 
select 
    c."name" as category_name,
    a."first_name",
    a."last_name"
from "actor" a
left join "film_actor" fa on a."actor_id" = fa."actor_id"
left join "film" f on fa."film_id" = f."film_id"
left join "film_category" fc on f."film_id" = fc."film_id"
left join "category" c on fc."category_id" = c."category_id";

select distinct "first_name", "last_name"
from "actor_category_table"
where "category_name" = 'Sci-Fi'
order by "last_name", "first_name";

-- 55. Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película ‘Spartacus Cheaper’ se alquilara por primera vez. Ordena los resultados alfabéticamente por apellido.
with first_spartacus_rental as (
	select r."rental_date"
	from "rental" r
	inner join "inventory" i on r."inventory_id" = i."inventory_id"
	inner join "film" f on i."film_id" = f."film_id"
	where f."title" = 'SPARTACUS CHEAPER'
	order by r."rental_date"
	limit 1
)
select distinct a."first_name", a."last_name"
from "actor" a
inner join "film_actor" fa on a."actor_id" = fa."actor_id"
inner join "film" f on fa."film_id" = f."film_id"
inner join "inventory" i on f."film_id" = i."film_id"
inner join "rental" r on i."inventory_id" = r."inventory_id"
cross join first_spartacus_rental fsr
where r."rental_date" > fsr."rental_date"
-- The cross join adds the single-row first rental date to every row so we can compare each rental’s date against it.
order by a."last_name", a."first_name";

-- 56. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Music’.
select distinct a."first_name", a."last_name"
from "actor_category_table" a
where not exists (
-- not exists checks if the subquery returns no rows. If there are no matches, it returns TRUE, thus selecting actors who have not acted in any 'Music' movies.
    select 1
    from "actor_category_table" m
    where m."first_name" = a."first_name" and m."last_name" = a."last_name" and m.category_name = 'Music'
)
order by a."first_name", a."last_name";

-- 57. Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.
select distinct f."title"
from "rental" r
left join "inventory" i on r."inventory_id" = i."inventory_id"
left join "film" f on i."film_id" = f."film_id"
where r."return_date" is not null and (r."return_date" - r."rental_date") > INTERVAL '8 days';
-- Because both rental_date and return_date are stored as timestamps, subtracting them returns an interval, not a number. 
-- Therefore, comparing the result directly to 8 caused an error, so I used INTERVAL '8 days' to match the data type.

-- 58. Encuentra el título de todas las películas que son de la misma categoría que ‘Animation’.
-- The statement is poorly written, as it seems to suggest finding the films that belong to the same category as the film mentioned in the question. 
select f."title"
from "film" f
inner join "film_category" fc on f."film_id" = fc."film_id"
inner join "category" c on fc."category_id" = c."category_id"
where c."name" = 'Animation';

-- 59. Encuentra los nombres de las películas que tienen la misma duración que la película con el título ‘Dancing Fever’. Ordena los resultados alfabéticamente por título de película.
select "title"
from "film"
where "length" = (
	select "length"
	from "film"
	where "title" = 'DANCING FEVER'
) and "title" <> 'DANCING FEVER';

-- 60. Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. Ordena los resultados alfabéticamente por apellido.
select 
	CONCAT(c.first_name, ' ', c.last_name) as customer_name,
	COUNT(distinct f.film_id) as films_rented
from "film" f
inner join "inventory" i on f."film_id" = i."film_id"
inner join "rental" r on i."inventory_id" = r."inventory_id"
inner join "customer" c on r."customer_id" = c."customer_id"
group by c.customer_id 
having COUNT(distinct f.film_id) > 6
order by c."last_name";

-- 61. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.
select 
	c."name" as category_name, 
	COUNT(r."rental_id") as total_rentals
from "rental" r
inner join "inventory" i on r."inventory_id" = i."inventory_id" 
inner join "film_category" fc on i."film_id" = fc."film_id" 
inner join "category" c on fc."category_id" = c."category_id" 
group by c."category_id", c."name"; 

-- 62. Encuentra el número de películas por categoría estrenadas en 2006.
select 
	c."name" as category_name,
	COUNT(f."film_id") as total_films_released_2006
from "film" f
inner join "film_category" fc on f."film_id" = fc."film_id"
inner join "category" c on fc."category_id" = c."category_id"
where f."release_year" = 2006
group by c."category_id", c."name";

-- 63. Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.
select 
	CONCAT(s2."first_name", ' ', s2."last_name") as staff_name,
	s."store_id"
from "store" s
cross join "staff" s2;

-- 64. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.
-- In a real project, I would slightly modify query 51 to achieve this.
select 
	c."customer_id",
	CONCAT(c."first_name", ' ', c."last_name") as customer_name,
	COUNT(r."customer_id") as total_rentals
from "customer" c
left join "rental" r on r."customer_id" = c."customer_id"
group by c."customer_id", c."first_name", c."last_name";



