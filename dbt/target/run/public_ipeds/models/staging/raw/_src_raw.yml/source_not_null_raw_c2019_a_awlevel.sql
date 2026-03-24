
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select awlevel
from `data-eng-ipeds`.`raw`.`c2019_a`
where awlevel is null



  
  
      
    ) dbt_internal_test