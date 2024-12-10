{{ config(materialized = 'view', schema = 'reporting') }}
{% set lineno = get_lineno() %}

select orderid,
{% for lno in lineno%}
sum(case when lineno = {{lno}} then linesaleamount end) as line{{lno}}_sales,
{%endfor%}
sum(linesaleamount) as total_sales
from {{ref('fct_orders')}}
group by orderid