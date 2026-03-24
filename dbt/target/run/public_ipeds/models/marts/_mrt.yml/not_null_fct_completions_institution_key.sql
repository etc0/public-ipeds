
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select institution_key
from `data-eng-ipeds`.`dbt_echristiansen`.`fct_completions`
where institution_key is null



  
  
      
    ) dbt_internal_test