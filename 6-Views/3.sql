/*
3.1 Створити нового користувача, ім'я якого = «ваше_прізвище_латиницею»+'EAV',
наприклад, blazhko_eav, з правами, достатніми для створення та заповнення таблиць БД EAV.
*/
CREATE USER heshko_eav IDENTIFIED BY password;
GRANT CONNECT TO heshko_eav;
GRANT CREATE TABLE TO heshko_eav;
GRANT CREATE SEQUENCE TO heshko_eav;
GRANT RESOURCE TO heshko_eav;
ALTER USER heshko_eav QUOTA UNLIMITED ON users;
/*
3.2 Створити таблиці БД EAV та заповнити таблиці об'єктних типів та атрибутних типів,
взявши рішення з лабораторної роботи No5.
*/
CREATE TABLE objtype
(
    object_type_id NUMBER(20),
    parent_id      NUMBER(20),
    code           VARCHAR2(20),
    name           VARCHAR2(200),
    description    VARCHAR2(1000)
);

ALTER TABLE objtype
    ADD CONSTRAINT objtype_pk
        PRIMARY KEY (object_type_id);
ALTER TABLE objtype
    ADD CONSTRAINT objtype_code_unique
        UNIQUE (code);
ALTER TABLE objtype
    MODIFY (code NOT NULL);
ALTER TABLE objtype
    ADD CONSTRAINT objtype_fk
        FOREIGN KEY (parent_id) REFERENCES objtype (object_type_id);

INSERT INTO objtype (object_type_id, parent_id, code, name, description)
    VALUES (1, NULL, 'CUSTOMER', 'Клієнт', 'Інформація про клієнта');

INSERT INTO objtype (object_type_id, parent_id, code, name, description)
    VALUES (2, 1, 'EQUIPMENT', 'Техніка', 'Інформація про техніку на ремонті');

CREATE TABLE ATTRTYPE (
    ATTR_ID      		NUMBER(20),
    OBJECT_TYPE_ID 		NUMBER(20),
	OBJECT_TYPE_ID_REF 	NUMBER(20),
    CODE         		VARCHAR2(20),
    NAME         		VARCHAR2(200)
);

ALTER TABLE ATTRTYPE ADD CONSTRAINT ATTRTYPE_PK
	PRIMARY KEY (ATTR_ID);
ALTER TABLE ATTRTYPE ADD CONSTRAINT ATTRTYPE_OBJECT_TYPE_ID_FK
	FOREIGN KEY (OBJECT_TYPE_ID) REFERENCES OBJTYPE (OBJECT_TYPE_ID);
ALTER TABLE ATTRTYPE ADD CONSTRAINT ATTRTYPE_OBJECT_TYPE_ID_REF_FK
	FOREIGN KEY (OBJECT_TYPE_ID_REF) REFERENCES OBJTYPE (OBJECT_TYPE_ID);

INSERT INTO ATTRTYPE (ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME) 
	VALUES (1, 1, NULL, 'first_name', 'Імя');

INSERT INTO ATTRTYPE (ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME) 
	VALUES (2, 1, NULL, 'last_name', 'Прізвище');

INSERT INTO ATTRTYPE (ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME) 
	VALUES (3, 1, NULL, 'phone', 'Номер телефону');


INSERT INTO ATTRTYPE (ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME) 
	VALUES (4, 2, NULL, 'EQUIPMENT_NAME', 'Назва техніки');
INSERT INTO ATTRTYPE (ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME) 
	VALUES (5, 2, NULL, 'SERIAL_NUMBER', 'Серійний номер');
INSERT INTO ATTRTYPE (ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME) 
	VALUES (6, 2, NULL, 'CONCLUSION', 'Висновок');
INSERT INTO ATTRTYPE (ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME) 
	VALUES (7, 2, NULL, 'owner', 'Власник');
INSERT INTO ATTRTYPE (ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME) 
	VALUES (8, 2, NULL, 'first_appeal', 'Дата звернення');

CREATE TABLE OBJECTS (
	OBJECT_ID      NUMBER(20),
	PARENT_ID      NUMBER(20),
	OBJECT_TYPE_ID NUMBER(20),
	NAME           VARCHAR2(2000),
	DESCRIPTION    VARCHAR2(4000)
);

ALTER TABLE OBJECTS ADD CONSTRAINT OBJECTS_PK
	PRIMARY KEY (OBJECT_ID);
ALTER TABLE OBJECTS ADD CONSTRAINT OBJECTS_PARENT_ID_FK
	FOREIGN KEY (PARENT_ID) REFERENCES OBJECTS (OBJECT_ID);
ALTER TABLE OBJECTS ADD CONSTRAINT OBJECTS_OBJECT_TYPE_ID_FK
	FOREIGN KEY (OBJECT_TYPE_ID) REFERENCES OBJTYPE (OBJECT_TYPE_ID);
/*
3.3 Створити генератор послідовності таблиці OBJECTS БД EAV, ініціалізувавши його
початковим значенням з урахуванням вже заповнених значень.
*/
CREATE SEQUENCE objects_id_seq;
/*
3.4 Налаштувати права доступу нового користувача до таблиць схеми даних із таблицями
реляційної БД вашої предметної області, створеної в лабораторній роботі No2.
*/
GRANT SELECT ON heshko.customer TO heshko_eav;
GRANT SELECT ON heshko.equipment TO heshko_eav;
/*
3.5 Створити множину запитів типу INSERT INTO ... SELECT, які автоматично заповнять
таблицю OBJECTS, взявши потрібні дані з реляційної бази даних вашої предметної області.
*/
INSERT
INTO objects (object_id, parent_id, object_type_id, name)
SELECT objects_id_seq.nextval, NULL, ot.object_type_id, c.first_name
FROM objtype ot,
     heshko.customer c
WHERE ot.code = 'customer';


INSERT
INTO objects (object_id, parent_id, object_type_id, name)
SELECT objects_id_seq.nextval, ob.object_id, ot.object_type_id, '#' || equipment.equipment_id
FROM objtype ot,
     heshko.customer customer,
     heshko.equipment equipment,
     objects ob
WHERE ot.code = 'equipment'
  AND customer.customer_id = equipment.customer_id
  AND customer.first_name = ob.name;

INSERT
INTO objects (object_id, parent_id, object_type_id, name)
SELECT objects_id_seq.nextval, ob.object_id, ot.object_type_id, equipment.equipment_name
FROM objtype ot,
     heshko.equipment equipment,
     heshko.customer customer,
     objects ob
WHERE ot.code = 'equipment'
  AND customer.customer_id = equipment.customer_id (+)
  AND 'CUSTOMER' || customer.customer_id = equipment.equipment_name (+);

SELECT object_id, parent_id, object_type_id, name FROM objects;
/*
 OBJECT_ID  PARENT_ID OBJECT_TYPE_ID
---------- ---------- --------------
NAME                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
         1                         1 
Гешко М.М.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              

         2                         1 
Герасименко И.В.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        

         3          1              2 
Холодильник                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             


 OBJECT_ID  PARENT_ID OBJECT_TYPE_ID
---------- ---------- --------------
NAME                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
         4          1              2 
Чайник                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  

         5                         2 
Білий колір                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             

         6                         2 
Блакитний колір                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         


6 rows selected. 
*/