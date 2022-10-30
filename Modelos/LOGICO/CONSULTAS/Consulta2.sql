DELIMITER $$
CREATE PROCEDURE consulta2 (carnet_in BIGINT(9))
BEGIN
    
    IF validarestudiante(carnet_in) THEN
        SELECT es.carnet, CONCAT(es.nombres,' ', es.apellidos) AS 'nombre completo', fecha_nacimiento, correo, telefono, direccion, dpi, Carrera_id_carrera, creditos FROM estudiante es;
    ELSE
        SELECT 'ESTUDIANTE NO EXISTE' AS MENSAJE;
    END IF;
END$$
-- PARAM: CARNET ESTUDIANTE
CALL consulta2(201801445);