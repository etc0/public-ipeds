
    
    

with dbt_test__target as (

  select completion_key as unique_field
  from `data-eng-ipeds`.`dbt_echristiansen`.`fct_completions`
  where completion_key is not null

)

select
    unique_field,
    count(*) as n_records

from dbt_test__target
group by unique_field
having count(*) > 1


