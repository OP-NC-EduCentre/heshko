SELECT
    equipment_name,
    conclusion,
    ROUND(
        AVG(assessed_price) OVER (PARTITION BY conclusion)
    ) AS avg_assessed_price
FROM equipment;