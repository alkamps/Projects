Select *
From Portfolio..[Covid Deaths]
Where continent is not null
order by 3,4


--Select *
--From Portfolio..[Covid Vax]
--order by 3,4


Select location, date, total_cases, new_cases, total_deaths, population
From Portfolio..[Covid Deaths]
Where continent is not null
order by 1,2

-- Looking at Total Cases vs Total Deaths
-- Shows likelihood of ding if you contract COVID in our country

Select location, date, total_cases,total_deaths, (Total_deaths/total_cases)*100 as DeathPercentage 
From Portfolio..[Covid Deaths]
Where location like '%states%'
and continent is not null
order by 1,2

-- Looking at Total Cases vs Population
-- Shows what percentage of populaiton has contracted COVID

Select location, date, population, total_cases, (total_cases/population)*100 as ContractionPercentageOfPopulation 
From Portfolio..[Covid Deaths]
Where location like '%states%'
order by 1,2

-- Looking at Countries with Highest Infection Rate compared to Population

Select location, population, MAX(total_cases) as HighestContractionCount, Max((total_cases/population))*100 as ContractionPercentageOfPopulation 
From Portfolio..[Covid Deaths]
--Where location like '%states%'
Where continent is not null
Group by Location, Population
order by ContractionPercentageOfPopulation desc

-- Showing Countries with Highest Death Count per Population


Select location, MAX(cast(Total_deaths as int)) as TotalDeathCount
From Portfolio..[Covid Deaths]
--Where location like '%states%'
Where continent is not null
Group by Location
order by TotalDeathCount desc

-- BREAK DOWN BY CONTINENT

-- showing continents with the highest death count per population

Select location, MAX(cast(Total_deaths as int)) as TotalDeathCount
From Portfolio..[Covid Deaths]
--Where location like '%states%'
Where continent is not null
Group by location
order by TotalDeathCount desc

-- GLOBAL NUMBERS

Select date, SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage 
From Portfolio..[Covid Deaths]
Where continent is not null
Group By date
order by 1,2

-- Looking at Total Population vs Vaccination

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.date)
as RollingVaxCounter
From Portfolio..[Covid Deaths]dea
Join Portfolio..[Covid Vax]vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
order by 2,3

-- USE CTE

With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingVaxCounter)
as 
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, 
dea.date) as RollingVaxCounter
From Portfolio..[Covid Deaths] dea
Join Portfolio..[Covid Vax] vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
)
Select *, (RollingVaxCounter/Population)*100
From PopvsVac


--Tablue

--1

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From Portfolio..[Covid Deaths]
--Where location like '%states%'
where continent is not null 
--Group By date
order by 1,2

--2 

Select location, SUM(cast(new_deaths as int)) as TotalDeathCount
From Portfolio..[Covid Deaths]
--Where location like '%states%'
Where continent is null 
and location not in ('World', 'European Union', 'International', 'Upper middle income', 'High income', 'Lower middle income')
Group by location
order by TotalDeathCount desc

-- 3.

Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From Portfolio..[Covid Deaths]
--Where location like '%states%'
Group by Location, Population
order by PercentPopulationInfected desc

-- 4.


Select Location, Population,date, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From Portfolio..[Covid Deaths]
--Where location like '%states%'
Group by Location, Population, date
order by PercentPopulationInfected desc


