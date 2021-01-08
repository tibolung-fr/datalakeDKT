select
--top 10 *
 --count(*)
sku_num_sku_r3,
mdl_num_model_r3
/*lab_idr_label_mdl,
mdl_label*/
--brd_label_brand, 
--brd_type_brand_libelle
from CDS.D_SKU
where sku_date_creation >= '2020-01-01'
and mdl_num_model_r3 is not null
and sku_idr_sku is not null
--and mdl_num_model_r3 in ('8575763')
--where mdl_num_model_r3 in ('8575763')

--select top 10 * from ODS.SPI_CATALOG

--2961509 8575763   23218504


