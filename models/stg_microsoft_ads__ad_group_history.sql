with base as (

    select *
    from {{ var('ad_group_history') }}

), fields as (

    select 
        id as ad_group_id,
        campaign_id,
        name as ad_group_name,
        modified_time as modified_timestamp
    from base

), surrogate_key as (

    select 
        *,
        {{ dbt_utils.surrogate_key(['ad_group_id','modified_timestamp']) }} as ad_group_version_id
    from fields

), most_recent_record as (

    select
        *,
        row_number() over (partition by ad_group_id order by modified_timestamp desc) = 1 as is_most_recent_version
    from surrogate_key

)

select *
from most_recent_record