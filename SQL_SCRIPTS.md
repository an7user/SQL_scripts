## Method 1. Finding duplicates in table: fact_sales using aggregation function COUNT() with Group BY and HAVING clause

SELECT 

gross_income,

unit_price,

COUNT(*) AS CNT

FROM

fact_sales f
   
   GROUP BY  
   gross_income, 
   unit_price

   HAVING COUNT(*) > 1;
       

![01_dupe_1](https://user-images.githubusercontent.com/90646142/136613543-fd81a3d3-c4c6-47f3-a2e1-d01f0ff64a37.png)

## method 2: finding duplicates in table: fact_sales using Common Table Expression
             
WITH CTE as 

(  
   SELECT*, ROW_NUMBER() over (PARTITION BY invoice_id ORDER BY invoice_id) as Duplicates  
   FROM fact_sales  
)  

SELECT * FROM CTE

WHERE Duplicates > 1;


![02_dupe_2](https://user-images.githubusercontent.com/90646142/136613545-b503a357-dfa8-42d6-a936-5990d6211312.png)

## method 3: finding duplicates in table: fact_sales using ROW_MUMBER function
   
   SELECT * FROM (SELECT *, ROW_NUMBER() over (PARTITION BY invoice_id ORDER BY invoice_id) as Duplicates  
   
   FROM fact_sales) as temp_table 
   
   WHERE Duplicates >= 1;
 


![03_dupe_3](https://user-images.githubusercontent.com/90646142/136613546-b809509b-714d-4c11-82c8-d2495ee431b0.png)

## Deliting duplicates from table: fact_sales using the ROW_NUMBER() Function 

 DELETE FROM fact_sales WHERE fact_id IN(
 
   SELECT fact_id FROM (SELECT fact_id, ROW_NUMBER() 
   over (PARTITION BY invoice_id ORDER BY invoice_id) as Duplicates
   
   FROM fact_sales) AS temp_table 
   
   WHERE Duplicates >1
   
   );
    
 ![04_dupe_delete](https://user-images.githubusercontent.com/90646142/136613547-d7360f10-8010-4a4a-9f18-9a73700af9fe.png)
  
 ## Double cheking for dupliactes after running the delete script using Common Table Expression
 
  WITH CTE as  

(  
   SELECT*, ROW_NUMBER() over (PARTITION BY invoice_id ORDER BY invoice_id) as Duplicates  
   FROM fact_sales  

)  

SELECT * FROM CTE

WHERE Duplicates > 1;
  
![05_dupe_delete_check](https://user-images.githubusercontent.com/90646142/136613549-c23434b9-8b57-4f41-8e52-72020024c79b.png)

 ## Double cheking for dupliactes after running the delete script using ROW_MUMBER function
 
 SELECT * FROM (SELECT *, ROW_NUMBER() over (PARTITION BY invoice_id ORDER BY invoice_id) as Duplicates  
   
   FROM fact_sales) as temp_table 
   
   WHERE Duplicates >= 1;
   
             
![06_dupe_delete_check2](https://user-images.githubusercontent.com/90646142/136613550-47017f73-60a6-4dd7-9f90-60990880368c.png)

## Using CASE WHEN function to find the best product (highest rating and the price below 30 USD)

SELECT *,

case 

when rating > 9.5 and unit_price < 30 then 'Best product'

ELSE 'other'

END as product_select

FROM fact_sales f

join invoice i on f.invoice_id = i.invoice_id

join customer c on f.customer_id = c.customer_id

join location l on f.location_id = l.location_id

order by product_select

; 

![07_case_when_f](https://user-images.githubusercontent.com/90646142/136613551-5c87b71f-3c67-4be0-b092-5dedf4873893.png)

## replacing NULL value with the 'No membership' value in table: customer with a COALESCE function

SELECT* from customer;

SELECT* from customer

WHERE membership is null;

SELECT *,

COALESCE (membership, 'NO MEMBERSHIP') as `UNDEFINED`

from customer;

![08_coalesce_f](https://user-images.githubusercontent.com/90646142/136613552-c04d7ae0-e2d9-41ab-a104-77b09191cdb7.png)

## USING NULLIF function to substitute the 'Sports and travel' product line in table: fact_sales with `NULL`

SELECT *,

NULLIF (product_line, 'Sports and travel') AS NULLIFIED

FROM fact_sales f

join invoice i on f.invoice_id = i.invoice_id

join customer c on f.customer_id = c.customer_id

join location l on f.location_id = l.location_id

ORDER BY NULLIFIED ASC

;

![09_nullif](https://user-images.githubusercontent.com/90646142/136613555-3a759cb8-30a2-4ebd-942a-ab4a7fbd5c59.png)

## Using LEAST function to replace the unit price of all the products with the price above 30 USD

SELECT *,

LEAST (30, unit_price) AS HAPPY_PRICE

FROM fact_sales f

join invoice i on f.invoice_id = i.invoice_id

join customer c on f.customer_id = c.customer_id

join location l on f.location_id = l.location_id

ORDER BY HAPPY_PRICE DESC

; 


![10_least](https://user-images.githubusercontent.com/90646142/136613557-49ea6869-7b8e-4772-be8b-ef0d84fa17b3.png)

## Using GREATEST function to replace the unit price of all the products with the price below 50 USD

SELECT *,

GREATEST (50, unit_price) AS INFLATION_PRICE

FROM fact_sales f

join invoice i on f.invoice_id = i.invoice_id

join customer c on f.customer_id = c.customer_id

join location l on f.location_id = l.location_id

ORDER BY INFLATION_PRICE ASC

; 

![11_GREATEST](https://user-images.githubusercontent.com/90646142/136613559-694c704c-a437-4581-81cf-91b0012b4b23.png)

## USING DISTINCT function to find the unique values for the unit price

SELECT distinct unit_price

FROM fact_sales;

![12_distinct](https://user-images.githubusercontent.com/90646142/136613560-4bb4b18e-2be4-4cd0-9a54-0c9ad92c2f10.png)

