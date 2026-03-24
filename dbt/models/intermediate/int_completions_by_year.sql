with 

completions_2018 as (
    select * from {{ ref('stg_raw__c2018_a') }} as a
),
completions_2019 as (
    select * from {{ ref('stg_raw__c2019_a') }} as a
),
completions_2020 as (
    select * from {{ ref('stg_raw__c2020_a') }} as a
),
completions_2021 as (
    select * from {{ ref('stg_raw__c2021_a') }} as a
),
completions_2022 as (   
    select * from {{ ref('stg_raw__c2022_a') }} as a
),
completions_2023 as (
    select * from {{ ref('stg_raw__c2023_a') }} as a
),
completions_2024 as (   
    select * from {{ ref('stg_raw__c2024_a') }} as a
),
combine as (
    select * from completions_2018

    union all 

    select * from completions_2019

    union all 

    select * from completions_2020

    union all 

    select * from completions_2021

    union all 

    select * from completions_2022

    union all 

    select * from completions_2023

    union all 

    select * from completions_2024
)

select * 
from combine
where major_number = 1