CREATE OR REPLACE FUNCTION importar_usuarios_buques()
RETURNS VOID AS $$
DECLARE
tupla_14 RECORD;
contador INTEGER;
sexo VARCHAR;
clave VARCHAR;
BEGIN
clave := 'apple369'
contador := SELECT COUNT(Usuarios.uid) FROM Usuarios;
contador := contador + 1;
FOR tupla_14 IN SELECT * FROM personal WHERE es_capitan = 't'
LOOP
sexo := '';
IF tupla_14.genero = 'mujer' THEN sexo := 'F';
ELSE sexo := 'M'; END IF;
INSERT INTO usuarios VALUES(contador,tupla_14.pnombre,tupla_14.edad,sexo,tupla_14.pasaporte,tupla_14.nacionalidad,clave);
contador := contador + 1;
END LOOP;
END;
$$ language plpgsql 