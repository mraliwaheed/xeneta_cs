-- increment_datapoints.sql
{{ config(materialized='table',
    schema='raw') }}

WITH all_files AS (
    SELECT * FROM read_csv_auto('/Users/ZZ00OL808/xeneta_cs/data/files_to_load/input_files/2/DE_casestudy_datapoints_*.csv')
)

SELECT * FROM all_files
