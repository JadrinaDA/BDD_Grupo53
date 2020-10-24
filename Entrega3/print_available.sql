CREATE OR REPLACE FUNCTION print_available(tipo_chosen VARCHAR, fecha_start DATE, fecha_end DATE)
RETURNS TABLE(iid INT, tipo VARCHAR(100), capacidad INT) 
AS $$
DECLARE
tupla RECORD;
pos_com INT;
string CHAR(100);
BEGIN
CREATE TABLE tabla_aux(iid INT, tiene_capacidad bool);
FOR tupla IN SELECT calcular_capacidad(fecha_start, fecha_end)
LOOP
string := CAST(tupla.calcular_capacidad AS CHAR(100));
pos_com := POSITION(',' IN string);
INSERT INTO tabla_aux VALUES(CAST(SUBSTRING(string , 2, pos_com - 2) AS INT), CAST(SUBSTRING(string , pos_com + 1, 1) AS bool));
END LOOP;
CREATE TABLE tabla_aux_2(iid INT, tipo VARCHAR(100), capacidad INT);
FOR tupla IN SELECT * FROM instalaciones
LOOP
IF tupla.tipo = tipo_chosen
THEN
INSERT INTO tabla_aux VALUES (tupla.iid, tupla.tipo, tupla.capacidad);
END IF;
END LOOP;
RETURN QUERY EXECUTE 'SELECT * FROM tabla_aux INNER JOIN tabla_aux_2 ON tabla_aux.iid = tabla_aux_2.iid';
DROP TABLE tabla_aux;
DROP TABLE tabla_aux_2;
END;
$$ language plpgsql 
