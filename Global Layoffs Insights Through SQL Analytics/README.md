# Advanced SQL Data Cleaning & Insights on Global Layoffs

## Project Background
This project was designed to **analyze and extract insights from global layoff data** using SQL.  

The end-to-end workflow covers importing raw data, cleaning and standardizing messy fields, conducting exploratory data analysis (EDA), and finally extracting advanced insights with analytical SQL queries.  

The project demonstrates skills in **data cleaning, schema design, handling NULLs and duplicates, exploratory statistics, and advanced SQL (CTEs, window functions, aggregation)**.  

Key areas of analysis include:  
* **Layoff Trends Over Time** – Yearly patterns and event distribution.  
* **Industry & Country Analysis** – Identifying hardest-hit sectors and regional contributions.  
* **Employee Layoff Intensity** – Categorizing companies by percentage laid off.  
* **Funding Stage Patterns** – Exploring layoffs relative to company funding stage.  


The dataset used for this project in availabe <a href="https://www.kaggle.com/datasets/swaptr/layoffs-2022" target="_blank">here</a>

---

## Data Cleaning and Standardization
The raw dataset contained **inconsistent formatting, missing values, duplicates, and mixed data types**.  
Cleaning was done through a series of SQL transformations:  

* **Schema setup & ingestion** – Created a structured staging table, imported CSV data with `LOAD DATA INFILE`.  
* **Trimming and standardizing text** – Removed whitespace, fixed capitalization and inconsistent country names (e.g., mapping `"us"`, `"U.S."` → `"United States"`).  
* **Type conversions** – Converted dates to `DATE`, funding to `DECIMAL`, and layoff percentages to numeric values from `TEXT`.  
* **Handling NULLs & blanks** – Replaced missing industries with `"Other"`, removed unusable rows with no layoff or percentage data, added missing country names.  
* **Deduplication** – Identified and removed duplicate records to ensure data integrity.  

This step ensured the dataset was **analysis-ready**, consistent, and reproducible. Finally, data validation and exploration were performed through Exploratory Data Analysis (EDA) to ensure accuracy and uncover initial patterns.

---

## Insights 
**Overview of Findings:**  
* **Layoff Trends:** 2023 recorded the highest layoffs (264,220 people, ~35% of the total), while 2021 saw the lowest (~15,823).  
* **Industry Impact:** The **Hardware sector** was hit hardest (≈86,528 layoffs), while **AI, Legal, and Product-based industries** faced the fewest.  
* **Country Distribution:** The **United States accounted for ~67%** of all layoffs, followed by **India (~8%)**.  
* **Funding Stage:** Peak layoffs varied by stage — **late-stage startups in 2020**, **early/mid-stage firms in 2022**, and **mature/IPO/acquired firms in 2023**.  
* **Shutdowns vs. Staff Cuts:** Most companies reduced staff by **<20%**, but **327 out of 2,445 companies** experienced complete shutdowns (100% layoffs).  

---

## Insights Deep Dive


* **Yearly Layoffs**
  - **2023**, layoffs reached their highest level (264,220 people, 35% of total) as companies faced economic slowdown, implemented cost-cutting measures, reduced funding availability, and accelerated adoption of AI and automation, leading to workforce restructuring. 
  - **2021**, layoffs reached their lowest point (~15.8K) as businesses adapted to the 2020 lockdowns, benefited from surging digital demand and funding helped retain staff.

      <img width="1461" height="947" alt="image" src="https://github.com/user-attachments/assets/83cad96a-0d96-4859-ba7d-41f6322581a4" />


* **Industry-Level Analysis** –  
  - **Hardware industry** faced the maximum layoffs (**86.5K employees**).  
  - **AI, Legal, and Product-based industries** reported the **least layoffs**.
 
      <img width="2649" height="2080" alt="Picture 11" src="https://github.com/user-attachments/assets/f85002cc-2acb-4fb9-9b60-20d385c3424d" />


* **Geographic Distribution** –  
  - **United States:** ~67% of global layoffs (highest concentration).  
  - **India:** ~8% of layoffs, driven by the IT/tech sector’s exposure.

    <img width="3231" height="2053" alt="Picture 12" src="https://github.com/user-attachments/assets/a7633127-8263-4dac-b0c4-d3879adc2072" />

* **Stage-Wise Layoffs** -

  - **Early and Mid-Stage Companies (Seed to Series F)**  
    - Layoffs generally **peaked in 2022–2023**.  
    - These companies were highly vulnerable to funding slowdowns and investor caution.   
  
  - **Late-Stage Companies (Series G–J)**  
    - Layoffs **peaked earlier in 2020**, except **Series H** (which peaked in 2022).  
    - Reflects the immediate impact of the pandemic on late-stage companies.  
  
  - **Mature Companies (Acquired, Post-IPO, PE-Backed)**  
    - Layoff spikes occurred mainly in **2023**.  
    - Indicates cost-cutting and profitability push even among well-capitalized companies.  
    - Additionally, many mature companies have begun **restructuring around AI and automation**, leading to role shifts and workforce reductions.
    - This highlights that layoffs are increasingly driven not only by revenues but also by **technology-driven business transformations**. 
  
  - **General Note**  
    - The **worst of layoffs concentrated between 2022 and 2023** across most stages.  
    - By **2024–2025**, most categories show stabilization or decline in layoffs.  

 
      <img width="1619" height="1046" alt="image" src="https://github.com/user-attachments/assets/7bdfaa10-ba33-4589-8173-acf6727b3c44" />



* **Company-Level Distribution** –  
  - **Controlled cuts (<20% staff):** 43% of companies.  
  - **Shutdowns:** 327 companies (~13% of total 2,445) completely closed down.  
  - **High-percentage layoffs (>50%):** Rare (<4%), showing shutdowns were more common than deep cuts.

    <img width="1979" height="1180" alt="image" src="https://github.com/user-attachments/assets/79cf82a6-4532-48d7-909b-03d1bb6715a9" />

---
