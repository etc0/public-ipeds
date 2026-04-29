with 

survey_years as (

    select * from {{ ref('stg_seed__survey_years') }}

)

select
    survey_year,
    academic_year
from survey_years