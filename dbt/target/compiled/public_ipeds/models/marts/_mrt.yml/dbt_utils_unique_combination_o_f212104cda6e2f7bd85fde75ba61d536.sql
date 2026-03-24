





with validation_errors as (

    select
        survey_year, institution_id
    from `data-eng-ipeds`.`dbt_echristiansen`.`dim_institutions`
    group by survey_year, institution_id
    having count(*) > 1

)

select *
from validation_errors


