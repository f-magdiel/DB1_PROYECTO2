DELIMITER $$
CREATE PROCEDURE agregarhorario (dia_in int, horario_in VARCHAR(50), id_curso_habilitado_in int)
BEGIN
    DECLARE EXIT HANDLER FOR 3819 
		SELECT CONCAT('OCURRIO UN ERROR AL INSERTAR EN LA TABLA HORARIO CURSO') AS MENSAJE;

	IF validarcursohabilitado(id_curso_habilitado_in)  THEN
        SELECT 'HORARIO AGREGADO' AS MENSAJE;
		INSERT INTO horario_curso (dia, horario, Curso_Habilitado_id_curso_habilitado)
		VALUES (dia_in, horario_in, id_curso_habilitado_in);
    ELSE
        SELECT 'ID DEL CURSO NO EXISTE EN CURSO HABILITADO' AS MENSAJE;
	END IF;
END$$

CALL agregarhorario(2,'9:00-10:00',1);