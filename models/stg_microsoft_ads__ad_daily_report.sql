ADD source_relation WHERE NEEDED + CHECK JOINS AND WINDOW FUNCTIONS! (Delete this line when done.)

{{ config(enabled=var('ad_reporting__microsoft_ads_enabled', True)) }}

with base as (

    select * 
    from {{ ref('stg_microsoft_ads__ad_daily_report_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_microsoft_ads__ad_daily_report_tmp')),
                staging_columns=get_ad_daily_report_columns()
            )
        }}

    
        {{ fivetran_utils.source_relation(
            union_schema_variable='microsoft_ads_union_schemas', 
            union_database_variable='microsoft_ads_union_databases') 
        }}

    from base
),

final as (

    select
        source_relation, 
        date as date_day,
        account_id,
        campaign_id,
        ad_group_id,
        ad_id,
        currency_code,
        device_os,
        device_type,
        network,
        language,
        ad_distribution,
        bid_match_type,
        delivered_match_type,
        top_vs_other,
        clicks,
        impressions,
        spend

        {{ fivetran_utils.fill_pass_through_columns('microsoft_ads__ad_passthrough_metrics') }}
    from fields
)

select * 
from final
