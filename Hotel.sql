---- Exploring Data

---2018 data
SELECT *
FROM [HotelProject].[dbo].['2018$']

--- 2019 data
SELECT *
FROM [HotelProject].[dbo].['2019$']

--- 2020 data
SELECT *
FROM [HotelProject].[dbo].['2020$'];


--- joining all the tables together for easy cleaning and analysis

SELECT *
FROM [HotelProject].[dbo].['2018$']
UNION ALL
SELECT *
FROM [HotelProject].[dbo].['2019$']
UNION ALL
SELECT *
FROM [HotelProject].[dbo].['2020$'];

--- creating a special table for the joined tables

DROP TABLE if exists hotels
CREATE TABLE hotels (
hotel varchar(50),
is_canceled	numeric,
lead_time numeric,
arrival_date_year	numeric,
arrival_date_month	varchar(50),
arrival_date_week_number numeric,
arrival_date_day_of_month numeric,
stays_in_weekend_nights numeric	,
stays_in_week_nights numeric,
adults numeric,
children numeric,
babies	numeric,
meal varchar(50),
country	varchar(50),
market_segment varchar(50)	,
distribution_channel varchar(50),
is_repeated_guest numeric,
previous_cancellations	numeric,
previous_bookings_not_canceled	numeric,
reserved_room_type	varchar(1),
assigned_room_type	varchar(1),
booking_changes	numeric,
deposit_type varchar(50),
agent numeric,
company	varchar(50),
days_in_waiting_list numeric,
customer_type varchar(50),
adr	numeric,
required_car_parking_spaces	numeric,
total_of_special_requests	numeric,
reservation_status	varchar(50),
reservation_status_date datetime)


INSERT INTO hotels  
SELECT *
FROM [HotelProject].[dbo].['2018$']
UNION ALL
SELECT *
FROM [HotelProject].[dbo].['2019$']
UNION ALL
SELECT *
FROM [HotelProject].[dbo].['2020$'];

--- checking newly created table

SELECT *
FROM hotels;


--- joining market segment and meal table to hotel table to get discount and cost

WITH fullhotel AS (
SELECT hotel,	
is_canceled	lead_time,	
arrival_date_year,	
arrival_date_month,
arrival_date_week_number,
arrival_date_day_of_month,
stays_in_weekend_nights,
stays_in_week_nights,
adults,
children,
babies,
h.meal,
country,
h.market_segment,
distribution_channel,
is_repeated_guest,
previous_cancellations,
previous_bookings_not_canceled,
reserved_room_type,
assigned_room_type,
booking_changes,
deposit_type,
agent,
company	days_in_waiting_list,
customer_type,
adr,
required_car_parking_spaces,
total_of_special_requests,
reservation_status,
reservation_status_date,
Discount,
Cost
FROM hotels h
LEFT JOIN [HotelProject].[dbo].[market_segment$] ms
ON h.market_segment = ms.market_segment

LEFT JOIN [HotelProject].[dbo].[meal_cost$] mc
on h.meal = mc.meal)

--- creating revenue column

SELECT *, ((stays_in_week_nights + stays_in_weekend_nights)*adr)*Discount AS revenue
from fullhotel;

--- checking the revenue for each hotels each year

SELECT hotel, arrival_date_year ,SUM(((stays_in_week_nights + stays_in_weekend_nights)*adr)-discount) AS revenue
FROM hotels h
LEFT JOIN [HotelProject].[dbo].[market_segment$] ms
ON h.market_segment = ms.market_segment

LEFT JOIN [HotelProject].[dbo].[meal_cost$] mc
on h.meal = mc.meal
GROUP BY hotel, arrival_date_year
ORDER BY arrival_date_year, hotel;  -- (2020 data is not complete, it stops at august)