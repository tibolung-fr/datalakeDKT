with bu_age as (
  select top 100
    but_idr_business_unit,
    (case 
      when Floor(MONTHS_BETWEEN(GETDATE(),but_creation_date))>36 then 37
      when Floor(MONTHS_BETWEEN(GETDATE(),but_creation_date))<=36 then Floor(MONTHS_BETWEEN(GETDATE(),but_creation_date))
    end) as age_bu_in_months
  from CDS.D_BUSINESS_UNIT)
  
select * from bu_age
