{% macro get_campaign_performance_daily_report_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "account_id", "datatype": dbt_utils.type_int()},
    {"name": "ad_distribution", "datatype": dbt_utils.type_string()},
    {"name": "ad_relevance", "datatype": dbt_utils.type_int()},
    {"name": "all_conversion_rate", "datatype": dbt_utils.type_string()},
    {"name": "all_conversions", "datatype": dbt_utils.type_int()},
    {"name": "all_return_on_ad_spend", "datatype": dbt_utils.type_float()},
    {"name": "all_revenue", "datatype": dbt_utils.type_float()},
    {"name": "assists", "datatype": dbt_utils.type_int()},
    {"name": "average_cpc", "datatype": dbt_utils.type_float()},
    {"name": "average_position", "datatype": dbt_utils.type_float()},
    {"name": "bid_match_type", "datatype": dbt_utils.type_string()},
    {"name": "budget_association_status", "datatype": dbt_utils.type_string()},
    {"name": "campaign_id", "datatype": dbt_utils.type_int()},
    {"name": "campaign_name", "datatype": dbt_utils.type_string()},
    {"name": "campaign_status", "datatype": dbt_utils.type_string()},
    {"name": "clicks", "datatype": dbt_utils.type_int()},
    {"name": "conversion_rate", "datatype": dbt_utils.type_float()},
    {"name": "conversions", "datatype": dbt_utils.type_int()},
    {"name": "ctr", "datatype": dbt_utils.type_float()},
    {"name": "currency_code", "datatype": dbt_utils.type_string()},
    {"name": "date", "datatype": "date"},
    {"name": "delivered_match_type", "datatype": dbt_utils.type_string()},
    {"name": "device_os", "datatype": dbt_utils.type_string()},
    {"name": "device_type", "datatype": dbt_utils.type_string()},
    {"name": "expected_ctr", "datatype": dbt_utils.type_int()},
    {"name": "historical_ad_relevance", "datatype": dbt_utils.type_int()},
    {"name": "historical_expected_ctr", "datatype": dbt_utils.type_int()},
    {"name": "historical_landing_page_experience", "datatype": dbt_utils.type_int()},
    {"name": "historical_quality_score", "datatype": dbt_utils.type_int()},
    {"name": "impressions", "datatype": dbt_utils.type_int()},
    {"name": "landing_page_experience", "datatype": dbt_utils.type_int()},
    {"name": "low_quality_clicks", "datatype": dbt_utils.type_int()},
    {"name": "low_quality_clicks_percent", "datatype": dbt_utils.type_float()},
    {"name": "low_quality_conversion_rate", "datatype": dbt_utils.type_float()},
    {"name": "low_quality_conversions", "datatype": dbt_utils.type_int()},
    {"name": "low_quality_general_clicks", "datatype": dbt_utils.type_int()},
    {"name": "low_quality_impressions", "datatype": dbt_utils.type_int()},
    {"name": "low_quality_impressions_percent", "datatype": dbt_utils.type_float()},
    {"name": "low_quality_sophisticated_clicks", "datatype": dbt_utils.type_int()},
    {"name": "network", "datatype": dbt_utils.type_string()},
    {"name": "phone_calls", "datatype": dbt_utils.type_int()},
    {"name": "phone_impressions", "datatype": dbt_utils.type_int()},
    {"name": "ptr", "datatype": dbt_utils.type_float()},
    {"name": "quality_score", "datatype": dbt_utils.type_int()},
    {"name": "return_on_ad_spend", "datatype": dbt_utils.type_float()},
    {"name": "revenue", "datatype": dbt_utils.type_float()},
    {"name": "spend", "datatype": dbt_utils.type_float()},
    {"name": "top_vs_other", "datatype": dbt_utils.type_string()},
    {"name": "view_through_conversions", "datatype": dbt_utils.type_int()}
] %}

{{ return(columns) }}

{% endmacro %}
