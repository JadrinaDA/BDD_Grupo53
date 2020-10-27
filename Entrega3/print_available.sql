CREATE OR REPLACE FUNCTION print_available(puerto VARCHAR, tipo_chosen VARCHAR, fecha_start DATE, fecha_end DATE)
RETURNS TABLE(iid INT, tipo VARCHAR(100), capacidad INT) 
AS $$
DECLARE
tupla RECORD;
pos_com INT;
string CHAR(100);
BEGIN
CREATE TABLE tabla_aux(iid INT, tiene_capacidad bool);
FOR tupla IN SELECT * FROM calcular_capacidad(puerto, fecha_start, fecha_end) WHERE tiene_capacidad = 'true'
LOOP
INSERT INTO tabla_aux VALUES(tupla.iid, tupla.tiene_capacidad);
END LOOP;
CREATE TABLE tabla_aux_2(iid INT, tipo VARCHAR(100), capacidad INT);
FOR tupla IN SELECT * FROM instalaciones
LOOP
IF tupla.tipo = tipo_chosen
THEN
INSERT INTO tabla_aux_2 VALUES (tupla.iid, tupla.tipo, tupla.capacidad);
END IF;
END LOOP;
RETURN QUERY EXECUTE 'SELECT tabla_aux_2.iid, tabla_aux_2.tipo, tabla_aux_2.capacidad FROM tabla_aux INNER JOIN tabla_aux_2 ON tabla_aux.iid = tabla_aux_2.iid';
DROP TABLE tabla_aux;
DROP TABLE tabla_aux_2;
END;
$$ language plpgsql 
