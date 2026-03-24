
  
    

    create or replace table `data-eng-ipeds`.`dbt_echristiansen`.`dim_institutions`
      
    
    

    
    OPTIONS()
    as (
      with 

institutions_by_year as (

    select * from `data-eng-ipeds`.`dbt_echristiansen`.`int_institutions_by_year`

)

select 
    
    to_hex(md5(cast(coalesce(cast(survey_year as string), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(institution_id as string), '_dbt_utils_surrogate_key_null_') as string)))
 as institution_key,  -- primary key
    survey_year,
    institution_id,
    institution_name,
    state_county,
    state_abbreviation
from institutions_by_year
    );
  