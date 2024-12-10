{{ config(materialized = 'table' ,schema = env_var('DBT_STAGESCHEMA','STAGE_DBT'))}}

select *
FROM {{source('qwt_raw','suppliers_xml')}}
