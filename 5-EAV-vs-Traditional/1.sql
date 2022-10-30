/*
1.1. Створити таблицю опису об'єктних типів.
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
/*
Table OBJTYPE created.

Table OBJTYPE altered.

Table OBJTYPE altered.

Table OBJTYPE altered.

Table OBJTYPE altered.
*/
/*
1.2 Нехай у лабораторній роботі No1 було створено UML-діаграму концептуальних класів. Для
трьох класів з UML-діаграми, пов'язаних між собою, бажано зв'язком «узагальнення», «агрегатна
асоціація» та «іменована асоціація», заповнити опис об'єктних типів.
*/
INSERT INTO objtype (object_type_id, parent_id, code, name, description)
    VALUES (1, NULL, 'CUSTOMER', 'Клієнт', 'Інформація про клієнта');

INSERT INTO objtype (object_type_id, parent_id, code, name, description)
    VALUES (2, 1, 'EQUIPMENT', 'Техніка', 'Інформація про техніку на ремонті');
/*
1 row inserted.

1 row inserted.

1 row inserted.
*/
/*
1.3 Отримати інформацію про об'єктні типи.
*/
SELECT OBJECT_TYPE_ID, PARENT_ID, CODE, NAME
	FROM OBJTYPE;
/*
OBJECT_TYPE_ID  PARENT_ID CODE                 NAME                                                                                                                                                                                                    
-------------- ---------- -------------------- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
             1            CUSTOMER             Клієнт                                                                                                                                                                                                  
             2          1 EQUIPMENT            Техніка       
*/
/*
1.4 Отримати інформацію про об'єктні типи та можливі зв'язки між ними типу «узагальнення»,
«агрегатна асоціація».
*/
SELECT 
    P.OBJECT_TYPE_ID,
    P.CODE,
	C.OBJECT_TYPE_ID AS OBJ_T_ID_LINK, 
    C.CODE AS CODE_LINK
FROM OBJTYPE C, OBJTYPE P
WHERE P.OBJECT_TYPE_ID = C.PARENT_ID(+);
/*
OBJECT_TYPE_ID CODE                 OBJ_T_ID_LINK CODE_LINK           
-------------- -------------------- ------------- --------------------
             1 CUSTOMER                         2 EQUIPMENT           
             2 EQUIPMENT                                                                                            
*/