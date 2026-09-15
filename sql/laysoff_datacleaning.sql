SELECT * FROM layoffs
LIMIT 3;



CREATE TABLE layoff_staging
LIKE layoffs;

INSERT INTO layoff_staging
SELECT * FROM layoffs;
 -- CALCULATING ROW_NUMBER FOR EACH DIFFERENT GROUP
 
SELECT * ,
ROW_NUMBER() OVER(PARTITION BY company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) AS row_num
FROM layoff_staging;

-- CREATING AND COPYING THE TABLE FOR REMOVING

CREATE TABLE `layoff_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_number` int 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO layoff_staging2
SELECT * ,
ROW_NUMBER() OVER(PARTITION BY company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) AS row_num
FROM layoff_staging;

SELECT * FROM layoff_staging2;

SET SQL_SAFE_UPDATES = 0;
-- REMOVING DUPLICATES AND CHECKING

DELETE FROM layoff_staging2
WHERE `row_number`>1;

SELECT * FROM layoff_staging2
WHERE `row_number`>1;

-- Standardizing Data

-- TRIMING

SELECT company,TRIM(company)
FROM layoff_staging2;

UPDATE layoff_staging2
SET company=TRIM(company);

SELECT industry FROM layoff_staging2
WHERE industry LIKE 'Crypto%';

UPDATE layoff_staging2
SET industry='Crypto'
WHERE industry LIKE 'Crypto%';

SELECT industry FROM layoff_staging2
WHERE industry = 'Crypto Currency';

-- Triming trailing .
UPDATE layoff_staging2
SET country=TRIM(TRAILING '.' FROM country);

-- Changing date column type

SELECT `date` FROM layoff_staging2;

UPDATE layoff_staging2
SET `date`=STR_TO_DATE(`date`,'%m/%d/%Y');

ALTER TABLE layoff_staging2
MODIFY COLUMN `date` DATE;

-- NULL Handling

SELECT * FROM layoff_staging2
WHERE company='Airbnb';

UPDATE layoff_staging2
SET industry = NULL
WHERE industry='';

UPDATE layoff_staging2 t1
JOIN layoff_staging2 t2
ON t1.company=t2.company
SET t1.industry=t2.industry
WHERE t1.industry IS NULL AND t2.industry IS NOT NULL;

-- Removing unwanted data

SELECT * FROM layoff_staging2
WHERE total_laid_off IS NULL AND percentage_laid_off IS NULL;

DELETE FROM layoff_staging2
WHERE total_laid_off IS NULL AND percentage_laid_off IS NULL;

-- AT Last Deleting (helper column)row_number column

ALTER TABLE layoff_staging2
DROP COLUMN `row_number`;

SELECT * FROM layoff_staging2;
