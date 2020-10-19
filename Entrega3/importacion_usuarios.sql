CREATE OR REPLACE FUNCTION imoprtar_usuarios()
RETURNS VOID AS $$
DECLARE
tupla RECORD;
BEGIN
FOR tupla IN SELECT * FROM personal,jefes WHERE personal.rut = jefes.rut
LOOP
INSERT INTO intento_1 VALUES((tupla).nombre,(tupla).rut);
END LOOP;
END;
$$ language plpgsql 