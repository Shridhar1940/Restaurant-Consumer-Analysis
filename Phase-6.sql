-- Consider all ratings made by 'Consumer_ID' = 'U1008'. For each rating, show the Restaurant_ID, Overall_Rating, and 
-- the Overall_Rating of the next restaurant they rated (if any), ordered by Restaurant_ID (as a proxy for time if rating time 
-- isn't available). Use a derived table to filter for the consumer's ratings first.
select restaurant_id,overall_rating,lead(overall_rating) over(order by restaurant_id) as next_rating
from (
select restaurant_id,overall_rating
from ratings 
where consumer_id='U1008'
) as consumer_ratings
order by restaurant_id;

-- This analysis examines the rating pattern of consumer U1008 across their rated restaurants. 
-- By comparing each rating with the next rating in Restaurant_ID order, it can identify changes or patterns in the customer's 
-- rating behavior.