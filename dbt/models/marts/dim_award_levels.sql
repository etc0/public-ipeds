with 

award_levels as (

    select * from {{ ref('stg_seed__award_level_codes') }}

)

select 
    award_level,
    award_level_description,
    award_level_category
from award_levels
