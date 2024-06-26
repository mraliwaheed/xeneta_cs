-- increment_charges.sql
{{ config(materialized='table') }}

WITH all_files AS (
    SELECT * FROM read_csv_auto('/Users/ZZ00OL808/xeneta_cs/data/files_to_load/input_files/2/DE_casestudy_charges_*.csv')
)

SELECT * FROM all_files
