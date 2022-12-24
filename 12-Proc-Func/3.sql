/*
3.1. Оформіть рішення завдань етапу 2 у вигляді програмного пакета. Наведіть
приклад виклику збереженої процедури та функції, враховуючи назву пакету.
*/
CREATE OR REPLACE PACKAGE equipment_utils IS
    PROCEDURE insert_n_rows_to_customer(n_rows IN NUMBER);
    FUNCTION calc_sum_price_by_customer_id(c_id IN equipment.customer_id%TYPE) RETURN NUMBER;
END equipment_utils;
/

CREATE OR REPLACE PACKAGE BODY equipment_utils IS
    PROCEDURE insert_n_rows_to_customer(n_rows IN NUMBER)
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
                VALUES (customer_seq.nextval, 'Mykola', 'Heshko', '+56(401)590-01-22', 1, 'heshko@gmail.com');
            END LOOP;
        t2 := SYSTIMESTAMP;
        delta := TO_NUMBER(TO_CHAR(t2, 'HHMISS.FF3'), '999999.999') -
                 TO_NUMBER(TO_CHAR(t1, 'HHMISS.FF3'), '999999.999');
        dbms_output.put_line('Time = ' || delta || 's');
    END;

    FUNCTION calc_sum_price_by_customer_id(c_id IN equipment.customer_id%TYPE)
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
END equipment_utils;
/

BEGIN
    insert_n_rows_to_customer(333);
    ROLLBACK;
    dbms_output.put_line('Загальна вартість усієї техніки : ' || equipment_utils.calc_sum_price_by_customer_id(23));
END;
/
/*
Time = ,05s
Загальна вартість усієї техніки : 550
*/