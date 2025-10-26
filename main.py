from scripts import dbt_seeds

def run_etl():
    print("🧩 Gerando seeds (dim_date)")
    dbt_seeds.generate_seeds()
    print("✅ Seeds gerados com sucesso!")

if __name__ == "__main__":
    run_etl()
