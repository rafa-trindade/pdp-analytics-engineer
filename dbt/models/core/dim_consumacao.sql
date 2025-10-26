WITH src AS (
    SELECT
        consumacao_id,
        hospedagem_id,
        produto_id,
        data_consumacao,
        quantidade_produto,
        valor_produto,
        valor_consumacao
    FROM {{ source('staging', 'stg_consumacao') }}
)

SELECT * FROM src
