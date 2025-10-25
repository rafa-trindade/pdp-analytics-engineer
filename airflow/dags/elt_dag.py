import os
from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime

# Scripts
SCRIPT_EXTRACT = "/opt/airflow/scripts/extract_data.py"
SCRIPT_LOAD = "/opt/airflow/scripts/load_data.py"
PYTHONPATH = "/opt/airflow:/opt/airflow/scripts:/opt/airflow/config"

# Pasta interna do container (onde airflow tem permissão)
INTERNAL_DATA_DIR = "/opt/airflow/data/extracted"
# Pasta bind mount para Windows
HOST_DATA_DIR = "/opt/airflow/data/extracted_final"

# Garantir que as pastas existem antes de rodar a DAG
os.makedirs(INTERNAL_DATA_DIR, exist_ok=True)
os.makedirs(HOST_DATA_DIR, exist_ok=True)

with DAG(
    dag_id="elt_dag",
    start_date=datetime(2025, 10, 23),
    schedule_interval="0 3 * * *",
    catchup=False,
    tags=["extract", "load", "transform", "portfolio"]
) as dag:

    # Extração: escreve primeiro no container e depois copia para o host
    extract_task = BashOperator(
        task_id="extract_data",
        bash_command=(
            f"PYTHONPATH={PYTHONPATH} python {SCRIPT_EXTRACT} "
            f"--internal-dir {INTERNAL_DATA_DIR} "
            f"--host-dir {HOST_DATA_DIR}"
        )
    )

    # Load (mantém como estava)
    load_task = BashOperator(
        task_id="load_data",
        bash_command=f"PYTHONPATH={PYTHONPATH} python {SCRIPT_LOAD}"
    )

    extract_task >> load_task
