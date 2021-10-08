## method 1: finding duplicates in table: fact_sales using Group BY and HAVING 

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
       

![01_dupe_1](https://user-images.githubusercontent.com/90646142/136609539-e9d99c8f-d960-43b8-8f68-a9a30d05d9e9.png)

## method 2: finding duplicates in table: fact_sales using Common Table Expression
             
WITH CTE as 

(  
   SELECT*, ROW_NUMBER() over (PARTITION BY invoice_id ORDER BY invoice_id) as Duplicates  
   FROM fact_sales  
)  

SELECT * FROM CTE

WHERE Duplicates > 1;


![02_dupe_2](https://user-images.githubusercontent.com/90646142/136609542-125e3a4c-aad2-4924-9f99-5137af74af11.png)

## method 3: finding duplicates in table: fact_sales using ROW_MUMBER function
   
   SELECT * FROM (SELECT *, ROW_NUMBER() over (PARTITION BY invoice_id ORDER BY invoice_id) as Duplicates  
   
   FROM fact_sales) as temp_table 
   
   WHERE Duplicates >= 1;
 


![03_dupe_3](https://user-images.githubusercontent.com/90646142/136609544-612a1901-0213-497f-baef-51886e737fb4.png)

## Deliting duplicates from table: fact_sales using the ROW_NUMBER() Function 

 DELETE FROM fact_sales WHERE fact_id IN(
 
   SELECT fact_id FROM (SELECT fact_id, ROW_NUMBER() 
   over (PARTITION BY invoice_id ORDER BY invoice_id) as Duplicates
   
   FROM fact_sales) AS temp_table 
   
   WHERE Duplicates >1
   
   );
    
  ![04_dupe_delete](https://user-images.githubusercontent.com/90646142/136609545-bd8b88c7-1929-436e-8481-98c57c396083.png)
  
 ## Double cheking for dupliactes after running the delete script using Common Table Expression
 
  WITH CTE as  

(  
   SELECT*, ROW_NUMBER() over (PARTITION BY invoice_id ORDER BY invoice_id) as Duplicates  
   FROM fact_sales  

)  

SELECT * FROM CTE

WHERE Duplicates > 1;
  
![05_dupe_delete_check](https://user-images.githubusercontent.com/90646142/136609546-d5d1b308-acfb-4e63-818a-6bec46e9510d.png)

 ## Double cheking for dupliactes after running the delete script using ROW_MUMBER function
 
 SELECT * FROM (SELECT *, ROW_NUMBER() over (PARTITION BY invoice_id ORDER BY invoice_id) as Duplicates  
   
   FROM fact_sales) as temp_table 
   
   WHERE Duplicates >= 1;
   
             
![06_dupe_delete_check2](https://user-images.githubusercontent.com/90646142/136609548-3ec3fdca-cdd1-4856-9e09-759b73e93fb2.png)

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

![07_case_when_f](https://user-images.githubusercontent.com/90646142/136609550-0be486a0-35d9-4390-bae3-7056e30e2834.png)

## replacing NULL value with the 'No membership' value in table: customer with a COALESCE function

SELECT* from customer;

SELECT* from customer

WHERE membership is null;

SELECT *,

COALESCE (membership, 'NO MEMBERSHIP') as `UNDEFINED`

from customer;

![08_coalesce_f](https://user-images.githubusercontent.com/90646142/136609552-fd8b92ee-0342-476f-b577-08b3ee27ee31.png)

## USING NULLIF function to substitute the 'Sports and travel' product line in table: fact_sales with `NULL`

SELECT *,

NULLIF (product_line, 'Sports and travel') AS NULLIFIED

FROM fact_sales f

join invoice i on f.invoice_id = i.invoice_id

join customer c on f.customer_id = c.customer_id

join location l on f.location_id = l.location_id

ORDER BY NULLIFIED ASC

;

![09_nullif](https://user-images.githubusercontent.com/90646142/136609554-5d54087e-c69f-49e3-8f6a-744fb0914209.png)

## Using LEAST function to replace the unit price of all the products with the price above 30 USD

SELECT *,

LEAST (30, unit_price) AS HAPPY_PRICE

FROM fact_sales f

join invoice i on f.invoice_id = i.invoice_id

join customer c on f.customer_id = c.customer_id

join location l on f.location_id = l.location_id

ORDER BY HAPPY_PRICE DESC

; 


![10_least](https://user-images.githubusercontent.com/90646142/136609555-78108cfd-5e26-4369-88bc-556da7163335.png)

## Using GREATEST function to replace the unit price of all the products with the price below 50 USD

SELECT *,

GREATEST (50, unit_price) AS INFLATION_PRICE

FROM fact_sales f

join invoice i on f.invoice_id = i.invoice_id

join customer c on f.customer_id = c.customer_id

join location l on f.location_id = l.location_id

ORDER BY INFLATION_PRICE ASC

; 

![11_GREATEST](https://user-images.githubusercontent.com/90646142/136609556-87df90a2-49de-46a5-b2f3-ce4577861827.png)

## USING DISTINCT function to find the unique values for the unit price

SELECT distinct unit_price

FROM fact_sales;

![12_distinct](https://user-images.githubusercontent.com/90646142/136609557-b69bc193-936c-41cf-9915-dd839b7ebc7b.png)

