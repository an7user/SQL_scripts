-- CASE WHEN function

SELECT *,
case 
when rating > 9.5 and unit_price < 30 then "Best product"
ELSE 'other'
END as product_select
FROM fact_sales f
join invoice i on f.invoice_id = i.invoice_id
join customer c on f.customer_id = c.customer_id
join location l on f.location_id = l.location_id
order by product_select
; 

-- COALESCE function

SELECT* from customer;

SELECT* from customer
WHERE membership is null;

SELECT *,
COALESCE (membership, 'NO MEMBERSHIP') as DA_MEMBA
from customer;

-- USING NULLIF function

SELECT *,
NULLIF (product_line, 'Sports and travel') AS NULLIFIED
FROM fact_sales f
join invoice i on f.invoice_id = i.invoice_id
join customer c on f.customer_id = c.customer_id
join location l on f.location_id = l.location_id
; 

--  LEAST and GREATEST

SELECT *,
GREATEST (50, unit_price) AS INFLATION_PRICE
FROM fact_sales f
join invoice i on f.invoice_id = i.invoice_id
join customer c on f.customer_id = c.customer_id
join location l on f.location_id = l.location_id
; 

SELECT *,
LEAST (30, unit_price) AS HAPPY_PRICE
FROM fact_sales f
join invoice i on f.invoice_id = i.invoice_id
join customer c on f.customer_id = c.customer_id
join location l on f.location_id = l.location_id
; 

-- USING DISTINCT

SELECT distinct unit_price
FROM fact_sales;

-- finding the same price

SELECT *
FROM fact_sales
GROUP BY unit_price
HAVING COUNT(unit_price) >1
;

-- CTE for finding the same price

WITH CTE as  
(  
   SELECT*, ROW_NUMBER() over (PARTITION BY unit_price ORDER BY unit_price) as same_price  
   FROM fact_sales  
)  
SELECT * FROM CTE
WHERE same_price > 1;
