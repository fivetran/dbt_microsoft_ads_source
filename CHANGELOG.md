# dbt_microsoft_ads_source v0.11.0
[PR #39](https://github.com/fivetran/dbt_microsoft_ads_source/pull/39) includes the following changes:

## Breaking Changes:
- Updated `stg_microsoft_ads__ad_history` to include more name-related fields:
  - `title`
  - `title_part_1`
  - `title_part_2`
  - `title_part_3`
  - `domain`
- For more information on these fields, refer to the [docs](https://fivetran.github.io/dbt_microsoft_ads_source/#!/model/model.microsoft_ads_source.stg_microsoft_ads__ad_history).

## Feature Updates:
- Introduced a new variable `microsoft_ads__ad_name_selector` to allow for `ad_name` in `stg_microsoft_ads__ad_history` to be customizable. By default `ad_name` is created from `title_part_1`, but you may override this by including the configuration shown below in your `dbt_project.yml` file. For more information, refer to the [README](https://github.com/fivetran/dbt_microsoft_ads_source/blob/main/README.md#change-how-ad-name-is-determined).

```yml
vars:
    microsoft_ads__ad_name_selector: coalesce(title_part_2, title_part_1) # using `title_part_2`, with `title_part_1` as a fallback if the former is `null`.
```

## Under the Hood
- Updated the `ad_history` seed data, `get_account_history_columns`, `src_microsoft_ads.yml`, and `stg_microsoft_ads.yml` files with the new fields.

## Documentation
- Corrected references to connectors and connections in the README. ([#36](https://github.com/fivetran/dbt_microsoft_ads_source/pull/36))
- Updated License

# dbt_microsoft_ads_source v0.10.0
[PR #32](https://github.com/fivetran/dbt_microsoft_ads_source/pull/32) includes the following updates:

## Feature Updates: Conversion Metrics
- We have added the following source fields to each `stg_microsoft_ads__<entity>_daily_report` model:
  - `conversions`: Number of conversions, measured by completion of an action by a customer after viewing your ad. This will default to `conversions_qualified` if synced (recommended), but will coalesce with the now-deprecated `conversions` field.
  - `conversions_value`: The `revenue` reported by the advertiser and attributed to conversions.
  - `all_conversions`: Number of *[all](https://learn.microsoft.com/en-us/advertising/reporting-service/conversionperformancereportcolumn?view=bingads-13#allconversions)* conversions, measured by completion of an action by a customer after viewing your ad. This will default to `all_conversions_qualified` if synced (recommended), but will coalesce with the now-deprecated `all_conversions` field. This field differs from the default `conversions` field in that it includes conversions associated with a conversion goal in which the [ExcludeFromBidding](https://learn.microsoft.com/en-us/advertising/campaign-management-service/conversiongoal?view=bingads-13#excludefrombidding) Microsoft Ads property is set to `true`.
  - `all_conversions_value` (not in `stg_microsoft_ads__account_daily_report`): The `revenue` reported by the advertiser and attributed to *all* conversions. This field differs from the default `conversions_value` field in that it includes revenue associated with a conversion goal in which the [ExcludeFromBidding](https://learn.microsoft.com/en-us/advertising/campaign-management-service/conversiongoal?view=bingads-13#excludefrombidding) Microsoft Ads property is set to `true`.
> The above new field additions are **breaking changes**.

## Under the Hood 
- Created `microsoft_ads_fill_pass_through_columns` and `microsoft_ads_add_pass_through_columns` macros to ensure that the new conversion fields are backwards compatible with users who have already included them via [passthrough columns](https://github.com/fivetran/dbt_microsoft_ads_source?tab=readme-ov-file#passing-through-additional-metrics).
- Updated seed files with new fields to test and validate on local data, provided specific casting to numeric (for currency) and integers.
- We've coalesced metrics in each `stg_microsoft_ads__<entity>_daily_report` model with `0` to avoid any potential null values that could disrupt aggregate calculations [in the `dbt_microsoft_ads` transformation package](https://github.com/fivetran/dbt_microsoft_ads).

## Documentation Update
- Updated source and staging yml files with new fields mentioned above.

## Contributors
- [Seer Interactive](https://www.seerinteractive.com/?utm_campaign=Fivetran%20%7C%20Models&utm_source=Fivetran&utm_medium=Fivetran%20Documentation)

# dbt_microsoft_ads_source v0.9.0

[PR #31](https://github.com/fivetran/dbt_microsoft_ads_source/pull/31) includes the following updates:

## Bug Fixes
- Accommodates when the `budget_name` and `budget_status` fields are populated within the `CAMPAIGN_PERFORMANCE_DAILY_REPORT` source table. These fields are now:
  - Included and documented in the `stg_microsoft_ads__campaign_daily_report` model.
  - Included in uniqueness tests on `stg_microsoft_ads__campaign_daily_report`, as they affect the grain of the report and may have therefore induced uniqueness test failures.
- Added proper documentation for the pre-existing `budget_association_status` field (also from `CAMPAIGN_PERFORMANCE_DAILY_REPORT`).

## Under the Hood
- Included auto-releaser GitHub Actions workflow to automate future releases.
- Updated the PR Templates for package maintainers to our most up-to-date standards.
- Upgraded integration test dbt-adapter versions.

# dbt_microsoft_ads_source v0.8.0
[PR #29](https://github.com/fivetran/dbt_microsoft_ads_source/pull/29) includes the following updates:
## Breaking changes
- Updated the following identifiers for consistency with the source name and compatibility with the union schema feature:

| current  | previous |
|----------|----------|
|microsoft_ads_account_performance_daily_report_identifier | microsoft_ads_account_daily_report_identifier |
|microsoft_ads_ad_group_performance_daily_report_identifier | microsoft_ads_ad_group_daily_report_identifier|
|microsoft_ads_ad_performance_daily_report_identifier | microsoft_ads_ad_daily_report_identifier|
|microsoft_ads_campaign_performance_daily_report_identifier | microsoft_ads_campaign_daily_report_identifier|
|microsoft_ads_keyword_performance_daily_report_identifier | microsoft_ads_keyword_daily_report_identifier|
|microsoft_ads_search_query_performance_daily_report_identifier | microsoft_ads_search_query_daily_report_identifier|

- If you are using the previous identifier, be sure to update to the current version!

## Feature update 🎉
- Unioning capability! This adds the ability to union source data from multiple microsoft_ads connectors. Refer to the [Union Multiple Connectors README section](https://github.com/fivetran/dbt_microsoft_ads_source/blob/main/README.md#union-multiple-connectors) for more details.

## Under the hood 🚘
- Updated tmp models to union source data using the `fivetran_utils.union_data` macro. 
- To distinguish which source each field comes from, added `source_relation` column in each staging model and applied the `fivetran_utils.source_relation` macro.
- Updated tests to account for the new `source_relation` column.

[PR #26](https://github.com/fivetran/dbt_microsoft_ads_source/pull/26) includes the following updates:
- Incorporated the new `fivetran_utils.drop_schemas_automation` macro into the end of each Buildkite integration test job.
- Updated the pull request [templates](/.github).
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
