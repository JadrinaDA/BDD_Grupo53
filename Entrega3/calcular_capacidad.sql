CREATE OR REPLACE FUNCTION calcular_capacidad(fecha_start DATE, fecha_end DATE)
RETURNS TABLE(iid INT, tiene_capacidad bool)
AS $$
DECLARE
tupla_muelle RECORD;
tupla_asti RECORD;
capacidad_max INT;
atracados INT;
BEGIN
CREATE TABLE table_cap(iid INT, tiene_capacidad bool);
atracados := 0;
FOR tupla_inst IN SELECT permisos.pid, iid, capacidad, fecha_atraque FROM ((SELECT pid, instalaciones.iid, instalaciones.capacidad FROM instalaciones
 INNER JOIN atraques ON instalaciones.iid = atraques.iid WHERE instalaciones.tipo = 'muelle') AS insts INNER JOIN permisos ON insts.pid = permisos.pid);
LOOP
IF tupla_inst.fecha_atraque >= fecha_start AND tupla_inst.fecha_atraque <= fecha_end
THEN 
atracados := atracados + 1;
capacidad_max := tupla_inst.capacidad;
INSERT INTO table_cap VALUES(tupla_inst.iid, atracados < capacidad_max);
END LOOP;
atracados := 0;
FOR tupla_asti IN SELECT permisos_astillero.pid, iid, capacidad, fecha_atraque, fecha_salida FROM ((SELECT permisos.pid, iid, capacidad, fecha_atraque FROM ((SELECT pid, instalaciones.iid, instalaciones.capacidad FROM instalaciones
 INNER JOIN atraques ON instalaciones.iid = atraques.iid WHERE instalaciones.tipo = 'astillero') AS insts INNER JOIN permisos ON insts.pid = permisos.pid)) as astis INNER JOIN permisos_astillero ON astis.pid = permisos_astillero.pid);
LOOP
IF tupla_asti.fecha_atraque >= fecha_start AND tupla_inst.fecha_salida <= fecha_salida;
THEN 
atracados := atracados + 1;
capacidad_max := tupla_asti.capacidad;
INSERT INTO table_cap VALUES(tupla_asti.iid, atracados < capacidad_max);
END LOOP;
RETURN QUERY EXECUTE 'SELECT * FROM table_cap';
DROP TABLE table_cap;
END;
$$ language plpgsql 