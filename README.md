# IPEDS Data Pipeline & Analytics Platform

## Overview
End-to-end data engineering pipeline ingesting IPEDS 
(Integrated Postsecondary Education Data System) completions 
and institutional characteristics data for survey years 2018-2024
into Google BigQuery, transforming it into an analytical data 
model, and visualizing key higher education metrics.

## Architecture
![Alt Text](docs/data-pipeline-ipeds.drawio.png)

## Technology Stack
| Layer | Technology |
|---|---|
| Extraction | Python, requests |
| Load | Python, pandas, google-cloud-bigquery |
| Data Warehouse | GCP BigQuery |
| Transformation | dbt |
| Visualization | Looker Studio |
| Version Control | Git/GitHub |
| Code Quality | pre-commit, dbt-checkpoint |

## Dashboard
[View Live Dashboard: Metabase](https://venus.tail59a343.ts.net/public/dashboard/abda35ce-c89e-44cf-ab7b-e6a8f212ac51)

[View Live Dashboard: Looker Studio](https://lookerstudio.google.com/reporting/c4844475-0d15-406f-8cd8-cbeb03332b2b)

## Key Features
- Automated download and decompression of IPEDS ZIP files
- Schema-driven CSV ingestion with data cleaning
- Medallion architecture (Bronze/Silver/Gold)
- Dimensional model with fact and dimension tables
- Partitioned and clustered BigQuery tables for performance
- dbt tests for data quality at every layer
- dbt documentation with full lineage DAG
- Pre-commit hooks enforcing code quality

## Data Model
[Data Model Documentation](docs/static_index.html)

### Dimensional Model
- fct_completions — grain: one row per year/institution/CIP/award level
- dim_survey_year — survey year with academic year
- dim_institution — annual snapshot of institutional characteristics
- dim_cip_code — CIP 2020 program classification with STEM flags
- dim_award_level — award level codes and categories

## Reports
1. Total completions trend 2018-2024
2. Completions by award level over time
3. Top 10 CIP families
4. STEM vs non-STEM trend
5. Gender gap by field of study
6. State completions by academic year
7. Top 25 institutions by completions
6. Year-over-year growth rate by state

## Setup
1. Create a GCP project named: 'data-eng-ipeds'
2. Under the project, create two datasets named: 'raw' and 'dwh'
3. Clone this GIT repository
4. Create a Python virtual environment
5. Install Python requirements
6. Set environment variable DBT_USER_SCHEMA='dwh'
7. From the root folder, run: `python -m ingestion.ingestion`
8. Navigate to the dbt folder and run: dbt build

## Notes
- The Python pandas library was used to create a dataframe as a source for loading completion data into Google BigQuery, since the BigQuery autodetect forced zero-padded CIP codes as float data type (e.g. 01.0105 -> 1.0105)
- Similarly, a schema.yml file was used to instruct dbt to treat CIP codes as strings, since the 'dbt seed' command by default interprets zero-padded CIP codes from the definition file as float data types.
- A filter was applied to completions data to only include students' first majors (MAJORNUM=1), as the reports do not cover secondary majors.
- The definition of STEM fields were derived from the Optional Practical Training (OPT) as set by the Department of Homeland Security (DHS): [Source Link](https://studyinthestates.dhs.gov/stem-opt-hub/additional-resources/eligible-cip-codes-for-the-stem-opt-extension)
