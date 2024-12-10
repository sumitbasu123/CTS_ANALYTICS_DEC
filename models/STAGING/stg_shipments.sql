{{ config(materialized = 'table' ,schema = env_var('DBT_STAGESCHEMA','STAGE_DBT'))}}

select 
OrderID,LineNo,ShipperID,CustomerID,ProductID,EmployeeID,
split_part(shipmentdate,' ', 0) shipmentdate,
Status
FROM {{source('qwt_raw','shipments')}}