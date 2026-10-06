drop database Project;
create database Project; 
use Project;

show tables;

CREATE TABLE IF NOT EXISTS consumers (
    Consumer_ID VARCHAR(10) PRIMARY KEY,
    City VARCHAR(20),
    State VARCHAR(20),
    Country VARCHAR(30),
    Latitude FLOAT,
    Longitude FLOAT,
    Smoker VARCHAR(10),
    Drink_Level VARCHAR(20),
    Transportation_Method VARCHAR(20),
    Marital_Status VARCHAR(20),
    Children VARCHAR(20),
    Age INT,
    Occupation VARCHAR(20),
    Budget VARCHAR(10)
);

CREATE TABLE IF NOT EXISTS consumer_preferences (
    Consumer_ID VARCHAR(10),
    Preferred_Cuisine VARCHAR(30)
);

CREATE TABLE IF NOT EXISTS ratings (
    Consumer_ID VARCHAR(10),
    Restaurant_ID INT,
    Overall_Rating INT,
    Food_Rating INT,
    Service_Rating INT,
    PRIMARY KEY (Consumer_ID, Restaurant_ID)
);

CREATE TABLE IF NOT EXISTS restaurant_cuisines (
    Restaurant_ID INT,
    Cuisine VARCHAR(30),
    PRIMARY KEY (Restaurant_ID, Cuisine)
);

CREATE TABLE IF NOT EXISTS restaurants (
    Restaurant_ID INT PRIMARY KEY,
    Name VARCHAR(60),
    City VARCHAR(20),
    State VARCHAR(20),
    Country VARCHAR(20),
    Zip_Code INT,
    Latitude FLOAT,
    Longitude FLOAT,
    Alcohol_Service VARCHAR(20),
    Smoking_Allowed VARCHAR(20),
    Price VARCHAR(10),
    Franchise VARCHAR(10),
    Area VARCHAR(10),
    Parking VARCHAR(20)
);

ALTER TABLE consumer_preferences
ADD CONSTRAINT fk_consumer_preferences_consumer
FOREIGN KEY (Consumer_ID)
REFERENCES consumers(Consumer_ID);

ALTER TABLE ratings
ADD CONSTRAINT fk_ratings_consumer
FOREIGN KEY (Consumer_ID)
REFERENCES consumers(Consumer_ID);

ALTER TABLE ratings
ADD CONSTRAINT fk_ratings_restaurant
FOREIGN KEY (Restaurant_ID)
REFERENCES restaurants(Restaurant_ID);

ALTER TABLE restaurant_cuisines
ADD CONSTRAINT fk_restaurant_cuisines_restaurant
FOREIGN KEY (Restaurant_ID)
REFERENCES restaurants(Restaurant_ID);

select * from consumers limit 10;
select * from restaurants limit 10;
select * from restaurant_cuisines limit 10;
select * from ratings limit 10;
select * from consumer_preferences limit 10;