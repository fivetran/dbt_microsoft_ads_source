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
