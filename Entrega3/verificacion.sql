##(nombre,edad,sexo,contraseña,nacionalidad,pasaporte_rut)
CREATE OR REPLACE FUNCTION verificar_si_existe(pasaporte_rut VARCHAR)
RETURNS bool 
AS $$
DECLARE
tupla RECORD;
BEGIN;
tupla := EXECUTE QUERY 'SELECT COUNT(*) FROM Usuarios WHERE Usuarios.pasaporte = pasaporte_rut' USING pasaporte_rut;
IF tupla != 0 THEN RETURN TRUE;
ELSE RETURN FALSE; END IF;
END;
$$ language plpgsql