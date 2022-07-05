{% macro get_keyword_history_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "ad_group_id", "datatype": dbt_utils.type_int()},
    {"name": "bid", "datatype": dbt_utils.type_float()},
    {"name": "bid_strategy_type", "datatype": dbt_utils.type_string()},
    {"name": "destination_url", "datatype": dbt_utils.type_string()},
    {"name": "editorial_appeal_status", "datatype": dbt_utils.type_string()},
    {"name": "editorial_location", "datatype": dbt_utils.type_string()},
    {"name": "editorial_reason_code", "datatype": dbt_utils.type_string()},
    {"name": "editorial_status", "datatype": dbt_utils.type_string()},
    {"name": "editorial_term", "datatype": dbt_utils.type_string()},
    {"name": "final_url", "datatype": dbt_utils.type_string()},
    {"name": "id", "datatype": dbt_utils.type_int()},
    {"name": "inherited_bid_strategy_type", "datatype": dbt_utils.type_string()},
    {"name": "language", "datatype": dbt_utils.type_string()},
    {"name": "match_type", "datatype": dbt_utils.type_string()},
    {"name": "mobile_final_url", "datatype": dbt_utils.type_string()},
    {"name": "modified_time", "datatype": dbt_utils.type_timestamp()},
    {"name": "name", "datatype": dbt_utils.type_string()},
    {"name": "param_1", "datatype": dbt_utils.type_string()},
    {"name": "param_2", "datatype": dbt_utils.type_string()},
    {"name": "param_3", "datatype": dbt_utils.type_string()},
    {"name": "status", "datatype": dbt_utils.type_string()},
    {"name": "tracking_template", "datatype": dbt_utils.type_string()}
] %}

{{ return(columns) }}

{% endmacro %}
