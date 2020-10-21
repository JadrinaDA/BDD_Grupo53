CREATE OR REPLACE FUNCTION calcular_capacidad(fecha_start DATE, fecha_end DATE)
RETURNS TABLE(iid INT, tiene_capacidad bool)
AS $$
DECLARE
tupla_muelle RECORD;
tupla_asti RECORD;
tupla_inst RECORD;
capacidad_max INT;
atracados INT;
BEGIN
CREATE TABLE table_cap(iid INT, tiene_capacidad bool);
CREATE TABLE table_moors(pid INT, iid INT, capacidad INT, fecha_atraque DATE);
FOR tupla_muelle IN SELECT permisos.pid, insts.iid, insts.capacidad, permisos.fecha_atraque FROM ((SELECT atraques.pid, instalaciones.iid, instalaciones.capacidad FROM instalaciones
 INNER JOIN atraques ON instalaciones.iid = atraques.iid WHERE instalaciones.tipo = 'muelle') AS insts INNER JOIN permisos ON insts.pid = permisos.pid)
LOOP
INSERT INTO tabla_moors VALUES(tupla_muelle.pid, tupla_muelle.iid, tupla_muelle.capacidad, tupla_muelle.fecha_atraque);
END LOOP;
atracados := 0;
FOR tupla_inst IN SELECT * FROM instalaciones
LOOP
IF tupla_inst.fecha_atraque = fecha_start
THEN 
atracados := (SELECT COUNT(*) FROM table_moors WHERE table_moors.iid == tupla_inst.iid);
END IF;
capacidad_max := tupla_inst.capacidad;
INSERT INTO table_cap VALUES(tupla_inst.iid, atracados < capacidad_max);
END LOOP;
DROP TABLE table_moors;
/*atracados := 0;
FOR tupla_asti IN SELECT permisos_astillero.pid, astis.iid, astis.capacidad, astis.fecha_atraque, permisos_astillero.fecha_salida FROM ((SELECT permisos.pid, insts.iid, insts.capacidad, permisos.fecha_atraque FROM ((SELECT pid, instalaciones.iid, instalaciones.capacidad FROM instalaciones
 INNER JOIN atraques ON instalaciones.iid = atraques.iid WHERE instalaciones.tipo = 'astillero') AS insts INNER JOIN permisos ON insts.pid = permisos.pid)) as astis INNER JOIN permisos_astillero ON astis.pid = permisos_astillero.pid)
LOOP
IF tupla_asti.fecha_atraque >= fecha_start AND tupla_asti.fecha_atraque <= fecha_end AND tupla_asti.fecha_salida >
THEN 
atracados := atracados + 1;
END IF;
capacidad_max := tupla_asti.capacidad;
INSERT INTO table_cap VALUES(tupla_asti.iid, atracados < capacidad_max);
END LOOP;*/
RETURN QUERY EXECUTE 'SELECT * FROM table_cap';
DROP TABLE table_cap;
END;
$$ language plpgsql 