
  
    

    create or replace table `data-eng-ipeds`.`dbt_echristiansen`.`fct_completions`
      
    partition by range_bucket(
            survey_year,
            generate_array(2018, 2035, 1)
        )
    cluster by institution_key, cip_code, award_level

    
    OPTIONS()
    as (
      

with 

completions_by_year as (

    select * from `data-eng-ipeds`.`dbt_echristiansen`.`int_completions_by_year` as a

)

select 
    to_hex(md5(cast(coalesce(cast(survey_year as string), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(institution_id as string), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(cip_code as string), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(major_number as string), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(award_level as string), '_dbt_utils_surrogate_key_null_') as string))) as completion_key,  -- primary key
    
    to_hex(md5(cast(coalesce(cast(survey_year as string), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(institution_id as string), '_dbt_utils_surrogate_key_null_') as string)))
 as institution_key,
    survey_year,
    institution_id,
    cip_code,
    award_level,
    total_completions,
    male_completions,
    female_completions
from completions_by_year
    );
  