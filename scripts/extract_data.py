import os
import pandas as pd
import pyodbc
import shutil
import argparse
from pathlib import Path
from config.db_config import SQL_SERVER_CONFIG

def extract_from_sqlserver(internal_dir: Path, host_dir: Path):
    tables = [
        "clsCliente",
        "clsEmpresa",
        "clsHospedagem",
        "clsProduto",
        "clsConsumacao",
    ]

    # Garantir que as pastas existam
    internal_dir.mkdir(parents=True, exist_ok=True)
    host_dir.mkdir(parents=True, exist_ok=True)

    conn_str = (
        f"DRIVER={{{SQL_SERVER_CONFIG['driver']}}};"
        f"SERVER={SQL_SERVER_CONFIG['server']};"
        f"DATABASE={SQL_SERVER_CONFIG['database']};"
        f"UID={SQL_SERVER_CONFIG['user']};"
        f"PWD={SQL_SERVER_CONFIG['password']}"
    )

    try:
        conn = pyodbc.connect(conn_str)
        print("Conexão com o SQL Server estabelecida com sucesso!")

        for table in tables:
            print(f"📥 Extraindo tabela: {table} ...")
            query = f"SELECT * FROM {table};"
            df = pd.read_sql(query, conn)

            file_name = f"{table}.csv"
            internal_file_path = internal_dir / file_name
            host_file_path = host_dir / file_name

            # Salva primeiro na pasta interna do container
            df.to_csv(internal_file_path, index=False, encoding="utf-8-sig")
            print(f"{table} salva em: {internal_file_path} (linhas: {len(df)})")

            # Copia para a pasta do host
            shutil.copy(internal_file_path, host_file_path)
            print(f"{table} copiada para: {host_file_path}")

        conn.close()
        print("Extração concluída com sucesso!")

    except Exception as e:
        print(f"Erro na extração: {e}")
        raise

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--internal-dir", required=True, help="Pasta interna do container")
    parser.add_argument("--host-dir", required=True, help="Pasta bind mount para host Windows")
    args = parser.parse_args()

    internal_dir = Path(args.internal_dir)
    host_dir = Path(args.host_dir)

    extract_from_sqlserver(internal_dir, host_dir)
