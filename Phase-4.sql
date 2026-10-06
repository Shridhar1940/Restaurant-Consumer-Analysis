/*Show the Consumer_ID, Restaurant_ID, and Overall_Rating for all ratings where the Overall_Rating was 'Highly Satisfactory' 
(which corresponds to a value of 2, according to the data dictionary).*/
select Consumer_ID,Restaurant_ID,Overall_Rating 
from ratings
where Overall_Rating=2;

-- The analysis identifies customer–restaurant interactions where customers reported Highly Satisfactory overall experiences. 
-- These records can be used to identify restaurants receiving strong customer satisfaction and to further analyze which customers 
-- and restaurant characteristics are associated with positive experiences.

-- List the names and cities of all restaurants that have an Overall_Rating of 2 (Highly Satisfactory) from at least one consumer.
select distinct restaurants.Name,restaurants.City,ratings.Overall_Rating
from restaurants inner join ratings
on restaurants.Restaurant_ID=ratings.Restaurant_ID
where ratings.Overall_Rating=2;

-- The analysis identifies a broad set of restaurants that have received at least one Highly Satisfactory rating. 
-- Most of these restaurants are located in San Luis Potosi, indicating that the dataset contains a large concentration of 
-- positively rated restaurants in that city.

select Name,City
from restaurants 
where Restaurant_ID in (select Restaurant_ID from ratings where Overall_Rating>1);



-- For each restaurant, calculate its average Overall_Rating. Then, list the restaurant Name, City, and its calculated average 
-- Overall_Rating, but only for restaurants located in 'Cuernavaca' AND whose calculated average Overall_Rating is greater than 1.0.
select restaurants.Name,restaurants.City,avg(ratings.overall_rating)
from restaurants join ratings
on restaurants.Restaurant_ID=ratings.Restaurant_ID
where restaurants.city='Cuernavaca' 
group by ratings.Restaurant_ID
having avg(ratings.Overall_Rating)>1;

-- Among restaurants in Cuernavaca, Mariscos Tia Licha has the highest average Overall Rating at 1.60, followed by Vips at 1.43, 
-- Subway at 1.33, and Restaurant Los Pinos at 1.25. These restaurants have an average customer rating above 1.0, indicating generally 
-- positive customer satisfaction based on the dataset's rating scale.


-- List restaurants (Name, City) that have received a Food_Rating lower than the average Food_Rating across all rated restaurants.
select Name,City 
from restaurants
where Restaurant_ID in (select Restaurant_ID from ratings where Food_Rating < (select avg(Food_Rating) from ratings));

-- The analysis identifies restaurants that have received at least one below-average Food Rating compared with the overall food-rating 
-- benchmark. These restaurants can be investigated further to identify potential food-quality issues and understand whether low food 
-- ratings are isolated incidents or consistent patterns.

-- Create a VIEW named HighlyRatedMexicanRestaurants that shows the Restaurant_ID, Name,
-- and City of all Mexican restaurants that have an average Overall_Rating greater than 1.5.
drop view HighlyRatedMexicanRestaurants;
create view HighlyRatedMexicanRestaurants as
select * 
from (
select restaurants.restaurant_id,restaurants.name,restaurants.city,
avg(ratings.overall_rating) as Avg_Overall_Rating
from restaurants join restaurant_cuisines
on restaurants.restaurant_id=restaurant_cuisines.restaurant_id
join ratings
on restaurants.restaurant_id=ratings.restaurant_id
where restaurant_cuisines.cuisine='Mexican'
group by ratings.restaurant_id
) as temp
where Avg_Overall_Rating>1.5;

select * from HighlyRatedMexicanRestaurants;

-- Among the Mexican restaurants in the dataset, La Cochinita Pibil Restaurante Yucateco is the only restaurant with an 
-- average Overall Rating above 1.5, with an average rating of 1.7143. The view makes this high-performing Mexican restaurant 
-- information reusable for further customer and restaurant analysis.


-- Identify the top 2 highest-rated (by Overall_Rating) restaurants for each cuisine type. If there
-- are ties in rating, include all tied restaurants. Display Cuisine, Restaurant_Name, City, and
-- Overall_Rating.

with CTE as (
select distinct restaurants.Name,restaurants.city,restaurant_cuisines.cuisine,ratings.overall_rating,
dense_rank() over(partition by restaurant_cuisines.cuisine order by ratings.overall_rating desc) as Ranking
from restaurants join restaurant_cuisines
on restaurants.restaurant_id=restaurant_cuisines.restaurant_id
join ratings
on ratings.restaurant_id=restaurants.restaurant_id)
select * from CTE
where Ranking<=2;



-- This analysis identifies the top-performing restaurants within each cuisine based on their average Overall Rating. 
-- Using average restaurant-level ratings provides a more reliable comparison than ranking individual rating records, 
-- while DENSE_RANK() ensures that restaurants with tied average ratings are all included.

