# dbt_amplitude v0.1.0
🎉 Initial Release 🎉
- This is the initial release of this package. 

This package is designed enrich your Fivetran Amplitude data by doing the following:

- Add descriptions to tables and columns that are synced using Fivetran
- Add freshness tests to source data
- Add column-level testing where applicable. For example, all primary keys are tested for uniqueness and non-null values
- Model staging tables, which will be used in our transform package

Currently the package supports Postgres, Redshift, BigQuery, and Snowflake. Additionally, this package is designed to work with dbt versions [">=1.0.0", "<2.0.0"].

- For more information refer to the [README](/README.md).