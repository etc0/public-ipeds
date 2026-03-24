
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select unitid
from `data-eng-ipeds`.`raw`.`hd2019`
where unitid is null



  
  
      
    ) dbt_internal_test