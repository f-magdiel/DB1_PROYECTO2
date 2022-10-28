DELIMITER $$
CREATE PROCEDURE crearcarrera (carrera_nombre_in varchar(50))
BEGIN
    -- Validar que exista carrera
    DECLARE cont int;
    DECLARE EXIT HANDLER FOR 3819 
		SELECT CONCAT('OCURRIO UN ERROR AL CREAR CARRERA') AS MENSAJE;
        
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

CALL crearcarrera('Ciencias Sistemas');
CALL crearcarrera('Area Comun');
CALL crearcarrera('Ingenieria en Ciencias y Sistemas');
CALL crearcarrera('Ingenieria Civil');
CALL crearcarrera('Ingenieria Quimica');
CALL crearcarrera('Ingenieria Mecanica');
CALL crearcarrera('Ingenieria Electrica');
CALL crearcarrera('Ingenieria Industrial');
CALL crearcarrera('Ingenieria Mecanica Electrica');
CALL crearcarrera('Ingenieria Mecanica Industrial');
CALL crearcarrera('Ingenieria Electronica');
CALL crearcarrera('Ingenieria Ambiental');
USE fiusac;