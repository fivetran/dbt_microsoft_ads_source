{{ config(enabled=var('ad_reporting__microsoft_ads_enabled', True)) }}

with base as (

    select * 
    from {{ ref('stg_microsoft_ads__campaign_daily_report_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_microsoft_ads__campaign_daily_report_tmp')),
                staging_columns=get_campaign_daily_report_columns()
            )
        }}
        
    from base
),

final as (
    
    select 
        date as date_day,
        account_id,
        campaign_id,
        currency_code,
        device_os,
        device_type,
        network,
        ad_distribution,
        bid_match_type,
        delivered_match_type,
        top_vs_other,
        budget_association_status,
        clicks,
        impressions,
        spend

        {{ fivetran_utils.fill_pass_through_columns('microsoft_ads__campaign_passthrough_metrics') }}
    from fields
)

select * 
from final
