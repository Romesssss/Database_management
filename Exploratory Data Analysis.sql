SELECT location, 
date, 
total_cases, 
new_cases, 
total_deaths, 
population

FROM data.coviddeath
ORDER by 1, 2;


SELECT location, 
      MAX(total_cases) AS total_cases, 
      MAX(total_deaths) AS total_deaths,
      ROUND((MAX(total_deaths)/NULLIF (MAX(total_cases), 0)) * 100, 2) AS DeathPercentage
FROM data.coviddeath
WHERE continent IS NOT NULL
GROUP by location;



SELECT location, 
    date, 
    total_cases, 
    population, (total_cases/population) * 100 AS PopulationInfectedPercentage
FROM data.coviddeath
ORDER by 1, 2;


SELECT location, 
      MAX(total_cases) AS HighestInfectionCount, 
      population, 
      max((total_cases/population)) * 100 AS PercentPopulationInfected
FROM data.coviddeath
WHERE continent IS NOT NULL
GROUP by location, population
ORDER by PercentPopulationInfected DESC;


SELECT continent, 
      MAX(total_deaths) as TotalDeathCount
FROM data.coviddeath
WHERE continent IS NOT NULL
GROUP by continent
ORDER by TotalDeathCount desc;



SELECT location, 
      MAX(hosp_patients) AS HospitalizedPatients, 
      MAX(icu_patients) AS ICUPatients,  
      MAX(total_cases) AS TotalCases
FROM data.coviddeath
WHERE hosp_patients IS NOT NULL AND icu_patients IS NOT NULL
GROUP by location;


SELECT location, 
      MIN(date) AS date_reached_100k
FROM data.coviddeath
WHERE total_cases >= 100000 AND continent IS NOT NULL
GROUP by location
ORDER by date_reached_100k ASC;



SELECT date, 
    SUM(new_cases) AS total_cases, 
    SUM(new_deaths) AS total_deaths, 
    (SUM(new_deaths)/SUM(new_cases))* 100 AS DeathPercentage
FROM data.coviddeath
WHERE continent IS NOT NULL
GROUP by date
Order by 1, 2;

--CTE 

WITH PopvsVac
AS 
(
  SELECT dea.continent,
      dea.location,
      dea.date,
      dea.population,
      vac.new_vaccinations,
      SUM(vac.new_vaccinations) OVER(PARTITION by dea.location ORDER by dea.location, dea.date) AS RollingPeopleVaccinated
FROM data.coviddeath AS dea
JOIN data.covidvaccine AS vac
ON dea.location = vac.location
AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
)
SELECT *, (RollingPeopleVaccinated/population)* 100
 FROM PopvsVac;

--view

CREATE VIEW data.PercentPopulationVaccinated AS 
WITH PopvsVac AS
(
SELECT dea.continent,
      dea.location,
      dea.date,
      dea.population,
      vac.new_vaccinations,
      SUM(vac.new_vaccinations) OVER(PARTITION by dea.location ORDER by dea.location, dea.date) AS RollingPeopleVaccinated
FROM data.coviddeath AS dea
JOIN data.covidvaccine AS vac
ON dea.location = vac.location
AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
)

SELECT continent,
    location,
    date,
    population,
    new_vaccinations,
    RollingPeopleVaccinated,
    (RollingPeopleVaccinated/population) * 100 AS PercentVaccinated
FROM PopvsVac;
