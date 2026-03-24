
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select major_number
from `data-eng-ipeds`.`dbt_echristiansen`.`fct_completions`
where major_number is null



  
  
      
    ) dbt_internal_test