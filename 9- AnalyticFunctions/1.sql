/*
1. Одна з колонок таблиці повинна містити значення, що повторюються, для
виділення підгруп, інша колонка повинна мати числові значення. Створіть запит, який
отримає усереднені значення другої колонки кожного рядка в кожній підгрупі.
Використати аналітичну функцію на основі AVG, PARTITION BY.
*/
--
ALTER TABLE equipment
ADD assessed_price Number(10,4);

SELECT equipment_name,
       conclusion,
       ROUND(AVG(assessed_price) OVER (PARTITION BY conclusion)) avg_assessed_price
FROM equipment;
/*
EQUIPMENT_NAME                                     CONCLUSION             AVG_ASSESSED_PRICE
-------------------------------------------------- --------------------   ------------------
Microwave Bosch Microwave                          Не підлягає ремонту    250
Холодильник Whirlpool                              Не підлягає ремонту    250
Fridge B1-V                                        Потрібен ремонт        600
Microwave Microwave                                Потрібна діагностика   525
Холодильник SAMSUNG                                Потрібна діагностика   525
*/
/*
2. Одна з колонок таблиці повинна містити значення, що повторюються, для
виділення підгруп, інша колонка повинна мати числові значення. Створіть запит, який
отримає накопичувальні підсумки другої колонки.
Використати аналітичну функцію на основі AVG, ORDER BY.
*/
SELECT equipment_name,
       conclusion,
       first_appeal,
       SUM(assessed_price) OVER (ORDER BY first_appeal) sum_assessed_price
FROM equipment;
/*
EQUIPMENT_NAME                                     CONCLUSION                                                                                                                                                                                                                                                      FIRST_AP AVG_ASSESSED_PRICE
-------------------------------------------------- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- -------- ------------------
Fridge B1-V                                        Потрібен ремонт                                                                                                                                                                                                                                                 14.04.22                600
Microwave Bosch Microwave                          Не підлягає ремонту                                                                                                                                                                                                                                             23.04.22               1400
Microwave Microwave                                Потрібна діагностика                                                                                                                                                                                                                                            23.04.22               1400
Холодильник SAMSUNG                                Потрібна діагностика                                                                                                                                                                                                                                            03.11.22               1900
Холодильник Whirlpool                              Не підлягає ремонту                                                                                                                                                                                                                                             15.11.22               2150
*/
/*
3. Виконайте попереднє завдання, отримавши накопичувальні підсумки в кожній
підгрупі окремо.
Використати аналітичну функцію на основі AVG, PARTITION BY, ORDER BY.
*/
SELECT equipment_name,
       conclusion,
       first_appeal,
       SUM(assessed_price) OVER (PARTITION BY first_appeal) sum_assessed_price
FROM equipment;
/*
EQUIPMENT_NAME                                     CONCLUSION                                                                                                                                                                                                                                                      FIRST_AP SUM_ASSESSED_PRICE
-------------------------------------------------- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- -------- ------------------
Fridge B1-V                                        Потрібен ремонт                                                                                                                                                                                                                                                 14.04.22                600
Microwave Bosch Microwave                          Не підлягає ремонту                                                                                                                                                                                                                                             23.04.22                800
Microwave Microwave                                Потрібна діагностика                                                                                                                                                                                                                                            23.04.22                800
Холодильник SAMSUNG                                Потрібна діагностика                                                                                                                                                                                                                                            03.11.22                500
Холодильник Whirlpool                              Не підлягає ремонту                                                                                                                                                                                                                                             15.11.22                250
*/