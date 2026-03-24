
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select award_level
from `data-eng-ipeds`.`dbt_echristiansen`.`obt_completions`
where award_level is null



  
  
      
    ) dbt_internal_test