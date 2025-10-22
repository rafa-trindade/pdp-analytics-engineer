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

- ✅ Geração das dimensões `dim_date` e `dim_time` via Python, utilizadas como **seeds** no DBT.  
- 🚧 **Próximos passos:** implementação das camadas *staging* e *core*, modelagem das tabelas fato e dimensões analíticas, e integração completa ao pipeline orquestrado pelo Airflow.

---

## 🧩 Diagrama do Modelo OLTP
![Diagrama OLTP](docs/diagrams/oltp_model.png)

## 🧠 Diagrama do Modelo OLAP
![Diagrama OLAP](docs/diagrams/olap_model.png)