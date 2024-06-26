SELECT count(1)
FROM xeneta.main_final.daily_aggregated_price_old where dq_ok = TRUE ;

SELECT count(1)
FROM xeneta.main_final.daily_aggregated_price  where dq_ok = TRUE ;

--------------------

SELECT day, covered_lanes_count
FROM xeneta.main_final.data_coverage;