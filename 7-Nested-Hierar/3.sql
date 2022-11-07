/*
1. Виберіть таблицю вашої БД, до якої потрібно додати нову колонку, яка стане FK-
колонкою для PK-колонки цієї таблиці та буде використана для зберігання ієрархії.
Використовується команда ALTER TABLE таблиця ADD колонка тип_даних;
Заповніть дані для створеної колонки, виконавши серію команд UPDATE.
*/
ALTER TABLE customer
    ADD inviter NUMBER(9);

ALTER TABLE customer
    ADD CONSTRAINT customer_inviter_fk
        FOREIGN KEY (inviter) REFERENCES customer (customer_id);

UPDATE customer
SET inviter = 1
WHERE customer_id = 2;

UPDATE customer
SET inviter = 2
WHERE customer_id = 23;

SELECT * FROM customer;
/*
CUSTOMER_ID FIRST_NAME           LAST_NAME                      PHONE_NUMBER            INVITER
----------- -------------------- ------------------------------ -------------------- ----------
          1 Mykola               Heshko                         0664241334                     
          2 Andrew               Jackson                        0636619513                    1
          3 Mykola               Heshko                         +380636669696                  
         23 Артур                Второй                         +380636669677                 2
         43 Виталий              Второй                         +380631679611                  
         63 Mykola               Heshko                         +380123456789                  
*/
/*
2. Використовуючи створену колонку, отримайте дані з таблиці через ієрархічний зв'язок
типу «зверху-вниз».
*/
SELECT customer_id, first_name, inviter
FROM customer
START WITH inviter IS NULL
CONNECT BY PRIOR customer_id = inviter;
/*
CUSTOMER_ID FIRST_NAME              INVITER
----------- -------------------- ----------
          1 Mykola                         
          3 Mykola                         
          43 Виталий                        
          63 Mykola    
          2 Andrew                        1
         23 Артур                         2  
*/
/*
3. Згенеруйте унікальну послідовність чисел, використовуючи рекурсивний запит, в
діапазоні від 1 до 100. На основі отриманого результату створіть запит, що виводить на екран
список ще не внесених значень однієї з PK-колонок однієї з таблиць БД за прикладом на рисунку 11.
*/
SELECT n
FROM (WITH num(n) AS
               (SELECT 1 AS n
                FROM dual
                UNION ALL
                SELECT n + 1
                FROM num
                WHERE n < 100)
      SELECT n
      FROM num)
WHERE NOT EXISTS(SELECT equipment_id
                 FROM equipment
                 WHERE equipment_id = n);
/*
         N
----------
         3
         4
         5
         6
         8
         9
        10
        11
        12
        13
        14
        15
        16
        17
        18
        19
        20
        21
        22
        24
        25
        26
        27
        28
        29
        30
        31
        32
        33
        34
        35
        36
        37
        38
        39
        40
        41
        42
        44
        45
        46
        47
        48
        49
        50
        51
        52
        53
        54
        55
        56
        57
        58
        59
        60
        61
        62
        63
        64
        65
        66
        67
        68
        69
        70
        71
        72
        73
        74
        75
        76
        77
        78
        79
        80
        81
        82
        83
        84
        85
        86
        87
        88
        89
        90
        91
        92
        93
        94
        95
        96
        97
        98
        99
       100
*/