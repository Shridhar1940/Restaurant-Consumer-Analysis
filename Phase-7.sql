-- Create a stored procedure GetRestaurantRatingsAboveThreshold that accepts a
-- Restaurant_ID and a minimum Overall_Rating as input. It should return the Consumer_ID,
-- Overall_Rating, Food_Rating, and Service_Rating for that restaurant where the Overall_Rating
-- meets or exceeds the threshold.
--,out consumerid int,out overallrating int,out foodrating int,out servicerating int
delimiter //
create procedure GetRestaurantRatingsAboveThreshold(
in Restaurantid int,in overallrating int)
begin
select Consumer_id,overall_rating,food_rating,service_rating
from ratings
where restaurant_id=restaurantid and overall_rating>=overallrating;
end//
delimiter ;

select * from ratings;

call GetRestaurantRatingsAboveThreshold(132825,1);

-- The procedure allows restaurant managers to quickly retrieve customer ratings that meet a specified satisfaction threshold 
-- for any restaurant. By changing the Restaurant_ID and minimum rating, the same analysis can be reused without rewriting the SQL query.


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