# pdp-hospedagem Data Warehouse
[![Projeto Badge](https://img.shields.io/badge/-pdp--hospedagem-2B5482?style=flat-square&logo=github&logoColor=fff)](https://github.com/rafa-trindade/pdp-hospedagem)

> **Status:** Em andamento  

Este projeto realiza a **implementação, modelagem e consumo de um Data Warehouse** utilizando **Airflow**, **DBT** e **Power BI**, integrando dados transacionais do projeto [pdp-hospedagem](https://github.com/rafa-trindade/pdp-hospedagem).  

O projeto contempla:  
- **Orquestração de pipelines ETL/ELT** utilizando o Apache Airflow;  
- **Transformação e organização dos dados em camadas:**  
  - **Staging:** armazenamento de dados brutos provenientes das fontes transacionais;  
  - **Core:** tratamento, padronização e integração dos dados, formando a base consolidada;  
  - **Data Mart:** modelagem analítica voltada ao consumo em dashboards e relatórios;  
- **Criação de dashboards e análises interativas** no Power BI, apoiando a tomada de decisão.


## 📍 Progresso do Projeto

- ✅ Geração das dimensões `dim_date` e `dim_time` via Python que serão utilizadas como **seeds** no DBT.  
- ✅ Ingestão de dados transacionais fictícios no projeto [**pdp-hospedagem**](https://github.com/rafa-trindade/pdp-hospedagem) utilizando [**datafaker-rafatrindade**](https://github.com/rafa-trindade/datafaker-rafadrindade).
- 🚧 **Próximos passos:** implementação das camadas *staging* e *core*, modelagem das tabelas fato e dimensões analíticas, e integração completa ao pipeline orquestrado pelo Airflow.

---

## 📦 Bibliotecas Utilizadas

**Ambiente:** Python 3.11  

| Pacote            | Versão  | Observação |
|--------------------|----------|-------------|
| **pandas**         | 2.3.3    | Manipulação e transformação de dados |
| **requests**       | 2.32.3   | Requisições HTTP e integração de APIs |
| **dbt-core**       | 1.10.13  | Transformações e modelagem no Data Warehouse |
| **dbt-postgres**   | 1.9.1    | Adaptador DBT para PostgreSQL |
| **apache-airflow** | 2.9.3    | Orquestração de pipelines ETL/ELT |

💡 Airflow instalado com constraints oficiais:  
`--constraint https://raw.githubusercontent.com/apache/airflow/constraints-2.9.3/constraints-3.11.txt`

## 🗂️ Estrutura do Projeto

```text
pdp-dw-powerbi/
├── airflow/                 # Orquestração de pipelines ETL/ELT com Airflow
│   └── dags/                # Definição dos DAGs
├── config/                  # Arquivos de configuração do projeto
├── data/                    # Dados brutos e processados
│   ├── 01_raw/              # Dados originais importados das fontes
│   └── 02_processed/        # Dados transformados e preparados para DBT
├── dbt/                     # Projeto DBT
│   ├── models/              
│   │   ├── 01_staging/      # Modelos staging (limpeza e padronização de dados)
│   │   ├── 02_core/         # Modelos core (dados integrados e limpos)
│   │   └── 03_marts/        # Modelos marts (tabelas para análise e dashboards)
│   ├── seeds/               # Seeds (ex.: dim_date, dim_time)
│   ├── snapshots/           # Snapshots de tabelas para histórico de mudanças
│   ├── tests/               # Testes de qualidade do DBT
│   ├── dbt_project.yml      # Configuração do projeto DBT
│   └── profiles.yml         # Configuração de conexão com o banco
├── docs/                    # Documentação do projeto
│   ├── diagrams/            # Diagramas de bancos OLTP e DWH
│   ├── powerbi_screenshots/ # Capturas de tela de dashboards
│   └── data_dictionary.md   # Dicionário de dados
├── reports/                 # Relatórios Power BI exportados
├── scripts/                 # Pipelines ETL e scripts auxiliares (ex.: geração de seeds via Python)
├── main.py                  # Script principal para execução de pipelines
├── README.md                # Documentação inicial do projeto
└── requirements.txt         # Dependências Python
```

---

## 🧩 Diagrama do Modelo OLTP
![Diagrama OLTP](docs/diagrams/oltp_model.png)

## 🧠 Diagrama do Modelo OLAP
![Diagrama OLAP](docs/diagrams/olap_model.png)