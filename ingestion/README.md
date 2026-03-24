# IPEDS Data Ingestion Module

## Overview

The ingestion module orchestrates the extraction of IPEDS (Integrated Postsecondary Education Data System) data from the NCES data portal and loads it into Google BigQuery. It automates the full Extract and Load workflow for completions and institutional characteristics data across survey years 2018–2024.

---

## Architecture

The ingestion pipeline follows an **Extract → Clean → Load** pattern.

---

## Module Structure

```
ingestion/
├── ingestion.py              # Main orchestration script
├── exceptions.py             # Custom exception classes
├── extract/                  # Download and extraction utilities
│   ├── download_completions.py
│   └── download_institutions.py
├── load/                     # BigQuery loading logic
│   ├── load_completions.py
│   └── load_institutions.py
├── utils/                    # Helper utilities
│   ├── extract.py           # File download and ZIP extraction
│   ├── clean.py             # CSV quoting and encoding fixes
│   └── load.py              # BigQuery schema inference and data loading
└── data/                    # Local data storage
    ├── completions/         # Raw completions ZIP files and CSVs
    ├── institutions/        # Raw institutions ZIP files and CSVs
    └── seeds/               # Reference/lookup data (CSVs)
```

---

## Main Entry Point

### `ingestion.py`

The main orchestration script that coordinates the entire ETL workflow.

**Workflow:**
1. Creates necessary directory structure (`data/completions`, `data/institutions`, `data/seeds`)
2. **For years 2018–2024:**
   - Downloads completions ZIP files (e.g., `C2018_A.zip`)
   - Downloads institutions ZIP files (e.g., `hd2018.zip`)
3. **For years 2018–2024:**
   - Cleans completions CSV files
   - Loads completions data to BigQuery `raw` dataset
   - Cleans institutions CSV files
   - Loads institutions data to BigQuery `raw` dataset
4. **Seed Processing:**
   - Cleans seed CSV files (reference data)
   - Copies to dbt `seeds/` directory for use in dbt models

**Usage:**
```bash
python -m ingestion.ingestion
```

---

## Dependencies

### Python Packages
- **requests** — Download files from NCES data portal
- **pandas** — Data manipulation and BigQuery loading
- **google-cloud-bigquery** — BigQuery client and schema management
- **chardet** — Automatic encoding detection

### GCP Requirements
- **Project ID:** `data-eng-ipeds`
- **Datasets:** `raw` (created automatically if missing)
- **Permissions:** BigQuery Editor role to create/write tables

---

## Key Design Decisions

### CIP Code as String
CIP codes are forced to `STRING` type in BigQuery to preserve leading zeros:
- Input: `01.0105` (STEM: Computer Science)
- Without override: `1.0105` (loses leading zero, breaks joins)
- With string override: `01.0105` (correct)

### Revised Files Priority
For years with both original and revised (`_REV`) files, the revised version is used:
- Handles IPEDS data corrections and updates
- Searchable case-insensitively (`C{year}_A_REV.csv` or `c{year}_a_rev.csv`)

### Write Truncate Mode
Each load uses `WRITE_TRUNCATE` disposition:
- Replaces entire table each run (idempotent)
- Ensures consistency with source data
- Allows re-runs without manual table deletion

### Idempotent Downloads
Downloads are skipped if ZIP file already exists locally:
- Reduces network calls and NCES server load
- Maintains local cache for debugging
- Can be cleared to force fresh downloads