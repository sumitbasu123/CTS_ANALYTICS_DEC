--min date macro
{% macro get_minimun_orderdate() -%}

{% set get_min_orderdate %}

select min(orderdate)
from {{ ref('fct_orders') }}
order by 1

{% endset %} 
{% set results = run_query(get_min_orderdate) %} 
{% if execute %}
{# Return the first column #}
{% set results_list = results.columns[0][0] %}
{% else %}
{% set results_list = [] %}
{% endif %}
{{ return(results_list) }}
 
{%- endmacro %}

---max date macro
{% macro get_maximum_orderdate() -%}

{% set get_max_orderdate %}

select max(orderdate)
from {{ ref('fct_orders') }}
order by 1

{% endset %} 
{% set results = run_query(get_max_orderdate) %} 
{% if execute %}
{# Return the first column #}
{% set results_list = results.columns[0][0] %}
{% else %}
{% set results_list = [] %}
{% endif %}
{{ return(results_list) }}
 
{%- endmacro %}
