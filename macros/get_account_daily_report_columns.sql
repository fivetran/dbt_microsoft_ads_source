{% macro get_account_daily_report_columns() %}

{% set columns = [
    {"name": "account_id", "datatype": dbt.type_int()},
    {"name": "ad_distribution", "datatype": dbt.type_string()},
    {"name": "bid_match_type", "datatype": dbt.type_string()},
    {"name": "clicks", "datatype": dbt.type_int()},
    {"name": "currency_code", "datatype": dbt.type_string()},
    {"name": "date", "datatype": "date"},
    {"name": "delivered_match_type", "datatype": dbt.type_string()},
    {"name": "device_os", "datatype": dbt.type_string()},
    {"name": "device_type", "datatype": dbt.type_string()},
    {"name": "impressions", "datatype": dbt.type_int()},
    {"name": "network", "datatype": dbt.type_string()},
    {"name": "spend", "datatype": dbt.type_float()},
    {"name": "top_vs_other", "datatype": dbt.type_string()}
] %}

{{ fivetran_utils.add_pass_through_columns(columns, var('microsoft_ads__account_passthrough_metrics')) }}

{{ return(columns) }}

{% endmacro %}
