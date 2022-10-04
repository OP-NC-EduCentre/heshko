ALTER TABLE equipment ADD CONSTRAINT equipment_serial_number_unique
    UNIQUE (serial_number);
ALTER TABLE equipment MODIFY (serial_number NOT NULL);

ALTER TABLE customer ADD CONSTRAINT customer_pk
    PRIMARY KEY (customer_id);

ALTER TABLE equipment ADD CONSTRAINT equipment_pk
    PRIMARY KEY (equipment_id);
	
ALTER TABLE equipment ADD CONSTRAINT equipment_customer_fk
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id);

ALTER TABLE customer ADD CONSTRAINT chk_phone CHECK (phone_number like '%[^0-9]%');


