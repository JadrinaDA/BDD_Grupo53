CREATE OR REPLACE FUNCTION calcular_capacidad(puerto VARCHAR, fecha_start DATE, fecha_end DATE)
RETURNS TABLE(iid INT, tiene_capacidad bool)
AS $$
DECLARE
tupla_muelle RECORD;
tupla_asti RECORD;
tupla_inst RECORD;
tupla_inst_2 RECORD;
tupla_asti_2 RECORD;
capacidad_max INT;
atracados_s INT;
atracados INT[];
dias_int INT;
fecha_aux DATE;
has_cap bool;
ind INT;
BEGIN
CREATE TABLE table_cap(iid INT, tiene_capacidad bool);
CREATE TABLE table_moors(pid INT, iid INT, capacidad INT, fecha_atraque DATE);
FOR tupla_muelle IN SELECT permisos.pid, insts.iid, insts.capacidad, permisos.fecha_atraque FROM ((SELECT atraques.pid, instas.iid, instas.capacidad FROM
 (SELECT int_p.iid, instalaciones.tipo, instalaciones.capacidad FROM (SELECT pertenece_a.iid FROM pertenece_a WHERE pertenece_a.nombre_puerto = puerto) AS int_p INNER JOIN instalaciones ON int_p.iid = instalaciones.iid WHERE instalaciones.tipo = 'muelle') AS instas
 INNER JOIN atraques ON instas.iid = atraques.iid) AS insts INNER JOIN permisos ON insts.pid = permisos.pid)
LOOP
INSERT INTO table_moors VALUES(tupla_muelle.pid, tupla_muelle.iid, tupla_muelle.capacidad, tupla_muelle.fecha_atraque);
END LOOP;
atracados_s := 0;
FOR tupla_inst IN SELECT int_p.iid, instalaciones.tipo, instalaciones.capacidad FROM (SELECT pertenece_a.iid FROM pertenece_a WHERE pertenece_a.nombre_puerto = puerto) AS int_p INNER JOIN instalaciones ON int_p.iid = instalaciones.iid WHERE instalaciones.tipo = 'muelle'
LOOP
atracados_s := (SELECT COUNT(*) FROM table_moors WHERE table_moors.iid = tupla_inst.iid AND table_moors.fecha_atraque = fecha_start);
capacidad_max := tupla_inst.capacidad;
INSERT INTO table_cap VALUES(tupla_inst.iid, atracados_s < capacidad_max);
END LOOP;
DROP TABLE table_moors;
dias_int := fecha_start - fecha_end;
FOR tupla_inst_2 IN SELECT pertenece_a.iid FROM pertenece_a WHERE pertenece_a.nombre_puerto = puerto
LOOP
atracados := ARRAY[dias_int];
FOR tupla_asti_2 IN SELECT permisos_astillero.pid, astis.iid, astis.capacidad, astis.fecha_atraque, permisos_astillero.fecha_salida FROM ((SELECT permisos.pid, insts.iid, insts.capacidad, permisos.fecha_atraque FROM ((SELECT pid, instas.iid, instas.capacidad FROM 
	(SELECT int_p.iid, instalaciones.tipo, instalaciones.capacidad FROM (SELECT pertenece_a.iid FROM pertenece_a WHERE pertenece_a.nombre_puerto = puerto) AS int_p INNER JOIN instalaciones ON int_p.iid = instalaciones.iid WHERE instalaciones.tipo = 'astillero') AS instas
 INNER JOIN atraques ON instas.iid = atraques.iid) AS insts INNER JOIN permisos ON insts.pid = permisos.pid)) as astis INNER JOIN permisos_astillero ON astis.pid = permisos_astillero.pid) WHERE astis.iid = tupla_inst_2.iid
LOOP
IF tupla_asti_2.fecha_atraque >= fecha_start AND tupla_asti_2.fecha_atraque <= fecha_end
THEN 
IF tupla_asti_2.fecha_salida >= fecha_end
THEN
fecha_aux := tupla_asti_2.fecha_atraque;
LOOP
EXIT WHEN fecha_aux = fecha_end + 1;
atracados[fecha_aux - fecha_start] =  atracados[fecha_aux - fecha_start] + 1;
fecha_aux := fecha_aux + 1;
END LOOP;
ELSE
fecha_aux := tupla_asti_2.fecha_atraque;
LOOP
EXIT WHEN fecha_aux = tupla_asti_2.fecha_salida + 1;
atracados[fecha_aux - fecha_start] =  atracados[fecha_aux - fecha_start] + 1;
fecha_aux := fecha_aux + 1;
END LOOP;
END IF;
ELSEIF tupla_asti_2.fecha_salida >= fecha_start AND tupla_asti_2.fecha_salida <= fecha_end
THEN
fecha_aux := fecha_start;
LOOP
EXIT WHEN fecha_aux = tupla_asti_2.fecha_salida + 1;
atracados[fecha_aux - fecha_start] =  atracados[fecha_aux - fecha_start] + 1;
fecha_aux := fecha_aux + 1;
END LOOP;
ELSEIF tupla_asti_2.fecha_atraque < fecha_start AND tupla_asti_2.fecha_salida > fecha_end
THEN
fecha_aux := fecha_start;
LOOP
EXIT WHEN fecha_aux = fecha_end + 1;
atracados[fecha_aux - fecha_start] =  atracados[fecha_aux - fecha_start] + 1;
fecha_aux := fecha_aux + 1;
END LOOP;
END IF;
END LOOP;
capacidad_max := tupla_inst_2.capacidad;
ind := 0;
has_cap := true;
LOOP
EXIT WHEN ind >= dias_int;
IF atracados[ind] >= capacidad_max
THEN
has_cap := false;
END IF;
ind := ind + 1;
END LOOP;
INSERT INTO table_cap VALUES(tupla_asti_2.iid, has_cap);
END LOOP;
RETURN QUERY EXECUTE 'SELECT * FROM table_cap ORDER BY iid';
DROP TABLE table_cap;
END;
$$ language plpgsql 