{% macro get_search_daily_report_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "account_id", "datatype": dbt_utils.type_int()},
    {"name": "account_number", "datatype": dbt_utils.type_string()},
    {"name": "ad_group_id", "datatype": dbt_utils.type_int()},
    {"name": "ad_id", "datatype": dbt_utils.type_int()},
    {"name": "all_conversion_rate", "datatype": dbt_utils.type_string()},
    {"name": "all_conversions", "datatype": dbt_utils.type_int()},
    {"name": "all_return_on_ad_spend", "datatype": dbt_utils.type_float()},
    {"name": "all_revenue", "datatype": dbt_utils.type_float()},
    {"name": "assists", "datatype": dbt_utils.type_int()},
    {"name": "average_cpc", "datatype": dbt_utils.type_float()},
    {"name": "average_position", "datatype": dbt_utils.type_float()},
    {"name": "bid_match_type", "datatype": dbt_utils.type_string()},
    {"name": "campaign_id", "datatype": dbt_utils.type_int()},
    {"name": "clicks", "datatype": dbt_utils.type_int()},
    {"name": "conversion_rate", "datatype": dbt_utils.type_float()},
    {"name": "conversions", "datatype": dbt_utils.type_int()},
    {"name": "ctr", "datatype": dbt_utils.type_float()},
    {"name": "customer_id", "datatype": dbt_utils.type_int()},
    {"name": "date", "datatype": "date"},
    {"name": "delivered_match_type", "datatype": dbt_utils.type_string()},
    {"name": "device_os", "datatype": dbt_utils.type_string()},
    {"name": "device_type", "datatype": dbt_utils.type_string()},
    {"name": "impressions", "datatype": dbt_utils.type_int()},
    {"name": "keyword_id", "datatype": dbt_utils.type_int()},
    {"name": "language", "datatype": dbt_utils.type_string()},
    {"name": "network", "datatype": dbt_utils.type_string()},
    {"name": "return_on_ad_spend", "datatype": dbt_utils.type_float()},
    {"name": "revenue", "datatype": dbt_utils.type_float()},
    {"name": "search_query", "datatype": dbt_utils.type_string()},
    {"name": "spend", "datatype": dbt_utils.type_float()},
    {"name": "top_vs_other", "datatype": dbt_utils.type_string()}
] %}

{{ return(columns) }}

{% endmacro %}