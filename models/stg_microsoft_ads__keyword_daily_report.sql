{{ config(enabled=var('ad_reporting__microsoft_ads_enabled', True)) }}

with base as (

    select * 
    from {{ ref('stg_microsoft_ads__keyword_daily_report_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_microsoft_ads__keyword_daily_report_tmp')),
                staging_columns=get_keyword_daily_report_columns()
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
        keyword_id,
        currency_code,
        device_os,
        device_type,
        network,
        language,
        ad_distribution,
        bid_match_type,
        delivered_match_type,
        top_vs_other,
        coalesce(clicks, 0) as clicks, 
        coalesce(impressions, 0) as impressions,
        coalesce(spend, 0) as spend,
        coalesce(coalesce(conversions_qualified, conversions), 0) as conversions,
        coalesce(revenue, 0) as conversions_value,
        coalesce(coalesce(all_conversions_qualified, all_conversions), 0) as all_conversions,
        coalesce(all_revenue, 0) as all_conversions_value

        {{ microsoft_ads_fill_pass_through_columns(pass_through_fields=var('microsoft_ads__keyword_passthrough_metrics'), except=['conversions_qualified', 'conversions', 'revenue', 'all_conversions_qualified', 'all_conversions', 'all_revenue']) }}
    
    from fields
)

select * 
from final
