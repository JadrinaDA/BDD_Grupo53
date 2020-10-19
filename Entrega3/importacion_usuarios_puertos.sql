CREATE OR REPLACE FUNCTION importar_usuarios_puertos()
RETURNS VOID AS $$
DECLARE
tupla_53 RECORD;
contador INTEGER;
nacionalidad VARCHAR;
clave VARCHAR;
BEGIN
clave := 'apple369';
contador := 0;
nacionalidad := 'CHILENA';
FOR tupla_53 IN SELECT * FROM personal,jefes WHERE personal.rut = jefes.rut
LOOP
INSERT INTO usuarios VALUES(contador,tupla_53.nombre,tupla_53.edad,tupla_53.sexo,tupla_53.rut,nacionalidad,clave);
contador := contador + 1;
END LOOP;
END;
$$ language plpgsql 