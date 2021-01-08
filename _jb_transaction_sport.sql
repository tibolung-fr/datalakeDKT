/* Mis à jour 2020/11/27 10H00
Construction des tables 
Temps de requête : 20 minutes
*/

with 
transactions as (
  SELECT 
    date(tdt_date_to_ordered) as date_to_ordered,
    cnt_idr_country as code_pays,
    cur_idr_currency,
    sku_idr_sku,
    but_idr_business_unit,
    sum(f_to_tax_in) as CA
  FROM cds.f_transaction_detail --_current
    -- where date_to_ordered = '2020-03-01'
    where date_to_ordered >= '2019-01-01' and date_to_ordered < '2021-01-01'
    -- and code_pays = 66
  group by 1,2,3,4,5
), 
sports as ( 
   select
      sku_idr_sku,
      dpt_num_department,
      replace(dpt_label,',','-') as dpt_label
   from CDS.D_SKU
), 
bu_age as (
  select
    but_idr_business_unit,
    (case 
      when MONTHS_BETWEEN(CURRENT_DATE,but_creation_date)>36 then 99
      when (MONTHS_BETWEEN(CURRENT_DATE,but_creation_date)>24 and MONTHS_BETWEEN(CURRENT_DATE,but_creation_date)<=36) then 3
      when (MONTHS_BETWEEN(CURRENT_DATE,but_creation_date)>12 and MONTHS_BETWEEN(CURRENT_DATE,but_creation_date)<=24) then 2
      when MONTHS_BETWEEN(CURRENT_DATE,but_creation_date)<=12 then 1
      --when MONTHS_BETWEEN(CURRENT_DATE,but_creation_date)<=36 then Floor(MONTHS_BETWEEN(CURRENT_DATE,but_creation_date))
    end) as age_bu_in_years -- age_bu_in_months
  from CDS.D_BUSINESS_UNIT
),
currencies as (
   select a.cur_idr_currency_base,
     hde_share_price
      --a.*,
      --b.hde_end_date,
      --b.hde_share_price
    from 
    (     
    -- 1/ lister la date_restit la plus récente du TAUX pour chaque couple de currency
    select 
         cpt_idr_cur_price,
         cur_idr_currency_base,
         cur_idr_currency_restit, 
         --hde_share_price,
         max(hde_effect_date) as last_hde_effect_date 
         --hde_end_date
         --count(hde_share_price), avg(hde_share_price)
        from
        cds.f_currency_exchange
        where 
        cpt_idr_cur_price = 6 and
        cur_idr_currency_restit = 32 and 
        TO_CHAR(hde_effect_date, 'YYYY-MM-DD') <= date(GETDATE()) and
        TO_CHAR(hde_end_date, 'YYYY-MM-DD') >= date(GETDATE())
        group by 1,2,3
    ) as a
    left join cds.f_currency_exchange as b
    on a.cpt_idr_cur_price = b.cpt_idr_cur_price
      and a.cur_idr_currency_base = b.cur_idr_currency_base
      and a.cur_idr_currency_restit = b.cur_idr_currency_restit
      and a.last_hde_effect_date = b.hde_effect_date
), 

countries as (
  select cnt_idr_country,
    cnt_country_code_3a
    --cur_idr_currency
  from cds.d_country), 

/* 
Création de la jointure 
*/

table_sport_pays as (select *,
  (ca*hde_share_price) as ca_euro,
  date(date_trunc('month',date_to_ordered)) as month_to_ordered
from transactions as t
left join sports as s
on t.sku_idr_sku = s.sku_idr_sku 
left join bu_age as bu
on t.but_idr_business_unit = bu.but_idr_business_unit 
left join currencies as c
on t.cur_idr_currency = c.cur_idr_currency_base 
left join countries
on t.code_pays = countries.cnt_idr_country)


/* 
Restitution des résultats
*/
select month_to_ordered as Date_Mois_commande,
   cnt_country_code_3a as Pays,
   concat(dpt_num_department,  '-' + dpt_label) as Sport,
   age_bu_in_years as Age_BU_en_années,
   -- age_bu_in_months as Age_BU_en_mois,
   (sum(ca_euro))as CA_euro
from table_sport_pays
group by 1,2,3,4
