-- C:\Users\ZZ00OL808\xeneta_cs\models\staging\2\datapoint_charges.sql
{{ config(
    materialized='incremental',
    schema='staging',
    unique_key='D_ID'  
) }}

-- Create staging.datapoint_charges table from staging.datapoints and staging.charges
WITH joined_data AS (
    SELECT 
        dp.d_id,
        dp.VALID_FROM,
        dp.VALID_TO,
        dp.EQUIPMENT_ID,
        dp.ORIGIN_PID,
        dp.DESTINATION_PID,
        dp.COMPANY_ID,
        dp.SUPPLIER_ID,
        c.currency,
        c.CHARGE_VALUE
    FROM {{ ref('datapoints') }} dp
    JOIN {{ ref('charges') }} c 
      ON dp.d_id = c.d_id
)

SELECT *
FROM joined_data

{% if is_incremental() %}
WHERE D_ID NOT IN (
    SELECT D_ID
    FROM {{ this }}
)
{% endif %}
