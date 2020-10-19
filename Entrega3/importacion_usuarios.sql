CREATE OR REPLACE FUNCTION imoprtar_usuarios()
RETURNS VOID AS $$
DECLARE
tupla RECORD;
lista ARRAY;
BEGIN
FOR tupla IN SELECT * FROM personal,jefes WHERE personal.rut = jefes.rut
LOOP
lista := ARRAY(tupla);
INSERT INTO intento_1 VALUES(lista[2],lista[1]);
END LOOP;
END;
$$ language plpgsql \