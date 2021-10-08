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
  
![05_dupe_delete_check](https://user-images.githubusercontent.com/90646142/136598752-feed06bb-22ef-47f2-aa20-82affaab52ae.png)

 ## Double cheking for dupliactes after running the delete script using ROW_MUMBER function
             
![06_dupe_delete_check2](https://user-images.githubusercontent.com/90646142/136598754-a30385a9-c653-46ed-aece-615596d991a6.png)
![07_case_when_f](https://user-images.githubusercontent.com/90646142/136598755-3e1f9925-b2fc-434e-9cd7-ab2376f54961.png)
![08_coalesce_f](https://user-images.githubusercontent.com/90646142/136598757-4038471f-0878-4018-873a-e418602bde54.png)
![09_nullif](https://user-images.githubusercontent.com/90646142/136598758-ba469d18-071f-4a66-b9a8-bd0f9d8652ff.png)
![10_least](https://user-images.githubusercontent.com/90646142/136598760-667e337c-8908-499a-833e-83bf8241df22.png)
![11_GREATEST](https://user-images.githubusercontent.com/90646142/136598761-b1d17a55-3eb4-44bb-96e4-89c4d52d4e86.png)
![12_distinct](https://user-images.githubusercontent.com/90646142/136598763-7127b9fc-75ab-4543-a8a8-a4cebc57881c.png)
