# Base image oficial do Airflow 2.9.3 com Python 3.11
FROM apache/airflow:2.9.3-python3.11

USER root

# Dependências do sistema para pyodbc e SQL Server
RUN apt-get update && apt-get install -y \
    unixodbc-dev \
    curl \
    gnupg2 \
    apt-transport-https \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Driver ODBC do SQL Server
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/debian/11/prod.list > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get install -y msodbcsql17

USER airflow

# Pacotes Python para o extract
RUN pip install --no-cache-dir \
    pandas==2.3.3 \
    pyodbc==5.3.0

WORKDIR /opt/airflow
