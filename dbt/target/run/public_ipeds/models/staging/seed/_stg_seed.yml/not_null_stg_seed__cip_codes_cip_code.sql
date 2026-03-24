
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select cip_code
from `data-eng-ipeds`.`dbt_echristiansen`.`stg_seed__cip_codes`
where cip_code is null



  
  
      
    ) dbt_internal_test