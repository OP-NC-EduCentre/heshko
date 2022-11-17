/*
1. Одна з колонок таблиць повинна містити строкове значення з трьома різними буквами у
першій позиції. Створіть запит, який отримає три рядки таблиці з урахуванням трьох букв,
використовуючи оператор LIKE.
*/
SELECT equipment_name, serial_number FROM equipment 
WHERE 
    serial_number LIKE 'WMC%'
	OR serial_number LIKE 'DMC%'
	OR serial_number LIKE 'RGB%';
/*
EQUIPMENT_NAME                                     SERIAL_NUMBER                 
-------------------------------------------------- ------------------------------
Холодильник Whirlpool                              WMC43147                      
Microwave Bosch                                    DMC53544                      
Microwave                                          RGB5521                  
*/
/*
2. Повторіть завдання 1, використовуючи регулярні вирази з альтернативними варіантами.
*/
SELECT equipment_name, serial_number FROM equipment 
WHERE 
     regexp_like(serial_number, '^WMC|^DMC|^RGB');
/*
EQUIPMENT_NAME                                     SERIAL_NUMBER                 
-------------------------------------------------- ------------------------------
Холодильник Whirlpool                              WMC43147                      
Microwave Bosch                                    DMC53544                      
Microwave                                          RGB5521                     
*/
/*
3. Одна з колонок таблиць повинна містити строкове значення з цифрами від 3 до 8 у
будь-якій позиції. Створіть запит, який отримає рядки таблиці з урахуванням присутності у
вказаній колонці будь-якої цифри від 3 до 8.
*/
SELECT equipment_name,
	equipment_id
	FROM equipment
	WHERE regexp_like(equipment_id, '.*[3-8].*');
/*
EQUIPMENT_NAME                                     EQUIPMENT_ID
-------------------------------------------------- ------------
Microwave Bosch                                               7
Microwave                                                    23
Fridge B1-V                                                  43
*/
/*
4. Створіть запит, який отримає рядки таблиці з урахуванням відсутності в зазначеній
колонці будь-якої цифри від 3 до 8.
*/
SELECT equipment_name,
	equipment_id
	FROM equipment
	WHERE regexp_like(equipment_id, '[^3-8]');
/*
EQUIPMENT_NAME                                     EQUIPMENT_ID
-------------------------------------------------- ------------
Холодильник SAMSUNG                                           1
Холодильник Whirlpool                                         2
Microwave                                                    23
*/
/*
5. Створіть запит, який отримає рядки таблиці з урахуванням присутності в раніше вказаній
колонці поєднання будь-яких трьох цифр розміщених підряд від 3 до 8.
*/
SELECT first_name, 
	last_name, 
	phone_number AS phone
	FROM customer
	WHERE regexp_like(phone_number, '(063|456|567|678)');
/*
FIRST_NAME           LAST_NAME                      PHONE               
-------------------- ------------------------------ --------------------
Andrew               Jackson                        +380636619513       
Mykola               Heshko                         +380636669696       
Артур                Второй                         +380636669677       
Виталий              Второй                         +380631679611       
Mykola               Heshko                         +380123456789      
*/
