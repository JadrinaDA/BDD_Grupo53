CREATE OR REPLACE FUNCTION todos_dias_disponibles(puerto VARCHAR,fecha_inicio DATE,fecha_termino DATE)
RETURNS TABLE (instalacion_dias_disponibles VARCHAR, porcentaje_de_ocupacion VARCHAR)
AS $$
DECLARE
tupla_permisos_permisos_atraques RECORD;
tupla_permisos_permisos_muelle RECORD;
tupla_instalaciones RECORD;
tupla_dias_permisos RECORD;
tupla_auxiliar RECORD;
tupla_dias_permiso_auxiliar RECORD;
tupla_dias_permisos_contar BIGINT;
capacidad_instalacion INTEGER;
cantidad_ocupada_muelles INTEGER;
cantidad_ocupada_astilleros INTEGER;
tabla_aux_id_fecha INTEGER;
cantidad_de_dias_ocupados_astilleros INTEGER;
fecha_auxiliar DATE;
discriminante BOOL;
contador_tablas_auxiliar_dias_contados INTEGER;
variable_contador_dias DATE;
dias_string VARCHAR;
vairable_pass INTEGER;
id INTEGER;
BEGIN
CREATE TABLE tabla_auxiliar_id_fecha(tabla_auxiliar_id INTEGER, instalaciones_id INTEGER, instalaciones_capacidad INTEGER,fecha DATE);
CREATE TABLE tabla_auxiliar_dias_contados(instalaciones_id INTEGER,instalacion_capacidad INTEGER,fecha DATE, dias_contados BIGINT);
CREATE TABLE tabla_dias_disponibles(instalaciones_id INTEGER,instalacion_capacidad INTEGER, instalacion_dias_disponibles VARCHAR, porcentaje_de_ocupacion VARCHAR);
CREATE TABLE tabla_dias_disponibles_cesgados(instalacion_dias_disponibles VARCHAR, porcentaje_de_ocupacion VARCHAR);
tabla_aux_id_fecha := 0;
FOR tupla_instalaciones IN SELECT * FROM instalaciones,atraques WHERE instalaciones.iid=atraques.iid
LOOP
capacidad_instalacion := tupla_instalaciones.capacidad;
cantidad_ocupada_muelles := 0;
FOR tupla_permisos_permisos_muelle IN SELECT permisos.pid,permisos.fecha_atraque FROM permisos,permisos_muelle WHERE permisos.pid=permisos_muelle.pid
LOOP
IF tupla_permisos_permisos_muelle.fecha_atraque >= fecha_inicio AND tupla_permisos_permisos_muelle.fecha_atraque <= fecha_termino
AND tupla_instalaciones.pid = tupla_permisos_permisos_muelle.pid
THEN 
cantidad_ocupada_muelles := cantidad_ocupada_muelles + 1;
INSERT INTO tabla_auxiliar_id_fecha VALUES(tabla_aux_id_fecha,tupla_instalaciones.iid,tupla_instalaciones.capacidad,tupla_permisos_permisos_muelle.fecha_atraque);
tabla_aux_id_fecha := tabla_aux_id_fecha + 1;
END IF;
END LOOP;
cantidad_ocupada_astilleros := 0; 
FOR tupla_permisos_permisos_atraques IN SELECT permisos.pid,permisos.fecha_atraque,permisos_astillero.fecha_salida FROM permisos,permisos_astillero
WHERE permisos.pid=permisos_astillero.pid
LOOP
IF tupla_instalaciones.pid = tupla_permisos_permisos_atraques.pid THEN discriminante := TRUE;
ELSE discriminante := FALSE;
END IF;
IF tupla_permisos_permisos_atraques.fecha_atraque >= fecha_inicio AND tupla_permisos_permisos_atraques.fecha_atraque <= fecha_termino
AND tupla_permisos_permisos_atraques.fecha_salida >= fecha_inicio AND tupla_permisos_permisos_atraques.fecha_salida <= fecha_termino AND discriminante
THEN
cantidad_de_dias_ocupados_astilleros := tupla_permisos_permisos_atraques.fecha_salida - tupla_permisos_permisos_atraques.fecha_atraque;
cantidad_ocupada_astilleros := cantidad_ocupada_astilleros + cantidad_de_dias_ocupados_astilleros;
LOOP
EXIT WHEN cantidad_de_dias_ocupados_astilleros = 0;
fecha_auxiliar := tupla_permisos_permisos_atraques.fecha_salida - cantidad_de_dias_ocupados_astilleros;
cantidad_de_dias_ocupados_astilleros := cantidad_de_dias_ocupados_astilleros - 1; 
INSERT INTO tabla_auxiliar_id_fecha VALUES(tabla_aux_id_fecha,tupla_instalaciones.iid,tupla_instalaciones.capacidad,fecha_auxiliar);
tabla_aux_id_fecha := tabla_aux_id_fecha + 1;
END LOOP; 
ELSEIF tupla_permisos_permisos_atraques.fecha_atraque >= fecha_inicio AND tupla_permisos_permisos_atraques.fecha_atraque <= fecha_termino AND discriminante
THEN
cantidad_de_dias_ocupados_astilleros := fecha_termino - tupla_permisos_permisos_atraques.fecha_atraque;
cantidad_ocupada_astilleros := cantidad_ocupada_astilleros + cantidad_de_dias_ocupados_astilleros + 1; 
LOOP
EXIT WHEN cantidad_de_dias_ocupados_astilleros = -1; 
fecha_auxiliar := fecha_termino - cantidad_de_dias_ocupados_astilleros;
cantidad_de_dias_ocupados_astilleros := cantidad_de_dias_ocupados_astilleros - 1; 
INSERT INTO tabla_auxiliar_id_fecha VALUES(tabla_aux_id_fecha,tupla_instalaciones.iid,tupla_instalaciones.capacidad,fecha_auxiliar);
tabla_aux_id_fecha := tabla_aux_id_fecha + 1;
END LOOP;
ELSE
IF tupla_permisos_permisos_atraques.fecha_salida >= fecha_inicio AND tupla_permisos_permisos_atraques.fecha_salida <= fecha_termino AND discriminante
THEN
cantidad_de_dias_ocupados_astilleros := tupla_permisos_permisos_atraques.fecha_salida - fecha_inicio;
cantidad_ocupada_astilleros := cantidad_ocupada_astilleros + cantidad_de_dias_ocupados_astilleros;
LOOP
EXIT WHEN cantidad_de_dias_ocupados_astilleros = 0;
fecha_auxiliar := tupla_permisos_permisos_atraques.fecha_salida - cantidad_de_dias_ocupados_astilleros;
cantidad_de_dias_ocupados_astilleros := cantidad_de_dias_ocupados_astilleros - 1; 
INSERT INTO tabla_auxiliar_id_fecha VALUES(tabla_aux_id_fecha,tupla_instalaciones.iid,tupla_instalaciones.capacidad,fecha_auxiliar);
tabla_aux_id_fecha := tabla_aux_id_fecha + 1;
END LOOP; -- 10-9
END IF;
END IF;
END LOOP; -- 11-4
END LOOP; -- 12-1;
FOR tupla_dias_permisos IN SELECT * FROM tabla_auxiliar_id_fecha
LOOP
FOR tupla_dias_permisos_contar IN SELECT COUNT(tabla_auxiliar_id_fecha.tabla_auxiliar_id) FROM tabla_auxiliar_id_fecha 
WHERE tabla_auxiliar_id_fecha.instalaciones_id=tupla_dias_permisos.instalaciones_id GROUP BY tabla_auxiliar_id_fecha.fecha
LOOP
INSERT INTO tabla_auxiliar_dias_contados VALUES(tupla_dias_permisos.instalaciones_id,tupla_dias_permisos.instalaciones_capacidad,tupla_dias_permisos.fecha,tupla_dias_permisos_contar);
END LOOP;
END LOOP;
FOR tupla_instalaciones IN SELECT * FROM instalaciones
LOOP
IF tupla_instalaciones.iid NOT IN (SELECT DISTINCT tabla_auxiliar_dias_contados.instalaciones_id FROM tabla_auxiliar_dias_contados WHERE tabla_auxiliar_dias_contados.instalaciones_id=tupla_instalaciones.iid)
THEN
dias_string := '';
FOR variable_contador_dias IN SELECT * FROM generate_series(fecha_inicio::DATE,fecha_termino, '1 day')
LOOP
IF dias_string = '' THEN dias_string := CONCAT(variable_contador_dias);
ELSE dias_string := CONCAT(dias_string,',',variable_contador_dias);
END IF;
END LOOP;
INSERT INTO tabla_dias_disponibles VALUES(tupla_instalaciones.iid,tupla_instalaciones.capacidad,dias_string,'0%');
ELSE
dias_string := '';
FOR variable_contador_dias IN SELECT * FROM generate_series(fecha_inicio::DATE,fecha_termino, '1 day')
LOOP
IF variable_contador_dias NOT IN (SELECT DISTINCT tabla_auxiliar_dias_contados.fecha FROM tabla_auxiliar_dias_contados WHERE tabla_auxiliar_dias_contados.instalaciones_id=tupla_instalaciones.iid) AND dias_string = ''
THEN dias_string := CONCAT(variable_contador_dias);
ELSEIF variable_contador_dias NOT IN (SELECT DISTINCT tabla_auxiliar_dias_contados.fecha FROM tabla_auxiliar_dias_contados WHERE tabla_auxiliar_dias_contados.instalaciones_id=tupla_instalaciones.iid) AND dias_string != ''
THEN dias_string := CONCAT(dias_string,',',variable_contador_dias);
ELSE
IF dias_string = '' AND tupla_instalaciones.capacidad = 1
THEN vairable_pass := 1;
ELSEIF dias_string != '' AND tupla_instalaciones.capacidad = 1
THEN vairable_pass := 2;
ELSEIF dias_string = '' AND tupla_instalaciones.capacidad = 2
THEN dias_string := CONCAT(variable_contador_dias);
ELSEIF dias_string != '' AND tupla_instalaciones.capacidad = 2
THEN dias_string := CONCAT(dias_string,',',variable_contador_dias);
ELSEIF dias_string = '' AND tupla_instalaciones.capacidad = 3
THEN dias_string := CONCAT(variable_contador_dias);
ELSEIF dias_string != '' AND tupla_instalaciones.capacidad = 3
THEN dias_string := CONCAT(dias_string,',',variable_contador_dias);
END IF;
END IF;
END LOOP;
IF tupla_instalaciones.capacidad = 1
THEN
INSERT INTO tabla_dias_disponibles VALUES(tupla_instalaciones.iid,tupla_instalaciones.capacidad,dias_string,'100%');
ELSEIF tupla_instalaciones.capacidad = 2
THEN
INSERT INTO tabla_dias_disponibles VALUES(tupla_instalaciones.iid,tupla_instalaciones.capacidad,dias_string,'50%');
ELSE
INSERT INTO tabla_dias_disponibles VALUES(tupla_instalaciones.iid,tupla_instalaciones.capacidad,dias_string,'33.33%');
END IF;
END IF;
END LOOP;
FOR tupla_dias_permiso_auxiliar IN SELECT * FROM (SELECT puertos.nombre,pertenece_a.iid FROM puertos, pertenece_a WHERE puertos.nombre=pertenece_a.nombre_puerto) AS consulta_aux WHERE nombre=puerto
LOOP
id := tupla_dias_permiso_auxiliar.iid;
tupla_auxiliar := 'FUNCIONO CTM';
INSERT INTO tabla_dias_disponibles_cesgados VALUES(tupla_auxiliar, tupla_auxiliar);
END LOOP;
RETURN QUERY EXECUTE 'SELECT * FROM tabla_dias_disponibles_cesgados';
DROP TABLE tabla_auxiliar_id_fecha;
DROP TABLE tabla_auxiliar_dias_contados;
DROP TABLE tabla_dias_disponibles;
DROP TABLE tabla_dias_disponibles_cesgados;
END;
$$ language plpgsql 
