{{ config(enabled=var('ad_reporting__microsoft_ads_enabled', True)) }}

with base as (

    select * 
    from {{ ref('stg_microsoft_ads__keyword_history_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_microsoft_ads__keyword_history_tmp')),
                staging_columns=get_keyword_history_columns()
            )
        }}
        
    from base
),

final as (
    
    select 
        id as keyword_id,
        name as keyword_name,
        modified_time as modified_at,
        ad_group_id,
        match_type,
        status,
        row_number() over (partition by id order by modified_time desc) = 1 as is_most_recent_record
    from fields
)

select * 
from final
