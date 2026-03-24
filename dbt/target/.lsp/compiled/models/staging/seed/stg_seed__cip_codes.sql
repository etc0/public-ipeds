with 

cip_codes as (
    select * from `data-eng-ipeds`.`dbt_echristiansen`.`cipcode2020`
),

rename as (
    select
        CIPCode         as cip_code,  -- primary key
        CIPFamily       as cip_family,
        CIPTitle        as cip_title,
        CIPDefinition   as cip_definition,
        -- Populate the CIP family title on each row
        case instr(CIPCode, '.')
            when 0 then null 
            else (
                select sq.CIPTitle 
                from cip_codes sq 
                where sq.CIPCode = substr(c.CIPCode, 1, 2)
            )
        end             as cip_family_title,
        -- Uses Department of Homeland Security (DHS) definition of STEM fields
        case 
            when substr(CIPCode, 0, 2) in ('14', '26', '27', '40') then 'STEM'
            else 'non-STEM'
        end             as is_stem
    from cip_codes c

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