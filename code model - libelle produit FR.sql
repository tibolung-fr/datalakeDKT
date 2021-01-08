
with LABEL as (
      select lab_idr_label, 
      lat_long_label,
      --lat_short_label 
      from CDS.D_LABEL_TRANSLATION
      where --lab_idr_label = '23218504' and
      lan_code_langue_lan = 'FR'
      and lat_date_creation >= '2020-01-01'
      )
      

    select distinct
    --top 10 
     --count(*)
    --sku_idr_sku,
    sku.mdl_num_model_r3,
    --sku.lab_idr_label_mdl, 
    lab.*
    from CDS.D_SKU as sku
    inner join LABEL as lab
    on sku.lab_idr_label_mdl = lab.lab_idr_label
    where sku_date_creation >= '2020-01-01'
    and mdl_num_model_r3 is not null
    and lab_idr_label_mdl is not null
    --and sku_idr_sku is not null
    
    

