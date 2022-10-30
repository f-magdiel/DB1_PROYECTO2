DELIMITER $$
CREATE PROCEDURE consulta1 (id_carrera_in int)
BEGIN
    
    SELECT curso.codigo, curso.nombre, 
    CASE  curso.obligatorio
    WHEN  1 THEN 'SI'
    ELSE 'NO'
    END AS 'obligatorio',
    curso.cr_necesarios
    FROM curso
	WHERE curso.Carrera_id_carrera IN (1,id_carrera_in);
END$$
-- PARAM: ID DE LA CARRERA
CALL consulta1(1);