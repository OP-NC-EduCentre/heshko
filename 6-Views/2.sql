/*
2.1 Створити віртуальну таблицю, структура та вміст якої відповідає рішенню завдання
2.3 з лабораторної роботи No5, але враховує опцію «WITH READ ONLY»: отримати інформацію
про атрибутні типи. Отримати вміст таблиці.
*/
CREATE OR REPLACE VIEW objecttype_attr
            (object_code,
             attr_id,
             attr_code,
             attr_name)
AS
SELECT o.code,
       a.attr_id,
       a.code,
       a.name
FROM objtype o,
     attrtype a
WHERE o.object_type_id = a.object_type_id
ORDER BY a.object_type_id, a.attr_id
WITH READ ONLY;

SELECT object_code,
       attr_id,
       attr_code,
       attr_name
FROM objecttype_attr;
/*
OBJECT_CODE             ATTR_ID ATTR_CODE            ATTR_NAME                                                                                                                                                                                               
-------------------- ---------- -------------------- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CUSTOMER                      1 first_name           Імя                                                                                                                                                                                                     
CUSTOMER                      2 last_name            Прізвище                                                                                                                                                                                                
CUSTOMER                      3 phone                Номер телефону                                                                                                                                                                                          
EQUIPMENT                     4 EQUIPMENT_NAME       Назва техніки                                                                                                                                                                                           
EQUIPMENT                     5 SERIAL_NUMBER        Серійний номер                                                                                                                                                                                          
EQUIPMENT                     6 CONCLUSION           Висновок                                                                                                                                                                                                
EQUIPMENT                     7 CUSTOMER             Власник                                                                                                                                                                                                 
EQUIPMENT                     8 first_appeal         Дата звернення                                                                                                                                                                                          
*/
/*
2.2 Виконати видалення одного рядка з віртуальної таблиці, створеної у попередньому
завданні. Прокоментувати реакцію СУБД.
*/
DELETE FROM objecttype_attr WHERE objecttype_attr.attr_id = 9;
/*
-- ORA-42399: cannot perform a DML operation on a read-only view
*/
/*
2.3 Створити віртуальну таблицю, що містить дві колонки:
назва класу, кількість екземплярів об'єктів класу. Отримати вміст таблиці.
*/
CREATE OR REPLACE VIEW object_count
    (object_type, objects_count)
AS
SELECT objtype.name,
       COUNT(objects.object_id)
FROM objtype,
     objects
WHERE objects.object_type_id = objtype.object_type_id
GROUP BY objtype.name;

SELECT object_type, objects_count FROM object_count;
/*
OBJECT_TYPE                                                                                                                                                                                              OBJECTS_COUNT
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- -------------
Техніка                                                                                                                                                                                                              4
Клієнт    
*/
/*
2.4 Перевірити можливість виконання операції зміни даних у віртуальній таблиці,
створеної у попередньому завданні. Прокоментувати реакцію СУБД.
*/
UPDATE object_count
SET objects_count = 333
WHERE object_count.object_type = 'Техніка';
/*
-- ORA-01732: data manipulation operation not legal on this view
*/