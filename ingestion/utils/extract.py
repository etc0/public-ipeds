import requests
import zipfile
from ingestion.exceptions import DownloadError, ExtractError

def download_file(target: str, file: str) -> None:
    print(f"Downloading {file}...")
    url: str = f"https://nces.ed.gov/ipeds/datacenter/data/{file}"
    try:
        response: requests.Response = requests.get(url)
        response.raise_for_status()
        # move the file to the target directory
        with open(f"{target}/{file}", 'wb') as f:
            f.write(response.content)
    except requests.RequestException as e:
        raise DownloadError(f"Failed to download {file}: {e}") from e

def extract_zip(target: str, file: str) -> None:
    print(f"Extracting {file}...")
    try:
        file_path: str = f"{target}/{file}"
        with zipfile.ZipFile(file_path, 'r') as this_zip:
            this_zip.extractall(target)
    except zipfile.BadZipFile as e:
        raise ExtractError(f"Failed to extract {file}: {e}") from e 