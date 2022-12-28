/*
1. Створити інформуючий тригер для виведення повідомлення на екран після
додавання, зміни або видалення рядка з будь-якої таблиці Вашої бази даних із зазначенням
у повідомленні операції, на яку зреагував тригер. Навести тест-кейс перевірки роботи
тригера.
*/
CREATE OR REPLACE TRIGGER equipment_modification_after
    AFTER INSERT OR UPDATE OR DELETE ON equipment
BEGIN
    IF INSERTING THEN
        dbms_output.put_line('INSERTING INTO EQUIPMENT ... ');
    ELSIF UPDATING THEN
        dbms_output.put_line('UPDATING EQUIPMENT ... ');
    ELSIF DELETING THEN
        dbms_output.put_line('DELETING EQUIPMENT ... ');
    END IF;
END;

INSERT INTO equipment (equipment_id, equipment_name, serial_number, conclusion, customer_id, first_appeal, assessed_price)
VALUES (equipment_seq.nextval, 'Microwave Testw', 'wdwa14fwa', 'Потрібен ремонт', 1, '14.12.22', 540);

-- INSERTING INTO EQUIPMENT ... 

UPDATE equipment
SET assessed_price = assessed_price + 300.00
WHERE equipment_id = 11;

-- UPDATING EQUIPMENT ... 

DELETE FROM equipment WHERE equipment_id = 11;

-- DELETING EQUIPMENT ... 
/*
2. Повторити попереднє завдання лише під час роботи користувача, ім'я якого
збігається з вашим логіном. Навести тест-кейс перевірки роботи тригера.
*/
CREATE OR REPLACE TRIGGER equipment_modification_after
    AFTER INSERT OR UPDATE OR DELETE ON equipment
    FOR EACH ROW
    WHEN (USER = 'HESHKO')
BEGIN
    IF INSERTING THEN
        dbms_output.put_line('INSERTING INTO EQUIPMENT ... ');
    ELSIF UPDATING THEN
        dbms_output.put_line('UPDATING EQUIPMENT ... ');
    ELSIF DELETING THEN
        dbms_output.put_line('DELETING EQUIPMENT ... ');
    END IF;
END;

INSERT INTO equipment (equipment_id, equipment_name, serial_number, conclusion, customer_id, first_appeal, assessed_price)
VALUES (equipment_seq.nextval, 'Microwave Test2', 'aaw-25wafa', 'Потрібен ремонт', 1, '15.12.22', 540);

-- INSERTING INTO EQUIPMENT ... 

UPDATE equipment
SET assessed_price = assessed_price + 150.00
WHERE equipment_id = 11;

-- UPDATING EQUIPMENT ... 

DELETE FROM equipment WHERE equipment_id = 11;

-- DELETING EQUIPMENT ... 

-- тест: Змінимо ім'я користувача

CREATE OR REPLACE TRIGGER equipment_modification_after
    AFTER INSERT OR UPDATE OR DELETE ON equipment
    FOR EACH ROW
    WHEN (USER = 'FOO')
BEGIN
    IF INSERTING THEN
        dbms_output.put_line('INSERTING INTO EQUIPMENT ... ');
    ELSIF UPDATING THEN
        dbms_output.put_line('UPDATING EQUIPMENT ... ');
    ELSIF DELETING THEN
        dbms_output.put_line('DELETING EQUIPMENT ... ');
    END IF;
END;

INSERT INTO equipment (equipment_id, equipment_name, serial_number, conclusion, customer_id, first_appeal, assessed_price)
VALUES (equipment_seq.nextval, 'Microwave Test3', 'awafawawffa', 'Потрібен ремонт', 1, '16.12.22', 570);

UPDATE equipment
SET assessed_price = assessed_price + 50.00
WHERE equipment_id = 11;

DELETE FROM equipment WHERE equipment_id = 11;

-- Повідомлення не виводяться
