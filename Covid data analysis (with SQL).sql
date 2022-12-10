        -- EXPLORING DATA
SELECT 
  * 
FROM 
  [CovidProject].[dbo].['owid-covid-data$'] 
ORDER BY 
  location, 
  date;

        --- displaying data that we will be using
SELECT 
  location, 
  date, 
  total_cases, 
  new_cases, 
  total_deaths, 
  population, 
  people_vaccinated, 
  total_boosters, 
  people_fully_vaccinated 
FROM 
  [CovidProject].[dbo].['owid-covid-data$'] 
ORDER BY 
  location, 
  date;
 
        -- CLEANING DATA
        --- changing some columns data type
ALTER TABLE[CovidProject].[dbo].['owid-covid-data$'] ALTER COLUMN total_deaths BIGINT;
ALTER TABLE[CovidProject].[dbo].['owid-covid-data$'] ALTER COLUMN total_cases FLOAT;
ALTER TABLE[CovidProject].[dbo].['owid-covid-data$'] ALTER COLUMN [new_deaths] INT;
ALTER TABLE[CovidProject].[dbo].['owid-covid-data$'] ALTER COLUMN population FLOAT;
ALTER TABLE[CovidProject].[dbo].['owid-covid-data$'] ALTER COLUMN reproduction_rate FLOAT;
ALTER TABLE[CovidProject].[dbo].['owid-covid-data$'] ALTER COLUMN new_cases INT;
ALTER TABLE[CovidProject].[dbo].['owid-covid-data$'] ALTER COLUMN [new_deaths] INT;
ALTER TABLE[CovidProject].[dbo].['owid-covid-data$'] ALTER COLUMN [total_deaths_per_million] FLOAT;
ALTER TABLE[CovidProject].[dbo].['owid-covid-data$'] ALTER COLUMN [total_deaths_per_million] FLOAT;
ALTER TABLE[CovidProject].[dbo].['owid-covid-data$'] ALTER COLUMN [icu_patients_per_million] FLOAT;
ALTER TABLE[CovidProject].[dbo].['owid-covid-data$'] ALTER COLUMN [hosp_patients_per_million] FLOAT;
ALTER TABLE[CovidProject].[dbo].['owid-covid-data$'] ALTER COLUMN [total_deaths_per_million] FLOAT;
ALTER TABLE[CovidProject].[dbo].['owid-covid-data$'] ALTER COLUMN [hosp_patients_per_million] FLOAT;
ALTER TABLE[CovidProject].[dbo].['owid-covid-data$'] ALTER COLUMN [new_deaths_smoothed] FLOAT;
ALTER TABLE[CovidProject].[dbo].['owid-covid-data$'] ALTER COLUMN [new_deaths_per_million] FLOAT;
ALTER TABLE[CovidProject].[dbo].['owid-covid-data$'] ALTER COLUMN [new_deaths_per_million] FLOAT;
ALTER TABLE[CovidProject].[dbo].['owid-covid-data$'] ALTER COLUMN [weekly_icu_admissions_per_million] FLOAT;
ALTER TABLE[CovidProject].[dbo].['owid-covid-data$'] ALTER COLUMN [weekly_hosp_admissions_per_million] FLOAT;
ALTER TABLE[CovidProject].[dbo].['owid-covid-data$'] ALTER COLUMN [people_vaccinated] FLOAT;
ALTER TABLE[CovidProject].[dbo].['owid-covid-data$'] ALTER COLUMN [total_deaths_per_million] FLOAT;
ALTER TABLE[CovidProject].[dbo].['owid-covid-data$'] ALTER COLUMN [people_fully_vaccinated] FLOAT;
ALTER TABLE[CovidProject].[dbo].['owid-covid-data$'] ALTER COLUMN [new_deaths_smoothed_per_million] FLOAT;
ALTER TABLE[CovidProject].[dbo].['owid-covid-data$'] ALTER COLUMN [icu_patients] INT;
ALTER TABLE[CovidProject].[dbo].['owid-covid-data$'] ALTER COLUMN [hosp_patients] INT;
ALTER TABLE[CovidProject].[dbo].['owid-covid-data$'] ALTER COLUMN [weekly_icu_admissions] INT;
ALTER TABLE[CovidProject].[dbo].['owid-covid-data$'] ALTER COLUMN [weekly_hosp_admissions] INT;
ALTER TABLE[CovidProject].[dbo].['owid-covid-data$'] ALTER COLUMN [new_vaccinations] BIGINT;
ALTER TABLE[CovidProject].[dbo].['owid-covid-data$'] ALTER COLUMN [total_vaccinations] BIGINT;
ALTER TABLE[CovidProject].[dbo].['owid-covid-data$'] ALTER COLUMN [total_tests] BIGINT;
ALTER TABLE[CovidProject].[dbo].['owid-covid-data$'] ALTER COLUMN [new_tests] BIGINT;
ALTER TABLE[CovidProject].[dbo].['owid-covid-data$'] ALTER COLUMN [total_boosters] BIGINT;

        --- deleting incorrect data
