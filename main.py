from scripts import transform_data

def run_etl():
    print("🧩 Gerando seeds (dim_date e dim_time)")
    transform_data.generate_seeds()
    print("✅ Seeds gerados com sucesso!")

if __name__ == "__main__":
    run_etl()
