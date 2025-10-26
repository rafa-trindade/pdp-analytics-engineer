WITH src AS (
    SELECT
        hospedagem_id,
        cliente_id,
        data_entrada,
        data_saida,
        hospedagem_qtd_diarias,
        hospedagem_valor,
        hospedagem_qtd_pessoas
    FROM {{ source('staging', 'stg_hospedagem') }}
)

SELECT * FROM src
