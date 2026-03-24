

  create or replace view `data-eng-ipeds`.`dbt_echristiansen`.`stg_seed__survey_years`
  OPTIONS()
  as with 

survey_years as (
    select * from `data-eng-ipeds`.`dbt_echristiansen`.`ipeds_survey_years`
)

select * from survey_years;

