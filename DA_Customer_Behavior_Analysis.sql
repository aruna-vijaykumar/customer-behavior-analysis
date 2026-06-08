CREATE DATABASE customer_analytics;
USE customer_analytics;

SELECT * 
FROM customer_behavior

--#1 Top Revenue generating Categories
SELECT Category, SUM(Purchase_Amount_USD) AS Revenue
FROM customer_behavior
GROUP BY Category
ORDER BY Revenue DESC;

--#2 Category Revenue Share
SELECT Category, SUM(Purchase_Amount_USD) AS Revenue,
	ROUND(
		100.0 * SUM(Purchase_Amount_USD)/SUM(SUM(Purchase_Amount_USD)) OVER(),
		2
	) AS Revenue_Share_Percent
FROM customer_behavior
GROUP BY Category
ORDER BY Revenue DESC;

--#3 Top Revenue generating Products
SELECT Item_Purchased, SUM(Purchase_Amount_USD) AS Revenue
FROM customer_behavior
GROUP BY Item_Purchased
ORDER BY Revenue DESC;

--#4 Revenue by Gender
SELECT Gender, COUNT(*) AS Customers,
	SUM(Purchase_Amount_USD) AS Revenue,
	ROUND(AVG(Purchase_Amount_USD), 2) AS Avg_Order_Value
FROM customer_behavior
GROUP BY Gender;

--#5 Revenue by Age-group
SELECT
	CASE
		WHEN Age<=30 THEN 'Young Adult'
		WHEN Age<=44 THEN 'Adult'
		WHEN Age<=57 THEN 'Middle Aged'
		ELSE 'Senior'
	END AS Age_Group,

	COUNT(*) AS Customers,
	SUM(Purchase_Amount_USD) AS Revenue,
	ROUND(AVG(Purchase_Amount_USD),2) AS Avg_Spend
FROM customer_behavior
GROUP BY
CASE
	WHEN Age<=30 THEN 'Young Adult'
	WHEN Age<=44 THEN 'Adult'
	WHEN Age<=57 THEN 'Middle Aged'
	ELSE 'Senior'
END
ORDER BY Revenue DESC;

--#6 Customer Lifetime Value Segmentation
WITH customer_clv AS (
	SELECT Customer_ID, Purchase_Amount_USD, Previous_Purchases,
	Purchase_Amount_USD * Previous_Purchases AS Estimated_CLV
	FROM customer_behavior
),
quartiles AS (
	SELECT *,
		NTILE(4) OVER (ORDER BY Estimated_CLV DESC) AS CLV_Quartile
		FROM customer_clv
)

SELECT CLV_Quartile, COUNT(*) AS Customer_Count,
	ROUND(AVG(Estimated_CLV),2) AS Avg_CLV,
	SUM(Estimated_CLV) AS Total_CLV
FROM quartiles
GROUP BY CLV_Quartile
ORDER BY CLV_Quartile;

--#7 Revenue Share by CLV Quartile
WITH customer_clv AS (
	SELECT Customer_ID, 
	Purchase_Amount_USD * Previous_Purchases AS Estimated_CLV
	FROM customer_behavior
),
quartiles AS (
	SELECT *, 
		NTILE(4) OVER (ORDER BY Estimated_CLV DESC) AS Quartile
	FROM customer_clv
)

SELECT Quartile, SUM(Estimated_CLV) AS Total_CLV,
	ROUND(100.0*SUM(Estimated_CLV)/SUM(SUM(Estimated_CLV)) OVER(), 2) AS Revenue_Share_Percent
FROM quartiles
GROUP BY Quartile
ORDER BY Quartile;

--#8 Subscription vs Non-Subscription Spending
SELECT Subscription_Status, COUNT(*) AS Customers,
	SUM(Purchase_Amount_USD) AS Revenue,
	ROUND(AVG(Purchase_Amount_USD), 2) AS Avg_Spend
FROM customer_behavior
GROUP BY Subscription_Status;

--#9 Discount Impact
SELECT Discount_Applied, COUNT(*) AS Orders,
	SUM(Purchase_Amount_USD) AS Revenue,
	ROUND(AVG(Purchase_Amount_USD), 2) AS Avg_Order_Value
FROM customer_behavior
GROUP BY Discount_Applied;

--#10 State-wise Revenue Ranking
SELECT Location, SUM(Purchase_Amount_USD) AS Revenue,
	RANK() OVER(
		ORDER BY SUM(Purchase_Amount_USD) DESC
	) AS Revenue_Rank
FROM customer_behavior
GROUP BY Location;

--#11 Top Customers
WITH customer_spend AS (
	SELECT Customer_ID, SUM(Purchase_Amount_USD) AS Revenue
	FROM customer_behavior
	GROUP BY Customer_ID
),
ranked_customers AS (
	SELECT*,
		ROW_NUMBER() OVER (ORDER BY Revenue DESC) AS rn 
	FROM customer_spend
)

SELECT *
FROM ranked_customers
WHERE rn<=10;

--#12 Review Rating vs Spending
SELECT ROUND(Review_Rating, 0) AS Rating_Bucket,
	COUNT(*) AS Orders,
	ROUND(AVG(Purchase_Amount_USD), 2) AS Avg_Spend
FROM customer_behavior
GROUP BY ROUND(Review_Rating, 0)
ORDER BY Rating_Bucket

--#13 Seasonal Category Preferences
SELECT Season, Category,
	COUNT(*) AS Purchases,
	SUM(Purchase_Amount_USD) AS Revenue
FROM customer_behavior
GROUP BY Season, Category
ORDER BY Season, Category DESC;

--#14 Purchase Frequency Segmentation
SELECT Frequency_of_Purchases, COUNT(*) AS Customers,
	SUM(Purchase_Amount_USD) AS Revenue,
	ROUND(AVG(Purchase_Amount_USD),2) AS Avg_Order_Value
FROM customer_behavior
GROUP BY Frequency_of_Purchases
ORDER BY Revenue DESC;
