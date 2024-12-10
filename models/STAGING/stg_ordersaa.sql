{{ config(materialized = 'incremental' , unique_key = 'orderid', schema = env_var('DBT_STAGESCHEMA','STAGE_DBT')) }}

select * from {{ source('qwt_raw','orders') }}

{% if is_incremental() %}

    --this is filter incremental data
    where orderdate > (select max(orderdate) from {{ this }})

{% endif %}