
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  





with validation_errors as (

    select
        survey_year, institution_id
    from `data-eng-ipeds`.`dbt_echristiansen`.`int_institutions_by_year`
    group by survey_year, institution_id
    having count(*) > 1

)

select *
from validation_errors



  
  
      
    ) dbt_internal_test