{% macro get_campaign_history_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "account_id", "datatype": dbt_utils.type_int()},
    {"name": "bid_adjustment", "datatype": dbt_utils.type_float()},
    {"name": "bid_strategy_max_cpc", "datatype": dbt_utils.type_float()},
    {"name": "bid_strategy_target_cpa", "datatype": dbt_utils.type_float()},
    {"name": "bid_strategy_type", "datatype": dbt_utils.type_string()},
    {"name": "budget", "datatype": dbt_utils.type_float()},
    {"name": "budget_id", "datatype": dbt_utils.type_int()},
    {"name": "country_code", "datatype": dbt_utils.type_string()},
    {"name": "domain_language", "datatype": dbt_utils.type_string()},
    {"name": "id", "datatype": dbt_utils.type_int()},
    {"name": "language", "datatype": dbt_utils.type_string()},
    {"name": "local_inventory_ads_enabled", "datatype": "boolean"},
    {"name": "modified_time", "datatype": dbt_utils.type_timestamp()},
    {"name": "name", "datatype": dbt_utils.type_string()},
    {"name": "priority", "datatype": dbt_utils.type_int()},
    {"name": "status", "datatype": dbt_utils.type_string()},
    {"name": "store_id", "datatype": dbt_utils.type_int()},
    {"name": "sub_type", "datatype": dbt_utils.type_string()},
    {"name": "time_zone", "datatype": dbt_utils.type_string()},
    {"name": "tracking_template", "datatype": dbt_utils.type_string()},
    {"name": "type", "datatype": dbt_utils.type_string()},
    {"name": "website", "datatype": dbt_utils.type_string()}
] %}

{{ return(columns) }}

{% endmacro %}
