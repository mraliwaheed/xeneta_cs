-- processed_files.sql
{{ config(materialized='table') }}

SELECT * FROM (
    VALUES
        ('datapoints_1.csv', current_timestamp),
        ('charges_1.csv', current_timestamp)
) AS t(filename, processed_at)
