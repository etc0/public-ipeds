
    
    

with dbt_test__target as (

  select institution_key as unique_field
  from `data-eng-ipeds`.`dbt_echristiansen`.`dim_institutions`
  where institution_key is not null

)

select
    unique_field,
    count(*) as n_records

from dbt_test__target
group by unique_field
having count(*) > 1


