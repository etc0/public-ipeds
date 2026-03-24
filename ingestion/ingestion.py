from pathlib import Path
from os import makedirs
from ingestion.extract.download_completions import download_completions
from ingestion.extract.download_institutions import download_institutions
from ingestion.load.load_completions import load_completions
from ingestion.load.load_institutions import load_institutions
from ingestion.utils.clean import csv_fix_quotes
import shutil

def main():
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
    makedirs(completions_clean, exist_ok=True)
    makedirs(institutions_clean, exist_ok=True)
    makedirs(seeds_clean, exist_ok=True)

    # for each year 2018-2024, download and extract the zip files
    for year in range(2018, 2025):
        download_completions(completions_target, year)
        download_institutions(institutions_target, year)

    # for each year 2018-2024, import the appropriate csv files into GCP BigQuery
    for year in range(2018, 2025):
        load_completions(completions_target, completions_clean, year, dataset)
        load_institutions(institutions_target, institutions_clean, year, dataset)

    # clean the seeds files and copy them to the dbt seeds directory
    for file in seeds_target.iterdir():
        if file.is_file() and file.name.endswith('.csv'):
            encoding = csv_fix_quotes(seeds_target, seeds_clean, file.name)
            print(f"Copying cleaned seed file {file.name} to dbt seeds directory...")
            shutil.copy(seeds_clean / file.name, dbt_seeds / file.name)

if __name__ == "__main__":
    main()