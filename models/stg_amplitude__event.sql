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

final_pre as (
    
    select
        _fivetran_synced,
        _insert_id,
        ad_id,
        amplitude_id,
        app,
        city,
        client_event_time,
        client_upload_time,
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
        event_properties,
        event_time,
        event_type,
        event_type_id,
        group_types,
        group_properties,
        id as event_id,
        idfa,
        ip_address,
        is_attribution_event,
        language,
        library,
        location_lat,
        location_lng,
        os_name,
        os_version,
        paying as is_paying,
        platform,
        processed_time,
        project_name,
        region,
        schema,
        server_received_time,
        server_upload_time,
        session_id,
        start_version,
        user_creation_time,
        user_id,
        user_properties,
        uuid,
        version_name
    from fields
),

final as (

    select
        {{ dbt_utils.surrogate_key(['event_id','device_id','client_event_time']) }} as unique_event_id,
        {{ dbt_utils.surrogate_key(['user_id','session_id']) }} as unique_session_id,
        coalesce(user_id, amplitude_id) as amplitude_user_id,
        event_id,
        event_properties,
        cast(event_time as {{ dbt_utils.type_timestamp() }}) as event_time,
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
        is_paying,
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
    from final_pre
)

select *
from final
