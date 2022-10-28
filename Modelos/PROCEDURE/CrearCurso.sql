DELIMITER $$
CREATE PROCEDURE crearcurso (codigo_in int, nombre_in VARCHAR(50), cr_necesarios_in int, cr_otorgados_in int, obligatorio_in TINYINT(1), id_carrera_in int)
BEGIN
	 DECLARE EXIT HANDLER FOR 3819 
		SELECT CONCAT('OCURRIO UN ERROR AL CREAR CURSO') AS MENSAJE;
        
	IF validarcurso(codigo_in)  THEN
		SELECT 'CURSO YA EXISTE' AS MENSAJE;
    ELSE
        IF validarcarrera(id_carrera_in) THEN
			SELECT 'CURSO REGISTRADO' AS MENSAJE;
            INSERT INTO curso (codigo, nombre, cr_necesarios, cr_otorgados, obligatorio, Carrera_id_carrera)
            VALUES (codigo_in, nombre_in, cr_necesarios_in, cr_otorgados_in, obligatorio_in, id_carrera_in);
		ELSE
			SELECT 'CARRERA NO EXISTE' AS MENSAJE;
			
		END IF;
	END IF;
END$$

CALL crearcurso(16,'teo2',1,2,1,1);

