{{ config(materialized = 'table', schema = 'transforming') }}

select
emp.empid,emp.LastName,emp.FirstName,emp.title,emp.HireDate,emp.Extension,
iff(mgr.FirstName is NULL,emp.FirstName,mgr.FirstName) as mgr,
emp.YearSalary,off.OfficeCity,off.OfficeCountry
from {{ref('stg_employee')}} as emp
left join {{ref('stg_employee')}} as mgr on emp.ReportsTo = mgr.empid
inner join {{ref('lkp_office')}} as off on emp.office = off.office
