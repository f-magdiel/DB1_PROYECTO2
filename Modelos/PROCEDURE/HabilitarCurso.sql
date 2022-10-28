DELIMITER $$
CREATE PROCEDURE habilitarcurso (id_curso_in int, ciclos_in VARCHAR(50), cupo_in int, seccion_in VARCHAR(1), Docente_dpi_in BIGINT(13), Curso_codigo_in int)
BEGIN
	
    DECLARE EXIT HANDLER FOR 3819 
		SELECT CONCAT('OCURRIO UN ERROR AL INSERTAR EN LA TABLA HABILITAR CURSO') AS MENSAJE;
    
	IF validarcurso(Curso_codigo_in)  THEN
		IF validardocente(Docente_dpi_in) THEN
            INSERT INTO curso_habilitado (id_curso_habilitado, ciclos, cupo, seccion, periodo, Docente_dpi, Curso_codigo)
            VALUES(id_curso_in, ciclos_in, cupo_in, UPPER(seccion_in),CURDATE(), Docente_dpi_in, Curso_codigo_in);
			SELECT 'CURSO HABILITADO EXITOSAMENTE' AS MENSAJE;
        ELSE
            SELECT 'DOCENTE NO EXISTE' AS MENSAJE;
        END IF;
    ELSE
        SELECT 'CURSO NO EXISTE' AS MENSAJE;
	END IF;
END$$

CALL  habilitarcurso(2, '1S', 15, 'a',3016980070101,16);
