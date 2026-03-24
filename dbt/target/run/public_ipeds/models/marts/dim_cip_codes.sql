
  
    

    create or replace table `data-eng-ipeds`.`dbt_echristiansen`.`dim_cip_codes`
      
    
    

    
    OPTIONS()
    as (
      with 

cip_codes as (

    select * from `data-eng-ipeds`.`dbt_echristiansen`.`stg_seed__cip_codes`
    
)

select 
    cip_code,
    cip_title,
    cip_family_title,
    is_stem
from cip_codes
    );
  