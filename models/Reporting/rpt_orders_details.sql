{{ config(materialized = 'view', schema = 'reporting') }}


select d.companyname,
       d.contactname,
       min(f.orderdate) as first_order_date,
       max(f.orderdate) as recent_order_date,
       count(f.orderid) as orders_count,
       sum(f.linesaleamount) as sales,
       avg(f.margin) as avg_margin
from {{ref('dim_customers')}} d 
left join {{ref('fct_orders')}} f on f.customerid = d.customerid
group by d.companyname,d.contactname