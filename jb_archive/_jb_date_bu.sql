select 
but_idr_business_unit,
but_creation_date,
date(GETDATE())-date(but_creation_date) as age_jour_transaction
floor((date(GETDATE())-date(but_creation_date))/365.25 as age_transaction
from CDS.D_BUSINESS_UNIT
