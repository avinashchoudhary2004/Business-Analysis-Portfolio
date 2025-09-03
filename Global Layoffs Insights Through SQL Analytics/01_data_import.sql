# Creating database and importing files
create database world_layoffs;

USE world_layoffs;

#importing data from the datasets 
SHOW VARIABLES LIKE "secure_file_priv";

create table layoffs like `world layoffs`;

LOAD DATA INFILE '/tmp/World Layoffs.csv'
INTO TABLE world_layoffs.layoffs
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


# exploring the dataset
select * from layoffs;

describe layoffs;	# need to change data type of date and total_laid_off field 


