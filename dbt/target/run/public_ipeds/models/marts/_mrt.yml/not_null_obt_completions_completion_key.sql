
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select completion_key
from `data-eng-ipeds`.`dbt_echristiansen`.`obt_completions`
where completion_key is null



  
  
      
    ) dbt_internal_test