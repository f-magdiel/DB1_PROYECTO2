DELIMITER $$
CREATE PROCEDURE registroestudiante (carnet_in bigint(9), dpi_in bigint(13),nombres_in varchar(50), apellidos_in varchar(50), fecha_nacimiento_in date, correo_in varchar(50), telefono_in bigint(8), direccion_in varchar(50), id_carrera_in int)
BEGIN
	IF validarestudiante(carnet_in) THEN
		SELECT 'ESTUDIANTE YA EXISTE' AS MENSAJE;
    ELSE
        IF validarcarrera(id_carrera_in) THEN
			SELECT 'ESTUDIANTE REGISTRADO' AS MENSAJE;
            INSERT INTO estudiante  (carnet, dpi, nombres, apellidos, fecha_nacimiento, correo, telefono, direccion, fecha_creacion, Carrera_id_carrera )
            VALUES (carnet_in, dpi_in, nombres_in, apellidos_in, fecha_nacimiento_in, correo_in, telefono_in, direccion_in, CURDATE() ,id_carrera_in);
		ELSE
			SELECT 'CARRERA NO EXISTE' AS MENSAJE;
			
		END IF;
	END IF;
END$$

 CALL registroestudiante(201801440, 3275257541407,'Magdiel','Asicona','2022-10-24','magdiel@gmail.com',30063089,'zona 1',1);
 
INSERT INTO estudiante(carnet, dpi, nombres, apellidos, fecha_nacimiento, correo, telefono, direccion, creditos, fecha_creacion, Carrera_id_carrera)
VALUES(201801442, 3275257541407,'Magdiel','Asicona','2022-10-24','magdiel@gmail.com',30063089,'zona 1',100, CURDATE(),1 );

