{{ config(materialized = 'view', schema = 'reporting') }}

select c.companyname,
       c.contactname,
       c.city,
       sum(o.LINESALEAMOUNT) total_linesamount,
       sum(o.quantity) total_quantity,
       avg(o.margin) average_margin
from {{ref('dim_customers')}} c 
left join {{ref('fct_orders')}} o on c.customerid = o.customerid
where c.city= {{var('vcity',"London")}} --'London'
group by c.companyname,c.contactname,c.city
order by c.companyname,c.contactname,c.city