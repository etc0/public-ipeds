
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  





with validation_errors as (

    select
        unitid, cipcode, majornum, awlevel
    from `data-eng-ipeds`.`raw`.`c2023_a`
    group by unitid, cipcode, majornum, awlevel
    having count(*) > 1

)

select *
from validation_errors



  
  
      
    ) dbt_internal_test