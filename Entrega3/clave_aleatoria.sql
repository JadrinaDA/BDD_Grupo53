CREATE OR REPLACE FUNCTION aleatorio ()
RETURNS VARCHAR AS $$
DECLARE
letra_1 VARCHAR;
numero_1 INTEGER;
letra_2 VARCHAR;
numero_2 INTEGER;
letra_3 VARCHAR;
numero_3 INTEGER;
numeros INTEGER;
numeros_2 INTEGER;
string VARCHAR;
BEGIN
numeros := floor(random() * 1000);
numeros_2 := floor(random() * 100);
numero_1 := floor(random() * 10);
IF numero_1 < 4 THEN letra_1 := 'A';
ELSEIF numero_1 > 3 AND numero_1 < 7 THEN letra_1 := 'B';
ELSE letra_1 := 'C'; END IF;
numero_2 := floor(random() * 10);
IF numero_2 < 4 THEN letra_2 := 'C';
ELSEIF numero_2 > 3 AND numero_2 < 7 THEN letra_2 := 'B';
ELSE letra_2 := 'A'; END IF;
numero_3 := floor(random() * 10);
IF numero_3 < 4 THEN letra_3 := 'B';
ELSEIF numero_3 > 3 AND numero_3 < 7 THEN letra_3 := 'C';
ELSE letra_3 := 'A'; END IF;
string := CONCAT(letra_1,numeros,letra_2,numeros_2,letra_3);
RETURN string;
END;
$$ language plpgsql