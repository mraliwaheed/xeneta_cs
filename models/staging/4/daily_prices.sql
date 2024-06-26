--daily_prices.sql
{{ config(
    materialized='incremental',
    schema='staging',
    unique_key='d_id, day'
) }}

-- Calculate daily prices for each datapoint
WITH daily_prices AS (
    SELECT
        d_id,
        EQUIPMENT_ID,
        ORIGIN_PID,
        DESTINATION_PID,
        COMPANY_ID,
        SUPPLIER_ID,
        exchange_rate_day AS day,
        SUM(usd_value) AS total_usd_value
    FROM {{ ref('charges_usd') }}
    GROUP BY 
        d_id,  
        EQUIPMENT_ID,  
        ORIGIN_PID,  
        DESTINATION_PID,  
        COMPANY_ID,  
        SUPPLIER_ID,  
        exchange_rate_day
)

SELECT *
FROM daily_prices

{% if is_incremental() %}
LEFT JOIN {{ this }} prev
    ON daily_prices.d_id = prev.d_id
    AND daily_prices.day = prev.day
WHERE prev.d_id IS NULL
{% endif %}
