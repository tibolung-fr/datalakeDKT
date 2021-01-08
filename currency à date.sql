-- 2/ récupérer les TAUX sur les date_restit les plus récentes de chaque couple de currency

select a.*,
b.hde_end_date,
b.hde_share_price
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
  
