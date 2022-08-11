{{ config(enabled=var('ad_reporting__microsoft_ads_enabled', True)) }}

select * 
from {{ var('search_performance_daily_report') }}
