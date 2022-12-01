/*
Code	Line / Position	Description
L036	1 / 1	
Select targets should be on a new line unless there is only one select target.
L012	3 / 66	
Implicit/explicit aliasing of columns.
L016	3 / 84	
Line is too long.
*/
SELECT equipment_name,
       conclusion,
       ROUND(AVG(assessed_price) OVER (PARTITION BY conclusion)) avg_assessed_price
FROM equipment;