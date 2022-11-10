/*
1. Створіть запит, який отримає рядки таблиці з урахуванням присутності в раніше
вказаній колонці поєднання будь-яких двох підряд розташованих цифр, або трьох підряд
розташованих букв.
*/
SELECT equipment_name, serial_number FROM equipment 
WHERE 
     regexp_like(serial_number, '\d{2}|[a-zA-Z]{3}$');
/*
EQUIPMENT_NAME                                     SERIAL_NUMBER                 
-------------------------------------------------- ------------------------------
Холодильник SAMSUNG                                RB33J3000SA/UA                
Холодильник Whirlpool                              WMC43147                      
Microwave Bosch                                    WMC53544                      
Microwave                                          WMC5521                       
Fridge B1-V                                        B1-VV111DA52  
*/
/*
2. Одна з колонок таблиць повинна містити строкове значення з двома однаковими
буквами, що повторюються підряд. Створіть запит, який отримає рядки таблиці з таким значенням
колонки.
*/
SELECT first_name, last_name
FROM customer
WHERE REGEXP_LIKE(first_name, '([[:alpha:]])\1');
/*
FIRST_NAME           LAST_NAME                     
-------------------- ------------------------------
Кирилл               Второй                        
*/
/*
3. Одна з колонок таблиць повинна містити строкове значення з двома однаковими
словами, що повторюються підряд. Створіть запит, який отримає рядки таблиці з таким значенням
колонки.
*/
SELECT EQUIPMENT_NAME
FROM equipment 
WHERE regexp_like(equipment_name,  '(\w+)\s+\1');
/*
EQUIPMENT_NAME                                    
--------------------------------------------------
Microwave Microwave
*/
/*
4. Одна з колонок таблиць повинна містити строкове значення з номером мобільного
телефону у форматі +XX(XXX)XXX-XX-XX, де X – цифра. Створіть запит, який отримає рядки
таблиці з таким значенням колонки.
*/
SELECT last_name, phone_number FROM customer
WHERE regexp_like(phone_number, '^([+]?[\s0-9]+)?(\d{3}|[(]?[0-9]+[)])?([-]?[\s]?[0-9])+$');
/*
LAST_NAME                      PHONE_NUMBER        
------------------------------ --------------------
Heshko                         +38(066)424-13-34   
Jackson                        +38(063)661-95-13   
Heshko                         +38(063)666-96-96   
Второй                         +38(063)666-96-77   
Второй                         +38(063)167-96-11   
Heshko                         +38(012)345-67-89   
*/
/*
5. Одна з колонок таблиць має містити строкове значення з електронною поштовою
адресою у форматі EEE@EEE.EEE.UA, де E – будь-яка латинська буква. Створіть запит, який
отримає рядки таблиці з таким значенням колонки.
*/
ALTER TABLE customer 
ADD email VARCHAR2(80);

UPDATE customer
SET email = 'kolya.geshko@sub.gmail.ua'
WHERE customer_id = 1;

UPDATE customer
SET email = 'kolya.geshko@gmail.com'
WHERE customer_id = 2;

SELECT * FROM customer WHERE regexp_like(email,  '^[a-zA-Z0-9._%-]+@[a-zA-Z0-9._%-]+\.[a-zA-Z]{2,4}$');
/*
CUSTOMER_ID FIRST_NAME           LAST_NAME                      PHONE_NUMBER            INVITER EMAIL                                                                           
----------- -------------------- ------------------------------ -------------------- ---------- --------------------------------------------------------------------------------
          1 Mykola               Heshko                         +38(066)424-13-34               kolya.geshko@sub.gmail.ua                                                       
          2 Andrew               Jackson                        +38(063)661-95-13             1 kolya.geshko@gmail.com                                                              
*/