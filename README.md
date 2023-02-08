<p align="center">
    <a alt="License"
        href="https://github.com/fivetran/dbt_amplitude_source/blob/main/LICENSE">
        <img src="https://img.shields.io/badge/License-Apache%202.0-blue.svg" /></a>
    <a alt="dbt-core">
        <img src="https://img.shields.io/badge/dbt_Core™_version->=1.3.0_,<2.0.0-orange.svg" /></a>
    <a alt="Maintained?">
        <img src="https://img.shields.io/badge/Maintained%3F-yes-green.svg" /></a>
    <a alt="PRs">
        <img src="https://img.shields.io/badge/Contributions-welcome-blueviolet" /></a>
</p>

# Amplitude Source dbt Package ([Docs](https://fivetran.github.io/dbt_amplitude_source/))
# 📣 What does this dbt package do?
- Materializes [Amplitude staging tables](https://fivetran.github.io/dbt_amplitude_source/#!/overview/amplitude_source/models/?g_v=1) which leverage data in the format described by [this ERD](https://fivetran.com/docs/applications/amplitude/#schemainformation). These staging tables clean, test, and prepare your Amplitude data from [Fivetran's connector](https://fivetran.com/docs/applications/amplitude) for analysis by doing the following:
  - Name columns for consistency across all packages and for easier analysis
  - Adds freshness tests to source data
  - Adds column-level testing where applicable. For example, all primary keys are tested for uniqueness and non-null values.
- Generates a comprehensive data dictionary of your Amplitude data through the [dbt docs site](https://fivetran.github.io/dbt_amplitude_source/).
- These tables are designed to work simultaneously with our [Amplitude transformation package](https://github.com/fivetran/dbt_amplitude).
    - Refer to our [Docs site](https://fivetran.github.io/dbt_amplitude_source/#!/overview/salesforce_source/models/?g_v=1) for more details about these materialized models. 

# 🎯 How do I use the dbt package?
## Step 1: Prerequisites
To use this dbt package, you must have the following:
- At least one Fivetran Amplitude connector syncing data into your destination. 
- A **BigQuery**, **Snowflake**, **Redshift**, **PostgreSQL**, or **Databricks** destination.

### Databricks dispatch configuration
If you are using a Databricks destination with this package, you must add the following (or a variation of the following) dispatch configuration within your `dbt_project.yml`. This is required in order for the package to accurately search for macros within the `dbt-labs/spark_utils` then the `dbt-labs/dbt_utils` packages respectively.
```yml
dispatch:
  - macro_namespace: dbt_utils
    search_order: ['spark_utils', 'dbt_utils']
```

## Step 2: Install the package
Include the following amplitude_source package version in your `packages.yml` file.
> TIP: Check [dbt Hub](https://hub.getdbt.com/) for the latest installation instructions or [read the dbt docs](https://docs.getdbt.com/docs/package-management) for more information on installing packages.
```yaml
packages:
  - package: fivetran/amplitude_source
    version: [">=0.3.0", "<0.4.0"]
```
## Step 3: Define database and schema variables

By default, this package runs using your destination and the `amplitude_source` schema. If this is not where your Amplitude data is (for example, if your Amplitude schema is named `amplitude_fivetran`), you would add the following configuration to your root `dbt_project.yml` file with your custom database and schema names:

```yml
vars:
    amplitude_database: your_destination_name
    amplitude_schema: your_schema_name 
```

## Step 4: Configure event date range
Because of the typical volume of event data, you may want to limit this package's models to work with a more recent date range. Therefore we have added the functionality to filter records via the `amplitude__date_range_start` and `amplitude__date_range_end` variables within the `stg_amplitude__event` model. The default date range starts at '2020-01-01' and ends one month past the current day, but you may configure it in your root `dbt_project.yml` file:

```yml
vars:
    amplitude__date_range_start: '2022-01-01' # your start date here
    amplitude__date_range_end: '2022-12-01' # your end date here
```
If you adjust the date range variables, we recommend running `dbt run --full-refresh` to ensure no data quality issues within the adjusted date range.

## (Optional) Step 5: Additional configurations
<details><summary>Expand to view details</summary>
<br>

### Change source table references
If an individual source table has a different name than the package expects, add the table name as it appears in your destination to the respective variable:
> IMPORTANT: See this project's [`dbt_project.yml`](https://github.com/fivetran/dbt_amplitude_source/blob/main/dbt_project.yml) variable declarations to see the expected names.
    
```yml
vars:
    amplitude_<default_source_table_name>_identifier: your_table_name 
```

### Change build schema
By default, this package builds the Amplitude staging models within a schema titled (`<target_schema>` + `_source_amplitude`) in your destination. If this is not where you would like your Amplitude staging data to be written to, add the following configuration to your root `dbt_project.yml` file:

```yml
models:
    amplitude_source:
      +schema: my_new_schema_name # leave blank for just the target_schema
```

</details>

## (Optional) Step 6: Orchestrate your models with Fivetran Transformations for dbt Core™
<details><summary>Expand to view details</summary>
<br>

Fivetran offers the ability for you to orchestrate your dbt project through [Fivetran Transformations for dbt Core™](https://fivetran.com/docs/transformations/dbt). Learn how to set up your project for orchestration through Fivetran in our [Transformations for dbt Core™ setup guides](https://fivetran.com/docs/transformations/dbt#setupguide).
</details>

# 🔍 Does this package have dependencies?
This dbt package is dependent on the following dbt packages. Please be aware that these dependencies are installed by default within this package. For more information on the following packages, refer to the [dbt hub](https://hub.getdbt.com/) site.
> IMPORTANT: If you have any of these dependent packages in your own `packages.yml` file, we highly recommend that you remove them from your root `packages.yml` to avoid package version conflicts.
```yml
packages:
    - package: fivetran/fivetran_utils
      version: [">=0.4.0", "<0.5.0"]

    - package: dbt-labs/dbt_utils
      version: [">=1.0.0", "<2.0.0"]

    - package: dbt-labs/spark_utils
      version: [">=0.3.0", "<0.4.0"]
```
# 🙌 How is this package maintained and can I contribute?
## Package Maintenance
The Fivetran team maintaining this package _only_ maintains the latest version of the package. We highly recommend that you stay consistent with the [latest version](https://hub.getdbt.com/fivetran/amplitude_source/latest/) of the package and refer to the [CHANGELOG](https://github.com/fivetran/dbt_amplitude_source/blob/main/CHANGELOG.md) and release notes for more information on changes across versions.

## Contributions
A small team of analytics engineers at Fivetran develops these dbt packages. However, the packages are made better by community contributions! 

We highly encourage and welcome contributions to this package. Check out [this dbt Discourse article](https://discourse.getdbt.com/t/contributing-to-a-dbt-package/657) to learn how to contribute to a dbt package!

# 🏪 Are there any resources available?
- If you have questions or want to reach out for help, please refer to the [GitHub Issue](https://github.com/fivetran/dbt_amplitude_source/issues/new/choose) section to find the right avenue of support for you.
- If you would like to provide feedback to the dbt package team at Fivetran or would like to request a new dbt package, fill out our [Feedback Form](https://www.surveymonkey.com/r/DQ7K7WW).
- Have questions or want to just say hi? Book a time during our office hours [on Calendly](https://calendly.com/fivetran-solutions-team/fivetran-solutions-team-office-hours) or email us at solutions@fivetran.com.
