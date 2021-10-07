-- method 1: finding duplicates in table: fact_sales using Group BY and HAVING 

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
      
      ![01_dupe_1](https://user-images.githubusercontent.com/90646142/136476523-3ef588a2-7dc8-4cca-859a-2815cbdf68fb.png)

          
     -- method 2: finding duplicates in table: fact_sales using Common Table Expression
             
WITH CTE as  
(  
   SELECT*, ROW_NUMBER() over (PARTITION BY invoice_id ORDER BY invoice_id) as Duplicates  
   FROM fact_sales  
)  
SELECT * FROM CTE
WHERE Duplicates > 1;


-- method 3: finding duplicates in table: fact_sales using ROW_MUMBER function
   
   SELECT * FROM (SELECT *, ROW_NUMBER() over (PARTITION BY invoice_id ORDER BY invoice_id) as Duplicates  
   FROM fact_sales) as temp_table WHERE Duplicates >= 1;
 
-- Deliting duplicates from table: fact_sales using the ROW_NUMBER() Function 

 DELETE FROM fact_sales WHERE fact_id IN(
   SELECT fact_id FROM (SELECT fact_id, ROW_NUMBER() 
   over (PARTITION BY invoice_id ORDER BY invoice_id) as Duplicates  
   FROM fact_sales) AS temp_table WHERE Duplicates >1
   );
    
  select * from fact_sales;     
