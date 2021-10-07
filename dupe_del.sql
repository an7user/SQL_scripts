-- simple duplicates lookup

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
       
     --  simple select with * for duplicates 
       
       SELECT *, 
COUNT(*) AS CNT
FROM
    fact_sales f
    GROUP BY 
    gross_income, gross_margin_percentage, quantity, unit_price
       HAVING COUNT(*) > 1;
       
       -- / CTE finding duplicates /
              
WITH CTE as  
(  
   SELECT*, ROW_NUMBER() over (PARTITION BY invoice_id ORDER BY invoice_id) as Duplicates  
   FROM fact_sales  
)  
SELECT * FROM CTE
WHERE Duplicates > 1;


-- ROW_MUMBER function select
   
   SELECT * FROM (SELECT *, ROW_NUMBER() over (PARTITION BY invoice_id ORDER BY invoice_id) as Duplicates  
   FROM fact_sales) as temp_table WHERE Duplicates >= 1;
 
--  Deliting duplicates Using the ROW_NUMBER() Function 

 DELETE FROM fact_sales WHERE fact_id IN(
   SELECT fact_id FROM (SELECT fact_id, ROW_NUMBER() 
   over (PARTITION BY invoice_id ORDER BY invoice_id) as Duplicates  
   FROM fact_sales) AS temp_table WHERE Duplicates >1
   );
    
  
