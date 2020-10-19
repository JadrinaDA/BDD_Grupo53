CREATE OR REPLACE FUNCTION imoprtar_usuarios()
RETURNS VOID AS $$
DECLARE
tupla_53 RECORD;
tupla_14 RECORD;
contador INTEGER;
sexo VARCHAR;
BEGIN
contador := 0;
FOR tupla_53 IN SELECT * FROM personal,jefes WHERE personal.rut = jefes.rut
LOOP
INSERT INTO usuarios VALUES(contador,tupla_53.nombre,tupla_53.edad,tupla_53.sexo,tupla_53.rut,"CHILENA",aleatorio());
contador := contador + 1;
END LOOP;
END;
$$ language plpgsql 