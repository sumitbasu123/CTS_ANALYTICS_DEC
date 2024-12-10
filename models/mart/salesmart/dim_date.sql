{{config(materialized = 'view',schema = 'salesmart')}}

{% set min_orderdate = get_minimun_orderdate() %}
{% set max_orderdate = get_maximum_orderdate() %}

{{dbt_date.get_date_dimension(min_orderdate,max_orderdate)}}