# 🗄️ pdp-dw-powerbi
[![Projeto Badge](https://img.shields.io/badge/-pdp--hospedagem-2B5482?style=flat-square&logo=github&logoColor=fff)](https://github.com/rafa-trindade/pdp-hospedagem)

Este projeto realiza a **implementação, modelagem e consumo de um Data Warehouse** utilizando **Airflow**, **DBT** e **Power BI**, integrando dados transacionais do projeto [pdp-hospedagem](https://github.com/rafa-trindade/pdp-hospedagem).

O projeto contempla:  
- **Conteinerização da aplicação** com **Docker**, garantindo isolamento, portabilidade e facilidade de execução dos serviços (Airflow, PostgreSQL, DBT);  
- **Orquestração de pipelines** utilizando o **Apache Airflow**;  
- **Transformação, documentação e modelagem** utilizando o **DBT**:
- **Consumo** dos modelos com o **Power BI** para criação de dashboards e relaórios.  

---

## 📍 Progresso do Projeto:

- ✅ Criação das dimensões `dim_date` e `dim_time` via Python que serão utilizadas como **seeds** no DBT.  
- ✅ Ingestão de dados transacionais fictícios no banco de dados **SQL Server** do projeto [**pdp-hospedagem**](https://github.com/rafa-trindade/pdp-hospedagem) utilizando [**datafaker-rafatrindade**](https://github.com/rafa-trindade/datafaker-rafatrindade).  
- ✅ **Conteinerização** do projeto utilizando **Docker**, com configuração de:
  - **Dockerfile** para instalar dependências necessárias e preparar o container do Airflow.
  - **docker-compose.yml** para orquestrar o Airflow e os containers de banco de dados (**SQL Server** e **PostgreSQL**).
- ✅ Implementação da **extração (Extract)** dos dados transacionais via pipeline do **Airflow**, com arquivos extraídos salvos na pasta `data/extracted`.  

---

## 🚧 Próximos Passos:

- **Carga (Load)** dos dados extraídos do SQL Server para o PostgreSQL via pipeline orquestrada no Airflow.  
- **Transformações (Transform)** dos dados no DBT, estruturando as camadas **staging**, **core**.  
- Modelagem das **tabelas fato** e **dimensões analíticas** utilizando o DBT na camada camada **data mart**.  
- Consumo dos modelos com o **Power BI** para criação de dashboards e relaórios.  

---

### 🔁 Resumo da Arquitetura ELT e Dataviz:

1. **Extract:** Extração dos dados transacionais do SQL Server via Airflow. *(Etapa concluída ✅)*  
2. **Load:** Carga dos dados brutos no Data Warehouse (PostgreSQL). *(Próxima etapa 🚧)*  
3. **Transform:** Transformações e modelagem realizadas pelo DBT diretamente no Data Warehouse. *(Etapa futura 🔜)* 
4. **Dataviz:** Consumo e análise dos dados no **Power BI**, com desenvolvimento de dashboards e relatórios. *(Etapa futura 🔜)*  

---

## 📦 Bibliotecas Utilizadas:

**Ambiente:** Python 3.11  

| Pacote            | Versão  | Observação |
|-------------------|---------|------------|
| **pandas**         | 2.3.3    | Manipulação e transformação de dados |
| **requests**       | 2.32.3   | Requisições HTTP e integração de APIs |
| **python-dotenv**  | 1.0.1    | Carregamento de variáveis de ambiente do arquivo `.env` |
| **dbt-core**       | 1.10.13  | Transformações e modelagem no Data Warehouse |
| **dbt-postgres**   | 1.9.1    | Adaptador DBT para PostgreSQL |

---

## ⚡ Inicialização do ambiente com Docker:

```bash
docker-compose build airflow
docker-compose up -d
```

---

## 🗂️ Estrutura do Projeto:

```text
pdp-dw-powerbi/
├── airflow/                 # Orquestração de pipelines ETL/ELT com Airflow
│   ├── dags/                # Definição dos DAGs
│   ├── logs/                # Armazenamento de logs de execução dos DAGs
│   └── plugins/             # Plugins customizados do Airflow
├── config/                  # Arquivos de configuração do projeto
├── data/                    # Dados brutos e processados
│   ├── extracted/           # Dados extraídos das fontes
│   └── processed/           # Dados transformados e preparados para load
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
├── .env                     # Variáveis de ambiente do projeto
├── docker-compose.yml       # Configuração para execução de containers Docker
├── Dockerfile               # Definições da imagem Docker do projeto
├── main.py                  # Script para execução local
├── README.md                # Documentação do projeto
└── requirements.txt         # Dependências Python
```

---

## 🧩 Diagrama do Modelo OLTP:
![Diagrama OLTP](docs/diagrams/oltp_model.png)

## 🧠 Diagrama do Modelo OLAP:
![Diagrama OLAP](docs/diagrams/olap_model.png)