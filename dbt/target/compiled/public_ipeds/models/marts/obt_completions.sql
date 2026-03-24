-- models/marts/obt_completions.sql


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

from `data-eng-ipeds`.`dbt_echristiansen`.`fct_completions` f
left join `data-eng-ipeds`.`dbt_echristiansen`.`dim_survey_years` s 
    on f.survey_year = s.survey_year
left join `data-eng-ipeds`.`dbt_echristiansen`.`dim_institutions` i 
    on f.institution_key = i.institution_key
left join `data-eng-ipeds`.`dbt_echristiansen`.`dim_cip_codes` c 
    on f.cip_code = c.cip_code
left join `data-eng-ipeds`.`dbt_echristiansen`.`dim_award_levels` a 
    on f.award_level = a.award_level