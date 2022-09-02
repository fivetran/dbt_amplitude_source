{% macro get_event_type_columns() %}

{% set columns = [
    {"name": "_fivetran_deleted", "datatype": "boolean"},
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "autohidden", "datatype": "boolean"},
    {"name": "deleted", "datatype": "boolean"},
    {"name": "display", "datatype": dbt_utils.type_string()},
    {"name": "flow_hidden", "datatype": "boolean"},
    {"name": "hidden", "datatype": "boolean"},
    {"name": "id", "datatype": dbt_utils.type_int()},
    {"name": "in_waitroom", "datatype": "boolean"},
    {"name": "name", "datatype": dbt_utils.type_string()},
    {"name": "non_active", "datatype": "boolean"},
    {"name": "project_name", "datatype": dbt_utils.type_string()},
    {"name": "timeline_hidden", "datatype": "boolean"},
    {"name": "totals", "datatype": dbt_utils.type_int()},
    {"name": "totals_delta", "datatype": dbt_utils.type_int()},
    {"name": "value", "datatype": dbt_utils.type_string()},
    {"name": "waitroom_approved", "datatype": dbt_utils.type_string()}
] %}

{{ return(columns) }}

{% endmacro %}
