DELIMITER $$
CREATE FUNCTION validarestudiante(carnetin bigint(9)) RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE flag_estudiante BOOLEAN;
    DECLARE cont INT;
    SELECT COUNT(*) FROM estudiante WHERE carnetin = carnet 
    INTO cont;
	IF cont > 0 THEN
		SELECT TRUE INTO flag_estudiante;
	ELSE
		SELECT FALSE INTO flag_estudiante;
	END IF;
    RETURN flag_estudiante;
END$$

SELECT validarestudiante(201801449);
