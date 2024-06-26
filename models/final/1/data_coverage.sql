-- models/metadata/data_coverage.sql
{{ config(materialized='view', 
    schema = 'final' ) }}

select
  day,
  count(distinct (origin_pid, destination_pid, equipment_id)) as covered_lanes_count
from {{ ref('daily_aggregated_price') }}
where dq_ok = true
group by day
