drop table customer CASCADE CONSTRAINTS;
drop table equipment CASCADE CONSTRAINTS;

CREATE TABLE customer(
    customer_id NUMBER(4),
    first_name VARCHAR(20),
    last_name VARCHAR(30),
    phone_number VARCHAR(20)
);

CREATE TABLE equipment(
    equipment_id NUMBER(4),
    equipment_name VARCHAR(20),
    serial_number VARCHAR(30),
    conclusion VARCHAR(255),
    customer_id NUMBER(4)
);