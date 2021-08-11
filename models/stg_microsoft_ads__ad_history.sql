with base as (

    select *
    from {{ var('ad_history') }}

{% if var('microsoft_auto_tagging_enabled', false) %}
), campaigns as (
    
    select * 
    from {{ ref('stg_microsoft_ads__campaign_history') }}

), ad_groups as (
    
    select *
    from {{ ref('stg_microsoft_ads__ad_group_history') }}
{% endif %}

), fields as (

    select 
        id as ad_id,
        final_url,
        ad_group_id,
        modified_time as modified_timestamp
    from base

), url_fields as (

    select 
        fields.*,
        {{ dbt_utils.split_part('fields.final_url', "'?'", 1) }} as base_url,
        {{ dbt_utils.get_url_host('fields.final_url') }} as url_host,
        '/' || {{ dbt_utils.get_url_path('fields.final_url') }} as url_path,

        {% if var('microsoft_auto_tagging_enabled', false) %}

        coalesce( {{ dbt_utils.get_url_parameter('fields.final_url', 'utm_source') }} , 'bing') as utm_source,
        coalesce( {{ dbt_utils.get_url_parameter('fields.final_url', 'utm_medium') }}, 'cpc') as utm_medium,
        coalesce( {{ dbt_utils.get_url_parameter('fields.final_url', 'utm_campaign') }}, campaigns.campaign_name) as utm_campaign,
        coalesce( {{ dbt_utils.get_url_parameter('fields.final_url', 'utm_content') }}, ad_groups.ad_group_name) as utm_content,

        {% else %}

        {{ dbt_utils.get_url_parameter('fields.final_url', 'utm_source') }} as utm_source,
        {{ dbt_utils.get_url_parameter('fields.final_url', 'utm_medium') }} as utm_medium,
        {{ dbt_utils.get_url_parameter('fields.final_url', 'utm_campaign') }} as utm_campaign,
        {{ dbt_utils.get_url_parameter('fields.final_url', 'utm_content') }} as utm_content,

        {% endif %}

        {{ dbt_utils.get_url_parameter('fields.final_url', 'utm_term') }} as utm_term
    from fields

    {% if var('microsoft_auto_tagging_enabled', false) %}
    left join ad_groups
        on ad_groups.ad_group_id = fields.ad_group_id

    left join campaigns
    on campaigns.campaign_id = ad_groups.campaign_id
        and coalesce(campaigns.is_most_recent_version, true)

    {% endif %}

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