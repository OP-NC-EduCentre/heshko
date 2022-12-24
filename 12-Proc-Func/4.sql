/*
4.1. З урахуванням вашої предметної області створити табличну функцію, що
повертає значення будь-яких двох колонок будь-якої таблиці з урахуванням значення однієї
з колонок, що передається як параметр. Показати приклад виклику функції.
*/
DROP TYPE equipment_info_list;
DROP TYPE equipment_info;

CREATE TYPE equipment_info AS OBJECT (
	equipment_id NUMBER(4),
	equipment_name VARCHAR(50),
	assessed_price NUMBER(5)
);
/

CREATE TYPE equipment_info_list IS TABLE OF equipment_info;
/

CREATE OR REPLACE FUNCTION get_equipment_info_by_customer (c_id IN NUMBER)
RETURN equipment_info_list
AS
	equipment_list equipment_info_list := equipment_info_list();
BEGIN
	SELECT equipment_info(equipment_id, equipment_name, assessed_price)
		BULK COLLECT INTO equipment_list
		FROM equipment
		WHERE customer_id = c_id;
	RETURN equipment_list;
END;
/

SELECT equipment_id, equipment_name, assessed_price
FROM TABLE(get_equipment_info_by_customer(23))
ORDER BY assessed_price ASC;
/*
EQUIPMENT_ID EQUIPMENT_NAME                                     ASSESSED_PRICE
------------ -------------------------------------------------- --------------
          23 Microwave Microwave                                           550
*/
/*
4.2. Повторіть рішення попереднього завдання, але з використанням конвеєрної
табличної функції.
*/
CREATE OR REPLACE PACKAGE equipment_info_pack IS
	TYPE equipment_info IS RECORD (
		equipment_id NUMBER(4),
		equipment_name VARCHAR(55),
		assessed_price NUMBER(5)
	);
	TYPE equipment_info_list IS TABLE OF equipment_info;
	FUNCTION get_equipment_info_by_customer (c_id IN NUMBER)
		RETURN equipment_info_list PIPELINED;
END equipment_info_pack;
/

-- створення тіла пакету

CREATE OR REPLACE PACKAGE BODY equipment_info_pack IS
	FUNCTION get_equipment_info_by_customer (c_id IN NUMBER)
		RETURN equipment_info_list PIPELINED
	AS
	BEGIN
		FOR elem IN (SELECT equipment_id, equipment_name, assessed_price
					FROM equipment
					WHERE customer_id = c_id) LOOP
			PIPE ROW(elem);
		END LOOP;
	END;
END equipment_info_pack; 
/

-- виклик функції з пакету

SELECT equipment_id, equipment_name, assessed_price
FROM TABLE(equipment_info_pack.get_equipment_info_by_customer(23))
ORDER BY assessed_price ASC;
/*
EQUIPMENT_ID EQUIPMENT_NAME                                          ASSESSED_PRICE
------------ ------------------------------------------------------- --------------
          23 Microwave Microwave                                                550
*/