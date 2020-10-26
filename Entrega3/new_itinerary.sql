CREATE OR REPLACE FUNCTION new_itinerary(patente VARCHAR, pid INT, fecha_llegada TIMESTAMP)
RETURNS VOID AS $$
DECLARE
new_piid INT;
BEGIN
new_id := (SELECT COUNT(*) FROM proximo_itinerario) + 1;
INSERT INTO proximo_itinerario VALUES(new_id, patente, pid, fecha_llegada);
END;
$$ language plpgsql 