SELECT 
  location, 
  continent, 
  total_cases, 
  total_deaths 
FROM 
  [CovidProject].[dbo].['owid-covid-data$'] 
WHERE 
  location = 'north korea';--(North korea data is invalid)
  
        --- deleting north korea data
DELETE FROM 
  [CovidProject].[dbo].['owid-covid-data$'] 
WHERE 
  location = 'north korea'; ---- (deleted North Korea data because it was not accurate at all)
 
        --- removing null values from continent column
DELETE FROM 
  [CovidProject].[dbo].['owid-covid-data$'] 
WHERE 
  continent IS NULL;

        -- ANALYZING DATA ABOUT DEATH
        --- shows the percentage of someone dying after contacting the virus
SELECT 
  location, 
  population, 
  date, 
  total_cases, 
  total_deaths, 
  (total_deaths / total_cases)* 100 AS fatality 
FROM 
  [CovidProject].[dbo].['owid-covid-data$'] 
WHERE 
  date = '2022-07-28 00:00:00.000' 
ORDER BY 
  fatality DESC;
  
        --- showing the percentage of the population that got covid
SELECT 
  location, 
  population, 
  date, 
  total_cases, 
  total_deaths, 
  (total_cases / population)* 100 AS case_fatality 
FROM 
  [CovidProject].[dbo].['owid-covid-data$'] 
WHERE 
  date = '2022-07-28 00:00:00.000' 
ORDER BY 
  case_fatality DESC;
  
        --- checking highest death vs population percentage
SELECT 
  location, 
  date, 
  total_cases, 
  population, 
  total_deaths, 
  (total_deaths / population)* 100 AS death_population 
FROM 
  [CovidProject].[dbo].['owid-covid-data$'] 
WHERE 
  date = '2022-07-28 00:00:00.000' 
ORDER BY 
  death_population DESC;
--- Checking country with the most death
SELECT 
  location, 
  date, 
  total_cases, 
  total_deaths 
FROM 
  [CovidProject].[dbo].['owid-covid-data$'] 
WHERE 
  date = '2022-07-28 00:00:00.000' 
ORDER BY 
  total_deaths DESC;
  
        --- breaking it down by continent
        ---- checking continent with the most death (continent)
SELECT 
  continent, 
  SUM(total_deaths) AS deaths 
FROM 
  [CovidProject].[dbo].['owid-covid-data$'] 
WHERE 
  date = '2022-07-28 00:00:00.000' 
GROUP BY 
  continent 
ORDER BY 
  deaths DESC;
  
        --- shows the percentage of someone dying after contacting the virus (contitnent)
SELECT 
  continent, 
  (SUM(total_deaths)/ SUM(total_cases))* 100 AS fatality 
FROM 
  [CovidProject].[dbo].['owid-covid-data$'] 
WHERE 
  date = '2022-07-28 00:00:00.000' 
GROUP BY 
  continent 
ORDER BY 
  fatality DESC;
  
        --- showing the percentage of the population that got covid (continent)
SELECT 
  continent, 
  (SUM(total_cases)/ SUM(population))* 100 AS fatality 
FROM 
  [CovidProject].[dbo].['owid-covid-data$'] 
WHERE 
  date = '2022-07-28 00:00:00.000' 
GROUP BY 
  continent 
ORDER BY 
  fatality DESC;
  
        --- checking highest death VS population (continent)
SELECT 
  continent, 
  (SUM(total_deaths)/ SUM(population))* 100 AS fatality 
FROM 
  [CovidProject].[dbo].['owid-covid-data$'] 
WHERE 
  date = '2022-07-28 00:00:00.000' 
GROUP BY 
  continent 
ORDER BY 
  fatality DESC;
  
        --- global fatality
SELECT 
  SUM(total_cases) AS total_case, 
  SUM(total_deaths) AS total_deaths, 
  (SUM(total_deaths)/ SUM(total_cases))* 100 AS fatality 
FROM 
  [CovidProject].[dbo].['owid-covid-data$'] 
WHERE 
  date = '2022-07-28 00:00:00.000';
  
        -- ANALYZING DATA ABOUT VACCINATION
    --- if i was to create my own total_vacination table
SELECT 
  continent, 
  location, 
  date, 
  population, 
  people_vaccinated, 
  total_boosters, 
  people_fully_vaccinated, 
  (people_vaccinated + total_boosters + people_fully_vaccinated) AS total_vacc 
FROM 
  [CovidProject].[dbo].['owid-covid-data$'] 
ORDER BY 
  location, 
  date;
        --- trying to use my newly created total_vacc to calulate percentage of people vaccinated
