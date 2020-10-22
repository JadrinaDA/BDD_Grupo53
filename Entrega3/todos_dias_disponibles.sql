CREATE OR REPLACE FUNCTION todos_dias_disponibles(fecha_inicio DATE, fecha_termino DATE)
RETURNS TABLE (instalacion_id INTEGER,instalacion VARCHAR, tipo_instalacion VARCHAR,dias_no_agotados VARCHAR ,porcentaje_ocupacion VARCHAR)
AS $$
DECLARE
tupla_permisos_permisos_atraques RECORD;
tupla_permisos_permisos_muelle RECORD;
tupla_instalaciones RECORD;
capacidad_instalacion INTEGER;
cantidad_ocupada_muelles INTEGER;
cantidad_ocupada_astilleros INTEGER;
tabla_aux_id_fecha INTEGER;
cantidad_de_dias_ocupados_astilleros INTEGER;
fecha_auxiliar DATE;
discriminante BOOL;
BEGIN
CREATE TABLE tabla_auxiliar_id_fecha(tabla_auxiliar_id INTEGER, fecha DATE);
tabla_aux_id_fecha := 0;
FOR tupla_instalaciones IN SELECT * FROM instalaciones,atraques WHERE instalaciones.iid=atraques.iid
LOOP -- 1-12
capacidad_instalacion := tupla_instalaciones.capacidad;
cantidad_ocupada_muelles := 0;
FOR tupla_permisos_permisos_muelle IN SELECT permisos.pid,permisos.fecha_atraque FROM permisos,permisos_muelle WHERE permisos.pid=permisos_muelle.pid
LOOP -- 2-3
IF tupla_permisos_permisos_muelle.fecha_atraque >= fecha_inicio AND tupla_permisos_permisos_muelle <= fecha_salida
AND tupla_instalaciones.pid = tupla_permisos_permisos_muelle.pid
THEN 
cantidad_ocupada_muelles := cantidad_ocupada_muelles + 1;
INSERT INTO tabla_auxiliar_id_fecha VALUES(tabla_aux_id_fecha,tupla_permisos_permisos_muelle.fecha_atraque);
tabla_aux_id_fecha := tabla_aux_id_fecha + 1;
END IF;
END LOOP; -- 3-2
cantidad_ocupada_astilleros := 0; 
FOR tupla_permisos_permisos_atraques IN SELECT permisos.pid,permisos.fecha_atraque,permisos_astillero.fecha_salida FROM permisos,permisos_astillero
WHERE permisos.pid=permisos_astillero.pid
LOOP -- 4-11
IF tupla_instalaciones.pid = tupla_permisos_permisos_atraques.pid THEN discriminante := TRUE;
ELSE discriminante := FALSE;
END IF;
IF tupla_permisos_permisos_atraques.fecha_atraque >= fecha_inicio AND tupla_permisos_permisos_atraques.fecha_atraque <= fecha_salida
AND tupla_permisos_permisos_atraques.fecha_salida >= fecha_inicio AND tupla_permisos_permisos_atraques.salida <= fecha_salida AND discriminante
THEN
cantidad_de_dias_ocupados_astilleros := tupla_permisos_permisos_atraques.fecha_salida - tupla_permisos_permisos_atraques.fecha_atraque;
cantidad_ocupada_astilleros := cantidad_ocupada_astilleros + cantidad_de_dias_ocupados_astilleros;
LOOP -- 5-6
EXIT WHEN cantidad_de_dias_ocupados_astilleros = 0;
fecha_auxiliar := tupla_permisos_permisos_atraques.fecha_salida - cantidad_de_dias_ocupados_astilleros;
cantidad_de_dias_ocupados_astilleros := cantidad_de_dias_ocupados_astilleros - 1; 
INSERT INTO tabla_auxiliar_id_fecha VALUES(tabla_aux_id_fecha,fecha_auxiliar);
tabla_aux_id_fecha := tabla_aux_id_fecha + 1;
END LOOP; -- 6-5
ELSEIF tupla_permisos_permisos_atraques.fecha_atraque >= fecha_inicio AND tupla_permisos_permisos_atraques.fecha_atraque <= fecha_salida AND discriminante
THEN
cantidad_de_dias_ocupados_astilleros := fecha_termino - tupla_permisos_permisos_atraques.fecha_atraque;
cantidad_ocupada_astilleros := cantidad_ocupada_astilleros + cantidad_de_dias_ocupados_astilleros + 1; 
LOOP -- 7-8
EXIT WHEN cantidad_de_dias_ocupados_astilleros = -1; 
fecha_auxiliar := fecha_termino - cantidad_de_dias_ocupados_astilleros;
cantidad_de_dias_ocupados_astilleros := cantidad_de_dias_ocupados_astilleros - 1; 
INSERT INTO tabla_auxiliar_id_fecha VALUES(tabla_aux_id_fecha,fecha_auxiliar);
tabla_aux_id_fecha := tabla_aux_id_fecha + 1;
END LOOP; -- 8-7
ELSE
IF discriminante
THEN
cantidad_de_dias_ocupados_astilleros := tupla_permisos_permisos_atraques.fecha_salida - fecha_inicio;
cantidad_ocupada_astilleros := cantidad_ocupada_astilleros + cantidad_de_dias_ocupados_astilleros + 1; 
LOOP -- 9-10
EXIT WHEN cantidad_de_dias_ocupados_astilleros = -1;
fecha_auxiliar := fecha_inicio + cantidad_de_dias_ocupados_astilleros;
cantidad_de_dias_ocupados_astilleros := cantidad_de_dias_ocupados_astilleros - 1; 
INSERT INTO tabla_auxiliar_id_fecha VALUES(tabla_aux_id_fecha,fecha_auxiliar);
tabla_aux_id_fecha := tabla_aux_id_fecha + 1;
END LOOP; -- 10-9
END IF;
END IF;
END LOOP; -- 11-4
END LOOP; -- 12-1;
RETURN QUERY EXECUTE 'SELECT * FROM tabla_auxiliar_id_fecha';
DROP TABLE tabla_auxiliar_id_fecha;
END;
$$ language plpgsql 


