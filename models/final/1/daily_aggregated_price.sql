{{ config(
    materialized='incremental',                  
    schema='final',                             
    unique_key='equipment_id, ORIGIN_PID, DESTINATION_PID, day'  
) }}

WITH aggregated_data AS (
    SELECT
        equipment_id,
        ORIGIN_PID,
        DESTINATION_PID,
        day,
        AVG(total_usd_value) AS avg_daily_price,
        MEDIAN(total_usd_value) AS median_daily_price,
        COUNT(DISTINCT company_id) >= 5 AS dq_ok_company,
        COUNT(DISTINCT supplier_id) >= 2 AS dq_ok_supplier,
        (COUNT(DISTINCT company_id) >= 5 AND COUNT(DISTINCT supplier_id) >= 2) AS dq_ok
    FROM {{ ref('daily_prices') }}
    GROUP BY
        equipment_id,
        ORIGIN_PID,
        DESTINATION_PID,
        day
)

SELECT *
FROM aggregated_data

{% if is_incremental() %}
LEFT JOIN {{ this }} prev
    ON aggregated_data.equipment_id = prev.equipment_id
    AND aggregated_data.ORIGIN_PID = prev.ORIGIN_PID
    AND aggregated_data.DESTINATION_PID = prev.DESTINATION_PID
    AND aggregated_data.day = prev.day
WHERE prev.equipment_id IS NULL
{% endif %}