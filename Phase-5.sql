-- For each rating, show the Consumer_ID, Restaurant_ID, Overall_Rating, and also display the average Overall_Rating 
-- given by that specific consumer across all their ratings.
select consumer_id,restaurant_id,overall_rating,avg(overall_rating) over(partition by consumer_id) as Avg_overall_rating
from ratings;

-- This analysis compares each individual restaurant rating with the customer's overall rating behavior.
-- It helps identify whether a particular rating is higher or lower than the customer's usual rating pattern, which can be 
-- useful for understanding customer satisfaction behavior and identifying consistently high- or low-rating customers.

-- First, create a VIEW named ConsumerAverageRatings that lists Consumer_ID and their
-- average Overall_Rating. Then, using this view and a CTE, find the top 5 consumers by their
-- average overall rating. For these top 5 consumers, list their Consumer_ID, their average
-- rating, and the number of 'Mexican' restaurants they have rated.
create view ConsumerAverageRatings as (
select consumer_id,avg(overall_rating) as Avg_overall_rating
from ratings 
group by consumer_id
);
with CTE_1 as (
select consumer_id,Avg_overall_rating
from ConsumerAverageRatings
order by Avg_overall_Rating desc
limit 5
)
select distinct CTE_1.consumer_id,CTE_1.Avg_overall_rating,count(ratings.restaurant_id) over(partition by ratings.consumer_id) as Restaurants_rated
from CTE_1
join ratings
on ratings.consumer_id=CTE_1.consumer_id
join restaurant_cuisines
on ratings.restaurant_id=restaurant_cuisines.restaurant_id
where restaurant_cuisines.cuisine='Mexican';

-- Based on the output you provided, U1087 has an average Overall Rating of 2.0000 and has rated 1 Mexican restaurant.
-- The analysis is designed to connect two customer behaviors:
-- Overall customer satisfaction level + interaction with Mexican restaurants.
-- This can help understand whether highly satisfied customers are also engaging with Mexican restaurants.


-- First, ensure the HighlyRatedMexicanRestaurants view from Q7 exists. Then, using a CTE to
-- find consumers who prefer 'Mexican' cuisine, list those consumers (Consumer_ID) who have
-- not rated any restaurant listed in the HighlyRatedMexicanRestaurants view.
with CTE as (
select consumers.consumer_id
from consumers join consumer_preferences
on consumers.consumer_id=consumer_preferences.consumer_id
where consumer_preferences.preferred_cuisine='Mexican'
)
select distinct CTE.consumer_id
from CTE 
where not exists
(
select 1 from ratings r
join HighlyRatedMexicanRestaurants HR
on r.restaurant_id=HR.restaurant_id
where CTE.consumer_id=r.consumer_id
);

-- A large group of consumers who prefer Mexican cuisine have not yet rated the highly rated Mexican restaurant 
-- identified in the analysis. This highlights a potential customer segment that has an expressed interest in Mexican 
-- cuisine but has not interacted with the highly rated Mexican restaurant.


-- Using a CTE to get all ratings for restaurants in 'Cuernavaca', rank these ratings within each restaurant based on 
-- Overall_Rating (highest first). Display Restaurant_ID, Consumer_ID, Overall_Rating, and the RatingRank.
with restaurant_ranking as (
select restaurants.restaurant_id,ratings.consumer_id,ratings.overall_rating, 
dense_rank() over(partition by ratings.restaurant_id order by ratings.Overall_rating desc) as RatingRank
from restaurants join ratings
on restaurants.restaurant_id=ratings.restaurant_id
where restaurants.city='Cuernavaca'
)
select * from restaurant_ranking;

-- This analysis ranks customer ratings within each Cuernavaca restaurant and shows how different customers evaluated the 
-- same restaurant. It helps identify the highest, middle, and lowest rating levels received by each restaurant while preserving ties.

-- Create a stored procedure named GetConsumerSegmentAndRestaurantPerformance that
-- accepts a Consumer_ID as input.
-- The procedure should:
-- 1. Determine the consumer's "Spending Segment" based on their Budget:
-- ○ 'Low' -> 'Budget Conscious'
-- ○ 'Medium' -> 'Moderate Spender'
-- ○ 'High' -> 'Premium Spender'
-- ○ NULL or other -> 'Unknown Budget'
-- 2. For all restaurants rated by this consumer:
-- ○ List the Restaurant_Name.
-- ○ The Overall_Rating given by this consumer.
-- ○ The average Overall_Rating this restaurant has received from all consumers
-- (not just the input consumer).
-- ○ A "Performance_Flag" indicating if the input consumer's rating for that
-- restaurant is 'Above Average', 'At Average', or 'Below Average' compared to
-- the restaurant's overall average rating.
-- ○ Rank these restaurants for the input consumer based on the Overall_Rating
-- they gave (highest rating = rank 1)
drop procedure GetConsumerSegmentAndRestaurantPerformance;
delimiter //
create procedure GetConsumerSegmentAndRestaurantPerformance (in consumerid varchar(10))
begin
with restaurantratings as (
select restaurant_id,overall_rating,avg(overall_rating) over(partition by restaurant_id) as Avg_overall_rating
from ratings
)
select distinct restaurants.Name,ratings.overall_rating,restaurantratings.Avg_overall_rating,
case 
when consumers.Budget='low' then 'Budget Conscious'
when consumers.Budget='Medium' then 'Moderate Spender'
when consumers.Budget='High' then 'Premium Spender'
else 'Unknown Budget'
end as Spending_Segment,
case 
when ratings.Overall_rating>restaurantratings.Avg_overall_rating then 'Above Average'
when ratings.overall_rating=restaurantratings.Avg_overall_rating then 'At Average'
when ratings.overall_rating<restaurantratings.Avg_overall_rating then 'Below Average'
end as Performance_Flag,
dense_rank() over(order by ratings.overall_rating desc) as Ranking
from consumers join ratings
on consumers.consumer_id=ratings.consumer_id
join restaurants
on ratings.restaurant_id=restaurants.restaurant_id
join restaurantratings
on ratings.restaurant_id=restaurantratings.restaurant_id
where ratings.consumer_id=consumerid;
end//
delimiter ;

call GetConsumerSegmentAndRestaurantPerformance('U1010');

-- This procedure provides a customer-specific view of restaurant performance by combining the consumer's 
-- spending segment, their individual ratings, the restaurant's overall average rating, and their relative 
-- performance against that average.