

  create or replace view `data-eng-ipeds`.`dbt_echristiansen`.`int_institutions_by_year`
  OPTIONS()
  as with 

institutions_2018 as (
    select * from `data-eng-ipeds`.`dbt_echristiansen`.`stg_raw__hd2018` as a
),
institutions_2019 as (
    select * from `data-eng-ipeds`.`dbt_echristiansen`.`stg_raw__hd2019` as a
),
institutions_2020 as (
    select * from `data-eng-ipeds`.`dbt_echristiansen`.`stg_raw__hd2020` as a
),
institutions_2021 as (
    select * from `data-eng-ipeds`.`dbt_echristiansen`.`stg_raw__hd2021` as a
),
institutions_2022 as (   
    select * from `data-eng-ipeds`.`dbt_echristiansen`.`stg_raw__hd2022` as a
),
institutions_2023 as (
    select * from `data-eng-ipeds`.`dbt_echristiansen`.`stg_raw__hd2023` as a
),
institutions_2024 as (   
    select * from `data-eng-ipeds`.`dbt_echristiansen`.`stg_raw__hd2024` as a
),
combine as (
    select * from institutions_2018

    union all 

    select * from institutions_2019

    union all 

    select * from institutions_2020

    union all 

    select * from institutions_2021

    union all 

    select * from institutions_2022

    union all 

    select * from institutions_2023

    union all 

    select * from institutions_2024
)

select * from combine;

