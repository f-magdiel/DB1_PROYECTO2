DELIMITER $$
CREATE PROCEDURE registroestudiante (carnet_in bigint(9), dpi_in bigint(13),nombres_in varchar(50), apellidos_in varchar(50), fecha_nacimiento_in date, correo_in varchar(50), telefono_in bigint(8), direccion_in varchar(50), id_carrera_in int)
BEGIN
	 DECLARE EXIT HANDLER FOR 3819 
			SELECT CONCAT('OCURRIO UN ERROR AL REGISTRAR ESTUDIANTE') AS MENSAJE;
        
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

 CALL registroestudiante(201801440, 3275257541415,'Magdiel','Asicona','1990-10-24','magdiela@gmail.com',30063012,'Zona 5',2);
 CALL registroestudiante(201801441, 3275257541435,'Danny','Cuxum','1991-05-12','dannyc@gmail.com',45616548,'Zona 14',3);
 CALL registroestudiante(201801442, 3275257541445,'Haroldo','Perez','1995-10-24','haroldop@gmail.com',13248648,'Zona 10',4);
 CALL registroestudiante(201801443, 3275257541489,'Luis','Losano','1998-01-24','luisl@gmail.com',89546512,'Zona 9',5);
 CALL registroestudiante(201801444, 3275257541478,'Ben','Ramos','1996-02-14','benram@gmail.com',96545357,'Zona 7',2);
 CALL registroestudiante(201801445, 3275257541496,'Francisco','Montes','1999-10-15','franciscom@gmail.com',13548657,'Zona 5',3);
 CALL registroestudiante(201801446, 3275257541417,'Eduardo','Sanchez','1995-09-17','eduardos@gmail.com',96654861,'Zona 10',4);
 CALL registroestudiante(201801447, 3275257541420,'Edgar','Santos','1997-10-18','edgars@gmail.com',12358966,'Zona 13',5);
 CALL registroestudiante(201801448, 3275257541430,'William','Cabrera','2000-06-24','willic@gmail.com',89765648,'Zona 12',2);
 CALL registroestudiante(201801449, 3275257541440,'Marcos','Mateo','2001-12-06','marcosm@gmail.com',45651235,'Zona 1',3);
 
-- INSERT INTO estudiante(carnet, dpi, nombres, apellidos, fecha_nacimiento, correo, telefono, direccion, creditos, fecha_creacion, Carrera_id_carrera)
-- VALUES(201801442, 3275257541407,'Magdiel','Asicona','2022-10-24','magdiel@gmail.com',30063089,'zona 1',100, CURDATE(),1 );

