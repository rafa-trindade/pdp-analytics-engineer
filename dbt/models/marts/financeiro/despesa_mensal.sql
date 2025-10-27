WITH base AS (
    SELECT
        EXTRACT(YEAR FROM dd.data)::INT AS ano,
        EXTRACT(MONTH FROM dd.data)::INT AS mes,
        dd.tipo,
        dd.valor
    FROM {{ source('core', 'dim_despesas') }} dd
)

, agregados AS (
    SELECT
        ano,
        mes,
        tipo as tipo_despesa,
        SUM(valor) AS total_despesa
    FROM base
    GROUP BY ano, mes, tipo_despesa
    ORDER BY ano, mes, tipo_despesa
)

SELECT
    ano,
    mes,
    tipo_despesa,
    total_despesa
FROM agregados