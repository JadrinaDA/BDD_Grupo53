CREATE OR REPLACE FUNCTION imoprtar_usuarios()
RETURNS VOID AS $$
DECLARE
tupla_53 RECORD;
tupla_14 RECORD;
contador INTEGER;
sexo VARCHAR;
nacionalidad VARCHAR;
BEGIN
contador := 0;
nacionalidad := 'CHILENA';
FOR tupla_53 IN SELECT * FROM personal,jefes WHERE personal.rut = jefes.rut
LOOP
INSERT INTO usuarios VALUES(contador,tupla_53.nombre,tupla_53.edad,tupla_53.sexo,tupla_53.rut,nacionalidad,aleatorio());
contador := contador + 1;
END LOOP;
FOR tupla_14 IN SELECT * FROM personal WHERE es_capitan = 't'
LOOP
sexo := '';
IF tupla_14.genero = 'mujer' THEN sexo := 'F';
ELSE sexo := 'M'; END IF;
INSERT INTO usuarios VALUES(contador,tupla_14.pnombre,tupla_14.edad,sexo,tupla_14.pasaporte,tupla_14.nacionalidad,aleatorio());
contador := contador +1;
END LOOP;
END;
$$ language plpgsql 