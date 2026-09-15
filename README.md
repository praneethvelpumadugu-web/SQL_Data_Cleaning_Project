# SQL Data Cleaning Project

## Overview

This project focuses on cleaning and preparing a raw layoffs dataset using MySQL.

The main goal was to identify and remove duplicate records, standardize inconsistent values, handle missing data, convert data types, and remove unnecessary records.

## Tools Used

- MySQL
- MySQL Workbench
- SQL

## Dataset

The dataset contains **2,361 records** with information about:

- Companies
- Locations
- Industries
- Layoffs
- Dates
- Company stages
- Countries
- Funds raised

The original dataset is included as `layoffs.csv`.

## Data Cleaning Process

### 1. Created a Staging Table
Created a copy of the original table so the raw data remained unchanged during cleaning.

### 2. Removed Duplicate Records
Used `ROW_NUMBER()` with `PARTITION BY` to identify duplicate records and removed records where the row number was greater than 1.

### 3. Standardized Data
- Removed extra spaces from company names using `TRIM()`.
- Standardized industry values beginning with `Crypto` to `Crypto`.
- Removed trailing periods from country names.

### 4. Converted Date Data
Converted the date column from text format to the MySQL `DATE` data type using `STR_TO_DATE()`.

### 5. Handled Missing Data
- Converted empty industry values to `NULL`.
- Filled missing industry values using another record from the same company when available.
- Removed records where both `total_laid_off` and `percentage_laid_off` were missing.

### 6. Final Cleanup
Removed the temporary `row_number` helper column after duplicate removal.

## SQL Concepts Used

- `CREATE TABLE`
- `INSERT INTO ... SELECT`
- `ROW_NUMBER()`
- `PARTITION BY`
- `UPDATE`
- `DELETE`
- `JOIN`
- `LIKE`
- `TRIM()`
- `STR_TO_DATE()`
- `ALTER TABLE`
- `NULL` handling

## Project Structure

```text
SQL_Data_Cleaning_Project/
│
├── README.md
├── data/
│   └── layoffs.csv
└── sql/
    └── layoffs_data_cleaning.sql
```

## Key Takeaways

This project provided hands-on experience with SQL data cleaning, duplicate detection, data standardization, NULL handling, data type conversion, and working with staging tables in MySQL.