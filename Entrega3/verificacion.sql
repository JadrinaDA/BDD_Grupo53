CREATE OR REPLACE FUNCTION verificar_si_existe(pasaporte_rut VARCHAR)
RETURNS bool 
AS $$
DECLARE
tupla INTEGER;
BEGIN
tupla := (SELECT COUNT(*) FROM Personal WHERE Personal.pasaporte = pasaporte_rut USING pasaporte_rut);
IF tupla != 0 THEN RETURN TRUE;
ELSE RETURN FALSE; END IF;
END;
$$ language plpgsql