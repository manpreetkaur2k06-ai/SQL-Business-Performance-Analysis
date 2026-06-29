SELECT COUNT(*) AS Total_Records
FROM walmart_sales;

SELECT DISTINCT City
FROM walmart_sales;

SELECT DISTINCT Branch
FROM walmart_sales;

SELECT DISTINCT category
FROM walmart_sales;

SELECT COUNT(DISTINCT category) AS Total_Categories
FROM walmart_sales;

SELECT DISTINCT payment_method
FROM walmart_sales;

SELECT COUNT(DISTINCT payment_method) AS Payment_Methods
FROM walmart_sales;

SELECT
MIN(date) AS First_Date,
MAX(date) AS Last_Date
FROM walmart_sales;

SELECT ROUND(AVG(rating),2) AS Average_Rating
FROM walmart_sales;

SELECT ROUND(AVG(CAST(REPLACE(unit_price,'$','') AS REAL)),2) AS Average_Unit_Price
FROM walmart_sales;

SELECT
ROUND(
SUM(
CAST(REPLACE(unit_price,'$','') AS REAL) * quantity
),2) AS Total_Revenue
FROM walmart_sales;

SELECT
ROUND(
AVG(
CAST(REPLACE(unit_price,'$','') AS REAL) * quantity
),2) AS Avg_Transaction_Value
FROM walmart_sales;

SELECT
category,
ROUND(
SUM(
CAST(REPLACE(unit_price,'$','') AS REAL) * quantity
),2) AS Revenue
FROM walmart_sales
GROUP BY category
ORDER BY Revenue DESC;

SELECT
Branch,
ROUND(
SUM(
CAST(REPLACE(unit_price,'$','') AS REAL) * quantity
),2) AS Revenue
FROM walmart_sales
GROUP BY Branch
ORDER BY Revenue DESC;

SELECT
City,
ROUND(
SUM(
CAST(REPLACE(unit_price,'$','') AS REAL) * quantity
),2) AS Revenue
FROM walmart_sales
GROUP BY City
ORDER BY Revenue DESC;

SELECT
category,
SUM(quantity) AS Quantity_Sold
FROM walmart_sales
GROUP BY category
ORDER BY Quantity_Sold DESC;

SELECT
category,
ROUND(AVG(rating),2) AS Avg_Rating
FROM walmart_sales
GROUP BY category
ORDER BY Avg_Rating DESC;

SELECT
payment_method,
COUNT(*) AS Total_Transactions
FROM walmart_sales
GROUP BY payment_method
ORDER BY Total_Transactions DESC;

SELECT
category,
ROUND(AVG(profit_margin),2) AS Avg_Profit_Margin
FROM walmart_sales
GROUP BY category
ORDER BY Avg_Profit_Margin DESC;

SELECT
invoice_id,
category,
ROUND(
CAST(REPLACE(unit_price,'$','') AS REAL) * quantity,
2
) AS Revenue
FROM walmart_sales
ORDER BY Revenue DESC
LIMIT 10;

SELECT
category,
ROUND(
SUM(CAST(REPLACE(unit_price,'$','') AS REAL) * quantity),2
) AS Revenue
FROM walmart_sales
GROUP BY category
HAVING Revenue > 50000
ORDER BY Revenue DESC;

SELECT
Branch,
ROUND(AVG(rating),2) AS Avg_Rating
FROM walmart_sales
GROUP BY Branch
HAVING Avg_Rating > 4
ORDER BY Avg_Rating DESC;

SELECT
category,
COUNT(invoice_id) AS Total_Transactions
FROM walmart_sales
GROUP BY category
ORDER BY Total_Transactions DESC;

SELECT
category,
MAX(CAST(REPLACE(unit_price,'$','') AS REAL)) AS Highest_Unit_Price
FROM walmart_sales
GROUP BY category
ORDER BY Highest_Unit_Price DESC;

SELECT
category,
MIN(CAST(REPLACE(unit_price,'$','') AS REAL)) AS Lowest_Unit_Price
FROM walmart_sales
GROUP BY category
ORDER BY Lowest_Unit_Price;

SELECT
invoice_id,
rating,
CASE
WHEN rating >= 4.5 THEN 'Excellent'
WHEN rating >= 3.5 THEN 'Good'
ELSE 'Average'
END AS Rating_Category
FROM walmart_sales;

SELECT
Branch,
ROUND(AVG(quantity),2) AS Avg_Quantity
FROM walmart_sales
GROUP BY Branch
ORDER BY Avg_Quantity DESC;

