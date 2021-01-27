with transactions as 
(
select * from cds.f_transaction_detail
where date(tdt_date_to_ordered) >= '2019-01-01' 
and date(tdt_date_to_ordered) < '2020-01-01' 
)

select --top 1500 
date(t.tdt_date_to_ordered) as date, 

/*info mag*/
t.but_idr_business_unit, 
bu.but_name_business_unit as nom_mag,
bu.but_num_business_unit	as code_mag,	
bu.but_num_typ_but,
bu.cnt_country_code,
t.the_to_type, 

/*info produit*/
/*
t.sku_idr_sku,
--sku.fam_idr_family,
sku.fam_num_family,
sku.family_label, 

--sku.unv_idr_univers, 
--sku.unv_num_univers,
--sku.unv_label,
*/

--sku.dpt_idr_department,
--sku.dpt_num_department, 
--sku.dpt_label, 
case when sku.dpt_num_department in ('133',
'165',
'516',
'170',
'164',
'417',
'535',
'537') then 'CYCLING' 
when  sku.dpt_num_department in ('442',
'127',
'521',
'126') then 'OUTDOOR'
when sku.dpt_num_department in ('128',
'400') then 'RUNNING'
end as UNIVERS_AT,

--sku.product_nature_label,

/*KPI*/
count(distinct t.the_transaction_id) as nb_tickets,
--count(t.the_transaction_id) as nb_contacts,
sum(t.f_to_tax_in)	as CAttc 
 FROM transactions/*cds.f_transaction_detail_current*/ as t
inner join cds.d_business_unit as bu
on t.but_idr_business_unit = bu.but_idr_business_unit
inner join CDS.D_SKU as sku
on t.sku_idr_sku = sku.sku_idr_sku

where t.cnt_idr_country = 66
and t.the_to_type = 'offline' 
--and date(t.tdt_date_to_ordered) >= '2020-01-01' 
and sku.dpt_num_department in ('133',
'165',
'516',
'170',
'164',
'417',
'535',
'537',
'442',
'127',
'521',
'126',
'128',
'400')

group by 1,2,3,4,5,6,7,8--,9,10,11--,12,13,14

/*
select * from 
cds.d_country
 where cnt_country_code = 'FR'

select top 1000 * from cds.d_business_unit
where cnt_country_code = 'FR'
and but_num_typ_but = 7
*/
