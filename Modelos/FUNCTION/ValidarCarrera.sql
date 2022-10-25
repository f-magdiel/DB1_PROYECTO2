DELIMITER $$
CREATE FUNCTION validarcarrera(id_carrerain int) RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE flag_carrera BOOLEAN;
    DECLARE cont INT;
    SELECT 1 FROM carrera WHERE id_carrerain = id_carrera 
    INTO cont;
	IF cont > 0 THEN
		SELECT TRUE INTO flag_carrera;
	ELSE
		SELECT FALSE INTO flag_carrera;
	END IF;
    RETURN flag_carrera;
END$$

SELECT validarcarrera(1);