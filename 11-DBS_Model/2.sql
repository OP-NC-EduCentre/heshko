/*
2.1. Повторити виконання завдання 3 етапу 1, забезпечивши контроль відсутності даних у
відповіді на запит із використанням винятку.
*/
DECLARE
    v_equipment_price equipment.assessed_price%TYPE;
BEGIN
    SELECT assessed_price
    INTO v_equipment_price
    FROM equipment
    WHERE conclusion = 'foo';
    dbms_output.put_line('Average price of goods under repair = ' || v_equipment_price);
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('Equipment with selected name not found');
END;
/
--Equipment with selected name not found
/*
2.2. Повторити виконання завдання 3 етапу 1, забезпечивши контроль отримання
багаторядкової відповіді на запит.
*/
DECLARE
    v_equipment_price equipment.assessed_price%TYPE;
BEGIN
    SELECT assessed_price
    INTO v_equipment_price
    FROM equipment
    WHERE conclusion = 'Потрібен ремонт';
    dbms_output.put_line('Average price of goods under repair = ' || v_equipment_price);
EXCEPTION
    WHEN too_many_rows THEN
        dbms_output.put_line('Query return more than one equipment');
END;
/
--Query return more than one equipment
/*
2.3. Повторити виконання завдання 3 етапу 1, забезпечивши контроль за внесенням
унікальних значень.
*/
BEGIN
    INSERT
    INTO equipment (equipment_id, equipment_name, serial_number, conclusion, customer_id, first_appeal, assessed_price)
    VALUES (equipment_seq.nextval, 'Microwave LAN', 'MCROlan-1456', 'Потрібен ремонт', 1,
            TO_DATE('08/08/2022', 'DD/MM/YYYY'), 550);
EXCEPTION
    WHEN dup_val_on_index THEN
        dbms_output.put_line('Unique constraint is violated');
END;
/
--Unique constraint is violated