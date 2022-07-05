{% macro get_ad_group_history_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "ad_rotation", "datatype": dbt_utils.type_string()},
    {"name": "bid_adjustment", "datatype": dbt_utils.type_float()},
    {"name": "bid_boost_value", "datatype": dbt_utils.type_float()},
    {"name": "bid_option", "datatype": dbt_utils.type_string()},
    {"name": "bid_strategy_type", "datatype": dbt_utils.type_string()},
    {"name": "campaign_id", "datatype": dbt_utils.type_int()},
    {"name": "cpc_bid", "datatype": dbt_utils.type_float()},
    {"name": "end_date", "datatype": "date"},
    {"name": "id", "datatype": dbt_utils.type_int()},
    {"name": "inherited_bid_strategy_type", "datatype": dbt_utils.type_string()},
    {"name": "language", "datatype": dbt_utils.type_string()},
    {"name": "maximum_bid", "datatype": dbt_utils.type_float()},
    {"name": "modified_time", "datatype": dbt_utils.type_timestamp()},
    {"name": "name", "datatype": dbt_utils.type_string()},
    {"name": "network_distribution", "datatype": dbt_utils.type_string()},
    {"name": "privacy_status", "datatype": dbt_utils.type_string()},
    {"name": "start_date", "datatype": "date"},
    {"name": "status", "datatype": dbt_utils.type_string()},
    {"name": "target_setting", "datatype": dbt_utils.type_string()},
    {"name": "tracking_template", "datatype": dbt_utils.type_string()}
] %}

{{ return(columns) }}

{% endmacro %}
