import os
from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime

SCRIPT_EXTRACT = "/opt/airflow/scripts/extract_data.py"
SCRIPT_LOAD = "/opt/airflow/scripts/load_data.py"

PYTHONPATH = "/opt/airflow:/opt/airflow/scripts:/opt/airflow/config"

with DAG(
    dag_id="extract_load_dag",
    start_date=datetime(2025, 10, 23),
    schedule_interval=None,
    catchup=False,
    tags=["extract", "load", "portfolio"]
) as dag:

    extract_task = BashOperator(
        task_id="extract_data",
        bash_command=f"PYTHONPATH={PYTHONPATH} python {SCRIPT_EXTRACT}"
    )

    load_task = BashOperator(
        task_id="load_data",
        bash_command=f"PYTHONPATH={PYTHONPATH} python {SCRIPT_LOAD}"
    )

    extract_task >> load_task
