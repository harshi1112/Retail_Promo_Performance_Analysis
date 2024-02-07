/* QUICK OVERVIEW OF THE DATA */
SELECT * FROM dim_campaigns;
SELECT* FROM dim_products;
SELECT* FROM dim_stores;
SELECT* FROM fact_events;
SELECT COUNT(*) FROM dim_campaigns;
SELECT DISTINCT (promo_type) from fact_events;
SELECT COUNT(DISTINCT(store_id)) FROM dim_stores;
SELECT COUNT(DISTINCT(city)) FROM dim_stores;
SELECT DISTINCT promo_type FROM fact_events;
SELECT * , CASE 
                WHEN promo_type = '50% OFF' THEN base_price * 0.5
                WHEN promo_type = '25% OFF' THEN base_price * 0.75
                WHEN promo_type = '33% OFF' THEN base_price * 0.67
                WHEN promo_type = 'BOGOF' THEN base_price *1
                WHEN promo_type = '500 Cashback' THEN base_price - 500
                ELSE NULL
            END  AS discounted_price
     FROM fact_events;

WITH AB AS (SELECT * , CASE 
                WHEN promo_type = '50% OFF' THEN base_price * 0.5
                WHEN promo_type = '25% OFF' THEN base_price * 0.75
                WHEN promo_type = '33% OFF' THEN base_price * 0.67
                WHEN promo_type = 'BOGOF' THEN base_price *1
                WHEN promo_type = '500 Cashback' THEN base_price - 500
                ELSE NULL
            END  AS discounted_price
     FROM fact_events)

SELECT SUM(base_price * `quantity_sold(before_promo)`) , SUM(discounted_price * `quantity_sold(after_promo)`)
FROM AB;


/* BUSINESS REQUESTS*/


/* Products with base_price greater than 500 with promo_type BOGOF*/
WITH A AS (SELECT fact_events.* , dim_products.product_name FROM fact_events 
JOIN  dim_products ON  
fact_events.product_code=dim_products.product_code
)
SELECT  DISTINCT(product_code) ,(product_name) from A WHERE base_price > 500 AND promo_type = 'BOGOF';

/*Number of store in each city */
SELECT city , COUNT(store_id) as store_counts  FROM dim_stores GROUP BY  city order by store_counts desc;

/* Total revenue generated before and after campaign in millions*/
SELECT
    dim_campaigns.campaign_name,
    CONCAT(FORMAT(SUM(fact_events.base_price * fact_events.`quantity_sold(before_promo)`)/ 1000000, 0) , ' M') AS total_revenue_before_promotion,
    CONCAT(FORMAT(SUM(CASE
            WHEN fact_events.promo_type = '50% OFF' THEN fact_events.base_price*0.5
            WHEN fact_events.promo_type = '33% OFF' THEN fact_events.base_price* 0.67
            WHEN fact_events.promo_type = '25% OFF' THEN fact_events.base_price*0.75
            WHEN fact_events.promo_type = 'BOGOF' THEN fact_events.base_price * 1
            WHEN fact_events.promo_type = '500 Cashback' THEN fact_events.base_price -500 
		    ELSE NULL  
        END * fact_events.`quantity_sold(after_promo)`)/1000000,0),' M'
    ) AS total_revenue_after_promo
FROM
    fact_events 
JOIN
    dim_campaigns  ON fact_events.campaign_id = dim_campaigns.campaign_id
GROUP BY
    dim_campaigns.campaign_name;    
    
    
/* Incremental Sold Quantity percentage for each category during diwali campaign  */
WITH A AS (
SELECT 
     dim_products.product_name , 
     dim_products.category, 
     dim_campaigns.campaign_name , 
     fact_events.* FROM fact_events 
JOIN dim_products ON 
dim_products.product_code=fact_events.product_code
JOIN dim_campaigns ON 
dim_campaigns.campaign_id=fact_events.campaign_id
)

SELECT 
     category , 
     (SUM(`quantity_sold(after_promo)`) - SUM(`quantity_sold(before_promo)` ))/SUM(`quantity_sold(before_promo)`)*100 as 'ISU %' ,
     RANK() OVER( ORDER BY (SUM(`quantity_sold(after_promo)`) - SUM(`quantity_sold(before_promo)` )) / SUM(`quantity_sold(before_promo)`) * 100 DESC ) AS Rank_order
FROM A 
WHERE A.campaign_name = 'Diwali' 
GROUP BY category ORDER BY 'ISU%' DESC;

/* Top 5 products ranked by incremental revenue percentage across all campaigns  */
WITH C AS (
    SELECT
        dim_products.product_name,
        dim_products.category,
        
        SUM(fact_events.base_price * fact_events.`quantity_sold(before_promo)`) AS total_revenue_b_p,
        SUM(
            CASE
                WHEN fact_events.promo_type = '50% OFF' THEN fact_events.base_price * 0.5 * fact_events.`quantity_sold(after_promo)`
                WHEN fact_events.promo_type = '33% OFF' THEN fact_events.base_price * 0.67 * fact_events.`quantity_sold(after_promo)`
                WHEN fact_events.promo_type = '25% OFF' THEN fact_events.base_price * 0.75 * fact_events.`quantity_sold(after_promo)`
                WHEN fact_events.promo_type = 'BOGOF' THEN (fact_events.base_price *1) * fact_events.`quantity_sold(after_promo)`
                WHEN fact_events.promo_type = '500 Cashback' THEN (fact_events.base_price - 500) * fact_events.`quantity_sold(after_promo)`
                ELSE NULL
            END
        ) AS total_revenue_d_p
    FROM
        dim_products 
    JOIN
        fact_events  ON dim_products.product_code = fact_events.product_code
    GROUP BY
        dim_products.product_name, dim_products.category
)

SELECT
    product_name,
    category,
    ROUND(
        ((SUM(total_revenue_d_p) - SUM(total_revenue_b_p)) / SUM(total_revenue_b_p)) * 100,
        2
    ) AS IR_percent
FROM
    C
GROUP BY
    product_name , category
ORDER BY
    IR_percent DESC
LIMIT 5;



