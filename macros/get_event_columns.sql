{% macro get_event_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "_insert_id", "datatype": dbt_utils.type_string()},
    {"name": "ad_id", "datatype": dbt_utils.type_string()},
    {"name": "amplitude_id", "datatype": dbt_utils.type_string()},
    {"name": "app", "datatype": dbt_utils.type_string()},
    {"name": "city", "datatype": dbt_utils.type_string()},
    {"name": "client_event_time", "datatype": dbt_utils.type_timestamp()},
    {"name": "client_upload_time", "datatype": dbt_utils.type_timestamp()},
    {"name": "country", "datatype": dbt_utils.type_string()},
    {"name": "data", "datatype": dbt_utils.type_string()},
    {"name": "device_brand", "datatype": dbt_utils.type_string()},
    {"name": "device_carrier", "datatype": dbt_utils.type_string()},
    {"name": "device_family", "datatype": dbt_utils.type_string()},
    {"name": "device_id", "datatype": dbt_utils.type_string()},
    {"name": "device_manufacturer", "datatype": dbt_utils.type_string()},
    {"name": "device_model", "datatype": dbt_utils.type_string()},
    {"name": "device_type", "datatype": dbt_utils.type_string()},
    {"name": "dma", "datatype": dbt_utils.type_string()},
    {"name": "event_properties", "datatype": dbt_utils.type_string()},
    {"name": "event_time", "datatype": dbt_utils.type_timestamp()},
    {"name": "event_type", "datatype": dbt_utils.type_string()},
    {"name": "event_type_id", "datatype": dbt_utils.type_int()},
    {"name": "group_properties", "datatype": dbt_utils.type_string()},
    {"name": "id", "datatype": dbt_utils.type_int()},
    {"name": "idfa", "datatype": dbt_utils.type_string()},
    {"name": "ip_address", "datatype": dbt_utils.type_string()},
    {"name": "is_attribution_event", "datatype": "boolean"},
    {"name": "language", "datatype": dbt_utils.type_string()},
    {"name": "library", "datatype": dbt_utils.type_string()},
    {"name": "location_lat", "datatype": dbt_utils.type_string()},
    {"name": "location_lng", "datatype": dbt_utils.type_string()},
    {"name": "os_name", "datatype": dbt_utils.type_string()},
    {"name": "os_version", "datatype": dbt_utils.type_string()},
    {"name": "paying", "datatype": "boolean"},
    {"name": "platform", "datatype": dbt_utils.type_string()},
    {"name": "processed_time", "datatype": dbt_utils.type_timestamp()},
    {"name": "project_name", "datatype": dbt_utils.type_string()},
    {"name": "region", "datatype": dbt_utils.type_string()},
    {"name": "schema", "datatype": dbt_utils.type_int()},
    {"name": "server_received_time", "datatype": dbt_utils.type_timestamp()},
    {"name": "server_upload_time", "datatype": dbt_utils.type_timestamp()},
    {"name": "session_id", "datatype": dbt_utils.type_int()},
    {"name": "start_version", "datatype": dbt_utils.type_string()},
    {"name": "user_creation_time", "datatype": dbt_utils.type_timestamp()},
    {"name": "user_id", "datatype": dbt_utils.type_string()},
    {"name": "user_properties", "datatype": dbt_utils.type_string()},
    {"name": "uuid", "datatype": dbt_utils.type_string()},
    {"name": "version_name", "datatype": dbt_utils.type_string()}
] %}

{% if target.type == 'bigquery' %}
{{ columns.append( {"name": "groups", "datatype": dbt_utils.type_string(), "alias": "group_types", "quote": true} ) }}
{% else %}
{{ columns.append( {"name": "groups", "alias": "group_types", "datatype": dbt_utils.type_string()} ) }}
{% endif %} ,

{{ return(columns) }}

{% endmacro %}
