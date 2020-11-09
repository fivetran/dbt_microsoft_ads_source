with base as (

    select *
    from {{ var('ad_performance_daily_report')}}

), fields as (

    select 
        date as date_day,
        account_id,
        campaign_id,
        ad_group_id,
        ad_id,
        currency_code,
        clicks,
        impressions,
        spend
    from base

)

select *
from fields