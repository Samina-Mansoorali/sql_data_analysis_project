-- EXPLORATORY SATA ANALYSIS

SELECT *
FROM layoffs_staging2;

SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2;

SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;

SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

SELECT MIN(`date`), MAX(`date`)
FROM layoffs_staging2
WHERE country LIKE 'india%';

SELECT industry, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;

SELECT *
FROM layoffs_staging2;

SELECT country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

SELECT year(`date`), SUM(total_laid_off)
FROM layoffs_staging2
WHERE country LIKE 'india%'
GROUP BY year(`date`)
ORDER BY 1 ASC;

SELECT stage, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;


SELECT company, AVG(percentage_laid_off)
FROM layoffs_staging2
WHERE country LIKE 'india%'
GROUP BY company
ORDER BY 2 DESC;

SELECT substring(`date`,1,7) AS 'MONTH', SUM(total_laid_off)
FROM layoffs_staging2
WHERE substring(`date`,1,7) IS NOT NULL
GROUP BY substring(`date`,1,7)
ORDER BY 1 ASC;

SELECT *
FROM layoffs_staging2;

WITH Rolling_Total AS
(
SELECT SUBSTRING(`date`,1,7) AS Month_year, SUM(total_laid_off) AS total_off
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY Month_year
ORDER BY 1 ASC
)
SELECT Month_year, total_off,
SUM(total_off) OVER(ORDER BY Month_year ASC) AS rolling_total
FROM Rolling_Total;


SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
WHERE country like 'india%'
GROUP BY company
ORDER BY 2 DESC;

SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
WHERE country like 'india%'
GROUP BY company, YEAR(`date`)
ORDER BY company;

SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
WHERE country like 'india%'
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC;

WITH company_year (company, years, total_laid_off) AS
(
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
WHERE country like 'india%'
GROUP BY company, YEAR(`date`)
), company_year_rank AS
(SELECT * , 
DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
FROM company_year
WHERE years IS NOT NULL
)
SELECT *
FROM company_year_rank;

WITH company_year (company, years, total_laid_off) AS
(
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
WHERE country like 'india%'
GROUP BY company, YEAR(`date`)
), company_year_rank AS
(SELECT * , 
DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
FROM company_year
WHERE years IS NOT NULL
)
SELECT *
FROM company_year_rank
WHERE Ranking <= 5;

WITH company_year (industry, years, total_laid_off) AS
(
SELECT industry, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
WHERE country like 'india%'
GROUP BY industry, YEAR(`date`)
), company_year_rank AS
(SELECT * , 
DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
FROM company_year
WHERE years IS NOT NULL
)
SELECT *
FROM company_year_rank
WHERE Ranking <= 5;






































































































































