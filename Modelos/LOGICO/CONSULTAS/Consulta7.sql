DELIMITER $$
CREATE PROCEDURE consulta7 (codigo_in int, ciclos_in VARCHAR(50), year_in int ,seccion_in VARCHAR(1))
BEGIN   
    DECLARE estu_des int;

    IF validarcurso(codigo_in) THEN 
        SELECT COUNT(ac.Estudiante_carnet)
        INTO estu_des
        FROM asignacion_curso ac
        INNER JOIN curso_habilitado ch ON ac.Curso_Habilitado_id_curso_habilitado = ch.id_curso_habilitado
        WHERE
        ac.estado_asignacion = 0
        AND ch.seccion = UPPER(seccion_in)
        AND ch.ciclos = UPPER(ciclos_in)
        AND ch.Curso_codigo = codigo_in
        AND YEAR(ch.periodo) = year_in;
        
        SELECT ch.Curso_codigo, ch.seccion,
        CASE 
        WHEN ch.ciclos = '1S' THEN 'PRIMER SEMESTRE'
        WHEN ch.ciclos = '2S' THEN 'SEGUNDO SEMESTRE'
        WHEN ch.ciclos = 'VJ' THEN 'VACACIONES DE JUNIO'
        ELSE 'VACACIONES DE DICIEMBRE'
        END AS 'ciclo', YEAR(ch.periodo) as 'año', ch.asignados as 'asignados', estu_des as 'desasignados',
        CONCAT(((estu_des/ch.asignados)*100),'%') as 'porcentaje'
        FROM asignacion_curso ac
        INNER JOIN curso_habilitado ch ON ac.Curso_Habilitado_id_curso_habilitado = ch.id_curso_habilitado
        WHERE ch.ciclos = UPPER(ciclos_in)
        AND ch.seccion = UPPER(seccion_in)
        AND ch.Curso_codigo = codigo_in
        AND YEAR(ch.periodo) = year_in
        LIMIT 1;
    ELSE
        SELECT 'EL CURSO NO EXISTE' AS MENSAJE;
    END IF;
END$$
-- PARAM: CODIGO CURSO, CICLO, AÑO, SECCION
CALL consulta7(14, '1S', 2022, 'a');