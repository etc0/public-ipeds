import os
from ingestion.utils.extract import download_file, extract_zip
    
def download_completions(target: str, year: int) -> None:
    file: str = f"C{year}_A.zip"

    # only download the file if it doesn't exist
    if not os.path.exists(f"{target}/{file}"):
        download_file(target, file)
        extract_zip(target, file)