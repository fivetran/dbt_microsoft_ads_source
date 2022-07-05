
with base as (

    select * 
    from {{ ref('stg_microsoft_ads__campaign_performance_daily_report_tmp') }}

),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_microsoft_ads__campaign_performance_daily_report_tmp')),
                staging_columns=get_campaign_performance_daily_report_columns()
            )
        }}
        
    from base
),

final as (
    
    select 
        account_id,
        campaign_id,
        currency_code,
        device_type,
        network,
        clicks,
        impressions,
        spend
    from fields
)

select * from final
