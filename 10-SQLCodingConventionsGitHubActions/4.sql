/*
Code	Line / Position	Description
L059	2 / 23	
Unnecessary quoted identifier "Equipment".
L059	3 / 29	
Unnecessary quoted identifier "QTY".
L013	8 / 5	
Column expression without alias. Use explicit `AS` clause.
L013	9 / 5	
Column expression without alias. Use explicit `AS` clause.
L030	9 / 5	
Function names must be consistently upper case.
*/
SELECT
    equipment_name AS "Equipment",
    COUNT(serial_number) AS "QTY"
FROM equipment
GROUP BY equipment_name
UNION ALL
SELECT
    'Total count of equipment:',
    count(equipment_id)
FROM equipment