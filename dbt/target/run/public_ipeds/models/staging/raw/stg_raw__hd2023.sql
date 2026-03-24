

  create or replace view `data-eng-ipeds`.`dbt_echristiansen`.`stg_raw__hd2023`
  OPTIONS()
  as with source as (
        select * from `data-eng-ipeds`.`raw`.`hd2023`
  ),
  renamed as (
      select
        2023 as survey_year,
        unitid as institution_id,
        instnm as institution_name,
        ialias as institution_alias,
        addr as address,
        city as city,
        stabbr as state_abbreviation,
        zip as zip_code,
        fips as fips_code,
        obereg as bureau_of_economic_analysis_region,
        chfnm as chief_executive_name,
        chftitle as chief_executive_title,
        gentele as general_telephone,
        ein as employer_identification_number,
        cast(null as string) as duns_number,  -- retired
        ueis as ueis_number,
        cast(opeid as integer) as ope_id,
        opeflag as ope_flag,
        webaddr as website_address,
        adminurl as admin_url,
        faidurl as financial_aid_url,
        applurl as application_url,
        npricurl as net_price_url,
        veturl as veteran_url,
        athurl as athletics_url,
        disaurl as disability_url,
        sector as sector_code,
        iclevel as institution_control_level,
        control as control_code,
        hloffer as high_level_offering,
        ugoffer as undergraduate_offering,
        groffer as graduate_offering,
        hdegofr1 as highest_degree_offered,
        deggrant as degree_granting,
        hbcu as historically_black_college_university,
        hospital as hospital_code,
        medical as medical_school,
        tribal as tribal_college,
        locale as locale_code,
        openpubl as open_admission_policy,
        act as insitution_status,
        newid as new_id,
        deathyr as death_year,
        closedat as close_date,
        cyactive as currently_active,
        postsec as primarily_postsecondary_indicator,
        pseflag as postsecondary_insitution_indicator,
        pset4flg as postsecondary_title_iv_indicator,
        rptmth as report_month,
        instcat as institution_category,
        -- carnegie 2000
        carnegie as carnegie_2000,
        -- carnegie 2005/2010
        ccbasic as carnegie_2005_2010_basic,
        -- carnegie 2015
        c15basic as carnegie_2015_basic,
        -- carnegie 2018
        c18basic as carnegie_2018_basic,
        cast(null as integer) as carnegie_2018_undergrad_instructional_program,
        cast(null as integer) as carnegie_2018_grad_instructional_program,
        cast(null as integer) as carnegie_2018_undergrad_profile,
        cast(null as integer) as carnegie_2018_enrollment_profile,
        cast(null as integer) as carnegie_2018_size_setting,
        -- carnegie 2021
        c21basic as carnegie_2021_basic,
        c21ipug as carnegie_2021_undergrad_instructional_program,
        c21ipgrd as carnegie_2021_grad_instructional_program,
        c21ugprf as carnegie_2021_undergrad_profile,
        c21enprf as carnegie_2021_enrollment_profile,
        c21szset as carnegie_2021_size_setting,
        -- carnegie 2025
        cast(null as integer) as carnegie_2025_instructional_composition,
        cast(null as integer) as carnegie_2025_size_and_enrollment_categories,
        cast(null as integer) as carnegie_2025_research_classification,
        cast(null as integer) as carnegie_2025_size,
        cast(null as integer) as carnegie_2025_artificial_left_framework,
        cast(null as integer) as carnegie_2025_artificial_program_mix,
        cast(null as integer) as carnegie_2025_graduate_program_mix,
        landgrnt as land_grant_status,
        instsize as institution_size,
        f1systyp as system_type,
        f1sysnam as system_name,
        f1syscod as system_code,
        cbsa as core_based_statistical_area_code,
        cbsatype as core_based_statistical_area_type,
        csa as combined_statistical_area_code,
        cast(null as integer) as new_england_city_and_town_area_code,
        countycd as county_code,
        countynm as county_name,
        stabbr || ' - ' || countynm as state_county,
        cngdstcd as congressional_district_code,
        longitud as longitude,
        latitude as latitude,
        dfrcgid as data_feedback_report_comparison_group_id,
        dfrcuscg as data_feedback_report_institution_submitted_group_id

      from source
  )
  select * from renamed;

