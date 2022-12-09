/*
1.1. Виберіть таблицю бази даних, що містить стовпець типу date. Оголосіть змінні, що
відповідають стовпцям цієї таблиці, використовуючи посилальні типи даних. Надайте змінним
значення, використовуйте SQL-функції для формування значень послідовності, перетворення
дати до вибраного стилю. Виведіть на екран рядок.
*/
DECLARE
    v_equipment equipment%ROWTYPE;
BEGIN
    v_equipment.equipment_id := equipment_seq.nextval;
    v_equipment.equipment_name := 'Microwave';
    v_equipment.serial_number := 'MCRO-1455';
    v_equipment.conclusion := 'Потрібен ремонт';
    v_equipment.customer_id := 1;
    v_equipment.first_appeal := TO_DATE('08/08/2022', 'DD/MM/YYYY');
    v_equipment.assessed_price := 550;
    dbms_output.put_line('equipment_id = ' || v_equipment.equipment_id);
    dbms_output.put_line('first_appeal = ' || v_equipment.first_appeal);
END;
/
--equipment_id = 103
--first_appeal = 08.08.2022
/*
1.2. Додати інформацію до однієї з таблиць, обрану у попередньому завданні.
Використовувати формування нового значення послідовності та перетворення формату дати.
*/
BEGIN
    INSERT
    INTO equipment (equipment_id, equipment_name, serial_number, conclusion, customer_id, first_appeal, assessed_price)
    VALUES (equipment_seq.nextval, 'Microwave LAN', 'MCROlan-1456', 'Потрібен ремонт', 1,
            TO_DATE('08/08/2022', 'DD/MM/YYYY'), 550);
END;
/
--PL/SQL procedure successfully completed.
/*
1.3. Для однієї з таблиць створити команду отримання середнього значення однієї з
цілих колонок, використовуючи умову вибірки за заданим значенням іншої колонки. Результат
присвоїти змінній і вивести на екран.
*/
DECLARE
    v_equipment_avg_price equipment.assessed_price%TYPE;
BEGIN
    SELECT AVG(assessed_price)
    INTO v_equipment_avg_price
    FROM equipment
    WHERE conclusion = 'Потрібен ремонт';
    dbms_output.put_line('Average price of goods under repair = ' || v_equipment_avg_price);
END;
/
--Average price of goods under repair = 575
/*
1.4. Виконайте введення 5 рядків у таблицю бази даних, використовуючи цикл з
параметрами. Значення первинного ключа генеруються автоматично, решта даних дублюється.
*/
BEGIN
    FOR i IN 1..5
        LOOP
            INSERT
            INTO customer (customer_id, first_name, last_name, phone_number, inviter, email)
            VALUES (customer_seq.nextval, 'Mykola', 'Heshko', '+380636629593',
                    2, 'kolya.geshko@gmail.com');
        END LOOP;
END;
/