
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select institution_code
from `data-eng-ipeds`.`dbt_echristiansen`.`obt_completions`
where institution_code is null



  
  
      
    ) dbt_internal_test