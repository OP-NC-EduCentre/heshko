/*
4.1. Виконайте введення 5 рядків у таблицю бази даних із динамічною генерацією
команди. Значення первинного ключа генеруються автоматично, решта даних дублюється.
*/
DECLARE
    v_id           customer.customer_id%TYPE;
    v_first_name   customer.first_name%TYPE;
    v_last_name    customer.last_name%TYPE;
    v_phone_number customer.phone_number%TYPE;
    v_inviter      customer.inviter%TYPE;
    v_email        customer.email%TYPE;
    insert_sql     VARCHAR2(255);
BEGIN
    insert_sql := 'INSERT INTO customer (customer_id, first_name, last_name, phone_number, inviter, email)'
        || ' VALUES(:1,:2,:3,:4,:5,:6)';
    FOR i IN 1..5
        LOOP
            v_id := customer_seq.nextval;
            v_first_name := 'Mykola';
            v_last_name := 'Heshko';
            v_phone_number := '+38(063)112-34-56';
            v_inviter := 2;
            v_email := 'kolya@gmail.com';
            EXECUTE IMMEDIATE insert_sql
                USING v_id, v_first_name, v_last_name,
                v_phone_number, v_inviter, v_email;
        END LOOP;
END;
/
/*
4.2. Скласти динамічний запит створення таблиці, іменами колонок якої будуть значення
будь-якої символьної колонки. Попередньо виконати перевірку існування таблиці з її
видаленням.
*/
DROP TABLE conclusion;

DECLARE
    create_sql VARCHAR2(500);
BEGIN
    create_sql := 'CREATE TABLE conclusion (';
    FOR f_conclusion IN (SELECT DISTINCT conclusion FROM equipment)
        LOOP
            create_sql := create_sql || f_conclusion.conclusion
                || ' BOOLEAN,';
        END LOOP;
    create_sql := RTRIM(create_sql, ',') || ')';
    dbms_output.put_line(create_sql);
    EXECUTE IMMEDIATE create_sql;
END;
/
/*
CREATE TABLE conclusion (Diagnosis_is_required BOOLEAN, Needs_repair BOOLEAN)
*/
/*
4.3. Команда ALTER SEQUENCE може змінювати початкове значення генератора
починаючи з СУБД версії 12. Для ранніх версій доводиться виконувати дві команди: видалення
генератора та створення генератора з новим початковим значенням.
З урахуванням вашої предметної області створити анонімний PL/SQL-блок, який
викликатиме один із варіантів SQL-запитів зміни початкового значення генератора залежно від
значення версії СУБД.
*/
DECLARE
    start_value    NUMBER(4) := 6;
    alter_sequence_sql VARCHAR2(255);
BEGIN
    dbms_output.put_line('Current version = ' || dbms_db_version.version);

    IF dbms_db_version.version >= 12 THEN
        alter_sequence_sql := 'ALTER SEQUENCE customer_seq RESTART START WITH ' || start_value;
        EXECUTE IMMEDIATE alter_sequence_sql;
    ELSE
        alter_sequence_sql := 'DROP SEQUENCE customer_seq';
        EXECUTE IMMEDIATE alter_sequence_sql;
        alter_sequence_sql := 'CREATE SEQUENCE customer_seq START WITH ' || start_value;
        EXECUTE IMMEDIATE alter_sequence_sql;
    END IF;
    
    dbms_output.put_line(alter_sequence_sql);
END;
/
/*
Current version = 18
ALTER SEQUENCE customer_seq RESTART START WITH 6
*/