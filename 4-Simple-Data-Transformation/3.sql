/*
3.1 Для будь-яких двох таблиць створити команду отримання декартового добутку.
*/
SELECT customer.first_name, equipment.equipment_name
FROM customer CROSS JOIN equipment;
/*
FIRST_NAME           EQUIPMENT_NAME                                    
-------------------- --------------------------------------------------
Mykola               Холодильник SAMSUNG                               
Mykola               Холодильник Whirlpool                             
Mykola               Microwave Noname                                  
Mykola               Microwave                                         
Andrew               Холодильник SAMSUNG                               
Andrew               Холодильник Whirlpool                             
Andrew               Microwave Noname                                  
Andrew               Microwave                                         
Mykola               Холодильник SAMSUNG                               
Mykola               Холодильник Whirlpool                             
Mykola               Microwave Noname                                  

FIRST_NAME           EQUIPMENT_NAME                                    
-------------------- --------------------------------------------------
Mykola               Microwave                                         
Артур                Холодильник SAMSUNG                               
Артур                Холодильник Whirlpool                             
Артур                Microwave Noname                                  
Артур                Microwave                                         
Виталий              Холодильник SAMSUNG                               
Виталий              Холодильник Whirlpool                             
Виталий              Microwave Noname                                  
Виталий              Microwave                                         

20 rows selected. 
*/
/*
3.2 Для двох таблиць, пов'язаних через PK-колонку та FK-колонку, створити команду
отримання двох колонок першої та другої таблиць з використанням екві-з’єднання таблиць.
Використовувати префікси.
*/
SELECT 
    customer.first_name, 
    customer.last_name, 
    equipment.equipment_name,
    equipment.conclusion
FROM customer 
INNER JOIN equipment ON (equipment.customer_id = customer.customer_id);
/*
FIRST_NAME           LAST_NAME                      EQUIPMENT_NAME                                     CONCLUSION                                                                                                                                                                                                                                                     
-------------------- ------------------------------ -------------------------------------------------- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Mykola               Heshko                         Холодильник SAMSUNG                                Потрібна діагностика                                                                                                                                                                                                                                           
Mykola               Heshko                         Холодильник Whirlpool                              Потрібна діагностика                                                                                                                                                                                                                                           
Andrew               Jackson                        Microwave Noname                                   Потрібна діагностика                                                                                                                                                                                                                                           
Артур                Второй                         Microwave                                          Потрібна діагностика                                                                                                                                                                                                                                           
*/
/*
3.3 Повторити рішення попереднього завдання, застосувавши автоматичне визначення умов
екві-з’єднання.
*/
SELECT 
    customer.first_name, 
    customer.last_name, 
    equipment.equipment_name,
    equipment.conclusion
FROM customer 
NATURAL JOIN equipment
/*
FIRST_NAME           LAST_NAME                      EQUIPMENT_NAME                                     CONCLUSION                                                                                                                                                                                                                                                     
-------------------- ------------------------------ -------------------------------------------------- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Mykola               Heshko                         Холодильник SAMSUNG                                Потрібна діагностика                                                                                                                                                                                                                                           
Mykola               Heshko                         Холодильник Whirlpool                              Потрібна діагностика                                                                                                                                                                                                                                           
Andrew               Jackson                        Microwave Noname                                   Потрібна діагностика                                                                                                                                                                                                                                           
Артур                Второй                         Microwave                                          Потрібна діагностика                                                                                                                                                                                                                                           
*/
/*
3.4 Повторити рішення завдання 3.2, замінивши еквіз'єднання на зовнішнє з'єднання
(лівостороннє або правостороннє), яке дозволить побачити рядки таблиці з PK-колонкою, не пов'язані
з FK-колонкою.
*/
SELECT 
    c.first_name, 
    c.last_name, 
    e.equipment_name,
    e.conclusion
FROM customer c
LEFT OUTER JOIN equipment e ON e.customer_id = c.customer_id;
/*
FIRST_NAME           LAST_NAME                      EQUIPMENT_NAME                                     CONCLUSION                                                                                                                                                                                                                                                     
-------------------- ------------------------------ -------------------------------------------------- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Mykola               Heshko                         Холодильник SAMSUNG                                Потрібна діагностика                                                                                                                                                                                                                                           
Mykola               Heshko                         Холодильник Whirlpool                              Потрібна діагностика                                                                                                                                                                                                                                           
Andrew               Jackson                        Microwave Noname                                   Потрібна діагностика                                                                                                                                                                                                                                           
Mykola               Heshko                                                                                                                                                                                                                                                                                                                                           
Артур                Второй                         Microwave                                          Потрібна діагностика                                                                                                                                                                                                                                           
Виталий              Второй                                                                                                                                                                                                                                                                                                                                           

6 rows selected. 
*/