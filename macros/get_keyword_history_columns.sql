{% macro get_keyword_history_columns() %}

{% set columns = [
    {"name": "id", "datatype": dbt_utils.type_int()},
    {"name": "name", "datatype": dbt_utils.type_string()},
    {"name": "modified_time", "datatype": dbt_utils.type_timestamp()},
    {"name": "ad_group_id", "datatype": dbt_utils.type_int()},
    {"name": "match_type", "datatype": dbt_utils.type_string()},
    {"name": "status", "datatype": dbt_utils.type_string()}
] %}

{{ return(columns) }}

{% endmacro %}
