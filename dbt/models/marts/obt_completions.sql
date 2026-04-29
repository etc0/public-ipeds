with 

survey_years as (
    select 
        survey_year,
        academic_year,
    from {{ ref('dim_survey_years') }}
),

institutions as (
    select 
        institution_key,
        institution_id,
        institution_name,
        state_county,
        state_abbreviation
    from {{ ref('dim_institutions') }} 
),

cip_codes as (
    select 
        cip_code,
        cip_title,
        cip_family_title,
        is_stem,
    from {{ ref('dim_cip_codes') }}
),

award_levels as (
    select 
        award_level,
        award_level_description,
        award_level_category
    from {{ ref('dim_award_levels') }}
),

completions as (
    select    
        survey_year, 
        institution_key,
        cip_code,
        award_level,
        total_completions,
        male_completions,
        female_completions,
        completion_key 
    from {{ ref('fct_completions') }}
),

obt as (
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

    from completions f
    left join survey_years s 
        on f.survey_year = s.survey_year
    left join institutions i 
        on f.institution_key = i.institution_key
    left join cip_codes c 
        on f.cip_code = c.cip_code
    left join award_levels a 
        on f.award_level = a.award_level
)

select * from obt
