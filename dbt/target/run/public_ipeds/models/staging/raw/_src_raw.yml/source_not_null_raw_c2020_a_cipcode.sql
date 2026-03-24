
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select cipcode
from `data-eng-ipeds`.`raw`.`c2020_a`
where cipcode is null



  
  
      
    ) dbt_internal_test