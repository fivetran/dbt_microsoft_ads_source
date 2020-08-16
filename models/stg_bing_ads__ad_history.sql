with base as (

    select *
    from {{ source('bing_ads','ad_history') }}

), fields as (

    select 
        id as ad_id,
        final_url,
        ad_group_id,
        _fivetran_synced
    from base

)

select *
from fields