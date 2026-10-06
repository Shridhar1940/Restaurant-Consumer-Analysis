-- Distribution of consumers across city
select city,count(*) as consumer_count
from consumers
where city<>''
group by city;

-- San Luis Potosi has the largest consumer base, with 86 consumers, while Jiutepec has the smallest with 5 consumers. 
-- This indicates that consumer activity in the dataset is concentrated mainly in San Luis Potosi. Restaurant businesses can 
-- use this geographic distribution to understand where their major customer base is located and focus location-specific marketing 
-- or service strategies accordingly.

-- List all details of consumers who live in the city of 'Cuernavaca'.
select * 
from consumers
where city='Cuernavaca';

-- Cuernavaca has a diverse consumer base, including students and employed customers with different spending levels and 
-- lifestyle characteristics. Restaurant businesses in Cuernavaca can use this information to understand their local customer 
-- segments and potentially tailor their offerings, pricing, and marketing strategies to different customer groups.

-- Find the Consumer_ID, Age, and Occupation of all consumers who are 'Students' AND are 'Smokers'.
select Consumer_ID,Age,Occupation 
from consumers 
where Occupation='Student' and Smoker='Yes';

-- The analysis identifies a specific customer segment of student smokers. Restaurant businesses can use this segment to 
-- understand the characteristics of customers with similar lifestyle attributes and analyze whether this group has 
-- particular restaurant, cuisine, or service preferences.

-- List restaurants (Name) that have received ratings from consumers older than 30.
select distinct (restaurants.Name) , consumers.age
from restaurants inner join ratings
on restaurants.restaurant_id=ratings.restaurant_id
inner join consumers
on ratings.consumer_id=consumers.consumer_id
where consumers.age>30;

-- The analysis identifies restaurants that attract or serve customers above the age of 30. Restaurant owners can use this 
-- information to understand which restaurants have engagement from older customer segments and potentially study their menu, 
-- pricing, service, or location characteristics.


-- Find consumers (Consumer_ID, Age) who are 'Married' and whose Food_Rating for any restaurant is equal to their Service_Rating 
-- for that same restaurant, but only consider ratings where the Overall_Rating was 2.
select consumers.Consumer_ID,consumers.age
from consumers join ratings
on consumers.Consumer_ID=ratings.consumer_id
where consumers.Marital_Status='Married' 
and ratings.Food_Rating=ratings.Service_Rating
and overall_rating=2;

-- The analysis identifies married customers who gave highly satisfactory overall ratings while rating food and service equally. 
-- This can help restaurant managers understand customers who perceive the food and service experience similarly and positively.


-- Find consumers (Consumer_ID, Age) who are 'Social Drinkers' and have rated a restaurant that has 'No' parking.
select distinct c.consumer_id,c.age
from consumers c join ratings r
on c.consumer_id=r.consumer_id
join restaurants rt
on rt.restaurant_id=r.restaurant_id
where c.Drink_level='Social Drinker' and rt.parking='None';

-- The analysis identifies a small group of social-drinking customers who have interacted with restaurants without parking facilities. 
-- This can help restaurant managers understand customer segments that are willing to visit restaurants without parking and evaluate 
-- whether parking availability affects customer behavior.

-- List Consumer_IDs and the count of restaurants they've rated, but only for consumers who are 'Students'. 
-- Show only students who have rated more than 2 restaurants.
select consumers.consumer_id,count(ratings.consumer_id) as Restaurant_rated
from consumers inner join ratings
on consumers.consumer_id=ratings.consumer_id
where consumers.occupation='Student'
group by ratings.Consumer_ID
having count(ratings.consumer_id)>2;

-- The analysis identifies highly active student customers based on their restaurant-rating activity. 
-- These customers may represent an engaged student segment that interacts with multiple restaurants and can be useful 
-- for analyzing student preferences and restaurant behavior.

-- For each Occupation, find the average age of consumers. Only consider consumers who have made at least one rating. 
-- (Use a derived table to get consumers who have rated).
select consumers.occupation,avg(consumers.age) as Avg_age
from consumers
join (
select distinct Consumer_ID from ratings
) as rated_consumer
on consumers.Consumer_ID=rated_consumer.consumer_id
where occupation<>''
group by consumers.Occupation;

-- The analysis shows that the Employed consumer group has the highest average age at 37.56 years, while Students have an 
-- average age of about 25 years and Unemployed consumers about 23 years.

-- This helps restaurant businesses understand the age profile of their active customers across different occupation groups, 
-- which can support customer segmentation and targeted marketing or offerings.

-- What is the Distribution of consumers by budget level
select budget,count(*) as consumer_count
from consumers
where budget<>''
group by budget;

-- Helps restaurants understand whether their customer base is primarily budget-conscious, moderate-spending, or high-budget.

-- what is the Distribution of consumers by age group
select 
case 
when age<20 then 'Under 20'
when age between 20 and 29 then '20-29'
when age between 30 and 39 then '30-39'
when age between 40 and 49 then '40-49'
when age between 50 and 59 then '50-59'
else '60+'
end as Age_group,
count(*) as consumer_count
from consumers
group by Age_group
order by Age_group;

-- Helps identify the dominant age segment and understand the demographic profile of customers.

-- which occupations have the highest number of consumers
select occupation,count(*) as consumer_count
from consumers
where occupation<>''
group by occupation;

-- Helps identify the largest occupational customer segments, which can be useful for customer profiling and targeted marketing.

-- Distribution of Transportation by consumers
select transportation_method , count(*) as consumer_count
from consumers
where Transportation_Method<>''
group by transportation_method;

-- Helps restaurants understand how customers typically travel and can provide context for decisions involving parking, 
-- accessibility, and location.