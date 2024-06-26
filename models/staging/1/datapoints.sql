-- C:\Users\ZZ00OL808\xeneta_cs\models\staging\1\datapoints.sql
{{ config(
    materialized='incremental',
    schema='staging',
    unique_key='D_ID'  
) }}

-- Create staging.datapoints table from main_raw.datapoints_1 after basic validation
WITH validated_data AS (
    SELECT *
    FROM {{ source('main_raw', 'datapoints_1') }}
    WHERE ORIGIN_PID IS NOT NULL 
      AND DESTINATION_PID IS NOT NULL
)

SELECT *
FROM validated_data

{% if is_incremental() %}
WHERE D_ID NOT IN (
    SELECT D_ID
    FROM {{ this }}
)
{% endif %}
