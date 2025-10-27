WITH base AS (

    -- receita de hospedagem
    SELECT
        d.ano::INT AS ano,
        d.mes::INT AS mes,
        'HOSPEDAGEM' AS origem,
        FALSE AS cmv,
        SUM(fh.hospedagem_valor) AS total_receita
    FROM {{ source('core', 'fact_hospedagem') }} fh
    JOIN {{ source('core', 'dim_data') }} d
        ON fh.data_hospedagem_key = d.chave_data
    GROUP BY d.ano, d.mes

    UNION ALL

    -- receita de consumo
    SELECT
        d.ano::INT AS ano,
        d.mes::INT AS mes,
        'CONSUMO' AS origem,
        TRUE AS cmv,
        SUM(fc.valor_consumacao) AS total_receita
    FROM {{ source('core', 'fact_consumo') }} fc
    JOIN {{ source('core', 'dim_data') }} d
        ON fc.data_consumacao_key = d.chave_data
    GROUP BY d.ano, d.mes
)

SELECT
    ano,
    mes,
    origem,
    cmv,
    total_receita
FROM base
ORDER BY ano, mes, origem
