/*
1. Розробити механізм журналізації DML-операцій, що виконуються над таблицею
вашої бази даних, враховуючи такі дії:
– створити таблицю з ім'ям LOG_ім'я_таблиці. Структура таблиці повинна
включати: ім'я користувача, тип операції, дата виконання операції, атрибути, що містять
старі та нові значення.
– створити тригер журналювання.
Перевірити роботу тригера журналювання для операцій INSERT, UPDATE,
DELETE.
*/
CREATE TABLE customer_log
(
    operation_author VARCHAR2(64),
    operation_type   VARCHAR(16),
    operation_date   DATE,
    new_first_name   VARCHAR2(30),
    old_first_name   VARCHAR2(30),
    new_last_name    VARCHAR2(50),
    old_last_name    VARCHAR2(50),
    new_phone_number VARCHAR2(24),
    old_phone_number VARCHAR2(24),
    new_email        VARCHAR2(64),
    old_email        VARCHAR2(64)
);

CREATE OR REPLACE TRIGGER customer_log
    AFTER INSERT OR UPDATE OR DELETE
    ON customer
    FOR EACH ROW
DECLARE
    operation_type customer_log.operation_type%TYPE;
BEGIN
    IF INSERTING THEN
        operation_type := 'INSERT';
    ELSIF UPDATING THEN
        operation_type := 'UPDATE';
    ELSIF DELETING THEN
        operation_type := 'DELETE';
    END IF;

    INSERT
    INTO customer_log
    VALUES (USER, operation_type, SYSDATE,
            :new.first_name, :old.first_name,
            :new.last_name, :old.last_name,
            :new.phone_number, :old.phone_number,
            :new.email, :old.email);
END;
/

INSERT
INTO customer (customer_id, first_name, last_name, phone_number, inviter, email)
VALUES (client_id_seq.nextval, 'Ivan', 'Navi', '+38(063)371-02-51', 1,  'kolya.dadadw@gmail.com');

INSERT
INTO customer (customer_id, first_name, last_name, phone_number, inviter, email)
VALUES (customer_seq.nextval, 'Ivan', 'Navi', '+38(063)371-02-51', 1,  'kolya.dadadw@gmail.com');

UPDATE customer
SET first_name = 'Andrew'
WHERE customer_id = 629400;

DELETE customer
WHERE customer_id = 629400;

/*
+----------------+--------------+-------------------+---------------------+---------------------+
|OPERATION_AUTHOR|OPERATION_TYPE|OPERATION_DATE     |NEW_FIRST_NAME       |OLD_FIRST_NAME       |
+----------------+--------------+-------------------+---------------------+---------------------+
|HESHKO          |INSERT        |2022-12-27 21:20:45|Ivan                 |null                 |
|HESHKO          |UPDATE        |2022-12-27 21:20:47|Andrew               |Ivan                 |
|HESHKO          |DELETE        |2022-12-27 21:20:48|null                 |Andrew               |
+----------------+--------------+-------------------+---------------------+---------------------+
*/
/*
2. Припустимо, що використовується СУБД до 12-ї версії, яка не підтримує механізм
DEFAULT SEQUENCE, який дозволяє автоматично внести нове значення первинного
ключа, якщо воно не задано при операції внесення. Для будь-якої колонки вашої бази даних
створити тригер з підтримкою механізму DEFAULT SEQUENCE. Навести тест-кейс
перевірки роботи тригера.
*/
CREATE OR REPLACE TRIGGER equipment_default_sequence
    BEFORE INSERT
    ON equipment
    FOR EACH ROW
BEGIN
    IF :new.equipment_id IS NULL THEN
        :new.equipment_id := equipment_seq.nextval;
    END IF;
END;
/

INSERT INTO equipment(equipment_id, equipment_name, serial_number, customer_id)
VALUES (equipment_seq.NEXTVAL, 'Microwave 2', 'BWAFA-V', 1);

SELECT equipment_id,
       equipment_name,
       serial_number
FROM equipment
WHERE serial_number = 'BWAFA-V';
/*
EQUIPMENT_ID EQUIPMENT_NAME                                     SERIAL_NUMBER                 
------------ -------------------------------------------------- ------------------------------
         163 Microwave 2                                        BWAFA-V                       

*/