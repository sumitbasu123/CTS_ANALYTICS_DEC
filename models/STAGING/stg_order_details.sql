{{ config(materialized = 'incremental',unique_key =['orderid','lineno'],schema = env_var('DBT_STAGESCHEMA','STAGE_DBT')) }}

select od.*,o.orderdate
from {{source('qwt_raw','orders_details')}} as od
inner join {{source('qwt_raw','orders')}} as o
on od.orderid = o.orderid

{% if is_incremental() %}

    --this is filter incremental data
    where o.orderdate > (select max(orderdate) from {{ this }})

{% endif %}