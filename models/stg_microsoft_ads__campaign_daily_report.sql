
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
        clicks,
        impressions,
        spend

        {% for metric in var('microsoft_ads__campaign_report_passthrough_metrics', []) %}
        , {{ metric }}
        {% endfor %}
    from fields
)

select * from final