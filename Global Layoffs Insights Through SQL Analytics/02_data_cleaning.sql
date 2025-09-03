select * from layoffs;

# creating a duplicate of the table
create table layoffs_staging(
	select * 
    from layoffs
);

select * from layoffs_staging;

# adding row identifier
alter table layoffs_staging add column id INT AUTO_INCREMENT PRIMARY KEY;

# /////////////////////////////////////////////////////////

# 1. Standardize the data
select distinct company
from layoffs_staging;

select company 
from layoffs_staging
where company like " %" or company like "% ";

update layoffs_staging
set company = trim(company)
where company like " %" or company like "% ";

select distinct country
from layoffs_staging
;

select distinct location
from layoffs_staging
where country = "india"
;

select *
from layoffs_staging
where location = "SF Bay Area" and country = "india"
;

update layoffs_staging
set country = 'United States'
where id = 137 or id = 232;

select distinct location
from layoffs_staging
where country = "United States"
;

select *
from layoffs_staging
where location like "%york%";

update layoffs_staging
set location = 'New York City'
where id = 2979;

select distinct industry
from layoffs_staging
;

select distinct stage
from layoffs_staging
;

describe layoffs_staging;

# changing date type from text to data
select date, str_to_date(`date`, "%m/%d/%Y")
from layoffs_staging;

create temporary table backup_table(
	select * from layoffs_staging
);

update layoffs_staging
set `date` = str_to_date(`date`, "%m/%d/%Y");

alter table layoffs_staging modify column `date` date;

# changing total_laid_off type from text to int
UPDATE layoffs_staging
SET total_laid_off = NULL
WHERE total_laid_off = '';

alter table layoffs_staging modify column total_laid_off int;

# changing funds_raised type from text to decimal
ALTER TABLE layoffs_staging RENAME COLUMN funds_raised TO funds_raised_million;

update layoffs_staging
set funds_raised_million = null
where funds_raised_million = "";

update layoffs_staging
set funds_raised_million = substring(funds_raised_million,2)
where funds_raised_million is not null;

alter table layoffs_staging modify column funds_raised_million decimal;

# changing percentage laid off type from text to decimal
update layoffs_staging
set percentage_laid_off = null
where percentage_laid_off = "";

update layoffs_staging
set funds_raised_million = substring(percentage_laid_off,1, locate('%', percentage_laid_off)-1)
where funds_raised_million is not null;

alter table layoffs_staging modify column percentage_laid_off decimal;

# /////////////////////////////////////////////////////////
#2. Checking and Removing duplicates

select distinct * from layoffs_staging;

# checking duplicate rows
with distinct_rows as(
	select distinct * 
    from layoffs
)
select count(layoffs.company) as total_rows,
	((select count(distinct_rows.company) from distinct_rows)) as total_distincy_rows
from layoffs; -- no duplicate rows

# checking possible duplicates
select company, location, industry, date, count(id)
from layoffs_staging
group by company, location, industry, date
having count(id) > 1;

select * from layoffs_staging
WHERE company IN ('Terminus','StockX','Sendy','Rapid',
    'Oda','Nomad Health','IronNet','Cazoo','Cart.com','Bybit',
    'Bustle Digital Group','Beyond Meat','Anodot'
);

delete from layoffs_staging
where id in (840, 2656, 3160, 2249, 3272, 2542, 2545, 3026,3035, 5155,3524);


# /////////////////////////////////////////////////////////
# 3. Handling nulls and blanks

select *
from layoffs_staging
where location = "" or location is null;

update layoffs_staging
set location = "San Francisco"
where id = 998;
;

update layoffs_staging
set industry = "Other"
where industry = "" or location is null;\ 

update layoffs_staging
set stage = "Unknown"
where stage = "" or stage is null; 

select * from layoffs_staging
where country='';

update layoffs_staging
set country = 'Germany'
where id = 1126;

update layoffs_staging
set country = 'Canada'
where id = 1343;

select count(*)
from layoffs_staging 
where total_laid_off is null and percentage_laid_off = "";

# we can see 677 rows both have no data in total_laid_off and percentage_laid_off. So, this data is not usefull for any kind of analysis we want to do.
delete from layoffs_staging 
where total_laid_off is null and percentage_laid_off = "";


# /////////////////////////////////////////////////////////
# 4. remove unwanted columns
select * from layoffs_staging;

alter table layoffs_staging drop column date_added;

alter table layoffs_staging drop column source;

alter table layoffs_staging drop column id;

# /////////////////////////////////////////////////////////
# 5. Final data validation
select * from layoffs_staging;

describe layoffs_staging;

#checking total remaining nulls in each columns
select sum(case when company is null or company='' then 1 else 0 end) as null_companies,
  sum(case when country is null or country='' then 1 else 0 end) as null_countries,
  sum(case when location is null or location='' then 1 else 0 end) as null_locations,
  sum(case when industry is null or industry='' then 1 else 0 end) as null_industries,
  sum(case when stage is null or stage='' then 1 else 0 end) as null_stages,
  sum(case when total_laid_off is null then 1 else 0 end) as null_laid_off,
  sum(case when percentage_laid_off is null or percentage_laid_off='' then 1 else 0 end) as null_percentage_laid_off,
  sum(case when funds_raised_million is null then 1 else 0 end) as null_funds
from layoffs_staging;

# companies before and after data cleaning
select 
  (select count(distinct company) from layoffs) as layoffs,
  (select count(distinct company) from layoffs_staging) as layoffs_staging;