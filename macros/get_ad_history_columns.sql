{% macro get_ad_history_columns() %}

{% set columns = [
    {"name": "id", "datatype": dbt.type_int()},
    {"name": "title_part_1", "datatype": dbt.type_string()},
    {"name": "final_url", "datatype": dbt.type_string()},
    {"name": "ad_group_id", "datatype": dbt.type_int()},
    {"name": "modified_time", "datatype": dbt.type_timestamp()},
    {"name": "status", "datatype": dbt.type_string()},
    {"name": "type", "datatype": dbt.type_string()}
] %}

{{ return(columns) }}

{% endmacro %}
