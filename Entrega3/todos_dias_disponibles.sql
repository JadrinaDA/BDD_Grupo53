CREATE OR REPLACE FUNCTION todos_dias_disponibles(fecha_inicio DATE,fecha_termino DATE)
RETURNS TABLE (dias_contados BIGINT,fecha DATE)
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
CREATE TABLE tabla_auxiliar_id_fecha(tabla_auxiliar_id INTEGER, intalaciones_id INTEGER, instalaciones_capacidad INTEGER,fecha DATE);
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
RETURN QUERY EXECUTE 'SELECT COUNT(tabla_auxiliar_id_fecha.tabla_auxiliar_id) AS cantidad_permisos_en_ese_dia,tabla_auxiliar_id_fecha.fecha FROM tabla_auxiliar_id_fecha GROUP BY tabla_auxiliar_id_fecha.fecha';
DROP TABLE tabla_auxiliar_id_fecha;
END;
$$ language plpgsql 

