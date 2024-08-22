{{ config(enabled=var('ad_reporting__microsoft_ads_enabled', True),
    unique_key = ['source_relation','date_day','account_id','campaign_id','ad_group_id','ad_id','keyword_id','device_os','device_type','network','language','currency_code','ad_distribution','bid_match_type','delivered_match_type','top_vs_other'],
    partition_by={
      "field": "date_day", 
      "data_type": "date",
      "granularity": "day"
    }
    ) }}

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
        DATE(TIMESTAMP(date, "America/New_York")) AS date_day,     --EST timezone conversion
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
        clicks,
        impressions,
        spend

        {{ fivetran_utils.fill_pass_through_columns('microsoft_ads__keyword_passthrough_metrics') }}
    from fields
)

select * 
from final where DATE(date_day) >= DATE_ADD(CURRENT_DATE(), INTERVAL -2 YEAR)
