CREATE OR REPLACE FUNCTION importar_usuarios_puertos()
RETURNS TABLE (contador INTEGER, nombre VARCHAR, edad INTEGER, sexo VARCHAR, pasaporte VARCHAR, nacionalidad VARCHAR, clave VARCHAR)
AS $$
DECLARE
tupla_53 RECORD;
contador INTEGER;
nacionalidad VARCHAR;
clave VARCHAR;
BEGIN
CREATE TABLE tabla_auxiliar(contador INTEGER, nombre VARCHAR, edad INTEGER, sexo VARCHAR, pasaporte VARCHAR, nacionalidad VARCHAR, clave VARCHAR);
clave := 'apple369';
contador := 0;
nacionalidad := 'CHILENA';
FOR tupla_53 IN SELECT * FROM personal,jefes WHERE personal.rut = jefes.rut
LOOP
INSERT INTO tabla_auxiliar VALUES(contador,tupla_53.nombre,tupla_53.edad,tupla_53.sexo,tupla_53.rut,nacionalidad,clave);
contador := contador + 1;
END LOOP;
RETURN QUERY EXECUTE 'SELECT * FROM tabla_auxiliar';
DROP TABLE tabla_auxiliar;
END;
$$ language plpgsql 
