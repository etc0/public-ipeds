with 

survey_years as (
    select * from {{ ref('ipeds_survey_years') }}
)

select * from survey_years