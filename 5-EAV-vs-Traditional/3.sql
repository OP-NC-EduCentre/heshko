/*
3.1 Створити таблицю описів листових значень.
*/
CREATE TABLE LISTS (
	ATTR_ID NUMBER(10),
	LIST_VALUE_ID NUMBER(10),
	VALUE VARCHAR(4000)
);

ALTER TABLE LISTS ADD CONSTRAINT LISTS_PK
	PRIMARY KEY (LIST_VALUE_ID);
ALTER TABLE LISTS ADD CONSTRAINT LISTS_ATTR_ID_FK
	FOREIGN KEY (ATTR_ID) REFERENCES ATTRTYPE(ATTR_ID);
/*
Table LISTS created.

Table LISTS altered.

Table LISTS altered.
*/
/*
3.2 Для одного з атрибутних типів, який може містити кінцеву множину можливих значень,
заповнити описи листових значень.
*/
INSERT INTO LISTS(ATTR_ID, LIST_VALUE_ID, VALUE) 
	VALUES(4, 1, 'Велика побутова техніка');
INSERT INTO LISTS(ATTR_ID, LIST_VALUE_ID, VALUE) 
	VALUES(4, 2, 'Дрібна побутова техніка');
/*
1 row inserted.
1 row inserted.
*/
/*
3.3 Отримати інформацію про листові значення.
*/
SELECT 
    O.CODE,
    A.ATTR_ID,
    A.CODE,
    A.NAME,
    L.LIST_VALUE_ID,
    L.VALUE
FROM OBJTYPE O, ATTRTYPE A, LISTS L
WHERE 
    O.OBJECT_TYPE_ID = A.OBJECT_TYPE_ID 
    AND A.ATTR_ID = L.ATTR_ID
ORDER BY A.OBJECT_TYPE_ID,A.ATTR_ID;
/*
-- CODE      |ATTR_ID|CODE             |NAME     |LIST_VALUE_ID|VALUE     |
-- ----+-------+----+--------------+-------------+----------+
-- EQUIPMENT |     4|EQUIPMENT_NAME|Назва техніки|            1|Велика побутова техніка  |
-- EQUIPMENT |     4|EQUIPMENT_NAME|Назва техніки|            2|Дрібна побутова техніка   |
*/