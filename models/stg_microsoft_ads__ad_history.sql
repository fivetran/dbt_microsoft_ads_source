{{ config(enabled=var('ad_reporting__microsoft_ads_enabled', True),
    unique_key = ['source_relation','ad_id','modified_at'],
    partition_by={
      "field": "modified_at", 
      "data_type": "TIMESTAMP",
      "granularity": "day"
    }
    ) }}

with base as (

    select * 
    from {{ ref('stg_microsoft_ads__ad_history_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_microsoft_ads__ad_history_tmp')),
                staging_columns=get_ad_history_columns()
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
        id as ad_id,
        title_part_1 as ad_name,
        final_url,
        ad_group_id,
        CAST(FORMAT_TIMESTAMP("%F %T", modified_time, "America/New_York") AS TIMESTAMP) as modified_at,    --EST Conversion
        status,
        type,
        row_number() over (partition by source_relation, id order by modified_time desc) = 1 as is_most_recent_record
    from fields
)

select * 
from final
