
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select institution_id
from `data-eng-ipeds`.`dbt_echristiansen`.`obt_completions`
where institution_id is null



  
  
      
    ) dbt_internal_test