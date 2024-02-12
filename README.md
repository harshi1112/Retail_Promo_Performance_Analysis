# Retail_Promotion_Performance_Analysis
### PROJECT OVERVIEW
AtliQ Mart is a retail giant with over 50 supermarkets in the sourthern region of India. All their 50 stores ran a massive promotion during the Diwali 2023 and Sankranti 2024 (festive time in India) on their AtliQ  branded products. 

### PROBLEM STATEMENT
The sales director wants to understand which promotion did well and which did not so that they can make informed decisions for their next promotional period.

### OBJECTIVE
The analysis aims to evaluate the performance of different promotions  conducted by AtliQ Mart during the Diwali 2023 and Sankranti 2024 periods. By analyzing store performance, product 
performance, and promotion effectiveness, key insights have been derived .The analysis focuses on identifying the most successful promotions to guide decision-making for future campaigns.
Also there were some additional business questions that were required to be answered using SQL queries,which is uploaded above. 

### DATA SOURCE
The dataset is taken from Codebasics. It contains four csv files -
1. dim_campaigns
2. dim_products
3. dim_stores
4. fact_events
##### Column Description for dim_campaigns:
- campaign_id: Unique identifier for each promotional campaign.
- campaign_name: Descriptive name of the campaign (e.g., Diwali, Sankranti).
- start_date: The date on which the campaign begins, formatted as DD-MM-YYYY.
- end_date: The date on which the campaign ends, formatted as DD-MM-YYYY.
##### Column Description for dim_products:
- product_code: Unique code assigned to each product for identification.
- product_name: The full name of the product, including brand and specifics (e.g., quantity, size).
- category: The classification of the product into broader categories such as Grocery & Staples, Home Care, Personal Care, Home Appliances, etc.
##### Column Description for dim_stores:
- store_id: Unique code identifying each store location.
- city: The city where the store is located, indicating the geographical market.
##### Column Description for fact_events:
- event_id: Unique identifier for each sales event.
- store_id: Refers to the store where the event took place, linked to the dim_stores table.
- campaign_id: Indicates the campaign under which the event was recorded, linked to the dim_campaigns table.
- product_code: The code of the product involved in the sales event, linked to the dim_products table.
- base_price: The standard price of the product before any promotional discount.
- promo_type: The type of promotion applied (e.g., percentage discount, BOGOF(Buy One Get One Free), cashback).
- quantity_sold(before_promo): The number of units sold in the week immediately preceding the start of the campaign, serving as a baseline for comparison with promotional sales.
- quantity_sold(after_promo): The quantity of the product sold after the promotion was applied.
   

### METHODOLOGY
##### Step 1: Data Familiarization and Problem Statement Review

Downloaded and opened the dataset in the provided format (.csv file).
Reviewed each file to ensure data integrity and identify any visual errors.
Thoroughly read the problem statement to understand the focus areas for analysis.
##### Step 2: Database Setup and SQL Queries

Created a database in MySQL to import the dataset.
Executed SQL queries to gain insights into the dataset and answer specific business questions.
Utilized SQL queries to explore relationships between different tables and understand the dataset's structure.
##### Step 3: Idea Brainstorming and Dashboard Drafting

Utilized notepad to brainstorm ideas and outline the analysis approach.
Drafted a rough dashboard layout to visualize the key metrics and insights derived from the analysis.
Generated initial hypotheses and identified potential areas of interest for deeper exploration.
##### Step 4: Data Preparation and Analysis in Power BI

Imported the dataset into Power BI to begin data preparation.
Created common measures such as Incremental Sold Unit, Incremental Revenue, Incremental Revenue Percentage, Promo Price,etc.
Developed visualizations and report pages in Power BI to visualize the data and present key findings.
Iteratively refined the dashboard layout and visuals to ensure clarity and effectiveness in communicating insights.
By following these steps, I systematically approached the analysis of the dataset, from data familiarization to visualization and reporting, ensuring a structured and comprehensive exploration of the provided data.
### RESULTS/FINDINGS
#### Store Performance:

##### 1) Identified the distribution of stores across different cities.
##### 2) Determined the bottom 10 stores based on Incremental Sold Units (ISU).
##### 3) Identified the top 10 stores with the highest Incremental Revenue (IR).
##### 4) Analyzed Incremental Revenue by city, revealing varying performance.
##### 5) Utilized a heatmap to visualize the relationship between city and promotion type performance, indicating that cities with higher revenue tend to have a higher proportion of revenue generated from BOGOF and 500 cashback promotions.
#### Product/Category Performance:

##### 1) Identified the top 5 products performing exceptionally well in terms of Incremental Revenue Percentage (IR%).
##### 2) Identified the top 5 products with the highest Incremental Revenue (IR).
##### 3) Identified the bottom 5 products with the lowest Incremental Revenue (IR).
##### 4) Conducted a correlation analysis between product category and promotion type effectiveness, revealing disparities in performance across different categories.
##### 5) Analyzed net revenue by product category  
##### 6) Identified Grocery and Staples showing significant lifts in sales from the promotions.
#### Promotional Performance:

##### 1) Analyzed net revenue by promotion type, revealing insights into the distribution of revenue across different promotion types.
##### 2) Examined Incremental Sold Units by promotion type, identifying the most successful promotions in terms of generating sales.
##### 3) Identified the top two promotions resulting in the highest Incremental Revenue, which were 500 cashback and BOGOF.
##### 4) Compared the performance of discount-based promotions with 500 cashback and BOGOF promotions, with BOGOF showing the best balance between Incremental Sold Units and maintaining healthy margins.

### RECOMMENDATIONS:

##### 1) Leverage Successful Promotions: Given the success of 500 cashback and BOGOF promotions, consider allocating more resources towards these promotions in future campaigns.
##### 2) Optimize Product Mix: Focus on promoting products from categories that have shown significant lifts in sales, such as Grocery and Staples.
##### 3) Review Discount-Based Promotions: Evaluate the effectiveness of discount-based promotions and consider repositioning or discontinuing them if they continue to yield negative incremental revenue.
##### 4) Enhance Store Performance: Provide additional support and resources to underperforming stores, particularly those in cities with lower revenue generation.
##### 5) Investigate Factors Driving Performance Disparities: Conduct further analysis to understand the factors contributing to performance disparities across different cities and product categories, and develop targeted strategies to address them.

### CONCLUSION:
The analysis provides valuable insights into the effectiveness of promotional campaigns conducted by AtliQ Mart . By leveraging these insights, AtliQ Mart can make informed decisions to optimize future promotional strategies and maximize sales performance.


