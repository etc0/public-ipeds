
  
    

    create or replace table `data-eng-ipeds`.`dbt_echristiansen`.`dim_survey_years`
      
    
    

    
    OPTIONS()
    as (
      with survey_years as (

    select * from `data-eng-ipeds`.`dbt_echristiansen`.`stg_seed__survey_years`

)

select
    survey_year,
    academic_year
from survey_years
    );
  