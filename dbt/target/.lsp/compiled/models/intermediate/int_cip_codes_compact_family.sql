-- This view brings the CIP family title into each cip code row while omitting the family rows

with 

cip_codes as (
    select * from `data-eng-ipeds`.`dbt_echristiansen`.`stg_seed__cip_codes`
),

refactor as (
    select
        cip_code,  -- primary key
        cip_family,
        (
            select 
                cip_title
            from cip_codes sq
            where substr(sq.cip_code, 1, instr(sq.cip_code, '.')) = cc.cip_code

        ) as cip_family_title,
        cip_title,
        cip_definition
    from cip_codes as cc
    where instr(cc.cip_code, '.') = 0
)