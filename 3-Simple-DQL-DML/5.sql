/*
5.1 Для однієї з таблиць, що містить обмеження цілісності зовнішнього ключа, виконати
команду зміни значення колонки зовнішнього ключа на значення, яке відсутнє в колонці
первинного ключа відповідної таблиці. Перевірити реакцію СКБД на таку зміну.
*/
UPDATE equipment
SET customer_id = 5
WHERE equipment_id = 1
/*
Error report -
ORA-02291: integrity constraint (HESHKO.EQUIPMENT_CUSTOMER_FK) violated - parent key not found
*/
/*
5.2 Повторити рішення завдання 5.1, але таке, що не призводить до порушення цілісності
зовнішнього ключа.
*/
UPDATE equipment
SET customer_id = 2
WHERE equipment_id = 1
/*
1 row updated.
*/
/*
5.3 Для однієї з таблиць, що містить обмеження цілісності первинного ключа, пов'язане з
колонкою зовнішнього ключа іншої таблиці, виконати одну команду видалення рядка зі значенням
колонки первинного ключа, що є в колонці зовнішнього ключа іншої таблиці. Перевірити реакцію
СКБД видалення.
*/
DELETE FROM customer WHERE customer_id = 1;
/*
Error report -
ORA-02292: integrity constraint (HESHKO.EQUIPMENT_CUSTOMER_FK) violated - child record found
*/
/*
5.4 Повторити рішення завдання 5.3, але таке, що не призводить до порушення цілісності
зовнішнього ключа.
*/
UPDATE equipment
SET customer_id = 1
WHERE customer_id = 2

DELETE FROM customer WHERE customer_id = 2;
/*
1 row deleted.
*/
/*
5.5 Для однієї з таблиць, що містить обмеження цілісності первинного ключа, виконати
команду зміни значення колонки первинного ключа на значення, яке відсутнє у колонці
зовнішнього ключа відповідної таблиці. Перевірити реакцію СКБД на таку зміну.
*/
UPDATE customer
SET customer_id = 5
WHERE customer_id = 1
/*
Error report -
ORA-02292: integrity constraint (HESHKO.EQUIPMENT_CUSTOMER_FK) violated - child record found
*/
/*
5.6 Повторити рішення завдання 5.5, але таке, що не призводить до порушення цілісності
зовнішнього ключа.
*/
UPDATE customer
SET customer_id = 6
WHERE customer_id = 4
/*
1 row updated.
*/