WITH popvac 
  (continent, location, date, population, 
  people_vaccinated, total_boosters, 
  people_fully_vaccinated, total_vacc) AS (
  SELECT 
    continent, 
    location, 
    date, 
    population, 
    people_vaccinated, 
    total_boosters, 
    people_fully_vaccinated, 
    (people_vaccinated + total_boosters + people_fully_vaccinated) AS total_vacc 
  FROM 
    [CovidProject].[dbo].['owid-covid-data$']) 
SELECT 
  *, 
  (total_vacc / population) * 100 AS percentage 
FROM 
  popvac 
ORDER BY 
  percentage DESC;
  
        --- confirming what I created
SELECT 
  continent, 
  location, 
  date, 
  population, 
  total_vaccinations, 
  total_cases, 
  total_deaths, 
  (total_vaccinations / population)* 100 AS percentage 
FROM 
  [CovidProject].[dbo].['owid-covid-data$'] 
ORDER BY 
  percentage DESC; ---(percentage of the population vaccinated is more than 100%, this could be due to multiple booster and vaccination taken per person)

        --- creating temp table
DROP 
  TABLE IF exists #PercentagePopulationVaccinated
  CREATE TABLE #PercentagePopulationVaccinated
  (location nvarchar(255), 
   continent nvarchar(255), 
   date datetime, 
   population numeric, 
   people_vaccinated numeric, 
   total_boosters numeric, 
   people_fully_vaccinated numeric, 
   total_vacc numeric) 
  INSERT INTO #PercentagePopulationVaccinated
SELECT 
  continent, 
  location, 
  date, 
  population, 
  people_vaccinated, 
  total_boosters, 
  people_fully_vaccinated, 
  (people_vaccinated + total_boosters + people_fully_vaccinated) AS total_vacc 
FROM 
  [CovidProject].[dbo].['owid-covid-data$'] 
SELECT 
  *, 
  (total_vacc / population) * 100 AS percentage 
FROM 
  #PercentagePopulationVaccinated;
  --- Confirming table
SELECT 
  *, 
  (total_vacc / population) * 100 AS percentage 
FROM 
  #PercentagePopulationVaccinated;
  
        --- Creating views to store data for later data visualization
  CREATE VIEW PercentagePopulationVaccinated AS 
SELECT 
  continent, 
  location, 
  date, 
  population, 
  people_vaccinated, 
  total_boosters, 
  people_fully_vaccinated, 
  (people_vaccinated + total_boosters + people_fully_vaccinated) AS total_vacc 
FROM 
  [CovidProject].[dbo].['owid-covid-data$'];
  
        
CREATE VIEW continental_DeathPerPopulation AS 
SELECT 
  continent, 
  (SUM(total_deaths)/ SUM(population))* 100 AS fatality 
FROM 
  [CovidProject].[dbo].['owid-covid-data$'] 
WHERE 
  date = '2022-07-28 00:00:00.000' 
GROUP BY 
  continent;
  
  
CREATE VIEW Continental_Case_Fatality AS 
SELECT 
  continent, 
  (SUM(total_cases)/ SUM(population))* 100 AS fatality 
FROM 
  [CovidProject].[dbo].['owid-covid-data$'] 
WHERE 
  date = '2022-07-28 00:00:00.000' 
GROUP BY 
  continent;
  
  
CREATE VIEW Continental_Death_Fatality AS 
SELECT 
  continent, 
  (SUM(total_deaths)/ SUM(total_cases))* 100 AS fatality 
FROM 
  [CovidProject].[dbo].['owid-covid-data$'] 
WHERE 
  date = '2022-07-28 00:00:00.000' 
GROUP BY 
  continent;


CREATE VIEW Fatality AS 
SELECT 
  location, 
  date, 
  total_cases, 
  total_deaths 
FROM 
  [CovidProject].[dbo].['owid-covid-data$'] 
WHERE 
  date = '2022-07-28 00:00:00.000';
  
  
CREATE VIEW Death_Per_Population AS 
SELECT 
  location, 
  date, 
  total_cases, 
  population, 
  total_deaths, 
  (total_deaths / population)* 100 AS death_population 
FROM 
  [CovidProject].[dbo].['owid-covid-data$'] 
WHERE 
  date = '2022-07-28 00:00:00.000';
  
  
CREATE VIEW Case_Fatality AS 
SELECT 
  location, 
  population, 
  date, 
  total_cases, 
  total_deaths, 
  (total_cases / population)* 100 AS case_fatality 
FROM 
  [CovidProject].[dbo].['owid-covid-data$'] 
WHERE 
  date = '2022-07-28 00:00:00.000';
  
  
CREATE VIEW Death_Fatality AS 
SELECT 
  location, 
  population, 
  date, 
  total_cases, 
  total_deaths, 
  (total_deaths / total_cases)* 100 AS fatality 
FROM 
  [CovidProject].[dbo].['owid-covid-data$'] 
WHERE 
  date = '2022-07-28 00:00:00.000';
