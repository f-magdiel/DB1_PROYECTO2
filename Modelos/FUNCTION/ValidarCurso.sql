DELIMITER $$
CREATE FUNCTION validarcurso(codigo_in int) RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE flag_curso BOOLEAN;
    DECLARE cont INT;
    SELECT 1 FROM curso WHERE codigo_in = codigo 
    INTO cont;
	IF cont > 0 THEN
		SELECT TRUE INTO flag_curso;
	ELSE
		SELECT FALSE INTO flag_curso;
	END IF;
    RETURN flag_curso;
END$$

SELECT validarcurso(14);