CREATE OR REPLACE FUNCTION imoprtar_usuarios()
RETURNS VOID AS $$
DECLARE
tupla_53 RECORD;
tupla_14 RECORD;
contador INTEGER;
BEGIN
contador := 0
FOR tupla_53 IN SELECT * FROM personal,jefes WHERE personal.rut = jefes.rut
LOOP
INSERT INTO intento_1 VALUES(contador,tupla_53.rut);
contador := contador + 1;
END LOOP;
END;
$$ language plpgsql 