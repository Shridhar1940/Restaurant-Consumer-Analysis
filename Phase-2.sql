-- Find all details of consumers who prefer 'American' cuisine AND have a 'Medium' budget
select *
from consumers inner join consumer_preferences
on consumers.Consumer_ID=consumer_preferences.Consumer_ID
where consumer_preferences.Preferred_Cuisine='American' and consumers.Budget='Medium';

-- American cuisine preference within this dataset is represented by a small group of medium-budget student consumers. 
-- This indicates a potentially relevant customer segment for restaurants offering American cuisine, particularly when 
-- analyzing student-oriented pricing and offerings.

-- Find the Consumer_ID and Occupation of consumers whose preferred cuisine is 'Mexican' and who have given an 
-- Overall_Rating of 0 to at least one restaurant (any restaurant).
select distinct consumers.consumer_id,consumers.occupation
from consumers inner join consumer_preferences
on consumers.consumer_id=consumer_preferences.consumer_id
inner join ratings
on consumer_preferences.consumer_id=ratings.consumer_id
where consumer_preferences.preferred_cuisine='Mexican' and ratings.Overall_rating=0;

-- The analysis identifies Mexican-cuisine-preferring consumers who have expressed dissatisfaction with at least one 
-- restaurant through an Overall Rating of 0. The segment is predominantly made up of students, indicating that student 
-- customers form a significant portion of this dissatisfied Mexican-cuisine preference group.

-- Using a CTE, identify students who have a 'Low' budget. Then, for each of these students, list their top 3 most preferred 
-- cuisines based on the order they appear in the Consumer_Preferences table (assuming no explicit preference order, 
-- use Consumer_ID, Preferred_Cuisine to define order for ROW_NUMBER).
with preferred_cuisines as (
select consumers.consumer_id,consumers.budget,consumer_preferences.Preferred_Cuisine,
row_number() over(partition by consumer_preferences.consumer_id 
order by consumer_preferences.consumer_id,consumer_preferences.Preferred_Cuisine) as Preference_order
from consumers join consumer_preferences
on consumers.Consumer_ID=consumer_preferences.Consumer_ID
where consumers.Budget='Low' and consumers.Occupation='Student'
)
select preferred_cuisines.consumer_id,preferred_cuisines.Preferred_cuisine,preferred_cuisines.preference_order
from preferred_cuisines
where preferred_cuisines.preference_order<=3;

-- Low-budget student consumers show a strong presence of Mexican cuisine among their recorded preferences, 
-- while some students have multiple cuisine preferences. This suggests that Mexican cuisine may be an important 
-- preference to consider when analyzing offerings for budget-conscious student customers.



/*Find consumers (Consumer_ID, Age, Occupation) who have rated at least one restaurant 
but have NOT rated any restaurant that serves 'Italian' cuisine.*/
select distinct(consumers.Consumer_ID),consumers.Age,consumers.Occupation
from consumers 
where exists (select 1 from ratings where consumers.consumer_id=ratings.consumer_id)
and not exists (
select 1 from restaurant_cuisines inner join ratings
on restaurant_cuisines.restaurant_id=ratings.restaurant_id 
where consumers.consumer_id=ratings.consumer_id 
and restaurant_cuisines.cuisine='Italian');

-- The analysis identifies active consumers who have not yet interacted with Italian-cuisine restaurants. 
-- This group represents a potential audience for further analysis of Italian restaurant exposure and customer preferences.
-- Restaurant businesses could investigate whether these customers avoid Italian cuisine because of preference, availability, 
-- location, or other factors.


-- which cusines are preferred by the largest number of consumers
select preferred_cuisine,count(distinct consumer_id) as consumer_count
from consumer_preferences
group by Preferred_Cuisine
order by consumer_count desc;

-- Mexican cuisine is by far the most preferred cuisine in the dataset, with 97 unique consumers selecting it. 
-- American cuisine follows with only 11 consumers, while Cafeteria and Pizzeria each have 9.

-- which cuisnes receive the highest number of ratings from consumers
select preferred_cuisine,count(*) as Number_of_ratings 
from consumer_preferences join ratings
on consumer_preferences.Consumer_ID=ratings.consumer_id
group by preferred_cuisine
order by number_of_ratings desc;

-- Consumers who prefer Mexican cuisine generate the highest volume of restaurant ratings, with 459 ratings. 
-- This is consistent with the earlier analysis where Mexican cuisine was also the most commonly stated preference, 
-- with 97 unique consumers.

