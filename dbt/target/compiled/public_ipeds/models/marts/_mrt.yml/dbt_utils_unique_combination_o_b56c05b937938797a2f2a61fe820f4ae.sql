





with validation_errors as (

    select
        survey_year, state_abbreviation
    from `data-eng-ipeds`.`dbt_echristiansen`.`obt_completions_yoy_by_state`
    group by survey_year, state_abbreviation
    having count(*) > 1

)

select *
from validation_errors


