/*
2.1. Створити таблицю описів атрибутних типів.
*/
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
/*
Table ATTRTYPE created.

Table ATTRTYPE altered.

Table ATTRTYPE altered.

Table ATTRTYPE altered.
*/
/*
2.2 Для раніше використаних класів UML-діаграми заповнити описи атрибутних типів.
*/
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
/*
1 row inserted.

1 row inserted.

1 row inserted.

1 row inserted.

1 row inserted.

1 row inserted.

1 row inserted.

1 row inserted.
*/
/*
2.3 Отримати інформацію про атрибутні типи.
*/
SELECT O.CODE,A.ATTR_ID,A.CODE,A.NAME, O_REF.CODE O_REF
FROM OBJTYPE O, ATTRTYPE A LEFT JOIN OBJTYPE O_REF ON 
    (A.OBJECT_TYPE_ID_REF = O_REF.OBJECT_TYPE_ID)
WHERE O.OBJECT_TYPE_ID = A.OBJECT_TYPE_ID
ORDER BY A.OBJECT_TYPE_ID,A.ATTR_ID;
/*
CODE                    ATTR_ID CODE                 NAME                                                                                                                                                                                                     O_REF               
-------------------- ---------- -------------------- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- --------------------
CUSTOMER                      1 first_name           Імя                                                                                                                                                                                                                          
CUSTOMER                      2 last_name            Прізвище                                                                                                                                                                                                                     
CUSTOMER                      3 phone                Номер телефону                                                                                                                                                                                                               
EQUIPMENT                     4 EQUIPMENT_NAME       Назва техніки                                                                                                                                                                                                                
EQUIPMENT                     5 SERIAL_NUMBER        Серійний номер                                                                                                                                                                                                               
EQUIPMENT                     6 CONCLUSION           Висновок                                                                                                                                                                                                                     
EQUIPMENT                     7 owner                Власник                                                                                                                                                                                                                      
EQUIPMENT                     8 first_appeal         Дата звернення                                                                                                                                                                                                          

8 rows selected. 
*/
/*
2.4 Отримати інформацію про атрибутні типи та можливі зв'язки між ними типу «іменована
асоціація».
*/
SELECT 
    O.CODE,
    A.ATTR_ID,
    A.CODE,
    A.NAME,
    O_REF.CODE AS O_REF
FROM OBJTYPE O, ATTRTYPE A 
    LEFT JOIN OBJTYPE O_REF ON (A.OBJECT_TYPE_ID_REF = O_REF.OBJECT_TYPE_ID)
WHERE O.OBJECT_TYPE_ID = A.OBJECT_TYPE_ID
ORDER BY A.OBJECT_TYPE_ID, A.ATTR_ID;
/*
CODE                    ATTR_ID CODE                 NAME                                                                                                                                                                                                     O_REF               
-------------------- ---------- -------------------- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- --------------------
CUSTOMER                      1 first_name           Імя                                                                                                                                                                                                                          
CUSTOMER                      2 last_name            Прізвище                                                                                                                                                                                                                     
CUSTOMER                      3 phone                Номер телефону                                                                                                                                                                                                               
EQUIPMENT                     4 EQUIPMENT_NAME       Назва техніки                                                                                                                                                                                                                
EQUIPMENT                     5 SERIAL_NUMBER        Серійний номер                                                                                                                                                                                                               
EQUIPMENT                     6 CONCLUSION           Висновок                                                                                                                                                                                                                     
EQUIPMENT                     7 owner                Власник                                                                                                                                                                                                                      
EQUIPMENT                     8 first_appeal         Дата звернення                                                                                                                                                                                                               

8 rows selected. 
*/