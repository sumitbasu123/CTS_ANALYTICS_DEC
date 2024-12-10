{{ config(materialized = 'table', schema = 'transforming') }}

select 
TO_CHAR(GET(XMLGET(supplierinfo,'SupplierID'), '$')) as SupplierID,
TO_CHAR(GET(XMLGET(supplierinfo,'CompanyName'), '$')) as CompanyName,
TO_CHAR(GET(XMLGET(supplierinfo,'ContactName'), '$')) as ContactName,
TO_CHAR(GET(XMLGET(supplierinfo,'Address'), '$')) as Address,
TO_CHAR(GET(XMLGET(supplierinfo,'City'), '$')) as City,
TO_CHAR(GET(XMLGET(supplierinfo,'PostalCode'), '$')) as PostalCode,
TO_CHAR(GET(XMLGET(supplierinfo,'Country'), '$')) as Country,
TO_CHAR(GET(XMLGET(supplierinfo,'Phone'), '$')) as Phone,
TO_CHAR(GET(XMLGET(supplierinfo,'Fax'), '$')) as Fax
from {{ref('stg_suppliers')}}