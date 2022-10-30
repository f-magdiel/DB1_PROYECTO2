DELIMITER $$
CREATE PROCEDURE consulta6 (codigo_in int)
BEGIN
    IF validarcurso(codigo_in)  THEN
        SELECT ch.Curso_codigo, ch.seccion, 
        CASE 
        WHEN ch.ciclos = '1S' THEN 'PRIMER SEMESTRE'
        WHEN ch.ciclos = '2S' THEN 'SEGUNDO SEMESTRE'
        WHEN ch.ciclos = 'VJ' THEN 'VACACIONES DE JUNIO'
        ELSE 'VACACIONES DE DICIEMBRE'
        END AS 'ciclo', YEAR(ch.periodo) as 'año', ch.asignados, acta.fecha_acta
        FROM curso_habilitado ch
        INNER JOIN acta 
        ON ch.id_curso_habilitado = acta.Curso_Habilitado_id_curso_habilitado
        WHERE ch.Curso_codigo = codigo_in;
    ELSE
        SELECT 'CURSO NO EXISTE' AS MENSAJE;
    END IF;
 
END$$
-- PARAM: CODIGO CURSO
CALL consulta6(14);