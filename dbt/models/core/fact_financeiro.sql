WITH hospedagem AS (
    SELECT
        hospedagem_id,
        cliente_id,
        CAST(data_saida AS DATE) AS data_saida,
        COALESCE(CAST(hospedagem_valor AS NUMERIC), 0) AS hospedagem_valor
    FROM {{ ref('dim_hospedagem') }}
),

consumo AS (
    SELECT
        hospedagem_id,
        SUM(COALESCE(CAST(valor_consumacao AS NUMERIC),0)) AS total_consumo
    FROM {{ ref('dim_consumacao') }}
    GROUP BY hospedagem_id
),

base AS (
    SELECT
        h.hospedagem_id,
        h.cliente_id,
        cl.cliente_nome,
        cl.empresa_id,
        e.empresa_nome,
        h.data_saida AS data_movimentacao,
        d.chave_data AS data_movimentacao_key,
        COALESCE(h.hospedagem_valor, 0) AS hospedagem_valor,
        COALESCE(c.total_consumo, 0) AS total_consumo,
        (COALESCE(h.hospedagem_valor, 0) + COALESCE(c.total_consumo, 0)) AS valor_total
    FROM hospedagem h
    LEFT JOIN consumo c
        ON h.hospedagem_id = c.hospedagem_id
    LEFT JOIN {{ ref('dim_cliente') }} cl
        ON h.cliente_id = cl.cliente_id
    LEFT JOIN {{ ref('dim_empresa') }} e
        ON cl.empresa_id = e.empresa_id
    LEFT JOIN {{ ref('dim_data') }} d
        ON h.data_saida = d.data
)

SELECT * FROM base
