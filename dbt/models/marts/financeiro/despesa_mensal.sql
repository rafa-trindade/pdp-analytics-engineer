WITH base AS (
    SELECT
        dd.data AS data,
        EXTRACT(YEAR FROM dd.data)::INT AS ano,
        EXTRACT(MONTH FROM dd.data)::INT AS mes,
        dd.tipo,
        dd.valor
    FROM {{ source('core', 'dim_despesas') }} dd
)

, agregados AS (
    SELECT
        data,
        ano,
        mes,
        tipo AS tipo_despesa,
        SUM(valor) AS total_despesa
    FROM base
    GROUP BY data, ano, mes, tipo_despesa
    ORDER BY data, ano, mes, tipo_despesa
)

SELECT
    data,
    ano,
    mes,
    tipo_despesa,
    total_despesa
FROM agregados