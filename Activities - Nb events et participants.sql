/* Nb events et Nb participants au compte de TrainMe organizer_id = 'd0898e63-1246-4a29-88fc-610a0ba2639' , 'eecefe26-251a-4721-a780-6f220ed47ff7' */
--with events as 
(select 
event_id,
--parent,  
--status, 
--title, 
--description, 
sport_id,
sport_id_masterdata, 
  tenant_name as site_pays,
  case when upper(title) like '%LIVE%' 
  or upper(title) like '%REPLAY%' 
  or upper(title) like '%VISIO%'
  or upper(title) like '%VIDEO%'
  then 'VISIO' else 'PHYSIQUE' end as TYPE_EVENT,
end_date as date, 
case when end_date > GETDATE() then 'UPCOMING' else 'ACHIEVED' end as ETAT_EVENT,
subscribers_limit as NB_CAPACITE_PART,
subscribers_count as NB_PARTICIPANTS,
cast(subscribers_count as float)/ cast(subscribers_limit as float)*100 as TX_REMPLISSAGE,
--organizer_id,
price_display
from ods_retail.act_events
where organizer_id in ('eecefe26-251a-4721-a780-6f220ed47ff7','d0898e63-1246-4a29-88fc-610a0ba2639')
--and event_id = 99910
and status = 'PUBLISHED'
and parent <> event_id
)

/* exclure les parent = envent_id pour ne pas avoir les lignes mères */
/* taux de remplissage = count / limit (subscribers) , case when pour exclure les limit=0 */

/*title like '%live% '%replay%' pour avoir les visio '%video%' '%visio%' */
/*sport_id pour le sport associé à l'évènement */
/*tenant_name : pays de création de l'évènement lié au site*/


/*
select --date, 
count(event_id),
sum(nb_capacite_part) as nb_capacite, 
sum(nb_participants) as nb_participants 
from events
where etat_event = 'ACHIEVED'
--group by date
--order by date desc
*/

