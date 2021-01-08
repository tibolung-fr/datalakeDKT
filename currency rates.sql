select cur_idr_currency_base, cur_idr_currency_restit, count(hde_share_price), avg(hde_share_price) as hde_share_price_moy
from
(select
cpt_idr_cur_price, 
cur_idr_currency_base,
cur_idr_currency_restit,
hde_share_price,
--count(hde_share_price) 
hde_effect_date, hde_end_date, system_date, rs_technical_date
from cds.f_currency_exchange
where date(system_date) = date(GETDATE())
and cpt_idr_cur_price = 6
and cur_idr_currency_restit = 32
--group by 1,2,3
)
group by 1,2
