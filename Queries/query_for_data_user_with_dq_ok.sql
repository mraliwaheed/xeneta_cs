SELECT
    pa.day,
    ro.name AS origin_region,
    rd.name AS destination_region,
    pa.EQUIPMENT_ID,
    pa.avg_daily_price,
    pa.median_daily_price
FROM
    main_final.daily_aggregated_price pa
JOIN
    main_raw.ports po_origin ON pa.ORIGIN_PID = po_origin.pid
JOIN
    main_raw.regions ro ON po_origin.Slug = ro.slug
JOIN
    main_raw.ports po_destination ON pa.DESTINATION_PID = po_destination.pid
JOIN
    main_raw.regions rd ON po_destination.Slug = rd.slug
WHERE
    ro.name = 'China East Main'
    AND rd.name = 'US West Coast'
    AND pa.EQUIPMENT_ID = 2
    AND pa.day BETWEEN '2021-01-01' AND '2021-12-31'
    and pa.dq_ok = TRUE 
ORDER BY
    pa.day DESC;