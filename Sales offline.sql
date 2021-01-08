SELECT TOP 1000 --but.but_num_business_unit
 sum(tdt.f_to_tax_in)
, sum(tdt.f_to_tax_ex)
, sum(tdt.f_qty_item)
, sum(tdt.f_margin_estimate)
FROM cds.f_transaction_detail_current tdt
--inner join cds.d_sku sku on tdt.sku_idr_sku = sku.sku_idr_sku
inner join cds.d_business_unit but on tdt.but_idr_business_unit = but.but_idr_business_unit
where tdt.tdt_date_to_ordered between '2020-07-01 00:00:00' and '2020-07-31 23:59:59'
and the_to_type = 'offline'
--GROUP BY 1 
