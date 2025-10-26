import os
from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime

# Scripts
SCRIPT_EXTRACT = "/opt/airflow/scripts/extract_data.py"
SCRIPT_LOAD = "/opt/airflow/scripts/load_data.py"
PYTHONPATH = "/opt/airflow:/opt/airflow/scripts:/opt/airflow/config"

DATA_DIR = "/opt/airflow/data/extracted"

os.makedirs(DATA_DIR, exist_ok=True)

with DAG(
    dag_id="elt_dag",
    start_date=datetime(2025, 10, 23),
    schedule_interval="0 3 * * *",
    catchup=False,
    tags=["extract", "load", "transform", "portfolio"]
) as dag:

    extract_task = BashOperator(
        task_id="extract_data",
        bash_command=f"PYTHONPATH={PYTHONPATH} python {SCRIPT_EXTRACT} --data-dir {DATA_DIR}"
    )

    load_task = BashOperator(
        task_id="load_data",
        bash_command=f"PYTHONPATH={PYTHONPATH} python {SCRIPT_LOAD}"
    )

    dbt_staging_task = BashOperator(
        task_id="dbt_run_staging",
        bash_command="cd /opt/airflow/dbt && dbt run --models staging"
    )

    extract_task >> load_task >> dbt_staging_task