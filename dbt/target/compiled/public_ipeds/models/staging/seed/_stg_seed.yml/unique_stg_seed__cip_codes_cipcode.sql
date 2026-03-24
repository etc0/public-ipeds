
    
    

with dbt_test__target as (

  select cipcode as unique_field
  from `data-eng-ipeds`.`dbt_echristiansen`.`stg_seed__cip_codes`
  where cipcode is not null

)

select
    unique_field,
    count(*) as n_records

from dbt_test__target
group by unique_field
having count(*) > 1


