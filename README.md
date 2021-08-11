[![Apache License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) ![dbt logo and version](https://img.shields.io/static/v1?logo=dbt&label=dbt-version&message=0.20.x&color=orange)
# Microsoft Advertising (Source)

This package models Microsoft Advertising data from [Fivetran's connector](https://fivetran.com/docs/applications/microsoft-advertising). It uses data in the format described by [this ERD](https://fivetran.com/docs/applications/microsoft-advertising#schemainformation).

This package enriches your Fivetran data by doing the following:

* Adds descriptions to tables and columns that are synced using Fivetran
* Adds column-level testing where applicable. For example, all primary keys are tested for uniqueness and non-null values.
* Models staging tables, which will be used in our transform package

## Models

This package contains staging models, designed to work simultaneously with our [Microsoft Advertising modeling package](https://github.com/fivetran/dbt_microsoft_ads) and our [multi-platform Ad Reporting package](https://github.com/fivetran/dbt_ad_reporting). The staging models name columns consistently across all packages:
* Boolean fields are prefixed with `is_` or `has_`
* Timestamps are appended with `_at`
* ID primary keys are prefixed with the name of the table. For example, the campaign table's ID column is renamed `campaign_id`.

## Installation Instructions
Check [dbt Hub](https://hub.getdbt.com/) for the latest installation instructions, or [read the dbt docs](https://docs.getdbt.com/docs/package-management) for more information on installing packages.

Include in your `packages.yml`

```yaml
packages:
  - package: fivetran/microsoft_ads_source
    version: [">=0.3.0", "<0.4.0"]
```

## Configuration
By default, this package looks for your Microsoft Advertising data in the `bingads` schema of your [target database](https://docs.getdbt.com/docs/running-a-dbt-project/using-the-command-line-interface/configure-your-profile). If this is not where your Microsoft Advertising data is, add the following configuration to your `dbt_project.yml` file:

```yml
# dbt_project.yml

...
config-version: 2

vars:
    microsoft_ads_schema: your_schema_name
    microsoft_ads_database: your_database_name
```
### UTM Auto Tagging Feature
This package assumes you are manually adding UTM tags to the `final_url` field within the `ad_history` table. If you are leveraging the auto-tag feature within Microsoft Ads then you will want to enable the `microsoft_auto_tagging_enabled` variable to correctly populate the UTM fields within the `stg_microsoft_ads__ad_history` model.
```yml
vars:
    microsoft_ads_source:
      microsoft_auto_tagging_enabled: true # False by default
```

### Changing the Build Schema
By default this package will build the Microsoft Ads staging models within a schema titled (<target_schema> + `_stg_microsoft_ads`) in your target database. If this is not where you would like your Microsoft Ads staging data to be written to, add the following configuration to your `dbt_project.yml` file:

```yml
# dbt_project.yml

...
models:
    microsoft_ads_source:
      +schema: my_new_schema_name # leave blank for just the target_schema
```
## Database Support

This package has been tested on BigQuery, Snowflake, Redshift, Postgres, and Databricks.

### Databricks Dispatch Configuration
dbt `v0.20.0` introduced a new project-level dispatch configuration that enables an "override" setting for all dispatched macros. If you are using a Databricks destination with this package you will need to add the below (or a variation of the below) dispatch configuration within your `dbt_project.yml`. This is required in order for the package to accurately search for macros within the `dbt-labs/spark_utils` then the `dbt-labs/dbt_utils` packages respectively.
```yml
# dbt_project.yml

dispatch:
  - macro_namespace: dbt_utils
    search_order: ['spark_utils', 'dbt_utils']
```

## Contributions

Additional contributions to this package are very welcome! Please create issues
or open PRs against `master`. Check out 
[this post](https://discourse.getdbt.com/t/contributing-to-a-dbt-package/657) 
on the best workflow for contributing to a package.

## Resources:
- Provide [feedback](https://www.surveymonkey.com/r/DQ7K7WW) on our existing dbt packages or what you'd like to see next
- Have questions or feedback, or need help? Book a time during our office hours [here](https://calendly.com/fivetran-solutions-team/fivetran-solutions-team-office-hours) or shoot us an email at solutions@fivetran.com.
- Find all of Fivetran's pre-built dbt packages in our [dbt hub](https://hub.getdbt.com/fivetran/)
- Learn how to orchestrate dbt transformations with Fivetran [here](https://fivetran.com/docs/transformations/dbt).
- Learn more about Fivetran overall [in our docs](https://fivetran.com/docs)
- Check out [Fivetran's blog](https://fivetran.com/blog)
- Learn more about dbt [in the dbt docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](http://slack.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the dbt blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
