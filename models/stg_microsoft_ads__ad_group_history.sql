{{ config(enabled=var('ad_reporting__microsoft_ads_enabled', True),
   unique_key = ['source_relation','ad_group_id','modified_at'],
   partition_by={
      "field": "modified_at", 
      "data_type": "TIMESTAMP",
      "granularity": "day"
    }
    ) }}

with base as (

    select * 
    from {{ ref('stg_microsoft_ads__ad_group_history_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_microsoft_ads__ad_group_history_tmp')),
                staging_columns=get_ad_group_history_columns()
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
        id as ad_group_id,
        name as ad_group_name,
        campaign_id,
        CAST(FORMAT_TIMESTAMP("%F %T", modified_time, "America/New_York") AS TIMESTAMP) as modified_at,       --EST Conversion
        DATE(TIMESTAMP(start_date, "America/New_York")) AS start_date,         --EST Conversion
        DATE(TIMESTAMP(end_date, "America/New_York")) AS end_date,              --EST Conversion
        status,
        row_number() over (partition by source_relation, id order by modified_time desc) = 1 as is_most_recent_record
    from fields
)

select * 
from final
