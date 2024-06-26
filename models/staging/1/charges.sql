-- C:\Users\ZZ00OL808\xeneta_cs\models\staging\1\charges.sql
{{ config(
    materialized='incremental',
    schema='staging',
    unique_key='D_ID'  
) }}

-- Create staging.charges table from main_raw.charges_1 after basic validation
WITH validated_data AS (
    SELECT *
    FROM {{ source('main_raw', 'charges_1') }}
    WHERE CHARGE_VALUE IS NOT NULL 
      AND currency IS NOT NULL
)

SELECT *
FROM validated_data

{% if is_incremental() %}
WHERE D_ID NOT IN (
    SELECT D_ID
    FROM {{ this }}
)
{% endif %}
