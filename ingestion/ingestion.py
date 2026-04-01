from json import load
from pathlib import Path
import os
from ingestion.extract.download_completions import download_completions
from ingestion.extract.download_institutions import download_institutions
from ingestion.load.load_completions import load_completions
from ingestion.load.load_institutions import load_institutions
from ingestion.utils.clean import csv_fix_quotes
import shutil
from dotenv import load_dotenv
load_dotenv(override=True)

def main():
    # get the target warehouse type ('snowflake' or 'bigquery') from environment variable
    warehouse: str = os.getenv("WAREHOUSE", "snowflake").lower()
    if warehouse not in ['snowflake', 'bigquery']:
        raise ValueError("Invalid WAREHOUSE environment variable. Must be 'snowflake' or 'bigquery'.")
    else:
        print(f"Using {warehouse} as target data warehouse.")

    # create target directories if they don't exist
    completions: str = "completions"
    institutions: str = "institutions"
    seeds: str = "seeds"
    data: str = "data"
    clean: str = "clean"
    dbt: str = "dbt"
    dataset: str = "raw"
    completions_target: Path = Path(__file__).resolve().parent / data / completions
    institutions_target: Path = Path(__file__).resolve().parent / data / institutions
    seeds_target: Path = Path(__file__).resolve().parent / data / seeds
    completions_clean: Path = completions_target / clean
    institutions_clean: Path = institutions_target / clean
    seeds_clean: Path = seeds_target / clean
    dbt_seeds: Path = Path(__file__).resolve().parent.parent / dbt/ seeds
    os.makedirs(completions_clean, exist_ok=True)
    os.makedirs(institutions_clean, exist_ok=True)
    os.makedirs(seeds_clean, exist_ok=True)

    # for each year 2018-2024, download and extract the zip files
    for year in range(2018, 2025):
        download_completions(completions_target, year)
        download_institutions(institutions_target, year)

    # for each year 2018-2024, import the appropriate csv files into GCP BigQuery
    for year in range(2018, 2025):
        load_completions(warehouse, completions_target, completions_clean, year, dataset)
        load_institutions(warehouse, institutions_target, institutions_clean, year, dataset)

    # clean the seeds files and copy them to the dbt seeds directory
    for file in seeds_target.iterdir():
        if file.is_file() and file.name.endswith('.csv'):
            encoding = csv_fix_quotes(seeds_target, seeds_clean, file.name)
            print(f"Copying cleaned seed file {file.name} to dbt seeds directory...")
            shutil.copy(seeds_clean / file.name, dbt_seeds / file.name)

if __name__ == "__main__":
    main()