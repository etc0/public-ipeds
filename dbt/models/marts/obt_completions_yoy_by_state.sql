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
        state_abbreviation
    from {{ ref('dim_institutions') }} 
),

completions as (
    select    
        survey_year, 
        institution_key,
        total_completions,
        male_completions,
        female_completions
    from {{ ref('fct_completions') }}
),


completions_by_year_state as (
    select
        -- Survey year attributes
        s.survey_year,
        s.academic_year,

        -- Institution attributes
        i.state_abbreviation,

        -- Fact measures
        sum(f.total_completions) as state_completions

    from completions f
    left join survey_years s 
        on f.survey_year = s.survey_year
    left join institutions i 
        on f.institution_key = i.institution_key
    group by 
        s.survey_year,
        s.academic_year,
        i.state_abbreviation
),

obt as (
    select 
        c.survey_year,
        c.academic_year,
        p.academic_year     as prior_academic_year,
        c.state_abbreviation,
        c.state_completions,
        p.state_completions as prior_year_state_completions,
        c.state_completions - p.state_completions as yoy_change,
        case 
            when p.state_completions > 0 
                then (c.state_completions - p.state_completions) / p.state_completions * 100
            else
                NULL
        end                 as yoy_growth_rate_pct
    from completions_by_year_state c
    left join completions_by_year_state p
        on  p.survey_year = c.survey_year - 1
        and p.state_abbreviation = c.state_abbreviation
    where p.survey_year is not null
)

select * from obt