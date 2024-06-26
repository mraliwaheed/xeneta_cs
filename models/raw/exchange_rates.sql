{{ config(materialized='table', schema='raw') }}
SELECT * FROM read_csv_auto('/Users/ZZ00OL808/xeneta_cs/data/files_to_load\input_files/DE_casestudy_exchange_rates.csv')
