-- created_at: 2026-03-18T20:01:49.345338586+00:00
-- finished_at: 2026-03-18T20:01:51.917038274+00:00
-- elapsed: 2.6s
-- outcome: success
-- dialect: bigquery
-- node_id: not available
-- query_id: not available
-- desc: dbt run query
select * from (select * from (
with 

cip_codes as (

    select * from `data-eng-ipeds`.`dbt_echristiansen`.`CIPCode2020`
    
)
SELECT * FROM cip_codes
) as __preview_sbq__ limit 1000
) limit 10;
