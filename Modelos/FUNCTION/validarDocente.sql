DELIMITER $$
CREATE FUNCTION validardocente(dpi_in bigint(13)) RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE flag_docente BOOLEAN;
    DECLARE cont INT;
    SELECT COUNT(*) FROM docente WHERE dpi = dpi_in 
    INTO cont;
	IF cont > 0 THEN
		SELECT TRUE INTO flag_docente;
	ELSE
		SELECT FALSE INTO flag_docente;
	END IF;
    RETURN flag_docente;
END$$

SELECT validardocente(3275257541406);