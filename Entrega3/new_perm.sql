CREATE OR REPLACE FUNCTION new_perm(tipo VARCHAR, fecha_start DATE, fecha_end DATE, patente VARCHAR, id INT, actividad VARCHAR)
RETURNS VOID AS $$
BEGIN
INSERT INTO permisos VALUES(id, fecha_start);
IF tipo = 'astillero'
THEN
INSERT INTO permisos_astillero(id, fecha_end);
ELSE
INSERT INTO permisos_muelle(id, actividad)
END IF;
END;
$$ language plpgsql 