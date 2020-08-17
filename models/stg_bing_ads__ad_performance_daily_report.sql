with base as (

    select *
    from {{ source('bing_ads','ad_performance_daily_report')}}

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

), surrogate_key as (

    select 
        *,
        {{ dbt_utils.surrogate_key(['ad_id','date_day']) }} as daily_ad_id
    from fields

)

select *
from surrogate_key