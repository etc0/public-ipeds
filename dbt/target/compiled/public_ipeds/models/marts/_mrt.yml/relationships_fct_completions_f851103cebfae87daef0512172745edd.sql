
    
    

with child as (
    select institution_key as from_field
    from `data-eng-ipeds`.`dbt_echristiansen`.`fct_completions`
    where institution_key is not null
),

parent as (
    select institution_key as to_field
    from `data-eng-ipeds`.`dbt_echristiansen`.`dim_institutions`
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


