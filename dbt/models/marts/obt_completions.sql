-- models/marts/obt_completions.sql
{{
    config(
        materialized='table',
        partition_by={
            "field": "survey_year",
            "data_type": "int64",
            "range": {
                "start": 2018,
                "end": 2035,
                "interval": 1
            }
        },
        cluster_by=["institution_name", "cip_title", "state_abbreviation", "award_level_description"]
    )
}}

select
    -- Survey year attributes
    s.survey_year,
    s.academic_year,

    -- Institution attributes
    i.institution_id,
    i.institution_name,
    i.state_county,
    i.state_abbreviation,

    -- CIP attributes
    c.cip_code,
    c.cip_title,
    c.cip_family_title,
    c.is_stem,

    -- Award level attributes
    a.award_level,
    a.award_level_description,
    a.award_level_category,

    -- Fact measures
    f.total_completions,
    f.male_completions,
    f.female_completions,
    f.completion_key

from {{ ref('fct_completions') }} f
left join {{ ref('dim_survey_years') }} s 
    on f.survey_year = s.survey_year
left join {{ ref('dim_institutions') }} i 
    on f.institution_key = i.institution_key
left join {{ ref('dim_cip_codes') }} c 
    on f.cip_code = c.cip_code
left join {{ ref('dim_award_levels') }} a 
    on f.award_level = a.award_level