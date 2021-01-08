 
select *,
tdt_date_to_ordered_date - but_creation_date as age_jour_transac
year(tdt_date_to_ordered_date - but_creation_date) as transac_year
from 
       (SELECT TOP 100
        date(tdt_date_to_ordered) as tdt_date_to_ordered_date,
        --tdt_date_to_ordered as date_commande,
        --tdt_date_to_returned as date_retour,
        --the_transaction_id as transaction_id,
        cnt_idr_country as code_pays,
        --sku_idr_sku,
        cur_idr_currency,
        --cct_idr_customer_channel_type,
        --ctt_idr_customer_type,
        the_to_type,  
        --tcn_idr_transaction_channel_type,
        sku_idr_sku,
        but_idr_business_unit,
        sum(f_to_tax_in) as CA
        FROM cds.f_transaction_detail_current as a
        where tdt_date_to_ordered_date >= '2018-12-01' and tdt_date_to_ordered_date < '2021-01-01'
        group by 1,2,3,4,5,6) as transac


left join
  (select 
  but_idr_business_unit,
  but_creation_date
  --date(GETDATE())-date(but_creation_date) as age_jour_transaction
  from CDS.D_BUSINESS_UNIT) as bu

on transac.but_idr_business_unit = bu.but_idr_business_unit
        
