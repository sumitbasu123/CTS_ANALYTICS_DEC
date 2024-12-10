{{ config(materialized = 'table' ,schema = env_var('DBT_STAGESCHEMA','STAGE_DBT'))}}

select 
EmpID,LastName,FirstName,Title,HireDate,Office,Extension,ReportsTo,YearSalary
FROM {{source('qwt_raw','employee')}}