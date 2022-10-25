DELIMITER $$
CREATE PROCEDURE crearcarrera (carrera_nombre_in varchar(50))
BEGIN
    -- Validar que exista carrera
    DECLARE cont int;
    SELECT COUNT(id_carrera)
    INTO cont
    FROM carrera
    WHERE carrera.nombre = carrera_nombre_in;

    IF cont = 0 THEN
        SELECT 'CARRERA CREADA' AS MENSAJE;
        INSERT INTO carrera (nombre) 
        VALUES (carrera_nombre_in);
    ELSE
        SELECT 'CARRERA YA EXISTE' AS MENSAJE;
    END IF;
	
END$$

CALL crearcarrera('Sistemas');