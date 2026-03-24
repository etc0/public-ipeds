
    
    

with dbt_test__target as (

  select award_level as unique_field
  from `data-eng-ipeds`.`dbt_echristiansen`.`stg_seed__award_level_codes`
  where award_level is not null

)

select
    unique_field,
    count(*) as n_records

from dbt_test__target
group by unique_field
having count(*) > 1


