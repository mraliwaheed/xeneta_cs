-- C:\Users\ZZ00OL808\xeneta_cs\models\raw\datapoints_1.sql
{{ config(
    materialized='incremental',
    schema='raw',
    unique_key='D_ID'  
) }}

WITH all_files AS (
    SELECT *
    FROM read_csv_auto('/Users/ZZ00OL808/xeneta_cs/data/files_to_load/input_files/DE_casestudy_datapoints_*.csv')
)

SELECT *
FROM all_files

{% if is_incremental() %}
WHERE D_ID NOT IN (
    SELECT D_ID
    FROM {{ this }}
)
{% endif %}
