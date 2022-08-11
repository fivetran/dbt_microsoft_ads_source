{% macro get_account_history_columns() %}

{% set columns = [
    {"name": "id", "datatype": dbt_utils.type_int()},
    {"name": "name", "datatype": dbt_utils.type_string()},
    {"name": "last_modified_time", "datatype": dbt_utils.type_timestamp()},
    {"name": "time_zone", "datatype": dbt_utils.type_string()},
    {"name": "currency_code", "datatype": dbt_utils.type_string()}
] %}

{{ return(columns) }}

{% endmacro %}
