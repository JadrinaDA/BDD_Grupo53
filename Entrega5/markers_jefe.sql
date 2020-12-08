CREATE OR REPLACE FUNCTION markers_jefe (rut VARCHAR)
RETURNS VARCHAR
AS $$
es_jefe INTEGER;
jefe_de INTEGER;
nombre_puerto VARCHAR;
coordenadas_x FLOAT;
coordenadas_y FLOAT;
coordenadas_string VARCHAR;
BEGIN
es_jefe := SELECT COUNT(jefes.iid) FROM jefes WHERE jefes.rut=rut;
IF es_jefe = 1 THEN
jefe_de := SELECT jefes.iid FROM jefes WHERE jefes.rut=rut;
nombre_puerto := SELECT pertenece_a.nombre_puerto FROM pertenece_a WHERE pertenece_a.iid=jefe_de;
coordenadas_x := SELECT puerto_coords.latitud FROM puerto_coords WHERE puerto_coords.puerto=nombre_puerto;
coordenadas_y := SELECT puerto_coords.longitud FROM puerto_coords WHERE puerto_coords.puerto=nombre_puerto;
coordenadas_string := CONCAT(coordenadas_x,',',coordenadas_y);
ELSE 
coordenadas_string := 'None';
END IF;