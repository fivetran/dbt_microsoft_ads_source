# dbt_microsoft_ads_source v0.7.0

## 🚨 Breaking Changes 🚨:
[PR #22](https://github.com/fivetran/dbt_microsoft_ads_source/pull/22) includes the following breaking changes:
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
- `packages.yml` has been updated to reflect new default `fivetran/fivetran_utils` version, previously `[">=0.3.0", "<0.4.0"]` now `[">=0.4.0", "<0.5.0"]`.

[PR #23](https://github.com/fivetran/dbt_microsoft_ads_source/pull/23) includes the following updates:
- Added `budget_association_status` into the `stg_microsoft_ads__campaign_daily_report` table in order to account for campaign budgets that end midday. Including `budget_association_status` as another grain to test by, will reduce tests failing due to non-uniqueness of rows. 


# dbt_microsoft_ads v0.6.1

## Bug Fixes
[PR #24](https://github.com/fivetran/dbt_microsoft_ads_source/pull/24) includes the following updates:
- Added `budget_association_status` into the `stg_microsoft_ads__campaign_daily_report` table in order to account for campaign budgets that end midday. Including `budget_association_status` as another grain to test by, will reduce tests failing due to non-uniqueness of rows. 


## Contributors 
- @MaximeLagresle - Thank you for bringing up [this issue](https://github.com/fivetran/dbt_microsoft_ads_source/issues/21) in office hours!

# dbt_microsoft_ads_source v0.6.0
## 🚨 Breaking Changes 🚨
[PR #20](https://github.com/fivetran/dbt_microsoft_ads_source/pull/20) makes the below updates that may affect your workflow:
- `modified_timestamp` columns have been renamed to `modified_at` and `is_most_recent_version` has been renamed to `is_most_recent_record` to reflect more recent package coding standards for the below models:
  - `stg_microsoft_ads__account_history`
  - `stg_microsoft_ads__ad_group_history`
  - `stg_microsoft_ads__ad_history`
  - `stg_microsoft_ads__ad_performance_daily_report`
  - `stg_microsoft_ads__campaign_history`
- Deprecating `*_version_id` fields in `*_history` models.

## 🎉 Feature Enhancements 🎉
We have added the below feature enhancements to this package in [PR #20](https://github.com/fivetran/dbt_microsoft_ads_source/pull/20):
- Add `get_*_columns` macros for previously included models and newly added models.
- Updated staging model standards on old models to conform with recent package development standards. Updates were made to the below models:
  - `stg_microsoft_ads__account_history`
  - `stg_microsoft_ads__ad_group_history`
  - `stg_microsoft_ads__ad_history`
  - `stg_microsoft_ads__ad_performance_daily_report`
  - `stg_microsoft_ads__campaign_history`
- New history and daily performance staging models including:
  - `stg_microsoft_ads__account_daily_report` 
  - `stg_microsoft_ads__campaign_daily_report` 
  - `stg_microsoft_ads__ad_group_daily_report` 
  - `stg_microsoft_ads__search_daily_report`
  - `stg_microsoft_ads__keyword_daily_report`
  - `stg_microsoft_ads__keyword_history`
- `README` updates for easier navigation and use of the package.
- Addition of identifier variables for each of the source tables to allow for further flexibility in source table direction within the dbt project.
- More robust testing for better data integrity including: 
  - Freshness tests
  - Model grain tests
- Inclusion of passthrough metrics:
  - `microsoft_ads__account_passthrough_metrics`
  - `microsoft_ads__campaign_passthrough_metrics`
  - `microsoft_ads__ad_group_passthrough_metrics`
  - `microsoft_ads__ad_passthrough_metrics`
  - `microsoft_ads__keyword_passthrough_metrics`
  - `microsoft_ads__search_passthrough_metrics`
> This applies to all passthrough columns within the `dbt_microsoft_ads_source` package and not just the `microsoft_ads__ad_passthrough_metrics` example.
```yml
vars:
  microsoft_ads__ad_passthrough_metrics:
    - name: "my_field_to_include" # Required: Name of the field within the source.
      alias: "field_alias" # Optional: If you wish to alias the field within the staging model.
```
- Additional documentation for new models added.

# dbt_microsoft_ads_source v0.5.0

## 🚨 Breaking Changes 🚨
- We have migrated URL and UTM logic into the "modeling" package in order to adhere to our definitions of "source" and "modeling" packages; specifically, "source" packages are meant to only do light renaming and subsetting columns from the source while "modeling" packages perform more complex transformations, including string extraction for new fields. 
- Changes include:
  - Removed `url_fields` CTE from `stg_microsoft_ads__ad_history` model
  - Removed `microsoft_auto_tagging_enabled` conditional statements from `stg_microsoft_ads__ad_history` model
- Please reference [dbt_microsoft_ads](https://github.com/fivetran/dbt_microsoft_ads)'s models if you are using any of the below fields from the `stg_microsoft_ads__ad_history` in this package:
  - `base_url`
  - `url_host`
  - `url_path`
  - `utm_source`
  - `utm_medium`
  - `utm_campaign`
  - `utm_content`
  - `utm_term`
- Additionally, if you have declared the `microsoft_auto_tagging_enabled` variable for `microsoft_ads_source` in your `dbt_project.yml`, you may declare the variable globally or for `microsoft_ads`.  
# dbt_microsoft_ads_source v0.4.1
## Bug Fixes
- Adjusts the `stg_microsoft_ads__ad_history` model in order to avoid fanout, caused by joining with the `ad_group_history` table. Now, the join is limited to the most recent record of ad groups in `ad_group_history` ([#13](https://github.com/fivetran/dbt_microsoft_ads_source/issues/13))

# dbt_microsoft_ads_source v0.4.0
🎉 dbt v1.0.0 Compatibility 🎉
## 🚨 Breaking Changes 🚨
- Adjusts the `require-dbt-version` to now be within the range [">=1.0.0", "<2.0.0"]. Additionally, the package has been updated for dbt v1.0.0 compatibility. If you are using a dbt version <1.0.0, you will need to upgrade in order to leverage the latest version of the package.
  - For help upgrading your package, I recommend reviewing this GitHub repo's Release Notes on what changes have been implemented since your last upgrade.
  - For help upgrading your dbt project to dbt v1.0.0, I recommend reviewing dbt-labs [upgrading to 1.0.0 docs](https://docs.getdbt.com/docs/guides/migration-guide/upgrading-to-1-0-0) for more details on what changes must be made.
- Upgrades the package dependency to refer to the latest `dbt_fivetran_utils`. The latest `dbt_fivetran_utils` package also has a dependency on `dbt_utils` [">=0.8.0", "<0.9.0"].
  - Please note, if you are installing a version of `dbt_utils` in your `packages.yml` that is not in the range above then you will encounter a package dependency error.

# dbt_microsoft_ads_source v0.1.0 -> v0.3.1
Refer to the relevant release notes on the Github repository for specific details for the previous releases. Thank you!
