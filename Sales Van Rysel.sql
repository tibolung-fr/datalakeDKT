with VRysel as 
(select 
sku_idr_sku,
mdl_num_model_r3,
brd_label_brand, 
brd_type_brand_libelle
from CDS.D_SKU
where UPPER(brd_label_brand) like '%VAN RYSEL%'
)


SELECT TOP 1000 tdt.sku_idr_sku
, sum(tdt.f_to_tax_in) as ca_ttc
, sum(tdt.f_to_tax_ex) as ca_ht
, sum(tdt.f_qty_item) as qte
, sum(tdt.f_margin_estimate) as margin
, min(tdt.tdt_date_to_ordered) as date_1er_achat
, max(tdt.tdt_date_to_ordered) as date_last_achat
FROM cds.f_transaction_detail_current tdt
inner join VRysel as VRysel on tdt.sku_idr_sku = VRysel.sku_idr_sku 
--inner join cds.d_sku sku on tdt.sku_idr_sku = sku.sku_idr_sku
--inner join cds.d_business_unit but on tdt.but_idr_business_unit = but.but_idr_business_unit
--where tdt.tdt_date_to_ordered between '2020-07-01 00:00:00' and '2020-07-31 23:59:59'
--and the_to_type = 'offline'
GROUP BY 1 
--where tdt.tdt_date_to_ordered between '2020-07-01 00:00:00' and '2020-07-31 23:59:59'
