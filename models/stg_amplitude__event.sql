with base as (

    select * 
    from {{ ref('stg_amplitude__event_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_amplitude__event_tmp')),
                staging_columns=get_event_columns()
            )
        }}
    from base
),

final as (

    select
        id as event_id,
        cast(event_time as {{ dbt_utils.type_timestamp() }}) as event_time,
        {{ dbt_utils.surrogate_key(['user_id','session_id']) }} as unique_session_id,
        coalesce(user_id, (cast(amplitude_id as {{ dbt_utils.type_string() }}))) as amplitude_user_id,
        event_properties,
        event_type,
        event_type_id,
        group_types,
        group_properties,
        session_id,
        cast(user_id as {{ dbt_utils.type_string() }}) as user_id, 
        user_properties,
        cast(amplitude_id as {{ dbt_utils.type_string() }}) as amplitude_id,
        _insert_id,
        ad_id,
        app,
        project_name,
        cast(client_event_time as {{ dbt_utils.type_timestamp() }}) as client_event_time,
        cast(client_upload_time as {{ dbt_utils.type_timestamp() }}) as client_upload_time,
        city,
        country,
        data,
        device_brand,
        device_carrier,
        device_family,
        device_id,
        device_manufacturer,
        device_model,
        device_type,
        dma,
        idfa,
        ip_address,
        language,
        location_lat,
        location_lng,
        os_name,
        os_version,
        is_attribution_event,
        library,
        paying as is_paying,
        platform,
        cast(processed_time as {{ dbt_utils.type_timestamp() }}) as processed_time,
        region,
        schema,
        cast(server_received_time as {{ dbt_utils.type_timestamp() }}) as server_received_time,
        cast(server_upload_time as {{ dbt_utils.type_timestamp() }}) as server_upload_time,
        start_version,
        cast(user_creation_time as {{ dbt_utils.type_timestamp() }}) as user_creation_time,
        uuid,
        version_name,
        _fivetran_synced
    from fields
),

surrogate as (
    
    select
        *,
        {{ dbt_utils.surrogate_key(['event_id','device_id','client_event_time','amplitude_user_id']) }} as unique_event_id
    from final
)

select *
from surrogate
