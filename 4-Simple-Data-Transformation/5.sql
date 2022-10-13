/*
5.1 Для однієї з таблиць створити команду отримання кількості рядків таблиці, згрупованих по
одній з колонок, яка також повинна бути отримана, об'єднавши її з командою отримання загальної
кількості рядків із зазначенням слова «Разом:», наприклад:
Колонка Кількість
значення1 10
значення2 15
Разом: 25
При виконанні завдання необхідно врахувати, що підсумковий рядок завжди повинен бути
останнім, незалежно від значень колонки у попередніх рядках.
*/
SELECT
    equipment_name AS "Equipment",
    COUNT(serial_number) AS "QTY"
FROM equipment
GROUP BY equipment_name
UNION ALL
SELECT
    'Total count of equipment:',
    count(equipment_id)
FROM equipment
/*
Equipment                                                 QTY
-------------------------------------------------- ----------
Microwave                                                   1
Холодильник SAMSUNG                                         1
Холодильник Whirlpool                                       1
Microwave Noname                                            1
Total count of equipment:                                   4
*/