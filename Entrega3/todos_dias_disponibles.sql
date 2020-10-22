-- INPUT: DOS FECHAS
-- OUTPUT: todos los dias en ese intervalo donde todavia no esta agotada la capacidad de instalacion
--		   porcentaje promedio de ocupacion de ese intervalo.
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
-- me retorna iid, tipo, capacidad,pid, idd, patente
FOR tupla_instalaciones IN SELECT * FROM instalaciones,atraques WHERE instalaciones.iid=atraques.iid
LOOP
capacidad_instalacion := tupla_instalaciones.capacidad;
cantidad_ocupada_muelles := 0;
-- me retorna pid,fecha_atraque
FOR tupla_permisos_permisos_muelle IN SELECT permisos.pid,permisos.fecha_atraque FROM permisos,permisos_muelle WHERE permisos.pid=permisos_muelle.pid
LOOP
-- UNICO CASO MUELLES, LA FECHA ESTA O NO DENTRO DEL INTERVALO
IF tupla_permisos_permisos_muelle.fecha_atraque >= fecha_inicio AND tupla_permisos_permisos_muelle <= fecha_salida
AND tupla_instalaciones.pid = tupla_permisos_permisos_muelle.pid
THEN 
cantidad_ocupada_muelles := cantidad_ocupada_muelles + 1;
INSERT INTO tabla_auxiliar_id_fecha VALUES(tabla_aux_id_fecha,tupla_permisos_permisos_muelle.fecha_atraque);
tabla_aux_id_fecha := tabla_aux_id_fecha + 1;
END IF;
END LOOP;
cantidad_ocupada_astilleros := 0; 
-- me retorna pid,fecha_atraque,fecha_salida
FOR tupla_permisos_permisos_atraques IN SELECT permisos.pid,permisos.fecha_atraque,permisos_astillero.fecha_salida FROM permisos,permisos_astillero
WHERE permisos.pid=permisos_astillero.pid
LOOP
IF tupla_instalaciones.pid = tupla_permisos_permisos_atraques.pid THEN discriminante := TRUE;
ELSE discriminante := FALSE;
END IF;
-- PRIMER CASO ASTILLEROS, AMBAS FECHAS ESTAN DENTRO DEL INTERVALO
IF tupla_permisos_permisos_atraques.fecha_atraque >= fecha_inicio AND tupla_permisos_permisos_atraques.fecha_atraque <= fecha_salida
AND tupla_permisos_permisos_atraques.fecha_salida >= fecha_inicio AND tupla_permisos_permisos_atraques.salida <= fecha_salida AND discriminante
THEN
cantidad_de_dias_ocupados_astilleros := tupla_permisos_permisos_atraques.fecha_salida - tupla_permisos_permisos_atraques.fecha_atraque;
cantidad_ocupada_astilleros := cantidad_ocupada_astilleros + cantidad_de_dias_ocupados_astilleros; --date '2001-10-01' - date '2001-09-28' = integer '3' (days)
-- notar que los dias ocupados seria el 28,29,30 y el 1, son 4 dias y no 3. UPDATE, pero el 1 se va, me lo deja disponible, son 3.
LOOP
fecha_auxiliar := tupla_permisos_permisos_atraques.fecha_salida - cantidad_de_dias_ocupados_astilleros;
cantidad_de_dias_ocupados_astilleros := cantidad_de_dias_ocupados_astilleros - 1; 
INSERT INTO tabla_auxiliar_id_fecha VALUES(tabla_aux_id_fecha,fecha_auxiliar);
tabla_aux_id_fecha := tabla_aux_id_fecha + 1;
EXIT WHEN cantidad_de_dias_ocupados_astilleros = 0;
END LOOP;
-- SEGUNDO CASO ASTILLEROS, LA FECHA DE ATRAQUE ESTA DENTRO DEL INTERVALO PERO LA FECHA DE SALIDA NO
ELSEIF tupla_permisos_permisos_atraques.fecha_atraque >= fecha_inicio AND tupla_permisos_permisos_atraques.fecha_atraque <= fecha_salida AND discriminante
THEN
cantidad_de_dias_ocupados_astilleros := fecha_termino - tupla_permisos_permisos_atraques.fecha_atraque;
cantidad_ocupada_astilleros := cantidad_ocupada_astilleros + cantidad_de_dias_ocupados_astilleros + 1; 
--date '2001-10-01' - date '2001-09-28' = integer '3' (days)
-- notar que los dias ocupados seria el 28,29,30 y el 1. UPDATE supongamos que el 29 es la fecha_termino y la
-- fecha_atraque es el 28, la diferencia es 1, pero ambos dias estarian dentro de mi intervalo, siendo uno mas.
LOOP
--date '2001-10-01' - date '2001-09-28' = integer '3' (days), pero supongamos
--que el 29 es la fecha_termino y la fecha_inicio es el 28, la diferencia es 1, entonces al restarle al 29 uno queda 28, guardo
--esa fecha, pero no guardaria la del 29 que tambien estaria incluida, por eso el loop debe recorrer el valor de 0.
fecha_auxiliar := fecha_termino - cantidad_de_dias_ocupados_astilleros;
cantidad_de_dias_ocupados_astilleros := cantidad_de_dias_ocupados_astilleros - 1; 
INSERT INTO tabla_auxiliar_id_fecha VALUES(tabla_aux_id_fecha,fecha_auxiliar);
tabla_aux_id_fecha := tabla_aux_id_fecha + 1;
EXIT WHEN cantidad_de_dias_ocupados_astilleros = -1; 
END LOOP;
-- TERCER CASO ASTILLEROS, LA FECHA DE ATRAQUE NO ESTA DENTRO DEL INTERVALO PERO LA FECHA DE SALIDA SI
ELSE
IF discriminante
THEN
cantidad_de_dias_ocupados_astilleros := tupla_permisos_permisos_atraques.fecha_salida - fecha_inicio;
cantidad_ocupada_astilleros := cantidad_ocupada_astilleros + cantidad_de_dias_ocupados_astilleros + 1; 
--date '2001-10-01' - date '2001-09-28' = integer '3' (days)
-- notar que los dias ocupados seria el 28,29,30 y el 1. UPDATE, pero supongamos que el intervalo es del dia 28 a 30 y yo tengo ocupado el astillero desde el 27 al 29
-- entonces, la interseccion del intervalo seria 28 y 29. fecha de salida seria el 29 y la fecha de inicio el 28, diferencia de 1, pero los 2 dias estan incluidos en 
-- el intervalo. por eso el loop debe recorrer el valor de 0.
LOOP
fecha_auxiliar := fecha_inicio + cantidad_de_dias_ocupados_astilleros;
cantidad_de_dias_ocupados_astilleros := cantidad_de_dias_ocupados_astilleros - 1; 
INSERT INTO tabla_auxiliar_id_fecha VALUES(tabla_aux_id_fecha,fecha_auxiliar);
tabla_aux_id_fecha := tabla_aux_id_fecha + 1;
EXIT WHEN cantidad_de_dias_ocupados_astilleros = -1;
END LOOP;
END IF;
END IF;
RETURN QUERY EXECUTE 'SELECT * FROM tabla_auxiliar_id_fecha';
DROP TABLE tabla_auxiliar_id_fecha;
END;
$$ language plpgsql 


