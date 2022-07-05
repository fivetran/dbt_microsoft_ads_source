{% macro get_account_history_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "account_financial_status", "datatype": dbt_utils.type_string()},
    {"name": "account_life_cycle_status", "datatype": dbt_utils.type_string()},
    {"name": "auto_tag_type", "datatype": dbt_utils.type_string()},
    {"name": "back_up_payment_instrument_id", "datatype": dbt_utils.type_int()},
    {"name": "bill_to_customer_id", "datatype": dbt_utils.type_int()},
    {"name": "billing_threshold_amount", "datatype": dbt_utils.type_float()},
    {"name": "business_address_city", "datatype": dbt_utils.type_string()},
    {"name": "business_address_country_code", "datatype": dbt_utils.type_string()},
    {"name": "business_address_id", "datatype": dbt_utils.type_int()},
    {"name": "business_address_line_1", "datatype": dbt_utils.type_string()},
    {"name": "business_address_line_2", "datatype": dbt_utils.type_string()},
    {"name": "business_address_line_3", "datatype": dbt_utils.type_string()},
    {"name": "business_address_line_4", "datatype": dbt_utils.type_string()},
    {"name": "business_address_postal_code", "datatype": dbt_utils.type_string()},
    {"name": "business_address_state_or_province", "datatype": dbt_utils.type_string()},
    {"name": "business_name", "datatype": dbt_utils.type_string()},
    {"name": "currency_code", "datatype": dbt_utils.type_string()},
    {"name": "id", "datatype": dbt_utils.type_int()},
    {"name": "language", "datatype": dbt_utils.type_string()},
    {"name": "last_modified_by_user_id", "datatype": dbt_utils.type_int()},
    {"name": "last_modified_time", "datatype": dbt_utils.type_timestamp()},
    {"name": "name", "datatype": dbt_utils.type_string()},
    {"name": "number", "datatype": dbt_utils.type_string()},
    {"name": "parent_customer_id", "datatype": dbt_utils.type_int()},
    {"name": "pause_reason", "datatype": dbt_utils.type_int()},
    {"name": "payment_method_id", "datatype": dbt_utils.type_int()},
    {"name": "payment_method_type", "datatype": dbt_utils.type_string()},
    {"name": "primary_user_id", "datatype": dbt_utils.type_int()},
    {"name": "sales_house_customer_id", "datatype": dbt_utils.type_int()},
    {"name": "sold_to_payment_instrument_id", "datatype": dbt_utils.type_int()},
    {"name": "time_zone", "datatype": dbt_utils.type_string()}
] %}

{{ return(columns) }}

{% endmacro %}
