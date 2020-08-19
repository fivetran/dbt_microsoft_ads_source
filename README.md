# Bing Ads (Source)

This package models Bing Ads data from [Fivetran's connector](https://fivetran.com/docs/applications/microsoft-advertising). It uses data in the format described by [this ERD](https://docs.google.com/presentation/d/1xNeRCtU5dNVy01kTjE-ydX_BLoRDgKZOHGci1vUKDFg/edit).

This package enriches your Fivetran data by doing the following:

* Adds descriptions to tables and columns that are synced using Fivetran
* Adds column-level testing where applicable. For example, all primary keys are tested for uniqueness and non-null values.
* Models staging tables, which will be used in our transform package

## Models

This package contains staging models, designed to work simultaneously with our [Bing Ads modeling package](https://github.com/fivetran/dbt_bing_ads). The staging models:

* Name columns consistently across all packages:
* Boolean fields are prefixed with is_ or has_
* Timestamps are appended with _at
* ID primary keys are prefixed with the name of the table. For example, the campaign table's ID column is renamed campaign_id.

## Installation Instructions
Check [dbt Hub](https://hub.getdbt.com/) for the latest installation instructions, or [read the dbt docs](https://docs.getdbt.com/docs/package-management) for more information on installing packages.

## Configuration
By default this package will look for your Bing Ads data in the `bing_ads` schema of your [target database](https://docs.getdbt.com/docs/running-a-dbt-project/using-the-command-line-interface/configure-your-profile). If this is not where your Bing Ads data is, please add the following configuration to your `dbt_project.yml` file:

```yml
# dbt_project.yml

...
config-version: 2

vars:
    bing_ads_schema: your_database_name
    bing_ads_database: your_schema_name 
```

## Contributions

Additional contributions to this package are very welcome! Please create issues
or open PRs against `master`. Check out 
[this post](https://discourse.getdbt.com/t/contributing-to-a-dbt-package/657) 
on the best workflow for contributing to a package.

## Resources:
- Learn more about Fivetran [here](https://fivetran.com/docs)
- Check out [Fivetran's blog](https://fivetran.com/blog)
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](http://slack.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
