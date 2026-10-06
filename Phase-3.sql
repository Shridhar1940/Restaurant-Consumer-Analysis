-- List the Name, City, Alcohol_Service, and Price of all restaurants that serve 'Wine & Beer' and have a 'Medium' price level.
select Name , City, Alcohol_Service, Price
from restaurants
where Alcohol_Service='Wine & Beer' and Price='Medium';

-- The analysis identifies 6 medium-priced restaurants that serve Wine & Beer, mainly concentrated in San Luis Potosi. 
-- These restaurants represent options for customers looking for moderate-priced dining with alcoholic beverage service.

-- Find the names and cities of all restaurants that are part of a 'Franchise'.
select Name,City 
from restaurants
where Franchise='Yes';

-- The analysis identifies 6 franchise restaurants across Cuernavaca and San Luis Potosi. 
-- This helps understand the presence and geographic distribution of franchise-based restaurants in the dataset.

-- List the names and cities of restaurants that serve 'Pizzeria' cuisine and are located in a city where at least one 'Student' 
-- consumer lives.
select distinct(restaurants.name),restaurants.city
from restaurants join restaurant_cuisines
on restaurants.restaurant_id=restaurant_cuisines.restaurant_id
join consumers
on consumers.city=restaurants.city
where restaurant_cuisines.cuisine='Pizzeria' and consumers.occupation='student';

-- The analysis identifies 2 Pizzeria restaurants in San Luis Potosi, a city where student consumers are present. 
-- This can help restaurant businesses understand the availability of Pizzeria options in locations with a student customer segment.

-- List the names of restaurants that serve 'Mexican' cuisine and have been rated by consumer 'U1001'.
select restaurants.Name,restaurant_cuisines.Cuisine,ratings.Consumer_ID
from restaurants inner join restaurant_cuisines
on restaurants.Restaurant_ID=restaurant_cuisines.Restaurant_ID
inner join ratings
on ratings.Restaurant_ID=restaurant_cuisines.Restaurant_ID
where ratings.Consumer_ID='U1001' and Cuisine='Mexican';

-- Consumer U1001 has rated Puesto De Tacos, which serves Mexican cuisine. 
-- This connects an individual customer's restaurant interaction with the cuisine served by that restaurant.


-- Find the Consumer_ID and Age of consumers who have rated restaurants located in 'San Luis Potosi'.
select distinct consumers.Consumer_ID,consumers.Age,restaurants.City
from consumers inner join ratings
on consumers.Consumer_ID = ratings.Consumer_ID
inner join restaurants
on restaurants.Restaurant_ID=ratings.Restaurant_ID
where restaurants.City='San Luis Potosi';

-- The analysis identifies a broad customer base interacting with restaurants in San Luis Potosi, with most consumers in the 
-- dataset being younger adults while some older consumers are also active. This can help restaurants in San Luis Potosi understand 
-- the age diversity of their customer base and plan customer segmentation accordingly.

-- which cuisines are offered by the largest number of restaurants
select cuisine,count(distinct restaurant_id) as Number_of_restaurants
from restaurant_cuisines
group by cuisine
order by Number_of_restaurants desc;

-- Bar cuisine has the widest restaurant availability, with 9 restaurants, while Mexican, Fast Food, Seafood, and Brewery each have 5. 
-- Several cuisines have limited availability, with only one restaurant offering American, Burgers, Family, or Italian cuisine. 
-- This helps identify which cuisines are widely represented and which have relatively limited restaurant presence in the dataset.

-- Distribution of restaurants by price
select price,count(*) as restaurants_count
from restaurants
group by price;

-- The restaurant portfolio is concentrated in the Medium price category, with 27 restaurants, followed by High with 20 and Low with 9. 
-- This indicates that medium-priced restaurants represent the largest segment of the restaurant market in the dataset.