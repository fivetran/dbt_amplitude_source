# dbt_amplitude_source v0.3.0

## 🚨 Breaking Changes 🚨:
[PR #8](https://github.com/fivetran/dbt_amplitude_source/pull/8) includes the following update:

- Rename the `date_range_start` and `date_range_end` variables to `amplitude__date_range_start` and `amplitude__date_range_end` in order to make them global variables. 
- Additionally, move `amplitude__date_range_start` and `amplitude__date_range_end` variables further upstream to the `stg_amplitude__event` model. 
    - This way event records will be filtered from the onset, which will help reduce unnecessary volume later downstream. 
    - The filtered data will be between (and including) the `amplitude__date_range_start` and `amplitude__date_range_end` dates.
    - If a `amplitude__date_range_start` is not provided, it will use `2020-01-01` as default.
    - If a `amplitude__date_range_end` is not provided, it will use a month from the current date by default.
- Brought the `event_day` field upstream to the `stg_amplitude__event` model. 
- Please note, a `dbt run --full-refresh` will be required after upgrading to this version in order to capture the updates.


# dbt_amplitude_source v0.2.0

## 🚨 Breaking Changes 🚨:
[PR #6](https://github.com/fivetran/dbt_amplitude_source/pull/6) includes the following breaking changes:
- Dispatch update for dbt-utils to dbt-core cross-db macros migration. Specifically `{{ dbt_utils.<macro> }}` have been updated to `{{ dbt.<macro> }}` for the below macros:
    - `any_value`
    - `bool_or`
    - `cast_bool_to_text`
    - `concat`
    - `date_trunc`
    - `dateadd`
    - `datediff`
    - `escape_single_quotes`
    - `except`
    - `hash`
    - `intersect`
    - `last_day`
    - `length`
    - `listagg`
    - `position`
    - `replace`
    - `right`
    - `safe_cast`
    - `split_part`
    - `string_literal`
    - `type_bigint`
    - `type_float`
    - `type_int`
    - `type_numeric`
    - `type_string`
    - `type_timestamp`
    - `array_append`
    - `array_concat`
    - `array_construct`
- For `current_timestamp` and `current_timestamp_in_utc` macros, the dispatch AND the macro names have been updated to the below, respectively:
    - `dbt.current_timestamp_backcompat`
    - `dbt.current_timestamp_in_utc_backcompat`
- `dbt_utils.surrogate_key` has also been updated to `dbt_utils.generate_surrogate_key`. Since the method for creating surrogate keys differ, we suggest all users do a `full-refresh` for the most accurate data. For more information, please refer to dbt-utils [release notes](https://github.com/dbt-labs/dbt-utils/releases) for this update.
- Dependencies on `fivetran/fivetran_utils` have been upgraded, previously `[">=0.3.0", "<0.4.0"]` now `[">=0.4.0", "<0.5.0"]`.

# dbt_amplitude_source v0.1.0
🎉 Initial Release 🎉
- This is the initial release of this package. 

This package is designed enrich your Fivetran Amplitude data by doing the following:

- Add descriptions to tables and columns that are synced using Fivetran
- Add freshness tests to source data
- Add column-level testing where applicable. For example, all primary keys are tested for uniqueness and non-null values
- Model staging tables, which will be used in our transform package

Currently the package supports Postgres, Redshift, BigQuery, Databricks, and Snowflake. Additionally, this package is designed to work with dbt versions [">=1.0.0", "<2.0.0"].

- For more information refer to the [README](/README.md).
