-- 1.1 Для кожної таблиці БД створити команди внесення даних, тобто внести по два рядки.
INSERT ALL 
    INTO customer (customer_id, first_name, last_name, phone_number) VALUES (1, 'Mykola', 'Heshko', '0664241334')
    INTO customer (customer_id, first_name, last_name, phone_number) VALUES (2, 'Andrew', 'Jackson', '0636619513')
SELECT 1 FROM DUAL;

INSERT ALL 
    INTO equipment (equipment_id, equipment_name, serial_number, conclusion, customer_id) VALUES (1, 'Холодильник SAMSUNG', 'RB33J3000SA/UA', 'Потрібна діагностика', 1)
    INTO equipment (equipment_id, equipment_name, serial_number, conclusion, customer_id) VALUES (2, 'Холодильник Whirlpool', 'F00185264', 'Потрібна діагностика', 1)
SELECT 1 FROM DUAL;

-- 1.2 Для однієї з таблиць створити команду додавання колонки типу date з урахуванням
предметної області.
ALTER TABLE equipment ADD first_appeal DATE;

/* 1.3 Для зазначеної таблиці створити команду на внесення одного рядка, але з невизначеним
значенням колонки типу date.*/
INSERT INTO equipment (equipment_id, equipment_name, serial_number, conclusion, customer_id, first_appeal) 
VALUES (3, 'Microwave Bosch', 'B00344744', 'Потрібна діагностика', 1, null)

-- 1.4 Створити команду налаштування формату date = dd/mm/yyyy
ALTER SESSION SET NLS_DATE_FORMAT = 'dd/mm/yyyy';

/* 1.5 Для задіяної в завданні 1.2 таблиці створити ще одну команду на внесення одного рядка
з урахуванням значення колонки типу date.*/
INSERT INTO equipment (equipment_id, equipment_name, serial_number, conclusion, customer_id, first_appeal) 
VALUES (4, 'Microwave Noname', 'WB5353354744', 'Потрібна діагностика', 2, '30/01/2022')

/* 1.6 Для однієї з таблиць, що містить обмеження цілісності потенційного ключа, виконати
команду додавання нового рядка зі значенням колонки, що порушує це обмеження. Перевірити
реакцію СКБД на таку зміну.*/
INSERT INTO equipment (equipment_id, equipment_name, serial_number, conclusion, customer_id, first_appeal) 
VALUES (1, 'Microwave Noname', 'WL414744W', 'Потрібна діагностика', 1, '30/01/2022')
/*Error starting at line : 1 in command -
INSERT INTO equipment (equipment_id, equipment_name, serial_number, conclusion, customer_id, first_appeal) 
VALUES (1, 'Microwave Noname', 'WL414744W', 'Потрібна діагностика', 1, '30/01/2022')
Error report -
ORA-00001: unique constraint (HESHKO.EQUIPMENT_PK) violated*/

/* 1.7 Для однієї з таблиць, що містить обмеження цілісності зовнішнього ключа, виконати
команду додавання нового рядка зі значенням колонки зовнішнього ключа, який відсутній у
колонці первинного ключа відповідної таблиці. Перевірити реакцію СКБД на подібне додавання,
яке порушує обмеження цілісності зовнішнього ключа.*/
INSERT INTO equipment (equipment_id, equipment_name, serial_number, conclusion, customer_id, first_appeal) 
VALUES (5, 'Microwave Noname', 'WL5533514744W', 'Потрібна діагностика', 3, '30/01/2022')

/*Error starting at line : 1 in command -
INSERT INTO equipment (equipment_id, equipment_name, serial_number, conclusion, customer_id, first_appeal) 
VALUES (5, 'Microwave Noname', 'WL5533514744W', 'Потрібна діагностика', 3, '30/01/2022')
Error report -
ORA-02291: integrity constraint (HESHKO.EQUIPMENT_CUSTOMER_FK) violated - parent key not found*/
