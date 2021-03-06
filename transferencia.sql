CREATE OR REPLACE FUNCTION
transferencia ()
RETURNS void AS $$
DECLARE
	tupla RECORD;
	concat varchar;
BEGIN
	FOR tupla IN SELECT * FROM PERSONAS LOOP
		concat = tupla.nombre || tupla.apellido;
		insert into personascompleto values(tupla.rut, concat);
	END LOOP;
END
$$ language plpgsql