import os
import pandas as pd

string_overrides: set = {"CIPCODE"}

def load_file(warehouse: str, type: str, source_dir: str, year: int, file_name: str, encoding: str, dataset_id: str) -> None:
    print(f"Loading {file_name} into {warehouse}...")
    project_id: str = "data-eng-ipeds"

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
                pass  # Keep original data type if conversion fails
        else:
            df[col] = df[col].astype(str)

    # Load data into the appropriate data warehouse type
    if warehouse == 'snowflake':
        import snowflake.connector
        from snowflake.connector.pandas_tools import write_pandas

        conn = snowflake.connector.connect(
            user=os.getenv("SNOWFLAKE_USER"),
            password=os.getenv("SNOWFLAKE_PASSWORD"),
            account=os.getenv("SNOWFLAKE_ACCOUNT"),
            warehouse=os.getenv("SNOWFLAKE_WAREHOUSE"),
            role=os.getenv("SNOWFLAKE_ROLE"),
            database=os.getenv("SNOWFLAKE_DATABASE"),
            schema=os.getenv("SNOWFLAKE_SCHEMA")
        )

        try:
            write_pandas(conn, df, table_name.upper(), auto_create_table=True, overwrite=True)
        except Exception as e:
            for key, value in os.environ.items():
                if key.startswith('SNOWFLAKE'):
                    print(f"{key}: {value}")
            print(f"Error loading data into Snowflake: {e}")
            raise e

        # Show the number of rows loaded
        cs = conn.cursor()
        query = f"SELECT count(*) FROM {table_name};"
        count = cs.execute(query).fetchone()[0]
        print(f"Loaded {count} rows.")

    else: # bigquery
        from google.cloud import bigquery
        client: bigquery.Client = bigquery.Client(project=project_id)
        
        # make sure the dataset exists
        dataset: bigquery.Dataset = bigquery.Dataset(f"{project_id}.{dataset_id}")
        client.create_dataset(dataset, exists_ok=True)

        # Build the schema based on the DataFrame dtypes, applying overrides as needed
        schema = []
        for col in df.columns:
            data_type = "STRING"
            if col not in string_overrides:
                pandas_dtype = str(df[col].dtype)
                if pandas_dtype[:3] == "int":
                    data_type = "INTEGER"
                elif pandas_dtype[:5] == "float":
                    data_type = "FLOAT"

            schema.append(bigquery.SchemaField(col, data_type, "NULLABLE"))

        # define the job configuration for loading the file into BigQuery
        job_config: bigquery.LoadJobConfig = bigquery.LoadJobConfig(
            autodetect=False,
            destination_table_description=f"IPEDS {type.capitalize()} data for {year}",
            schema=schema,
            write_disposition=bigquery.WriteDisposition.WRITE_TRUNCATE,
        )

        # load the data into GCP BigQuery
        job: bigquery.LoadJob = client.load_table_from_dataframe(df, table_id, job_config=job_config)
        job.result()

        # Show the number of rows loaded
        print(f"Loaded {client.get_table(table_id).num_rows} rows.")