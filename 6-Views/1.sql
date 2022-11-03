/*
1.1 Створити віртуальну таблицю, структура та вміст якої відповідає рішенню завдання
4.2 з лабораторної роботи No3: для однієї з таблиць створити команду отримання значень усіх
колонок (явно перерахувати) за окремими рядками з урахуванням умови, в якій рядкове
значення однієї з колонок має співпадати з якимось константним значенням. Отримати вміст
таблиці.
*/
CREATE OR REPLACE VIEW EQUIPMENT_VIEW
            (equipment_id,
             equipment_name,
             serial_number,
             conclusion,
             customer_id,
             first_appeal)
AS
SELECT equipment_id,
    equipment_name,
    serial_number,
    conclusion, 
    customer_id,
    first_appeal
FROM equipment WHERE equipment_name = 'Microwave Bosch';
/*
EQUIPMENT_ID EQUIPMENT_NAME                                     SERIAL_NUMBER                  CONCLUSION                                                                                                                                                                                                                                                      CUSTOMER_ID FIRST_APP
------------ -------------------------------------------------- ------------------------------ --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ----------- ---------
           7 Microwave Bosch                                    WB-53544                       Потрібна діагностика    
*/
/*
1.2 Виконати команду зміни значення колонки створеної віртуальної таблиці на
значення, яка входить в умову вибірки рядків із рішення попереднього завдання, при цьому нове
значення має відрізнятись від поточного.
*/
UPDATE EQUIPMENT_VIEW
SET conclusion = 'Не підлягає ремонту'
WHERE equipment_name = 'Microwave Bosch';

SELECT equipment_id,
    equipment_name,
    serial_number,
    conclusion, 
    customer_id,
    first_appeal
FROM EQUIPMENT_VIEW;
/*
EQUIPMENT_ID EQUIPMENT_NAME                                     SERIAL_NUMBER                  CONCLUSION                                                                                                                                                                                                                                                      CUSTOMER_ID FIRST_APP
------------ -------------------------------------------------- ------------------------------ --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ----------- ---------
           7 Microwave Bosch                                    WB-53544                       Не підлягає ремонту                                                                                                                                                                                                                                                       2 23-APR-22

*/
/*
1.3 Створити віртуальну таблицю, структура та вміст якої відповідає рішенню завдання
3.2 з лабораторної роботи No4: для двох таблиць, пов'язаних через PK-колонку та FK-колонку,
створити команду отримання двох колонок першої та другої таблиць з використанням екві-
сполучення таблиць. Отримати вміст таблиці.
*/
CREATE OR REPLACE VIEW customer_equipment_view
            (phone_number,
             equipment_name)
AS
SELECT c.phone_number,
       e.equipment_name
FROM customer c
         INNER JOIN equipment e ON c.customer_id = e.customer_id;

SELECT phone_number, equipment_name
FROM customer_equipment_view;
/*
View CUSTOMER_EQUIPMENT_VIEW created.

PHONE_NUMBER         EQUIPMENT_NAME                                    
-------------------- --------------------------------------------------
0664241334           Холодильник SAMSUNG                               
0664241334           Холодильник Whirlpool                             
0636619513           Microwave Bosch                                   
+380636669677        Microwave            
*/
/*
1.4 Виконати команду додавання нового рядка до однієї з таблиць, що входить до запиту
з попереднього завдання.
*/
INSERT INTO equipment 
	(equipment_id,
    equipment_name,
    serial_number,
    conclusion, 
    customer_id,
    first_appeal) 
VALUES (equipment_seq.nextval , 
	'Fridge B1-V', 
	'B1-VV111DA52', 
	'Потрібен ремонт', 
	1,
    '14/03/2022'
    );

SELECT * FROM customer_equipment_view;
/*
1 row inserted.


PHONE_NUMBER         EQUIPMENT_NAME                                    
-------------------- --------------------------------------------------
0664241334           Холодильник SAMSUNG                               
0664241334           Холодильник Whirlpool                             
0664241334           Fridge B1-V                                       
0636619513           Microwave Bosch                                   
+380636669677        Microwave                                         

*/
