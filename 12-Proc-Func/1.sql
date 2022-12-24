/*
1.1. Повторіть виконання завдання 4 етапу 1 із попередньої лабораторної роботи:
− циклічно внести 5000 рядків;
− визначити загальний час на внесення зазначених рядків;
− вивести на екран значення часу.
*/
DECLARE
    t1    TIMESTAMP;
    t2    TIMESTAMP;
    delta NUMBER;
BEGIN
    t1 := SYSTIMESTAMP;
    FOR i IN 1..5000
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
ROLLBACK;

--Time = ,696s
/*
1.2. Повторіть виконання попереднього завдання, порівнявши час виконання
циклічних внесень рядків, використовуючи два способи: FOR і FORALL.
*/
DROP TABLE customer1;
DROP TABLE customer2;
CREATE TABLE customer1(id INTEGER, name VARCHAR2(55));
CREATE TABLE customer2(id INTEGER, name VARCHAR2(55));

DECLARE
    TYPE IdTab IS TABLE OF customer.customer_id%TYPE INDEX BY PLS_INTEGER;
    TYPE NameTab IS TABLE OF customer.first_name%TYPE INDEX BY PLS_INTEGER;
	customerids IdTab;
	customernames NameTab;
	iterations CONSTANT PLS_INTEGER := 5000;
    t1 TIMESTAMP;
	t2 TIMESTAMP;
	delta NUMBER;
BEGIN
    FOR j IN 1..iterations LOOP
	    customerids(j) := j;
		customernames(j) := 'Mykola' || TO_CHAR(j);		
	END LOOP;
    t1 := SYSTIMESTAMP;
    FOR i IN 1..iterations LOOP
        INSERT INTO customer1 (id, name)
        VALUES (customerids(i), customernames(i));
    END LOOP;
	t2 := SYSTIMESTAMP;
	delta := TO_NUMBER(TO_CHAR(t2, 'HHMISS.FF3'), '999999.999') -
					   TO_NUMBER(TO_CHAR(t1, 'HHMISS.FF3'),'999999.999');
	DBMS_OUTPUT.PUT_LINE('FOR IN LOOP time (millisec) = ' || delta);
	
	t1 := SYSTIMESTAMP;
	FORALL i IN 1..iterations
		INSERT INTO customer2 (id, name)
        VALUES (customerids(i), customernames(i));
	t2 := SYSTIMESTAMP;
	delta := TO_NUMBER(TO_CHAR(t2, 'HHMISS.FF3'), '999999.999') -
					   TO_NUMBER(TO_CHAR(t1, 'HHMISS.FF3'),'999999.999');
	DBMS_OUTPUT.PUT_LINE('FORALL-operator time (millisec) = ' || delta);
END;
/
/*
FOR IN LOOP time (millisec) = ,391
FORALL-operator time (millisec) = ,1
*/
/*
1.3. Для однієї з таблиць отримайте рядки з використанням курсору та пакетної
обробки SELECT-операції з оператором BULK COLLECT.
*/
DECLARE
    CURSOR equipment_list_cursor IS
        SELECT equipment_id,
               equipment_name,
               assessed_price
        FROM equipment;
    TYPE equipment_list_bulk_type IS TABLE OF equipment_list_cursor%ROWTYPE;
    equipment_list_bulk equipment_list_bulk_type;
BEGIN
    dbms_output.put_line('Список техніки (CURSOR):');
    dbms_output.put_line(RPAD('equipment_id', 20, ' ') || RPAD('equipment_name', 20, ' ') || 'assessed_price');
    FOR equipment_item IN equipment_list_cursor
        LOOP
            dbms_output.put_line(RPAD(equipment_item.equipment_id, 20, ' ')
                || RPAD(equipment_item.equipment_name, 20, ' ')
                || equipment_item.assessed_price);
        END LOOP;

    dbms_output.put_line('Список техніки (BULK COLLECT):');
    SELECT equipment_id,
           equipment_name,
           assessed_price BULK COLLECT
    INTO equipment_list_bulk
    FROM equipment;
    dbms_output.put_line(RPAD('equipment_id', 20, ' ') || RPAD('equipment_name', 20, ' ') || 'assessed_price');
    FOR i IN equipment_list_bulk.first..equipment_list_bulk.last
        LOOP
            dbms_output.put_line(RPAD(equipment_list_bulk(i).equipment_id, 20, ' ')
                || RPAD(equipment_list_bulk(i).equipment_name, 20, ' ')
                || equipment_list_bulk(i).assessed_price);
        END LOOP;
END;
/
/*
Список техніки (CURSOR):
equipment_id        equipment_name      assessed_price
1                   Холодильник SAMSUNG 500
23                  Microwave Microwave 550
43                  Fridge B1-V         600
84                  Microwave LAN       550
Список техніки (BULK COLLECT):
equipment_id        equipment_name      assessed_price
1                   Холодильник SAMSUNG 500
23                  Microwave Microwave 550
43                  Fridge B1-V         600
84                  Microwave LAN       550
*/