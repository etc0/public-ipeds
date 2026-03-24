import os 
from ingestion.utils.clean import csv_fix_quotes
from ingestion.utils.load import load_file

type: str = 'institutions'

def get_file(source_dir: str, year: int) -> str:
    print(f"Loading {type} for {year}...")
    
    # Use the revised *_rev.csv file if it exists, otherwise use the original file. Ignore case.
    file: str = None
    for f in os.listdir(source_dir):
        if f.lower() == f"hd{year}.csv":
            file: str = f
            break

    # if no file is found, log a warning and skip this year
    if not file:
        print(f"No {type} file found for {year} in {source_dir}")
        return None
    
    # return the file path for the file to be loaded
    print(f"Using {type} file for {year}: {file}")
    return file

def clean_file(source_dir: str, clean_dir: str, file_name: str) -> str:
    return csv_fix_quotes(source_dir, clean_dir, file_name)

def load_institutions(source_dir: str, clean_dir: str, year: int, dataset_id: str) -> None:
    file_name: str = get_file(source_dir, year)
    if file_name:
        encoding = clean_file(source_dir, clean_dir, file_name)
        load_file(type, clean_dir, year, file_name, encoding, dataset_id)