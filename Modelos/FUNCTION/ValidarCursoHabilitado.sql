DELIMITER $$
CREATE FUNCTION validarcursohabilitado(id_curso_habilitado_in int) RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE flag_curso BOOLEAN;
    DECLARE cont INT;
    SELECT 1 FROM curso_habilitado WHERE id_curso_habilitado = id_curso_habilitado_in 
    INTO cont;
	IF cont > 0 THEN
		SELECT TRUE INTO flag_curso;
	ELSE
		SELECT FALSE INTO flag_curso;
	END IF;
    RETURN flag_curso;
END$$

SELECT validarcursohabilitado(1);