/*
1.1. Для всіх таблиць нової БД створити генератори послідовності, щоб забезпечити
автоматичне створення нових значень колонок, які входять у первинний ключ. Врахувати наявність
рядків у таблицях. Виконати тестове внесення одного рядка до кожної таблиці.
*/
CREATE SEQUENCE customer_seq START WITH 3 INCREMENT BY 1;
CREATE SEQUENCE equipment_seq START WITH 3 INCREMENT BY 1;

INSERT INTO customer(customer_id, first_name, last_name, phone_number) VALUES (customer_seq.nextval, 'Mykola', 'Heshko', '+380636669696');
INSERT INTO equipment (equipment_id, equipment_name, serial_number, conclusion, customer_id, first_appeal) 
VALUES (equipment_seq.nextval, 'Microwave Noname', 'WB-53544', 'Потрібна діагностика', 2, TO_DATE('23/04/22', 'DD/MM/YY'))
/*
Sequence CUSTOMER_SEQ created.
Sequence EQUIPMENT_SEQ created.

1 row inserted.

1 row inserted.
*/
/*
1.2 Для всіх пар взаємопов'язаних таблиць створити транзакції, що включають дві INSERT-
команди внесення рядка в дві таблиці кожної пари з урахуванням зв'язку між PK-колонкою першої

таблиці і FK-колонкою 2-ї таблиці пари з використанням псевдоколонок NEXTVAL і CURRVAL.
*/
INSERT INTO customer(customer_id, first_name, last_name, phone_number) 
VALUES (customer_seq.nextval, 'Артур', 'Второй', '+380636669677');
INSERT INTO equipment (equipment_id, equipment_name, serial_number, conclusion, customer_id, first_appeal) 
VALUES (equipment_seq.nextval, 'Microwave', 'WM-5521', 'Потрібна діагностика', customer_seq.CURRVAL, TO_DATE('23/04/22', 'DD/MM/YY'))
/*
1 row inserted.

1 row inserted.
*/
/*
1.3 Отримати інформацію про створені генератори послідовностей, використовуючи системну
таблицю СУБД Oracle.
*/
select * from USER_SEQUENCES;
/*
SEQUENCE_NAME                                                                                                                     MIN_VALUE  MAX_VALUE INCREMENT_BY C O CACHE_SIZE LAST_NUMBER S E S K
-------------------------------------------------------------------------------------------------------------------------------- ---------- ---------- ------------ - - ---------- ----------- - - - -
CUSTOMER_SEQ                                                                                                                              1 1.0000E+28            1 N N         20          63 N N N N
EQUIPMENT_SEQ                                                                                                                             1 1.0000E+28            1 N N         20          43 N N N N
*/
/*
1.4 Використовуючи СУБД Oracle >= 12 для однієї з таблиць створити генерацію унікальних
значень PK-колонки через DEFAULT-оператор. Виконати тестове внесення одного рядка до таблиці.
*/
ALTER TABLE customer MODIFY 
  (customer_id number DEFAULT customer_seq.nextval NOT NULL);
    
INSERT INTO customer(first_name, last_name, phone_number) 
VALUES ('Виталий', 'Второй', '+380631679611');
/*
Table CUSTOMER altered.


1 row inserted.
*/
