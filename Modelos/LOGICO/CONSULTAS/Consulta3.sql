DELIMITER $$
CREATE PROCEDURE consulta3 (docente_in BIGINT(13))
BEGIN
    
    IF  validardocente(docente_in) THEN
        SELECT d.siif, CONCAT(d.nombres, ' ', d.apellidos) as 'nombre completo', d.fecha_nacimiento, d.correo, d.telefono, d.direccion, d.dpi
        FROM docente d;

    ELSE
        SELECT 'DOCENTE NO EXISTE' AS MENSAJE;
    END IF;
END$$
-- PARA: DPI DOCENTE
CALL consulta3(3016980070101);