SELECT
City,
ROUND(
AVG(CAST(REPLACE(unit_price,'$','') AS REAL) * quantity),2
) AS Avg_Revenue
FROM walmart_sales
GROUP BY City
ORDER BY Avg_Revenue DESC;

SELECT
Branch,
ROUND(AVG(profit_margin),2) AS Avg_Profit_Margin
FROM walmart_sales
GROUP BY Branch
ORDER BY Avg_Profit_Margin DESC;

SELECT
SUBSTR(date,1,INSTR(date,'/')-1) AS Month,
ROUND(
SUM(CAST(REPLACE(unit_price,'$','') AS REAL) * quantity),2
) AS Revenue
FROM walmart_sales
GROUP BY Month
ORDER BY CAST(Month AS INTEGER);

SELECT
    category,
    ROUND(SUM(CAST(REPLACE(unit_price,'$','') AS REAL) * quantity),2) AS Revenue
FROM walmart_sales
GROUP BY category
HAVING Revenue >
(
    SELECT AVG(CAST(REPLACE(unit_price,'$','') AS REAL) * quantity)
    FROM walmart_sales
)
ORDER BY Revenue DESC;

SELECT
    invoice_id,
    category,
    Branch,
    ROUND(CAST(REPLACE(unit_price,'$','') AS REAL) * quantity,2) AS Revenue
FROM walmart_sales
ORDER BY Revenue DESC
LIMIT 5;

SELECT
    invoice_id,
    ROUND(CAST(REPLACE(unit_price,'$','') AS REAL) * quantity,2) AS Revenue,
    ROUND(
        SUM(CAST(REPLACE(unit_price,'$','') AS REAL) * quantity)
        OVER(ORDER BY invoice_id),
    2) AS Running_Total
FROM walmart_sales;

SELECT
    category,
    ROUND(
        SUM(CAST(REPLACE(unit_price,'$','') AS REAL) * quantity),
    2) AS Revenue,
    RANK() OVER
    (
        ORDER BY SUM(CAST(REPLACE(unit_price,'$','') AS REAL) * quantity) DESC
    ) AS Revenue_Rank
FROM walmart_sales
GROUP BY category;

SELECT
    Branch,
    ROUND(
        SUM(CAST(REPLACE(unit_price,'$','') AS REAL) * quantity),
    2) AS Revenue,
    DENSE_RANK() OVER
    (
        ORDER BY SUM(CAST(REPLACE(unit_price,'$','') AS REAL) * quantity) DESC
    ) AS Revenue_Rank
FROM walmart_sales
GROUP BY Branch;

SELECT
invoice_id,
ROUND(
CAST(REPLACE(unit_price,'$','') AS REAL) * quantity,
2
) AS Revenue,
CASE
WHEN (CAST(REPLACE(unit_price,'$','') AS REAL) * quantity) >= 1000
THEN 'High Revenue'
WHEN (CAST(REPLACE(unit_price,'$','') AS REAL) * quantity) >= 500
THEN 'Medium Revenue'
ELSE 'Low Revenue'
END AS Revenue_Category
FROM walmart_sales;

WITH BranchRevenue AS
(
SELECT
Branch,
ROUND(
SUM(CAST(REPLACE(unit_price,'$','') AS REAL) * quantity),
2
) AS Revenue
FROM walmart_sales
GROUP BY Branch
)
SELECT *
FROM BranchRevenue
ORDER BY Revenue DESC;

SELECT
payment_method,
ROUND(
AVG(CAST(REPLACE(unit_price,'$','') AS REAL) * quantity),
2
) AS Avg_Revenue
FROM walmart_sales
GROUP BY payment_method
ORDER BY Avg_Revenue DESC;

SELECT
category,
ROUND(AVG(rating),2) AS Avg_Rating,
RANK() OVER
(
ORDER BY AVG(rating) DESC
) AS Rating_Rank
FROM walmart_sales
GROUP BY category;

SELECT
COUNT(*) AS Total_Transactions,
ROUND(
SUM(CAST(REPLACE(unit_price,'$','') AS REAL) * quantity),
2
) AS Total_Revenue,
ROUND(
AVG(CAST(REPLACE(unit_price,'$','') AS REAL) * quantity),
2
) AS Average_Transaction_Value,
ROUND(AVG(rating),2) AS Average_Rating,
COUNT(DISTINCT Branch) AS Total_Branches,
COUNT(DISTINCT City) AS Total_Cities,
COUNT(DISTINCT category) AS Total_Categories
FROM walmart_sales;