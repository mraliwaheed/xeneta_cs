-- daily_aggregated_price_old.sql
{{ config(
    materialized='table',
    schema='final',
    alias='daily_aggregated_price_old'
) }}

SELECT
    EQUIPMENT_ID,
    ORIGIN_PID,
    DESTINATION_PID,
    day,
    avg_daily_price,
    median_daily_price,
    dq_ok_company,
    dq_ok_supplier,
    dq_ok
FROM {{ ref('daily_aggregated_price') }}
