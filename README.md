# Microsoft Ads Source dbt Package ([Docs](https://fivetran.github.io/dbt_microsoft_ads_source/))

<p align="left">
    <a alt="License"
        href="https://github.com/fivetran/dbt_microsoft_ads_source/blob/main/LICENSE">
        <img src="https://img.shields.io/badge/License-Apache%202.0-blue.svg" /></a>
    <a alt="dbt-core">
        <img src="https://img.shields.io/badge/dbt_Core™_version->=1.3.0_,<2.0.0-orange.svg" /></a>
    <a alt="Maintained?">
        <img src="https://img.shields.io/badge/Maintained%3F-yes-green.svg" /></a>
    <a alt="PRs">
        <img src="https://img.shields.io/badge/Contributions-welcome-blueviolet" /></a>
    <a alt="Fivetran Quickstart Compatible"
        href="https://fivetran.com/docs/transformations/dbt/quickstart">
        <img src="https://img.shields.io/badge/Fivetran_Quickstart_Compatible%3F-yes-green.svg" /></a>
</p>

## What does this dbt package do?
<!--section="microsoft_ads_source_model"-->
- Materializes [Microsoft Ads staging tables](https://fivetran.github.io/dbt_microsoft_ads_source/#!/overview/microsoft_ads_source/models/?g_v=1&g_e=seeds) which leverage data in the format described by [this ERD](https://fivetran.com/docs/applications/microsoft-advertising#schemainformation). These staging tables clean, test, and prepare your microsoft_ads data from [Fivetran's connector](https://fivetran.com/docs/applications/microsoft-advertising) for analysis by doing the following:
  - Names columns for consistency across all packages and for easier analysis
  - Adds freshness tests to source data
  - Adds column-level testing where applicable. For example, all primary keys are tested for uniqueness and non-null values.
- Generates a comprehensive data dictionary of your Microsoft Ads data through the [dbt docs site](https://fivetran.github.io/dbt_microsoft_ads_source/).
- These tables are designed to work simultaneously with our [Microsoft Ads transformation package](https://github.com/fivetran/dbt_microsoft_ads).
<!--section-end-->

## How do I use the dbt package?
### Step 1: Prerequisites
To use this dbt package, you must have the following:
- At least one Fivetran Microsoft Ads connection syncing data into your destination.
- A **BigQuery**, **Snowflake**, **Redshift**, **PostgreSQL**, or **Databricks** destination.

#### Databricks Dispatch Configuration
If you are using a Databricks destination with this package you will need to add the below (or a variation of the below) dispatch configuration within your `dbt_project.yml`. This is required in order for the package to accurately search for macros within the `dbt-labs/spark_utils` then the `dbt-labs/dbt_utils` packages respectively.
```yml
dispatch:
  - macro_namespace: dbt_utils
    search_order: ['spark_utils', 'dbt_utils']
```

### Step 2: Install the package (skip if also using the `Microsoft Ads ` transformation or `Ad Reporting` combo package)
If you  are **not** using the [Microsoft Ads transformation package](https://github.com/fivetran/dbt_microsoft_ads) or the [Ad Reporting combination package](https://github.com/fivetran/dbt_ad_reporting), include the following package version in your `packages.yml` file. If you are installing the transform or combo packages, the source package is automatically installed as a dependency.

> TIP: Check [dbt Hub](https://hub.getdbt.com/) for the latest installation instructions or [read the dbt docs](https://docs.getdbt.com/docs/package-management) for more information on installing packages.
```yaml
packages:
  - package: fivetran/microsoft_ads_source
    version: [">=0.10.0", "<0.11.0"]
```
### Step 3: Define database and schema variables
By default, this package runs using your destination and the `microsoft_ads` schema. If this is not where your Microsoft Ads data is (for example, if your microsoft_ads schema is named `microsoft_ads_fivetran`), add the following configuration to your root `dbt_project.yml` file:

```yml
vars:
    microsoft_ads_database: your_destination_name
    microsoft_ads_schema: your_schema_name 
```

### (Optional) Step 4: Additional configurations

<details open><summary>Expand/Collapse details</summary>

#### Union multiple connections
If you have multiple microsoft_ads connections in Fivetran and would like to use this package on all of them simultaneously, we have provided functionality to do so. The package will union all of the data together and pass the unioned table into the transformations. You will be able to see which source it came from in the `source_relation` column of each model. To use this functionality, you will need to set either the `microsoft_ads_union_schemas` OR `microsoft_ads_union_databases` variables (cannot do both) in your root `dbt_project.yml` file:

```yml
vars:
    microsoft_ads_union_schemas: ['microsoft_ads_usa','microsoft_ads_canada'] # use this if the data is in different schemas/datasets of the same database/project
    microsoft_ads_union_databases: ['microsoft_ads_usa','microsoft_ads_canada'] # use this if the data is in different databases/projects but uses the same schema name
```
> NOTE: The native `source.yml` connection set up in the package will not function when the union schema/database feature is utilized. Although the data will be correctly combined, you will not observe the sources linked to the package models in the Directed Acyclic Graph (DAG). This happens because the package includes only one defined `source.yml`.

To connect your multiple schema/database sources to the package models, follow the steps outlined in the [Union Data Defined Sources Configuration](https://github.com/fivetran/dbt_fivetran_utils/tree/releases/v0.4.latest#union_data-source) section of the Fivetran Utils documentation for the union_data macro. This will ensure a proper configuration and correct visualization of connections in the DAG.

#### Passing Through Additional Metrics
By default, this package will select `clicks`, `impressions`, `spend`, `conversions` (coalesces source `conversions` and `conversions_qualified` fields), `conversions_value` (aliased from `revenue`), `all_conversions` (coalesces source `all_conversions` and `all_conversions_qualified` fields) and `all_conversions_value` (aliased from `all_revenue`) from the source reporting tables to store into the staging models. If you would like to pass through additional metrics to the staging models, add the below configurations to your `dbt_project.yml` file. These variables allow for the pass-through fields to be aliased (`alias`) if desired, but not required. Use the below format for declaring the respective pass-through variables:

> IMPORTANT: Make sure to exercise due diligence when adding metrics to these models. The metrics added by default have been vetted by the Fivetran team maintaining this package for accuracy. There are metrics included within the source reports, for example metric averages, which may be inaccurately represented at the grain for reports created in this package. You will want to ensure whichever metrics you pass through are indeed appropriate to aggregate at the respective reporting levels provided in this package.

```yml
vars:
    microsoft_ads__account_passthrough_metrics: 
      - name: "new_custom_field"
        alias: "custom_field"
    microsoft_ads__campaign_passthrough_metrics:
      - name: "this_field"
    microsoft_ads__ad_group_passthrough_metrics:
      - name: "unique_string_field"
        alias: "field_id"
    microsoft_ads__ad_passthrough_metrics: 
      - name: "new_custom_field"
        alias: "custom_field"
      - name: "a_second_field"
    microsoft_ads__keyword_passthrough_metrics:
      - name: "this_field"
    microsoft_ads__search_passthrough_metrics:
      - name: "unique_string_field"
        alias: "field_id"
```
#### Change the build schema
By default, this package builds the Microsoft Ads staging models (11 views, 11 tables) within a schema titled (`<target_schema>` + `_microsoft_ads_source`) in your destination. If this is not where you would like your Microsoft Ads staging data to be written to, add the following configuration to your root `dbt_project.yml` file:

```yml
models:
    microsoft_ads_source:
      +schema: my_new_schema_name # leave blank for just the target_schema
```
    
#### Change the source table references
If an individual source table has a different name than the package expects, add the table name as it appears in your destination to the respective variable. This is not available when unioning together multiple connections.
> IMPORTANT: See this project's [`dbt_project.yml`](https://github.com/fivetran/dbt_microsoft_ads_source/blob/main/dbt_project.yml) variable declarations to see the expected names.
    
```yml
vars:
    microsoft_ads_<default_source_table_name>_identifier: your_table_name 
```

</details>

### (Optional) Step 5: Orchestrate your models with Fivetran Transformations for dbt Core™
<details><summary>Expand for more details</summary>

Fivetran offers the ability for you to orchestrate your dbt project through [Fivetran Transformations for dbt Core™](https://fivetran.com/docs/transformations/dbt). Learn how to set up your project for orchestration through Fivetran in our [Transformations for dbt Core™ setup guides](https://fivetran.com/docs/transformations/dbt#setupguide).
    
</details>

## Does this package have dependencies?
This dbt package is dependent on the following dbt packages. These dependencies are installed by default within this package. For more information on the following packages, refer to the [dbt hub](https://hub.getdbt.com/) site.
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
          
## How is this package maintained and can I contribute?
### Package Maintenance
The Fivetran team maintaining this package _only_ maintains the latest version of the package. We highly recommend that you stay consistent with the [latest version](https://hub.getdbt.com/fivetran/microsoft_ads_source/latest/) of the package and refer to the [CHANGELOG](https://github.com/fivetran/dbt_microsoft_ads_source/blob/main/CHANGELOG.md) and release notes for more information on changes across versions.

### Contributions
A small team of analytics engineers at Fivetran develops these dbt packages. However, the packages are made better by community contributions.

We highly encourage and welcome contributions to this package. Check out [this dbt Discourse article](https://discourse.getdbt.com/t/contributing-to-a-dbt-package/657) on the best workflow for contributing to a package.

#### Contributors
We thank [everyone](https://github.com/fivetran/dbt_microsoft_ads_source/graphs/contributors) who has taken the time to contribute. Each PR, bug report, and feature request has made this package better and is truly appreciated.

A special thank you to [Seer Interactive](https://www.seerinteractive.com/?utm_campaign=Fivetran%20%7C%20Models&utm_source=Fivetran&utm_medium=Fivetran%20Documentation), who we closely collaborated with to introduce native conversion support to our Ad packages.

## Are there any resources available?
- If you have questions or want to reach out for help, see the [GitHub Issue](https://github.com/fivetran/dbt_microsoft_ads_source/issues/new/choose) section to find the right avenue of support for you.
- If you would like to provide feedback to the dbt package team at Fivetran or would like to request a new dbt package, fill out our [Feedback Form](https://www.surveymonkey.com/r/DQ7K7WW).
