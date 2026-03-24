with survey_years as (

    select * from `data-eng-ipeds`.`dbt_echristiansen`.`stg_seed__survey_years`

)

select * from survey_years