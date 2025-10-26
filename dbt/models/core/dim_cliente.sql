WITH src AS (
    SELECT
        cliente_id,
        cliente_nome,
        cliente_data_cadastro,
        empresa_id
    FROM {{ source('staging', 'stg_cliente') }}
)

SELECT * FROM src
