SELECT
    objects.object_id AS id,
    first_name.value AS first_name,
    last_name.value AS last_name,
    phone_number.value AS phone_number
FROM objects,
    objtype,
    attributes AS first_name,
    attributes AS last_name,
    attributes AS phone_number
WHERE objtype.code = 'CUSTOMER'
      AND objtype.object_type_id = objects.object_type_id
      AND objects.object_id = first_name.object_id
      AND first_name.attr_id = 1
      AND objects.object_id = last_name.object_id
      AND last_name.attr_id = 2
      AND objects.object_id = phone_number.object_id
      AND phone_number.attr_id = 3
      AND first_name.value = 'Mykola';