# setting a session bases variable to total number of rows
SELECT COUNT(*) INTO @total_records
FROM layoffs_staging;

SELECT @total_records AS total_records;

# count of distinct companies
SELECT COUNT(DISTINCT company) AS number_of_companies
FROM layoffs_staging;

# count of countries
select count(distinct country) as number_of_countries
from layoffs_staging;

# overall time range covered in the dataset
select 
    min(`date`) AS start_date,
    max(`date`) AS end_date
from layoffs_staging; # march-2020 to oct-2023


# year wise distribution of layoffs records
select 
  year(`date`) as year,
  count(*) as records
from layoffs_staging
group by year
order by year;

# industry wise records
select 
  industry,
  count(*) as records
from layoffs_staging
group by industry
order by records desc; 


# % records where total_laid_off field is null
select 100.0*count(*)/@total_records
from layoffs_staging 
where total_laid_off is null; # 22%

# % records where percentage_laid_off is null
select 100.0*count(*)/@total_records
from layoffs_staging 
where percentage_laid_off is null; # 24%

select sum(total_laid_off) as total_laid_off,
    max(total_laid_off) as max_laid_off_at_a_time,
    avg(total_laid_off) as avg_laid_off_at_a_time
from layoffs_staging;

# laid off times by a company
select company,
	count(*) as times_laid_off
from layoffs_staging
group by company
order by times_laid_off desc
;
