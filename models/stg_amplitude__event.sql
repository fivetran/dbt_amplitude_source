
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
        _fivetran_synced,
        _insert_id,
        ad_id,
        amplitude_event_type,
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
        paying,
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
)

select *
from final
