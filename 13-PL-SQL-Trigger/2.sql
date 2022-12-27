/*
1. Створити тригер для реалізації каскадного видалення рядків зі значеннями PK-
колонки, пов'язаних з FK-колонкою. Навести тест-кейс перевірки роботи тригера.
*/
create or replace TRIGGER customer_cascade_delete
	AFTER DELETE ON customer
	FOR EACH ROW
BEGIN
	DELETE FROM equipment e
	WHERE e.customer_id = :OLD.customer_id;
END;

DELETE
FROM customer
WHERE customer_id = 107;

-- Видалився клієнт та вся його техніка
/*
2. Створити тригер для реалізації предметно-орієнтованого контролю спроби
додавання значення FK-колонки, що не існує у PK-колонці. Навести тест-кейс перевірки
роботи тригера.
*/
DROP TRIGGER equipment_insert_customer_id_control;

CREATE OR REPLACE TRIGGER equipment_insert_customer_id_control
    BEFORE INSERT
    ON equipment
    FOR EACH ROW
DECLARE
    customer_id customer.customer_id%TYPE;
BEGIN
    SELECT customer_id
    INTO customer_id
    FROM customer
    WHERE customer_id = :new.customer_id;
EXCEPTION
    WHEN no_data_found THEN
        RAISE_APPLICATION_ERROR(-20551, 'Customer with id=' || :new.customer_id || ' NOT EXISTS!');
END;
/

INSERT INTO equipment(equipment_id, equipment_name, serial_number, customer_id)
VALUES (equipment_seq.NEXTVAL, 'Microwave', 'BW-1AFA-V', 5555)

/*
Error report -
ORA-20551: Customer with id=5555 NOT EXISTS!
ORA-06512: на  "HESHKO.EQUIPMENT_INSERT_CUSTOMER_ID_CONTROL", line 10
ORA-04088: ошибка во время выполнения триггера 'HESHKO.EQUIPMENT_INSERT_CUSTOMER_ID_CONTROL'
*/