with 

cip_codes as (
    select * from {{ ref('cipcode2020') }}
),

rename as (
    select
        c.CIPCode         as cip_code,  -- primary key
        c.CIPFamily       as cip_family,
        c.CIPTitle        as cip_title,
        c.CIPDefinition   as cip_definition,
        -- Populate the CIP family title on each row
        case 
            when {{ dbt.position("'.'", "c.CIPCode") }} = 0 then null 
            else sq.CIPTitle 
        end             as cip_family_title,
        -- Uses Department of Homeland Security (DHS) definition of STEM fields
        case 
            when substr(c.CIPCode, 0, 2) in ('14', '26', '27', '40') then 'STEM'
            else 'non-STEM'
        end             as is_stem
    from cip_codes c
    left join cip_codes sq 
        on substr(c.CIPCode, 1, 2) = sq.CIPCode

    union all
    
    -- Add residual codes not in official CIP file
    select
        '99'        as cip_code,
        '99'        as cip_family,
        'RESIDUAL'  as cip_title,
        'Residual code not in official CIP file' as cip_definition,
        'Residual code not in official CIP file' as cip_family_title,
        'non-STEM'  as is_stem
    
    union all
    
    select
        '99.0000'   as cip_code,    
        '99'        as cip_family,
        'Residual'  as cip_title,
        'Residual code not in official CIP file' as cip_definition,
        'Residual code not in official CIP file' as cip_family_title,
        'non-STEM'  as is_stem

)

select * from rename