with base as (

    select * 
    from {{ ref('stg_amplitude__event_type_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_amplitude__event_type_tmp')),
                staging_columns=get_event_type_columns()
            )
        }}
    from base
),

final as (
    
    select 
        _fivetran_deleted,
        _fivetran_synced,
        deleted,
        display,
        flow_hidden,
        hidden,
        id as event_type_id,
        in_waitroom,
        name as event_type_name,
        non_active,
        project_name,
        timeline_hidden,
        totals,
        totals_delta,
        value,
        waitroom_approved
    from fields
)

select *
from final
