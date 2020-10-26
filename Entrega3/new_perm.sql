CREATE OR REPLACE FUNCTION new_perm(tipo VARCHAR, fecha_start DATE, fecha_end DATE, patente VARCHAR, id INT, actividad VARCHAR)
RETURNS VOID AS $$
DECLARE
new_id INT;
BEGIN
new_id := (SELECT COUNT(*) FROM permisos) + 1;
INSERT INTO permisos VALUES(new_id, fecha_start);
IF tipo = 'astillero'
THEN
INSERT INTO permisos_astillero VALUES(new_id, fecha_end);
ELSE
INSERT INTO permisos_muelle VALUES(new_id, actividad);
END IF;
INSERT INTO atraques VALUES(new_id, id, patente);
END;
$$ language plpgsql 