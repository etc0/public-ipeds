
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select unitid
from `data-eng-ipeds`.`raw`.`c2018_a`
where unitid is null



  
  
      
    ) dbt_internal_test