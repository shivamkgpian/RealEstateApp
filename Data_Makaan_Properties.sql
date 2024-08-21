--Data Analysis using SQL of Makaan Real Estate Properties.

--Checking the database

select *
FROM  [Portfolio Project].dbo.Makaan_Properties


-- Different cities in the dataset

select DISTINCT City_name
FROM  [Portfolio Project].dbo.Makaan_Properties-- There are a total of 8 different cities and most of the metro cities are covered.

--Different types of property in each city.

select DISTINCT Property_type
FROM  [Portfolio Project].dbo.Makaan_Properties -- There are 5 different types of property in total.

--Different property status in each city.

select DISTINCT Property_status
FROM  [Portfolio Project].dbo.Makaan_Properties --There are some properties under construction and there are ready to move properties.

--Number of builders across these 8 cities.
select DISTINCT Builder_name
FROM  [Portfolio Project].dbo.Makaan_Properties -- There are almost 8900+ builders across 8 different cities averaging 1000+ builders in each city.

--Different type of BHK available in these 8 cities.

select DISTINCT No_of_BHK
FROM  [Portfolio Project].dbo.Makaan_Properties -- There are around 17 types of houses ranging from studios with 1RK to 14BHK and 0 BHK are all residential plots.

--Total number of properties for sale in each city including properties under construction.

select City_name, 
       COUNT(Property_Name) as No_of_properties_for_sale
FROM  [Portfolio Project].dbo.Makaan_Properties
GROUP BY City_name
ORDER BY City_name -- Mumbai seems to have the highest number of properties for sale followed by Bangalore and then Chennai.

--Total number of apartments for sale in each city.

select City_name, 
       COUNT(Property_Name) as No_of_Apartments_for_sale
FROM  [Portfolio Project].dbo.Makaan_Properties
WHERE Property_type= 'Apartment'
GROUP BY City_name
ORDER BY City_name-- Mumbai seems to have the highest number of apartments for sale followed by Bangalore and then Kolkata.

--Total number of Independent house for sale in each city.

select City_name, 
       COUNT(Property_Name) as No_of_Indenpendent_houses_for_sale
FROM  [Portfolio Project].dbo.Makaan_Properties
WHERE Property_type= 'Independent House'
GROUP BY City_name
ORDER BY City_name -- Chennai has more independent houses for sale followed by Hyderabad and then Kolkata.

--Total number of Residential plots for sale in each city.

select City_name, 
       COUNT(Property_Name) as No_of_Residential_Plots_for_sale
FROM  [Portfolio Project].dbo.Makaan_Properties
WHERE Property_type= 'Residential Plot'
GROUP BY City_name
ORDER BY City_name -- Hyderabad has more Residential plots for sale followed by Chennai and then Bangalore.

--Total number of Villas for sale in each city.

select City_name, 
       COUNT(Property_Name) as No_of_Villas_for_sale
FROM  [Portfolio Project].dbo.Makaan_Properties
WHERE Property_type= 'Villa'
GROUP BY City_name
ORDER BY City_name

-- Total number of Independent Floor for sale in each city.

select City_name, 
       COUNT(Property_Name) as No_of_Independent_Floor_for_sale
FROM  [Portfolio Project].dbo.Makaan_Properties
WHERE Property_type= 'Independent Floor'
GROUP BY City_name
ORDER BY City_name -- Delhi has more Independent floor for sale followed by Mumbai and then Kolkata.

--Finding the average price of property in each locality of the city.

--Ahmedabad

select DISTINCT (Locality_Name),
       AVG(Price) as Average_Price_1BHK
FROM  [Portfolio Project].dbo.Makaan_Properties
WHERE City_name= 'Ahmedabad' AND No_of_BHK= '1 BHK'
GROUP BY Locality_Name
ORDER BY Locality_Name-- We can see the average pricing of 1BHK property in 46 different localities of Ahmedabad.


select DISTINCT (Locality_Name),
       AVG(Price) as Average_Price_2BHK
FROM  [Portfolio Project].dbo.Makaan_Properties
WHERE City_name= 'Ahmedabad' AND No_of_BHK= '2 BHK'
GROUP BY Locality_Name
ORDER BY Locality_Name -- We can see the average pricing of 2BHK property in 79 different localities of Ahmedabad.


select DISTINCT (Locality_Name),
       AVG(Price) as Average_Price_3BHK
FROM  [Portfolio Project].dbo.Makaan_Properties
WHERE City_name= 'Ahmedabad' AND No_of_BHK= '3 BHK'
GROUP BY Locality_Name
ORDER BY Locality_Name-- We can see the average pricing of 3BHK property in 76 different localities of Ahmedabad.


select DISTINCT (Locality_Name),
       AVG(Price) as Average_Price_4BHK
FROM  [Portfolio Project].dbo.Makaan_Properties
WHERE City_name= 'Ahmedabad' AND No_of_BHK= '4 BHK'
GROUP BY Locality_Name
ORDER BY Locality_Name-- We can see the average pricing of 4BHK property in 52 different localities of Ahmedabad.

--Similarly we can find the average pricing of other BHK types like 5 BHK etc.
--We can repeat the same process to find the average price of properties for other cities just by changing the city name and no. of BHK in the above query .

--Finding the average price per Sq.Ft of properties in each locality across the cities.

select DISTINCT (Locality_Name),
       AVG(Price_per_unit_area) as Average_Price_Per_Sq_Feet
FROM  [Portfolio Project].dbo.Makaan_Properties
WHERE City_name= 'Chennai' 
GROUP BY Locality_Name
ORDER BY Average_Price_Per_Sq_Feet DESC

select DISTINCT (Locality_Name),
       AVG(Price_per_unit_area) as Average_Price_Per_Sq_Feet
FROM  [Portfolio Project].dbo.Makaan_Properties
WHERE City_name= 'Bangalore'
GROUP BY Locality_Name
ORDER BY Average_Price_Per_Sq_Feet DESC

select DISTINCT (Locality_Name),
       AVG(Price_per_unit_area) as Average_Price_Per_Sq_Feet
FROM  [Portfolio Project].dbo.Makaan_Properties
WHERE City_name= 'Mumbai'
GROUP BY Locality_Name
ORDER BY Average_Price_Per_Sq_Feet DESC

-- Similarly , we can find the price per square feet of properties from other cities as well by changing the city name in the above query.












