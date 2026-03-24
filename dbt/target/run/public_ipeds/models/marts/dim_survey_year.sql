

  create or replace view `data-eng-ipeds`.`dbt_echristiansen`.`dim_survey_year`
  OPTIONS()
  as with survey_years as (

    select * from `data-eng-ipeds`.`dbt_echristiansen`.`stg_seed__survey_years`

)

select * from survey_years;

