with 

cip_codes as (

    select * from {{ ref('stg_seed__cip_codes') }}
    
)

select 
    cip_code,
    cip_title,
    cip_family_title,
    is_stem
from cip_codes
