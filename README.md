# SQL Data Cleaning Project

## Overview

This project focuses on cleaning and preparing a raw layoffs dataset
using MySQL.

The dataset contains information about companies, locations, industries,
layoffs, dates, company stages, countries, and funds raised.

The main goal of this project is to identify and remove duplicate data,
standardize inconsistent values, handle missing data, convert data types,
and remove unnecessary records.

---

## Tools Used

- MySQL
- MySQL Workbench
- SQL

---

## Dataset

The raw dataset contains **2,361 records** and the following 9 columns:

- `company`
- `location`
- `industry`
- `total_laid_off`
- `percentage_laid_off`
- `date`
- `stage`
- `country`
- `funds_raised_millions`

The original CSV file is included in this repository as:

`layoffs.csv`

---

## Data Cleaning Process

### 1. Created a Staging Table

A staging table was created as a copy of the original `layoffs` table.

The original data was kept unchanged so that the cleaning process could
be performed safely on the staging data.

```sql
CREATE TABLE layoff_staging
LIKE layoffs;

INSERT INTO layoff_staging
SELECT *
FROM layoffs;