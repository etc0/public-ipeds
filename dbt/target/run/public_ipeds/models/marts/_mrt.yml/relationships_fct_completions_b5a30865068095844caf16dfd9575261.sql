
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

with child as (
    select cip_code as from_field
    from `data-eng-ipeds`.`dbt_echristiansen`.`fct_completions`
    where cip_code is not null
),

parent as (
    select cip_code as to_field
    from `data-eng-ipeds`.`dbt_echristiansen`.`dim_cip_codes`
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null



  
  
      
    ) dbt_internal_test