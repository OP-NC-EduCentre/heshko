/*
1. Класифікуйте значення однієї з колонок на 3 категорії залежно від загальної суми
значень у будь-якій числовій колонці. Використати аналітичну функцію NTILE.
*/
SELECT 
	NTILE(3) OVER (ORDER BY inviter) AS inviterntile, 
	first_name,
    last_name,
	inviter 
FROM customer;
/*
INVITERNTILE FIRST_NAME           LAST_NAME                         INVITER
------------ -------------------- ------------------------------ ----------
           1 Mykola               Heshko                                  1
           1 Andrew               Jackson                                 1
           2 Mykola               Heshko                                  2
           2 Артур                Второй                                  2
           3 Кирилл               Второй                                  3
           3 Mykola               Heshko        
*/
/*
2. Складіть запит, який поверне списки лідерів у підгрупах, отриманих у першому
завданні етапу 1.
*/
WITH a1 AS (SELECT equipment_name,
                   assessed_price,
                   NTILE(3) OVER (ORDER BY assessed_price) cat
            FROM equipment),
     a2 AS (SELECT equipment_name,
                   assessed_price,
                   cat,
                   RANK() OVER (PARTITION BY cat ORDER BY assessed_price) pos
            FROM a1)
SELECT equipment_name,
       assessed_price,
       cat,
       pos
FROM a2
WHERE pos = 1;
/*
EQUIPMENT_NAME                                     ASSESSED_PRICE        CAT        POS
-------------------------------------------------- -------------- ---------- ----------
Microwave Bosch Microwave                                     250          1          1
Холодильник Whirlpool                                         250          1          1
Холодильник SAMSUNG                                           500          2          1
Fridge B1-V                                                   600          3          1
*/
/*
3. Модифікуйте рішення попереднього завдання, повернувши по 2 лідери у кожній
підгрупі.
*/
WITH a1 AS (SELECT equipment_name,
                   assessed_price,
                   NTILE(3) OVER (ORDER BY assessed_price) cat
            FROM equipment),
     a2 AS (SELECT equipment_name,
                   assessed_price,
                   cat,
                   ROW_NUMBER() OVER (PARTITION BY cat ORDER BY cat) pos
            FROM a1)
SELECT equipment_name,
       assessed_price,
       cat,
       pos
FROM a2
WHERE pos <= 2;
/*
EQUIPMENT_NAME                                     ASSESSED_PRICE        CAT        POS
-------------------------------------------------- -------------- ---------- ----------
Microwave Bosch Microwave                                     250          1          1
Холодильник Whirlpool                                         250          1          2
Холодильник SAMSUNG                                           500          2          1
Microwave Microwave                                           550          2          2
Fridge B1-V                                                   600          3          1
*/
/*
4. Складіть запит, який повертає рейтинг будь-якого з перерахованих значень
відповідно до вашої предметноїобласті: товарів/послуг/співробітників/клієнтів тощо.
*/
SELECT equipment_name,
       ASSESSED_PRICE,
       RANK() OVER (ORDER BY ASSESSED_PRICE DESC) rating
FROM equipment;
/*
EQUIPMENT_NAME                                     ASSESSED_PRICE     RATING
-------------------------------------------------- -------------- ----------
Fridge B1-V                                                   600          1
Microwave Microwave                                           550          2
Холодильник SAMSUNG                                           500          3
Холодильник Whirlpool                                         250          4
Microwave Bosch Microwave                                     250          4
*/
/*
5. Одна з колонок таблиці повинна містити значення, що повторюються, для
виділення підгруп, інша колонка повинна мати числові значення. Створіть запит, який
отримає перше значення у кожній підгрупі. Використати аналітичну функцію
FIRST_VALUE.
*/
WITH a1 AS (SELECT equipment_name,
                   conclusion,
                   ASSESSED_PRICE,
                   FIRST_VALUE(ASSESSED_PRICE) OVER
                       (PARTITION BY conclusion
                       ORDER BY ASSESSED_PRICE DESC) top
            FROM equipment)
SELECT equipment_name,
        conclusion,
        ASSESSED_PRICE
FROM a1
WHERE ASSESSED_PRICE = top;
/*
EQUIPMENT_NAME                                     CONCLUSION                                                                                                                                                                                                                                                      ASSESSED_PRICE
-------------------------------------------------- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- --------------
Microwave Bosch Microwave                          Не підлягає ремонту                                                                                                                                                                                                                                                        250
Холодильник Whirlpool                              Не підлягає ремонту                                                                                                                                                                                                                                                        250
Fridge B1-V                                        Потрібен ремонт                                                                                                                                                                                                                                                            600
Microwave Microwave                                Потрібна діагностика                                                                                                                                                                                                                                                       550
*/
