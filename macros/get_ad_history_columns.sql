{% macro get_ad_history_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "ad_format_preference", "datatype": dbt_utils.type_string()},
    {"name": "ad_group_id", "datatype": dbt_utils.type_int()},
    {"name": "app_id", "datatype": dbt_utils.type_string()},
    {"name": "app_platform", "datatype": dbt_utils.type_string()},
    {"name": "business_name", "datatype": dbt_utils.type_string()},
    {"name": "call_to_action", "datatype": dbt_utils.type_string()},
    {"name": "device_preference", "datatype": dbt_utils.type_string()},
    {"name": "display_url", "datatype": dbt_utils.type_string()},
    {"name": "domain", "datatype": dbt_utils.type_string()},
    {"name": "editorial_appeal_status", "datatype": dbt_utils.type_string()},
    {"name": "editorial_location", "datatype": dbt_utils.type_string()},
    {"name": "editorial_reason_code", "datatype": dbt_utils.type_int()},
    {"name": "editorial_status", "datatype": dbt_utils.type_string()},
    {"name": "editorial_term", "datatype": dbt_utils.type_string()},
    {"name": "final_url", "datatype": dbt_utils.type_string()},
    {"name": "head_line", "datatype": dbt_utils.type_string()},
    {"name": "id", "datatype": dbt_utils.type_int()},
    {"name": "landscape_image_media_id", "datatype": dbt_utils.type_string()},
    {"name": "landscape_logo_media_id", "datatype": dbt_utils.type_string()},
    {"name": "long_head_line", "datatype": dbt_utils.type_string()},
    {"name": "mobile_final_url", "datatype": dbt_utils.type_string()},
    {"name": "modified_time", "datatype": dbt_utils.type_timestamp()},
    {"name": "path_1", "datatype": dbt_utils.type_string()},
    {"name": "path_2", "datatype": dbt_utils.type_string()},
    {"name": "square_image_media_id", "datatype": dbt_utils.type_string()},
    {"name": "square_logo_media_id", "datatype": dbt_utils.type_string()},
    {"name": "status", "datatype": dbt_utils.type_string()},
    {"name": "text", "datatype": dbt_utils.type_string()},
    {"name": "title", "datatype": dbt_utils.type_string()},
    {"name": "title_part_1", "datatype": dbt_utils.type_string()},
    {"name": "title_part_2", "datatype": dbt_utils.type_string()},
    {"name": "title_part_3", "datatype": dbt_utils.type_string()},
    {"name": "tracking_template", "datatype": dbt_utils.type_string()},
    {"name": "type", "datatype": dbt_utils.type_string()}
] %}

{{ return(columns) }}

{% endmacro %}
