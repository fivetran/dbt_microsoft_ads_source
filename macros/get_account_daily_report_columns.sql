{% macro get_account_daily_report_columns() %}

{% set columns = [
    {"name": "account_id", "datatype": dbt_utils.type_int()},
    {"name": "ad_distribution", "datatype": dbt_utils.type_string()},
    {"name": "bid_match_type", "datatype": dbt_utils.type_string()},
    {"name": "clicks", "datatype": dbt_utils.type_int()},
    {"name": "currency_code", "datatype": dbt_utils.type_string()},
    {"name": "date", "datatype": "date"},
    {"name": "delivered_match_type", "datatype": dbt_utils.type_string()},
    {"name": "device_os", "datatype": dbt_utils.type_string()},
    {"name": "device_type", "datatype": dbt_utils.type_string()},
    {"name": "impressions", "datatype": dbt_utils.type_int()},
    {"name": "network", "datatype": dbt_utils.type_string()},
    {"name": "spend", "datatype": dbt_utils.type_float()},
    {"name": "top_vs_other", "datatype": dbt_utils.type_string()}
] %}

{{ fivetran_utils.add_pass_through_columns(columns, var('microsoft_ads__account_passthrough_metrics')) }}

{{ return(columns) }}

{% endmacro %}
