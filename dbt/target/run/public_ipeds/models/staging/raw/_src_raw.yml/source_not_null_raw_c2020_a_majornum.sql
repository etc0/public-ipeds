
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select majornum
from `data-eng-ipeds`.`raw`.`c2020_a`
where majornum is null



  
  
      
    ) dbt_internal_test