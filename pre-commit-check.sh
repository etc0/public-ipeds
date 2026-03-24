#!/bin/bash

# get current datetime
NOW=$(date +"%Y-%m-%d_%H-%M")
FILE="pre-commit-check-${NOW}.log"

# Manual pre-commit checklist
cd dbt
dbt parse
dbt docs generate
cd ..
pre-commit run --all-files > $FILE