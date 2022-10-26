DELIMITER $$
CREATE PROCEDURE registrodocente(dpi_in BIGINT(13), siif_in BIGINT(10), nombres_in VARCHAR(50), apellidos_in VARCHAR(50), fecha_nacimiento_in DATE, correo_in VARCHAR(50), telefono_in BIGINT(8), direccion_in VARCHAR(50))
BEGIN
    IF validardocente(dpi_in) THEN
        SELECT 'DOCENTE YA EXISTE' AS MENSAJE;
    ELSE
        -- SE REGISTRA DOCENTE
        INSERT INTO docente (dpi, siif, nombres, apellidos, fecha_nacimiento, correo, telefono,direccion,fecha_creacion)
        VALUES (dpi_in, siif_in,nombres_in, apellidos_in, fecha_nacimiento_in, correo_in, telefono_in, direccion_in, CURDATE());
        SELECT 'DOCENTE REGISTRADO' AS MENSAJE;
	END IF;
END$$

CALL  registrodocente (3016980070101, 1234567890, 'Javs','Java','2022-11-11','javskrow.jc.tloz@gmail.com',42808267,'Z18');