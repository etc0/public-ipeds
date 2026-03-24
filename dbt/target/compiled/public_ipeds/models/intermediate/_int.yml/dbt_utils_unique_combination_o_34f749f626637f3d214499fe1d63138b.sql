





with validation_errors as (

    select
        survey_year, institution_id, cip_code, major_number, award_level
    from `data-eng-ipeds`.`dbt_echristiansen`.`int_completions_by_year`
    group by survey_year, institution_id, cip_code, major_number, award_level
    having count(*) > 1

)

select *
from validation_errors


