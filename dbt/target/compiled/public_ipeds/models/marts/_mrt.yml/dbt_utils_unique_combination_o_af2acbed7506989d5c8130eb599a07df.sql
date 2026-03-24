





with validation_errors as (

    select
        survey_year, institution_id, cip_code, award_level
    from `data-eng-ipeds`.`dbt_echristiansen`.`fct_completions`
    group by survey_year, institution_id, cip_code, award_level
    having count(*) > 1

)

select *
from validation_errors


