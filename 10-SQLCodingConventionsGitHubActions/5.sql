/*
Code	Line / Position	Description
L036	1 / 1	
Select targets should be on a new line unless there is only one select target.
L012	1 / 28	
Implicit/explicit aliasing of columns.
L014	2 / 8	
Unquoted identifiers must be consistently lower case.
L012	2 / 25	
Implicit/explicit aliasing of columns.
L014	3 / 8	
Unquoted identifiers must be consistently lower case.
L012	3 / 24	
Implicit/explicit aliasing of columns.
L014	4 / 8	
Unquoted identifiers must be consistently lower case.
L012	4 / 27	
Implicit/explicit aliasing of columns.
L014	4 / 27	
Unquoted identifiers must be consistently lower case.
L011	5 / 14	
Implicit/explicit aliasing of table.
L031	5 / 14	
Avoid aliases in from clauses and join conditions.
L003	6 / 6	
Expected 2 indentations, found less than 2 [compared to line 05]
L011	6 / 14	
Implicit/explicit aliasing of table.
L031	6 / 14	
Avoid aliases in from clauses and join conditions.
L003	7 / 6	
Expected 2 indentations, found less than 2 [compared to line 05]
L011	7 / 17	
Implicit/explicit aliasing of table.
L014	7 / 17	
Unquoted identifiers must be consistently lower case.
L003	8 / 6	
Expected 2 indentations, found less than 2 [compared to line 05]
L011	8 / 17	
Implicit/explicit aliasing of table.
L014	8 / 17	
Unquoted identifiers must be consistently lower case.
L003	9 / 6	
Expected 2 indentations, found less than 2 [compared to line 05]
L011	9 / 17	
Implicit/explicit aliasing of table.
L014	9 / 17	
Unquoted identifiers must be consistently lower case.
L003	11 / 3	
Expected 1 indentation, found less than 1 [compared to line 10]
L003	12 / 3	
Expected 1 indentation, found less than 1 [compared to line 10]
L026	12 / 29	
Reference 'first_name.object_id' refers to table/view not found in the FROM clause or found in ancestor statement.
L003	13 / 3	
Expected 1 indentation, found less than 1 [compared to line 10]
L026	13 / 7	
Reference 'first_name.attr_id' refers to table/view not found in the FROM clause or found in ancestor statement.
L003	14 / 3	
Expected 1 indentation, found less than 1 [compared to line 10]
L026	14 / 29	
Reference 'last_name.object_id' refers to table/view not found in the FROM clause or found in ancestor statement.
L003	15 / 3	
Expected 1 indentation, found less than 1 [compared to line 10]
L026	15 / 7	
Reference 'last_name.attr_id' refers to table/view not found in the FROM clause or found in ancestor statement.
L003	16 / 3	
Expected 1 indentation, found less than 1 [compared to line 10]
L014	16 / 29	
Unquoted identifiers must be consistently lower case.
L003	17 / 3	
Expected 1 indentation, found less than 1 [compared to line 10]
L014	17 / 7	
Unquoted identifiers must be consistently lower case.
L003	18 / 3	
Expected 1 indentation, found less than 1 [compared to line 10]
L014	18 / 7	
Unquoted identifiers must be consistently lower case.
*/
SELECT customers.object_id id,
       FIRST_NAME.value first_name,
       LAST_NAME.value last_name,
       PHONE_NUMBER.value PHONE_NUMBER
FROM objects customers,
     objtype customers_type,
     attributes FIRST_NAME,
     attributes LAST_NAME,
     attributes PHONE_NUMBER
WHERE customers_type.code = 'CUSTOMER'
  AND customers_type.object_type_id = customers.object_type_id
  AND customers.object_id = first_name.object_id
  AND first_name.attr_id = 1
  AND customers.object_id = last_name.object_id
  AND last_name.attr_id = 2
  AND customers.object_id = PHONE_NUMBER.object_id
  AND PHONE_NUMBER.attr_id = 3
  AND FIRST_NAME.value = 'Mykola';