    -- 1/ Données de ventes avec code pays, devise, offline online, marque, libelle marque, ca, date jour
      select
      a.date,
      a.code_pays,
      c.cnt_country_code, 
      c.cnt_country_code_3a,
      a.cur_idr_currency,
      b.cur_code_currency,
      b.cur_display_code,
      --cur_idr_currency_base, 
      --cur_idr_currency_restit,
      --cur.hde_share_price_moy,
      a.the_to_type,
      --a.sku_idr_sku,
      --d.mdl_num_model_r3,
      d.brd_label_brand, 
      d.brd_type_brand_libelle,
      sum(a.CA) as CA
      --sum(a.CA)*cur.hde_share_price as CA_euro 
      from (
        SELECT 
        date(tdt_date_to_ordered) as date,
        --tdt_date_to_ordered as date_commande,
        --tdt_date_to_returned as date_retour,
        --the_transaction_id as transaction_id,
        cnt_idr_country as code_pays,
        --sku_idr_sku,
        cur_idr_currency,
        --cct_idr_customer_channel_type,
        --ctt_idr_customer_type,
        the_to_type,  
        --tcn_idr_transaction_channel_type,
        sku_idr_sku,
        sum(f_to_tax_in) as CA
        FROM cds.f_transaction_detail_current as a
        where date >= '2020-10-01' and date <= '2020-10-13'
        group by 1,2,3,4,5
        ) as a
      inner join cds.d_currency as b
      on a.cur_idr_currency = b.cur_idr_currency  
      inner join cds.d_country as c
      on a.code_pays = c.cnt_idr_country
      inner join CDS.D_SKU as d 
      on a.sku_idr_sku = d.sku_idr_sku
      --where c.cnt_country_code = 'FR'
      group by 1,2,3,4,5,6,7,8,9,10
      --order by cur_idr_currency

      

