/*
4.1 Створити таблицю описів екземплярів об'єктів.
*/
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
Table OBJECTS created.

Table OBJECTS altered.

Table OBJECTS altered.

Table OBJECTS altered.

*/
/*
4.2 На основі вмісту двох рядків двох таблиць, заповнених у лабораторній роботі No3,
заповнити описи екземплярів об'єктів.
*/
INSERT INTO OBJECTS (OBJECT_ID, PARENT_ID, OBJECT_TYPE_ID, NAME, DESCRIPTION)
VALUES (1, NULL, 1, 'Гешко М.М.', NULL);
INSERT INTO OBJECTS (OBJECT_ID, PARENT_ID, OBJECT_TYPE_ID, NAME, DESCRIPTION)
VALUES (2, NULL, 1, 'Герасименко И.В.', NULL);

INSERT INTO OBJECTS (OBJECT_ID, PARENT_ID, OBJECT_TYPE_ID, NAME, DESCRIPTION)
VALUES (3, 1, 2, 'Холодильник', 'Не проходит питание');
INSERT INTO OBJECTS (OBJECT_ID, PARENT_ID, OBJECT_TYPE_ID, NAME, DESCRIPTION)
VALUES (4, 1, 2, 'Чайник', 'Не работает батарея');
/*
1 row inserted.

1 row inserted.

1 row inserted.

1 row inserted.
*/
/*
4.3 Отримати колекцію екземплярів об'єктів для одного з об'єктних типів, використовуючи
його код.
*/
SELECT 
    CAR.OBJECT_ID,
    CAR.NAME
FROM OBJECTS CAR, OBJTYPE OT 
WHERE 	
    OT.CODE = 'EQUIPMENT' 
	AND OT.OBJECT_TYPE_ID = CAR.OBJECT_TYPE_ID;
/*
 OBJECT_ID|NAME        |
 ---------+------------+
         3|Холодильник|
         4|Чайник|
*/
/*
4.4 Отримати один екземпляр об'єкта заданого імені для одного з об'єктних типів,
використовуючи його код.
*/
SELECT 
    CAR.OBJECT_ID,
    CAR.NAME
FROM OBJECTS CAR, OBJTYPE CAR_TYPE
WHERE 
	CAR.NAME = 'Холодильник'
	AND CAR_TYPE.CODE = 'EQUIPMENT'
	AND CAR_TYPE.OBJECT_TYPE_ID = CAR.OBJECT_TYPE_ID;
/*
-- OBJECT_ID|NAME        |
-- ---------+------------+
--         3|Холодильник|
*/