
with RR as
(
select sku_idr_sku, 
mdl_idr_model, 
mdl_num_model_r3, 
mdl_label, 
product_nature_label,
 unv_label,
 dpt_label,   
 sdp_label,
-- family_label
sku_num_sku_r3, 
sku_ean_num 
from cds.d_sku
where brd_label_brand = 'ROCKRIDER' 
)

select distinct mdl_idr_model, 
mdl_num_model_r3, 
mdl_label, 
product_nature_label,
 unv_label,
 dpt_label,   
 sdp_label,
-- family_label,
spi.* 
from RR as r
inner join ODS.SPI_SPORT_TREE as spi
on r.mdl_num_model_r3 = spi.model_code_r3
where spi.locale = 'fr_FR' and 
spi.season_year >= 2020 and
--mdl_label like '%5%' and /*186 codes*/
mdl_label like '%9%' and /*82 codes*/
mdl_label not like '%100%'
