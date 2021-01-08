

select --top 10
--lab_idr_label	,
sku_num_sku_r3,	
--lat_short_label,	
--lat_long_label	,
mdl_num_model_r3,	
sku_ean_num	,
--lab_idr_label_mdl,	
mdl_label	,
grid_size	,
ipd_net_weight,	
ipd_gross_weight,	
ipd_weight_unit	,
ipd_width	,
ipd_height,	
ipd_length,	
ipd_dimension_unit
from CDS.D_SKU
where sku_num_sku_r3 in ('2972509',
'2843881',
'2864411'
)
