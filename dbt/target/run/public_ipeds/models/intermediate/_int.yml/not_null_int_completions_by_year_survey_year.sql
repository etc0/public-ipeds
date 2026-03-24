
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select survey_year
from `data-eng-ipeds`.`dbt_echristiansen`.`int_completions_by_year`
where survey_year is null



  
  
      
    ) dbt_internal_test