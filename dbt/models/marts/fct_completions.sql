{{
    config(
        partition_by = {
            "field": "survey_year",
            "data_type": "int64",
            "range": {
                "start": 2018,
                "end": 2035,
                "interval": 1
            }
        },
        cluster_by = ["institution_key", "cip_code", "award_level"]
    )
}}

with 

completions_by_year as (

    select * from {{ ref('int_completions_by_year') }} as a

)

select 
    {{ dbt_utils.generate_surrogate_key(['survey_year', 'institution_id', 'cip_code', 'major_number', 'award_level']) }} as completion_key,  -- primary key
    {{ institutions_key() }} as institution_key,
    survey_year,
    institution_id,
    cip_code,
    award_level,
    total_completions,
    male_completions,
    female_completions
from completions_by_year