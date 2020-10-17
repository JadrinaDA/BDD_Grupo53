CREATE OR REPLACE FUNCTION nacionalizar()
RETURNS TABLE (rut VARCHAR, nombre VARCHAR, edad INT, sexo VARCHAR, iid INT, nacionalidad VARCHAR) 
AS $$
DECLARE
BEGIN
CREATE TABLE tabla_aux(nacionalidad VARCHAR);
RETURN SELECT * FROM (SELECT * FROM personal,jefes WHERE personal.rut=jefes.rut) CROSS JOIN tabla_aux;
DROP TABLE tabla_aux;
END;
$$ language plpgsql