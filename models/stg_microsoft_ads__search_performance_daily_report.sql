
with base as (

    select * 
    from {{ ref('stg_microsoft_ads__search_performance_daily_report_tmp') }}

),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_microsoft_ads__search_performance_daily_report_tmp')),
                staging_columns=get_search_query_performance_daily_report_columns()
            )
        }}
        
    from base
),

final as (
    
    select 
        date as date_day,
        account_id,
        campaign_id,
        ad_group_id,
        ad_id,
        bid_match_type,
        delivered_match_type,
        device_os,
        device_type,
        network,
        keyword_id,
        search_query,
        clicks,
        impressions,
        spend
    from fields
)

select * from final
