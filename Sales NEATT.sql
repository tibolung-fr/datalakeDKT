with neatt as 
(
select 
sku_num_sku_r3 as code_article,	
mdl_num_model_r3 as code_model,	
mdl_idr_model, 
sku_ean_num,
sku_idr_sku, 

brd_label_brand, 
brd_num_brand,
sku_date_creation,

lab_idr_label_mdl,
mdl_label, 

product_nature_label, 

fam_idr_family, 
fam_num_family, 
family_label, 

sdp_idr_sub_department, 
sdp_num_sub_department,
sdp_label, 

dpt_idr_department, 
dpt_num_department, 
dpt_label,

unv_idr_univers,
unv_num_univers,
unv_label 

from CDS.D_SKU
where brd_label_brand in ('NEATT')
)


SELECT tdt.sku_idr_sku
,tdt.tdt_date_to_ordered as date_vente
, sum(tdt.f_to_tax_in) as ca_ttc
, sum(tdt.f_to_tax_ex) as ca_ht
, sum(tdt.f_qty_item) as qte
, sum(tdt.f_margin_estimate) as margin
,neatt.*
--, min(tdt.tdt_date_to_ordered) as date_1er_achat
--, max(tdt.tdt_date_to_ordered) as date_last_achat
FROM cds.f_transaction_detail_current tdt
inner join neatt as neatt on tdt.sku_idr_sku = neatt.sku_idr_sku 
--inner join cds.d_sku sku on tdt.sku_idr_sku = sku.sku_idr_sku
--inner join cds.d_business_unit but on tdt.but_idr_business_unit = but.but_idr_business_unit
--where tdt.tdt_date_to_ordered between '2020-07-01 00:00:00' and '2020-07-31 23:59:59'
--and the_to_type = 'offline'
GROUP BY 1,2,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29 
--where tdt.tdt_date_to_ordered between '2020-07-01 00:00:00' and '2020-07-31 23:59:59'
