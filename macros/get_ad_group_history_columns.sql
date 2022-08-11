{% macro get_ad_group_history_columns() %}

{% set columns = [
    {"name": "id", "datatype": dbt_utils.type_int()},
    {"name": "name", "datatype": dbt_utils.type_string()},
    {"name": "campaign_id", "datatype": dbt_utils.type_int()},
    {"name": "modified_time", "datatype": dbt_utils.type_timestamp()},
    {"name": "start_date", "datatype": "date"},
    {"name": "end_date", "datatype": "date"},
    {"name": "status", "datatype": dbt_utils.type_string()}
] %}

{{ return(columns) }}

{% endmacro %}
