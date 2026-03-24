import pandas as pd
from google.cloud import bigquery

string_overrides: set = {"CIPCODE"}
required_fields: set = {"UNITID", "CIPCODE", "MAJORNUM", "AWLEVEL"}

def infer_schema(df: pd.DataFrame) -> list:
    schema = []
    for col in df.columns:
        dwh_type = "STRING"
        if col in string_overrides:
            dwh_type = "STRING"
        else:
            pandas_dtype = str(df[col].dtype)
            if pandas_dtype[:3] == "int":
                dwh_type = "INTEGER"
            elif pandas_dtype[:5] == "float":
                dwh_type = "FLOAT"

        mode = "NULLABLE"
        if col in required_fields:
            mode = "REQUIRED"

        schema.append(bigquery.SchemaField(col, dwh_type, mode))
    
    return schema

def load_file(type: str, source_dir: str, year: int, file_name: str, encoding: str, dataset_id: str) -> None:
    print(f"Loading {file_name} into BigQuery...")
    project_id: str = "data-eng-ipeds"
    client: bigquery.Client = bigquery.Client(project=project_id)

    # make sure the dataset exists
    dataset: bigquery.Dataset = bigquery.Dataset(f"{project_id}.{dataset_id}")
    client.create_dataset(dataset, exists_ok=True)

    # To get a standardized filename, remove the file extension and '_rv' if it exists
    table_name: str = file_name.split('.')[0].replace('_rv', '').lower()
    table_id: str = f"{project_id}.{dataset_id}.{table_name}"

    # Convert columns to numeric where possible, except those in string_overrides
    df = pd.read_csv(f"{source_dir}/{file_name}", dtype=str, encoding=encoding)
    for col in df.columns:
        if col not in string_overrides:
            try:
                df[col] = pd.to_numeric(df[col])
            except (ValueError, TypeError):
                pass  # Keep original string values if conversion fails

    # Get the schema based on the DataFrame dtypes, applying overrides as needed
    schema = infer_schema(df)

    # define the job configuration for loading the file into BigQuery
    job_config: bigquery.LoadJobConfig = bigquery.LoadJobConfig(
        autodetect=False,
        destination_table_description=f"IPEDS {type.capitalize()} data for {year}",
        schema=schema,
        write_disposition=bigquery.WriteDisposition.WRITE_TRUNCATE,
    )

    # load the data into GCP BigQuery
    job: bigquery.LoadJob = client.load_table_from_dataframe(df, table_id, job_config=job_config)

    # Wait for job to complete
    job.result()  
    print(f"Loaded {client.get_table(table_id).num_rows} rows.")