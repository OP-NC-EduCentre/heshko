/*
Code	Line / Position	Description
L036	1 / 1	
Select targets should be on a new line unless there is only one select target.
L001	4 / 16	
Unnecessary trailing whitespace.
L008	4 / 16	
Commas should be followed by a single whitespace unless followed by a comment.
*/
SELECT equipment_id,
    equipment_name,
    serial_number,
    conclusion, 
    customer_id,
    first_appeal
FROM equipment WHERE equipment_id > 2;