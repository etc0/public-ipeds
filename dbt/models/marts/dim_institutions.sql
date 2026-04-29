with 

institutions_by_year as (

    select
        survey_year,
        institution_id,
        institution_name,
        state_county,
        state_abbreviation 
    from {{ ref('int_institutions_by_year') }}

)

select 
    {{ institutions_key() }} as institution_key,  -- primary key
    survey_year,
    institution_id,
    institution_name,
    state_county,
    state_abbreviation
from institutions_by_year