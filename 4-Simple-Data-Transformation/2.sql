/*
2.1 Для однієї з таблиць створити команду отримання символьних значень колонки з
переведенням першого символу у верхній регістр, інших у нижній. При виведенні на екран визначити
для вказаної колонки нову назву псевдоніму.
*/
SELECT INITCAP(last_name) AS Прізвище
FROM customer
/*
ПРІЗВИЩЕ                      
------------------------------
Heshko
Jackson
Heshko
Второй
*/
/*
2.2. Модифікувати рішення попереднього завдання, створивши команду оновлення значення
вказаної колонки у таблиці.
*/
UPDATE customer
SET last_name = INITCAP(last_name)
/*
5 rows updated.
*/
/*
2.3 Для однієї з символьних колонок однієї з таблиць створити команду отримання
мінімальної, середньої та максимальної довжин рядків.
*/
SELECT MAX(LENGTH(equipment_name)) AS Max, MIN(LENGTH(equipment_name)) AS Min, AVG(LENGTH(equipment_name)) AS Avg
FROM equipment;
/*
       MAX        MIN        AVG
---------- ---------- ----------
        21          9      16.25
*/
/*
2.4 Для колонки типу date однієї з таблиць отримати кількість днів, тижнів та місяців, що
пройшли до сьогодні.
*/
SELECT 
    equipment_name,
    first_appeal,
    ROUND(SYSDATE-first_appeal) AS DAYS
FROM 
    equipment;

SELECT 
    equipment_name,
    first_appeal,
    ROUND((SYSDATE-first_appeal)/7) AS WEEKS
FROM 
    equipment;

SELECT 
    equipment_name,
    first_appeal,
    ROUND(MONTHS_BETWEEN (SYSDATE, first_appeal)) AS MONTHS
FROM 
    equipment;
/*
EQUIPMENT_NAME                                     FIRST_APP       DAYS
-------------------------------------------------- --------- ----------
Холодильник SAMSUNG                                                    
Холодильник Whirlpool                                                  
Microwave Noname                                   23-APR-22        174
Microwave                                          23-APR-22        174


EQUIPMENT_NAME                                     FIRST_APP      WEEKS
-------------------------------------------------- --------- ----------
Холодильник SAMSUNG                                                    
Холодильник Whirlpool                                                  
Microwave Noname                                   23-APR-22         25
Microwave                                          23-APR-22         25


EQUIPMENT_NAME                                     FIRST_APP     MONTHS
-------------------------------------------------- --------- ----------
Холодильник SAMSUNG                                                    
Холодильник Whirlpool                                                  
Microwave Noname                                   23-APR-22          6
Microwave                                          23-APR-22          6EQUIPMENT_NAME                                     FIRST_APP       DAYS
-------------------------------------------------- --------- ----------
Холодильник SAMSUNG                                                    
Холодильник Whirlpool                                                  
Microwave Noname                                   23-APR-22        174
Microwave                                          23-APR-22        174


EQUIPMENT_NAME                                     FIRST_APP      WEEKS
-------------------------------------------------- --------- ----------
Холодильник SAMSUNG                                                    
Холодильник Whirlpool                                                  
Microwave Noname                                   23-APR-22         25
Microwave                                          23-APR-22         25


EQUIPMENT_NAME                                     FIRST_APP     MONTHS
-------------------------------------------------- --------- ----------
Холодильник SAMSUNG                                                    
Холодильник Whirlpool                                                  
Microwave Noname                                   23-APR-22          6
Microwave                                          23-APR-22          6
*/