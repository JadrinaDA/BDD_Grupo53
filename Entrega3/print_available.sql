CREATE OR REPLACE FUNCTION print_available(tipo_chose VARCHAR, fecha_start DATE, fecha_end DATE)
RETURNS TABLE(iid INT, tipo VARCHAR(100), capacidad INT) 
AS $$
DECLARE
tupla RECORD;
BEGIN
CREATE TABLE tabla_aux(iid INT, tiene_capacidad bool);
FOR tupla IN SELECT calcular_capacidad(fecha_start, fecha_end)
LOOP
INSERT INTO tabla_aux VALUES(CAST(SUBSTRING(CAST(tupla.calcular_capacidad AS CHAR) , 2, 1) AS INT), SUBSTRING(CAST(tupla.calcular_capacidad AS CHAR) , 4, 1));
END LOOP;
RETURN QUERY EXECUTE 'SELECT * FROM instalaciones INNER JOIN tabla_aux ON instalaciones.iid == tabla_aux.iid WHERE instalaciones.tipo = tipo_chosen';
DROP TABLE tabla_aux;
END;
$$ language plpgsql 
