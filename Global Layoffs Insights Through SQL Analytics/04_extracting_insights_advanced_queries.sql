select * from layoffs_staging;

# layoffs year-wise
select year(`date`),
	sum(total_laid_off) as `Total laid off`
from layoffs_staging
group by year(`date`)
order by year(`date`)
;
# huge number of peeple laid of in 2023(2,64,220 out of 7,60,030) and lowest number of layoffs was seen in 2021 (15,823)

select industry,
	sum(total_laid_off) as `Total laid off`
from layoffs_staging
group by industry
order by `Total laid off` desc
;
# maximum layoffs seen in hardware(86528) and AI, legal, product based industries showed lowest number of layoffs

# country-wise layoffs
select country,
	100.00*sum(total_laid_off)
		/(
				select sum(total_laid_off) 
				from layoffs_staging
		) as `Total laid off`
from layoffs_staging
group by country
order by `total laid off` desc
;
# almost 67% layoffs were in United States only and 8% in india due to 

# stage wise layoffs - year wise performance
select stage,
	sum(total_laid_off) as `Total laid off`
from layoffs_staging
group by stage
order by `Total laid off` desc
;

# tage-wise layoffs share over years 2020–2025
with stage_wise_layoffs as(
	select stage,
		sum(total_laid_off) as total_layoffs
	from layoffs_staging
	group by stage
), ranked_stage_wise_layoffs as(
	select layoffs_staging.stage,
		year(`date`) as `year`,
		100.00*sum(total_laid_off)/stage_wise_layoffs.total_layoffs as `Total laid off`,
		rank() over(partition by layoffs_staging.stage order by sum(total_laid_off) desc)  as ranking
	from layoffs_staging
	join stage_wise_layoffs
		on layoffs_staging.stage = stage_wise_layoffs.stage
	group by layoffs_staging.stage, year(`date`)
	order by `total laid off` desc
)
select stage, 
	`year`,
	`total laid off`
from ranked_stage_wise_layoffs
order by stage, `year`
;
#Layoffs peaked in different waves: late-stage startups were hit hardest in 2020, early/mid-stage firms in 2022, and mature/acquired/IPO companies in 2023.


# Distribution of Companies(unique) based on percentage laid off (maximum if same companies laid off more than once)
WITH max_company_layoffs AS (
    SELECT 
        company,
        MAX(percentage_laid_off) AS percentage_laid_off
    FROM layoffs_staging
    GROUP BY company
), distribution_table as (
    select 
        company,
        case
            WHEN percentage_laid_off IS NULL THEN 'Data not available'
            WHEN percentage_laid_off > 0  AND percentage_laid_off <= 10 THEN '(0–10%]'
            WHEN percentage_laid_off > 10 AND percentage_laid_off <= 20 THEN '(10–20%]'
            WHEN percentage_laid_off > 20 AND percentage_laid_off <= 30 THEN '(20–30%]'
            WHEN percentage_laid_off > 30 AND percentage_laid_off <= 40 THEN '(30–40%]'
            WHEN percentage_laid_off > 40 AND percentage_laid_off <= 50 THEN '(40–50%]'
            WHEN percentage_laid_off > 50 AND percentage_laid_off <= 60 THEN '(50–60%]'
            WHEN percentage_laid_off > 60 AND percentage_laid_off <= 70 THEN '(60–70%]'
            WHEN percentage_laid_off > 70 AND percentage_laid_off <= 80 THEN '(70–80%]'
            WHEN percentage_laid_off > 80 AND percentage_laid_off <= 90 THEN '(80–90%]'
            WHEN percentage_laid_off > 90 AND percentage_laid_off < 100 THEN '(90–100%)'
            ELSE 'Shut downed'
        end as percentage_category
    from max_company_layoffs
)
select 
    percentage_category,
    100*count(company)/(
		select count(distinct company) 
		from layoffs_staging
	) as company_count
from distribution_table
group by percentage_category
order by percentage_category
;


select count(distinct company) as total_distinct_companies
from layoffs_staging;

# Majority of companies laid off <20% staff; high-percentage layoffs rare; many cases of shutdowns and missing data
# total 327 companies were total shutdowned out of 2445 distinct companies

