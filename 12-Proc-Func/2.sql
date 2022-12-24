/*
2.1. Повторити виконання завдання 1 етапу 1, створивши процедуру з вхідним
параметром у вигляді кількості рядків, що вносяться.
Навести приклад виконання створеної процедури.
*/
CREATE OR REPLACE PROCEDURE insert_n_rows_to_customer(n_rows IN NUMBER)
    IS
    t1    TIMESTAMP;
    t2    TIMESTAMP;
    delta NUMBER;
BEGIN
    t1 := SYSTIMESTAMP;
    FOR i IN 1..n_rows
        LOOP
            INSERT
            INTO customer (customer_id, first_name, last_name, phone_number, inviter, email)
            VALUES (customer_seq.nextval, 'Mykola', 'Heshko', 
            '+56(401)590-01-22', 1, 'heshko@gmail.com');
        END LOOP;
    t2 := SYSTIMESTAMP;
    delta := TO_NUMBER(TO_CHAR(t2, 'HHMISS.FF3'), '999999.999') -
             TO_NUMBER(TO_CHAR(t1, 'HHMISS.FF3'), '999999.999');
    dbms_output.put_line('Time = ' || delta || 's');
END;
/

BEGIN
    insert_n_rows_to_customer(333);
    ROLLBACK;
END;
/
-- Time = ,115s
/*
2.2. Створити функцію, яка повертає суму значень однієї з цілих колонок однієї з
таблиць. Навести приклад виконання створеної функції.
*/
CREATE OR REPLACE FUNCTION calc_sum_price_by_customer_id(c_id IN equipment.customer_id%TYPE)
    RETURN NUMBER
    IS
    result NUMBER;
BEGIN
    SELECT SUM(assessed_price)
    INTO result
    FROM equipment
    WHERE customer_id = c_id;
    RETURN result;
END;
/

BEGIN
    dbms_output.put_line('Загальна вартість усієї техніки : ' || calc_sum_price_by_customer_id(23));
END;
/
-- Загальна вартість усієї техніки : 550