WITH base AS (
    SELECT
        h.hospedagem_id,
        h.cliente_id,
        cl.cliente_nome,
        cl.empresa_id,
        e.empresa_nome,
        CAST(h.data_entrada AS DATE) AS data_entrada,
        CAST(h.data_saida AS DATE) AS data_saida,
        d_entrada.chave_data AS data_entrada_key,
        d_saida.chave_data AS data_saida_key,
        COALESCE(CAST(h.hospedagem_valor AS NUMERIC), 0) AS hospedagem_valor,
        COALESCE(cons.total_consumo, 0) AS total_consumo,
        (COALESCE(CAST(h.hospedagem_valor AS NUMERIC), 0) + COALESCE(cons.total_consumo, 0)) AS valor_total,
        COALESCE(cons.total_qtd_produtos, 0)::INTEGER AS total_qtd_produtos,
        CASE
            WHEN h.data_entrada IS NOT NULL AND h.data_saida IS NOT NULL
            THEN GREATEST(0, CAST((CAST(h.data_saida AS DATE) - CAST(h.data_entrada AS DATE)) AS INTEGER))
            ELSE NULL
        END AS noites_hospedagem
    FROM {{ ref('dim_hospedagem') }} h
    LEFT JOIN {{ ref('dim_cliente') }} cl
        ON h.cliente_id = cl.cliente_id
    LEFT JOIN {{ ref('dim_empresa') }} e
        ON cl.empresa_id = e.empresa_id
    LEFT JOIN (
        SELECT
            hospedagem_id,
            SUM(COALESCE(CAST(valor_consumacao AS NUMERIC), 0)) AS total_consumo,
            SUM(COALESCE(CAST(quantidade_produto AS NUMERIC), 0))::INTEGER AS total_qtd_produtos
        FROM {{ ref('dim_consumacao') }}
        GROUP BY hospedagem_id
    ) cons
        ON h.hospedagem_id = cons.hospedagem_id
    LEFT JOIN {{ ref('dim_data') }} d_entrada
        ON CAST(h.data_entrada AS DATE) = d_entrada.data
    LEFT JOIN {{ ref('dim_data') }} d_saida
        ON CAST(h.data_saida AS DATE) = d_saida.data
)

SELECT * FROM base
