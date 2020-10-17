# LO QUE ME RETORNA LA CONSULTA SELECT * FROM personal,jefes 
# WHERE personal.rut=jefes.rut; (rut,nombre,edad,sexo,rut,iid)

SELECT * FROM personal,jefes WHERE personal.rut=jefes.rut;
CREATE OR REPLACE FUNCTION nacionalizar()
RETURNS TABLE (rut VARCHAR, nombre VARCHAR, edad INT, sexo VARCHAR, iid INT, nacionalidad VARCHAR) 
AS $$
DECLARE
BEGIN
END
