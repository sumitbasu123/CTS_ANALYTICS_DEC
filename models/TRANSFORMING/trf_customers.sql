{{ config(materialized = 'table', schema = 'transforming') }}

select c.customerid,
       c.COMPANYNAME,
       c.CONTACTNAME,
       c.CITY,
       c.COUNTRY,
       d.Divisionname,
       c.ADDRESS,
       c.FAX,
       c.POSTALCODE,
       c.PHONE,
       IFF(C.state = '', 'NA', C.state) AS STATENAME

 from {{ref('stg_customers')}} as c
 inner join {{ref('lkp_division')}} as d on c.DIVISIONID = d.DivisionId