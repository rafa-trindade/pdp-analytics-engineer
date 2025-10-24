import os
from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime

SCRIPT_EXTRACT = "/opt/airflow/scripts/extract_data.py"
PYTHONPATH = "/opt/airflow:/opt/airflow/scripts:/opt/airflow/config"

with DAG(
    dag_id="elt_dag",
    start_date=datetime(2025, 10, 23),
    schedule_interval="0 3 * * *",
    catchup=False,
    tags=["extract", "load", "transform", "portfolio"]
) as dag:

    extract_task = BashOperator(
        task_id="extract_data",
        bash_command=f"PYTHONPATH={PYTHONPATH} python {SCRIPT_EXTRACT}"
    )

    extract_task
