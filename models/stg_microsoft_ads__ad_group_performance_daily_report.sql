
with base as (

    select * 
    from {{ ref('stg_microsoft_ads__ad_group_performance_daily_report_tmp') }}

),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_microsoft_ads__ad_group_performance_daily_report_tmp')),
                staging_columns=get_ad_group_performance_daily_report_columns()
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
        currency_code,
        device_os,
        device_type,
        language,
        network,
        clicks,
        impressions,
        spend
    from fields
)

select * from final
