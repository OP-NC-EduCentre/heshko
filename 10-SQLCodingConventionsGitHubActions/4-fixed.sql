SELECT
    equipment_name AS equipment,
    COUNT(serial_number) AS qty
FROM equipment
GROUP BY equipment_name
UNION ALL
SELECT
    'Total count of equipment:',
    COUNT(equipment_id)
FROM equipment
