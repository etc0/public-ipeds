

  create or replace view `data-eng-ipeds`.`dbt_echristiansen`.`stg_seed__award_level_codes`
  OPTIONS()
  as with 

award_levels as (
    select * from `data-eng-ipeds`.`dbt_echristiansen`.`award_level_codes`
), 

rename as (

    select 
        awlevel_code as award_level, 
        awlevel_description as award_level_description, 
        awlevel_category as award_level_category
    from award_levels

    -- Add values that appear in completions but descriptions aren't available
    union all 

    select 
        20 as award_level, 
        'Unknown' as award_level_description, 
        'Unknown' as award_level_category

    union all

    select 
        21 as award_level, 
        'Unknown' as award_level_description, 
        'Unknown' as award_level_category

)

select * from rename;

