
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  





with validation_errors as (

    select
        survey_year, institution_id, cip_code, award_level
    from `data-eng-ipeds`.`dbt_echristiansen`.`obt_completions`
    group by survey_year, institution_id, cip_code, award_level
    having count(*) > 1

)

select *
from validation_errors



  
  
      
    ) dbt_internal_test