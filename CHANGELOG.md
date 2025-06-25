# dbt_amplitude_source v0.5.0

[PR #17](https://github.com/fivetran/dbt_amplitude_source/pull/17) includes the following updates:

## Breaking Change for dbt Core < 1.9.6
> *Note: This is not relevant to Fivetran Quickstart users.*
Migrated `freshness` from a top-level source property to a source `config` in alignment with [recent updates](https://github.com/dbt-labs/dbt-core/issues/11506) from dbt Core. This will resolve the following deprecation warning that users running dbt >= 1.9.6 may have received:

```
[WARNING]: Deprecated functionality
Found `freshness` as a top-level property of `amplitude` in file
`models/src_amplitude.yml`. The `freshness` top-level property should be moved
into the `config` of `amplitude`.
```

**IMPORTANT:** Users running dbt Core < 1.9.6 will not be able to utilize freshness tests in this release or any subsequent releases, as older versions of dbt will not recognize freshness as a source `config` and therefore not run the tests.

If you are using dbt Core < 1.9.6 and want to continue running Amplitude freshness tests, please elect **one** of the following options:
  1. (Recommended) Upgrade to dbt Core >= 1.9.6
  2. Do not upgrade your installed version of the `amplitude_source` package. Pin your dependency on v0.4.1 in your `packages.yml` file.
  3. Utilize a dbt [override](https://docs.getdbt.com/reference/resource-properties/overrides) to overwrite the package's `amplitude` source and apply freshness via the previous release top-level property route. This will require you to copy and paste the entirety of the previous release `src_amplitude.yml` file and add an `overrides: amplitude_source` property.

## Under the Hood
- Updates to ensure integration tests use latest version of dbt.

# dbt_amplitude_source v0.4.1
This release introduces the following updates: 

## Under the Hood
- Prepends `materialized` configs in the package's `dbt_project.yml` file with `+` to improve compatibility with the newer versions of dbt-core starting with v1.10.0. ([PR #15](https://github.com/fivetran/dbt_amplitude_source/pull/15))
- Updates the package maintainer pull request template. ([PR #16](https://github.com/fivetran/dbt_amplitude_source/pull/16))

## Contributors
- [@b-per](https://github.com/b-per) ([PR #15](https://github.com/fivetran/dbt_amplitude_source/pull/15))

# dbt_amplitude_source v0.4.0
This release includes the following updates:

## Breaking Change
- Filtered events to include only those with `event_time` up to and including the current date, preventing data quality issues in downstream incremental models. Future events are treated as erroneous. ([#14](https://github.com/fivetran/dbt_amplitude_source/pull/14))
- As a result, the model `stg_amplitude__event` will no longer include events past the current date. ([#23](https://github.com/fivetran/dbt_amplitude/pull/23))

## Documentation
- Corrected references to connectors and connections in the README. ([#13](https://github.com/fivetran/dbt_amplitude_source/pull/13))

 ## Under the Hood:
- Incorporated the new `fivetran_utils.drop_schemas_automation` macro into the end of each Buildkite integration test job. ([#9](https://github.com/fivetran/dbt_amplitude_source/pull/9))

# dbt_amplitude_source v0.4.0-a1
This pre-release includes the following updates:

## Bug fix
- Filtered events to include only those with `event_time` up to and including the current date, preventing data quality issues in downstream incremental models. Future events are treated as erroneous.
 ([#14](https://github.com/fivetran/dbt_amplitude_source/pull/14))

## Documentation
- Corrected references to connectors and connections in the README. ([#13](https://github.com/fivetran/dbt_amplitude_source/pull/13))

 ## Under the Hood:
- Incorporated the new `fivetran_utils.drop_schemas_automation` macro into the end of each Buildkite integration test job. ([#9](https://github.com/fivetran/dbt_amplitude_source/pull/9))

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
