/*
4.1 Повторити рішення завдання 3.1
*/
SELECT 
    customer.first_name, 
    equipment.equipment_name
FROM 
    customer 
WHERE
    customer.customer_id = equipment.equipment_id
/*
FIRST_NAME           EQUIPMENT_NAME                                    
-------------------- --------------------------------------------------
Mykola               Холодильник SAMSUNG                               
Mykola               Холодильник Whirlpool                             
Andrew               Microwave Noname                                  
Артур                Microwave                                         
*/
/*
4.2 Повторити рішення завдання 3.2
*/
SELECT 
    customer.first_name, 
    customer.last_name, 
    equipment.equipment_name,
    equipment.conclusion
FROM 
    customer,
    equipment
WHERE
    customer.customer_id = equipment.equipment_id
/*
FIRST_NAME           LAST_NAME                      EQUIPMENT_NAME                                     CONCLUSION                                                                                                                                                                                                                                                     
-------------------- ------------------------------ -------------------------------------------------- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Mykola               Heshko                         Холодильник SAMSUNG                                Потрібна діагностика                                                                                                                                                                                                                                           
Andrew               Jackson                        Холодильник Whirlpool                              Потрібна діагностика                                                                                                                                                                                                                                           
Артур                Второй                         Microwave                                          Потрібна діагностика                                                                                                                                                                                                                                           
*/
/*
4.3 Повторити рішення завдання 3.4
*/
SELECT 
    c.first_name, 
    c.last_name, 
    e.equipment_name,
    e.conclusion
FROM 
    customer c,
    equipment e
WHERE 
    c.customer_id = e.equipment_id(+)
/*
FIRST_NAME           LAST_NAME                      EQUIPMENT_NAME                                     CONCLUSION                                                                                                                                                                                                                                                     
-------------------- ------------------------------ -------------------------------------------------- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Mykola               Heshko                         Холодильник SAMSUNG                                Потрібна діагностика                                                                                                                                                                                                                                           
Andrew               Jackson                        Холодильник Whirlpool                              Потрібна діагностика                                                                                                                                                                                                                                           
Артур                Второй                         Microwave                                          Потрібна діагностика                                                                                                                                                                                                                                           
Виталий              Второй                                                                                                                                                                                                                                                                                                                                           
Mykola               Heshko                                                                                                                                                                                                                                                                                                                                           
*/
