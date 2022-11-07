/*
1. Виконання простих однорядкових підзапитів із екві-з'єднанням або тета-
з'єднанням.
*/
SELECT equipment_name
FROM equipment
WHERE first_appeal >
                (
                    SELECT first_appeal
                    FROM equipment WHERE equipment_id = 7
                );
/*
EQUIPMENT_NAME                                    
--------------------------------------------------
Холодильник SAMSUNG
Холодильник Whirlpool
*/
/*
2. Використання агрегатних функцій у підзапитах.
*/
SELECT equipment_name
FROM equipment
WHERE first_appeal = 
                    (SELECT MIN(first_appeal) FROM equipment);
/*
EQUIPMENT_NAME                                    
--------------------------------------------------
Fridge B1-V
*/
/*
3. Пропозиція HAVING із підзапитами.
*/
SELECT customer_id, to_date(round(avg(to_number(to_char(first_appeal, 'J')))),'J') AVG_DATE
FROM equipment
GROUP BY customer_id
HAVING to_date(round(avg(to_number(to_char(first_appeal, 'J')))),'J') > (SELECT to_date(round(avg(to_number(to_char(first_appeal, 'J')))),'J') FROM equipment)
/*
CUSTOMER_ID AVG_DATE 
----------- ---------
          1 31-AUG-22
*/
/*
4. Виконання багаторядкових підзапитів
*/
SELECT equipment_name
FROM equipment
WHERE first_appeal < ANY
(SELECT first_appeal FROM equipment WHERE conclusion = 'Потрібна діагностика')
AND
conclusion <> 'Потрібна діагностика';
/*
EQUIPMENT_NAME                                    
--------------------------------------------------
Fridge B1-V
Microwave Bosch
*/
/*
5. Використання оператора WITH для структуризації запиту
*/
-- Підрахувати скільки товар у клієнтів перебуває у базі
with equip_count as (
  select customer_id, count(*) as equip_count
  from   equipment
  group by customer_id)
select c.first_name as first_name,
       ec.equip_count as customer_equipment_count
from   customer c,
       equip_count ec
where  c.customer_id = ec.customer_id;
/*
6. Використання кореляційних підзапитів
*/
-- Отримати номери телефону клієнтів, чия техніка на складі 
SELECT c.phone_number
FROM customer c
    WHERE EXISTS (
        SELECT e.customer_id
        FROM equipment e
        WHERE e.customer_id = c.customer_id);
/*
PHONE_NUMBER        
--------------------
0664241334
0636619513
+380636669677
*/