
/*BtoC*/
with recursive btoc as 
(
select 
date(invoice_date) as dates, /*à confirmer*/
count(distinct id_order) as nb_orders_B2C, 
sum(total_paid) as ca_B2C /*à confirmer*/
from orders o 
group by 1 
order by 1 desc
)

, 

btob as 
(
select date(created_at) as dates, /*à confirmer*/
status ,
deleted , 
count(event_id) as nb_events_B2B,
90*count(event_id) as ca_B2B /*à confirmer*/
from event e2 
group by 1,2,3
order by 1 desc
)

, 

coach as 
(
select 
date(date_add) as dates,
id_default_group,
count(id_customer) as nb_coach 
from customer c 
where id_default_group = 6
group by 1,2
order by 1  desc
)