with 

award_levels as (

    select * from `data-eng-ipeds`.`dbt_echristiansen`.`stg_seed__award_level_codes`

),

rename as (
    select
        awlevel_code as award_level,  -- primary key
        awlevel_description as award_level_description,
        awlevel_category as award_level_category
    from award_levels
)

select * from rename