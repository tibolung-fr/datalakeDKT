select 
sku_idr_sku,
mdl_num_model_r3,
brd_label_brand, 
brd_type_brand_libelle
from CDS.D_SKU
where UPPER(brd_label_brand) like '%VAN RYSEL%'
