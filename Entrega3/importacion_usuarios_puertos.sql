CREATE OR REPLACE FUNCTION importar_usuarios_puertos()
<<<<<<< HEAD
RETURNS TABLE (contador INTEGER, nombre VARCHAR, edad INTEGER, sexo VARCHAR, pasaporte VARCHAR, nacionalidad VARCHAR, clave VARCHAR)
AS $$
=======
RETURNS VOID AS $$
>>>>>>> a3d18b2e7d0247add3d6da8b65e5fa2f5ede52fd
DECLARE
tupla_53 RECORD;
contador INTEGER;
nacionalidad VARCHAR;
clave VARCHAR;
BEGIN
<<<<<<< HEAD
CREATE TABLE tabla_auxiliar(contador INTEGER, nombre VARCHAR, edad INTEGER, sexo VARCHAR, pasaporte VARCHAR, nacionalidad VARCHAR, clave VARCHAR);
=======
>>>>>>> a3d18b2e7d0247add3d6da8b65e5fa2f5ede52fd
clave := 'apple369';
contador := 0;
nacionalidad := 'CHILENA';
FOR tupla_53 IN SELECT * FROM personal,jefes WHERE personal.rut = jefes.rut
LOOP
<<<<<<< HEAD
INSERT INTO tabla_auxiliar VALUES(contador,tupla_53.nombre,tupla_53.edad,tupla_53.sexo,tupla_53.rut,nacionalidad,clave);
contador := contador + 1;
END LOOP;
RETURN tabla_auxiliar;
DROP TABLE tabla_auxiliar;
=======
INSERT INTO usuarios VALUES(contador,tupla_53.nombre,tupla_53.edad,tupla_53.sexo,tupla_53.rut,nacionalidad,clave);
contador := contador + 1;
END LOOP;
>>>>>>> a3d18b2e7d0247add3d6da8b65e5fa2f5ede52fd
END;
$$ language plpgsql 