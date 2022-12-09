/*
3.1. Виконайте DELETE-запит із попередніх рішень, додавши аналіз даних із неявного
курсору. Наприклад, кількість віддалених рядків
*/
BEGIN
    DELETE FROM equipment WHERE conclusion = 'Не підлягає ремонту';
    dbms_output.put_line('Deleted rows count = ' || SQL%ROWCOUNT);
END;
--Deleted rows count = 2
/*
3.2. Повторіть виконання завдання 3 етапу 1 з використанням явного курсору.
*/
DECLARE
    CURSOR equipment_avg_sum_list IS
        SELECT equipment_name,
               AVG(assessed_price) AS avg_price
        FROM equipment
        GROUP BY equipment_name;
BEGIN
    dbms_output.put_line(RPAD('equipment_name', 20, ' ') || 'avg_price');
    FOR equipment_avg_price IN equipment_avg_sum_list
        LOOP
            dbms_output.put_line(RPAD(equipment_avg_price.equipment_name, 20, ' ')
                || equipment_avg_price.avg_price);
        END LOOP;
END;
/
/*
equipment_name      avg_price
Microwave LAN       550
Microwave Microwave 550
Холодильник SAMSUNG 500
Fridge B1-V         600
*/
/*
3.3. 
З урахуванням вашої предметної області створити анонімний PL/SQL-блок, який
викликатиме один із варіантів подібних SQL-запитів залежно від значення версії СУБД.
При вирішенні використовувати:
− значення змінної DBMS_DB_VERSION.VERSION;
− явний курсор із параметричним циклом.
*/
BEGIN
    dbms_output.put_line('Current version = ' || dbms_db_version.version);

    IF dbms_db_version.version < 12 THEN
        DECLARE
            CURSOR equipment_list IS
                WITH equipment_name_price AS (SELECT equipment_name, assessed_price
                                              FROM equipment
                                              ORDER BY assessed_price DESC),
                     equipment_name_price_rownum AS (SELECT rownum AS r,
                                                            equipment_name,
                                                            assessed_price
                                                     FROM equipment_name_price)
                SELECT equipment_name,
                       assessed_price
                FROM equipment_name_price_rownum
                WHERE r <= 5;
        BEGIN
            dbms_output.put_line(RPAD('equipment', 15, ' ') || 'assessed_price');
            FOR item IN equipment_list
                LOOP
                    dbms_output.put_line(RPAD(item.equipment_name, 15, ' ')
                        || item.assessed_price);
                END LOOP;
        END;

    ELSE
        DECLARE
            CURSOR equipment_list IS
                SELECT equipment_name, assessed_price
                FROM equipment
                ORDER BY assessed_price DESC FETCH FIRST 5 ROWS ONLY;
        BEGIN
            dbms_output.put_line(RPAD('equipment', 15, ' ') || 'assessed_price');
            FOR item IN equipment_list
                LOOP
                    dbms_output.put_line(RPAD(item.equipment_name, 15, ' ')
                        || item.assessed_price);
                END LOOP;
        END;
    END IF;
END;
/
/*
Current version = 18
equipment      assessed_price
Fridge B1-V    600
Microwave Micro550
Microwave LAN  550
Холодильник SAM500
*/