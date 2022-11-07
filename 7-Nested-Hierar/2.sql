/*
1. Багатотабличне внесення даних
*/
INSERT ALL
    INTO customer (customer_id, first_name, last_name, phone_number)
        VALUES (customer_seq.nextval, 'Mykola', 'Heshko', '+380123456789')
    INTO equipment (equipment_id, equipment_name, serial_number, conclusion, customer_id, first_appeal)
        VALUES (equipment_seq.nextval, 'Холодильник Samsung', 'HOLODILNIK-1V', 'Потрібен ремонт', customer_seq.CURRVAL, SYSDATE)
SELECT * FROM dual;
/*
2. Використання багатостовпцевих підзапитів при зміні даних
*/
UPDATE equipment
    SET (conclusion) = (SELECT conclusion FROM equipment WHERE equipment_id = 7)
WHERE equipment_id = 2;
/*
3. Видалення рядків із використанням кореляційних підзапитів.
*/
DELETE FROM 
    (
        SELECT * FROM equipment
        WHERE equipment_id = 
        (
            SELECT equipment_id 
            FROM equipment WHERE serial_number = 'HOLODILNIK-1V'
        )
    );
/*
4. Поєднаний INSERT/UPDATE запит – оператор MERGE
*/
CREATE TABLE customer_staging AS 
SELECT * FROM customer;

MERGE INTO customer_staging x
USING (SELECT customer_id, first_name, last_name, phone_number FROM customer) y
ON (x.customer_id  = y.customer_id)
WHEN MATCHED THEN
    UPDATE SET x.first_name = y.first_name, 
                        x.last_name = y.last_name, 
                        x.phone_number = y.phone_number
    WHERE x.first_name <> y.first_name OR 
           x.last_name <> y.last_name OR 
           x.phone_number <> y.phone_number 
WHEN NOT MATCHED THEN
    INSERT(x.customer_id, x.first_name, x.last_name, x.phone_number)  
    VALUES(y.customer_id, y.first_name, y.last_name, y.phone_number);