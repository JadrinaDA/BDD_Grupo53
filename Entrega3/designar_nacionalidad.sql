CREATE OR REPLACE FUNCTION nacionalizar()
RETURNS TABLE (rut CHAR(12), nombre VARCHAR(100), edad INTEGER, sexo CHAR(1), iid INTEGER, nacionalidad VARCHAR) 
AS $$
DECLARE
BEGIN
CREATE TABLE tabla_aux(nacionalidad VARCHAR);
RETURN QUERY EXECUTE 'SELECT * FROM (SELECT personal.rut,nombre,edad,sexo,iid FROM personal,jefes WHERE personal.rut=jefes.rut) AS consulta CROSS JOIN tabla_aux';
DROP TABLE tabla_aux;
END;
$$ language plpgsql 