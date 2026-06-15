# Customer Behavior Analysis

A data analytics portfolio project analyzing shopping behavior of 3,900 customers
across demographics, product categories, seasons, and purchase patterns.

## Project Files

| File | Description |
|------|-------------|
| `customer_shopping_behavior.csv` | Raw dataset — 3,900 records, 18 features |
| `Data_Analysis_Portfolio_Project.ipynb` | Python notebook: cleaning, EDA, feature engineering |
| `DA_Customer_Behavior_Analysis.sql` | SQL queries: revenue analysis, CLV segmentation, rankings |
| `customer_behavior_dashboard.pbix` | Power BI dashboard for visual reporting |

## Dataset Features

Customer ID, Age, Gender, Item Purchased, Category, Purchase Amount (USD),
Location, Size, Color, Season, Review Rating, Subscription Status,
Shipping Type, Discount Applied, Previous Purchases, Payment Method,
Frequency of Purchases

## What Was Analyzed

**Python (Jupyter Notebook)**
- Data cleaning: imputed 37 null Review Rating values using per-category median
- Removed redundant column (`promo_code_used` mirrored `discount_applied`)
- Feature engineering: age group buckets, purchase frequency in days
- Exported cleaned data to SQL Server via SQLAlchemy

**SQL (14 queries)**
- Top revenue-generating categories and products
- Revenue breakdown by gender and age group
- Customer Lifetime Value (CLV) segmentation using NTILE quartiles
- Subscription vs. non-subscription spending comparison
- Discount impact on order value
- State-wise revenue ranking
- Top 10 customers by spend
- Review rating vs. spending behavior
- Seasonal category preferences
- Purchase frequency segmentation

**Power BI**
- Interactive dashboard built on the cleaned dataset

## Tools Used

- Python (pandas)
- SQL (SQL Server / T-SQL)
- Power BI

## Key Findings

**Revenue by Category**
Clothing led all categories with $104,264 in revenue (44.5% share), followed by
Accessories ($74,200), Footwear ($36,093), and Outerwear ($18,524).

**Top Products**
Blouse ($10,410), Shirt ($10,332), and Dress ($10,320) were the highest revenue-generating items.

**Customer Demographics**
- Dataset covers 3,900 customers aged 18–70
- Male customers (2,652) drove 67.7% of total revenue; female customers (1,248) had a slightly higher average order value ($60.25 vs $59.54)

**Subscription Impact**
Subscribed customers (1,053) had a marginally lower average spend ($59.49) compared to non-subscribers ($59.87), suggesting subscriptions attract deal-seekers rather than high-value spenders.

**Discount Impact**
Orders without discounts had a higher average order value ($60.13) vs discounted orders ($59.28), indicating discounts did not significantly drive higher spending.

**Seasonal Trends**
Fall was the strongest season ($60,018), followed closely by Winter and Spring. Summer was the weakest ($55,777).

**Purchase Frequency**
Revenue was nearly evenly distributed across all frequency segments, with "Every 3 Months" customers generating the most ($35,088).

**Top Locations**
Montana, Illinois, and California ranked as the top three states by revenue.

**Review Rating vs Spending**
Customers who gave a rating of 2 had the highest average spend ($62.29), while ratings of 3–5 clustered around $59–$61 — no strong correlation between satisfaction and spend.

## Business Recommendations

**1. Double down on Clothing — but protect margins**
Clothing is 44.5% of revenue and performs consistently across all seasons.
However, since discounts didn't meaningfully increase order value, avoid blanket
discounting on clothing. Focus on full-price sell-through instead.

**2. Target the top CLV quartile aggressively**
The top 25% of customers (by estimated CLV) account for ~53% of total estimated
lifetime value ($3.05M vs $5.92M total). A loyalty or early-access program
specifically for this segment would protect and grow the most valuable customer base.

**3. Re-evaluate the subscription program**
Subscribers spend slightly less on average than non-subscribers ($59.49 vs $59.87).
The subscription isn't driving higher-value purchases. Consider restructuring
incentives — e.g. exclusive product access or free express shipping — to increase
subscriber order value.

**4. Capitalize on Fall and Spring peaks**
Fall and Spring are the strongest seasons. Inventory planning and marketing budgets
should be weighted toward these windows, particularly for Clothing and Accessories
which peak in Spring.

**5. Push 2-Day Shipping and Express options**
Customers who chose faster shipping options (2-Day, Express) had higher average
spend (~$60.48–$60.73) compared to Standard shipping ($58.46). Promoting faster
shipping at checkout could nudge order values upward.

**6. Investigate low-rating, high-spend customers**
Customers who gave a rating of 2 had the highest average spend ($62.29) —
higher than 5-star customers. This is counterintuitive and worth investigating:
are high-spending customers dissatisfied with something specific (delivery,
product quality)? Addressing this could improve retention of valuable customers.

**7. Grow the female customer segment**
Female customers are only 32% of the customer base but have a slightly higher
average order value. Targeted acquisition campaigns for female shoppers could
improve both revenue and customer mix diversity.

## How to Run

1. **Notebook:** Open `Data_Analysis_Portfolio_Project.ipynb` in Jupyter.
   Update the file path in cell 2 to point to your local CSV.
   The SQL export cells require a SQL Server instance with the ODBC Driver 17.

2. **SQL:** Run `DA_Customer_Behavior_Analysis.sql` in SQL Server Management Studio
   or any T-SQL-compatible client against the `customer_analytics` database.

3. **Power BI:** Open `customer_behavior_dashboard.pbix` in Power BI Desktop.
   You may need to re-point the data source to your local CSV.
