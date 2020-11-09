with base as (

    select *
    from {{ var('ad_history') }}

), fields as (

    select 
        id as ad_id,
        final_url,
        ad_group_id,
        modified_time as modified_timestamp
    from base

), url_fields as (

    select 
        *,
        {{ dbt_utils.split_part('final_url', "'?'", 1) }} as base_url,
        {{ dbt_utils.get_url_host('final_url') }} as url_host,
        '/' || {{ dbt_utils.get_url_path('final_url') }} as url_path,
        {{ dbt_utils.get_url_parameter('final_url', 'utm_source') }} as utm_source,
        {{ dbt_utils.get_url_parameter('final_url', 'utm_medium') }} as utm_medium,
        {{ dbt_utils.get_url_parameter('final_url', 'utm_campaign') }} as utm_campaign,
        {{ dbt_utils.get_url_parameter('final_url', 'utm_content') }} as utm_content,
        {{ dbt_utils.get_url_parameter('final_url', 'utm_term') }} as utm_term
    from fields

), surrogate_key as (

    select 
        *,
        {{ dbt_utils.surrogate_key(['ad_id','modified_timestamp']) }} as ad_version_id
    from url_fields

), most_recent_record as (

    select
        *,
        row_number() over (partition by ad_id order by modified_timestamp desc) = 1 as is_most_recent_version
    from surrogate_key

)

select *
from most_recent_record