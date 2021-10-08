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
       

![01_dupe_1](https://user-images.githubusercontent.com/90646142/136598742-bca18bd8-b296-4526-b770-47176a518cb9.png)

## method 2: finding duplicates in table: fact_sales using Common Table Expression
             
WITH CTE as 

(  
   SELECT*, ROW_NUMBER() over (PARTITION BY invoice_id ORDER BY invoice_id) as Duplicates  
   FROM fact_sales  
)  

SELECT * FROM CTE

WHERE Duplicates > 1;


![02_dupe_2](https://user-images.githubusercontent.com/90646142/136598746-d5c9bd1d-42ac-44cb-a64b-f6126831e30e.png)

## method 3: finding duplicates in table: fact_sales using ROW_MUMBER function
   
   SELECT * FROM (SELECT *, ROW_NUMBER() over (PARTITION BY invoice_id ORDER BY invoice_id) as Duplicates  
   
   FROM fact_sales) as temp_table 
   
   WHERE Duplicates >= 1;
 


![03_dupe_3](https://user-images.githubusercontent.com/90646142/136598748-363ec9a4-8961-40dc-bfc9-a2c94e7b12e8.png)

## Deliting duplicates from table: fact_sales using the ROW_NUMBER() Function 

 DELETE FROM fact_sales WHERE fact_id IN(
 
   SELECT fact_id FROM (SELECT fact_id, ROW_NUMBER() 
   over (PARTITION BY invoice_id ORDER BY invoice_id) as Duplicates
   
   FROM fact_sales) AS temp_table 
   
   WHERE Duplicates >1
   
   );
    
  ![04_dupe_delete](https://user-images.githubusercontent.com/90646142/136598749-097b2919-e950-4262-99a5-370b3119770f.png)
  
 ## Double cheking for dupliactes after running the delete script using Common Table Expression
 
  WITH CTE as  

(  
   SELECT*, ROW_NUMBER() over (PARTITION BY invoice_id ORDER BY invoice_id) as Duplicates  
   FROM fact_sales  

)  

SELECT * FROM CTE

WHERE Duplicates > 1;
  
![05_dupe_delete_check](https://user-images.githubusercontent.com/90646142/136598752-feed06bb-22ef-47f2-aa20-82affaab52ae.png)

 ## Double cheking for dupliactes after running the delete script using ROW_MUMBER function
 
 SELECT * FROM (SELECT *, ROW_NUMBER() over (PARTITION BY invoice_id ORDER BY invoice_id) as Duplicates  
   
   FROM fact_sales) as temp_table 
   
   WHERE Duplicates >= 1;
   
             
![06_dupe_delete_check2](https://user-images.githubusercontent.com/90646142/136598754-a30385a9-c653-46ed-aece-615596d991a6.png)

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

![07_case_when_f](https://user-images.githubusercontent.com/90646142/136598755-3e1f9925-b2fc-434e-9cd7-ab2376f54961.png)

## replacing NULL value with the 'No membership' value in table: customer with a COALESCE function

SELECT* from customer;

SELECT* from customer

WHERE membership is null;

SELECT *,

COALESCE (membership, 'NO MEMBERSHIP') as `UNDEFINED`

from customer;

![08_coalesce_f](https://user-images.githubusercontent.com/90646142/136598757-4038471f-0878-4018-873a-e418602bde54.png)

## USING NULLIF function to substitute the 'Sports and travel' product line in table: fact_sales with `NULL`

SELECT *,

NULLIF (product_line, 'Sports and travel') AS NULLIFIED

FROM fact_sales f

join invoice i on f.invoice_id = i.invoice_id

join customer c on f.customer_id = c.customer_id

join location l on f.location_id = l.location_id

ORDER BY NULLIFIED ASC

;

![09_nullif](https://user-images.githubusercontent.com/90646142/136598758-ba469d18-071f-4a66-b9a8-bd0f9d8652ff.png)

## Using LEAST function to replace the unit price of all the products with the price above 30 USD

SELECT *,

LEAST (30, unit_price) AS HAPPY_PRICE

FROM fact_sales f

join invoice i on f.invoice_id = i.invoice_id

join customer c on f.customer_id = c.customer_id

join location l on f.location_id = l.location_id

ORDER BY HAPPY_PRICE DESC

; 


![10_least](https://user-images.githubusercontent.com/90646142/136598760-667e337c-8908-499a-833e-83bf8241df22.png)

## Using GREATEST function to replace the unit price of all the products with the price below 50 USD

SELECT *,

GREATEST (50, unit_price) AS INFLATION_PRICE

FROM fact_sales f

join invoice i on f.invoice_id = i.invoice_id

join customer c on f.customer_id = c.customer_id

join location l on f.location_id = l.location_id

ORDER BY INFLATION_PRICE ASC

; 

![11_GREATEST](https://user-images.githubusercontent.com/90646142/136598761-b1d17a55-3eb4-44bb-96e4-89c4d52d4e86.png)

## USING DISTINCT function to find the unique values for the unit price

SELECT distinct unit_price

FROM fact_sales;

![12_distinct](https://user-images.githubusercontent.com/90646142/136598763-7127b9fc-75ab-4543-a8a8-a4cebc57881c.png)
