DELIMITER $$
CREATE PROCEDURE registrodocente(dpi_in BIGINT(13), siif_in BIGINT(10), nombres_in VARCHAR(50), apellidos_in VARCHAR(50), fecha_nacimiento_in DATE, correo_in VARCHAR(50), telefono_in BIGINT(8), direccion_in VARCHAR(50))
BEGIN
	 DECLARE EXIT HANDLER FOR 3819 
			SELECT CONCAT('OCURRIO UN ERROR AL REGISTRAR ESTUDIANTE') AS MENSAJE;
            
    IF validardocente(dpi_in) THEN
        SELECT 'DOCENTE YA EXISTE' AS MENSAJE;
    ELSE
        -- SE REGISTRA DOCENTE
        INSERT INTO docente (dpi, siif, nombres, apellidos, fecha_nacimiento, correo, telefono,direccion,fecha_creacion)
        VALUES (dpi_in, siif_in,nombres_in, apellidos_in, fecha_nacimiento_in, correo_in, telefono_in, direccion_in, CURDATE());
        SELECT 'DOCENTE REGISTRADO' AS MENSAJE;
	END IF;
END$$

CALL  registrodocente (3016980070101, 1234567890, 'Pedro','Lopez','1990-11-11','pedrol@gmail.com',12451547,'Zona 18');
CALL  registrodocente (3016980070102, 4565413774, 'Daniel','Perez','1991-01-15','danp@gmail.com',58614589,'Zona 13');
CALL  registrodocente (3016980070103, 1565489646, 'Julio','Morales','1983-12-23','julioml@gmail.com',12674651,'Zona 14');
CALL  registrodocente (3016980070104, 6548165498, 'Julia','Lopez','1986-06-12','juliaal@gmail.com',89564357,'Zona 10');
CALL  registrodocente (3016980070105, 1234546684, 'Mario','Chavez','1989-05-10','marioch@gmail.com',25648948,'Zona 12');
