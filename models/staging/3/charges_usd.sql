--C:\Users\ZZ00OL808\xeneta_cs\models\staging\3\charges_usd.sql
{{ config(
    materialized='incremental',
    schema='staging',
    unique_key='d_id, exchange_rate_day'
) }}

-- Create staging.charges_usd table from staging.datapoint_charges and raw.exchange_rates
WITH updated_data AS (
    SELECT 
        dp.d_id,
        dp.VALID_FROM,
        dp.VALID_TO,
        dp.EQUIPMENT_ID,
        dp.ORIGIN_PID,
        dp.DESTINATION_PID,
        dp.COMPANY_ID,
        dp.SUPPLIER_ID,
        dp.CHARGE_VALUE / er.rate AS usd_value,
        er.day AS exchange_rate_day
    FROM {{ ref('datapoint_charges') }} dp
    JOIN {{ ref('exchange_rates') }} er 
      ON dp.currency = er.CURRENCY 
      AND dp.VALID_FROM <= er.day 
      AND dp.VALID_TO >= er.day
)

SELECT *
FROM updated_data

{% if is_incremental() %}
WHERE NOT EXISTS (
    SELECT 1
    FROM {{ this }} prev
    WHERE prev.d_id = updated_data.d_id
      AND prev.exchange_rate_day = updated_data.exchange_rate_day
)
{% endif %}
